Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7C64C0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiLMXuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiLMXuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:50:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344622636;
        Tue, 13 Dec 2022 15:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C2EB811FF;
        Tue, 13 Dec 2022 23:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E28EC433EF;
        Tue, 13 Dec 2022 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670975397;
        bh=kLBo0KHQrLyd29Ix59u6434teLEhcjNUfyC6w2bJk6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7vBYbnyp3mjW7ZXEp4kiDEA8RbfSYiWRbTccFe+szrUGhEvtVsr14yAD2SgIUmkg
         fEpy8t8rCcMZ7HVXaB9rh0OMtrN2/pTDMnUVJooYrEWIQGyf04ivBcR0neGjAnWiQB
         tpR/v4ettfsmRN/EWBnwWlO+XwhlQBReluZV43m9CXcmkkrBC7ksvBCWMaMgOMAeow
         AbsBlleMLG7t6jWlTAO+gfcB6oIH4QaMpwpbr0PpLqZ6FqK3p4AgPpZAFuPk0UURkF
         4zivL+YRd1VGnH/9vM2062zg94jXDDSo0Bz7qALMksmDmEZibZSbehIBT9FI/MT1MO
         sqwRytR8Xgl6w==
Date:   Wed, 14 Dec 2022 08:49:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-Id: <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
In-Reply-To: <20221213172429.7774f4ba@gandalf.local.home>
References: <20221213172429.7774f4ba@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 17:24:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If a trigger filter on the kernel command line fails to apply (due to
> syntax error), it will be freed. The freeing will call
> tracepoint_synchronize_unregister(), but this is not needed during early
> boot up, and will even trigger a lockdep splat.
> 
> Avoid calling the synchronization function when system_state is
> SYSTEM_BOOTING.

Shouldn't this be done inside tracepoint_synchronize_unregister()?
Then, it will prevent similar warnings if we expand boot time feature.

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 19ce9d22bfd7..e535959939d3 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1085,8 +1085,14 @@ int set_trigger_filter(char *filter_str,
>  	rcu_assign_pointer(data->filter, filter);
>  
>  	if (tmp) {
> -		/* Make sure the call is done with the filter */
> -		tracepoint_synchronize_unregister();
> +		/*
> +		 * Make sure the call is done with the filter.
> +		 * It is possible that a filter could fail at boot up,
> +		 * and then this path will be called. Avoid the synchronization
> +		 * in that case.
> +		 */
> +		if (system_state != SYSTEM_BOOTING)
> +			tracepoint_synchronize_unregister();
>  		free_event_filter(tmp);
>  	}
>  
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
