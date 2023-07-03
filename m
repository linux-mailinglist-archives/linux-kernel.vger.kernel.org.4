Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D7D745785
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGCIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGCIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E3B6;
        Mon,  3 Jul 2023 01:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7D260DFC;
        Mon,  3 Jul 2023 08:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9C9C433C8;
        Mon,  3 Jul 2023 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688373678;
        bh=d5tEEoXis+6rNIIz2nfMllrQPz1AqmYDceP1A2JH4Cg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TnlwvVial1YwcI5iiIAKpYUZnDLCAyvnhnQqg3Slu0ti/JklkdeUar2hHbB4ZEvf/
         kzhTy9CXSkl2s3q8qcnYhCif3SCjPYwX+Pqs5ZqBGMizJ/xxW8LkpDFqWbdEBqu0F6
         c1Mz6BUeF86H/uoGlaLhdBzuvy7pth9eX5jdgl2UosPywmW9EtfygOrrtOCLkncPxK
         yLbQSJDGaaa/IM3zn6NAYHDZ3N48e660yg+qFIZOo5Pm40yCpo5cZM9QCfJcW1OM8t
         2leJqaa4LsVwAqgKUPA5z8e2uPBxmFdVDxunQ/XUYnLToqCx+f9y0rX8SnMfteln2O
         Z/4zYKhhsapkw==
Date:   Mon, 3 Jul 2023 17:41:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/trace: Fix cleanup logic of
 enable_trace_eprobe
Message-Id: <20230703174114.dd2a7c53b35ab4c3e25a4366@kernel.org>
In-Reply-To: <20230703042853.1427493-1-tz.stoyanov@gmail.com>
References: <20230703042853.1427493-1-tz.stoyanov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
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
> -- 
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
