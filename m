Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911175B5F41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiILRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiILRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034CE3FA0D;
        Mon, 12 Sep 2022 10:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzH56FYbbwQlCqUeK3i3mnQve0A0i+qIoRDFkRaUnwc7sAL7lMyWfWqAHR5V77p45wJiuBW/wZYPD303jOSdvOOA5ar7OU/Yi1VohsxRyPMPK4ZWhRk72t8AEQZKETqQScauevUxnJxSshfKDrqNr2Kd9U3b0HYRwMFnKPHf+8684tZrRGIlvJUISijFLPDCXhfsLIJgnbmLpnIDL/HkQirzA6jRBo9XiDRh5w+gX/xlp9Y1ORcqJMPjnSjVMqblO4a2tCs5fLv6aVsuvmTvlqDU1Pz73IMtHxZboyfH0bKNlvr/sOwZCtiyH+C7vih4ND4YPSjOXvNEaN9q1TUWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJCqzRJRGdOcmbBQ/3UeozeAWVOetcD8M2l0k2hGyec=;
 b=MWoZ+Fsq4NTxX/LrXwHyCi/xbapxlpv8M6NnUfGcJEnG0zEuQRbNQ6XAsP5mOSS/PYUEzStpxHUdk+vb+uzxKKgZrU1X00iJt8MxLh2QflmfWvVg19FyT3jX3+PBSiV0TBU4mVkq/Vgny5OBxBLO5tZMqM6DAyGh3LRiMbOpOStbXN9gTUWDZrzBHpdggBvGkneaX8vBl5JBCI3RKBZV0p+6sIYIJZo+Ly6Ys8QjtL3g8trx6HoJZoICAh3aWnThdUtBuNBLxjujpXq2iQxa6JckPLnYeYqTFD1A1gWWu2KJZPqzq9Fg4KB4Gr/GfDUeZhcGxEQxsBWNo7mB0VuM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJCqzRJRGdOcmbBQ/3UeozeAWVOetcD8M2l0k2hGyec=;
 b=YF3zIg0WPmKT+Gs2FcXMGAK0Zh1TJuIS9GDzmXKn5FMX0ZIF9QrNwcqlkpVLxZiAv/7eJyNrEvO4nvFfEJi+JpQdFFWt8d7yn9dM9INbJxggGOKnuYf9zQk9hpHMi2M7hCyyobLe7Z6p29iB9qo3HTxmvlv06GybtJ8t77CIWHs=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 17:24:02 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f5) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:24:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 3/6] acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
Date:   Mon, 12 Sep 2022 12:23:57 -0500
Message-ID: <20220912172401.22301-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912172401.22301-1-mario.limonciello@amd.com>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 828693b8-7b39-4905-31bc-08da94e3963c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJJ++O1DfmrNM5pwZtTXxGpoMlkeAzcmwpOwb6ZFkIPzqZaMZfEssRZJ1HHzlxzKD6AAonIipborvhDU0MnLBpeh+qoaptJVj2CeyNXT47lKIXSHh8pUTVJ3pvXQzdz6cf1UP8zDd7mzVJ0oqBwBuiwwF6z6ynpNg/gMx4bGfZa8kJaCOh2lk01Ct6SEuBDVJXJvWqpNbCIanz3Fp4Zv7wRQlDGnBgz4w1GFaQYXqvLE30dXRwXgvMfAjSeL9/zA6SwCclYyDQmPLp/pbp8wLqZr/kMSNvoS86qOIiduCRsWikr9XqlH5XiBIVxknqwNVI+B6nmTgMm/ksViMhz4mep0UpYm9y2if9wpIld4AAVu4E4qmpvYbc68cvAXjXJ9eiBSJRgfInA7ca9Rd0QATWVRwsitokCrVG0BUKwwQhFVHopkwgJWcG6+eE94cyrJhKBRHpMTYHRtCcsC5laf7qNIwZoxiPyD5RPeYP2Fpq3zGlwZOxso7PozrAZih5ngdvymmumaFhvjK0gIR1W3+dY3iEoqyiLD9IY0bj8+QUHP2hQ2gCywW1iDVfNpIkL+FYTXNopzTdMh9ukqJu0qKeCNcKkcDa+ul0jzJ2lNc/36L6o+Po2J8LXurqWFQ5PbYbJzPqiWBy6WtTgpsenJcqnH49H0H5t5S/gT8EQfZlSu6gfDSC+zyF/X4a7qtGFuPht2P7IUP1VZXujbfm9FQRuHUQkIIDHkMXtJHg4YdU8tRNq821MEFXocEy2BKRNdDs033zVxX6mDFPVWjP+NjDuIzvmpmWR2RyO845HdwyQ9ODMr1W4nyUDpfFCBDFde
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(47530400004)(451199015)(40470700004)(36840700001)(46966006)(16526019)(478600001)(81166007)(41300700001)(83380400001)(52230400001)(5660300002)(8936002)(8676002)(4326008)(44832011)(2906002)(7696005)(2616005)(186003)(40480700001)(1076003)(47076005)(86362001)(336012)(26005)(45080400002)(426003)(6666004)(40460700003)(36860700001)(82310400005)(36756003)(356005)(70206006)(82740400003)(110136005)(54906003)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:02.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828693b8-7b39-4905-31bc-08da94e3963c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OEMs have made some mistakes in the past for the AMD GUID support
and not populated the method properly.  To add an escape hatch for
this problem introduce a module parameter that can force using
the Microsoft GUID.

This is intentionally introduced to both Intel and AMD codepaths
to allow using the parameter as a debugging tactic on either.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a8256e5a0e8a..a9b0f2b54a1c 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -27,6 +27,10 @@ static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
 
+static bool prefer_microsoft_guid __read_mostly;
+module_param(prefer_microsoft_guid, bool, 0644);
+MODULE_PARM_DESC(prefer_microsoft_guid, "Prefer selecting Microsoft GUID for LPS0 device");
+
 static const struct acpi_device_id lps0_device_ids[] = {
 	{"PNP0D80", },
 	{"", },
@@ -402,6 +406,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (lps0_device_handle)
 		return 0;
 
+	lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
+						    ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
+						    &lps0_dsm_guid_microsoft);
 	if (acpi_s2idle_vendor_amd()) {
 		static const struct acpi_device_id *dev_id;
 		const struct amd_lps0_hid_device_data *data;
@@ -416,16 +423,12 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
-					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
-					&lps0_dsm_guid_microsoft);
 		if (lps0_dsm_func_mask > 0x3 && data->check_off_by_one) {
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
 		} else if (lps0_dsm_func_mask_microsoft > 0 && data->prefer_amd_guid &&
-				(!strcmp(hid, "AMDI0007") ||
-				 !strcmp(hid, "AMDI0008"))) {
+				!prefer_microsoft_guid) {
 			lps0_dsm_func_mask_microsoft = -EINVAL;
 			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
@@ -433,7 +436,8 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = -EINVAL;
+		if (!prefer_microsoft_guid)
+			lps0_dsm_func_mask_microsoft = -EINVAL;
 	}
 
 	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
-- 
2.34.1

