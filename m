Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79845EE29A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiI1RJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1RJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:09:22 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374BAD9BC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:09:22 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13189cd5789so6318059fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7vQ2L03NmZjTjKW7aYlNCJZqth3/yEDQLyW9BQRTAy8=;
        b=A+bgUQTLuISMRGKf3gH1kVvGmP3b/AaIOap7gHgA/PD0nbgpIKholTwlPXLri1af0K
         cnXmQYCXr6Teuy/PYE/inGfAxECxd/mCvZF/wqKa528cfQv970CHoLHSzLvnxIGoeg2I
         Wt438dq+Wr6ck6v+tRyZuqUTQ439HqIxvfrIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7vQ2L03NmZjTjKW7aYlNCJZqth3/yEDQLyW9BQRTAy8=;
        b=szSfPTbGYunguz2+i3UMihedyPzfl2QQm7YT8bJWzvlM/XqCrs/tZluMMC8YdGFEHG
         9VXiLXEJXnaTGL12FXT7lGzb3N/qFtb5btqy0aw6R/FLc86PIGmPEj0dPgUWkDeFusBe
         QCKq/VJH3MTEmzSvuUqbDam2/agL3xE1URc0oa1cZWU7h2JTAZVLNzcQmRC8K3pR3uAk
         ooWbRf5azpruzQfhOCsdJw56eal7t/K0Dr7YJK4iPw5BA3d6JXhSo2d8MX4NKAbLJQhU
         lvg/eYgcWtspIqGd7wwOLScfmC/b+xNnKx9+9fOnAvIgsyMpWPlXbYC+4u09tgtl4KZp
         IBtQ==
X-Gm-Message-State: ACrzQf1lpPIzibRyeb+P5VHVsLktpNyM2fl/oYe2rGKZI4h36fC92aFE
        GakAqs8s0ywrOv8EQ9M3STQI/3/f2dxoZw==
X-Google-Smtp-Source: AMsMyM6mgal0LybokQKeDPBzi+BwFO116xE2gDkhcQ/wZRA4qIVLhAU/nfWx54o9TcpqQv4whL0nvg==
X-Received: by 2002:a05:6870:1d0:b0:131:86bc:3f8 with SMTP id n16-20020a05687001d000b0013186bc03f8mr5210517oad.98.1664384961221;
        Wed, 28 Sep 2022 10:09:21 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id c22-20020a056808105600b0033b31480f38sm1944651oih.34.2022.09.28.10.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:09:21 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id w22-20020a056830061600b006546deda3f9so8590793oti.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:09:20 -0700 (PDT)
X-Received: by 2002:a9d:2de3:0:b0:638:e210:c9da with SMTP id
 g90-20020a9d2de3000000b00638e210c9damr14921820otb.69.1664384960424; Wed, 28
 Sep 2022 10:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com> <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
In-Reply-To: <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 10:09:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Message-ID: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        keescook@chromium.org, mauro.chehab@linux.intel.com,
        linux@rasmusvillemoes.dk, vitor@massaru.org, dlatypov@google.com,
        ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 1:15 AM Gwan-gyeong Mun
<gwan-gyeong.mun@intel.com> wrote:
>
> +       if (check_assign(obj->base.size >> PAGE_SHIFT, &npages))
> +               return -E2BIG;

I have to say, I find that new "check_assign()" macro use to be disgusting.

It's one thing to check for overflows.

It's another thing entirely to just assign something to a local variable.

This disgusting "let's check and assign" needs to die. It makes the
code a completely unreadable mess. The "user" wersion is even worse.

If you worry about overflow, then use a mix of

 (a) use a sufficiently large type to begin with

 (b) check for value range separately

and in this particular case, I also suspect that the whole range check
should have been somewhere else entirely - at the original creation of
that "obj" structure, not at one random end-point where it is used.

In other words, THIS WHOLE PATCH is just end-points checking the size
requirements of that "base.size" thing much too late, when it should
have been checked originally for some "maximum acceptable base size"
instead.

And that "maximum acceptable base size" should *not* be about "this is
the size of the variables we use". It should be a sanity check of
"this value is sane and fits in sane use cases".

Because "let's plug security checks" is most definitely not about
picking random assignments and saying "let's check this one". It's
about trying to catch things earlier than that.

Kees, you need to reign in the craziness in overflow.h.

                 Linus
