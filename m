Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F17209DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjFBTc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:32:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04545CE;
        Fri,  2 Jun 2023 12:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es38AhNk6YzVmNOZ2eiUeyZBKJviSatKwpnYd/lyPIydBAozSbl/5ueIPHvm2YBYw8jJp5h3KQSm63Kn9DrCxaQnN/qyQGE7+FpCJMffw2xxxpxBBuM6aPzCjf2XGzCOd4ReR60jqVfMosdtrOgEv4aizPkFJ8NNh4W+MhyQryNUyH5eKLja0RQ4P/Lmcz5CoBA+GOCfy2PlpvMLpZ5l0kq6Va6Z3GHIQ77CAl5ChEufJ4xF3bgDvMCTR/6rjfUn4420TTW5dGXVdRplAZewRcRDckqOX95JUCLk5dsfmDcKaSGOQ0+rOyaBbc/8RowrNambHn3/uYc43Hc+DH6Lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jW3Os9uP2+hla3vlGDL/LlGtwxxwgiHpW066e9D7Hc=;
 b=TfdS+wyTE55WAVL3+wPb1hF+/tK2zfCZ2tDo8QmWdjFXuZUUW7zEm+c2EVsiR9EqCI6k3U/h9fI4u/e69SId6Pmy4YizXXkitTejOUkDL8FBAdbGNBZXo4CBm3Re2rSdGuEGoueGwavoR51ViBe3zWXFeBXmvVEkTD4BppApX5IdwHEtnpUh3cvZK2CbvR/ZVYCsR651hxZwnD2yKUNgmay8cTG87cBn2Bw4ZEupmBG4rErL/nAk5BfApuZUr8I8Rpl5TgvYQwAUsV3lnrCyFu6cdeQBvPx717155QsVw29xy7VvV6REndSfzhxiSaDMMD7ZDNO946VD1bIKL6koxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jW3Os9uP2+hla3vlGDL/LlGtwxxwgiHpW066e9D7Hc=;
 b=vE8FEIjuda1AaBeAI8FpH2ExssMKpQke3IdcKxfNFcGCmID17GLI+sJtXKyb+D5I0KxGwTrXJk8v6PKad9WuxhUit4TIozNlvtgREaY/1PPz/X3nuiadeG4+IC2ybVgKdJH+4cXKZnfhpQR1AQO2sPl4tSDtBGmOWZnS7J3yJkE=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 19:32:51 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::db) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 19:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 19:32:51 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 14:32:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 1/4] include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume
Date:   Fri, 2 Jun 2023 02:30:22 -0500
Message-ID: <20230602073025.22884-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: 22670920-0de5-416d-b4bd-08db63a027bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7chVz3UcVPnCJwo7MIVIAYyc3lui1fKkobs6vRLCqcBXzmgY0HNXY9lVx6uV5UuBfTSU5ekX7yQ3Ce0KLHVtcsTnlPzVHa5KRG5Uzo/6EvAqQ+rF2hlwxbV+W3D168t4vPb0EGMHwkgw4byCnwPbB4frZxETDo6ibcE+MhyTbMg5IlnaxOwNc4gH8wdMOfQsQJ3pjKT1a4XNLeaC6yR3hyCnuhnkhAJZCWJ8fOblJ2DkVBWzSXlxu2O8KXBzVdtM3eRM9+NkSNdk1h8txYpaUSXVL/05VN8Vh3rjpO2yAKWWTjUXkhKBAXbGcw9OpPl4obxPkKOjcRe1q1E2R1ysstZEbOvJ0OCGR37Wes4GMi3RBosJr4jJekzeY+ZmC1JIr7zDqlIMhRD2YDLtfUZDVNLSd7JfVC0WxewBL6U/ElzaM6zPsbw1u8YfLjnDS2ff2bLodHXb7UrJUOcoB0XV9BsxZ5aI0pe2DZ3KLURd7Y2epXv59QRyYTSJVU3fjP3+ZzX9M7IaGOmgj88yQqmrCLoTSflqhw5pawXDONtaOxr1rCaEfMsWWUhmegJRIURwJh5MgpmIysM9FZ0c5Fg0Vrat/gvB47RjT7/v9AQUkLz2qnmqOML0qiE9unduC2APY9OTsv82t9HRwUF9jiSBkdmOTwZLuEX2HHi60rh+k+vHE3F9xzn9hHYzOA54zLbUMxmlp6H2shiJre2v2hiFEOBv+LhJvCJK/GzkVhwo9vyWxXsAZXOzmVNzXUa8sN22RB72wbF//i6Zx3Q8DziyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(86362001)(70206006)(186003)(70586007)(16526019)(4326008)(15650500001)(2616005)(5660300002)(426003)(336012)(8936002)(8676002)(47076005)(478600001)(83380400001)(2906002)(7696005)(82310400005)(36860700001)(356005)(82740400003)(81166007)(316002)(44832011)(54906003)(40460700003)(110136005)(40480700001)(41300700001)(6666004)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 19:32:51.3687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22670920-0de5-416d-b4bd-08db63a027bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
v3->v4:
 * add back do/while as it wasn't pointless.  It fixes a warning.
---
 include/linux/suspend.h | 8 +++++---
 kernel/power/main.c     | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 1a0426e6761c..74f406c53ac0 100644
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
@@ -568,14 +569,14 @@ static inline int pm_dyn_debug_messages_on(void)
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_should_print())		\
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 		else if (pm_dyn_debug_messages_on())		\
 			pr_debug(fmt, ##__VA_ARGS__);	\
 	} while (0)
 #define __pm_deferred_pr_dbg(fmt, ...)				\
 	do {							\
-		if (pm_debug_messages_on)			\
+		if (pm_debug_messages_should_print())		\
 			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 	} while (0)
 #else
@@ -593,7 +594,8 @@ static inline int pm_dyn_debug_messages_on(void)
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
-- 
2.34.1

