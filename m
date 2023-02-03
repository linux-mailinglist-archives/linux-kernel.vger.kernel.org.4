Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A74688C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBCBWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBCBWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:22:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98BF83957;
        Thu,  2 Feb 2023 17:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77B28B828EE;
        Fri,  3 Feb 2023 01:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD45BC433EF;
        Fri,  3 Feb 2023 01:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675387363;
        bh=9oIiUfLPZHJQsT36yxAbWs6LV4LruxL2jZsGEw9mMQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NfCZTRs2rHo89KMxohEMFzqqU3FnDlkn1RrdRIYEFXB8+gWh8d1yORNycGN07obJI
         b3Hdlqv+928mZkxmtrVmwR0T7p8Z8W/dZPTVx5KCRQB5W7G5JeCfMUr3GsRyAfYbUI
         kZZR0pUdXsFGqR03fUTMAzsvPSBl/hKC3SdBsPiZJ6XFzG/9RUBGBkmUHoZ4Xu51AP
         wverwAy35VO30OLOUlFTgOXWNiVvMh8D+l4Ql9HURqxTdPCaf1+PqbFPQdpQJU6ye4
         ecA469pfAHmyWACuDjX+QOsU3loEwzPFNgxKDn03JCEoTz7Kx2OkKrcVNLa6cTE8vj
         GpRmcO06cKMpw==
Date:   Fri, 3 Feb 2023 10:22:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     rostedt@goodmis.org, mark.rutland@arm.com, peterz@infradead.org,
        jpoimboe@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: ftrace: Include the nospec-branch.h only for
 x86
Message-Id: <20230203102239.7a5bd7c431978faa0d9201e6@kernel.org>
In-Reply-To: <20230130085954.647845-1-suagrfillet@gmail.com>
References: <20230130085954.647845-1-suagrfillet@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 16:59:54 +0800
Song Shuai <suagrfillet@gmail.com> wrote:

> When other architectures without the nospec functionality write their
> direct-call functions of samples/ftrace/*.c, the including of
> asm/nospec-branch.h must be taken care to fix the no header file found
> error in building process.
> 
> This commit (ee3e2469b346 "x86/ftrace: Make it call depth tracking aware")
> file-globally includes asm/nospec-branch.h providing CALL_DEPTH_ACCOUNT
> for only x86 direct-call functions.
> 
> It seems better to move the including to `#ifdef CONFIG_X86_64`.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

This looks good to me since nospec-branch.h is used only for x86 asm macro.
(s390 also has "nospec-branch.h" file but that doesn't provide such macro,
so this change will not affect it.)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  samples/ftrace/ftrace-direct-modify.c       | 2 +-
>  samples/ftrace/ftrace-direct-multi-modify.c | 2 +-
>  samples/ftrace/ftrace-direct-multi.c        | 2 +-
>  samples/ftrace/ftrace-direct-too.c          | 2 +-
>  samples/ftrace/ftrace-direct.c              | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index de5a0f67f320..d93abbcb1f4c 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -3,7 +3,6 @@
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>  
>  extern void my_direct_func1(void);
>  extern void my_direct_func2(void);
> @@ -26,6 +25,7 @@ static unsigned long my_ip = (unsigned long)schedule;
>  #ifdef CONFIG_X86_64
>  
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index a825dbd2c9cf..b58c594efb51 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -3,7 +3,6 @@
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>  
>  extern void my_direct_func1(unsigned long ip);
>  extern void my_direct_func2(unsigned long ip);
> @@ -24,6 +23,7 @@ extern void my_tramp2(void *);
>  #ifdef CONFIG_X86_64
>  
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index d955a2650605..c27cf130c319 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -5,7 +5,6 @@
>  #include <linux/ftrace.h>
>  #include <linux/sched/stat.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>  
>  extern void my_direct_func(unsigned long ip);
>  
> @@ -19,6 +18,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>  
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index e13fb59a2b47..8139dce2a31c 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -4,7 +4,6 @@
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>  
>  extern void my_direct_func(struct vm_area_struct *vma,
>  			   unsigned long address, unsigned int flags);
> @@ -21,6 +20,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>  
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index 1f769d0db20f..1d3d307ca33d 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -4,7 +4,6 @@
>  #include <linux/sched.h> /* for wake_up_process() */
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
> -#include <asm/nospec-branch.h>
>  
>  extern void my_direct_func(struct task_struct *p);
>  
> @@ -18,6 +17,7 @@ extern void my_tramp(void *);
>  #ifdef CONFIG_X86_64
>  
>  #include <asm/ibt.h>
> +#include <asm/nospec-branch.h>
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
