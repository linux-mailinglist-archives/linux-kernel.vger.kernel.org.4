Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A69629757
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKOL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKOL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:27:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C723BF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:27:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95862B8165D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF61C433D7;
        Tue, 15 Nov 2022 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668511628;
        bh=K8GH84ufCawCbSPwuVXmJl8pj/woWabJOKnWxinVgow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWvNR++QQwgLMRZ04m1WEHvsU5z3xS/M+Q1Wjug70qp3KGGit2FwhMRkj0Xy6Q3ni
         wVlRag7iXtDDiVsX7XJ5PeQUnsHpA4SHHq+wkpZWc/HLWoK7YBcVm7axiWfYoGNcbM
         vGrQlMSJIDU9ng1akJ1KDntvbW6lZL0fYqujnr+I6xhPH0KWkX/jC7wIvqcCiR8ytD
         dofDNnK/Hqh0BosoIq8NPMXbDoFE6FI3gDQIln8bbG3sjQPjISCglC91L5g9jpxDwt
         QUBvOLPrTpbkAEioZyMcorNG89zBmjK6MVuHz5CgpWJPMZI11K9Sxa6cPqlSJXAOgl
         K8XV2yhZv5zcQ==
Date:   Tue, 15 Nov 2022 11:27:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 4/4] ftrace: arm64: move from REGS to ARGS
Message-ID: <20221115112701.GB32523@willie-the-truck>
References: <20221103170520.931305-1-mark.rutland@arm.com>
 <20221103170520.931305-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103170520.931305-5-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:05:20PM +0000, Mark Rutland wrote:
> This commit replaces arm64's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> removes some latent issues with inconsistent presentation of struct
> pt_regs (which can only be reliably saved/restored at exception
> boundaries).

[...]

> @@ -78,10 +77,71 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
>  struct dyn_ftrace;
>  struct ftrace_ops;
> -struct ftrace_regs;
> +
> +#define arch_ftrace_get_regs(regs) NULL
> +
> +struct ftrace_regs {
> +	/* x0 - x8 */
> +	unsigned long regs[9];
> +	unsigned long __unused;
> +
> +	unsigned long fp;
> +	unsigned long lr;
> +
> +	unsigned long sp;
> +	unsigned long pc;
> +};
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> +{
> +	return fregs->pc;
> +}
> +
> +static __always_inline void
> +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> +				    unsigned long pc)
> +{
> +	fregs->pc = pc;
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> +{
> +	return fregs->sp;
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> +{
> +	if (n < 8)
> +		return fregs->regs[n];

Where does this '8' come from?

Will
