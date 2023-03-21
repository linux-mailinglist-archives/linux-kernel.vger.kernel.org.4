Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD766C3837
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCURc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCURc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:32:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170B13D5C;
        Tue, 21 Mar 2023 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xUZFSZQsr16SNSQJKusTXYyu832nutqEq5J/FsHnccU=; b=AVftADjchhmt+Jp4bRXmDpPWgb
        QPWGGGotXG4NW1Bxs8o7Mp2rYgt/rL0QpXwz7h7on7QEc0WLk1BogpwK3a4peFkSHmTxBkVUyXocp
        j16OfEx0Oa09g8pUR/qFB7nkgAKzV/AW/0T7oiuhW2LiRPbNE7GT6NZmc/fLBVcY22b/BpDYwIOMJ
        2N+0YvkAiRDtyivAXO6s+QL9tNvKIH+3z2wm6TRGR2P1oF6tdGWQwzSQ2WpgY5ufuJR9Gx3RyzHQF
        kR1xJKNsXr60PT+/7CeaDjk9yyvTwktOC8fZrAOTP1SzL9jUPDeglbIOlB9HuOkQdulRWp8kKMoJC
        oqAmnEXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51692)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pefq5-0001da-I2; Tue, 21 Mar 2023 17:32:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pefpp-0007vh-5A; Tue, 21 Mar 2023 17:31:45 +0000
Date:   Tue, 21 Mar 2023 17:31:45 +0000
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
Subject: Re: [PATCH v5 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <ZBnqAYO7rdk4Qikq@shell.armlinux.org.uk>
References: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
 <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320131650.482594-2-pengdonglin@sangfor.com.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:16:49AM -0700, Donglin Peng wrote:
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index 3e7bcaca5e07..ba1986e27af8 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -258,7 +258,15 @@ ENDPROC(ftrace_graph_regs_caller)
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  ENTRY(return_to_handler)
>  	stmdb	sp!, {r0-r3}
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +	/*
> +	 * Pass both the function return values in the register r0 and r1
> +	 * to ftrace_return_to_handler
> +	 */
> +	add	r2, sp, #16		@ sp at exit of instrumented routine
> +#else
>  	add	r0, sp, #16		@ sp at exit of instrumented routine
> +#endif
>  	bl	ftrace_return_to_handler
...
> -unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
> +static unsigned long __ftrace_return_to_handler(unsigned long retval_1st,
> +			unsigned long retval_2nd, unsigned long frame_pointer)
...
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +unsigned long ftrace_return_to_handler(unsigned long retval_1st,
> +			unsigned long retval_2nd, unsigned long frame_pointer)
> +{
> +	return __ftrace_return_to_handler(retval_1st, retval_2nd, frame_pointer);
> +}
> +#else
> +unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
> +{
> +	return __ftrace_return_to_handler(0, 0, frame_pointer);
> +}
> +#endif
> +

Hi,

To echo Mark's criticism, I also don't like this. I feel it would be
better if ftrace_return_to_handler() always took the same arguments
irrespective of the setting of CONFIG_FUNCTION_GRAPH_RETVAL.

On 32-bit ARM, we have to stack r0-r3 anyway to prevent the call to
ftrace_return_to_handler() corrupting the return value, and these
are the registers we need. So we might as well pass a pointer to
these stacked registers. Whether that's acceptable on other
architectures, I couldn't say.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
