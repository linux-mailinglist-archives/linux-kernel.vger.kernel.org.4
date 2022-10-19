Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719F6047BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJSNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiJSNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAA18D82E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47B1FB823B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37603C433D6;
        Wed, 19 Oct 2022 13:30:21 +0000 (UTC)
Date:   Wed, 19 Oct 2022 09:30:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, xiehuan09@gmail.com
Subject: Re: [PATCH v2] trace/kprobe: remove duplicated calls of
 ring_buffer_event_data
Message-ID: <20221019093022.7ef5a0de@gandalf.local.home>
In-Reply-To: <1666145478-4706-1-git-send-email-chensong_2000@189.cn>
References: <1666145478-4706-1-git-send-email-chensong_2000@189.cn>
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

On Wed, 19 Oct 2022 10:11:18 +0800
Song Chen <chensong_2000@189.cn> wrote:

> Function __kprobe_trace_func calls ring_buffer_event_data to
> get a ring buffer, however, it has been done in above call
> trace_event_buffer_reserve. So does __kretprobe_trace_func.
> 
> This patch removes those duplicated calls.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Masami, want to take this one?

-- Steve

> ---
>  kernel/trace/trace_kprobe.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 23f7f0ec4f4c..f905829b856b 100644
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
> @@ -1435,7 +1434,6 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
>  		return;
>  
>  	fbuffer.regs = regs;
> -	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
>  	entry->func = (unsigned long)tk->rp.kp.addr;
>  	entry->ret_ip = get_kretprobe_retaddr(ri);
>  	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);

