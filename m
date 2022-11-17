Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B674162E8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiKQW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiKQW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95741A193;
        Thu, 17 Nov 2022 14:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggeBx1EZsHzve8zDQDyUbgHV6e5yUllhMEmKBBZSXRTyVtRikndnAsKiAM6Ux9iNP6lnHEDk0z1FG0u2zCdXd6rAIhKc0QjRakZpXFhxIFJi5JGc7ZkqfSNMXvd+IWHi+nNXId6a3Fj0woGBkiQXMO0wY9UggzegqAWeM0LpoAU3FAuEQNKduu/eWweOxdisMsLLYnqOxFU8Tv0v79Bb4WXYnQb6GunikFzCUUYeX8nMxhnbHpMGm/7eSZ6n7Z/6gc7VchDQzpBDJYtav5nydgRo/8ujbpzOB+WAm2lngTjROa05s+j57pBCtgV6yDH996ONUJ/OMzQ6jPHklBgShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vYM9RH7QTI+zoueCoHtEf8XndNeINySFB4MYccqk4w=;
 b=ZpatHFOvYxLWPbiGQjs4ZFFE2nl6V3JiS8gZj69FR283UnmLKDJLnkv83K40Ry9ygHzTQdilK7Nb+Kt211uTMNropQdeFx//0Fzn4I9cAZHkDpFbEeLe6Msi4qKNZgFunw0+JMDJfvFo1Lf2pEufyZ0vkF5rezfIE54P++IfxTjIvdS/b9c8OdFBb1eMqUq6kecz2oSh90yESWBJIYusXBVnYO/QMggdbThIjOQ17csNq/DkwVgoRGML9PcNyJ0/DwOs1Ml4p5irJ0WuO2gUTz4wxZjg2g7qnaSecAGEso6twJHl+W2XVxsoUqkijm5O7C/C+Dr7PAQpFM7BcxmJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vYM9RH7QTI+zoueCoHtEf8XndNeINySFB4MYccqk4w=;
 b=Rf0Ix+s795RpYADCFS1MPaWP9o5xlbrIgRpWwQ9499HRTBLCjCleR6zLVvBfrhY1b43Or48BWbLr8i1nuBGa58k5jhJGL7ODJ5zlhNtQa/S5XpcfbNpgk2ZQUx0ScbT8t6lBbgGFfdmWXhPvzqQDN2p4JysuNo2caAnQQTYwr1w=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 22:58:25 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::fd) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [RFC v4 1/5] PM: Add a sysfs file to represent the percentage of sleep in hardware state
Date:   Thu, 17 Nov 2022 16:58:17 -0600
Message-ID: <20221117225822.16154-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117225822.16154-1-mario.limonciello@amd.com>
References: <20221117225822.16154-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d85abbd-56bd-4961-daf9-08dac8ef3bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEBbrXsstFrZB6K0U74zfbXx9/m+wR6o9VdKvF2lOVe2ErY9k4hCaWh2nexCYmSqgbp4cBB9C7KcEJ4HKOzF8IfyqwWEE0p4+kST0h62cOn9XKRxiapCfbWfrQOIsF9hCWB9JlJuO2pnyf413Rs8EdvcnEL0I5Ha+xIEgtplr5qah1ysJlZXhdCGg6w0TTbuUS6vnl8782VtbwceKfpZ28GNYhFJ346V70xkEjt8MrAmAuHZW5eOe072syJrRC0qAh6plMrWXQVsZAqgvTP/67NziGaNva21gW6e0FSB6V+x/znw55E9aOay0xwaE7j6Qtdxxj1xT8iDcwGi5/ANhUuFB7lRERahcMkhYWPVsjuDom+nXolAZy1+q1Q1atfxj5tyvC1AEMOYWCl2jl0V38AGxNNqPUozVoaEun9Iadavbqo6Ra2/qDbzlXWiyxHaICyBRSGQoOsRJ4MuO/0cVujZivS+8P+Us/zRgntq3DF1JZVcZ9bHqa0RgnTbgJZI3lNacb00q3PbpCNl1Y5TgVtN/ENfVItyA2DxLndGXe13A/tEr0dSgjad9F4H4kPYObApNqXwf1a3Prb1acHOaYWAWl17odzkjMx3xFpVy3QGOSwLxYKmkQLcvjUbMnGsJca142lAIfxsyTvyZv3tUbvA7fUT3FyqV3W10LKZyO7FGPNPPbVeytArY+AUVgyVfIbOpu8bTXN0N717BH3YXNBaDJwMwYG85kyhett6g04=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(426003)(40480700001)(47076005)(336012)(5660300002)(316002)(2906002)(356005)(186003)(40460700003)(41300700001)(1076003)(70586007)(36756003)(7416002)(8936002)(16526019)(44832011)(36860700001)(26005)(82740400003)(2616005)(70206006)(83380400001)(4326008)(8676002)(86362001)(54906003)(81166007)(110136005)(7696005)(82310400005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:25.4015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d85abbd-56bd-4961-daf9-08dac8ef3bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can't easily discover how much of a sleep cycle was spent in a
hardware sleep state without using kernel tracing and vendor specific sysfs
or debugfs files.

To make this information more discoverable, introduce a new sysfs file
to represent the percentage of time spent in a sleep state.
This file will be present only if the system supports s2idle.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v3->v4
 * Switch to a percentage for reporting
 * Hook into timekeeping differently
---
 Documentation/ABI/testing/sysfs-power |  9 +++++++
 include/linux/suspend.h               |  2 ++
 include/linux/timekeeping.h           |  1 +
 kernel/power/main.c                   | 36 +++++++++++++++++++++++++++
 kernel/time/timekeeping.c             | 20 ++++++++++++---
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..60b6948f5982 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,15 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_hw_sleep_percent
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_hw_sleep_percent file
+		contains the percentage of time that the last suspend cycle
+		was spent in a hardware sleep state.  It is expressed as an
+		integer between between 0 and 100.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..e0f2ac5f4406 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,7 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_sleep;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +490,7 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_set_hw_sleep_time(u64 t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..2a81366f3e31 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -70,6 +70,7 @@ extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
+extern u64 get_suspend_duration_ns(void);
 
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..be82f4a740c0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -83,6 +84,12 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
+void pm_set_hw_sleep_time(u64 t)
+{
+	suspend_stats.last_hw_sleep = t;
+}
+EXPORT_SYMBOL_GPL(pm_set_hw_sleep_time);
+
 int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
@@ -377,6 +384,20 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_sleep_percent_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	u64 t = get_suspend_duration_ns();
+	int p;
+
+	if (!t)
+		return -EINVAL;
+
+	p = min((100 * NSEC_PER_USEC * suspend_stats.last_hw_sleep) / t, 100);
+	return sysfs_emit(buf, "%llu\n", p);
+}
+static struct kobj_attribute last_hw_sleep_percent = __ATTR_RO(last_hw_sleep_percent);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,12 +412,27 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_sleep_percent.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr == &last_hw_sleep_percent.attr) {
+#ifdef CONFIG_ACPI
+		if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+			return 0444;
+#endif
+		return 0;
+	}
+
+	return 0444;
+}
+
 static const struct attribute_group suspend_attr_group = {
 	.name = "suspend_stats",
 	.attrs = suspend_attrs,
+	.is_visible = suspend_attr_is_visible,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1de178..49119a942cb2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1779,7 +1779,7 @@ void timekeeping_resume(void)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock = tk->tkr_mono.clock;
 	unsigned long flags;
-	struct timespec64 ts_new, ts_delta;
+	struct timespec64 ts_new;
 	u64 cycle_now, nsec;
 	bool inject_sleeptime = false;
 
@@ -1806,16 +1806,16 @@ void timekeeping_resume(void)
 	cycle_now = tk_clock_read(&tk->tkr_mono);
 	nsec = clocksource_stop_suspend_timing(clock, cycle_now);
 	if (nsec > 0) {
-		ts_delta = ns_to_timespec64(nsec);
+		timekeeping_suspend_time = ns_to_timespec64(nsec);
 		inject_sleeptime = true;
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
-		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
+		timekeeping_suspend_time = timespec64_sub(ts_new, timekeeping_suspend_time);
 		inject_sleeptime = true;
 	}
 
 	if (inject_sleeptime) {
 		suspend_timing_needed = false;
-		__timekeeping_inject_sleeptime(tk, &ts_delta);
+		__timekeeping_inject_sleeptime(tk, &timekeeping_suspend_time);
 	}
 
 	/* Re-base the last cycle value */
@@ -2232,6 +2232,18 @@ void update_wall_time(void)
 		clock_was_set_delayed();
 }
 
+/**
+ * get_suspend_duration_ns - Return the duration of a system suspend.
+ *
+ * Returns the calculation of the duration of time that passed while a
+ * system was suspended.
+ *
+ */
+u64 get_suspend_duration_ns(void)
+{
+	return timespec64_to_ns(&timekeeping_suspend_time);
+}
+
 /**
  * getboottime64 - Return the real time of system boot.
  * @ts:		pointer to the timespec64 to be set
-- 
2.34.1

