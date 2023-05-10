Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81156FE467
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjEJTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjEJTMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:12:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792692705
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:12:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683745923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MECbkgCGOoBuvWtbOq2MxOu4fITVWEjEY+BBqAF9ns=;
        b=ffQ9fl3MaMTDG2AfJn3s0Hg+wrzUBDxCiJhn7ptHhlD3kBqhQNZ+u8taPzbQz/MBMGvWc9
        mYIczIfyPbP1YPZoHjbqNLPHGm7v88AWqvHoAmon3XZhtiLE9knDAj+y14BOeza7RPOmN/
        7elzRdT/aZLaluD1zGDW2M1/CiRs7H5Hm/cabxFX+esVHLVI+WnsRRmeEYGmu1pvUXShJh
        ExDfLZjWaGY68GPIC6zaUUX1f699sEYhdBKX7KS/kKhTuIjWiHpH93jgCzDBpI4ll7x9PB
        UmofVWYNcwDeY6GiZmxJN2JODggkR7hQ4aQNTFbNGZv3Knlr3QfHdkE7UKbb8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683745923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MECbkgCGOoBuvWtbOq2MxOu4fITVWEjEY+BBqAF9ns=;
        b=X4nOfMSYbZJkbpGd2m7OBEYGn2P8QP4+/B1iFgR2q7AgEF+4m0+jXgpEnhqFVTGaKYgqzZ
        cfTAyfqD2ZApXaCQ==
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <e1c50a59-f85a-02bc-6b48-fceaa390b2ad@nvidia.com>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx> <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299> <87mt2f2mhm.ffs@tglx>
 <ZFtGvfDFLyHeFVFH@yujie-X299> <87ttwkxn96.ffs@tglx> <87r0roxmvu.ffs@tglx>
 <e1c50a59-f85a-02bc-6b48-fceaa390b2ad@nvidia.com>
Date:   Wed, 10 May 2023 21:12:02 +0200
Message-ID: <87lehwxapp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanker!

On Wed, May 10 2023 at 10:19, Shanker Donthineni wrote:
> Apologies for my lack of familiarity with the maple tree data structure and
> not testing all functions. I received advice from the review comments below
> regarding the iterator.
>
> https://lore.kernel.org/linux-arm-kernel/875ydej9ur.ffs@tglx/
>
> static unsigned int irq_find_next_irq(unsigned int offset)
> {
>          MA_STATE(mas, &sparse_irqs, offset, nr_irqs);
>          struct irq_desc *desc = mas_next(&mas, nr_irqs);
>
>          return desc ? irq_desc_get_irq(desc) : nr_irqs;
> }

You gracefully omitted what I wrote below this:

    "or something like that."

which means that it's a suggestion and not claiming that it is in any
way correct.

It does not mean that you should copy it verbatim and assume that it is
correct. It means that if you pick that suggestion up it's your
responsibility to thoroughly understand and test the code you submit,
no?

That has nothing to do with familiarity vs. the maple tree. I'm neither
familiar with the maple tree and all I did was reading through the
documentation, which is pretty well done, except for that tiny
documentation error vs. the return value of mt_next().

It's a simple question of engineering principles:

     "correctness first" vs. "works for me".

> I am looking for your guidance to address the issue with the iterator

You must be kidding.

  1) You got 90% of the solution on a silber tablet

  2) You failed to understand and test the stuff you submitted

  3) You ignored the bug report. Someone else debugged the fallout and
     explained where and what the problem is.

  4) Now you ask that someone else goes and reads the maple tree
     documentation for you to find the proper function to use.  So that
     you can go and blindly apply the change and then go back to #2.

I'm really happy to help and guide people, but what you are asking for
is that I do your homework completely. Seriously?

> if not possible can we increase NR_IRQS for ARM64 arch.

Definitely not. The maple tree conversion is the right thing to do and
fixing the issue at hand is definitely not rocket science.

I'm pretty sure that it is about 3 lines of change to make it work. Plus
some polishing afterwards to make it palatable.

Thanks,

        tglx


