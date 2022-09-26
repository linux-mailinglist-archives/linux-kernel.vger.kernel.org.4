Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8A5EAFEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIZSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIZSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764651A06
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44341611B6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BFC433C1;
        Mon, 26 Sep 2022 18:31:06 +0000 (UTC)
Date:   Mon, 26 Sep 2022 14:32:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v1] kernel/trace/trace: check the return value of
 tracing_update_buffers()
Message-ID: <20220926143214.0d6a9203@gandalf.local.home>
In-Reply-To: <20220917020353.3836285-1-floridsleeves@gmail.com>
References: <20220917020353.3836285-1-floridsleeves@gmail.com>
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

On Fri, 16 Sep 2022 19:03:53 -0700
Li Zhong <floridsleeves@gmail.com> wrote:

> Check the return value of tracing_update_buffers() in case it fails.

FYI, the subject should be:

  tracing: Check the return value of tracing_update_buffers()

> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  kernel/trace/trace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d..0e367e326147 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3305,7 +3305,8 @@ void trace_printk_init_buffers(void)
>  	pr_warn("**********************************************************\n");
>  
>  	/* Expand the buffers to set size */
> -	tracing_update_buffers();
> +	if (tracing_update_buffers() < 0)
> +		return;

Even if the buffers are not expanded, tracing can still work. This should
not return here. But instead we should have something like:

	/* Allocation really should not fail here at boot up or module load */
	if (tracing_update_buffers() < 0)
		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
	else
		buffers_allocate = 1;

As we still want the cmdline action done late in the code.

-- Steve


>  
>  	buffers_allocated = 1;
>  

