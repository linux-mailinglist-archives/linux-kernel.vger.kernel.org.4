Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739C6381CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 00:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKXXku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 18:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 18:40:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC58114;
        Thu, 24 Nov 2022 15:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B7D621E1;
        Thu, 24 Nov 2022 23:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21ADC433D6;
        Thu, 24 Nov 2022 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669333246;
        bh=SYvBYgSbSaVfiKCPqCtIzKNYypAMfuEJrd5Cp78cV4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LglvWNR7XuXFUHPTRSEc7y9AsH/4w9tM6mT2qF/fb+ODWdKhlpyVvwZZkrbKu7UkI
         umD1NYoG9X8LX/rQ1GdaChBlEEAhjz8BgkTkNXkgwrVTdFFVsYkBkCsBiG4f5eG8h+
         0MIDWNxMQPgYYzp6Ha6w1bY+hrHpHY29LmOKkECF9Hst9GxNfsu8sINJPNbTilaBOP
         5KO+6wqk4ulBdaQmCXepKZdvLoU236KceMLzBEk2o3uIvmWrbjFr4jyEs1Ed63hnme
         Zd1DoKAIyD+kz1DgfD9T0hiDK2N99yrlZ3h3LDNgYUxlppAes0A+xb4eBFYh5s8whC
         Oqn+OyQgJyjOQ==
Date:   Fri, 25 Nov 2022 08:40:44 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kernel/trace: Introduce trace_probe_print_args
 and use it in *probes
Message-Id: <20221125084044.fdeabb7e9465ecfac4dc9aa1@kernel.org>
In-Reply-To: <1669190508-2850-1-git-send-email-chensong_2000@189.cn>
References: <1669190508-2850-1-git-send-email-chensong_2000@189.cn>
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

On Wed, 23 Nov 2022 16:01:48 +0800
Song Chen <chensong_2000@189.cn> wrote:

> print_probe_args is currently inplemented in trace_probe_tmpl.h and
> included by *probes, as a result, each probe has an identical copy.
> 
> This patch will move it to trace_probe.c as an new API, each probe
> calls it to print their args in trace file.

This looks good to me. There is no reason make it inlined.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/trace/trace_eprobe.c     |  2 +-
>  kernel/trace/trace_kprobe.c     |  4 ++--
>  kernel/trace/trace_probe.c      | 27 +++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h      |  2 ++
>  kernel/trace/trace_probe_tmpl.h | 28 ----------------------------
>  kernel/trace/trace_uprobe.c     |  2 +-
>  6 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 5dd0617e5df6..bdb26eee7a0c 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -310,7 +310,7 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5a75b039e586..a4ffa864dbb7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1426,7 +1426,7 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> @@ -1461,7 +1461,7 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
>  
>  	trace_seq_putc(s, ')');
>  
> -	if (print_probe_args(s, tp->args, tp->nr_args,
> +	if (trace_probe_print_args(s, tp->args, tp->nr_args,
>  			     (u8 *)&field[1], field) < 0)
>  		goto out;
>  
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de46..ae13b6b2d5da 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1218,3 +1218,30 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
>  
>  	return ret;
>  }
> +
> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> +		 u8 *data, void *field)
> +{
> +	void *p;
> +	int i, j;
> +
> +	for (i = 0; i < nr_args; i++) {
> +		struct probe_arg *a = args + i;
> +
> +		trace_seq_printf(s, " %s=", a->name);
> +		if (likely(!a->count)) {
> +			if (!a->type->print(s, data + a->offset, field))
> +				return -ENOMEM;
> +			continue;
> +		}
> +		trace_seq_putc(s, '{');
> +		p = data + a->offset;
> +		for (j = 0; j < a->count; j++) {
> +			if (!a->type->print(s, p, field))
> +				return -ENOMEM;
> +			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
> +			p += a->type->size;
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index de38f1c03776..cfef198013af 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -343,6 +343,8 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
>  bool trace_probe_match_command_args(struct trace_probe *tp,
>  				    int argc, const char **argv);
>  int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
> +int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> +		 u8 *data, void *field);
>  
>  #define trace_probe_for_each_link(pos, tp)	\
>  	list_for_each_entry(pos, &(tp)->event->files, list)
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index b3bdb8ddb862..1b57420857e1 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -212,31 +212,3 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
>  		}
>  	}
>  }
> -
> -static inline int
> -print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
> -		 u8 *data, void *field)
> -{
> -	void *p;
> -	int i, j;
> -
> -	for (i = 0; i < nr_args; i++) {
> -		struct probe_arg *a = args + i;
> -
> -		trace_seq_printf(s, " %s=", a->name);
> -		if (likely(!a->count)) {
> -			if (!a->type->print(s, data + a->offset, field))
> -				return -ENOMEM;
> -			continue;
> -		}
> -		trace_seq_putc(s, '{');
> -		p = data + a->offset;
> -		for (j = 0; j < a->count; j++) {
> -			if (!a->type->print(s, p, field))
> -				return -ENOMEM;
> -			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
> -			p += a->type->size;
> -		}
> -	}
> -	return 0;
> -}
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index fb58e86dd117..1ff8f87211a6 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1041,7 +1041,7 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
>  		data = DATAOF_TRACE_ENTRY(entry, false);
>  	}
>  
> -	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
> +	if (trace_probe_print_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
>  		goto out;
>  
>  	trace_seq_putc(s, '\n');
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
