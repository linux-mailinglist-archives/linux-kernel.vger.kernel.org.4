Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAF636530
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiKWQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiKWQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:01:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874B62073;
        Wed, 23 Nov 2022 08:01:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9D1B821A3;
        Wed, 23 Nov 2022 16:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F71AC433D6;
        Wed, 23 Nov 2022 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219315;
        bh=yFmuhTmSiyxU3ni/6DVX8B9oEkDKgW2Hapvs+HeA9KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hAml/RLcflOKFscFKPWoJtTdv4zQLkwWy5RHcaDMy149z0cg4BTIrOf2xR3TizNl/
         enVzSxJ076e+TbhjgNbo/8dmvEvfyOx7aHJTKac9iSkSWwESCn0RhQKTELXOz58HDS
         HALpQMRzVEb/g/DPLEJqOZoAgNt1lpHgNDNlzR3+qdz8Tcf3P4ebplwNL5WiIBHTdN
         WD/xAGHgrUG+vgxqns7oh9xOil2Izk98nFq0sW/PnVCKD3e/Ltws78kuQfnmIXFXHJ
         qeMHuaFFF2uYI/qJFJcJf+p/pYCS/qxrHHw99pF8T7QGqWtnVOLPNvtjINWp0KSqrU
         9rnlumY0XyvRA==
Date:   Thu, 24 Nov 2022 01:01:52 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/eprobe: Update cond flag before enabling
 trigger
Message-Id: <20221124010152.75846db3bc63a5c6c109945f@kernel.org>
In-Reply-To: <20221118111940.1268da2b@gandalf.local.home>
References: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
        <20221117211726.4bbbb96a@gandalf.local.home>
        <20221117213109.6119750e@gandalf.local.home>
        <Y3d9KcpcwrEUUYKT@macondo>
        <Y3eJ8GiGnEvVd8/N@macondo>
        <20221118111940.1268da2b@gandalf.local.home>
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

On Fri, 18 Nov 2022 11:19:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Nov 2022 10:34:40 -0300
> Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
> 
> > It did not trigger the NULL pointer issue to be more specific. When
> > creating event probe for all events I was unable to create any event for
> > the xhci-hcd system:
> > 
> > root@localhost:/sys/kernel/tracing# echo 'e xhci-hcd/xhci_add_endpoint' > dynamic_events 
> > -bash: echo: write error: Invalid argument
> > 
> > Debugging the issue it seems that the problem is in the is_good_name()
> > check, which returns false for "xhci-hcd". Should we sanitize it by
> 
> Ouch. I didn't realize that.

Maybe we need better error message so that user can notice which character
caused the error. 

> 
> > converting '-' into '_'?
> 
> Actually, it's just the system name that's an issue. I tested this patch
> and it appears to work.

Ah, the system name is more flexible than the event name because it has
TRACE_SYSTEM_VAR.

Steve, can you send me the below patch?

BTW, TRACE_DEFINE_ENUM() and TRACE_DEFINE_SIZEOF() macros are using
TRACE_SYSTEM instead of TRACE_SYSTEM_VAR. Should those use TRACE_SYSTEM_VAR
for defining a variable?

Thank you,

> 
> -- Steve
> 
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 54ee5711c729..a16fb4c9642e 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1955,17 +1955,30 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
>  }
>  
>  /* Check the name is good for event/group/fields */
> -static inline bool is_good_name(const char *name)
> +static inline bool __is_good_name(const char *name, bool hash_ok)
>  {
> -	if (!isalpha(*name) && *name != '_')
> +	if (!isalpha(*name) && *name != '_' && (!hash_ok || *name != '-'))
>  		return false;
>  	while (*++name != '\0') {
> -		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
> +		if (!isalpha(*name) && !isdigit(*name) && *name != '_' &&
> +		    (!hash_ok || *name != '-'))
>  			return false;
>  	}
>  	return true;
>  }
>  
> +/* Check the name is good for event/group/fields */
> +static inline bool is_good_name(const char *name)
> +{
> +	return __is_good_name(name, false);
> +}
> +
> +/* Check the name is good for system */
> +static inline bool is_good_system_name(const char *name)
> +{
> +	return __is_good_name(name, true);
> +}
> +
>  /* Convert certain expected symbols into '_' when generating event names */
>  static inline void sanitize_event_name(char *name)
>  {
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de46..bb2f95d7175c 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -246,7 +246,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  			return -EINVAL;
>  		}
>  		strlcpy(buf, event, slash - event + 1);
> -		if (!is_good_name(buf)) {
> +		if (!is_good_system_name(buf)) {
>  			trace_probe_log_err(offset, BAD_GROUP_NAME);
>  			return -EINVAL;
>  		}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
