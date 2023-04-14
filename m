Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1176E19A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDNBYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:24:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9110C9;
        Thu, 13 Apr 2023 18:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRfVnT375pEzDJbdT1sNJ/JZdy2qEdx/v0XEJ/Em0cYzcQNYKKKXlOWBo46TmZ0an43D0Sl7ROUqCr91mvu2VC+H8p9tlg6DCQOdntblYhGO80zK9ol7e1p4TEGTp9ZTp1bIM/rtjiJgapy9ixE6KSfI6Ar0p/EHz94PoTjWYpCpFHm9kCfgJzOLML7aSZjQ2HKqDgBZY/bvwLC3viaj+noAxaA8xGrHGXz7rWsiqoNRpofTWzjMHhZvfWF66sJUo/8ROrjASQnDmeUGbCKBIGM45RkDDxVcSk713Vip2OMdEHre46ZxzXr9kDFLSzg7HLI+AvQCAWvYfzMhxdLNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShWWw2wVhhkH4z6IvzIsoi7Ih8udnCG50Wc55BRZPCw=;
 b=mLuiLxppwb8B1K6fM5aKfOY1Mv2OWxpFKEmaUUh1lGF6MBInrRo3OSsOCyksQt36mad/V5AabK+iEaDEoF7N4NYvBvR/ed8WmaxBF6iLkuoSPk58hAT5dNqNeiV6gjWiAaSkKZIGLRWypu9mtI/i8em7vgqQnL0nT41d+PKMsIDAQiJB8s4keYpMIpuk0bWKQvRO+mu/XZl8xSL8CZEw9DwQoezMZlItdNI2C2uFS5gmfx5YFtcqrvP13EvkKNMuD7CfeWVsLs9WNgtMckhd8GHAXWnLuOF73X5/0CP9unB7SZs4tXpujrtyme4/x3vIHjl5heV32gGFlDX25JpLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShWWw2wVhhkH4z6IvzIsoi7Ih8udnCG50Wc55BRZPCw=;
 b=JYaMY72VxhKItestMbyzjyu5Cp/+UuyeGplFk0UoIc6tjwJP0AguC5VuKlTFHtJcRyCZDwNl3VTw5DEOJzwXgIWHvhNaLYIm8ScCm8f3A4bUxqzbGPLjft7etl7Jd4JP/leOPTOzttikP1b4hFQ70IogxD6ixlRKeE1ZF4RR7EQ=
Received: from DS7PR03CA0111.namprd03.prod.outlook.com (2603:10b6:5:3b7::26)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 01:24:25 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ab) by DS7PR03CA0111.outlook.office365.com
 (2603:10b6:5:3b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.33 via Frontend
 Transport; Fri, 14 Apr 2023 01:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 01:24:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 20:24:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v9 1/4] PM: Add sysfs files to represent time spent in hardware sleep state
Date:   Thu, 13 Apr 2023 20:23:42 -0500
Message-ID: <20230414012346.1946-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414012346.1946-1-mario.limonciello@amd.com>
References: <20230414012346.1946-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|BY5PR12MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e0ab2c-58f5-43e1-2034-08db3c86fbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TwWmoXMB1zPWSnACm2qg3N70sQXMQcisbG2P/zb6jhIbITnIQXo4RaGWimsszr/Wc3UbGGl7Tj/qc8frGdvgrlmhuiPUn3JMBa/liwSybWnJdukTZEk5EnmCrPy5faxw5Scw9k39XVb21F42YjuLLhauE/IJWfUZajRQu6KaXF6+TbYRdgQ0WRANqlccolpCELNUAdS0e36qy2QkIbf6GxG2Ct7iqnlgEtNMYZeph+IT2pf74ioEyFGHDJaVNxd/i+vU8yJyoLZsKQqorYK4JeUqoajmMqUtSL9JpyzrQGC0rxkvdD66NDbvO38w2rcfRcSOybVFlVXU8PbH73NkRPP5zZklpqwbWe/6arS5Jd0UTAYoeGnc/kX/p4A6owiZLMxf+0KtW6TzXQBQG+00QBXDA0omyYcCrs8WBSFDQcwvwmjAYGWfiW84WlOPw2LBjGNv/NQGVkVrpklEZPmTbPrMalNm3/ZUn8dFGdFuL7HLEZlTdfYpe6xknprngGaDtIBXxuVK1ng8izSw8R36qpxGulCr6C1qrqm0z/5GiCI4bBs4QhqNZi7hd/A9Kt+pybw7No/3IQ0fa8QV0jzlwdhK/jWXGd/TXiBZ22RCLj7UH8PTcSrnjElQKOz33cMmdON3QiZ0SiMnIc6SakUsNbOqt06IVJgpEDgNQK3OZXp32g+Z+rX8CIfRUuPCIpLGunCbEEEIIAF741viga+VClDP7COfTfWgN1ilK52p+XA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(82310400005)(36756003)(5660300002)(44832011)(7416002)(40460700003)(356005)(4326008)(81166007)(82740400003)(40480700001)(41300700001)(2906002)(86362001)(26005)(1076003)(6666004)(36860700001)(7696005)(8676002)(336012)(426003)(83380400001)(47076005)(186003)(16526019)(2616005)(54906003)(110136005)(316002)(70206006)(70586007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:24:25.1722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e0ab2c-58f5-43e1-2034-08db3c86fbe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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

To make this information more discoverable, introduce 3 new sysfs files:
1) The time spent in a hw sleep state for last cycle.
2) The time spent in a hw sleep state since the kernel booted
3) The maximum time that the hardware can report for a sleep cycle.
All of these files will be present only if the system supports s2idle.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7-v8:
 * Add max_hw_sleep sysfs file
 * Add function for drivers to set max_hw_sleep
 * Modify macro to display attributes
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

