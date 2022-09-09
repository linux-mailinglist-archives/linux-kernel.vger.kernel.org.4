Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB9C5B3557
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIIKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIIKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:37:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C259BB5A5B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F19AB82488
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF642C433C1;
        Fri,  9 Sep 2022 10:37:33 +0000 (UTC)
Date:   Fri, 9 Sep 2022 11:37:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: translate register values to physical addresses
 in kernel panics
Message-ID: <YxsXamXpLLTZ1M63@arm.com>
References: <20220812183530.2261795-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812183530.2261795-1-pcc@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:35:30AM -0700, Peter Collingbourne wrote:
> When debugging a kernel panic it is sometimes useful to know the physical
> address of any virtual addresses stored in registers. Therefore, pass
> all register values through AT S1E1R and print the resulting PAR_EL1
> value next to the register.

I don't see much value in this but I haven't come across a use-case yet.
For page faults the kernel prints the content of the PTE and that's what
I'm usually interested in.

> Not sure if this should land in this form (I imagine there could be
> all kinds of parsers that are expecting the existing format) but
> maybe behind an option. Let me know what you think.

While that's not considered user ABI, there might be some scripts
parsing it, though I suspect they don't pay attention to the registers
(I might be wrong though).

> +static unsigned long at(unsigned long addr)
> +{
> +	unsigned long pa;
> +
> +	__asm__ __volatile__("at s1e1r, %1\n"
> +			     "mrs %0, par_el1\n"
> +			     : "=r"(pa)
> +			     : "r"(addr)
> +			     : "memory");
> +	return pa;
> +}

This should take the translation fault into account. If PAR_EL1.F is 1,
the other bits can't be treated as a physical address. Also if you want
the actual address, it's also worth masking out the non-relevant bits
from PAR_EL1 and adding the offset from 'addr' into the lower 12 bits.

>  void __show_regs(struct pt_regs *regs)
>  {
>  	int i, top_reg;
> @@ -231,10 +243,10 @@ void __show_regs(struct pt_regs *regs)
>  	i = top_reg;
>  
>  	while (i >= 0) {
> -		printk("x%-2d: %016llx", i, regs->regs[i]);
> +		printk("x%-2d: %016llx (%016llx)", i, regs->regs[i], at(regs->regs[i]));
>  
>  		while (i-- % 3)
> -			pr_cont(" x%-2d: %016llx", i, regs->regs[i]);
> +			pr_cont(" x%-2d: %016llx (%016llx)", i, regs->regs[i], at(regs->regs[i]));

How long are the lines printed here? Maybe a better option without
cluttering the register values is to do another pass through the
register and print the potential VA->PA translations (only those kernel
addresses that do not fault). If one is interested they could look them
up on the following lines.

-- 
Catalin
