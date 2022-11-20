Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE86315E1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKTTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:38:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177221245
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 11:38:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24DDEB80B4D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CEC433D6;
        Sun, 20 Nov 2022 19:38:54 +0000 (UTC)
Date:   Sun, 20 Nov 2022 14:38:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
Message-ID: <20221120143852.7e84b50d@rorschach.local.home>
In-Reply-To: <20221118102521.62362-1-yangjihong1@huawei.com>
References: <20221118102521.62362-1-yangjihong1@huawei.com>
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

On Fri, 18 Nov 2022 18:25:21 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> print_trace_line may overflow seq_file buffer. If the event is not
> consumed, the while loop keeps peeking this event, causing a infinite loop.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>   - Print partial line to show the broken trace event when overflowed print_trace_line
> 
>  kernel/trace/trace.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..81c36dc80212 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6786,7 +6786,32 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  
>  		ret = print_trace_line(iter);
>  		if (ret == TRACE_TYPE_PARTIAL_LINE) {
> -			/* don't print partial lines */
> +			/*
> +			 * If one trace_line of the tracer overflows seq_file
> +			 * buffer, trace_seq_to_user returns -EBUSY.
> +			 * In this case, we need to consume, otherwise,
> +			 * while loop will peek this event next time,
> +			 * resulting in an infinite loop.
> +			 */
> +			if (trace_seq_has_overflowed(&iter->seq)) {

We need to only do this if save_len is zero. Because the reason that it
returns TRACE_TYPE_PARTIAL_LINE is usually because it overflowed.

This loops until the trace_seq is full, so it's OK to have it overflow.
The case I believe you are fixing, is the case were one
print_trace_line() actually fills the entire trace_seq in one shot. In
which case, it will never print, and in that case, save_len will be zero.

-- Steve


> +				/*
> +				 * Print the partial line,
> +				 * that way we can see the broken trace event.
> +				 */
> +				char dots[] = "...\n";
> +
> +				iter->seq.full = 0;
> +				if (seq_buf_buffer_left(&iter->seq.seq) < strlen(dots)) {
> +					iter->seq.seq.len =
> +						seq_buf_used(&iter->seq.seq) - strlen(dots);
> +				}
> +				trace_seq_puts(&iter->seq, dots);
> +
> +				trace_consume(iter);
> +				break;
> +			}
> +
> +			/* In other cases, don't print partial lines */
>  			iter->seq.seq.len = save_len;
>  			break;
>  		}

