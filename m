Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1AA70756D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEQW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQW2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8F959DE;
        Wed, 17 May 2023 15:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDABE648F9;
        Wed, 17 May 2023 22:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF56C433EF;
        Wed, 17 May 2023 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684362499;
        bh=KFREZcjLEiG8NztAj50tdQP1RgWuzfuivuMpu6iL7lU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MOMp5wi3hbzvqfoqvTmUUvhRxNtlfo0gRfrFFmV/bCdLQOO7cwZpflzzSzuuXqEB2
         tYeAsfOOqSmRLo+su9SOHiMUxFaavhgpYZsMR0Zkva2gldyrF2Z2j7vpYw/ivMFcAa
         l/1oFEpvLe3O30sVjNvzRi64h4PZBwcxtV0la0JFSyk92grL4l8x4TZWKkyMEPfVI2
         w5AW9BgnguEIhVKbWrw2Qn2j++ySHAyBfTNUsI/SY6IF0lrKrPYqECvbTFMVYBMp4h
         KGIB3tLsKC7cDlqnKP4bIqFM8r1Rz5LNQB7IlenQFlBUny35vQAHkOYuKcFDi88Jpe
         KChVFVrEgK0cA==
Date:   Thu, 18 May 2023 07:28:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Message-Id: <20230518072815.53fd9f67a3423d85f133d98b@kernel.org>
In-Reply-To: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
References: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:53:23 +0000
Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/ftrace.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 764668467155..6a77edb51f18 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5743,7 +5743,7 @@ bool ftrace_filter_param __initdata;
>  static int __init set_ftrace_notrace(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strlcpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_notrace=", set_ftrace_notrace);
> @@ -5751,7 +5751,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
>  static int __init set_ftrace_filter(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strlcpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_filter=", set_ftrace_filter);
> @@ -5763,14 +5763,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
>  
>  static int __init set_graph_function(char *str)
>  {
> -	strlcpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_graph_filter=", set_graph_function);
>  
>  static int __init set_graph_notrace_function(char *str)
>  {
> -	strlcpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_graph_notrace=", set_graph_notrace_function);
> @@ -6569,8 +6569,8 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
>  			continue;
>  		*value = op->trampoline;
>  		*type = 't';
> -		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
> -		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
> +		strscpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
> +		strscpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
>  		*exported = 0;
>  		return 0;
>  	}
> @@ -6933,7 +6933,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  		if (off)
>  			*off = addr - found_func->ip;
>  		if (sym)
> -			strlcpy(sym, found_func->name, KSYM_NAME_LEN);
> +			strscpy(sym, found_func->name, KSYM_NAME_LEN);
>  
>  		return found_func->name;
>  	}
> @@ -6987,8 +6987,8 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
>  
>  			*value = mod_func->ip;
>  			*type = 'T';
> -			strlcpy(name, mod_func->name, KSYM_NAME_LEN);
> -			strlcpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> +			strscpy(name, mod_func->name, KSYM_NAME_LEN);
> +			strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
>  			*exported = 1;
>  			preempt_enable();
>  			return 0;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
