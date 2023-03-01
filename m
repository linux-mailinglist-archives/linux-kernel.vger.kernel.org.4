Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E06A6EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCAOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCAOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:47:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5E43449;
        Wed,  1 Mar 2023 06:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31478B81081;
        Wed,  1 Mar 2023 14:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC27C4339E;
        Wed,  1 Mar 2023 14:46:49 +0000 (UTC)
Date:   Wed, 1 Mar 2023 09:46:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] tracing/ring-buffer: Drop inappropriate WARN in
 rb_set_head_page()
Message-ID: <20230301094646.76dc4056@gandalf.local.home>
In-Reply-To: <20230301034702.3449755-1-zhengyejian1@huawei.com>
References: <20230301034702.3449755-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 11:47:02 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Following WARNING appears several times during test on v5.10 but
> mainline kernel should have the same problem. However I currently
> can't find the reproduction method.
> 
> WARNING: CPU: 29 PID: 686834 at kernel/trace/ring_buffer.c:1357
>            rb_set_head_page+0x168/0x264
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/trace/ring_buffer.c?h=linux-5.10.y#n1357
> Call trace:
>  rb_set_head_page+0x168/0x264
>  rb_per_cpu_empty+0x34/0x15c
>  ring_buffer_empty_cpu.part.0.isra.0+0x1a4/0x3f0
>  ring_buffer_empty_cpu+0x74/0xb4
>  __find_next_entry+0x14c/0x2f4
>  trace_find_next_entry_inc+0x48/0x13c
>  tracing_read_pipe+0x2c8/0x6b4
>  vfs_read+0x144/0x324
>  ksys_read+0x104/0x220
>  __arm64_sys_read+0x54/0x70
>  el0_svc_common.constprop.0+0xd8/0x37c
>  do_el0_svc+0x50/0x120
>  el0_svc+0x24/0x3c
>  el0_sync_handler+0x17c/0x180
>  el0_sync+0x160/0x180
> 
> The WARNING appears because rb_set_head_page() didn't grab the header
> after three loops traversing buffer pages. This was not considered
> to be expected, as comment said, writer possibly moves the header in
> one loop.
> 
> However, supposing writer keeps moving the header, we may miss more
> loops and it seems normal not to grab the header within three loops
> in rb_set_head_page(). Therefore drop that RB_WARN_ON().

It's normal to grab the header in two loops. I only made it three in case I
was wrong. If it took 4 tries, something is wrong. Just returning NULL
without setting the header will cause bugs elsewhere.

-- Steve


> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ring_buffer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index af50d931b020..cbfa306570d3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1471,9 +1471,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	page = head = cpu_buffer->head_page;
>  	/*
>  	 * It is possible that the writer moves the header behind
> -	 * where we started, and we miss in one loop.
> -	 * A second loop should grab the header, but we'll do
> -	 * three loops just because I'm paranoid.
> +	 * where we started, so we try three loops to grab the header.
>  	 */
>  	for (i = 0; i < 3; i++) {
>  		do {
> @@ -1485,8 +1483,6 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
>  		} while (page != head);
>  	}
>  
> -	RB_WARN_ON(cpu_buffer, 1);
> -
>  	return NULL;
>  }
>  

