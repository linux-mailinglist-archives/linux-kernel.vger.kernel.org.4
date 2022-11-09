Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBBA622C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKIN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiKIN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:26:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CE2D3;
        Wed,  9 Nov 2022 05:26:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0019E61AA5;
        Wed,  9 Nov 2022 13:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3065BC433B5;
        Wed,  9 Nov 2022 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668000413;
        bh=zOnR20PQeCE3FFyKuASlv7XcbYLItRRWOxYi/XO2yns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iAIWUrqQt78w9ZIOCLM8gX/YEgCenk6TQjgEP1zIVUmMa50BvDtFKe4hYFsgA/MMY
         ODjPuQfd+b0+OVGJFgor+1+oNQS1mHhN4b2OSPCjepWb6k8pOhBTIco3EB+NqKBNUI
         CMYpWRN+SV+XefrQtvYc1C2VSgVfEYdoonSgfp+xVQ/7ZCK1Oe5/Nqr6C2mv3PI9nn
         7vjpCmn97IT/MaJ2Hgbm0yPA64mMtsYKI66U63GJd36w/L2U737mMARNvTvDEVvjxs
         e5ru+5HVQ4UBWJ16LtwdpD9G11tZHYmE5tx77xz3oH4HKvaDuKFi449Q1Dzsq7nTrm
         asSI2vaFFNDCg==
Date:   Wed, 9 Nov 2022 22:26:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH] tracing: Optimize event type allocation with IDA
Message-Id: <20221109222650.ce6c22e231345f6852f6956f@kernel.org>
In-Reply-To: <20221109032352.254502-1-zhengyejian1@huawei.com>
References: <20221109032352.254502-1-zhengyejian1@huawei.com>
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

On Wed, 9 Nov 2022 11:23:52 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> After commit 060fa5c83e67 ("tracing/events: reuse trace event ids after
>  overflow"), trace events with dynamic type are linked up in list
> 'ftrace_event_list' through field 'trace_event.list'. Then when max
> event type number used up, it's possible to reuse type number of some
> freed one by traversing 'ftrace_event_list'.
> 
> As instead, using IDA to manage available type numbers can make codes
> simpler and then the field 'trace_event.list' can be dropped.
> 
> Since 'struct trace_event' is used in static tracepoints, drop
> 'trace_event.list' can make vmlinux smaller. Local test with about 2000
> tracepoints, vmlinux reduced about 64KB:
>   before：-rwxrwxr-x 1 root root 76669448 Nov  8 17:14 vmlinux
>   after： -rwxrwxr-x 1 root root 76604176 Nov  8 17:15 vmlinux
> 

This looks good to me, I just have one comment below.

> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  include/linux/trace_events.h |  1 -
>  kernel/trace/trace_output.c  | 65 +++++++++---------------------------
>  2 files changed, 15 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 20749bd9db71..bb2053246d6a 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -136,7 +136,6 @@ struct trace_event_functions {
>  
>  struct trace_event {
>  	struct hlist_node		node;
> -	struct list_head		list;
>  	int				type;
>  	struct trace_event_functions	*funcs;
>  };
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 67f47ea27921..314d175dee3a 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c

Please include linux/idr.h in this source file explicitly beause
IDA APIs are defined in it.

Thank you,

> @@ -21,8 +21,6 @@ DECLARE_RWSEM(trace_event_sem);
>  
>  static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
>  
> -static int next_event_type = __TRACE_LAST_TYPE;
> -
>  enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
>  {
>  	struct trace_seq *s = &iter->seq;
> @@ -688,38 +686,23 @@ struct trace_event *ftrace_find_event(int type)
>  	return NULL;
>  }
>  
> -static LIST_HEAD(ftrace_event_list);
> +static DEFINE_IDA(trace_event_ida);
>  
> -static int trace_search_list(struct list_head **list)
> +static void free_trace_event_type(int type)
>  {
> -	struct trace_event *e = NULL, *iter;
> -	int next = __TRACE_LAST_TYPE;
> -
> -	if (list_empty(&ftrace_event_list)) {
> -		*list = &ftrace_event_list;
> -		return next;
> -	}
> +	if (type >= __TRACE_LAST_TYPE)
> +		ida_free(&trace_event_ida, type);
> +}
>  
> -	/*
> -	 * We used up all possible max events,
> -	 * lets see if somebody freed one.
> -	 */
> -	list_for_each_entry(iter, &ftrace_event_list, list) {
> -		if (iter->type != next) {
> -			e = iter;
> -			break;
> -		}
> -		next++;
> -	}
> +static int alloc_trace_event_type(void)
> +{
> +	int next;
>  
> -	/* Did we used up all 65 thousand events??? */
> -	if (next > TRACE_EVENT_TYPE_MAX)
> +	/* Skip static defined type numbers */
> +	next = ida_alloc_range(&trace_event_ida, __TRACE_LAST_TYPE,
> +			       TRACE_EVENT_TYPE_MAX, GFP_KERNEL);
> +	if (next < 0)
>  		return 0;
> -
> -	if (e)
> -		*list = &e->list;
> -	else
> -		*list = &ftrace_event_list;
>  	return next;
>  }
>  
> @@ -761,28 +744,10 @@ int register_trace_event(struct trace_event *event)
>  	if (WARN_ON(!event->funcs))
>  		goto out;
>  
> -	INIT_LIST_HEAD(&event->list);
> -
>  	if (!event->type) {
> -		struct list_head *list = NULL;
> -
> -		if (next_event_type > TRACE_EVENT_TYPE_MAX) {
> -
> -			event->type = trace_search_list(&list);
> -			if (!event->type)
> -				goto out;
> -
> -		} else {
> -
> -			event->type = next_event_type++;
> -			list = &ftrace_event_list;
> -		}
> -
> -		if (WARN_ON(ftrace_find_event(event->type)))
> +		event->type = alloc_trace_event_type();
> +		if (!event->type)
>  			goto out;
> -
> -		list_add_tail(&event->list, list);
> -
>  	} else if (WARN(event->type > __TRACE_LAST_TYPE,
>  			"Need to add type to trace.h")) {
>  		goto out;
> @@ -819,7 +784,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
>  int __unregister_trace_event(struct trace_event *event)
>  {
>  	hlist_del(&event->node);
> -	list_del(&event->list);
> +	free_trace_event_type(event->type);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
