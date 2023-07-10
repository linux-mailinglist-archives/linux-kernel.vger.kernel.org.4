Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D074D947
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGJOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6F114;
        Mon, 10 Jul 2023 07:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFC061048;
        Mon, 10 Jul 2023 14:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE65BC433C8;
        Mon, 10 Jul 2023 14:46:26 +0000 (UTC)
Date:   Mon, 10 Jul 2023 10:46:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix possible warning on checking all pages used
 in ftrace_process_locs()
Message-ID: <20230710104625.421c851a@gandalf.local.home>
In-Reply-To: <20230710212958.274126-1-zhengyejian1@huawei.com>
References: <20230710212958.274126-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 05:29:58 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> As comments in ftrace_process_locs(), there may be NULL pointers in
> mcount_loc section:
>  > Some architecture linkers will pad between
>  > the different mcount_loc sections of different
>  > object files to satisfy alignments.
>  > Skip any NULL pointers.  
> 
> After 20e5227e9f55 ("ftrace: allow NULL pointers in mcount_loc"),
> NULL pointers will be accounted when allocating ftrace pages but
> skipped before adding into ftrace pages, this may result in some
> pages not being used. Then after 706c81f87f84 ("ftrace: Remove extra
> helper functions"), warning may occur at:
>   WARN_ON(pg->next);
> 
> So we may need to skip NULL pointers before allocating ftrace pages.
> 
> Fixes: 706c81f87f84 ("ftrace: Remove extra helper functions")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3740aca79fe7..5b474165df31 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6485,6 +6485,16 @@ static int ftrace_process_locs(struct module *mod,
>  	if (!count)
>  		return 0;
>  
> +	p = start;
> +	while (p < end) {
> +		/*
> +		 * Refer to conments below, there may be NULL pointers,
> +		 * skip them before allocating pages
> +		 */
> +		addr = ftrace_call_adjust(*p++);
> +		if (!addr)
> +			count--;
> +	}

My main concern about this is the added overhead during boot to process
this. There's 10s of thousands of functions, so this loop will be 10s of
thousands. I also don't like that this is an unconditional loop (meaning it
executes even when it is unnecessary to do so).


>  	/*
>  	 * Sorting mcount in vmlinux at build time depend on
>  	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in

How about something like this?

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b24c573934af..acd033371721 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6474,6 +6474,7 @@ static int ftrace_process_locs(struct module *mod,
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -6536,8 +6537,10 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6551,12 +6554,24 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
-
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
 
+	/* We should have used all pages unless we skipped some */
+	if (pg->next) {
+		WARN_ON(!skipped);
+		while (ftrace_pages->next) {
+			pg = ftrace_pages->next;
+			ftrace_pages->next = pg->next;
+			if (pg->records) {
+				free_pages((unsigned long)pg->records, pg->order);
+				ftrace_number_of_pages -= 1 << pg->order;
+			}
+			kfree(pg);
+			ftrace_number_of_groups--;
+		}
+	}
+
 	/*
 	 * We only need to disable interrupts on start up
 	 * because we are modifying code that an interrupt
