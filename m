Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7375C6DE657
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDKVSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDKVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:18:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2B5FD7;
        Tue, 11 Apr 2023 14:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC5GP7se4V69ynVKBByYpr7tY9p7jD65gqmDhfwZ60QRYmMEdHdM3Dyk3ipxI+wGTMZsbyjB+3DRo5Po5cLKLOjavNcM/BmoYEBaECNcPyee97YhkAzZlha+QxG49VAo1KO0eeZDwXQgxTzdZSRfpseqWfYiDzcBpx4JU4aFdYr1bjKSBo5Ywlr3mI27bWE6bRm7pC0fmPWQ0QQkq/XrPzOLK+j6/cC4FYiWZn/p3pWaF14YteCCLa0tHB5BF+ELY1YpmHQbmcvqop2i6BbjcGU3/Lik7MbLJoqyH3eHSRO4Agi+MgpowXn6iio6vzcgmBOuGNPXzq5IQcHX+JSW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zl1CpWpTjn8MPi7sSokbYp4pkQDznbngnV4A659PDk=;
 b=iOe+O/NRca3VCbuafbH7g8IfmLtOrlXfzN02SJh2Jey1whDm4x9SNMHDm1GYdLFTGBd2ALxylyKhCYXqhV09ZrJ8zG55kV6xhceMthRYaJgcaM90qzdJvmF6F7L221vJW2MZ1d5ssn0XFWQtoZQP5mMGksJ0JOinCkom8vB+fT6YagzXNhGDuYjCYQN0wEzRFuEW5vu2oFW8gCWuGtnt1FWM7p4DwRiQfhdSwIBro/i3fcjFaSb/+ZJs3ZCD341AcYZ0UUEPOxPUWXnP1MUp+8J7VeRcv26U95FAbXjQMtRQkOMVGaxFFzyKvc0pBQ/AsX0CnBwYqJxb8RqlvYPsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zl1CpWpTjn8MPi7sSokbYp4pkQDznbngnV4A659PDk=;
 b=tMhpgvyqxGKS//JuohYT309OmYNNSxYvJOILF/kRcYXg7v2U7oCdYz8C1tU0xR5npSx8JuKG1Hx1Ep2ahk3U9z9kF+Ep01IIWeNSQz3XU3wxW5ps6vf97fbINLjuOy5JLIANhwDaB08/bLZ5x1HwY8tqN4oHbDa83Ht8BmTPKiI=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 21:17:50 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::44) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Tue, 11 Apr 2023 21:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 21:17:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:17:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in hardware sleep state
Date:   Tue, 11 Apr 2023 16:17:15 -0500
Message-ID: <20230411211719.4549-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411211719.4549-1-mario.limonciello@amd.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b437f3-e509-4c02-1cd8-08db3ad23486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnJp3upJMsuCxtcBZcrQ341CKxBsEVhJgNHK/YOCIghg4sRzUcDcNGxEMOwfzYznRMPB4eTtuxNkTlUWlpS6spfVYELHirVcoVuYFJVYyZRMWgif5J7dCGx8ssRSuk2vwYcygT/aJIzu6/yJq3wv+2YnaJPmP32LC8BxWQSPsA1iZdRjMUU4PHgUoUzxY8UVXhvzlb633q3IYxvT1kcbk+ANSP7UgLLqbrWyy7WYk/A/4LOZ4Jq2D10Cy0B6uoNNoNo2WqnNYdSMPTQint+XivSfqKI5D8egeHOec9n7y50u7I811OQHP0WX48TclfJGNlJq1YAUKWTPwQ2Ik9H2ucl76xa+A8UWwzUNkoou4qow9jBQnwATTzfZVj7ov5UY/6MsX6dryOQqrlHqExbf51vNAHxdf20HufFbVL/5S7KzS/6DMcv5Pvr0RcOhRjdjRiHzH//pwU+U8c5ly790CSXPyE0CaZVYqOd6ylNnt7mYKu8IhQ95TiChq/3fRuHo/XFKQg0mPNCWkt9Ceh5BtnLv0IUkbObWnnk+AGkZYZBGoTGIuKOiblVg1uwfVm+FGVp2qSzjfhGN5Hocus7+9l6JhfYVbNsjzwrvltQp3vyE2N3d1Ezh/5IElLPNX+RdixX0EDNeC2QfNBoxT7HxuoGSNiJUkpbspq3PtIaqBd4+bE3XOWs9XOfIbiIvWhqx0mawnhZ3RialwTl1RX2/1coOQ9M7fj4cnuQ4O4V5IdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(44832011)(7416002)(40460700003)(82310400005)(2906002)(5660300002)(8936002)(8676002)(40480700001)(86362001)(7696005)(6666004)(26005)(1076003)(83380400001)(36860700001)(110136005)(54906003)(478600001)(47076005)(2616005)(426003)(336012)(16526019)(186003)(70586007)(70206006)(82740400003)(356005)(81166007)(41300700001)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:17:50.1336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b437f3-e509-4c02-1cd8-08db3ad23486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can't easily discover how much of a sleep cycle was spent in a
hardware sleep state without using kernel tracing and vendor specific sysfs
or debugfs files.

To make this information more discoverable, introduce two new sysfs files:
1) The time spent in a hw sleep state for last cycle.
2) The time spent in a hw sleep state since the kernel booted
Both of these files will be present only if the system supports s2idle.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6->v7:
 * Rename to max_hw_sleep (David E Box)
 * Drop overflow checks (David E Box)
v5->v6:
 * Add total attribute as well
 * Change text for documentation
 * Adjust flow of is_visible callback.
 * If overflow was detected in total attribute return -EOVERFLOW
 * Rename symbol
 * Add stub for symbol for builds without CONFIG_PM_SLEEP
v4->v5:
 * Provide time in microseconds instead of percent. Userspace can convert
   this if desirable.
---
 Documentation/ABI/testing/sysfs-power | 24 ++++++++++++++++
 include/linux/suspend.h               |  5 ++++
 kernel/power/main.c                   | 40 +++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..0723b4dadfbe 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,30 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_hw_sleep file
+		contains the duration of time spent in a hardware sleep
+		state in the most recent system suspend-resume cycle.
+		This number is measured in microseconds.
+
+		NOTE: Limitations in the size of the hardware counters may
+		cause this value to be inaccurate in longer sleep cycles.
+
+What:		/sys/power/suspend_stats/max_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/max_hw_sleep file
+		contains the aggregate of time spent in a hardware sleep
+		state since the kernel was booted. This number
+		is measured in microseconds.
+
+		NOTE: Limitations in the size of the hardware counters may
+		cause this value to be inaccurate in longer sleep cycles.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..819e9677fd10 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,8 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_sleep;
+	u64	max_hw_sleep;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +491,7 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_report_hw_sleep_time(u64 t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -526,6 +529,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void pm_report_hw_sleep_time(u64 t) {};
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..a5546b91ecc9 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -83,6 +84,13 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
+void pm_report_hw_sleep_time(u64 t)
+{
+	suspend_stats.last_hw_sleep = t;
+	suspend_stats.max_hw_sleep += t;
+}
+EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
+
 int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
@@ -377,6 +385,22 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_sleep_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
+}
+static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
+
+static ssize_t max_hw_sleep_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	if (suspend_stats.max_hw_sleep == -EOVERFLOW)
+		return suspend_stats.max_hw_sleep;
+	return sysfs_emit(buf, "%llu\n", suspend_stats.max_hw_sleep);
+}
+static struct kobj_attribute max_hw_sleep = __ATTR_RO(max_hw_sleep);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,12 +415,28 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_sleep.attr,
+	&max_hw_sleep.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr != &last_hw_sleep.attr &&
+	    attr != &max_hw_sleep.attr)
+		return 0444;
+
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
-- 
2.34.1

