Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC3623C16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiKJGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiKJGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:49:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0B2D752;
        Wed,  9 Nov 2022 22:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ediHTmqYSDZozhmnNtuR3VjlmOKD0otkujwCJgWEAJBEN4FXKzsOithKmJAYreqO/etcw4NtKSY7AoJRHKm0loT/A8ycsgJojgdDxEc2+9IoqMQlzcr/3dCYKBHSlJNdgbidBLSJ1u7D3BD3Z9MHsLoKk6F2uRu3Q7jPKP8Xgw4Nhrly7LrkXnPECGG4n2ynJB4kp1tXCnOQDGyBBWPoR82y5zHOltLHmp7r+IEGTg7iMvjrzlRFt4/HxZrhx0FdO5beWFRDGw7Om7+Gf7DQtumYmFYGqZw1zA8hF413+/Cs7LC0YAkgqwaReyh5DkYJ6VZLSqp4uds5hnKv+S2L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcplZ2AaUdxKohANIdm9S+CdjyqW3W6VNIMpelnDjSc=;
 b=frFSRMU/jkZMNkisL45FfN+YYCWpprVedXv2msKarBEDa9vd/9ZX9RUvJiwO0WHIRzUC3QkQTZczFNyeCZ0U3x+zx9uIc0c7sc2q0kyGXJwdKXIl33Sx9xXReo3xOem4+sqgnHFqxnyhSRiT5NfmTwKA0eZxy9qHit4V38i56rv+yR3YbH5PGnaunc5kekL2WjuQNKunbB943x16QncucJhHyd5aPKt0MJT4SR+KkzCKVSP/iba7WpdDVl0P48qr7ZSrQjf7iKjBvOfsOW9zUI8esX1opRBhabxYcNnZ4Nx5xESzTTd0lMxlClDqYQYkDbjhihq80CIy362ezpqq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcplZ2AaUdxKohANIdm9S+CdjyqW3W6VNIMpelnDjSc=;
 b=OHiowf4OhLHnpdBp/AZ2wERyDIcfuFwLQeK+QdsaF9R5BNJ25lbcMV39lV1dalSUy8Jb6QJ3iI+q6F/zqmPqxXrgdCwumU/jYFtdF5iZz51O1vZYxLMlpYp4oftB5nogFndikPxmaJ/SRp6Tmtnp6KQnciYgaefezcjoQU5iuQI=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 06:49:27 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::62) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 10 Nov 2022 06:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 06:49:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 00:49:04 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Date:   Thu, 10 Nov 2022 00:47:21 -0600
Message-ID: <20221110064723.8882-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110064723.8882-1-mario.limonciello@amd.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbf64c7-a050-44cf-ebc2-08dac2e7b5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50ATUK4afSFoNmaik0L4HkU8dCXqepgSq7XWzO4ou1N2XdG+7KabclB+XtVuDE6FPhzWO4PwxX/6K4TjLjp7aEKoB1jkWMuX9m9vtB+gl5ZPzQvEckhu4CxeYg6r5R3v6yGJRvRF9e+pVM9Sxtktoy7jcObSQcNM1BhdfbtbnsZ3UxU/a2Kjw1CQp8YDaP67yEzc7LrxtMk/1UMnOAyr7lxOI1+7Frg/Ufrru69qZVtHmJa/2XpRwWYZx/JL8G5Bmm0P/fafvp00wx12I9WZjPmu0vJKLEzfr4RovUjSxtDpU4hkzs+BzyAVHKKB3mUsy/ncmmHY+1Ves8kMhMgX01ah+C9HEX+yk72KXuWWxHBzt/jWF9K9jh30YJ+8vLL/qc+yPlCSUROK4FB95U6i7JYgpNvEuSNKyVzX1Xg6NxZM0ahGZ6tPz85REz328XZl8e9JLxbakh8E33OEKkcfH2bW+NZcg/ZoayBohTSCsQfdlRZCoqgw4ADRQSGc8yGOomvgKXypU/vvubF7O8RVZ4uE5ilX4QCz7sVdOnGkwt3O+biy30ztc9lKApF1spFO9NMs5+LiL7HDwgjAfieVKOZ1bTpHOKx64B3OWHgL5dDuAtXHGRrZkko/x+WqV3GM4JTIEu3OK/JfWOIzHe4PjHGvXIK8Fjk9nNnuB8EwfAi3IsLNWq+khKwBVgWLUOMeHmjso5u0slJWRmAbXutKwLJn1TvksThuhvviNLokeuAaUtFy6Zxj6Q+orDEX/3YoGCA5x/VFsxbFkDp6uZqZJpAqL4mz7oQuYEm91NcnVVmdXB16JsPAUmVwU2LBp8Ut
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(66899015)(81166007)(86362001)(44832011)(47076005)(7416002)(2906002)(1076003)(26005)(426003)(336012)(83380400001)(5660300002)(16526019)(7696005)(186003)(36860700001)(82740400003)(8676002)(8936002)(2616005)(4326008)(41300700001)(70206006)(110136005)(316002)(70586007)(356005)(40480700001)(54906003)(82310400005)(6666004)(478600001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:49:26.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf64c7-a050-44cf-ebc2-08dac2e7b5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD and Intel SoCs have a concept of reporting whether the hardware
reached a hardware sleep state over s2idle as well as how much
time was spent in such a state.

This information is valuable to both chip designers and system designers
as it helps to identify when there are problems with power consumption
over an s2idle cycle.

To make the information discoverable, create a new sysfs file and a symbol
that drivers from supported manufacturers can use to advertise this
information. This file will only be exported when the system supports low
power idle in the ACPI table.

In order to effectively use this information you will ideally want to
compare against the total duration of sleep, so export a second sysfs file
that will show total time. This file will be exported on all systems and
used both for s2idle and s3.

Suggested-by: David E Box <david.e.box@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-power | 17 +++++++++++
 include/linux/suspend.h               |  4 +++
 kernel/power/main.c                   | 42 +++++++++++++++++++++++++++
 kernel/power/suspend.c                |  2 ++
 kernel/time/timekeeping.c             |  2 ++
 5 files changed, 67 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..5b47cbb4dc9e 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,23 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_hw_state_residency
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_hw_state_residency file contains
+		the amount of time spent in a hardware sleep state.
+		This attribute is only available if the system supports
+		low power idle.  This is measured in microseconds.
+
+What:		/sys/power/suspend_stats/last_suspend_total
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_suspend_total file contains
+		the total duration of the sleep cycle.
+		This is measured in microseconds.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..af343c3f8198 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,8 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_state_residency;
+	u64	last_suspend_total;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +491,8 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_set_hw_state_residency(u64 duration);
+extern void pm_account_suspend_type(const struct timespec64 *t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..11bd658583b0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -54,6 +55,19 @@ void unlock_system_sleep(unsigned int flags)
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
+void pm_set_hw_state_residency(u64 duration)
+{
+	suspend_stats.last_hw_state_residency = duration;
+}
+EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
+
+void pm_account_suspend_type(const struct timespec64 *t)
+{
+	suspend_stats.last_suspend_total += (s64)t->tv_sec * USEC_PER_SEC +
+						 t->tv_nsec / NSEC_PER_USEC;
+}
+EXPORT_SYMBOL_GPL(pm_account_suspend_type);
+
 void ksys_sync_helper(void)
 {
 	ktime_t start;
@@ -377,6 +391,20 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_state_residency_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", suspend_stats.last_hw_state_residency);
+}
+static struct kobj_attribute last_hw_state_residency = __ATTR_RO(last_hw_state_residency);
+
+static ssize_t last_suspend_total_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", suspend_stats.last_suspend_total);
+}
+static struct kobj_attribute last_suspend_total = __ATTR_RO(last_suspend_total);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,12 +419,26 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_state_residency.attr,
+	&last_suspend_total.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr != &last_hw_state_residency.attr)
+		return 0444;
+#ifdef CONFIG_ACPI
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+		return 0444;
+#endif
+	return 0;
+}
+
 static const struct attribute_group suspend_attr_group = {
 	.name = "suspend_stats",
 	.attrs = suspend_attrs,
+	.is_visible = suspend_attr_is_visible,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..b6c4a3733212 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
+	suspend_stats.last_suspend_total = 0;
+
 	if (state == PM_SUSPEND_TO_IDLE) {
 		s2idle_loop();
 		goto Platform_wake;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1de178..e1b356787e53 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/audit.h>
 #include <linux/random.h>
+#include <linux/suspend.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -1698,6 +1699,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
 	tk_debug_account_sleep_time(delta);
+	pm_account_suspend_type(delta);
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
-- 
2.34.1

