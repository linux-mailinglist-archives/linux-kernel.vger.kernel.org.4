Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40046619E9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjAHVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjAHVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:22:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6333E017;
        Sun,  8 Jan 2023 13:22:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76F15B80C03;
        Sun,  8 Jan 2023 21:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F4BC433EF;
        Sun,  8 Jan 2023 21:22:25 +0000 (UTC)
Date:   Sun, 8 Jan 2023 16:22:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     rostedt@goodmis.or, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Message-ID: <20230108162222.146d136f@rorschach.local.home>
In-Reply-To: <20230107034335.1154374-1-quanfafu@gmail.com>
References: <20230107034335.1154374-1-quanfafu@gmail.com>
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

On Sat,  7 Jan 2023 11:43:35 +0800
Quanfa Fu <quanfafu@gmail.com> wrote:

> Since this memory will be filled soon below, I feel that there is

kzalloc() is also used as a safety measure to make sure nothing is
accidentally exposed. I rather keep it for safety. Just because it
doesn't need to be here doesn't mean it should be removed. There is no
benefit to making this kmalloc(), as this is far from a fast path.

> no need for a memory of all zeros here. 'snprintf' does not return
> negative num according to ISO C99, so I feel that no judgment is
> needed here.

Also, it's best to remove "feelings" from change logs. Code updates are
not made due to how one feels about something (at least it shouldn't
be), but about having technical reasons for doing so. I do agree
there's no reason to check snprintf() from returning negative, as
looking at its implementation, there is no negative return. Thus, the
change log should be:

 "No need to check for negative return value from snprintf() as the
 code does not return negative values."

> 
> No functional change intended.

And this does have functional changes. If the output of a compiler is
different for a function, then that's a functional change. What we
consider non functional changes is if functions get moved around, or
possibly code in a function is moved into a helper function where the
compiler *should* end up with the same assembly.

Changing what malloc is called is definitely a functional change.

> 
> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> ---
>  kernel/trace/trace_eprobe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 352b65e2b910..cd1d271a74e7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>  	for (i = 0; i < argc; i++)
>  		len += strlen(argv[i]) + 1;
>  
> -	ep->filter_str = kzalloc(len, GFP_KERNEL);
> +	ep->filter_str = kmalloc(len, GFP_KERNEL);
>  	if (!ep->filter_str)
>  		return -ENOMEM;
>  
>  	p = ep->filter_str;
>  	for (i = 0; i < argc; i++) {
>  		ret = snprintf(p, len, "%s ", argv[i]);

I wonder if this should be a strncat() instead?

> -		if (ret < 0)
> -			goto error;
>  		if (ret > len) {
>  			ret = -E2BIG;
>  			goto error;

	for (i = 0; i < arcc, i++)
		strncat(ep->filter_str, argv[i], len);

I mean, before this code we have that loop already determining what len
is, do we really need to check if it is going to be -E2BIG?

-- Steve
