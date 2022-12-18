Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D564FD65
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 02:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLRBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLRBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 20:39:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B5E028
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 17:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 823ABB80939
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 01:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A7C433EF;
        Sun, 18 Dec 2022 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671327550;
        bh=vdPLodPjptqDtKrS8yKtZZdfufplFpLS9GpzIhaHVY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAgnnvwd0uDcZbYhpyT+e1C84in7/u77RbxpTGLADa3vOxA+AKtbZNsa1KRhBxKMW
         2AQkSJb4K8TnJtKxkXl6xvMWR58YdiIq2O/Uvunssm8pTe6nV4llzfBhiscW7gQQpp
         phck4l5h42UggKKYvAq9F44NDMFYBLp/f9rkvJp9xk6BvdXS6nZp4/ZbCpyXqcv3m5
         8oAg7jzcCZQd1+hXZ/wRVAvH7LSXfv5iQdB35aVsOQqHkqOMYcp/6DGXJsHpudYZ8K
         oTZ44hLXpTyiTPT6IhgvbTm4j/PnIBZuv2SYgJi7Lsd2M3fvxh7EyqJCsi1d3Cj9iU
         /Qhj8vEHNLghQ==
Date:   Sun, 18 Dec 2022 10:39:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <dolinux.peng@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] tracing/probe: add a char type to show the character
 value of traced arguments
Message-Id: <20221218103907.61bdd5a2ef5c2d175f585931@kernel.org>
In-Reply-To: <20221215091346.33710-1-dolinux.peng@gmail.com>
References: <20221215091346.33710-1-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donglin,

Thanks for updating you patch. And can you also send a test code update
(tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc)?

Thank you,

On Thu, 15 Dec 2022 01:13:46 -0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> There are scenes that we want to show the character value of traced
> arguments other than a decimal or hexadecimal or string value for debug
> convinience. Add a new type named 'char' to do it.
> 
> For example:
> 
> The to be traced function is 'void demo_func(char type, char *name);', we
> can add a kprobe event as follows to show argument values as we want:
> 
> echo 'p:myprobe demo_func $arg1:char +0($arg2):char[2]' > kprobe_events
> 
> we will get the following trace log:
> 
> ... 95.451350: myprobe: (demo_func+0x0/0x29) arg1=A arg2={b,p}
> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v4:
>  - update the example in the commit log
> 
> Changes in v3:
>  - update readme_msg
> 
> Changes in v2:
>  - fix build warnings reported by kernel test robot
>  - modify commit log
> ---
>  Documentation/trace/kprobetrace.rst | 3 ++-
>  kernel/trace/trace.c                | 2 +-
>  kernel/trace/trace_probe.c          | 2 ++
>  kernel/trace/trace_probe.h          | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 4274cc6a2f94..007972a3c5c4 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -58,7 +58,7 @@ Synopsis of kprobe_events
>    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
>    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
>  		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> -		  (x8/x16/x32/x64), "string", "ustring" and bitfield
> +		  (x8/x16/x32/x64), "char", "string", "ustring" and bitfield
>  		  are supported.
>  
>    (\*1) only for the probe on function entry (offs == 0).
> @@ -80,6 +80,7 @@ E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
>  Note that the array can be applied to memory type fetchargs, you can not
>  apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
>  wrong, but '+8($stack):x8[8]' is OK.)
> +Char type can be used to show the character value of traced arguments.
>  String type is a special type, which fetches a "null-terminated" string from
>  kernel space. This means it will fail and store NULL if the string container
>  has been paged out. "ustring" type is an alternative of string for user-space.
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5cfc95a52bc3..a64e206f94e6 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5615,7 +5615,7 @@ static const char readme_msg[] =
>  	"\t           $stack<index>, $stack, $retval, $comm,\n"
>  #endif
>  	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
> -	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
> +	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
>  	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
>  	"\t           <type>\\[<array-size>\\]\n"
>  #ifdef CONFIG_HIST_TRIGGERS
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de46..a4abf7f6c295 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
>  DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
>  DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
>  DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
> +DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "%c")
>  
>  int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
>  {
> @@ -93,6 +94,7 @@ static const struct fetch_type probe_fetch_types[] = {
>  	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
>  	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
>  	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> +	ASSIGN_FETCH_TYPE_ALIAS(char, u8, u8,  0),
>  	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
>  
>  	ASSIGN_FETCH_TYPE_END
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index de38f1c03776..8c86aaa8b0c9 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -164,6 +164,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x16);
>  DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
>  DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
>  
> +DECLARE_BASIC_PRINT_TYPE_FUNC(char);
>  DECLARE_BASIC_PRINT_TYPE_FUNC(string);
>  DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
