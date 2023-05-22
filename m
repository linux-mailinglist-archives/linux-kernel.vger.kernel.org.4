Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907F70CA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjEVUBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjEVUBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:01:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B5A9;
        Mon, 22 May 2023 13:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmWKynsXaphW52QVHgF3PMbSffgsYhLsIeX6YkpVB22uB5c3zW+jNcisBrslpmaVIet5UdGLK8heD/7FGpEcD5cSlZsuqeB2UhKx7HhFF9cosWbzZ1KJzVljfUeewtRDGj+zj1fkC0zIzmbcIZ2TKw9JquBYXnww7nI8bKHqkbXgUykMEsLdOcRtba+h6+a1sc4JvdETi/V6O4d+J2Z/r7kRRvJt/pZjn8ilG5iC+GSigIxpoELsM8US+oqLao3gJ8mGiKpWPrAhtWy5b7c/XNwhkgX36fqwCMEq/ER9B9Q2zHucKTXH8jJdzEKCI4aZVnTKTGQHyuB536f4wtUHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rLIPJ9+GBmoUs4o3I512F7rTUPbSUhKwVHw9JjZSDI=;
 b=BSiBUPoCeCdrDSHfocJFnx8amqnc379ChF9NbQWAlth0+EO78akQG6gPLbeNN961EiFksUm+iusH81iQvChn+NiXcAAGLkEWK+FqdzE9uHgqF7PbTJ2iGRH2VtFp98O7cOK+7h+LI6MvYDO8i6FdFM8+hOaRqDQQjJ7m/cfNBS6pWxf3AmmaUT3iZj6EKcakx7xzhep3nicUwjenMcU1P5fKEzY61A+tTJZh6iZTQLSHsGhAWdFikDapOgOsYUUE5KMjRP/Cn54jciB+G+wSicPd2Dly7MUb+HtBat2juppjsEwJyx2FuEpDlL66DVLnIb+w1cViV7YZy05lqlV8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rLIPJ9+GBmoUs4o3I512F7rTUPbSUhKwVHw9JjZSDI=;
 b=RBsTTjHLa4UMsYScStOgBWmPeyV2vikfCIF3R7ik+kPwqF2E8r3ARjrVLc9gAQ9usn1A9EFYrgZlG8kGAfMgDbU3mOPZ4PVyugDPijwbosFljSOU6cZb+cVS8OC1b5/PP0L4jfpmRxpY47OiJrF5gRjF94A8BRSjghmahU7SxuA=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:01:07 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::32) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 20:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 20:01:07 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 15:01:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
Date:   Mon, 22 May 2023 15:00:31 -0500
Message-ID: <20230522200033.2605-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522200033.2605-1-mario.limonciello@amd.com>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc1f980-b154-4540-559c-08db5aff4833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yw7c1XgyjF+24pVVEwp+n2+suK+zcNpdRTUpWH5lrUtbGcpk5lRLl3nSYMNSrRbSwr0ukOcFYW3FCUKeRK77EVFumA8k+vsrar4R/Z1mDppfG0N4gFiCzr6VyOKi8aydSCSdt1eaZ68pJGB8tFwkEK8JopPLuL984x40EVS+rghSUXVpTx2Rbi2lJNIWwIT3yoFd6Z4XGga3Tjt46vg/mifglwkYeAus0Yu3jhTtQaHOu2AAhji5d4DoJrsedvPEA4HQhB1465Crv6ynUtEtwGckkYaOtav9+d1ZNebZOuPfQ6FD7VnkSPu+ZAeOPG4Gnqayssuh0u1DpXa4R0ISKFv2QfjqLRjihCMD1YL/q7/YLKwtIUWmKiPz5wnQzfV3Zja25mx8GwhL3D8YdBFK87Q5eHrqlUOLpZeTmkn74SwAewYmgKMYRiUXRtRd7CUwi3YChSm3u8pGfKMFzBzX5ydGzSXngjkX4xxQIN3LDkKXBX9bWEaDmSynvBVmROUq9bZ75PpLqo+QAATlkAb5AutT4o/+s6lKbXZa0Pwkd9roTUimOXolYlvxSUop6XwYRm6zOU08fZnj7dxPcAQvI/dAbWGc/h6LANTVAHU6vkMRrv9V5S2LHIYjr7cNaM5Ik0gbVdAYh12sQLW7geU/HpPxkfuWIEwY5yYfvsK3W5tnTLT/nto8gmP9Y8FScAbJMqzR/Vy/OjP784SlfY8sjXyKFB2w59Z5P3+SEXzxzBmNNQg4klxIxIOSnmkC/a3q2J+G2soKQvnMMuHcT8EO/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(47076005)(5660300002)(44832011)(36860700001)(82310400005)(16526019)(186003)(83380400001)(426003)(26005)(81166007)(2616005)(1076003)(86362001)(82740400003)(336012)(356005)(40460700003)(41300700001)(7696005)(40480700001)(45080400002)(6666004)(70206006)(70586007)(316002)(4326008)(36756003)(478600001)(54906003)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 20:01:07.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc1f980-b154-4540-559c-08db5aff4833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling debugging messages for the state requires turning on dynamic
debugging for the file. To make it more accessible, use
`pm_debug_messages` and clearer strings for what is happening.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Remove an unnecessary stray semicolon

 drivers/acpi/x86/s2idle.c | 52 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c4579..7681f6ecab67 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -59,6 +59,7 @@ static int lps0_dsm_func_mask;
 
 static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
+static int lps0_dsm_state;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -320,6 +321,44 @@ static void lpi_check_constraints(void)
 	}
 }
 
+static bool acpi_s2idle_vendor_amd(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+}
+
+static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
+{
+	if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
+		switch (state) {
+		case ACPI_LPS0_SCREEN_OFF:
+			return "screen off";
+		case ACPI_LPS0_SCREEN_ON:
+			return "screen on";
+		case ACPI_LPS0_ENTRY:
+			return "lps0 entry";
+		case ACPI_LPS0_EXIT:
+			return "lps0 exit";
+		case ACPI_LPS0_MS_ENTRY:
+			return "lps0 ms entry";
+		case ACPI_LPS0_MS_EXIT:
+			return "lps0 ms exit";
+		}
+	} else {
+		switch (state) {
+		case ACPI_LPS0_SCREEN_ON_AMD:
+			return "screen on";
+		case ACPI_LPS0_SCREEN_OFF_AMD:
+			return "screen off";
+		case ACPI_LPS0_ENTRY_AMD:
+			return "lps0 entry";
+		case ACPI_LPS0_EXIT_AMD:
+			return "lps0 exit";
+		}
+	}
+
+	return "unknown";
+}
+
 static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
 {
 	union acpi_object *out_obj;
@@ -331,14 +370,15 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 					rev_id, func, NULL);
 	ACPI_FREE(out_obj);
 
-	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
-			  func, out_obj ? "successful" : "failed");
+	lps0_dsm_state = func;
+	if (pm_debug_messages_on) {
+		acpi_handle_info(lps0_device_handle,
+				"%s transitioned to state %s\n",
+				 out_obj ? "Successfully" : "Failed to",
+				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
+	}
 }
 
-static bool acpi_s2idle_vendor_amd(void)
-{
-	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
-}
 
 static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
 {
-- 
2.34.1

