Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADDA6244D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKJOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKJOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:52:38 -0500
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 53D1BFAD7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:52:34 -0800 (PST)
Received: (qmail 18111 invoked from network); 10 Nov 2022 14:52:32 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 10 Nov 2022 14:52:32 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id A17E0AB3A4; Thu, 10 Nov 2022 15:52:23 +0100 (CET)
Date:   Thu, 10 Nov 2022 15:52:23 +0100
From:   Solar Designer <solar@openwall.com>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        Adam Zabrocki <pi3@pi3.com.pl>
Subject: Re: [PATCH v2] kprobes: kretprobe events missing on 2-core KVM guest
Message-ID: <20221110145223.GA14731@openwall.com>
References: <20221026003315.266d59d5c0780c2817be3a0d@kernel.org> <20221110081502.492289-1-wuqiang.matt@bytedance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110081502.492289-1-wuqiang.matt@bytedance.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:15:02PM +0800, wuqiang wrote:
> Default value of maxactive is set as num_possible_cpus() for nonpreemptable
> systems. For a 2-core system, only 2 kretprobe instances would be allocated
> in default, then these 2 instances for execve kretprobe are very likely to
> be used up with a pipelined command.
> 
> Here's the testcase: a shell script was added to crontab, and the content
> of the script is:
> 
>   #!/bin/sh
>   do_something_magic `tr -dc a-z < /dev/urandom | head -c 10`
> 
> cron will trigger a series of program executions (4 times every hour). Then
> events loss would be noticed normally after 3-4 hours of testings.
> 
> The issue is caused by a burst of series of execve requests. The best number
> of kretprobe instances could be different case by case, and should be user's
> duty to determine, but num_possible_cpus() as the default value is inadequate
> especially for systems with small number of cpus.
> 
> This patch enables the logic for preemption as default, thus increases the
> minimum of maxactive to 10 for nonpreemptable systems.
> 
> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>

Reviewed-by: Solar Designer <solar@openwall.com>

Thank you!

> ---
>  Documentation/trace/kprobes.rst |  3 +--
>  kernel/kprobes.c                | 10 +++-------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index 48cf778a2468..fc7ce76eab65 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -131,8 +131,7 @@ For example, if the function is non-recursive and is called with a
>  spinlock held, maxactive = 1 should be enough.  If the function is
>  non-recursive and can never relinquish the CPU (e.g., via a semaphore
>  or preemption), NR_CPUS should be enough.  If maxactive <= 0, it is
> -set to a default value.  If CONFIG_PREEMPT is enabled, the default
> -is max(10, 2*NR_CPUS).  Otherwise, the default is NR_CPUS.
> +set to a default value: max(10, 2*NR_CPUS).
>  
>  It's not a disaster if you set maxactive too low; you'll just miss
>  some probes.  In the kretprobe struct, the nmissed field is set to
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index a8b202f87e2d..1e80bddf2654 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2212,11 +2212,7 @@ int register_kretprobe(struct kretprobe *rp)
>  	rp->kp.post_handler = NULL;
>  
>  	/* Pre-allocate memory for max kretprobe instances */
> -	if (rp->maxactive <= 0) {
> -#ifdef CONFIG_PREEMPTION
> +	if (rp->maxactive <= 0)
>  		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
> -#else
> -		rp->maxactive = num_possible_cpus();
> -#endif
> -	}
> +
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
> --
> 2.34.1

Alexander
