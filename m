Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4660BB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiJXUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiJXUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AD24F05;
        Mon, 24 Oct 2022 11:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DDC61313;
        Mon, 24 Oct 2022 13:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FDC433D6;
        Mon, 24 Oct 2022 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666617212;
        bh=ohNOY7PVOk8diau+BBLDCln6tx4VXrKTyd2bspxgGMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDsoR2cZ+9A+NaCG7Hd2CADTcqiWzPKpjvCiqVXBPt0QUTJfOG+UQ2YII4pKnoFeq
         1Yo8WmeGDLV/9RjjQStrVsDAVGXxVHW3Tiucd7l/3mv27Lko3L+4Y74k9SieISd538
         WMXrILYMl0DB12ckL38SE56zaB2VFOMdwpo7eweARW7vCtwg6z0QxtZ/3DEZ2I7IEU
         H5O2j0TdcHIOF6ApUMpfdjF0aJHzKRQoJnsz4x4q8ZH85qpWZds8Ep4oR0clnJZfnd
         I3BqKjiE3i0PWxihE8r0rODo3/IchbTCV7neosqFxT3JtKVDqo91Ta4gxRS+dZfVbk
         NYUABC82Uk6hw==
Date:   Mon, 24 Oct 2022 22:13:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ring-buffer: Include dropped pages in counting dirty
 patches
Message-Id: <20221024221328.91994cb956fcb7effcbdb97d@kernel.org>
In-Reply-To: <20221021123013.55fb6055@gandalf.local.home>
References: <20221021123013.55fb6055@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 12:30:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function ring_buffer_nr_dirty_pages() was created to find out how many
> pages are filled in the ring buffer. There's two running counters. One is
> incremented whenever a new page is touched (pages_touched) and the other
> is whenever a page is read (pages_read). The dirty count is the number
> touched minus the number read. This is used to determine if a blocked task
> should be woken up if the percentage of the ring buffer it is waiting for
> is hit.
> 
> The problem is that it does not take into account dropped pages (when the
> new writes overwrite pages that were not read). And then the dirty pages
> will always be greater than the percentage.
> 
> Add a new counter to keep track of lost pages, and include that in the
> accounting of dirty pages so that it is actually accurate.
> 
> Fixes: 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me. But I have just a nitpick below.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> ---
>  kernel/trace/ring_buffer.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b60047de897e..f712006f6dd3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -519,6 +519,7 @@ struct ring_buffer_per_cpu {
>  	local_t				committing;
>  	local_t				commits;
>  	local_t				pages_touched;
> +	local_t				pages_lost;
>  	local_t				pages_read;
>  	long				last_pages_touch;
>  	size_t				shortest_full;
> @@ -894,10 +895,18 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
>  size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu)
>  {
>  	size_t read;
> +	size_t lost;
>  	size_t cnt;
>  
>  	read = local_read(&buffer->buffers[cpu]->pages_read);
> +	lost = local_read(&buffer->buffers[cpu]->pages_lost);
>  	cnt = local_read(&buffer->buffers[cpu]->pages_touched);
> +
> +	if (WARN_ON_ONCE(cnt < lost))
> +		return 0;
> +
> +	cnt -= lost;
> +
>  	/* The reader can read an empty page, but not more than that */
>  	if (cnt < read) {
>  		WARN_ON_ONCE(read > cnt + 1);
> @@ -2020,6 +2029,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>  			 */
>  			local_add(page_entries, &cpu_buffer->overrun);
>  			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
> +			local_inc(&cpu_buffer->pages_lost);

Maybe we can make this part a static helper function so that we don't
repeat it below?

>  		}
>  
>  		/*
> @@ -2504,6 +2514,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
>  		 */
>  		local_add(entries, &cpu_buffer->overrun);
>  		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
> +		local_inc(&cpu_buffer->pages_lost);

Thanks,

>  
>  		/*
>  		 * The entries will be zeroed out when we move the
> @@ -5254,6 +5265,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  	local_set(&cpu_buffer->committing, 0);
>  	local_set(&cpu_buffer->commits, 0);
>  	local_set(&cpu_buffer->pages_touched, 0);
> +	local_set(&cpu_buffer->pages_lost, 0);
>  	local_set(&cpu_buffer->pages_read, 0);
>  	cpu_buffer->last_pages_touch = 0;
>  	cpu_buffer->shortest_full = 0;
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
