Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1862826F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiKNOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKNOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:24:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4673332;
        Mon, 14 Nov 2022 06:24:37 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id e205so7038513oif.11;
        Mon, 14 Nov 2022 06:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2h2Bd0mlhjARQuRbOtdZwUyYGBLSP4RY9cU803bW0zQ=;
        b=gsPwaJxXtXR+wwPO2KADrI7xy206biK5S3+3GdQNrc5mGeryDz6FzaC8bmQ11E9X6q
         6CCTNpMz0BWHRa98K9hbBleD6rP9+bKaoTn5ML4W3pqiEzU5K1U4HfzKdW1F/HJ1WLvb
         gZsOHTHvYv0iwVfh/EvCvB3KjN5S4bj8NpgsE4QUTgIGADjSNnjgnZpUWS9AqFcamQ/j
         gIuzj69j1Ks6IPYFfYJlKsj3ni71nKmpKBrF2+55ahAOzWk6a1gRxN2SVzKBjw0sx51X
         LoMlgNqscLOBR1kqS5Gg+5iVbtR709iTtwqQXFOpz2a9k6Yc2/3Cq+onLMkj8fj5U/yr
         7ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h2Bd0mlhjARQuRbOtdZwUyYGBLSP4RY9cU803bW0zQ=;
        b=aHCKxJIx7aM3TXBkhoNeaop3wXKW6Aq7HoginRqkLR4RXEv8cIpMPM/wsQT1UKz6xI
         0GopK1PphGzDQyq9CJAdUPe8PxnHxbeDyWaQHXKAP0MO94FQh+465+etvkRvziT7XCLE
         OZYTRXDwvE97t/jTYotFQ7pGxCFNgLG0nG7MuGgHmxy65DM+efmYUA1YKeZG2/BlMXJy
         GpQjiNDp7nwyyuLwMLeA0w/tzKO7UWNw1c7OUN7P0DtupFqzG/EjpBj6CWXapUznJvTc
         9gUIVC+Bn6qKfRCojmnLFw2FotrG2JDODFAQi6H1NIVA40lGNxf5+LimpdAYrVosl0im
         5ZyQ==
X-Gm-Message-State: ANoB5pmKFokDdtrgPOD2x50fPLMulx4F964lEyZsu+4tBa1jU9js08++
        l/UCUM3xSaVv5tjR23bL73U1h12k3Qw=
X-Google-Smtp-Source: AA0mqf4IdRPjdliZpWsTHJpe0jTBhjeSOLptE1wTmEObZg4TU32/brYS+XVF/1N+8P4h3wrojyPyDg==
X-Received: by 2002:aca:ac54:0:b0:353:c96f:5e2f with SMTP id v81-20020acaac54000000b00353c96f5e2fmr5822260oie.244.1668435877002;
        Mon, 14 Nov 2022 06:24:37 -0800 (PST)
Received: from macondo ([2804:431:e7cc:5fdd:fb45:46b2:b7e3:b06b])
        by smtp.gmail.com with ESMTPSA id n10-20020a4ac70a000000b0049f07909c5fsm3686129ooq.3.2022.11.14.06.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:24:36 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:24:32 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing/eprobe: Fix eprobe filter to make a filter
 correctly
Message-ID: <Y3JPoPYSL5CadDUR@macondo>
References: <166823166395.1385292.8931770640212414483.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166823166395.1385292.8931770640212414483.stgit@devnote3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:41:04PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the eprobe filter was defined based on the eprobe's trace event
> itself, it doesn't work correctly. Use the original trace event of
> the eprobe when making the filter so that the filter works correctly.
> 
> Without this fix:
> 
>  # echo 'e syscalls/sys_enter_openat \
> 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
>  # echo 1 > events/eprobes/sys_enter_openat/enable
> [  114.551550] event trace: Could not enable event sys_enter_openat
> -bash: echo: write error: Invalid argument
> 
> With this fix:
>  # echo 'e syscalls/sys_enter_openat \
> 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
>  # echo 1 > events/eprobes/sys_enter_openat/enable
>  # tail trace
> cat-241     [000] ...1.   266.498449: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> cat-242     [000] ...1.   266.977640: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> 
> Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
> Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_eprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Masami,

Tested this on top of v6.1-rc5 and the event filtering seems to be
working fine now. Tested with multiple events and conditions. Thanks.

Tested-by: Rafael Mendonca <rafaelmendsr@gmail.com>

> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index fe4833a7b7b3..1c3096ab2fe7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -643,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
>  	INIT_LIST_HEAD(&trigger->list);
>  
>  	if (ep->filter_str) {
> -		ret = create_event_filter(file->tr, file->event_call,
> +		ret = create_event_filter(file->tr, ep->event,
>  					ep->filter_str, false, &filter);
>  		if (ret)
>  			goto error;
> 
