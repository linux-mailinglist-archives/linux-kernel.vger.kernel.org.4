Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB86E4D22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjDQP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDQP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:28:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE5BBAE;
        Mon, 17 Apr 2023 08:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFoDYg/2YryYmMr3rS3eigEKJ22c7vgw8cPJ08okcDcjapTMUIuPHnQjNlNV3Fx688zyy+5n/VBVw33HKB9nAfGM87Ke8vl5DYk2Kqe03X1c7zmH7yx4IHFsc73oLj0Qcvy8rnDS7GegdB/xb3bAfsrQu9vrNczSBktiL7PKggZttz6raAwS5ptqoN9AOLaLMaqR6/X3++DgByYSnSKow3DxRrorNLNsLH8rCjdcTyFVgky7woatN94wOMZm2AC/5VAt60y0oEzp5xVIRWIKLf7rbKrYj++IAi2jrHv/7QtuLw06a6v7EPwSXuzyoXOz/UJ1Q6DaCnWY2Jt042UOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iz/F4CiSjm5AbQBzF+Y2/+001VLhR97nY5lT9pCJ9gM=;
 b=W8lJh0pJNPzZ0/CPqZ3Ds0u08SdZGPgI/LpQT1eFlQhXeOfMTZlA7L2zM3IEnSp6v7C2spdG9lG6bzRecyv4L1AjlZNsN68JnUCesqVYN9ZlxW2m+Wdir7Prc5y/t5fcMPglaOTueC9XDalnfza+8GOlrjl6vY92rRMfHiGNMuv1T9A3Y/ZwrOAVeAj58FHRZ2qDFDylSEiDpjOsz7idF8+6wEMjXtQhiAsFSQjxGg+8LKP0jTt/0kZHO5MmARMWe+ZxsQiSwljzVkfaK/s+tYkA980cxQ3VN88pNTmEJJz2fAvoq9pBPiwfnnHp+p7iKMNMQvcO0fmS99XTpKJcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iz/F4CiSjm5AbQBzF+Y2/+001VLhR97nY5lT9pCJ9gM=;
 b=BXuF2c2k77G9o7GYpdbAp2qiv0gS2D+AAm2kWLoCfV+aevmUPg396sQvC0dqXNpe4PPOSZpmM/+A5SYO8Amxma3WITvT0O4b3jY9LoHC54TjYlBF2sClLWJAMW+I8YoR5jAxDmpwDUaW8zsXGSrx9xju/J98YzPccL34Q+wWSAg=
Received: from SJ0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:a03:333::20)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:27:28 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a8) by SJ0PR03CA0105.outlook.office365.com
 (2603:10b6:a03:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 15:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 15:27:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 10:27:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v10 1/4] PM: Add sysfs files to represent time spent in hardware sleep state
Date:   Mon, 17 Apr 2023 10:27:05 -0500
Message-ID: <20230417152708.3599-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417152708.3599-1-mario.limonciello@amd.com>
References: <20230417152708.3599-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c04b0a7-6775-47b7-e182-08db3f58409c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlbl3/soZP6SCZP42pwFdopVrCqfDWnM5+WpSKXRESu9xgYZsEsbBluElVExsbyJePjsV+uhfSvN4DjpPnmkYajFdxGxhaVCGYj303mPMqVCdFXNq69oKGBrMDqOXiMwSh5kJrXHsn5C+XOo9C9RUzxCY6md7zep1r+y+KJtYh2EIMKbbdKcwBq/5zCQv0eR6HCgJk7sGs4YCxHVj89Nw/VAph0yHPlzjiqSsrKmwTyjRwFAqIf0pvjXDT/smsjQb65Qn5gf5Sc9dBbmqC521gxaEUQoH2D/tVByYoeZeDxT280ozxTC951tYMZYXi6AsrOYCqZ1tGcSjLzPrSJvq6I+MGOHvT4QoEX6glcpKsAociERvVYWXp03Rw1MfL5zqhFuNOVYuTsNJroAbBiaUXlbzo7GkfkgyitX9oL+OAmC23zP/W5bAiG5DYYdAvK9WGATwDinQDqJOf9uABQdJbggdl/LFZ0yxH7dUAoqoaDR98Z7kcauzgdx1xgRW12VReyZACipBg/KdCvZpdAvsbntNXbtKk/RcQGJAb9A4mcw0NxMQDJq9zCdV2vY4fTBZjTn88dwpWR4fFmx9+3jaGa3tzGZofVW3rrgpi5vKGItG6B1SYbcAkpQRfOjZHnn3x91S74x1nAe9+DVN+r2tgTo4JEpEm8Bzz2Tdsil46qX9yEkgCg5qynU1eObRgNDbbmIg+YHRhwNCiqvrGEEjkLXGHib58XgJF+IXGVHKNk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(6916009)(4326008)(40480700001)(70586007)(70206006)(81166007)(54906003)(356005)(40460700003)(16526019)(186003)(2906002)(36756003)(26005)(1076003)(336012)(86362001)(83380400001)(426003)(47076005)(82310400005)(2616005)(36860700001)(5660300002)(7696005)(44832011)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:27:27.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c04b0a7-6775-47b7-e182-08db3f58409c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can't easily discover how much of a sleep cycle was spent in a
hardware sleep state without using kernel tracing and vendor specific sysfs
or debugfs files.

To make this information more discoverable, introduce 3 new sysfs files:
1) The time spent in a hw sleep state for last cycle.
2) The time spent in a hw sleep state since the kernel booted
3) The maximum time that the hardware can report for a sleep cycle.
All of these files will be present only if the system supports s2idle.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-power | 29 +++++++++++++
 include/linux/suspend.h               |  8 ++++
 kernel/power/main.c                   | 59 +++++++++++++++++++++------
 3 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..a3942b1036e2 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,35 @@ Description:
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
+What:		/sys/power/suspend_stats/total_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/total_hw_sleep file
+		contains the aggregate of time spent in a hardware sleep
+		state since the kernel was booted. This number
+		is measured in microseconds.
+
+What:		/sys/power/suspend_stats/max_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/max_hw_sleep file
+		contains the maximum amount of time that the hardware can
+		report for time spent in a hardware sleep state. When sleep
+		cycles are longer than this time, the values for
+		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
+		This number is measured in microseconds.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..d0d4598a7b3f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,9 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_sleep;
+	u64	total_hw_sleep;
+	u64	max_hw_sleep;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +492,8 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_report_hw_sleep_time(u64 t);
+extern void pm_report_max_hw_sleep(u64 t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -526,6 +531,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void pm_report_hw_sleep_time(u64 t) {};
+static inline void pm_report_max_hw_sleep(u64 t) {};
+
 static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..3113ec2f1db4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -83,6 +84,19 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
+void pm_report_hw_sleep_time(u64 t)
+{
+	suspend_stats.last_hw_sleep = t;
+	suspend_stats.total_hw_sleep += t;
+}
+EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
+
+void pm_report_max_hw_sleep(u64 t)
+{
+	suspend_stats.max_hw_sleep = t;
+}
+EXPORT_SYMBOL_GPL(pm_report_max_hw_sleep);
+
 int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
@@ -314,24 +328,27 @@ static char *suspend_step_name(enum suspend_stat_step step)
 	}
 }
 
-#define suspend_attr(_name)					\
+#define suspend_attr(_name, format_str)				\
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, "%d\n", suspend_stats._name);	\
+	return sprintf(buf, format_str, suspend_stats._name);	\
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
-suspend_attr(success);
-suspend_attr(fail);
-suspend_attr(failed_freeze);
-suspend_attr(failed_prepare);
-suspend_attr(failed_suspend);
-suspend_attr(failed_suspend_late);
-suspend_attr(failed_suspend_noirq);
-suspend_attr(failed_resume);
-suspend_attr(failed_resume_early);
-suspend_attr(failed_resume_noirq);
+suspend_attr(success, "%d\n");
+suspend_attr(fail, "%d\n");
+suspend_attr(failed_freeze, "%d\n");
+suspend_attr(failed_prepare, "%d\n");
+suspend_attr(failed_suspend, "%d\n");
+suspend_attr(failed_suspend_late, "%d\n");
+suspend_attr(failed_suspend_noirq, "%d\n");
+suspend_attr(failed_resume, "%d\n");
+suspend_attr(failed_resume_early, "%d\n");
+suspend_attr(failed_resume_noirq, "%d\n");
+suspend_attr(last_hw_sleep, "%llu\n");
+suspend_attr(total_hw_sleep, "%llu\n");
+suspend_attr(max_hw_sleep, "%llu\n");
 
 static ssize_t last_failed_dev_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
@@ -391,12 +408,30 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_sleep.attr,
+	&total_hw_sleep.attr,
+	&max_hw_sleep.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr != &last_hw_sleep.attr &&
+	    attr != &total_hw_sleep.attr &&
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

