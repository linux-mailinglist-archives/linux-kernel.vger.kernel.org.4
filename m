Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F36483F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLIOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLIOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:40:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB96727DFC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:40:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C06C23A;
        Fri,  9 Dec 2022 06:40:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA453F73D;
        Fri,  9 Dec 2022 06:40:27 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:40:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, rostedt@goodmis.org, samitolvanen@google.com,
        keescook@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-ID: <Y5NI2TKtGbDKyt53@FVFF77S0Q05N>
References: <20221209143402.3332369-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209143402.3332369-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:34:02PM +0100, Ard Biesheuvel wrote:
> The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
> DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
> require the former in order to allow the function graph tracer to be
> enabled in combination with shadow call stacks. This means that this is
> no longer permitted at all, in spite of the fact that either flavour of
> ftrace works perfectly fine in this combination.
> 
> Given that arm64 is the only arch that implements shadow call stacks in
> the first place, let's update the condition to just reflect the arm64
> change. When other architectures adopt shadow call stack support, this
> can be revisited if needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

My bad; sorry about this, and thanks for the fix!

Acked-by: Mark Rutland <mark.rutland@arm.com>

We should probably also add:

Fixes: 26299b3f6ba26bfc ("ftrace: arm64: move from REGS to ARGS")

Mark.

> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 072a1b39e3afd0d1..683f365b5e31c856 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -635,7 +635,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  config SHADOW_CALL_STACK
>  	bool "Shadow Call Stack"
>  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> -	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> +	depends on DYNAMIC_FTRACE_WITH_ARGS || !FUNCTION_GRAPH_TRACER
>  	help
>  	  This option enables the compiler's Shadow Call Stack, which
>  	  uses a shadow stack to protect function return addresses from
> -- 
> 2.35.1
> 
