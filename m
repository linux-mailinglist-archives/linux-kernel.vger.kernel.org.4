Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E3673D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjASPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03525D7EB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674140883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4rbfEZevHkUftyO6SF/+rJeKbUzk1q8Fp+/mmnmeiBU=;
        b=Bh9Al8cKZpP+o0DxR/2YP6JFIZpGa6/njWyC/tOWepCMrFWHUVOYgOG/uJBMmQT/9Pponc
        7Fk6+WSO92Wq+zDh39zuXZcnU9lwca+mX3i+nCE4AeDRIVIqtHhsTPaCJR0lZVPf7frL93
        fP25t4P7XyfzOuxID/xxOxl3A8gQ6Yo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-aIotFR1jPQWZcCsOwyXmHA-1; Thu, 19 Jan 2023 10:08:00 -0500
X-MC-Unique: aIotFR1jPQWZcCsOwyXmHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC59A87A9E0;
        Thu, 19 Jan 2023 15:07:59 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7887E1121318;
        Thu, 19 Jan 2023 15:07:59 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        vishalc@linux.vnet.ibm.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        ritesh.list@gmail.com
Subject: [RESEND PATCH] sched/debug: Put sched/domains files under the verbose flag
Date:   Thu, 19 Jan 2023 10:07:58 -0500
Message-Id: <20230119150758.880189-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug files under sched/domains can take a long time to regenerate,
especially when updates are done one at a time. Move these files under
the sched verbose debug flag. Allow changes to verbose to trigger
generation of the files. This lets a user batch the updates but still
have the information available.  The detailed topology printk messages
are also under verbose.

Discussion that lead to this approach can be found in the link below.

Simplified code to maintain use of debugfs bool routines suggested by
Michael Ellerman <mpe@ellerman.id.au>.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/
---

Resending due to typo in lkml address... sorry about that.

 kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..2378a30738ec 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -280,6 +280,45 @@ static const struct file_operations sched_dynamic_fops = {
 
 __read_mostly bool sched_debug_verbose;
 
+#ifdef CONFIG_SMP
+static struct dentry           *sd_dentry;
+
+
+static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
+				  size_t cnt, loff_t *ppos)
+{
+	ssize_t result;
+	bool orig;
+
+	cpus_read_lock();
+	mutex_lock(&sched_domains_mutex);
+
+	orig = sched_debug_verbose;
+	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
+
+	if (sched_debug_verbose && !orig)
+		update_sched_domain_debugfs();
+	else if (!sched_debug_verbose && orig) {
+		debugfs_remove(sd_dentry);
+		sd_dentry = NULL;
+	}
+
+	mutex_unlock(&sched_domains_mutex);
+	cpus_read_unlock();
+
+	return result;
+}
+#else
+#define sched_verbose_write debugfs_write_file_bool
+#endif
+
+static const struct file_operations sched_verbose_fops = {
+	.read =         debugfs_read_file_bool,
+	.write =        sched_verbose_write,
+	.open =         simple_open,
+	.llseek =       default_llseek,
+};
+
 static const struct seq_operations sched_debug_sops;
 
 static int sched_debug_open(struct inode *inode, struct file *filp)
@@ -303,7 +342,7 @@ static __init int sched_init_debug(void)
 	debugfs_sched = debugfs_create_dir("sched", NULL);
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
-	debugfs_create_bool("verbose", 0644, debugfs_sched, &sched_debug_verbose);
+	debugfs_create_file_unsafe("verbose", 0644, debugfs_sched, &sched_debug_verbose, &sched_verbose_fops);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
@@ -345,7 +384,6 @@ late_initcall(sched_init_debug);
 #ifdef CONFIG_SMP
 
 static cpumask_var_t		sd_sysctl_cpus;
-static struct dentry		*sd_dentry;
 
 static int sd_flags_show(struct seq_file *m, void *v)
 {
@@ -402,15 +440,23 @@ void update_sched_domain_debugfs(void)
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
-- 
2.31.1

