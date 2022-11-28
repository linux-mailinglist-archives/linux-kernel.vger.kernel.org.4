Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464C63AE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiK1RJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiK1RJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:09:14 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CD219007;
        Mon, 28 Nov 2022 09:08:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFM6dZQhmF7iwbSn1wAtmxZxMUPk2WIviZDbBpNpz9QCWn3Qz+XXZRMpPIgVevZs2ICBoOSIJ/wJXRm4ZHbheph73GanVvk8dMczXd4BYVrFXF73DLaQVHJyQ/aAsTOBYFBmtIk+XVK9gAfVgM2q9cJRm9bFDeSF/o6ZuDYadH9ui//tA01toOmoHKgLAUc/TbVH4FddpTFLkzZM1BlRQ3GtL879XXwg0Sp39mn8OAWtE2C9c5655sBn+aCph79ksEDyezUtH+xyN3NPvVKh/ySzG9tB+5ECAEnozxnlUI7/n5KcoNPENi2xRVhjAe+61GnTxpZ04VCKYdACUbqGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VirJ2WDbt6irvvF4xdt6Gg3Mz1K+ya6sVU3s/44fRI=;
 b=O9TjChlICovVzo3YAnpgbQ+FUIan7mcYvmaGxDseKVGGMO/oIUYq8h7uZ+oSbzaYXhUW98n28x/KQU9AU6DprvyywgCH3YBgJSskLBSR/uZp2s7BpZ7ACv2marbB3oYg/6ZbF7DjWwKJbZGF/EdhaUb4y8ThvWyDssZhGtY7WAP48hgPGAZwX5lPx5oe26k17IMo0qoPxaDQ+XoeErPf8tJhB0gF0ux38YRKeN/Disl1JuDX7xJs6z1Ph36/USgqpRaf+uq80a4XvLUOiBhlu3aF0djc1JLGYV4LMbzBas/dgiIGtgflV8ff63eFmvBm2Sl79COEIK4zQvV0yw+jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VirJ2WDbt6irvvF4xdt6Gg3Mz1K+ya6sVU3s/44fRI=;
 b=m3duCTDSR8G0EyLkCkdklVUvGH/xsuh5QfiggJwrnARW3H8fEeUh4/abTjE602zInj/QgW/lIT4R3wkn2cxXS1Fs5FbxWit+tTwNimQQ4Y9uPGDdAInTIYV6DOHzKd/VKPhJEryM9/PcZPSagKOxuUpYt2kyzWFtGddW+0lZ2b8=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:08:54 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::fb) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Mon, 28 Nov 2022 17:08:54 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:17 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/9] cpufreq: amd_pstate: add driver working mode status sysfs entry
Date:   Tue, 29 Nov 2022 01:03:12 +0800
Message-ID: <20221128170314.2276636-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
References: <20221128170314.2276636-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3f6ce6-ef64-4b43-0122-08dad1633ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S1YhTEjYInkWaPNzYRPmOKqXlkFEjxx8kH7EKG0UEazmm+Bo+5DusvgKQoKQ/oHIYMfg1G2fuwR1ldL4IyxxKtEZX4CaJMDxsKMPBkhZmf6qWaLC0pBXgbK8LABu4arFfhnG2tlWpTL7BRWZf/M+XuiPC8oOfjCcJDMVm345sY5/NyVKgGiGHqKo5uyzeu/KPliVd42Ug9mSKYLObM1PAqMSj6o0yDBl9iiDWJbOLEztH/IVpLlEHCzxyKml/uUhHPyFknoNyOo/119PL9LosWgTk7rGyFC0Uf6TwElsoY3TjLDeQAiOuLb/I1J1Uv8t/HLfiNz7AgiOTM5dgINQBvva27CHnknaxdZIYZMerjYpHXkxzoHSZoYBolegZ5ypIVkXyxTOHPGN70uJIKSo0EnpGchxgmUPcjpcOpFNt5x5LeY9JM7ArmZTUBWNFoKW1X7XSyMGztuehuNNVNIC6+JpEBQeODCXsMCVT3vV2syMtVpSKg0ZxS7APzaEEidFVFrr6DUvIESuqfDnnEHlREP3z9QrWUlxfkWyWBBtWOCSqBg6ikFhCgbutsBZg23+Gddh65ywIw7ZgVFBpJ7OchJgduKuFG+Bvssx40/yaoJ+uW68+6BAFSVVW/laoMK4RKTuEgx7Nc6omhABEy63LjmAfpFp3gQK4FHCXJ9PGTeAAb80ITX9gKF8kfZyl4A+GSRRy1eenDl4epfACT/GIUSCpDRjqH8M0ddXo+vwJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(36860700001)(6666004)(82310400005)(36756003)(2906002)(82740400003)(70586007)(5660300002)(70206006)(8936002)(41300700001)(86362001)(110136005)(8676002)(4326008)(40460700003)(40480700001)(356005)(81166007)(54906003)(316002)(83380400001)(2616005)(44832011)(426003)(186003)(16526019)(47076005)(336012)(1076003)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:08:54.2917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3f6ce6-ef64-4b43-0122-08dad1633ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

While amd-pstate driver was loaded with specific driver mode, it will
need to check which mode is enabled for the pstate driver,add this sysfs
entry to show the current status

$ cat /sys/devices/system/cpu/amd-pstate/status
active

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3335e7aa76f1..07c26178853d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,8 @@ static int cppc_load __initdata;
 static int epp_off __initdata;
 
 static struct cpufreq_driver *default_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
+static struct cpufreq_driver amd_pstate_driver;
 static struct amd_cpudata **all_cpu_data;
 
 static struct amd_pstate_params global_params;
@@ -807,6 +809,46 @@ static ssize_t store_boost(struct kobject *a,
 	return count;
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!default_pstate_driver)
+		return sysfs_emit(buf, "off\n");
+
+	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
+					"active" : "passive");
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	/* FIXME! */
+	return -EOPNOTSUPP;
+}
+
+static ssize_t show_status(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_show_status(buf);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret;
+}
+
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
+			    const char *buf, size_t count)
+{
+	char *p = memchr(buf, '\n', count);
+	int ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -814,6 +856,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 define_one_global_rw(boost);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -833,6 +876,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&boost.attr,
+	&status.attr,
 	NULL
 };
 
-- 
2.34.1

