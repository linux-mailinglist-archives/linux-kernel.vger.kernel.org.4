Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CA6EE8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjDYUVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjDYUVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCEE1545E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F7B6146C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556EAC4339C;
        Tue, 25 Apr 2023 20:21:06 +0000 (UTC)
Date:   Tue, 25 Apr 2023 16:21:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ken Lin <lyenting@google.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add missing spaces in trace_print_hex_seq()
Message-ID: <20230425162104.42cf708f@gandalf.local.home>
In-Reply-To: <CAB9LMUQ2BT0JQkaZOSWGKRE1zzm5w2aio_phuAhQsD3xSgJuZw@mail.gmail.com>
References: <CAB9LMUQ2BT0JQkaZOSWGKRE1zzm5w2aio_phuAhQsD3xSgJuZw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 10:13:29 +0800
Ken Lin <lyenting@google.com> wrote:

> If the buffer length is larger than 16 and concatenate is set to false,
> there would be missing spaces every 16 bytes.
> Example:
>   Before: c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 4000 40 00
>   After:  c5 11 10 50 05 4d 31 40 00 40 00 40 00 4d 31 40 00 40 00
> 

This version of the patch has whitespace issues and sent as HTML. Please
fix.

Also, the subject needs to follow proper formatting:

  tracing: Add missing spaces in trace_print_hex_seq()

And please also Cc: linux-trace-kernel@vger.kernel.org.

Thanks,

-- Steve

> Signed-off-by: Ken Lin <lyenting@google.com>
> ---
>  kernel/trace/trace_output.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index bd475a00f96d..6e45cf18d816 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -221,8 +221,11 @@ trace_print_hex_seq(struct trace_seq *p, const
> unsigned char *buf, int buf_len,
>         const char *ret = trace_seq_buffer_ptr(p);
>         const char *fmt = concatenate ? "%*phN" : "%*ph";
> 
> -       for (i = 0; i < buf_len; i += 16)
> +       for (i = 0; i < buf_len; i += 16) {
> +               if (!concatenate && i != 0)
> +                       trace_seq_putc(p, ' ');
>                 trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);
> +       }
>         trace_seq_putc(p, 0);
> 
>         return ret;
> --
> 2.40.0.rc1.284.g88254d51c5-goog

