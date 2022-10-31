Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8894613F29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJaUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:43:38 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D112AC9;
        Mon, 31 Oct 2022 13:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlDmf+Of72l45eKE03GQgAZ2QvWMLcFWCKpt9vfx/X/cmJVQ/QSynKb3jGM/Zg2EQktlUbkCpdvYdj41UnIz136mzc2OcvHHSI+jfXLhEFRALkj+nRsF3y2tw9kN5akYL26wI3w5j35AZjWG3RknWT03BNZbq4fL7uCnnmHOvPswWipsPb0q/+VdxepsJJ1GtXxfvqr+fOViXtgwYSnLs28R1M8jThtbbQfo+GtXVqtCIx3OQPuc/F1aTPCyEOTqdOwtHOi65nC6ROtF4ZxckXADA3TDWo13v/7O5wEcah/Q7Icn8M7BJG0Nv242Pl1Lwfr5r9nUic8B0i8E0iDIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpe+l56ZW2oAZF/ck3Or05d3pEtIhETD+DyOuTJk0vo=;
 b=Ux1ejWKOGJ6S8AHHYnmkU4WNZ45OzlUHQOl+QozXCPH1Y3KKh6UT8bDxkCdclssnfl7y+/FLegukSiiAkLQ8ceSIuBoHn7CRBW6X6ZFf8s8zzLhls6JYuG76gWc6frVX1fN2lqewj5e1xE8IR9caXpc0EcoArssvJudcSFw31ZqwV9DJf7w9imDLtN81IqjkMO/PBTFZchpKN6Az99gUW0NUqPB/wr64W7Q8xBD5AhmGRLGLHHW3clPCzBc0i/O+If4RGna42BHzjidywD6/H6ohl43sNCY/4lL45rotnW/fSOxyGbPoh2Kw801K712GjtqP2a2Q6J4akDtTFkIqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpe+l56ZW2oAZF/ck3Or05d3pEtIhETD+DyOuTJk0vo=;
 b=DeZ1dPk0SVtbhLCgThkpTEQcjTtnN1I+4qqs/cNhE1LAqvvNP6LMiUecQKw+ZKjblTkb0Mufn8zlnxJRdJ7sa0WicMOoQcidziyT6WCFlCSBZ4Zx309WmjURwKCAPWjGFmLg+2HmXfMsP36uRQdmPI4Ma655jjKOHmDHOiFHsBA=
Received: from MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:43:34 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9f) by MW2PR2101CA0016.outlook.office365.com
 (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.1 via Frontend
 Transport; Mon, 31 Oct 2022 20:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Mon, 31 Oct 2022 20:43:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 15:43:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, <platform-driver-x86@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "David E Box" <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC 1/3] PM: Add a sysfs file to represent whether hardware reached the deepest state
Date:   Mon, 31 Oct 2022 15:43:17 -0500
Message-ID: <20221031204320.22464-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031204320.22464-1-mario.limonciello@amd.com>
References: <20221031204320.22464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bd8303-cdb6-4c48-4ad2-08dabb809467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzkaB13Ix/jriBV5JPGgHv6APWo/Kf1480n/qu04jshfpzokxeRwHCBkEDVxCS1AJRMZnGsXeOZFchvGvN97p2lu/+/JRXkgbq5uWuJxiwp5W1WV0KquTaxKxbPyYfY8TeENMEOQENhswwtZCg1TCo+YsX9R2CYbnvAC9yU8Clsup03TFoL6SZj0VQvfw9KULN9GFb3Jd9JtY3XfDGOtCv5PvQtbJNTmhhoZ5T76JQzAxA12ksJzikgVmcR4LdSJBMs0i1EzzZGIs8JlUsqO15PN1wvZva5/dN6FhQxd600xfjKpo7S8oOp1A/mRBd9m87EDkVfAPDTOBTeXa5shRoOnisNoubCOlfd+S3BgQE/N+t/ytlOh0kxvgPyU4hsMahpyl6u2Zv7TLS1uq/eVBRO6JrhpsjHJ4X2amVDk5/qKUaGGUJ3P/t0+wKgndiuH38/OwRke/CTuTsUJ2mAoY5wjCshp/v38YL/cCST3ocJbYSpblC4x587/s/hjO4WY1dmi/cRUxP/hpbWgIn8qU/4jxDAkYVysT0UpneRj95duqP+fDMLmEUJM18oocoNwnzhcHBKPrKCKABP4S87dvgmxsVeHAFU8lXAJQQUIn/VYSYXfdI2OS1lCDvFe5MnFSJvtBoe21XU2jxRkhE5rizR4GxUqAvWh3rGY6VtIEZncI9TvUSiydi7esd98L4RGmPi47L5fuRMCRMclEXL/9BwgoByzwDZSVDY+2tldGkG2KNw7yMC3gUJnaUE9zRJ7IynK3lB9NndyFQ5/FsmEO5RJoHryvShN58PJZmcSARSyn6zgO/hy/xu5BmEehx7/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(8936002)(5660300002)(41300700001)(7416002)(54906003)(356005)(86362001)(110136005)(81166007)(70206006)(4326008)(70586007)(44832011)(8676002)(316002)(2616005)(26005)(47076005)(336012)(40480700001)(186003)(16526019)(6666004)(82310400005)(478600001)(36756003)(7696005)(83380400001)(426003)(1076003)(82740400003)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:43:34.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd8303-cdb6-4c48-4ad2-08dabb809467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
reached the deepest possible hardware state over s2idle as well as how much
time was spent in that state.

This information is valuable to both chip designers and system designers as
it helps to identify when there are problems with power consumption over
an s2idle cycle.

To make the information discoverable, create a new sysfs file and a symbol
that drivers from supported manufacturers can use to advertise this
information.

Suggested-by: David E Box <david.e.box@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-power |  8 ++++++++
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f99d433ff3117..25c52d7469b9c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -413,6 +413,14 @@ Description:
 		The /sys/power/suspend_stats/last_failed_step file contains
 		the last failed step in the suspend/resume path.
 
+What:		/sys/power/suspend_stats/last_hw_deepest_state
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:
+		The /sys/power/suspend_stats/last_hw_deepest_state file contains
+		the amount of time spent in the deepest hardware sleep state.
+		This is measured in microseconds.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a0289185..30b8a8018299b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -68,6 +68,7 @@ struct suspend_stats {
 	int	last_failed_errno;
 	int	errno[REC_FAILED_NUM];
 	int	last_failed_step;
+	u64	last_hw_deepest_state;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
@@ -489,6 +490,7 @@ void restore_processor_state(void);
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
 extern void ksys_sync_helper(void);
+extern void pm_set_hw_deepest_state(u64 duration);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d704..1bda5d2d26c53 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -54,6 +54,12 @@ void unlock_system_sleep(unsigned int flags)
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
+void pm_set_hw_deepest_state(u64 duration)
+{
+	suspend_stats.last_hw_deepest_state = duration;
+}
+EXPORT_SYMBOL_GPL(pm_set_hw_deepest_state);
+
 void ksys_sync_helper(void)
 {
 	ktime_t start;
@@ -377,6 +383,13 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_hw_deepest_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", suspend_stats.last_hw_deepest_state);
+}
+static struct kobj_attribute last_hw_deepest_state = __ATTR_RO(last_hw_deepest_state);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -391,6 +404,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_failed_dev.attr,
 	&last_failed_errno.attr,
 	&last_failed_step.attr,
+	&last_hw_deepest_state.attr,
 	NULL,
 };
 
-- 
2.34.1

