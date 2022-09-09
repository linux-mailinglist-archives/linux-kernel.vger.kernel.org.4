Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476885B3E85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIISFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiIISFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE06E2FF;
        Fri,  9 Sep 2022 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0jdwxrCY4VXk24bX+mSaDshqyEwzQwLNR1XeJmvsuWQz6kb2E+h6r0loFEUe7k6CRxu31sz3bZ8GD7Pij/jdkeUY2I9SlC+Hx0RViJUjs3U1sPvOl2AMM31Wtz4KpNX2mTOeiQH6eTwV5oBh4VGveoahzGHYSstK6Iah4Y08oaecl+jnt/EYrbEOG5lStxls4gjo4JU3RwwyV+TiZr8oM1Dniow/8kbqKh1x3pPddRTXs2Pjj4MxgTaArlnEEqp0RVy7AQ1fuUyAMf11dBIfkLHVyo3R6dh/8vfn1YMOyqwjgseAPM89DywdxJua8YU3Ch5HJshrNHvTQ6M5EOU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJCqzRJRGdOcmbBQ/3UeozeAWVOetcD8M2l0k2hGyec=;
 b=lbTI7v4GBKjpYgV4h9jszx/xd9GtsvkGWBoa8l2RojueoLVwdFZ6VqNMdPCCHy+eCrSywNV7sd+TNPlj7GtEb8i4qKPn+1pRVVPBsOQ5/d1Zw2/ZrdbgMU0DGRO0sz1HrzotvM+vtBgJfFokziaRAX8IKGP50licMTK71McitIGfdWhF+zOJD9C8TDVMFYq4So6snyiI8099vQgbR5haqUVKURtVqv4pkrmdOQRhQvj+tqSVYUSXyzT3hO4djTkd651CRPYfhzs20f2g1OsRKx1sW+O/Hxn9bmQunrwpa1y66n6UZgq3M/tfjApcy2L/Uxw/BgfqdGnOUNH/q/o/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJCqzRJRGdOcmbBQ/3UeozeAWVOetcD8M2l0k2hGyec=;
 b=WNE7Kih/cvWQejdYNitIQmf54JMTUAJgTDjCfOLvRbWBGpN6da28tsD4shaCppjft9w3R5OJ++p87Rw7g4TQ5o2NTgg+TIH4yLmajhHDYnHKPoRoN+aWd1ij2vHiEh7yFjy7J/bjHRziWJmZAkpbkIcIVPnpNVKEuh/JuEtAKgc=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Fri, 9 Sep
 2022 18:05:27 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::51) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 18:05:27 +0000
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
 2022 13:05:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 3/4] acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
Date:   Fri, 9 Sep 2022 13:05:08 -0500
Message-ID: <20220909180509.638-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0baae7-919a-4c4f-ec42-08da928de02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8gKpeudT8g1Z0qc0FRN8XjZr/9pQe371E0Y49lYO8/u0PYN9/SisLkjwK24KeUalLqVuy4+aAVTUi9HO7Phhy1A1I4usnGkyQG3L4DTkgTbyzfrPRvUwIbZvjqRjPqmit7LcO/bw3oKWYxQucF5NZEckFgpM1NZ1s57sijxtN7TezDkK1C8EEMTgoTMzlizuN62kq5hE+GaHkDy8OdXYHJ5yEPwddZJ9me8PRdEhjenUtN4uled5uSO97mWQQrHrNlBuHd9VOnTchCIm2w1pqMcZxJoCKEYH+TCMBAp2nSxEHI+95VurgoCrUL8VfAANz1k0/1sulCmM4nGS+x77DwdfQQsMb1jigdM1IP6I7hoRR5+zssUQml0Qs/drKtuDxbH+y/ZTYRU4bwLUSCvF/GFu4liqwVLOd6p4f3mSfH+AfI+7m7Zie4XogvtPEDMJkx6AcljZNw9Jgw07JqwJOnG8UsXO70AKYICsY14A5OnO4l9IITBcf8W2UTdjSlln0FgTTMFz9V8kBDCz2ISuWSi5nhCVvN4/pNX8cTo1srq/8lfPytlHW7c4WWn/mIlZE1Y6iKeC7aOXkMEh8YrtG1CWSD61WIt3R+Sn6jLQWPOyA/9GkigIfWARKDT5ex0lBA7YTP5C0pM3S0aIDSrlqtOvxuCj3TM0t9hK7vkuyAN9Hk3BMJwAlaZjgU4PtkBALAsvWkaLaOWmRBNyVqdNvfIAdTW1AWMy7PCPnHCoWio595CJO+ABKr7ONUeXXoGe5MqVlW6TpeYB1sFBk4IYyCBZd8OY+IyyAA1PBTco02ju2CCSRajLkbAMXqi6bpG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(47530400004)(36840700001)(46966006)(40470700004)(70586007)(45080400002)(16526019)(356005)(70206006)(2906002)(36860700001)(82310400005)(4326008)(40480700001)(86362001)(316002)(47076005)(36756003)(8936002)(54906003)(8676002)(44832011)(7696005)(110136005)(41300700001)(5660300002)(26005)(186003)(1076003)(6666004)(426003)(478600001)(40460700003)(83380400001)(2616005)(336012)(82740400003)(81166007)(52230400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:05:27.4559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0baae7-919a-4c4f-ec42-08da928de02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

