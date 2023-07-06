Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1548274A1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGFQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGFQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C09D;
        Thu,  6 Jul 2023 09:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2448660DD4;
        Thu,  6 Jul 2023 16:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2080C433C7;
        Thu,  6 Jul 2023 16:00:41 +0000 (UTC)
Date:   Thu, 6 Jul 2023 12:00:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/trace: Fix cleanup logic of
 enable_trace_eprobe
Message-ID: <20230706120040.26a685cd@gandalf.local.home>
In-Reply-To: <20230703042853.1427493-1-tz.stoyanov@gmail.com>
References: <20230703042853.1427493-1-tz.stoyanov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jul 2023 07:28:53 +0300
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> The enable_trace_eprobe() function enables all event probes, attached
> to given trace probe. If an error occurs in enabling one of the event
> probes, all others should be roll backed. There is a bug in that roll
> back logic - instead of all event probes, only the failed one is
> disabled.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Tzvetomir!

-- Steve

> ---
> Changes since v1: https://lore.kernel.org/all/20230628121811.338655-1-tz.stoyanov@gmail.com/
>  - Added one-time warning, suggested by Steven Rostedt.
> Changed since v2: https://lore.kernel.org/lkml/20230630121627.833560-1-tz.stoyanov@gmail.com/
>  - Added counter of successfully enabled eprobes, suggested by Steven Rostedt.
> 
>  kernel/trace/trace_eprobe.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index cb0077ba2b49..a0a704ba27db 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -644,6 +644,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  	struct trace_eprobe *ep;
>  	bool enabled;
>  	int ret = 0;
> +	int cnt = 0;
>  
>  	tp = trace_probe_primary_from_call(call);
>  	if (WARN_ON_ONCE(!tp))
> @@ -667,12 +668,25 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  		if (ret)
>  			break;
>  		enabled = true;
> +		cnt++;
>  	}
>  
>  	if (ret) {
>  		/* Failed to enable one of them. Roll back all */
> -		if (enabled)
> -			disable_eprobe(ep, file->tr);
> +		if (enabled) {
> +			/*
> +			 * It's a bug if one failed for something other than memory
> +			 * not being available but another eprobe succeeded.
> +			 */
> +			WARN_ON_ONCE(ret != -ENOMEM);
> +
> +			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +				ep = container_of(pos, struct trace_eprobe, tp);
> +				disable_eprobe(ep, file->tr);
> +				if (!--cnt)
> +					break;
> +			}
> +		}
>  		if (file)
>  			trace_probe_remove_file(tp, file);
>  		else

