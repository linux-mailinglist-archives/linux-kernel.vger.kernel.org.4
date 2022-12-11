Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5C649243
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 04:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLKD1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 22:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKD1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 22:27:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237CC3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 19:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE53260D27
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86343C433EF;
        Sun, 11 Dec 2022 03:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670729255;
        bh=SLRW9XaslzwlpQy6leJBYpMTuYIaNwDRf33UV6+Ao14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=idDjc3uCqWJjnZF16XCZDJO66hS7lkkDiIcGq6/UKMwWocZcnfuiSaKLZkDMKJYlI
         4g/U0GeRdgDdQ32dXwkTOZ1ZC34UeGWlAQGu9maCWgA9eK/nzySbCVrLWM8a76pWVf
         wyrfKKFWmgDC2mvbP0rAylq8FsZGYZGXShJN9ljuP7e7tFoFSaWaFm/GGN1KDpl9OW
         C2IcsmI2F+8zk7v8v3KQPtp4rgAIREN3H64ano+Fep86knUPDQipY5X9iJrUpTrwbX
         fRFKDdOQUGPnCMq7CyN3rgsTHbaVS5xmnKOtKr492jtj2j0sMVbnITkTfKFJrd5euu
         0FF+YLliePkhA==
Date:   Sun, 11 Dec 2022 12:27:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, will@kernel.org, rostedt@goodmis.org,
        samitolvanen@google.com, keescook@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-Id: <20221211122731.f909ac15e227675229f03ecf@kernel.org>
In-Reply-To: <20221209143402.3332369-1-ardb@kernel.org>
References: <20221209143402.3332369-1-ardb@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Dec 2022 15:34:02 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

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

This brings a question. Is the SCS safe if kretprobe(rethook) is enabled?
it also changes the stack entry after a calling function.

Thank you,

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
