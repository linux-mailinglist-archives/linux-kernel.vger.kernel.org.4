Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529CE63AE12
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiK1QqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK1QqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:46:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BA1AD94
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8876126D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F42C433C1;
        Mon, 28 Nov 2022 16:46:15 +0000 (UTC)
Date:   Mon, 28 Nov 2022 11:46:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
Message-ID: <20221128114613.1c664e81@gandalf.local.home>
In-Reply-To: <20221124125850.155449-1-yangjihong1@huawei.com>
References: <20221124125850.155449-1-yangjihong1@huawei.com>
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

On Thu, 24 Nov 2022 20:58:50 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> print_trace_line may overflow seq_file buffer. If the event is not
> consumed, the while loop keeps peeking this event, causing a infinite loop.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/trace/trace.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a7fe0e115272..55733224fa88 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6787,7 +6787,27 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  
>  		ret = print_trace_line(iter);
>  		if (ret == TRACE_TYPE_PARTIAL_LINE) {
> -			/* don't print partial lines */
> +			/*
> +			 * If one trace_line of the tracer overflows seq_file
> +			 * buffer, trace_seq_to_user returns -EBUSY.
> +			 * In this case, we need to consume it, otherwise,
> +			 * while loop will peek this event next time,
> +			 * resulting in an infinite loop.
> +			 */
> +			if (trace_seq_has_overflowed(&iter->seq)) {

The only way to get here is if the above is true, and that is not going to
cause the infinite loop. What does is if save_len == 0. In fact, that's
all you need to check for:

			if (save_len == 0) {

Should do the trick.

-- Steve



> +				/*
> +				 * Here we only consider the case that one
> +				 * print_trace_line() fills the entire trace_seq
> +				 * in one shot, in that case, iter->seq.seq.len is zero,
> +				 * we simply output a log of too long line to inform the user.
> +				 */
> +				iter->seq.full = 0;
> +				trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
> +				trace_consume(iter);
> +				break;
> +			}
> +
> +			/* In other cases, don't print partial lines */
>  			iter->seq.seq.len = save_len;
>  			break;
>  		}

