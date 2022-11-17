Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD962E71E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKQVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbiKQVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:40:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3276829A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4C162281
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AA6C433D6;
        Thu, 17 Nov 2022 21:40:05 +0000 (UTC)
Date:   Thu, 17 Nov 2022 16:40:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
Message-ID: <20221117164003.6e655615@gandalf.local.home>
In-Reply-To: <20221114022946.66255-1-yangjihong1@huawei.com>
References: <20221114022946.66255-1-yangjihong1@huawei.com>
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

On Mon, 14 Nov 2022 10:29:46 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> print_trace_line may overflow seq_file buffer. If the event is not
> consumed, the while loop keeps peeking this event, causing a infinite loop.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/trace/trace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..2a8d5c68c29b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6788,6 +6788,19 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  		if (ret == TRACE_TYPE_PARTIAL_LINE) {
>  			/* don't print partial lines */
>  			iter->seq.seq.len = save_len;
> +
> +			/*
> +			 * If one trace_line of the tracer overflows seq_file
> +			 * buffer, trace_seq_to_user returns -EBUSY because
> +			 * nothing in the sequence (iter->seq.seq.len = \
> +			 * iter->seq.seq.readpos = 0).
> +			 * In this case, we need to consume, otherwise,
> +			 * "while" will peek this event next time, resulting
> +			 * in an infinite loop.
> +			 */
> +			if (trace_seq_has_overflowed(&iter->seq))
> +				trace_consume(iter);

Instead of consuming it, I think the right solution is to print the partial
line. Something like:

			if (trace_seq_has_overflowed(&iter->seq)) {
				char dots[] = "...";

				iter->seq.seq.len -= sizeof(dots) + 1;
				iter->seq.seq.full = 0;
				trace_seq_puts(&iter->seq, dots);
				trace_consume(iter);
				break;
			}

			iter->seq.seq.len = save_len;
			break;

That way we can see the broken trace event and not just silently drop it.

-- Steve

> +
>  			break;
>  		}
>  		if (ret != TRACE_TYPE_NO_CONSUME)

