Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9546DFF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjDLTuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjDLTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:49:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132F72A9;
        Wed, 12 Apr 2023 12:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg1h/Z5iTSTYA8XIeYs6RUYIRzHAVb1J1xDj95ZVy0eT7MBGshJY7aoDYWijkALoUxwgYmqw2y8pcIQTgPMRHAAPCAFhYg1RgArj1IpuEZxxvDOsqefRl8L8OrkaX+Y9EHUDwnaO+E6ccuBZKhNnFHQdP3nJpgrXWM23Z5prACxsiNM0qJL7c4Or1A/42AlNDjFPILE8svv0UJGqS2AqjKppycRBFHKWBmllTVdNx6I/PUQRsCQ5wzNO5JIl/V+q68Q7ZEXnvLQhocg4hCp6+V0Khg+Q+kPylGxI/BXcR9mjqyyeHS5+0RxMfSYTJMLXs/qzu8yBTGcl9z3hKZqPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShWWw2wVhhkH4z6IvzIsoi7Ih8udnCG50Wc55BRZPCw=;
 b=jmcvcJpwz09HCx5YKtjAP9W8gCND55bVv/4VOkYQ+r1N6x9m06kOgxHXIqIz1hzhAjDU79OdAUwGo7Qmcmeh3hyTp6EtupVo+wTd1MY9D42Ip+bPCWpuVOrKq8chqDERYw7GmqHpnLH0bYtgPhGEZlbIUsiCnEdvX6VFpxKo0IqYScz221UJGe7Du0ksS8igSmT0GYlKzLYBv4S4McgBQqchrVkmZsQ25J0vPErSHkPQM5cVAMv8a7N3SPUly+K/9h1EVHc5tYxR2mS4WaA7emYKPctJl5XmE5K31jK0bzJbEj2ATvuHlx6b+xFFHCsALeYVOHy3O1ghVrtClXxVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShWWw2wVhhkH4z6IvzIsoi7Ih8udnCG50Wc55BRZPCw=;
 b=FqOB5e9AvuK7VUYkvJaAWDNnJTrfZSLJ7x37OsyuyBPKutU1hPzgUjHfyCkQtQ6AB4Nz1JrWhnTN3Ix0jVL+AjYVsVtQeeCvgGq5EhD6f/C7KVAlJ47FI+8c/VYYdaotKboreutg4/haF0RXeILwM7VbRD8m8tFxT/woEGzugWw=
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Wed, 12 Apr 2023 19:49:37 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::1d) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 19:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 19:49:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 14:49:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 1/4] PM: Add sysfs files to represent time spent in hardware sleep state
Date:   Wed, 12 Apr 2023 14:49:13 -0500
Message-ID: <20230412194917.7164-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412194917.7164-1-mario.limonciello@amd.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aec9210-6ccd-473b-0b4e-08db3b8f0c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eftf5+JUKxiBMA62Aw/JJvooY8ext03p8JlCnVJy7S3J7MqDG0ARpm6nenN+lrgHlEbQ+T2AUtiICYGfqqzryce69rRxpMQP5L+lVFFNrjQveotxvAie/gMSbui0P1dDa6JzDn79ZFVjwD5EUyt/Nw2ACvvxk4kH4LG3r/j/fFJ9gxrBDibVlgDURUTnihKcJnzPU7HQvodkXXTWhwbDgY8nXyfSL0xgAKzV6wZxLkWjHLqFus+lumhg+cGWZunP+zH1MdR/33WCtEDtnxTdIdaDdBEY2DbWGgl2lrwXTdSyA5sMBFKm6cbe4mlDa50gjazYJ6ra00v42exJzyQePMJdY5y+VKeeu/HfiUAVnYqpZbp6nToL4u3K4I5/NgGSnY6Hin1KS7D14tUGIT4rOIFPmFIYMRme0Zm4qBD03KpKzY8H03PsJAZiMGn0fvXZ7U0LcBqGLu26qte5F8N/3mjCIp9r+pfMw2onp+BkdlXK9FeeZzlNViAlVJi+G8NQPBiqrq43VyDRcj8QyalizPk0C7zimVWKHMtJQ3cz7DCYvGvh0AHhiE9MOmvs8uO3MpIwcwculwcxPvAY03+746XFfSihwdgLL8njUO2DANCkoBmVjYpQBdeIC+AOPjbKILmJcr/G7KxFNKCAKxlFqEKEPSgqopJ3ldhvZmcBp3FHrAisBEMFYzhjgTlWRdpbdAu3IOsNnEV4BtalWOXznLD8gGNe48cHek5KRgUBvNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(7696005)(26005)(110136005)(186003)(16526019)(5660300002)(44832011)(54906003)(1076003)(316002)(2906002)(4326008)(70586007)(70206006)(6666004)(82310400005)(7416002)(8676002)(8936002)(41300700001)(40460700003)(81166007)(356005)(82740400003)(47076005)(83380400001)(40480700001)(36756003)(2616005)(336012)(426003)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:49:37.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aec9210-6ccd-473b-0b4e-08db3b8f0c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

