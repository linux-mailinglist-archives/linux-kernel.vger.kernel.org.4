Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202A6C762C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCXDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCXDNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:13:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD14C05;
        Thu, 23 Mar 2023 20:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D686293D;
        Fri, 24 Mar 2023 03:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B330C4339B;
        Fri, 24 Mar 2023 03:13:13 +0000 (UTC)
Date:   Thu, 23 Mar 2023 23:13:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>
Subject: Re: [PATCH] trace:cma: remove unnecessary event class
 cma_alloc_class
Message-ID: <20230323231311.4a11c7f7@rorschach.local.home>
In-Reply-To: <20230323114136.177677-1-haowenchao2@huawei.com>
References: <20230323114136.177677-1-haowenchao2@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 19:41:36 +0800
Wenchao Hao <haowenchao2@huawei.com> wrote:

> After commit cb6c33d4dc09 ("cma: tracing: print alloc result in
> trace_cma_alloc_finish"), cma_alloc_class has only one event which is
> cma_alloc_busy_retry. So we can remove the cma_alloc_class.
> 

This is fine for an aesthetic view, but it has no functional change.
TRACE_EVENT() is simply defined as:

#define TRACE_EVENT(name, proto, args, tstruct, assign, print) \
	DECLARE_EVENT_CLASS(name,			       \
			     PARAMS(proto),		       \
			     PARAMS(args),		       \
			     PARAMS(tstruct),		       \
			     PARAMS(assign),		       \
			     PARAMS(print));		       \
	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/trace/trace_events.h#n29

This patch simply un-open-codes it.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Cheers,

-- Steve


> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  include/trace/events/cma.h | 58 ++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 33 deletions(-)
> 
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index ef75ea606ab2..25103e67737c 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -8,37 +8,6 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> -DECLARE_EVENT_CLASS(cma_alloc_class,
> -
> -	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned long count, unsigned int align),
> -
> -	TP_ARGS(name, pfn, page, count, align),
> -
> -	TP_STRUCT__entry(
> -		__string(name, name)
> -		__field(unsigned long, pfn)
> -		__field(const struct page *, page)
> -		__field(unsigned long, count)
> -		__field(unsigned int, align)
> -	),
> -
> -	TP_fast_assign(
> -		__assign_str(name, name);
> -		__entry->pfn = pfn;
> -		__entry->page = page;
> -		__entry->count = count;
> -		__entry->align = align;
> -	),
> -
> -	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u",
> -		  __get_str(name),
> -		  __entry->pfn,
> -		  __entry->page,
> -		  __entry->count,
> -		  __entry->align)
> -);
> -
>  TRACE_EVENT(cma_release,
>  
>  	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> @@ -125,12 +94,35 @@ TRACE_EVENT(cma_alloc_finish,
>  		  __entry->errorno)
>  );
>  
> -DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
> +TRACE_EVENT(cma_alloc_busy_retry,
>  
>  	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
>  		 unsigned long count, unsigned int align),
>  
> -	TP_ARGS(name, pfn, page, count, align)
> +	TP_ARGS(name, pfn, page, count, align),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned long, pfn)
> +		__field(const struct page *, page)
> +		__field(unsigned long, count)
> +		__field(unsigned int, align)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->pfn = pfn;
> +		__entry->page = page;
> +		__entry->count = count;
> +		__entry->align = align;
> +	),
> +
> +	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u",
> +		  __get_str(name),
> +		  __entry->pfn,
> +		  __entry->page,
> +		  __entry->count,
> +		  __entry->align)
>  );
>  
>  #endif /* _TRACE_CMA_H */

