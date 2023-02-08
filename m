Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B780D68FA4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBHWgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:36:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E2869B;
        Wed,  8 Feb 2023 14:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B66B617E2;
        Wed,  8 Feb 2023 22:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16696C433EF;
        Wed,  8 Feb 2023 22:36:02 +0000 (UTC)
Date:   Wed, 8 Feb 2023 17:36:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: Re: [PATCH] tracing/ring-buffer: Remove integrity check at end of
 iter read
Message-ID: <20230208173601.710888d3@gandalf.local.home>
In-Reply-To: <20230208090814.869242-1-zhengyejian1@huawei.com>
References: <20230208090814.869242-1-zhengyejian1@huawei.com>
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

On Wed, 8 Feb 2023 17:08:14 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Concurrently closing "trace" file and writing into ring buffer [1] can
> cause WARNINGs [2]. It has been reported in
> Link: https://lore.kernel.org/all/20230203035608.2336906-1-zhengyejian1@huawei.com/
> 
> It seems a data race between ring_buffer writing and integrity check.
> That is, RB_FLAG of head_page is been updating, while at same time RB_FLAG
> was cleared when doing integrity check:
>   rb_check_pages()            rb_handle_head_page():
>   --------                    --------
>   rb_head_page_deactivate()
>                               rb_head_page_set_normal()
>   rb_head_page_activate()
> 

Good catch!

> Integrity check at end of iter read was added since commit 659f451ff213
> ("ring-buffer: Add integrity check at end of iter read"). As it's commit
> message said:
>   > As reading via an iterator requires disabling the ring buffer, it
>   > is a perfect place to have it.  
> However, since commit 1039221cc278 ("ring-buffer: Do not disable recording
> when there is an iterator"), ring buffer was not disabled at that place,
> so that integrity check should be removed.
> 
> 1:
> ``` read_trace.sh
>   while true;
>   do
>     # the "trace" file is closed after read
>     head -1 /sys/kernel/tracing/trace > /dev/null
>   done
> ```
> ``` repro.sh
>   sysctl -w kernel.panic_on_warn=1
>   # function tracer will writing enough data into ring_buffer
>   echo function > /sys/kernel/tracing/current_tracer
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
>   ./read_trace.sh &
> ```
> 


> Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ring_buffer.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c366a0a9ddba..34e955bd1e59 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5203,17 +5203,6 @@ void
>  ring_buffer_read_finish(struct ring_buffer_iter *iter)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
> -	unsigned long flags;
> -
> -	/*
> -	 * Ring buffer is disabled from recording, here's a good place
> -	 * to check the integrity of the ring buffer.
> -	 * Must prevent readers from trying to read, as the check
> -	 * clears the HEAD page and readers require it.
> -	 */
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -	rb_check_pages(cpu_buffer);
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);

I would rather find a way to make this still work than just removing it.

Perhaps there's no reason to clear the flags, and change rb_check_pages()
to mask them out before testing. Something like:

static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
{
	struct list_head *head = cpu_buffer->pages;
	struct buffer_page *bpage, *tmp;

	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->next)->prev) != head))
		return -1;
	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->prev)->next) != head))
		return -1;

	if (rb_check_list(cpu_buffer, head))
		return -1;

	list_for_each_entry_safe(bpage, tmp, head, list) {
		if (RB_WARN_ON(cpu_buffer,
		     rb_list_head(rb_list_head(bpage->list.next)->prev) != &bpage->list))
			return -1;
		if (RB_WARN_ON(cpu_buffer,
		     rb_list_head(rb_list_head(bpage->list.prev)->next) != &bpage->list))
			return -1;
		if (rb_check_list(cpu_buffer, &bpage->list))
			return -1;
	}

	return 0;
}

I haven't tested the above.

?

-- Steve


>  
>  	atomic_dec(&cpu_buffer->resize_disabled);
>  	kfree(iter->event);

