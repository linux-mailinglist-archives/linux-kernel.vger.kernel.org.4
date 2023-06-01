Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4792B71F6A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjFAXaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFAX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:29:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF7132;
        Thu,  1 Jun 2023 16:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP5QnPQDlRh4HCozYq9Vh9XOok/Z1xDN0mbXpzGn7+x/fClHI+2eFF9m9BE3kSFuxORU+bovDFbTqWonECTgZonUzCWphJ1A60bIKUHAX3YI66cuAigNVBaC05YnlTNsX0wvMWUBZIIccO+NURjcaSeZRgvDaUEYB+Lv/mUKnKmPUWb7m9GdUSj+Uya8gUEx0z9v0QOFseqyMoqA2JSTDPzblPi1fy0VghgD8/XXAjVOgW+918Kiq1YhmWYb6OV932fQiWqIhZitvOHyRSMbRzmg/GRrFa/6eFq5bGOQjx9VxU3j6yueT4xhFDTUBI+dUJt6bwOcO4FKYVzaDGJtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeoHFlJ4HX4hZtRkOHcQEXnwYMnU3F+8KWm89Ri2Sg4=;
 b=NJosYzfAp2axGLkHg3xh5wm//DcBIp0nuI7vsUV1OXzHvrfUlKW9LFnzslVt1VOVmOx/iN0GHwGYdoFBFQzS35Af8WDUllptwN695A6z5v75kpFabiU/9RLnrdl/oCK331aLcEt66O9l0ZvWkGK7aloTiOGAkqhR3YRvbbFdeiBKuGIqNi4vXyq5fWdPFb/YRttZDF2azs9G4PXC0ap9s+2HLctpV2XM8SfMYXVN8naDchkRfGtlpYsKmisMkL9/PRr6RWBQdCaAMO9+0IV7NOyuGX9m6CJvluE+KJxO0jw8CgtxgefNc8oFz/P4T9SfZNFrJ/1qa54Ds8x9CoHTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeoHFlJ4HX4hZtRkOHcQEXnwYMnU3F+8KWm89Ri2Sg4=;
 b=vOg14xP72WYOsWQH4cN0rt/DTmWzLs4Sz7vAOZOnLPqDRsiVtBLe7r52stdvSO3WhRVQp97QmxDRDOZR9pqOYb9yqP3Cthhbey1dHeH40Qu1eLua0MEayTg12mzbLFo70wmoKekcgvWl1/5ffVun0N2LzFJAxyz/0i/AyorIqxo=
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 23:29:42 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a9) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Thu, 1 Jun 2023 23:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 23:29:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 18:29:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date:   Thu, 1 Jun 2023 18:29:20 -0500
Message-ID: <20230601232923.1248-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 43970db9-82e1-4c1e-65ea-08db62f81389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB5mbJZlEXRgpKjZzm+qsLJTf8bTy808opSMEtxja8okn17IuQX869YhGhPtUdfSN29yTJTwfY8gp1aO1HqYxYnoWqrFf9wE62FX1jChan7J9JRJ9us2S9+O3dzvI2skDU3iRDTObZAwsLbbsfQTkKARBOkj3BAc4sbafNVJ3aaxQ9CwXTsGqtdAn9S1Bj8lGMs4/T69OI9uutfsWsYOzISDAwc2ic8EcPtl98Q9oqwLzgbEA0Z1abwaeerdHmw1832AjmIvsOqWCmJmG/833ZA3V4dhvNB6GIsN1oFnKTe1jarT2hj8P4afvHRpppAOEUFx2RTb5Bk6RSM6B2R6NOf+IOq/En7BU2GK1224siO2XUbRpLVMPmUSwQu7LCj8GdlDMWohmuKoy3Vsez3MhJArSAAi3+5m4zGRcKTybl/wd7owJbJ890YgIiVQCn+XKVS7wTsPQCMRJR3M4xn1qFsVoNOjlD2aLnjYXeNyikbXiocMAaJUxsGH6Bx5r0CgaE9dm0D8uQRnaTkh8d1RZyWBrOtFp+Rq/yXG0HGrLZ1ZD0AhRH/9SzNUBwhUF8HyKsbZj4eBJEVTqhNhJxQ2k8m59JLkldKWI+xq5Wp8Pgu9L2u7ZKL8/Qivy4oMUZgrRmTJ5bU8XQsvHei67goZ9KVo5B6jrdUE2nMJ9/aTMSx+HJYvJVtfXuXG0oswmhHJXf1r0+jjPKdHDYDKOrq78G9c5o5y62iV586TLn4rlgvhadYSQp9Xq2FxXDPYDXScWb7t3LNNHqU/kePBMeVnlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(16526019)(6666004)(82740400003)(82310400005)(356005)(81166007)(478600001)(40480700001)(47076005)(83380400001)(2616005)(426003)(336012)(36860700001)(26005)(186003)(36756003)(1076003)(7696005)(40460700003)(316002)(70206006)(70586007)(41300700001)(86362001)(4326008)(44832011)(8676002)(8936002)(54906003)(15650500001)(5660300002)(2906002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:29:42.1459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43970db9-82e1-4c1e-65ea-08db62f81389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses in the kernel are currently already oriented around
suspend/resume. As some other parts of the kernel may also use these
messages in functions that could also be used outside of
suspend/resume, only enable in suspend/resume path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Remove pointless do/while
 * Add a function pm_debug_messages_should_print
 * Export pm_debug_messages_should_print so modules can use it too.
---
 include/linux/suspend.h | 20 +++++++++-----------
 kernel/power/main.c     |  6 ++++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 1a0426e6761c..9a3cc0b89208 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -555,6 +555,7 @@ static inline void unlock_system_sleep(unsigned int flags) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
+extern bool pm_debug_messages_should_print(void);
 static inline int pm_dyn_debug_messages_on(void)
 {
 #ifdef CONFIG_DYNAMIC_DEBUG
@@ -567,17 +568,13 @@ static inline int pm_dyn_debug_messages_on(void)
 #define pr_fmt(fmt) "PM: " fmt
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
-	do {							\
-		if (pm_debug_messages_on)			\
-			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
-		else if (pm_dyn_debug_messages_on())		\
-			pr_debug(fmt, ##__VA_ARGS__);	\
-	} while (0)
+	if (pm_debug_messages_should_print())			\
+		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
+	else if (pm_dyn_debug_messages_on())			\
+		pr_debug(fmt, ##__VA_ARGS__);
 #define __pm_deferred_pr_dbg(fmt, ...)				\
-	do {							\
-		if (pm_debug_messages_on)			\
-			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
-	} while (0)
+	if (pm_debug_messages_should_print())			\
+		printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);
 #else
 #define pm_print_times_enabled	(false)
 #define pm_debug_messages_on	(false)
@@ -593,7 +590,8 @@ static inline int pm_dyn_debug_messages_on(void)
 /**
  * pm_pr_dbg - print pm sleep debug messages
  *
- * If pm_debug_messages_on is enabled, print message.
+ * If pm_debug_messages_on is enabled and the system is entering/leaving
+ *      suspend, print message.
  * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
  *	print message only from instances explicitly enabled on dynamic debug's
  *	control.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3113ec2f1db4..daa535012e51 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -556,6 +556,12 @@ power_attr_ro(pm_wakeup_irq);
 
 bool pm_debug_messages_on __read_mostly;
 
+bool pm_debug_messages_should_print(void)
+{
+	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
+}
+EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
+
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {

base-commit: 7736c431466abb54a2679dc257f739fddfa84295
-- 
2.34.1

