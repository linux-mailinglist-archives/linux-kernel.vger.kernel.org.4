Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F463D87D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiK3OsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3OsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:48:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6691A51C23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:48:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669819699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ysb9nF7W7aBl+zloPQlgaS76S2jwLQXf+/wIbHzkL2s=;
        b=XpIyPYchmWSgiG870br6Rr+E4xnpbB/61RTG50j7xs4sSOWyx8VUdXson8QV6vh2ZpWMuQ
        BZEMYc/p9N0Q0tSsTonvSPnaHIf2aWBB5+cAcEcuCI6+HVRiinLqDa3IrrDdndyOD+G3Hr
        Z6sM5rpFOEr9L1YcG11yjaSFORrZLqEwGLoHlqyRhr+IUveLr0N5sYvM5Y719pf4b3Ok7h
        /C0dDnmTcKDeYwgPwb1KR73iQ95pH4Cdv6XfjSaoTmG1OjrZHqbGh1+cDTjDVfb3R/3BDk
        A35C9XsX7NZiWCXdNnA1vviL+H365iJtI8VmtbpuPW5Tn7FCd41iyz6Mj6S2zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669819699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ysb9nF7W7aBl+zloPQlgaS76S2jwLQXf+/wIbHzkL2s=;
        b=VR3a3G9cPiYAbCKymrWGiegBry122LXuvcA9Z2nHl9QZdvcIn8YIEze+UtGvD+ADar1uDX
        BDCgBiqqjw00cmCA==
To:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] genirq: Simplify cond_unmask_eoi_irq()
In-Reply-To: <20221126234134.32660-2-samuel@sholland.org>
References: <20221126234134.32660-1-samuel@sholland.org>
 <20221126234134.32660-2-samuel@sholland.org>
Date:   Wed, 30 Nov 2022 15:48:18 +0100
Message-ID: <87edtkts5p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel!

On Sat, Nov 26 2022 at 17:41, Samuel Holland wrote:

> This function calls .irq_eoi in three places, making the logic hard to
> follow. Rearrange the function so that .irq_eoi is called only once.
>
> The only time .irq_eoi is not called is when all three if checks fail,
> so return early in that case. threads_oneshot can only be nonzero if
> IRQS_ONESHOT is set, so the IRQS_ONESHOT check can be omitted there.
>
> The IRQS_ONESHOT condition from the first if statement must then be
> copied to the unmask_irq() condition.
>
> Furthermore, if IRQS_ONESHOT is set, mask_irq() must have been called
> in the parent function, so the irqd_irq_masked() check is redundant.

Not really convinced that all this is functionaly equivalent.

>  static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
>  {
> -	if (!(desc->istate & IRQS_ONESHOT)) {
> -		chip->irq_eoi(&desc->irq_data);
> +	/*
> +	 * Do not send an EOI if the thread will do it later in
> +	 * unmask_threaded_irq().
> +	 */
> +	if ((chip->flags & IRQCHIP_EOI_THREADED) && desc->threads_oneshot)
>  		return;
> -	}
> +
> +	chip->irq_eoi(&desc->irq_data);

This now issues EOI when the interrupt is in disabled state, which was
not done before. That's probably a non-issue, but clearly a undocumented
change.

> +
>  	/*
>  	 * We need to unmask in the following cases:
>  	 * - Oneshot irq which did not wake the thread (caused by a
> @@ -669,12 +674,8 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
>  	 *   completely).
>  	 */
>  	if (!irqd_irq_disabled(&desc->irq_data) &&
> -	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
> -		chip->irq_eoi(&desc->irq_data);
> +	    (desc->istate & IRQS_ONESHOT) && !desc->threads_oneshot)
>  		unmask_irq(desc);

This breaks the mask logic of handle_fasteoi_mask_irq() for an interrupt
which does not have IRQS_ONESHOT set.

So no, it's not the same and it even breaks stuff.

Thanks,

        tglx
