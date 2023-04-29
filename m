Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8209C6F2521
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjD2O5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjD2O46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:56:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7E19B9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kGM/tMLHRgAdyItVmM6MhRnn73h1G/Op3fx6/i9IQF4=; b=Pi98x8JB6+uqsjZp+0bQqZ9CrJ
        cV+bM2xu1FXCoI1HmsQjfASP2Tsb+NJ5enuxbmjdbCOjpdsRRzq5LDWL2H/RQWleCMnnqbSiMpPQR
        vNqjinqDRYFwVU+HqSMaKcInr5j7tCyUr64NjhUuhIxb+shQ5BtevRT2VZVBdedpAtBTveSgjQYkI
        9yAXnImHsixun3AHgXFLlIYt6dAUt23dHpjFUo11up8DW6ao7c194p9iYfgREsV9IcAqvn0UW9Ufw
        y57skUIC3yOFeZoWhoK4e1bfcsZOYxavCncds/RY4JtQk0mDzUkM4lljzVokzdBxOvdDFpOa3Jd01
        Za/aU4rQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psm05-005b5V-PQ; Sat, 29 Apr 2023 14:56:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F29183004AF;
        Sat, 29 Apr 2023 16:56:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA2C6241CA941; Sat, 29 Apr 2023 16:56:35 +0200 (CEST)
Date:   Sat, 29 Apr 2023 16:56:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, Chen Yu <yu.c.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <20230429145635.GA1495785@hirez.programming.kicks-ass.net>
References: <20230406152633.3136708-1-chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406152633.3136708-1-chris.hyser@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:26:33AM -0400, chris hyser wrote:
> Commit 6419265899d9 ("sched/fair: Fix division by zero
> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
> value of zero. When moved from a sysctl to a debugfs file, this checking
> was lost.
> 
> This patch puts zero checking back in place.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

I suppose.. but is it really worth the hassle? I mean, this is debug
stuff, just don't write 0 in then?

If we do find we want this (why?!) then should we not invest in a better
debugfs_create_u32_minmax() or something so that we don't get to add 40+
lines for everthing we want to add limits on?

> ---
>  kernel/sched/debug.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1637b65ba07a..cc6a0172a598 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -278,6 +278,48 @@ static const struct file_operations sched_dynamic_fops = {
>  
>  #endif /* CONFIG_PREEMPT_DYNAMIC */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
> +				     size_t cnt, loff_t *ppos)
> +{
> +	int err;
> +	unsigned int scan_size;
> +
> +	err = kstrtouint_from_user(ubuf, cnt, 10, &scan_size);
> +	if (err)
> +		return err;
> +
> +	if (!scan_size)
> +		return -EINVAL;
> +
> +	sysctl_numa_balancing_scan_size = scan_size;
> +
> +	*ppos += cnt;
> +	return cnt;
> +}
> +
> +static int sched_numa_scan_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "%d\n", sysctl_numa_balancing_scan_size);
> +	return 0;
> +}
> +
> +static int sched_numa_scan_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_numa_scan_show, NULL);
> +}
> +
> +static const struct file_operations sched_numa_scan_fops = {
> +	.open		= sched_numa_scan_open,
> +	.write		= sched_numa_scan_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>  __read_mostly bool sched_debug_verbose;
>  
>  static const struct seq_operations sched_debug_sops;
> @@ -332,7 +374,7 @@ static __init int sched_init_debug(void)
>  	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
>  	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
>  	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
> -	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
> +	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
>  	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
>  #endif
>  
> -- 
> 2.31.1
> 
