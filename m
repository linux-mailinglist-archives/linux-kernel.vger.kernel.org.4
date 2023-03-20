Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35F76C1E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCTRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjCTRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:50:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 395AC9EF9;
        Mon, 20 Mar 2023 10:44:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291711FB;
        Mon, 20 Mar 2023 10:45:01 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF073F67D;
        Mon, 20 Mar 2023 10:44:16 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:44:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tom Rix <trix@redhat.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: set direct_ops storage-class-specifier to static
Message-ID: <ZBibbUQlkytYsoN9@FVFF77S0Q05N.cambridge.arm.com>
References: <20230311135113.711824-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311135113.711824-1-trix@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 08:51:13AM -0500, Tom Rix wrote:
> smatch reports this warning
> kernel/trace/ftrace.c:2594:19: warning:
>   symbol 'direct_ops' was not declared. Should it be static?
> 
> The variable direct_ops is only used in ftrace.c, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

This makes sense, and as this stands:

Acked-by: Mark Rutland <mark.rutland@arm.com>

... but Florent's rework of the API is going to remove this anyway:

  https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/
  https://lore.kernel.org/all/20230316173811.1223508-4-revest@chromium.org/

... so if we take Florent's series, this patch isn't necessary.

Mark.

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
