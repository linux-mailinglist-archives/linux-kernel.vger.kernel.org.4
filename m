Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266DD602DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiJRN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJRN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332F15FC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA27AB81F67
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB2C433B5;
        Tue, 18 Oct 2022 13:59:31 +0000 (UTC)
Date:   Tue, 18 Oct 2022 09:59:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        xiehuan09@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace/kprobe: remove duplicated call of
 ring_buffer_event_data
Message-ID: <20221018095932.7b955e96@gandalf.local.home>
In-Reply-To: <1666077186-6042-1-git-send-email-chensong_2000@189.cn>
References: <1666077186-6042-1-git-send-email-chensong_2000@189.cn>
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


[ Added Masami who's the new co-maintainer, and this is his code ]

On Tue, 18 Oct 2022 15:13:06 +0800
Song Chen <chensong_2000@189.cn> wrote:

> Function __kprobe_trace_func calls ring_buffer_event_data to get
> a ring buffer, however, it has been done in above call
> trace_event_buffer_reserve.
> 
> So remove one of them.
> 

May as well add:

Fixes: 5e6cd84e2f8bd ("tracing/kprobes: Do not open code event reserve logic")

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  kernel/trace/trace_kprobe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 23f7f0ec4f4c..dfd5809a4a65 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1394,7 +1394,6 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
>  		return;
>  
>  	fbuffer.regs = regs;
> -	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
>  	entry->ip = (unsigned long)tk->rp.kp.addr;
>  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
>  

