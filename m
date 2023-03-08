Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B56B0BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCHOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCHOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:53:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847B5A91C;
        Wed,  8 Mar 2023 06:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268B461866;
        Wed,  8 Mar 2023 14:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D5BC433D2;
        Wed,  8 Mar 2023 14:53:37 +0000 (UTC)
Date:   Wed, 8 Mar 2023 09:53:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace: Add ftrace_page to list after the index is
 calculated
Message-ID: <20230308095336.67f9368a@gandalf.local.home>
In-Reply-To: <20230308070844.58180-1-chenzhongjin@huawei.com>
References: <20230308070844.58180-1-chenzhongjin@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 15:08:44 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> Fixes: 3208230983a0 ("ftrace: Remove usage of "freed" records")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  kernel/trace/ftrace.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 29baa97d0d53..a258c48ad91e 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6804,28 +6804,14 @@ static int ftrace_process_locs(struct module *mod,
>  
>  	mutex_lock(&ftrace_lock);
>  
> +	if (WARN_ON(mod && !ftrace_pages))

This is wrong. I have no issues with mod && !ftrace_pages. That's not the
same as !mod && ftrace_pages, which I want to warn on.

The mod && !ftrace_pages means that the system had no ftrace functions but
a module does. Strange, but not something to warn about.

The !mod && ftrace_pages, means that this is setting up the builtin ftrace
pages, but the ftrace_pages already exist. As the builtin needs to only be
done once, this is a bug.

> +		goto out;
> +
>  	/*
>  	 * Core and each module needs their own pages, as
>  	 * modules will free them when they are removed.
>  	 * Force a new page to be allocated for modules.
>  	 */
> -	if (!mod) {
> -		WARN_ON(ftrace_pages || ftrace_pages_start);
> -		/* First initialization */
> -		ftrace_pages = ftrace_pages_start = start_pg;

Since the above only happens at boot up, and before anything can call into
it, this is not a problem.

> -	} else {
> -		if (!ftrace_pages)
> -			goto out;
> -
> -		if (WARN_ON(ftrace_pages->next)) {
> -			/* Hmm, we have free pages? */
> -			while (ftrace_pages->next)
> -				ftrace_pages = ftrace_pages->next;
> -		}
> -
> -		ftrace_pages->next = start_pg;

Basically, what you are saying is that once we add ftrace_pages->next to
point to the new start_pg, it becomes visible to others and that could be a
problem. And moving this code around is not really going to solve that, as
then we would need to add memory barriers.

> -	}
> -
>  	p = start;
>  	pg = start_pg;
>  	while (p < end) {
> @@ -6855,6 +6841,21 @@ static int ftrace_process_locs(struct module *mod,
>  	/* We should have used all pages */
>  	WARN_ON(pg->next);
>  
> +	/* Add pages to ftrace_pages list */
> +	if (!mod) {
> +		WARN_ON(ftrace_pages || ftrace_pages_start);
> +		/* First initialization */
> +		ftrace_pages_start = start_pg;
> +	} else {
> +		if (WARN_ON(ftrace_pages->next)) {
> +			/* Hmm, we have free pages? */
> +			while (ftrace_pages->next)
> +				ftrace_pages = ftrace_pages->next;
> +		}
> +
> +		ftrace_pages->next = start_pg;
> +	}
> +
>  	/* Assign the last page to ftrace_pages */
>  	ftrace_pages = pg;
>  

Why not just test for it?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..9b2803c7a18f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1564,7 +1564,8 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
 	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
+		if (pg->index == 0 ||
+		    end < pg->records[0].ip ||
 		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
 			continue;
 		rec = bsearch(&key, pg->records, pg->index,


-- Steve

