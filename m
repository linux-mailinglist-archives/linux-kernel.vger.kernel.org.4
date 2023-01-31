Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF868319E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjAaPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAaPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:36:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9136B4DCCA;
        Tue, 31 Jan 2023 07:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFDE3B81D6C;
        Tue, 31 Jan 2023 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2283FC433D2;
        Tue, 31 Jan 2023 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675179396;
        bh=QH4sAw+QrLozn4NsAExFtDNNpxCjPzE+cVXH25vlvbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PftTUX1KsnzRuJFutnCWxI8tixzL1lMTIWfWt2UECOjfKQJPH7t4OazUS3hpqCGrV
         CHOTnmysnGtcBxWomu7Pw3wekr8XQdNCos2cyvb9hM31DipHiO0Zwglx+CuQ6A+ide
         vsjOCiXMzRhFu2LCtuyvC9Ak6D74Bw3JBKR8VphAtG8DEY2y6i5+Rb5hZqnOfI1F7m
         8tVqsSo55Bo74wxldxQX3tCh+cy55kTa3VjZi0cHz98TZri0vr2Li5e1LPmn2zJRFH
         ufdth9PiOzCT7zE3qzD3dDg71jKD259OQTgXZSctPja+098rkgBx8oisBjunLI6a9Z
         vrZEvsQlcZ/pg==
Date:   Wed, 1 Feb 2023 00:36:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing: Fix trace_event_raw_event_synth() if else
 statement
Message-Id: <20230201003633.8db1a08b508a2203d69fa918@kernel.org>
In-Reply-To: <20230131095237.63e3ca8d@gandalf.local.home>
References: <20230131095237.63e3ca8d@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 09:52:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The test to check if the field is a stack is to be done if it is not a
> string. But the code had:
> 
>     } if (event->fields[i]->is_stack) {
> 
> and not
> 
>    } else if (event->fields[i]->is_stack) {
> 
> which would cause it to always be tested. Worse yet, this also included an
> "else" statement that was only to be called if the field was not a string
> and a stack, but this code allows it to be called if it was a string (and
> not a stack).
> 
> Also fixed some whitespace issues.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Hmm, I need to add more tests for syntax events...

Thanks!


> Link: https://lore.kernel.org/all/202301302110.mEtNwkBD-lkp@intel.com/
> 
> Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_synth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index adb630633f31..306c89e0ce55 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -564,8 +564,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
>  					   event->fields[i]->is_dynamic,
>  					   data_size, &n_u64);
>  			data_size += len; /* only dynamic string increments */
> -		} if (event->fields[i]->is_stack) {
> -		        long *stack = (long *)(long)var_ref_vals[val_idx];
> +		} else if (event->fields[i]->is_stack) {
> +			long *stack = (long *)(long)var_ref_vals[val_idx];
>  
>  			len = trace_stack(entry, event, stack,
>  					   data_size, &n_u64);
> -- 
> 2.39.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
