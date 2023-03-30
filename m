Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8C6D0F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjC3Tp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjC3TpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:45:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33435A2;
        Thu, 30 Mar 2023 12:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em3qWV5eWnkxmu4Qu14uMqJxnQfkKj0QL5Oba94CPhl/YB+83jWeQ/jWst5gDVY1vjqW0NFAfD8wUJipYzl7Y7I7bVIlmPqTrsaCM1WP29kILzirOmcA30AoCl2Qv+qTT3HzWxFAu39H2aDaigrvzmTavEmBjNNsp4b2mUESlsrxmRMJ/XLP9YPRFraMuLuYAD+LZgdYbJlPIId9CpP+YyZjC4YYq9DNn7RfkNhiskGE+YCSDE5ChVbzQU5VAKco2YeFtu+ZEf/2ngCfAzqs4Y2tvpDlFMUDIAqHWE4AFv0gVg/ZE89F2KdrwUNl0VRsmPqs1iTpUX8vKtR+N+HODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kDWPvMUZWAnWraORs8P6U6f7WmUSRF0sf7jRyDbBzo=;
 b=KB0pr9w8BKamXZReizwLnPrIB/s0m6xJNcpJ/ZYKuh78lCsw2rBRkzCuJBdfuthdIz4KEstxpIxYahUBBE9LMthLBmTXMQNWq6fcjhwgsXOca69kxCk7b2emBBHCbZPXV43Ohp0yhUyvOe3j4d2ZK+/PgzYXW3zsBlzxJh+moWn7hu+eerUzmW12lhRW5dfALN3dabC8cmKCfp92LYsYGs8Q+Q67k/2CuCP3EyjFjt0DfKrz5L2nIPFrgcxop99HzewaHu38NAQvqUdk1QHAgHi3Ah6j3c5YagQJhrGyMPKJ/+byXqwIs+ze/tggrta6oTLyA45PdnHltvF5/4TZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kDWPvMUZWAnWraORs8P6U6f7WmUSRF0sf7jRyDbBzo=;
 b=WCSbQ5coB/xiW+9cVbZcm1QHywz6eA8Vceodp9nJI05cbWkYo8WiYN3zeWif0zIam5D+GIC/1Pd/QIq1nnMF7xeZThPBS2YlA4ni14aHjqZNntbJpteyXxrGMZrEXs3TdQlZo4KvOWmd8NDsO1kUI7VZYuS0ZERiZ5Fi9bB4Ggk=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:44:57 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::8b) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:44:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:44:53 -0500
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
Subject: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in hardware sleep state
Date:   Thu, 30 Mar 2023 14:44:35 -0500
Message-ID: <20230330194439.14361-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330194439.14361-1-mario.limonciello@amd.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5612d087-c164-42b2-17a4-08db31573cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1+MdikbRYoWc7y0Ir4EK/4jRCq+unCaEyE8NqhleZTdQB3tSV09qTdSzZKCjMSV1jE95qEydnYQXfczp5hhpuntraU/ctl33TW/t0XhuL3iCyjQi/41Emhvn0eSaM7QataC16z51zMRboou3Kn2IbipfQJA+l7Ac740ZWo9dF+3ZV9LN1vWBlU59oIHBxiMwzFfgj/uTrVLTuJWv7OE8xLcpmESlDqTO68NuN5TEUoj+b6dcOs00zncWRfgQ7hbkYPuVv4pVkAE7QFUID7K60SJwdHeh/G0R03cqYzrUcwKpK3D6evc8vbB+y/nz6aCOJXbf10J6wMJ2+v8eqc4YsZqJPkUbPq6lMUySNaXm6b3DRQlu9l/b6GySvPyRWj8Ah2h143WxUS97OODr2UJGtkWKHcjkYuVS8RUCzMDf7/bkMxfBC30ubB7AetzD7d9t6XV5ds7HUtFdY723Cv0+25usb5RcfWnXfhxMJlGo3dkMG62NrO86QAoCUMJxZHNloIMteyMtISv1ZNlbOnZDi0AfGpE+H2bO0gfAdpLzWQYChdIb8QL1gRfj2hTf/cQGBJ2rfYS99lVGeu5sp6oCEqZKQn4kDAncC0EoEaAlGzTQDApMlSkYWhJRrJEHfbPVIPHtBRHS+zs7+XWsbCFyfOQb+iQaITsED4JpedDN0fsq9GFev8EFqF9/mGOFwagoI1dCuzwxkjjPLYgTCOQRwvJhg9e5wLEagN1PDiprk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(82310400005)(186003)(4326008)(16526019)(8676002)(478600001)(40460700003)(54906003)(316002)(110136005)(36860700001)(6666004)(40480700001)(1076003)(26005)(36756003)(7696005)(44832011)(8936002)(7416002)(5660300002)(47076005)(336012)(86362001)(83380400001)(2906002)(426003)(356005)(41300700001)(82740400003)(2616005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:44:55.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5612d087-c164-42b2-17a4-08db31573cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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
to represent the time spent in a sleep state.
This file will be present only if the system supports s2idle.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Provide time in microseconds instead of percent. Userspace can convert
   this if desirable.
---
 Documentation/ABI/testing/sysfs-power |  9 +++++++++
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 29 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff311..9e0c31b9ce85 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,15 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_hw_sleep
+Date:		June 2023
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_hw_sleep file
+		contains the duration of time spent in a hardware sleep
+		state during from the previous suspend cycle. This number
+		is measured in microseconds.
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
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..6a2bf8784ce8 100644
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
@@ -377,6 +384,13 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_sleep_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", suspend_stats.last_hw_sleep);
+}
+static struct kobj_attribute last_hw_sleep = __ATTR_RO(last_hw_sleep);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,12 +405,27 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_sleep.attr,
 	NULL,
 };
 
+static umode_t suspend_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (attr == &last_hw_sleep.attr) {
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
-- 
2.34.1

