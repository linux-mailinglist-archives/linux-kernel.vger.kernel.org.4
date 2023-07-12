Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823CB750877
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGLMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGLMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555FF1718;
        Wed, 12 Jul 2023 05:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C21617BF;
        Wed, 12 Jul 2023 12:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E45C433C7;
        Wed, 12 Jul 2023 12:37:29 +0000 (UTC)
Date:   Wed, 12 Jul 2023 08:37:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v5] ftrace: Fix possible warning on checking all pages
 used in ftrace_process_locs()
Message-ID: <20230712083727.405920c4@gandalf.local.home>
In-Reply-To: <20230712060452.3175675-1-zhengyejian1@huawei.com>
References: <20230711095802.71406422@gandalf.local.home>
        <20230712060452.3175675-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 14:04:52 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3305,6 +3305,22 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>  	return cnt;
>  }
>  
> +static void ftrace_free_pages(struct ftrace_page *pages)
> +{
> +	struct ftrace_page *pg = pages;
> +
> +	while (pg) {
> +		if (pg->records) {
> +			free_pages((unsigned long)pg->records, pg->order);
> +			ftrace_number_of_pages -= 1 << pg->order;
> +		}
> +		pages = pg->next;
> +		kfree(pg);
> +		pg = pages;
> +		ftrace_number_of_groups--;
> +	}
> +}
> +
>  static struct ftrace_page *
>  ftrace_allocate_pages(unsigned long num_to_init)
>  {
> @@ -3343,17 +3359,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
>  	return start_pg;
>  
>   free_pages:
> -	pg = start_pg;
> -	while (pg) {
> -		if (pg->records) {
> -			free_pages((unsigned long)pg->records, pg->order);
> -			ftrace_number_of_pages -= 1 << pg->order;
> -		}
> -		start_pg = pg->next;
> -		kfree(pg);
> -		pg = start_pg;
> -		ftrace_number_of_groups--;
> -	}
> +	ftrace_free_pages(start_pg);
>  	pr_info("ftrace: FAILED to allocate memory for functions\n");
>  	return NULL;
>  }

Nice little clean up. I had already started testing your previous patch,
but due to my test machine running out of disk space (perf doesn't clean up
its .debug directory :-p), I have to rerun it.

I'll apply this one for the new testing.

Thanks!

-- Steve
