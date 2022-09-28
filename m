Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5E5EE3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiI1SGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiI1SGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:06:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399E10197A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:06:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 9so13170220pfz.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lg8DJ4PVGf/UE/b9agj2E3jF0biYJ2TzSjDWoqo1nWk=;
        b=kX6MiQJJ++GzWgnGDgSHhlrCPXkUnTfSWuw5a1vTXKi13Y13VyCmf0QKz9GO79Hl9h
         lytSSUqbfN/S/Ah/mnF4XU0V59XNaRA/1kXJDF/OU4N76i45SgkcHk4RiaBdM3X11q3P
         ngv3+AbyQkBAOyZ4Efs1UnxU8fMOnw5TwIofU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lg8DJ4PVGf/UE/b9agj2E3jF0biYJ2TzSjDWoqo1nWk=;
        b=uH7IuoMYBR+tbcSCOxYMx10rkrN61DyU2IM6Of7BE66Oa2g0kG/ZDB+fpIVJlHGOaR
         YzyTPjS6FZ9+kqeXiUCTmkrUIrfQ41QYxglRzaNNtG34gYc6TXZpSXoyGF+8A3ngniZE
         +NROx+ytJgr48gBYLM6MnIBFvGQJBoi24hs/rEnZh9Wx0MAQhGwjDvhR5z1iwVc6ICb+
         x5Oq2MyobyqmClmKky6Bti2u7YPn9NYlhs9LYusKpSd6OMZzMirAmMtwyHbcA9BoSu8o
         MEyKTi99AkC95RIpO6e4P7XkXkfgFHhXUcrexIXA2EtpKYSfSiQu0QtNYpF664QcH3t7
         e+Vw==
X-Gm-Message-State: ACrzQf29nF9CQXRJyJh4oy6+jscbmgY4smiEJrkvkFfVJBnYP84reEfm
        J5apTHhkP/oIPxtbY98fQXjI7A==
X-Google-Smtp-Source: AMsMyM5YqTL3LfyC56o9MrGg1TzPcXSkd4eESKCY3Dzo1hitrUn0UwkQLKFW1M9B3lIoMGRQbkcRdw==
X-Received: by 2002:a65:4609:0:b0:434:8f0b:5d05 with SMTP id v9-20020a654609000000b004348f0b5d05mr29993911pgq.606.1664388369685;
        Wed, 28 Sep 2022 11:06:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt10-20020a17090b230a00b00203059fc75bsm1706643pjb.5.2022.09.28.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:06:09 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v13 5/9] drm/i915: Check for integer truncation on
 scatterlist creation
Message-ID: <202209281102.A86D736@keescook>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
 <20220928081300.101516-6-gwan-gyeong.mun@intel.com>
 <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wivJwvVbMUKma8600F6qaVLZHT=BY90SEnjiHWw2ZUVEg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:09:04AM -0700, Linus Torvalds wrote:
> Kees, you need to reign in the craziness in overflow.h.

Understood. I've been trying to help the drm folks walk a line between
having a bunch of custom macros hidden away in the drm includes and
building up generalized versions that are actually helpful beyond drm.
But I can see that it doesn't help to have a "do two things at the same
time" macro for the assignment checking.

-- 
Kees Cook
