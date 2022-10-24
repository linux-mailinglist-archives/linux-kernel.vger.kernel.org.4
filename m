Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6960B01D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiJXQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJXP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:59:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47F1DF39
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12EA8B81A70
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A75C433C1;
        Mon, 24 Oct 2022 14:48:35 +0000 (UTC)
Date:   Mon, 24 Oct 2022 10:48:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, will@kernel.org
Subject: Re: [PATCH 1/4] ftrace: pass fregs to
 arch_ftrace_set_direct_caller()
Message-ID: <20221024104845.3c898d85@gandalf.local.home>
In-Reply-To: <20221024140846.3555435-2-mark.rutland@arm.com>
References: <20221024140846.3555435-1-mark.rutland@arm.com>
        <20221024140846.3555435-2-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 15:08:43 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -429,6 +429,7 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
>  }
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
> +#ifdef CONFIG_FUNCTION_TRACER

Instead of adding the above preprocessor check, the below chunk should be
moved into the CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block above.

-- Steve


>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  /*
>   * This must be implemented by the architecture.
> @@ -443,9 +444,10 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
>   * the return from the trampoline jump to the direct caller
>   * instead of going back to the function it just traced.
>   */
> -static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
> +static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
>  						 unsigned long addr) { }
>  #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> +#endif /* CONFIG_FUNCTION_TRACER */
>  
>  #ifdef CONFIG_STACK_TRACER
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fbf2543111c0..234c5414deee 100644
