Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734E75B32B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiIIJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiIIJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D224558E5;
        Fri,  9 Sep 2022 02:00:29 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dqXz7i+/nKiAs5u3wwrcIGg38J4UlIG9WyCdSYDIy8=;
        b=fS0rnrQMbVi74ZiDCSzZ/zPO0QrkcsnT9KmK4QlMuqLAkMo3GF9npsTI5atG0/PLdpQdNg
        4zSF0GKXKzMOV18AlTr4AF0ROMLgq1W9QucBwRaAteUdLP/xNG7fSOwrjJ/wCV/0iYSJln
        ihxL7jf6mJ3J31OxWlPVto1ai+BqWSbn29xq7XX0y4DFMszO7F14BjSsUt9wa4OF4Yo8cT
        q3YyNe4SeA/pSWCJ6BE0WJ5m2PDO+ppjNne/0BaogqqFzIPgHxjIzNOh9Fs/AVaga36rrL
        UG5vZrY5zyAPJgt6or/YhEfvEAmNIJnQOjy4+a+oa1GQxUQakynCx7eIC8Wf+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dqXz7i+/nKiAs5u3wwrcIGg38J4UlIG9WyCdSYDIy8=;
        b=haIOghxK4D4l7LFXD8RZXQla4uha+1IA9YpHAD7f0rcRQh2ibtg8DrF9LCDEnj1bv8UUna
        W35sYk4kP+4JINAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] freezer: Have {,un}lock_system_sleep() save/restore flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114648.725003428@infradead.org>
References: <20220822114648.725003428@infradead.org>
MIME-Version: 1.0
Message-ID: <166271402491.401.4749699377360450741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5950e5d574c636a07dd21a872c2f8b41f6d20c55
Gitweb:        https://git.kernel.org/tip/5950e5d574c636a07dd21a872c2f8b41f6d20c55
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:48 +02:00

freezer: Have {,un}lock_system_sleep() save/restore flags

Rafael explained that the reason for having both PF_NOFREEZE and
PF_FREEZER_SKIP is that {,un}lock_system_sleep() is callable from
kthread context that has previously called set_freezable().

In preparation of merging the flags, have {,un}lock_system_slee() save
and restore current->flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20220822114648.725003428@infradead.org
---
 drivers/acpi/x86/s2idle.c         | 12 ++++++----
 drivers/scsi/scsi_transport_spi.c |  7 +++---
 include/linux/suspend.h           |  8 +++----
 kernel/power/hibernate.c          | 35 ++++++++++++++++++------------
 kernel/power/main.c               | 16 ++++++++------
 kernel/power/suspend.c            | 12 ++++++----
 kernel/power/user.c               | 24 ++++++++++++---------
 7 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b..1d1d6c8 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -541,12 +541,14 @@ void acpi_s2idle_setup(void)
 
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 {
+	unsigned int sleep_flags;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return -ENODEV;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	list_add(&arg->list_node, &lps0_s2idle_devops_head);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
@@ -554,12 +556,14 @@ EXPORT_SYMBOL_GPL(acpi_register_lps0_dev);
 
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
 {
+	unsigned int sleep_flags;
+
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	list_del(&arg->list_node);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
 
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index bd72c38..f569cf0 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -998,8 +998,9 @@ void
 spi_dv_device(struct scsi_device *sdev)
 {
 	struct scsi_target *starget = sdev->sdev_target;
-	u8 *buffer;
 	const int len = SPI_MAX_ECHO_BUFFER_SIZE*2;
+	unsigned int sleep_flags;
+	u8 *buffer;
 
 	/*
 	 * Because this function and the power management code both call
@@ -1007,7 +1008,7 @@ spi_dv_device(struct scsi_device *sdev)
 	 * while suspend or resume is in progress. Hence the
 	 * lock/unlock_system_sleep() calls.
 	 */
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (scsi_autopm_get_device(sdev))
 		goto unlock_system_sleep;
@@ -1058,7 +1059,7 @@ put_autopm:
 	scsi_autopm_put_device(sdev);
 
 unlock_system_sleep:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL(spi_dv_device);
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 70f2921..34fb72c 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -510,8 +510,8 @@ extern bool pm_save_wakeup_count(unsigned int count);
 extern void pm_wakep_autosleep_enabled(bool set);
 extern void pm_print_active_wakeup_sources(void);
 
-extern void lock_system_sleep(void);
-extern void unlock_system_sleep(void);
+extern unsigned int lock_system_sleep(void);
+extern void unlock_system_sleep(unsigned int);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -534,8 +534,8 @@ static inline void pm_system_wakeup(void) {}
 static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
-static inline void lock_system_sleep(void) {}
-static inline void unlock_system_sleep(void) {}
+static inline unsigned int lock_system_sleep(void) { return 0; }
+static inline void unlock_system_sleep(unsigned int flags) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 89c71fc..f58a0aa 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -92,20 +92,24 @@ bool hibernation_available(void)
  */
 void hibernation_set_ops(const struct platform_hibernation_ops *ops)
 {
+	unsigned int sleep_flags;
+
 	if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
 	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
 	    && ops->restore_cleanup && ops->leave)) {
 		WARN_ON(1);
 		return;
 	}
-	lock_system_sleep();
+
+	sleep_flags = lock_system_sleep();
+
 	hibernation_ops = ops;
 	if (ops)
 		hibernation_mode = HIBERNATION_PLATFORM;
 	else if (hibernation_mode == HIBERNATION_PLATFORM)
 		hibernation_mode = HIBERNATION_SHUTDOWN;
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(hibernation_set_ops);
 
@@ -713,6 +717,7 @@ static int load_image_and_restore(void)
 int hibernate(void)
 {
 	bool snapshot_test = false;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available()) {
@@ -720,7 +725,7 @@ int hibernate(void)
 		return -EPERM;
 	}
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -794,7 +799,7 @@ int hibernate(void)
 	pm_restore_console();
 	hibernate_release();
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	pr_info("hibernation exit\n");
 
 	return error;
@@ -809,9 +814,10 @@ int hibernate(void)
  */
 int hibernate_quiet_exec(int (*func)(void *data), void *data)
 {
+	unsigned int sleep_flags;
 	int error;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -891,7 +897,7 @@ restore:
 	hibernate_release();
 
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -1100,11 +1106,12 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
+	int mode = HIBERNATION_INVALID;
+	unsigned int sleep_flags;
 	int error = 0;
-	int i;
 	int len;
 	char *p;
-	int mode = HIBERNATION_INVALID;
+	int i;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -1112,7 +1119,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (len == strlen(hibernation_modes[i])
 		    && !strncmp(buf, hibernation_modes[i], len)) {
@@ -1142,7 +1149,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!error)
 		pm_pr_dbg("Hibernation mode set to '%s'\n",
 			       hibernation_modes[mode]);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	return error ? error : n;
 }
 
@@ -1158,9 +1165,10 @@ static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			    const char *buf, size_t n)
 {
-	dev_t res;
+	unsigned int sleep_flags;
 	int len = n;
 	char *name;
+	dev_t res;
 
 	if (len && buf[len-1] == '\n')
 		len--;
@@ -1173,9 +1181,10 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!res)
 		return -EINVAL;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	swsusp_resume_device = res;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
+
 	pm_pr_dbg("Configured hibernation resume from disk to %u\n",
 		  swsusp_resume_device);
 	noresume = 0;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index e369403..dae3d17 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -21,14 +21,16 @@
 
 #ifdef CONFIG_PM_SLEEP
 
-void lock_system_sleep(void)
+unsigned int lock_system_sleep(void)
 {
+	unsigned int flags = current->flags;
 	current->flags |= PF_FREEZER_SKIP;
 	mutex_lock(&system_transition_mutex);
+	return flags;
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
 
-void unlock_system_sleep(void)
+void unlock_system_sleep(unsigned int flags)
 {
 	/*
 	 * Don't use freezer_count() because we don't want the call to
@@ -46,7 +48,8 @@ void unlock_system_sleep(void)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	current->flags &= ~PF_FREEZER_SKIP;
+	if (!(flags & PF_FREEZER_SKIP))
+		current->flags &= ~PF_FREEZER_SKIP;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
@@ -263,16 +266,17 @@ static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 				const char *buf, size_t n)
 {
+	unsigned int sleep_flags;
 	const char * const *s;
+	int error = -EINVAL;
 	int level;
 	char *p;
 	int len;
-	int error = -EINVAL;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	level = TEST_FIRST;
 	for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
@@ -282,7 +286,7 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 			break;
 		}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error ? error : n;
 }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8270759..0d5f1fd 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -75,9 +75,11 @@ EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 	s2idle_ops = ops;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 
 static void s2idle_begin(void)
@@ -200,7 +202,9 @@ __setup("mem_sleep_default=", mem_sleep_default_setup);
  */
 void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 
 	suspend_ops = ops;
 
@@ -216,7 +220,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
 			mem_sleep_current = PM_SUSPEND_MEM;
 	}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d43c2aa..3a4e703 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -47,12 +47,13 @@ int is_hibernate_resume_dev(dev_t dev)
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available())
 		return -EPERM;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -98,7 +99,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->dev = 0;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -106,8 +107,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	swsusp_free();
 	data = filp->private_data;
@@ -124,7 +126,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
@@ -132,11 +134,12 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 static ssize_t snapshot_read(struct file *filp, char __user *buf,
                              size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 	if (!data->ready) {
@@ -157,7 +160,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		*offp += res;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }
@@ -165,16 +168,17 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 static ssize_t snapshot_write(struct file *filp, const char __user *buf,
                               size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned long sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
 	if (need_wait) {
 		wait_for_device_probe();
 		need_wait = false;
 	}
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 
@@ -196,7 +200,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	if (res > 0)
 		*offp += res;
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }
