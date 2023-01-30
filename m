Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929D7680E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjA3NHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3NHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:07:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DA1C6E91;
        Mon, 30 Jan 2023 05:07:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE181758;
        Mon, 30 Jan 2023 05:08:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DE043F885;
        Mon, 30 Jan 2023 05:07:38 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:07:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: sample: avoid open-coded 64-bit division
Message-ID: <Y9fBFKeJ1zMBtv4b@FVFF77S0Q05N>
References: <20230130130246.247537-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130130246.247537-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:02:37PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calculating the average period requires a 64-bit division that leads
> to a link failure on 32-bit architectures:
> 
> x86_64-linux-ld: samples/ftrace/ftrace-ops.o: in function `ftrace_ops_sample_init':
> ftrace-ops.c:(.init.text+0x23b): undefined reference to `__udivdi3'

Whoops; sorry about that.

> Use the div_u64() helper to do this instead. Since this is an init function that
> is not called frequently, the runtime overhead is going to be acceptable.
> 
> Fixes: b56c68f705ca ("ftrace: Add sample with custom ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  samples/ftrace/ftrace-ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
> index 24deb51c7261..0c8da87ff5c3 100644
> --- a/samples/ftrace/ftrace-ops.c
> +++ b/samples/ftrace/ftrace-ops.c
> @@ -223,7 +223,7 @@ static int __init ftrace_ops_sample_init(void)
>  
>  	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
>  		nr_function_calls, tracee_relevant,
> -		period, period / nr_function_calls);
> +		period, div_u64(period, nr_function_calls));
>  
>  	if (persist)
>  		return 0;
> -- 
> 2.39.0
> 
