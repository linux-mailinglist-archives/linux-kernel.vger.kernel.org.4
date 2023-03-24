Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962D76C85E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjCXTYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjCXTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:24:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319711E95;
        Fri, 24 Mar 2023 12:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF67B82546;
        Fri, 24 Mar 2023 19:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B677BC433D2;
        Fri, 24 Mar 2023 19:23:12 +0000 (UTC)
Date:   Fri, 24 Mar 2023 15:23:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Fix race while reader and writer are on
 the same page
Message-ID: <20230324152309.134f361a@gandalf.local.home>
In-Reply-To: <20230324125037.2719020-1-zhengyejian1@huawei.com>
References: <20230324125037.2719020-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 20:50:37 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Fixes: 77ae365eca89 ("ring-buffer: make lockless")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ring_buffer.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c6f47b6cfd5f..79fd5e10ee05 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2942,6 +2942,13 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
>  		event->array[0] = length;
>  	} else
>  		event->type_len = DIV_ROUND_UP(length, RB_ALIGNMENT);
> +
> +	/*
> +	 * The 'event' may be reserved from the page which is reading
> +	 * by reader, make sure 'event' is completely updated before
> +	 * reader_page->page->commit being set.
> +	 */
> +	smp_wmb();

This isn't the place to put this. We only care before the commit is
updated, not at *ever* update to the event (this can be called several
times before a commit).

If we need to add a smp_wmb() it's best to be in rb_set_commit_to_write()

>  }
>  
>  static unsigned rb_calculate_event_length(unsigned length)
> @@ -4684,7 +4691,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	/*
>  	 * Make sure we see any padding after the write update
> -	 * (see rb_reset_tail())
> +	 * (see rb_reset_tail()).
> +	 *
> +	 * In addition, writer may be writing on the reader page
> +	 * if the page has not been fully filled, so the read barrier
> +	 * is also needed to make sure we see the completely updated
> +	 * event that reserved by writer (see rb_update_event()).
>  	 */
>  	smp_rmb();
>  

I think we want this instead:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2d5c3caff32d..22d05cd04a3a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3092,6 +3092,10 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		if (RB_WARN_ON(cpu_buffer,
 			       rb_is_reader_page(cpu_buffer->tail_page)))
 			return;
+		/*
+		 * No need for a memory barrier here, as the update
+		 * of the tail_page did it for this page.
+		 */
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(&cpu_buffer->commit_page);
@@ -3101,6 +3105,8 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 	while (rb_commit_index(cpu_buffer) !=
 	       rb_page_write(cpu_buffer->commit_page)) {
 
+		/* Make sure the readers see the content of what is committed. */
+		smp_wmb();
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		RB_WARN_ON(cpu_buffer,
@@ -4676,7 +4682,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/*
 	 * Make sure we see any padding after the write update
-	 * (see rb_reset_tail())
+	 * (see rb_reset_tail()).
+	 *
+	 * In addition, a writer may be writing on the reader page
+	 * if the page has not been fully filled, so the read barrier
+	 * is also needed to make sure we see the completely updated
+	 * event reserved by the writer (see rb_tail_page_update()).
 	 */
 	smp_rmb();
 
