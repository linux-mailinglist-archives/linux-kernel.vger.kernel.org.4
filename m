Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE276BAB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjCOIsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCOIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907B5FD9;
        Wed, 15 Mar 2023 01:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B9161AC1;
        Wed, 15 Mar 2023 08:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D49C433EF;
        Wed, 15 Mar 2023 08:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678870128;
        bh=J2k08xWudvUCv6nsO7U+IrEa2txCfR0J8IVe5Z7YUlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VU8ZJa8E0er6C6d+JYQXuCR4sr/CHUTWqeyuXoPW2bG/hl7UPHeDjb/Jj3VjI7AXg
         GUCoOnLQ9nGBi66+jUFkDxwCDyXkNEr3Kv5kFlDK7Loqx11VMFiHJGb/sJXxoQB7gZ
         r4P9kyOFilh80LN7le7EMqH4UJYb8YgDtidke75P1oUp780SBPN7ui6mDk/dVNE/qa
         gJtEDJnDZDzCCtkFz0TjxqEQ10B/sPZuXto80CJuFuAIxA4sSVMaJCZvN09/Q70Ima
         rztg0GqPF/gfoupCt82gRKk2R3+7mrHxNOlWLyCVsxuHFqaVcYavATbX3mMIuYKqSG
         MpEMIRi8JdrPw==
Date:   Wed, 15 Mar 2023 17:48:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     rostedt@goodmis.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: set direct_ops storage-class-specifier to
 static
Message-Id: <20230315174845.c4bcf7a75ff5f644bef7b07a@kernel.org>
In-Reply-To: <20230311135113.711824-1-trix@redhat.com>
References: <20230311135113.711824-1-trix@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 08:51:13 -0500
Tom Rix <trix@redhat.com> wrote:

> smatch reports this warning
> kernel/trace/ftrace.c:2594:19: warning:
>   symbol 'direct_ops' was not declared. Should it be static?
> 
> The variable direct_ops is only used in ftrace.c, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 29baa97d0d53..05f76dc1f0c5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2591,7 +2591,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
>  	arch_ftrace_set_direct_caller(fregs, addr);
>  }
>  
> -struct ftrace_ops direct_ops = {
> +static struct ftrace_ops direct_ops = {
>  	.func		= call_direct_funcs,
>  	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
>  			  | FTRACE_OPS_FL_PERMANENT,
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
