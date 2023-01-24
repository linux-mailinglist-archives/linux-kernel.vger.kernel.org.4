Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546767A05A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjAXRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjAXRoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:44:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEB230287;
        Tue, 24 Jan 2023 09:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97A60B81601;
        Tue, 24 Jan 2023 17:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904C3C433EF;
        Tue, 24 Jan 2023 17:44:06 +0000 (UTC)
Date:   Tue, 24 Jan 2023 12:44:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] trace: Add NULL checks for buffer in
 ring_buffer_free_read_page()
Message-ID: <20230124124403.2727b6bf@gandalf.local.home>
In-Reply-To: <20230113125501.760324-1-baijiaju1990@gmail.com>
References: <20230113125501.760324-1-baijiaju1990@gmail.com>
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

On Fri, 13 Jan 2023 20:55:01 +0800
Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> In a previous commit 7433632c9ff6, buffer, buffer->buffers and 
> buffer->buffers[cpu] in ring_buffer_wake_waiters() can be NULL, 
> and thus the related checks are added.
> 
> However, in the same call stack, these variables are also used in
> ring_buffer_free_read_page():
> 
> tracing_buffers_release()
>   ring_buffer_wake_waiters(iter->array_buffer->buffer)
>     cpu_buffer = buffer->buffers[cpu] -> Add checks by previous commit
>   ring_buffer_free_read_page(iter->array_buffer->buffer)
>     cpu_buffer = buffer->buffers[cpu] -> No check
> 
> Thus, to avod possible null-pointer derefernces, the related checks
> should be added.
> 
> These results are reported by a static tool designed by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Although I'm not adverse to this patch (it doesn't hurt), but the code has:

	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);

	if (info->spare)
		ring_buffer_free_read_page(iter->array_buffer->buffer,
					   info->spare_cpu, info->spare);

Where none of those will be NULL if "info->spare" is set.

But as I said, I have no problem applying this, so I will ;-)

-- Steve


> ---
>  kernel/trace/ring_buffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c366a0a9ddba..45d4a23d6044 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5626,11 +5626,16 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
>   */
>  void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data)
>  {
> -	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> +	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct buffer_data_page *bpage = data;
>  	struct page *page = virt_to_page(bpage);
>  	unsigned long flags;
>  
> +	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
> +		return;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
>  	/* If the page is still in use someplace else, we can't reuse it */
>  	if (page_ref_count(page) > 1)
>  		goto out;

