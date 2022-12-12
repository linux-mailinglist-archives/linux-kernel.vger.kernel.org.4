Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB164A80A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiLLTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C6FD23
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670872687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZA2Lm3PDAwIQ0maNgxM3nNwupI/vUw9TUlNc3+zoMa4=;
        b=Rl63I5OEHcmFcaVwSqVqLrcNZdMBBcSTTvJ8eGL3t5l3K+B/o28tRRKtTjHgLyer5zHN/O
        g919HVAXnpW/J5bsQwaLeSCC7ZpLYVXxckOOQbIo4FqENik5AGoJl6yM8xCJ25PFo/ATIV
        yOV5X/fZ4+pHjbXrxz8WxoFAV5eh/FI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-7zF9GTMuPPSVMw9sczDziw-1; Mon, 12 Dec 2022 14:18:04 -0500
X-MC-Unique: 7zF9GTMuPPSVMw9sczDziw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AA0C806003;
        Mon, 12 Dec 2022 19:18:04 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4DFAC15BA0;
        Mon, 12 Dec 2022 19:18:03 +0000 (UTC)
Date:   Mon, 12 Dec 2022 14:17:58 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y5d+ZqdxeJD2eIHL@lorien.usersys.redhat.com>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
 <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
 <Y2oozs/YgqqRV5hq@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y2pKh3H0Ukvmfuco@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pKh3H0Ukvmfuco@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 08, 2022 at 01:24:39PM +0100 Greg Kroah-Hartman wrote:
> On Tue, Nov 08, 2022 at 03:30:46PM +0530, Vishal Chourasia wrote:
> > 
> > Thanks Greg & Peter for your direction. 
> > 
> > While we pursue the idea of having debugfs based on kernfs, we thought about
> > having a boot time parameter which would disable creating and updating of the
> > sched_domain debugfs files and this would also be useful even when the kernfs
> > solution kicks in, as users who may not care about these debugfs files would
> > benefit from a faster CPU hotplug operation.
> 
> Ick, no, you would be adding a new user/kernel api that you will be
> required to support for the next 20+ years.  Just to get over a
> short-term issue before you solve the problem properly.

I'm not convinced moving these files from debugfs to kernfs is the right
fix.  That will take it from ~50 back to ~20 _minutes_ on these systems.
I don't think either of those numbers is reasonable.

The issue as I see it is the full rebuild for every change with no way to
batch the changes. How about something like the below?

This puts the domains/* files under the sched_verbose flag. About the only
thing under that flag now are the detailed topology discovery printks anyway
so this fits together nicely.

This way the files would be off by default (assuming you don't boot with
sched_verbose) and can be created at runtime by enabling verbose. Multiple
changes could also be batched by disabling/makeing changes/re-enabling.

It does not create a new API, uses one that is already there.

> 
> If you really do not want these debugfs files, just disable debugfs from
> your system.  That should be a better short-term solution, right?

We do find these files useful at times for debugging issue and looking
at what's going on on the system.

> 
> Or better yet, disable SCHED_DEBUG, why can't you do that?

Same with this... useful information with (modulo issues like this)
small cost. There are also tuning knobs that are only available
with SCHED_DEBUG. 


Cheers,
Phil

---------------

sched/debug: Put sched/domains files under verbose flag

The debug files under sched/domains can take a long time to regenerate,
especially when updates are done one at a time. Move these files under
the verbose debug flag. Allow changes to verbose to trigger generation
of the files. This lets a user batch the updates but still have the
information available.  The detailed topology printk messages are also
under verbose.

Signed-off-by: Phil Auld <pauld@redhat.com>
---
 kernel/sched/debug.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..2eb51ee3ccab 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -280,6 +280,31 @@ static const struct file_operations sched_dynamic_fops = {
 
 __read_mostly bool sched_debug_verbose;
 
+static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos);
+
+static int sched_verbose_show(struct seq_file *m, void *v)
+{
+	if (sched_debug_verbose)
+		seq_puts(m,"Y\n");
+	else
+		seq_puts(m,"N\n");
+	return 0;
+}
+
+static int sched_verbose_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_verbose_show, NULL);
+}
+
+static const struct file_operations sched_verbose_fops = {
+	.open		= sched_verbose_open,
+	.write		= sched_verbose_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static const struct seq_operations sched_debug_sops;
 
 static int sched_debug_open(struct inode *inode, struct file *filp)
@@ -303,7 +328,7 @@ static __init int sched_init_debug(void)
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
-	debugfs_create_bool("verbose", 0644, debugfs_sched, &sched_debug_verbose);
+	debugfs_create_file("verbose", 0644, debugfs_sched, NULL, &sched_verbose_fops);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
@@ -402,15 +427,23 @@ void update_sched_domain_debugfs(void)
 	if (!debugfs_sched)
 		return;
 
+	if (!sched_debug_verbose)
+		return;
+
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
 
-	if (!sd_dentry)
+	if (!sd_dentry) {
 		sd_dentry = debugfs_create_dir("domains", debugfs_sched);
 
+		/* rebuild sd_sysclt_cpus if empty since it gets cleared below */
+		if (cpumask_first(sd_sysctl_cpus) >=  nr_cpu_ids)
+			cpumask_copy(sd_sysctl_cpus, cpu_online_mask);
+	}
+
 	for_each_cpu(cpu, sd_sysctl_cpus) {
 		struct sched_domain *sd;
 		struct dentry *d_cpu;
@@ -443,6 +476,37 @@ void dirty_sched_domain_sysctl(int cpu)
 
 #endif /* CONFIG_SMP */
 
+static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	bool orig = sched_debug_verbose;
+	bool bv;
+	int r;
+
+	r = kstrtobool_from_user(ubuf, cnt, &bv);
+	if (!r) {
+		mutex_lock(&sched_domains_mutex);
+		r = debugfs_file_get(dentry);
+		if (unlikely(r))
+			return r;
+		sched_debug_verbose = bv;
+		debugfs_file_put(dentry);
+
+#ifdef CONFIG_SMP
+		if (sched_debug_verbose && !orig)
+			update_sched_domain_debugfs();
+		else if (!sched_debug_verbose && orig){
+			debugfs_remove(sd_dentry);
+			sd_dentry = NULL;
+		}
+#endif
+
+		mutex_unlock(&sched_domains_mutex);
+	}
+	return cnt;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
 {
-- 
2.31.1



-- 

