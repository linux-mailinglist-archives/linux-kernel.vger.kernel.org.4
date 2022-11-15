Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289DB62A26A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKOUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKOUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:02:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B128E04;
        Tue, 15 Nov 2022 12:02:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaMM2a7HMASJsZCKApzI0bsl75wKkxild5Oud/59PHjBdFAI7NokQEVlSRiFD0FAC/fu+R2Vv+UFSxdp+X46MAZpkydCIppE7OAk+Vjay3EaGHS03U7MzZyengl4/R7gl4fSc0JU2Yug48hg1jf4DGVzCGmuMicxN/uq96rp3bOK6yulVNhnPgxwlW1a+00i6l+Cfl6gQl1i6vHe4wKA1MkGiRYwbVzPba5jVtIRN0venwL9into56xrovbyXgAizMLHinPaVIz8sk3QH434158ggT5Lldts9KxVSA3EGenOoMJ/h6Te0L9uOQ1+JPtSIn8K0wBjSl62W7VZ0QZR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVMMcO3WWf2cCU/0gNI+bRG3BH7aBwwuOUs+gmWh4R0=;
 b=KoNq+hlW4qy1X4U1mbzhBh3eJfIqpldUXvqnNDMxjFyjU1NN7BRrQI/0IZUrTCaO+XKND/ch7wjTIlMONqFWvAioBCZ9WMc0ruRTSSymTTSKoVL2Gcr/VVPBTT+XgmB3OmkRQl0NJ08SG05q3UKlrGQnbcf2EHSIdJvhrHnQMRPmTiWjRDsDppYHiMRb/QT8xzEpDZNRdOgPb+abbO0lsnCBfYhxypaxq+bovBiKkMGjwuhojsNjUqart5B2uElWfuFo+GvZAeFBTUK24Wifkg2cMHVk+xqTohqSIOhxufqhoMFWbBnhO0aUJbGPreJ/K/j2lGL+G7PRUpnLvKADew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVMMcO3WWf2cCU/0gNI+bRG3BH7aBwwuOUs+gmWh4R0=;
 b=lNzk08AElPweQFTbWtF4wTgYiM9koQutIeXD6ononNX/YHOC/zzJfyP2vja+BVR3aM1EX+LOfyfoPOFqDhO4GfvrB7unrGuo0qQP16r/nj+wfcIONVxeyVdAzqj8dngIuci9OjTOr7n6NfQUjSv3BIwKa6JvJFbCvll/3QyOS4w=
Received: from BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:02:08 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::af) by BN8PR07CA0021.outlook.office365.com
 (2603:10b6:408:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 20:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 20:02:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 14:02:06 -0600
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
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 1/4] PM: Add a sysfs file to represent the total sleep duration
Date:   Tue, 15 Nov 2022 14:01:53 -0600
Message-ID: <20221115200156.12218-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115200156.12218-1-mario.limonciello@amd.com>
References: <20221115200156.12218-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b07378-29a1-453e-9392-08dac7444678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQnVWq8m6aQ3IVp0IchLkjzeM/f/SjBANXTeHuMT8ItBEVL54DyoI8t79aUo5RTRTXOJa0axCz56yUihWctoW7MqZDybNJZT7znwKtbgw9Pzwv+PsbKPdg6pNF/zN+iYCRvJLqd6x4krWGfEUUDJFqMQKlf5DPZ3wsvITezr4a2gC1j357t62oJP/7XqQVe22YqytHPQK4RavouF348UCCEmgHf3waEFy3xcMzPc3RY4Ib/xiyljRHOPS/yTvP/u4m0cU+Ak2UD9DUVFHxgNYMb/AM7qkU8qNtEL+Ewk8p6l72r17rJQ3qBR4LInzJfbLYpzqPWEk8sSSqToz7PMcd4bhGVpRjtUj7ko++QkxDPaoBOXxLbqDgjD1rVgLREn5q2CaeumdUYgY4A83NI9ZfTKqrEhONToIWpuD8tjn6RnCK3QSctZYwXsmIcrv67EFoLIY2wDKZLl1qFHCM4MbjzFj3UsNqMAxFdMkkYqfnwPXcjqQO/grcQ94fS2VuTdprcF2biiqwpqFG/da2ZlPMDUmdfa4pzuCM+egccPpMzYHTME4OEZTgleX4EfHB0uT5v7JD2dH9Tjnd5/r4J0MevTYRqo7axKqXd7XAYxT0Oxwfd56Hk8umBbF+ESZyITLSLCQZZWkpGun2jjXD/fZ28vIdeqkDSZiBOnFhG2JnVbHg7N1Y0J6j8AXnlXJIVhglQqKdou3vXeNdPAKh5rRWDRJsEBxhCQWtvQcTW5QtqGhnj9zCpnFVTGqdPkr6Lbhyw2eoI1K+r9uuwY2sXgBgaO8wZEhjegjwcHVu5TBpuQ4uDGeQR4gy+HVoQZPMmw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(26005)(478600001)(1076003)(186003)(82310400005)(16526019)(2616005)(6666004)(426003)(336012)(86362001)(40460700003)(82740400003)(7696005)(36860700001)(36756003)(40480700001)(356005)(81166007)(8936002)(47076005)(41300700001)(2906002)(5660300002)(44832011)(7416002)(110136005)(54906003)(8676002)(316002)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:02:07.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b07378-29a1-453e-9392-08dac7444678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For userspace to be able to analyze how much of a suspend cycle was spent
in the hardware sleep states userspace software has to use kernel trace
points paired with the file `low_power_idle_system_residency_us` on
supported systems.

To make this information more discoverable, introduce a new sysfs file
to represent the duration spent in a sleep state.
This file will be present and updated during resume for all suspend
types.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v2->v3
 * Drop one of the sysfs files
 * Use sysfs_emit instead
 * Fix symbol name (s/type/time/)
 * Drop is_visible
 * Use timespec64 type for suspend stats
 * Update documentation
 * Update sysfs file name
---
 Documentation/ABI/testing/sysfs-power |  8 ++++++++
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 15 +++++++++++++++
 kernel/power/suspend.c                |  2 ++
 kernel/time/timekeeping.c             |  2 ++
 5 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..3abe20c47e08 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,14 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_total
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_total file contains
+		the total duration of the sleep cycle.
+		This is measured in microseconds.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..57f29ab4176c 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,7 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	struct timespec64	last_total;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +490,7 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_account_suspend_time(const struct timespec64 t);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..f33012860699 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2003 Open Source Development Lab
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
@@ -54,6 +55,11 @@ void unlock_system_sleep(unsigned int flags)
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
+void pm_account_suspend_time(const struct timespec64 t)
+{
+	suspend_stats.last_total = timespec64_add(suspend_stats.last_total, t);
+}
+
 void ksys_sync_helper(void)
 {
 	ktime_t start;
@@ -377,6 +383,14 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_total_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+			  timespec64_to_ns(&suspend_stats.last_total) / NSEC_PER_USEC);
+}
+static struct kobj_attribute last_total = __ATTR_RO(last_total);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,6 +405,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_total.attr,
 	NULL,
 };
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..cb0f72f52528 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -423,6 +423,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
+	suspend_stats.last_total = (struct timespec64) { 0, 0 };
+
 	if (state == PM_SUSPEND_TO_IDLE) {
 		s2idle_loop();
 		goto Platform_wake;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1de178..f9c8cfef8fc5 100644
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
+	pm_account_suspend_time(*delta);
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_RTC_HCTOSYS_DEVICE)
-- 
2.34.1

