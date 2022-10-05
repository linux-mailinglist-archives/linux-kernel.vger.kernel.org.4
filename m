Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493A5F5978
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJESAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJER75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:59:57 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64ADCD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:59:55 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so11343457ooo.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rCPnvUAK2fGseNDtkks3wo2hHpqY+s4RG4CRsqPxrT0=;
        b=g95TZ2i2pYkd5Qu/p+hc9fHuRrFcWvn3DVCOi9Yn1cJmsUq4Vu0438bUna0DmCTFyo
         Vys+K6Io7NH9g2IS5BMypikjZKSoyE3q45hI8gzj5c3HQgSBAK16WjeQsF0EyK56Rdia
         GIB4GgLPp1JXgHm5qnNGMqjY+E2kmFApvK2D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCPnvUAK2fGseNDtkks3wo2hHpqY+s4RG4CRsqPxrT0=;
        b=DC13V6nzOchnj5TLgfSQRDoO+MZHb/Kn45kuQe3sQGW24R3WlHC4kcyFROt4TKHO2w
         0A/1xxXQkoZDWY+7bDWEo9vDIwWX3xsEaBV9BLJ1VPivfDBQ65qiijrAeZ6BIaHpx7W2
         PDZzOsbSMV+NzArt7EVUdVoXSSJJ+vN+m52mHoSSNRyS/qTQltDtyULmI7fV6kvKTCXo
         9+sZUN/+cgGlPwkC+i0546b7hgxlLWZsiqYxZeXvPb8sH8DiGSjHi8FNh7+CYwDGyD32
         HBLC+4ZxyuRgSQFFwqTbt4mVCqxE/Hkjqy+T4jLl+P4iHORuQ1NhVX92Qod8mYQZxVQN
         NKZw==
X-Gm-Message-State: ACrzQf0TQsVIGXoGZAmr7Zcki4gxJSKaE1MX/SFBADswA8LvyZuNht7/
        aWY0JR+MFabujdMKsVJiCa6m0MkWXaRC7A==
X-Google-Smtp-Source: AMsMyM7mONt+KYwPDJNCR42XwmiG+8tlDPgkfWEIEDBIM1+KLFqkfESJt1SY+/+PyZPe1oIuYF5rZA==
X-Received: by 2002:a05:6830:2690:b0:659:ee3d:5756 with SMTP id l16-20020a056830269000b00659ee3d5756mr301509otu.117.1664992794144;
        Wed, 05 Oct 2022 10:59:54 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0506000000b003509cc4ad4esm4633872oif.39.2022.10.05.10.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 10:59:52 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q10so18453113oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:59:52 -0700 (PDT)
X-Received: by 2002:a05:6808:2012:b0:34f:ca73:ee55 with SMTP id
 q18-20020a056808201200b0034fca73ee55mr506789oiw.229.1664992792443; Wed, 05
 Oct 2022 10:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <Yz18QA27+gN0oaM3@google.com>
In-Reply-To: <Yz18QA27+gN0oaM3@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 10:59:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
Message-ID: <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Oct 5, 2022 at 5:44 AM Lee Jones <lee@kernel.org> wrote:
>
>    - Add support for MediaTek MT6370 Backlight

Hmm. This new driver has a

        depends on MFD_MT6370

but there is no such symbol anywhere.

It turns out the same is true of the MT6370 regulator driver that was
added during the previous merge window.

I do see that MFD_MT6370 in linux-next, but I don't see any pull
request for this, and now that I started looking I do see that we had
this already in 6.0.

I do *not* believe that it's ok to randomly take "drivers" that depend
on functionality that hasn't even been merged yet, and that are
basically just dead code but hidden away this non-obvious way.

I've pulled this, but I want to just state that this is bad, bad, bad.
If it has dependencies that aren't met, it damn well shouldn't be sent
upstream in a form where upstream can't even build test the thing.

                   Linus
