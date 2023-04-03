Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04E6D534D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjDCVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjDCVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB603AB9;
        Mon,  3 Apr 2023 14:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnIe7DAirxQQBzWEHS2DtjC6169Gu8Auy9hnyzdIruIlLzowoxtZ7KHbQXTXRgO35emhs6Xg1rxddJfFPOi+dVdD1B6oChMh5+YwvEmoPD0S/0qCdPcg9EsfAiL3C23qp3jzTqbUhX1Ci2Ohg3IgU/2muUEMcae7kVoP3ks3QEVPcyVzfUhkCpOHnh6xpUbhpFTegyQoodvIkyHHrwUqwu3scqRaeXbVtimvIVOIyZ+bAgdT3b4vBsxTFvJRqDKUp7Fy9hoTcmvJJYa/5n4cBbZAwXE8bWU4MqZAj3nkiDhPtFSl2kqJh6KwswVLBgG1Etl4FC+KRa6PcpcLe7MFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X39arzUJ4HO1T4FqdMCbR+xipWwoAq8sO6b5G2BYq3g=;
 b=lb8e687cJgaG9Xp+Gyz0AkP1r5G86Ya358FqBHFt+vQX6w0mudCCn5O5ook6XffYD270QXD5WYH3ruI5brfLShw3mCw2sVcmxgP9mX3Mj4pQ717Nk22xa3eF8TIA1X/Q+N1rZhnByAHGpnIXvkPQJO1GRhx8XXKucLFy8jnZw4xCwPoWVuEdaCJvVF834MEkLObEr29CS9aEVz/9qf73F6o59PK0zZBf0pJwz0Wi5ZrlLSVypfeMoHptRBtJ+0aTz675VvhjZ6LdvVGe2NaGj7MYRSAQIH4L8KN55ijLrUW8hz7QkUWMKlgVzSQ0+nJKoFNQnXBk+eUgN8l8uLEvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X39arzUJ4HO1T4FqdMCbR+xipWwoAq8sO6b5G2BYq3g=;
 b=bwjNbJ92cnqbkhuTjmnrYweH/2kDiUwQawNsylUapMFmRB25kdGmZRyah6ACTpn8QgOGk6v/W4XMTH0C/Jm6kAPOyI8ZlV6XD9gE9ikFY2A3lo2FMsg5WLHpZlc5bsQyKV8TI6/xRaSAo1/FAnFXDcOqQUUZP4I7eKeB/a2sMtU=
Received: from BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 21:18:48 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::8c) by BLAPR03CA0105.outlook.office365.com
 (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 21:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 21:18:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 16:18:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v6 1/4] PM: Add sysfs files to represent time spent in hardware sleep state
Date:   Mon, 3 Apr 2023 16:18:27 -0500
Message-ID: <20230403211831.4010-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403211831.4010-1-mario.limonciello@amd.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8ee78-71e0-4288-3cde-08db348903ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJ3MwNRvmGXNbSlIYvJaU900Qi173F1hIkSMWVi6GD6TfUfuGV4lBXVzO0zgVxFEZna/uD7PxfKhOs9wfO2rAEb609Jbl11YCcadR0EHj5XW/BxSLid3Gbtw4MDFzvk2bo+PSiGLSGfCEDGtRBl8xyrC1K+uMMDlVKwLruToL15jPvTSJVxL8GynNDFKARTPJl4Ur89nBzwgd5quTUTLIBp0/SIQ67ZuLkCmeqWwk/gLWHabq4RfjvTbSXQkXowx8Bu/zh8ZMMLkGS3C+eX/1GqyiB3rDa4XE57y1byhDAUSSVWDZhueP9uA2AZTh42nAV6m6eT48eHDcxoqH59fY3pwvUTS/94OjSWlnxSdniQ2m/ExOmNQF7PnX7wgE+5Z/JJHjwEKDPuT7Vnu7IIxfY7dgMBLRPvBHsMhjFEPvXj8TS3NNz5mO3LpZp+iWwAmvCiY79WIYr0oglPUkcGiNEUcAikjhPNRnAdWWiBYs9KrTWvZyuzuKDeHZMjEQVhSkE1QjdVd8ZXSmSrn9H9L/HulHc2HLCsAKhJC0SPADOOAaUGZtZ/q/MezNKqq+DoWcjTffAwlzRRW4UvuxrxjQLau1DjUo8LuT7LvWB/9CjSeiIxC3sVDHx0LsGjv/tbjjyxQiGPcWB2hrzj3ecKR4J+3kEkPa/EZTb5UJ90b1KrDNf2bSzDGZCK83ihCvozikgRQssMqmV6x4IUqKavYN/4dLo6tIqB3BVyhHRMJ6fA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(44832011)(81166007)(7416002)(356005)(5660300002)(82740400003)(70206006)(8936002)(70586007)(41300700001)(4326008)(8676002)(36860700001)(1076003)(40460700003)(36756003)(110136005)(54906003)(316002)(2616005)(83380400001)(82310400005)(47076005)(336012)(426003)(86362001)(478600001)(16526019)(186003)(6666004)(26005)(40480700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:18:48.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8ee78-71e0-4288-3cde-08db348903ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-power | 27 ++++++++++++++++
 include/linux/suspend.h               |  5 +++
 kernel/power/main.c                   | 45 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..37240575d282 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,33 @@ Description:
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
+What:		/sys/power/suspend_stats/total_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/total_hw_sleep file
+		contains the aggregate of time spent in a hardware sleep
+		state since the kernel was booted. This number
+		is measured in microseconds.
+
+		NOTE: Limitations in the size of the hardware counters may
+		cause this value to be inaccurate in longer sleep cycles.
+
+		If an overflow has been detected this file will return
+		-EOVERFLOW.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..069ef0c0ae57 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,8 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_sleep;
+	u64	total_hw_sleep;
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
index 31ec4a9b9d70..ffd4dd43cbdd 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -83,6 +84,18 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
+void pm_report_hw_sleep_time(u64 t)
+{
+	suspend_stats.last_hw_sleep = t;
+	if (suspend_stats.total_hw_sleep == -EOVERFLOW)
+		return;
+	if (suspend_stats.total_hw_sleep + t < suspend_stats.total_hw_sleep)
+		suspend_stats.total_hw_sleep = -EOVERFLOW;
+	else
+		suspend_stats.total_hw_sleep += t;
+}
+EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
+
 int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
@@ -377,6 +390,22 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_sleep_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
+}
+static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
+
+static ssize_t total_hw_sleep_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	if (suspend_stats.total_hw_sleep == -EOVERFLOW)
+		return suspend_stats.total_hw_sleep;
+	return sysfs_emit(buf, "%llu\n", suspend_stats.total_hw_sleep);
+}
+static struct kobj_attribute total_hw_sleep = __ATTR_RO(total_hw_sleep);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,12 +420,28 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_sleep.attr,
+	&total_hw_sleep.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr != &last_hw_sleep.attr &&
+	    attr != &total_hw_sleep.attr)
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

