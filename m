Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917046A7723
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCAW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAW5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:57:43 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09734A1FA;
        Wed,  1 Mar 2023 14:57:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATWGOfQE8VlE2mYmAKwc97b+g2tzbgnbDlBqfVuvvjMLeHPOg1Orqo5BpO6sLvp0waSw7xddeNHCj26XNx1xWwa+QZHhTO2LF9NoKQOkfY32ZshK4C11dX5yNm9zbVLJvWyZo9USxrLDPVgxxql0Zr7TbT+UtlJIcAGmoEf+ppFsyxCqLwHWu8e1dU0qWAZcyHDAMiTyDmakztC0gzjyUwOaL9fyhRRPLpOAcIaaxU6LQ6D4F8U1Y/0nfYund+Yo7B9NiuiM2PVRiw2HGEBn5FdVioMOMXetz2boIdRKzpB5JyxeBaMXkUzn3NQ0Jq6XDRGMuCPZ/t2vsijgEeO36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR7Gt35kv+RyRhuteZ5Zhfey8uqcmspY0SWhRatEdtc=;
 b=Oc91NTqZoqybok4y1Le6DbTzPZWINdnZZoMzvaxZmktLZhJrCuN+hDPmQToN3u8Bbnhd37bnSLR8XyiUYYWRHosFgGM9Mc88GeH+ygtlYGEC8tmNKWs3VTkap3fZ3C3HxYt3ODIi4+dmG8Zv6+CnOt9vgW9GHfohvzHE4b4y0Aqi9rw8jTZjmw3Mcx++d/5stALCZQLcJsBQ5KeebGthpRHwFQfprCVtK8I74LhIfr2BqKdC+6/9vJLVVNTg4bUvxjY04IaF4/73SdRX/WVPt2q6x2+etRbqmGVgezfTZX9DKejKDnDgX08RB1tQqJ2OwLMBK4c2M/1Kbx/pbwYMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR7Gt35kv+RyRhuteZ5Zhfey8uqcmspY0SWhRatEdtc=;
 b=sGdPC5fuHrWd8+rOOQhgsmQqbA8oA0O3h5Sb4SfO08wqkanDH8D8rmE0U7Qqax9f0NM7Kdolk+MzdGrbHEW2WVD5HtA61YJsCZmaTL0Gk9vcxUJl9SRDeMDQKztIfxVBTszaqJYVwBIyPMXS6puyCrN4ctaYmevEAfMo61u077fgbmTY7birWhz41QsGvNkqeoS6x8tV+j+ZUit+gUOg4P55MYQrAWMvWuwnGBkw90cvqGFfDsHLMkyZHz2v7acTqgOQj8z1bTfWHj0u3jRjwN4dN6EBm8Nh/GyqqkSzMb24/J9xoLCgWzL8+CSE2LlD5MZtrydNeCQZrAmeLsJqdQ==
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 22:57:39 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::1d) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 22:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 22:57:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 14:57:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 14:57:30 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 14:57:29 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] perf: arm_cspmu: Fix compiler warning
Date:   Wed, 1 Mar 2023 16:56:57 -0600
Message-ID: <20230301225657.30211-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 0050363c-3c7c-4654-600a-08db1aa85b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpkkVBzNXWJEuiFb10B8dVEwdQjFD5mYbrADGt+LDcybgeUXxONfLcd9nEwv8/rIHkBSS6HECcV2Utk2nJg9TCH8qDtVu9ZiiwecsFfyF8RnUyp/DJao5VNW+FcnuWqUhTnxwMJmN1lyITkPA6BDB7ZQ5xJdw8h3siR3ZaMFLul3iSpdI6y2ThONryJfNE+andChK2tyn14aPO74AxXAMTlEajFIv3V+zEIm64k4FbVyA6OAwITT4CW5v1wVk14iIptV0lB+GpBqdWccm7UAmgDEL1T3UH3ef7m4yPNH4ZTiMPLysBxUL4Rqx8eSTGOGHOZrvFOg/eO76iophnwBNWI0d1VGLLSSIiSg3u2wADTjZFrPKE1ASvlnTi3CHfSVzmf51pu7Cm2yY5F5edzKipWCVqNXZ6O0clNEwn/A0t+sL8KQeS8sOHC7zkkHzMRZjFD2GxCoJHGPjnJ0RoWqtZoYH1Xl9UmFYWDU1KX7R+DxD74sBBco8Af9FWgMNINftewHl/jDNXOA7kqCthT9NeHorQKLE8KOqplC4PijzGNiY5aF7X5ecEjCv3XPyV0W70Q/obbL2VlRs4v9B3ZbWH2GiYD7RuT1JG8jJgBvgDyxdKFo+ScyK5b/t8RjcueS25I50hq07W7rAu8C8jO88S5/RPJUNMf6kzrRv7QVE57gf8uAq71yoe79TYJN6ID7ssn2RUHJVuCv1YTtai8U2GpaNt/HBSQUoaOOHFe3aSyq0LtDeOXlGsc0lRNXLzqG2jjeV/hlljnbmZP4gjfDrg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(2906002)(82310400005)(47076005)(336012)(426003)(40480700001)(8936002)(2616005)(5660300002)(36756003)(316002)(40460700003)(41300700001)(186003)(70586007)(8676002)(36860700001)(70206006)(34020700004)(26005)(1076003)(4326008)(86362001)(7696005)(107886003)(82740400003)(110136005)(54906003)(6666004)(966005)(356005)(7636003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 22:57:39.2645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0050363c-3c7c-4654-600a-08db1aa85b6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following compiler warning message
  | smatch warnings:
  | drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container()
  |    warn: variable dereferenced before check 'cpu_dev' (see line 1073)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302191227.kc0V8fM7-lkp@intel.com/
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e31302ab7e37..a3f1c410b417 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1078,12 +1078,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
 	u32 acpi_uid;
-	struct device *cpu_dev = get_cpu_device(cpu);
-	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
+	struct device *cpu_dev;
+	struct acpi_device *acpi_dev;
 
+	cpu_dev = get_cpu_device(cpu);
 	if (!cpu_dev)
 		return -ENODEV;
 
+	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
 		if (!strcmp(acpi_device_hid(acpi_dev),
 			    ACPI_PROCESSOR_CONTAINER_HID) &&

base-commit: 7f7a8831520f12a3cf894b0627641fad33971221
-- 
2.17.1

