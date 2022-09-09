Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E725B3E87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIISGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIISFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812D72EF7;
        Fri,  9 Sep 2022 11:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1jBouiHX1b9VOh2cN+1oPxshxtOrvKK6sdS9fYljvhDNObBRutvqzcGmDfpo0j1k4x8NsD7z9ajG6bHfvyweZCuyd+gPgUG5RiA2w3HzMvPHAYtXnO8l3Pe4zQoRrcMyaUYzJOYQojOMI1AMpyEJteCcxYgcH5Fy1QELjg5ZuZwK+oHTkbe0Fao9tSgAqo+IXkgrdPvxdyZ3GkoWs3FNizvKoj6qsXGb7AXk4CcDIATp/Jd2aNgZCM/W1bpJ3p2pHBKVhZZzRrKO//VzCgjLGnOVoDQB3Hoiw8OI38Lbcra+ulf9G4pq4DhR8gInaXdUfW8yoj6LZQE1XLbCwWm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK3S96XOwX1WmlP0btZwOoKTndcVypd7IxZ4MZSTqyw=;
 b=dJKvW8vjQklR0Cdx0MZCBfeY97PcKskG25+lvxMLRltgsJkvWx47u2UIFrR0XJ9hegR6vlB+X3okrhJSZ3QgvO0pSHMwDWlNeKwsd09I6+zWy7+HZKnCrlOBQIl5e0uFWfYTggvheych1Wq3o01hYOaeTgdgOab628F9Gn4rXZBAcCFcTnXy6YOUev3b0kZxPtMc5MfgMKzNn9YKyufhia+fDNgk4ikpevSJGFHyQPvUSWYLTV575Ij9cY8vXPyLS/r1nRT3Fltril4qyjV3GPEEGr8tWHzxFRv6m/lrwieAEyApNegsTLNd21fWXkgI5JPmeZ01UnR46eqCuuljvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK3S96XOwX1WmlP0btZwOoKTndcVypd7IxZ4MZSTqyw=;
 b=ujSe+XlkKZrqybZ3k7xePYX3fx/mTAsKmryArMX+2bnJtc3slBaSWKQPvWGdXf51NdkF9hY314lRuBz7+0njRzc+QDgKUXzc9xBW+Bv1zn/JIp7mZMesayrLfPoFZ9dmQYDLDn28XiTYlZI8WTBGAhO1CwLGb/CbPYIGsS5dEx8=
Received: from DM6PR11CA0044.namprd11.prod.outlook.com (2603:10b6:5:14c::21)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 18:05:28 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::69) by DM6PR11CA0044.outlook.office365.com
 (2603:10b6:5:14c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 18:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 18:05:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 13:05:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 4/4] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
Date:   Fri, 9 Sep 2022 13:05:09 -0500
Message-ID: <20220909180509.638-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909180509.638-1-mario.limonciello@amd.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7c062d-2276-440a-3647-08da928de07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVXTlB7V17Ysb2+i0vubmdFHfEHOXeDZc1KKP5UUridBXLWUWSytdQF+X/4K7atV658QctQOV6lmKqcezz6wv2LxUnCgwpYXutFHFyfHkHzRVYvUFeGpZOfXDdsdo1dvN6hEZ60C4f2KNQb2xbrsO3ZrGR4nvwybEMBMJ+z4obzI70MpH0uHUVAitlD6GtS8d9NjV/QeEW3nWQnnyhSE2fzp66lVlDfwEtJu/WCdonGO9xJZqEGla8SGkzFAlA2K1ztGAbPQlyegRt40B9d8jbM3OIRs2T1V46nau3d6XXOVNdtuYkJ7BH5kc1G4EzZxR42arA/zt1otaDtyu7MSi3oUD4EOmaqBWDhPVa5IQUdGLedD3iw9nwl/uzZJ94IAOXDa6Kq9/zeV+RRsx/Zr+/T7M7eIdp4FjyfY9XzTZOzySp5HTvZhBib2ox7e92CM+lKjDW9SanEohcAQUJFKszNYzmC7bsDScb1Oac6f1Qw6NY1+CdbZbvjv5tT1nu6eaYXM51xBlIsTrf0NmbXxLrJiYfzB+N8JYFfECuW4RIaVzEO5VPgUPl5Y1u21LWhXhxBV6gJWBhFHi6bO8Hk/OOFpD+Q2z0l3YlMsfpHUbfDeDkzm2Y1vqQnL0kv4R+iKUTDB5BcH0Rr6ux+3qptHR8HjSxx/dbRd34Fxbr4RvOpu0jyDerSJ0dUHga0XZZZkyTN7xIy01FKp6E5KigCsVkErou2Br710UiUiDQtH9KzVnW9pqCQgVPXd9IitxFHauhQ2yekVvvouiwJL5v00uk7nhhzFCrXDSfIaNkmNwYUSVJN3DVi/dZz6R1UzdyPeaNDRmwrjHhoExtaPTcZskw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(356005)(81166007)(40460700003)(36756003)(82740400003)(70206006)(7696005)(41300700001)(8676002)(4326008)(70586007)(5660300002)(6666004)(8936002)(45080400002)(478600001)(54906003)(110136005)(966005)(316002)(47076005)(16526019)(426003)(83380400001)(336012)(186003)(40480700001)(2906002)(44832011)(26005)(1076003)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:05:27.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7c062d-2276-440a-3647-08da928de07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
s2idle resume.  It's from a missing call to an ASL method in AMD
the s2idle calling path. Force the system to use the Microsoft
Modern Standby calling path instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
Reported-and-tested-by: catalin@antebit.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a9b0f2b54a1c..6a2c94fdbeae 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -17,6 +17,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "../sleep.h"
@@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
+static int lps0_prefer_microsoft(const struct dmi_system_id *id)
+{
+	pr_debug("Preferring Microsoft GUID.\n");
+	prefer_microsoft_guid = true;
+	return 0;
+}
+
+static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
+	{
+		/*
+		 * ASUS TUF Gaming A17 FA707RE
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216101
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
+		},
+	},
+	{}
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -568,6 +591,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 
 void acpi_s2idle_setup(void)
 {
+	dmi_check_system(s2idle_dmi_table);
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.34.1

