Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653C5F242F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJBRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJBRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:00:33 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E32C13DEF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 10:00:32 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13207a86076so6468772fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QgT+0pE5+Jxg1Db0pjr/6GUR7lMe+WJC6D7WdnY3dDY=;
        b=Nzqj81O4P6j0wFJ6dCNqILguy0U5N+2OxhQjCFfKYDAC6M6UpY7hAq5wpd1cfw2nTd
         hSmo4qXcfU8ubm0sRDL10bN31XVYLOYrsXrrc2Oa+eXTJc9tQv8ii7M5hGagWac1Lm3y
         j4zJLaHZhsFQufPX3m6IxXYXKG+dcxt9QVs7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QgT+0pE5+Jxg1Db0pjr/6GUR7lMe+WJC6D7WdnY3dDY=;
        b=KVHFJo152FYjkAqiNVwZtJPS3ziMljd27cBLsBaUawLQ6q8RQSwcPOvcz+2V0mHPMT
         WxrXyJXwbGOE4QvH/n7NYTBtvBbzrDGxeRno62Zz9XjetP4MRah350vdcobq9thKAzhQ
         8wCULv7z5P0zx4/L/itLgMuGdkSkqQma/laeMCgs65lpLbsRxc9iqRpjGM7uvtuXz5pJ
         u6HFUWl+b7IGR3VwaoyAeoPEILmobbkZamP1ZeNLZGhDtaJrFBBeEXY7rdIApGyrqbKE
         /ahpqGdd2Szs1sqKUfYFG2kWNXSDPq8pILACHc33qf4kdPFJeu5xxYRFO6eInMGuRWm+
         krbw==
X-Gm-Message-State: ACrzQf0Q76eo79gxMUaH2tGtJBIHI/o5eWkbJc9iylp6QJfs1grVfc+0
        aS8wr/HrrPr3Z49GD73luvAVsEI8nijHkQ==
X-Google-Smtp-Source: AMsMyM5SoO+QpwbIICVyUbeOSL9nMaKggq42MI1roaChBLn35SaT5/mC7Bh29SqErzOztC8HXt8/wg==
X-Received: by 2002:a05:6870:891a:b0:130:ea0f:c071 with SMTP id i26-20020a056870891a00b00130ea0fc071mr3661178oao.251.1664730030732;
        Sun, 02 Oct 2022 10:00:30 -0700 (PDT)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id x16-20020a9d4590000000b00655ca9a109bsm1883051ote.36.2022.10.02.10.00.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 10:00:29 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so5434897ool.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 10:00:28 -0700 (PDT)
X-Received: by 2002:a05:6830:11c6:b0:65f:913:ff93 with SMTP id
 v6-20020a05683011c600b0065f0913ff93mr2396114otq.69.1664730028572; Sun, 02 Oct
 2022 10:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au> <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com> <Yzi/X12rQTuT9Uqk@arm.com>
In-Reply-To: <Yzi/X12rQTuT9Uqk@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Oct 2022 10:00:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
Message-ID: <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
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

On Sat, Oct 1, 2022 at 3:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The "force bouncing" in my series currently only checks for small
> (potentially kmalloc'ed) sizes under the assumption that intra-object
> DMA buffers were properly aligned to 128. So for something like below:

Ahh, so your forced bouncing isn't actually safe.

I would have hoped (but obviously never checked) that the force
bouncing be made really safe and look at the actual alignment of the
DMA (comparing it to the hardware coherency requirements), so that
alignment at allocation time simply wouldn't matter.

At that point, places like the ones you found would still work, they'd
just cause bouncing.

At which point you'd then have a choice of

 (a) just let it bounce

 (b) marking the allocations that led to them

and (a) might actually be perfectly fine in a lot of situations.
That's particularly true for the "random drivers" situation that may
not be all that relevant in real life, which is a *big* deal. Not
because of any performance issues, but simply because of kernel
developers not having to worry their pretty little heads about stuff
that doesn't really matter.

In fact, (a) might be perfectly ok even for drivers that *do* matter,
if they just aren't all that performance-critical and the situation
doesn't come up a lot (maybe it's a special management ioctl or
similar that just causes the possibility to come up, and it's
important that it *works*, but having a few bounces occasionally
doesn't actually matter, and all the regular IO goes the normal path).

And (b) would be triggered by actual data. Which could be fairly easy
to gather with a statistical model. For example, just making
dma_map_xyz() have a debug mode where it prints out the stack trace of
these bounces once every minute or so - statistically the call trace
will be one of the hot ones. Or, better yet, just use tracing to do
it.

That would allow us to say "DMA is immaterial for _correct_ alignment,
because we always fix it up if required", but then also find
situations where we might want to give it a gentle helper nudge.

But hey, if you're comfortable with your approach, that's fine too.
Anything that gets rid of the absolutely insane "you can't do small
allocations" is an improvement.

                   Linus
