Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1162EBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiKRCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiKRCRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:17:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B787575;
        Thu, 17 Nov 2022 18:17:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6FE6230C;
        Fri, 18 Nov 2022 02:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB5C433C1;
        Fri, 18 Nov 2022 02:17:28 +0000 (UTC)
Date:   Thu, 17 Nov 2022 21:17:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling
 trigger
Message-ID: <20221117211726.4bbbb96a@gandalf.local.home>
In-Reply-To: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
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

On Wed, 16 Nov 2022 16:25:51 -0300
Rafael Mendonca <rafaelmendsr@gmail.com> wrote:

> That happens because enable_eprobe() will eventually trigger the
> kmem/mm_page_alloc trace event:
> 
> - enable_eprobe [trace_eprobe.c]
>   - trace_event_trigger_enable_disable [trace_events_trigger.c]
>     - trace_event_enable_disable [trace_events.c]
>       - __ftrace_event_enable_disable [trace_events.c]
>         - trace_buffered_event_enable [trace.c]
>           - alloc_pages_node [gfp.h]
> 	   ...
>             - __alloc_pages [page_alloc.c]
>               - trace_mm_page_alloc // eprobe event file without TRIGGER_COND bit set
> 
> By the time kmem/mm_page_alloc trace event is hit, the eprobe event file
> does not have the TRIGGER_COND flag set yet, which causes the eprobe's
> trigger to be invoked (through the trace_trigger_soft_disabled() path)
> without a trace record, causing a NULL pointer dereference when fetching
> the event fields.
> 
> Fix this by setting the cond flag beforehand when enabling the eprobe's
> trigger.
> 
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---

Thanks for the report, but I'm worried that this isn't enough because of
how memory ordering can happen on different architectures. That is, just
because you switch the order of updates, doesn't mean that the architecture
will honor it.

I don't want to add memory barriers in the fast path, but instead we can
simply check if rec is NULL in the handler.

So basically:


static void eprobe_trigger_func(struct event_trigger_data *data,
				struct trace_buffer *buffer, void *rec,
				struct ring_buffer_event *rbe)
{
	struct eprobe_data *edata = data->private_data;

	if (!rec)
		return;

	__eprobe_trace_func(edata, rec);
}

And this should be documented.

-- Steve
