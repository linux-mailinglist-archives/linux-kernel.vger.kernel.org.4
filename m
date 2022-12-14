Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338F464C460
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiLNH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiLNH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:29:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953D13D7F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:29:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B0E61792
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614FCC433D2;
        Wed, 14 Dec 2022 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671002939;
        bh=rd25QmK/qA+SyipWKccknPGoz9s0EH6XTsWB5qWSl7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFGhegzm+nmSrDI2ax9eeohqzTjZ1rZVchOPVdFo7G/yPih4REh+6Rd8geHVu7SDh
         axby0bJfl3sJN5vmtJAKVI/VQ+2HZ0yBrHkIDKAEjhw5sg01OXQuSTlhtWGNTOz/RZ
         +4N0Sjg4WKeVAm6aevUoEMQI3g4kCl+22mBgpy8c7/do06IjqYJIV9t0GpwmGSpQqP
         xI6w+HcB2S6Z21F/ZmQ/iXu2XSn+pR74YO0+m6zhE7+ULfKBsdcgbdKnSfGXa9DcJW
         V5tWZ3p2PctBxFBluPAXt9KS9UUnN+nCJrYa3FEpgrTWbxae9orpO+ZKvCXmyzm0nh
         Map57S1Yy74UQ==
Date:   Wed, 14 Dec 2022 16:28:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <dolinux.peng@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] tracing/probe: add a char type to print the
 character value of traced arguments
Message-Id: <20221214162856.c45620472d5efbf26d0fb0e7@kernel.org>
In-Reply-To: <20221214025218.8737-1-dolinux.peng@gmail.com>
References: <20221214025218.8737-1-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 18:52:18 -0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> There are scenes that we want to show the character value of traced
> arguments other than a decimal or hexadecimal or string value for debug
> convinience. Add a new type named 'char' to do it.
> 
> For example:
> 
> echo 'p:myprobe xxxx +0($arg1):char' > kprobe_events
> 
> echo 'p:myprobe xxxx +0($arg1):char[2]' > kprobe_events

This looks good to me. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2:
>  - fix build warnings reported by kernel test robot
>  - modify commit log
> ---
>  Documentation/trace/kprobetrace.rst | 3 ++-
>  kernel/trace/trace_probe.c          | 2 ++
>  kernel/trace/trace_probe.h          | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
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
