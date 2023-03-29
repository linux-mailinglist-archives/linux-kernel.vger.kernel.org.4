Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647C76CEF02
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC2QPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjC2QPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:15:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759F59DB;
        Wed, 29 Mar 2023 09:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28411CE2148;
        Wed, 29 Mar 2023 16:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E992CC433EF;
        Wed, 29 Mar 2023 16:15:31 +0000 (UTC)
Date:   Wed, 29 Mar 2023 12:15:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V2 1/2] tracing/timerlat: Notify new max thread latency
Message-ID: <20230329121530.08b05132@gandalf.local.home>
In-Reply-To: <16e18d61d69073d0192ace07bf61e405cca96e9c.1680104184.git.bristot@kernel.org>
References: <16e18d61d69073d0192ace07bf61e405cca96e9c.1680104184.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 17:50:15 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> timerlat is not reporting a new tracing_max_latency for the thread
> latency. The reason is that it is not calling notify_new_max_latency()
> function after the new thread latency is sampled.
> 
> Call notify_new_max_latency after computing the thread latency.
> 
> Changes from V1:
>  Split the patch into two patches (Steve)

FYI, when doing this, please place the updates below the "---"

That way it doesn't automatically end up in the git log, and I have to go
back in and remove it.

> 
> Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---

Here, you can add:

Changes from V1: https://lore.kernel.org/linux-trace-kernel/c22302a7db3cee6bcabf87462ed22a35dd38690f.1679675521.git.bristot@kernel.org/
  Split the patch into two patches (Steve)

Notice, that I also added the link to the previous version, so it's easy to
find if someone wanted to investigate this series.

-- Steve



>  kernel/trace/trace_osnoise.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 9176bb7a9bb4..e8116094bed8 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
>  
>  		trace_timerlat_sample(&s);
>  
> +		notify_new_max_latency(diff);
> +
>  		timerlat_dump_stack(time_to_us(diff));
>  
>  		tlat->tracing_thread = false;

