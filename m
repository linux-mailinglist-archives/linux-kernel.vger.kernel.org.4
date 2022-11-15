Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB75629C13
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKOO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiKOO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:26:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34B2A948
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668522393; x=1700058393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XERZkaZEnlrgczx883x+W1hcSu7sIngfJcKE+vi5KY=;
  b=2dm9cKIOBcuXSggW4sEHYk+5uGBu3oM6jYI4wrV9pxjSBvsMiCv0dFAR
   mYMFQXUk0eaEq8ORkFySpdP8H6lSjIA09HgWoXnMEYv6FtsBP1YS/ncpi
   I5ocq2BzNP69ORGinHUodSkCZkorQV9D7vvcqQIvgVMeU0lu1KtrMW8k4
   hmy3Iabp8sLicPHoWjPzE7jCCn1jizwGwCoVD1kVIVJ7xrrFdTDwYSQeo
   BlLAIt+4bLTN/9m4Ba62u34d0mHDYsbMhC0nYQglp/hvJrMaUd+KZzSqu
   hgWgLoarypHkT0tgWMlh3C+VFQsSJ7dCW4QqMgyHyLF9va7Rfdj5twQBf
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="189058136"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 07:26:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 07:26:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 07:26:30 -0700
Date:   Tue, 15 Nov 2022 14:26:13 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <guoren@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] riscv/ftrace: add ftrace_graph_func
Message-ID: <Y3OhhZGlk5I5DN+f@wendy>
References: <20221115061525.112757-1-suagrfillet@gmail.com>
 <20221115061525.112757-2-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115061525.112757-2-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:15:23PM +0800, Song Shuai wrote:
> Here implements ftrace_graph_func as the function graph tracing function
> with FTRACE_WITH_REGS defined.
> 
> function_graph_func gets the point of the parent IP and the frame pointer
> from fregs and call prepare_ftrace_return for function graph tracing.
> 
> If FTRACE_WITH_REGS isn't defined, the enable/disable helpers of
> ftrace_graph_[regs]_call remain for serving the !FTRACE_WITH_REGS
> version ftrace_caller.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

Hey Song,
Last time I saw your email I'd swear it was "sugarfillet", just making
sure that it is not a typo.

Anyways, checkpatch is whinging about some parenthesis stuff:
https://patchwork.kernel.org/project/linux-riscv/patch/20221115061525.112757-2-suagrfillet@gmail.com/

Would be nice to fix that when you resping.

Thanks,
Conor.

> ---
>  arch/riscv/include/asm/ftrace.h | 13 +++++++++++--
>  arch/riscv/kernel/ftrace.c      | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 04dad3380041..b33c98070972 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -81,8 +81,17 @@ do {									\
>  struct dyn_ftrace;
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
> -#endif
>  
> -#endif
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +struct ftrace_ops;
> +struct ftrace_regs;
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +			struct ftrace_ops *op, struct ftrace_regs *fregs);
> +#define ftrace_graph_func ftrace_graph_func
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* CONFIG_DYNAMIC_FTRACE */
>  
>  #endif /* _ASM_RISCV_FTRACE_H */
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 2086f6585773..2d7ce77d4f33 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -196,6 +196,20 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  }
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +
> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +			struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
> +	unsigned long *parent = (unsigned long *)&(regs->ra);
> +
> +	prepare_ftrace_return(parent, ip, frame_pointer(regs));
> +}
> +
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
>  extern void ftrace_graph_call(void);
>  extern void ftrace_graph_regs_call(void);
>  int ftrace_enable_ftrace_graph_caller(void)
> @@ -223,5 +237,7 @@ int ftrace_disable_ftrace_graph_caller(void)
>  	return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
>  				    (unsigned long)&prepare_ftrace_return, false);
>  }
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> -- 
> 2.20.1
> 
