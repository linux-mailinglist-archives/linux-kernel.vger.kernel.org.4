Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6064FD5F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 02:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLRBUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 20:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLRBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 20:20:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34692E0FE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 17:20:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B12F60C3D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 01:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8939EC433EF;
        Sun, 18 Dec 2022 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671326433;
        bh=qicT3rQp6kWdT0Id/4bJcgSa3iwqNxcqhRvhQqCfeAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XDl3DIkV+QwdD6dsGqTVixU5UQ2j2XdOm806Gc1GpR82h4ysD4rG/ud61oMt6RSjn
         K92MRY9vYK1hbDjkB4hvvLEqaEt64/eHHG9X4+n8vIkhK8NA/47Wp/RS2ZdC6qg/ZN
         04SRJEfOz5F9PU5cIfqwyKgVJy6Ct0HEZLCFBSKuStnmWmuvy6dZH2SP64iXLfsTMm
         v9kxHqoZeS7oN5vKVew0DETsjTXOtZy2LE6qyYQiDR2Ru+Rl+sxdm6W8oNuTGxMDF2
         sFzgsCrpilDzRxxXztd8n8800tZyCoUCjTK3lqsWSOWGjH8eWXfLxPbGiqe/0I1Lbi
         PLWqcvjpCFdwQ==
Date:   Sun, 18 Dec 2022 10:20:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
Subject: Re: [PATCH] cma:tracing: Print alloc result in
 trace_cma_alloc_finish
Message-Id: <20221218102030.94b44e62608f20fd9decf9a0@kernel.org>
In-Reply-To: <20221208142130.1501195-1-haowenchao@huawei.com>
References: <20221208142130.1501195-1-haowenchao@huawei.com>
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

On Thu, 8 Dec 2022 22:21:30 +0800
Wenchao Hao <haowenchao@huawei.com> wrote:

> The result of allocation is not printed in trace_cma_alloc_finish
> now, while it's important to do it so we can set filters to catch
> specific error on allocation or trigger some operations on specific
> error.
> 
> Although we have printed the result in log, but the log is
> conditional and could not be filtered by tracing event.
> 
> What's more, it introduce little overhead to print this result.
> The result of allocation is named as errorno in trace.

This looks good to me. BTW, with this change, cma_alloc_class has only
one event - cma_alloc_busy_retry. If so, can we remove the cma_alloc_class?

Thank you,

> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>  include/trace/events/cma.h | 32 +++++++++++++++++++++++++++++---
>  mm/cma.c                   |  2 +-
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 3d708dae1542..ef75ea606ab2 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -91,12 +91,38 @@ TRACE_EVENT(cma_alloc_start,
>  		  __entry->align)
>  );
>  
> -DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
> +TRACE_EVENT(cma_alloc_finish,
>  
>  	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned long count, unsigned int align),
> +		 unsigned long count, unsigned int align, int errorno),
>  
> -	TP_ARGS(name, pfn, page, count, align)
> +	TP_ARGS(name, pfn, page, count, align, errorno),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned long, pfn)
> +		__field(const struct page *, page)
> +		__field(unsigned long, count)
> +		__field(unsigned int, align)
> +		__field(int, errorno)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->pfn = pfn;
> +		__entry->page = page;
> +		__entry->count = count;
> +		__entry->align = align;
> +		__entry->errorno = errorno;
> +	),
> +
> +	TP_printk("name=%s pfn=0x%lx page=%p count=%lu align=%u errorno=%d",
> +		  __get_str(name),
> +		  __entry->pfn,
> +		  __entry->page,
> +		  __entry->count,
> +		  __entry->align,
> +		  __entry->errorno)
>  );
>  
>  DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
> diff --git a/mm/cma.c b/mm/cma.c
> index 4a978e09547a..a75b17b03b66 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -491,7 +491,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		start = bitmap_no + mask + 1;
>  	}
>  
> -	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
> +	trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
>  
>  	/*
>  	 * CMA can allocate multiple page blocks, which results in different
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
