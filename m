Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BB64AFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiLMGZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiLMGYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:24:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B641F2E3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A020CE135B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89E8C433D2;
        Tue, 13 Dec 2022 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670912637;
        bh=XILhkOe6p+0QqL2sPK2HR37qz6w5rgg+N/ardspCqbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwraBZKvwbxi6uw8CQYPRtMMMV1pnEOs04Aj70AVZf9AcDn/pVDSLT09CeITcMikt
         PRBJhf6+HFBZTJdPhFWVKIsHOWnvGuUPttZwswsYnHOAAFjkPENKr9N5zoO7CsVgr5
         BhlYGWbBBJPQmvzPeJxbnJipu/4axyxuHDIO2WBM=
Date:   Tue, 13 Dec 2022 07:23:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y5gaerSL8pXZcIjR@kroah.com>
References: <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
 <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y2pKh3H0Ukvmfuco@kroah.com>
 <Y5d+ZqdxeJD2eIHL@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5d+ZqdxeJD2eIHL@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:17:58PM -0500, Phil Auld wrote:
> Hi,
> 
> On Tue, Nov 08, 2022 at 01:24:39PM +0100 Greg Kroah-Hartman wrote:
> > On Tue, Nov 08, 2022 at 03:30:46PM +0530, Vishal Chourasia wrote:
> > > 
> > > Thanks Greg & Peter for your direction. 
> > > 
> > > While we pursue the idea of having debugfs based on kernfs, we thought about
> > > having a boot time parameter which would disable creating and updating of the
> > > sched_domain debugfs files and this would also be useful even when the kernfs
> > > solution kicks in, as users who may not care about these debugfs files would
> > > benefit from a faster CPU hotplug operation.
> > 
> > Ick, no, you would be adding a new user/kernel api that you will be
> > required to support for the next 20+ years.  Just to get over a
> > short-term issue before you solve the problem properly.
> 
> I'm not convinced moving these files from debugfs to kernfs is the right
> fix.  That will take it from ~50 back to ~20 _minutes_ on these systems.
> I don't think either of those numbers is reasonable.
> 
> The issue as I see it is the full rebuild for every change with no way to
> batch the changes. How about something like the below?
> 
> This puts the domains/* files under the sched_verbose flag. About the only
> thing under that flag now are the detailed topology discovery printks anyway
> so this fits together nicely.
> 
> This way the files would be off by default (assuming you don't boot with
> sched_verbose) and can be created at runtime by enabling verbose. Multiple
> changes could also be batched by disabling/makeing changes/re-enabling.
> 
> It does not create a new API, uses one that is already there.

The idea seems good, the implementation might need a bit of work :)

> > If you really do not want these debugfs files, just disable debugfs from
> > your system.  That should be a better short-term solution, right?
> 
> We do find these files useful at times for debugging issue and looking
> at what's going on on the system.
> 
> > 
> > Or better yet, disable SCHED_DEBUG, why can't you do that?
> 
> Same with this... useful information with (modulo issues like this)
> small cost. There are also tuning knobs that are only available
> with SCHED_DEBUG. 
> 
> 
> Cheers,
> Phil
> 
> ---------------
> 
> sched/debug: Put sched/domains files under verbose flag
> 
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the verbose debug flag. Allow changes to verbose to trigger generation
> of the files. This lets a user batch the updates but still have the
> information available.  The detailed topology printk messages are also
> under verbose.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>  kernel/sched/debug.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1637b65ba07a..2eb51ee3ccab 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -280,6 +280,31 @@ static const struct file_operations sched_dynamic_fops = {
>  
>  __read_mostly bool sched_debug_verbose;
>  
> +static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> +				   size_t cnt, loff_t *ppos);
> +
> +static int sched_verbose_show(struct seq_file *m, void *v)
> +{
> +	if (sched_debug_verbose)
> +		seq_puts(m,"Y\n");
> +	else
> +		seq_puts(m,"N\n");
> +	return 0;
> +}
> +
> +static int sched_verbose_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_verbose_show, NULL);
> +}
> +
> +static const struct file_operations sched_verbose_fops = {
> +	.open		= sched_verbose_open,
> +	.write		= sched_verbose_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
>  static const struct seq_operations sched_debug_sops;
>  
>  static int sched_debug_open(struct inode *inode, struct file *filp)
> @@ -303,7 +328,7 @@ static __init int sched_init_debug(void)
>  	debugfs_sched = debugfs_create_dir("sched", NULL);
>  
>  	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
> -	debugfs_create_bool("verbose", 0644, debugfs_sched, &sched_debug_verbose);
> +	debugfs_create_file("verbose", 0644, debugfs_sched, NULL, &sched_verbose_fops);
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
>  #endif
> @@ -402,15 +427,23 @@ void update_sched_domain_debugfs(void)
>  	if (!debugfs_sched)
>  		return;
>  
> +	if (!sched_debug_verbose)
> +		return;
> +
>  	if (!cpumask_available(sd_sysctl_cpus)) {
>  		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>  			return;
>  		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>  	}
>  
> -	if (!sd_dentry)
> +	if (!sd_dentry) {
>  		sd_dentry = debugfs_create_dir("domains", debugfs_sched);
>  
> +		/* rebuild sd_sysclt_cpus if empty since it gets cleared below */
> +		if (cpumask_first(sd_sysctl_cpus) >=  nr_cpu_ids)
> +			cpumask_copy(sd_sysctl_cpus, cpu_online_mask);
> +	}
> +
>  	for_each_cpu(cpu, sd_sysctl_cpus) {
>  		struct sched_domain *sd;
>  		struct dentry *d_cpu;
> @@ -443,6 +476,37 @@ void dirty_sched_domain_sysctl(int cpu)
>  
>  #endif /* CONFIG_SMP */
>  
> +static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> +				   size_t cnt, loff_t *ppos)
> +{
> +	struct dentry *dentry = filp->f_path.dentry;
> +	bool orig = sched_debug_verbose;
> +	bool bv;
> +	int r;
> +
> +	r = kstrtobool_from_user(ubuf, cnt, &bv);
> +	if (!r) {
> +		mutex_lock(&sched_domains_mutex);
> +		r = debugfs_file_get(dentry);
> +		if (unlikely(r))
> +			return r;
> +		sched_debug_verbose = bv;
> +		debugfs_file_put(dentry);

Why the get/put of the debugfs dentry? for just this single value?

thanks,

greg k-h
