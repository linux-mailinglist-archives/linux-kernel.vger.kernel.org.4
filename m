Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48396694B03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBMPYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBMPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:24:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD1558E;
        Mon, 13 Feb 2023 07:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726D96117A;
        Mon, 13 Feb 2023 15:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4B2C433D2;
        Mon, 13 Feb 2023 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676301861;
        bh=U7/h4PcTTuCP83D457yoOt5YF99KmnT1gMD+1Gv9zu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WSeKozxjmCZSrIOiZjQSNIY7gNPXnrv+gAWu8A67aNA1zez2cpOQx6cIg0D3AIlSH
         nQlvKfiVfnSsYaHZdVUd0fSiWCXsr51Al0KcqqkrXlow9DNJ5PhrFdrV/zI/SLrJHw
         hXYAlsBbwEP+PdRZUM15/MWobMl6JVjUpCCNXtiQTuyNt+ogVYw2xdiLhf0wB04ZO5
         tHLBpw8/dFOAbWoOzm4M+2oLZIZuMc/mBun77faH6TOrRY8K5rqJxzfgSe6VSvj+NX
         c6Njr5wlmD9YUebD4aq/Q3KywBT3VsDysa3EFDudMsHufUvCqsEWR9wN8gpd4y0yfI
         rnD1ub70DGIhg==
Date:   Tue, 14 Feb 2023 00:24:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        akpm@linux-foundation.org, zwisler@google.com,
        chinglinyu@google.com
Subject: Re: [PATCH 1/4] tracing/histogram: Don't use strlen to find length
 of stacktrace variables
Message-Id: <20230214002418.0103b9e765d3e5c374d2aa7d@kernel.org>
In-Reply-To: <1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org>
References: <cover.1676063532.git.zanussi@kernel.org>
        <1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 15:33:03 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Because stacktraces are saved in dynamic strings,
> trace_event_raw_event_synth() uses strlen to determine the length of
> the stack.  Stacktraces may contain 0-bytes, though, in the saved
> addresses, so the length found and passed to reserve() will be too
> small.

Good catch!

> 
> Fix this by using the first unsigned long in the stack variables to
> store the actual number of elements in the stack and have
> trace_event_raw_event_synth() use that to determine the length of the
> stack.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_hist.c  | 12 ++++++++----
>  kernel/trace/trace_events_synth.c |  7 ++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 888b7a394ce5..76bd105988c6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3135,13 +3135,15 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
>  				size = min(val->size, STR_VAR_LEN_MAX);
>  				strscpy(str, val_str, size);
>  			} else {
> +				char *stack_start = str + sizeof(unsigned long);
>  				int e;
>  
> -				e = stack_trace_save((void *)str,
> +				e = stack_trace_save((void *)stack_start,
>  						     HIST_STACKTRACE_DEPTH,
>  						     HIST_STACKTRACE_SKIP);

BTW, the size of "str" is enough to store HIST_STACKTRACE_DEPTH?
In string case, 

size = min(val->size, STR_VAR_LEN_MAX);

will limit the max size.

Thank you,

>  				if (e < HIST_STACKTRACE_DEPTH - 1)
> -					((unsigned long *)str)[e] = 0;
> +					((unsigned long *)stack_start)[e] = 0;
> +				*((unsigned long *)str) = e;
>  			}
>  			var_val = (u64)(uintptr_t)str;
>  		}
> @@ -5133,13 +5135,15 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
>  					size = min(hist_field->size, STR_VAR_LEN_MAX);
>  					strscpy(str, val_str, size);
>  				} else {
> +					char *stack_start = str + sizeof(unsigned long);
>  					int e;
>  
> -					e = stack_trace_save((void *)str,
> +					e = stack_trace_save((void *)stack_start,
>  							     HIST_STACKTRACE_DEPTH,
>  							     HIST_STACKTRACE_SKIP);
>  					if (e < HIST_STACKTRACE_DEPTH - 1)
> -						((unsigned long *)str)[e] = 0;
> +						((unsigned long *)stack_start)[e] = 0;
> +					*((unsigned long *)str) = e;
>  				}
>  				hist_val = (u64)(uintptr_t)str;
>  			}
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index d458d7a0dfd7..6209b23c863f 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -538,7 +538,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
>  		val_idx = var_ref_idx[field_pos];
>  		str_val = (char *)(long)var_ref_vals[val_idx];
>  
> -		len = kern_fetch_store_strlen((unsigned long)str_val);
> +		if (event->dynamic_fields[i]->is_stack) {
> +			len = *((unsigned long *)str_val);
> +			len *= sizeof(unsigned long);
> +		} else {
> +			len = kern_fetch_store_strlen((unsigned long)str_val);
> +		}
>  
>  		fields_size += len;
>  	}
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
