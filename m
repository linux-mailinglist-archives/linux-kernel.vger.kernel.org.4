Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197DC6A61B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1Vpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjB1VpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:45:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D40367FC;
        Tue, 28 Feb 2023 13:44:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB04B80E1C;
        Tue, 28 Feb 2023 21:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03331C433D2;
        Tue, 28 Feb 2023 21:43:47 +0000 (UTC)
Date:   Tue, 28 Feb 2023 16:43:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Message-ID: <20230228164346.0691bb11@gandalf.local.home>
In-Reply-To: <20230228175929.7534-4-ubizjak@gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-4-ubizjak@gmail.com>
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

On Tue, 28 Feb 2023 18:59:29 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
> x86 CMPXCHG instruction returns success in ZF flag, so this change
> saves a compare after cmpxchg (and related move instruction in
> front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
> 
> No functional change intended.

As I mentioned in the RCU thread, I have issues with some of the changes
here.

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 4188af7d4cfe..8f0ef7d12ddd 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1493,14 +1493,11 @@ static bool rb_head_page_replace(struct buffer_page *old,
>  {
>  	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
>  	unsigned long val;
> -	unsigned long ret;
>  
>  	val = *ptr & ~RB_FLAG_MASK;
>  	val |= RB_PAGE_HEAD;
>  
> -	ret = cmpxchg(ptr, val, (unsigned long)&new->list);
> -
> -	return ret == val;
> +	return try_cmpxchg(ptr, &val, (unsigned long)&new->list);

No, val should not be updated.

>  }
>  
>  /*
> @@ -2055,7 +2052,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  	retries = 10;
>  	success = false;
>  	while (retries--) {
> -		struct list_head *head_page, *prev_page, *r;
> +		struct list_head *head_page, *prev_page;
>  		struct list_head *last_page, *first_page;
>  		struct list_head *head_page_with_bit;
>  
> @@ -2073,9 +2070,8 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  		last_page->next = head_page_with_bit;
>  		first_page->prev = prev_page;
>  
> -		r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
> -
> -		if (r == head_page_with_bit) {
> +		if (try_cmpxchg(&prev_page->next,
> +				&head_page_with_bit, first_page)) {

No. head_page_with_bit should not be updated.

>  			/*
>  			 * yay, we replaced the page pointer to our new list,
>  			 * now, we just have to update to head page's prev
> @@ -4061,10 +4057,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
>  	unsigned int rd;
>  	unsigned int new_rd;
>  
> +	rd = atomic_read(&buffer->record_disabled);
>  	do {
> -		rd = atomic_read(&buffer->record_disabled);
>  		new_rd = rd | RB_BUFFER_OFF;
> -	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
> +	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));

This change is OK.

>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_record_off);
>  
> @@ -4084,10 +4080,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
>  	unsigned int rd;
>  	unsigned int new_rd;
>  
> +	rd = atomic_read(&buffer->record_disabled);
>  	do {
> -		rd = atomic_read(&buffer->record_disabled);
>  		new_rd = rd & ~RB_BUFFER_OFF;
> -	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
> +	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));

And so is this one.

So I will not take this patch as is.

-- Steve

>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_record_on);
>  

