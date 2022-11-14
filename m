Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59462845E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiKNPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKNPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:52:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB612D1E6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D304AB81076
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B262FC433D6;
        Mon, 14 Nov 2022 15:52:43 +0000 (UTC)
Date:   Mon, 14 Nov 2022 10:53:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/7] mm: vmalloc: Add alloc_vmap_area trace event
Message-ID: <20221114105325.57d27b6f@gandalf.local.home>
In-Reply-To: <20221018181053.434508-2-urezki@gmail.com>
References: <20221018181053.434508-1-urezki@gmail.com>
        <20221018181053.434508-2-urezki@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 20:10:47 +0200
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> It is for a debug purpose and for validation of passed parameters.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/trace/events/vmalloc.h | 56 ++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/trace/events/vmalloc.h
> 
> diff --git a/include/trace/events/vmalloc.h b/include/trace/events/vmalloc.h
> new file mode 100644
> index 000000000000..39fbd77c91e7
> --- /dev/null
> +++ b/include/trace/events/vmalloc.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM vmalloc
> +
> +#if !defined(_TRACE_VMALLOC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_VMALLOC_H
> +
> +#include <linux/tracepoint.h>
> +
> +/**
> + * alloc_vmap_area - called when a new vmap allocation occurs
> + * @addr:	an allocated address
> + * @size:	a requested size
> + * @align:	a requested alignment
> + * @vstart:	a requested start range
> + * @vend:	a requested end range
> + * @failed:	an allocation failed or not
> + *
> + * This event is used for a debug purpose, it can give an extra
> + * information for a developer about how often it occurs and which
> + * parameters are passed for further validation.
> + */
> +TRACE_EVENT(alloc_vmap_area,
> +
> +	TP_PROTO(unsigned long addr, unsigned long size, unsigned long align,
> +		unsigned long vstart, unsigned long vend, int failed),
> +
> +	TP_ARGS(addr, size, align, vstart, vend, failed),

The above is passed in via (from patch 4):


@@ -1621,6 +1624,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		size, align, vstart, vend);
 	spin_unlock(&free_vmap_area_lock);
 
+	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
+
 	/*
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.

> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, addr)
> +		__field(unsigned long, size)
> +		__field(unsigned long, align)
> +		__field(unsigned long, vstart)
> +		__field(unsigned long, vend)

> +		__field(int, failed)

I would drop the failed field...

> +	),
> +
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		__entry->size = size;
> +		__entry->align = align;
> +		__entry->vstart = vstart;
> +		__entry->vend = vend;

And instead have:

		__entry->failed = addr == vend;

Why pass in a parameter that can be calculated in the trace event logic?

Other than that, from a tracing perspective:

  Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

for the series.

-- Steve


> +		__entry->failed = failed;
> +	),
> +
> +	TP_printk("va_start: %lu size=%lu align=%lu vstart=0x%lx vend=0x%lx failed=%d",
> +		__entry->addr, __entry->size, __entry->align,
> +		__entry->vstart, __entry->vend, __entry->failed)
> +);
> +
> +#endif /*  _TRACE_VMALLOC_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

