Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3F6BDCD6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPXVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:21:45 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D310DE40;
        Thu, 16 Mar 2023 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sdi/29/StTsbeuvKgT+Z/F++TfRAz2A8U4n5uNyTQzU=; b=yc1jhoRBNKVkdjN9mmlVB044Vu
        wohIHAMTrL9uqkgv4xeeoVKIdni4or2O28eapr23X3uKegkoPxskg52+U/dVBIsVL3sIXwjsHEMW5
        80C//4z4+Gbb4RT9+qfZ8Kb9S9cuSvo0GmBevSrXz37rQJSJc9S4xzJTtduN8qZ6LSlVstXP73atx
        t857BK93EF5gn8KtcYGaGmLJ+7YBGo4cO5CmN8X6Pl8bYu+/SFSa/UlQrS7vgRDCpnDqPEQY5v5o5
        EyLb4d79U+oBi6RtiDdDjSz+RQLfa2KuHEAqmdPdLSfnFYGRTVeGWmfnOBnbGvPnb/GY9cGx5fkMW
        TWAK5xiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43194)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pcwuI-0001Tf-9J; Thu, 16 Mar 2023 23:21:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pcwuB-0002qU-Rg; Thu, 16 Mar 2023 23:21:07 +0000
Date:   Thu, 16 Mar 2023 23:21:07 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <ZBOkY8FkqgoBfzQ2@shell.armlinux.org.uk>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
 <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:39:10AM -0700, Donglin Peng wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e24a9820e12f..ad03fc868f34 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -99,6 +99,7 @@ config ARM
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index 3e7bcaca5e07..0151d2ce9958 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -258,6 +258,10 @@ ENDPROC(ftrace_graph_regs_caller)
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  ENTRY(return_to_handler)
>  	stmdb	sp!, {r0-r3}
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +	/* Pass the function return value to ftrace_return_to_handler */
> +	mov	r1, r0

In a similar vein to Peter's comment, do we care about 64-bit return
values here, because the above only covers 32-bit values.

If we do care about 64-bit values, then we get into EABI/OABI
stickyness, because on EABI the 64-bit value would have to be passed
in r2,r3, and OABI would need r1,r2.

it would be better to have the 64-bit argument as the first argument
to ftrace_return_to_handler() which would eliminate that variability,
but I don't know what effect that would have for other architectures.

Things get more icky if we want 128-bit values. For EABI, we've
conveniently just stacked that. For OABI, that would need to be in
r1-r3 and the final high bits on the stack.

With a 128-bit argument as the first, that would be r0-r3 with the
existing stack pointer argument stored... on the stack.

So, really it depends what size of return value we want to report.
Also, please bear in mind that where a function returns a 32-bit
value, that will be in r0, and r1 will be whatever happened to be
in it at function exit - there's no defined value for r1.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
