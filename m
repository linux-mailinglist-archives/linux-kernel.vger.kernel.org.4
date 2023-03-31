Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A476D172F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCaGRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCaGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:17:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4AE3C20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH3J3x5sAdpK2l0og0A9MWVK2rrfyAkPAYfgCjTkOEk62whPd62XSKJxDPNyQJmX++/3gY8FNDHjywS9eLjFOEUXdBXINbJksOyOyBpSeZAotl74pD8k/VG8CqwW9rBpUj7+lAsAl3ISkUWcTdWYasvZ626WZRL34FkiS9yul6YsEjgzHuYuGt1MZX9EfQfaDRRfGjyVXKEzznd61yevMzxwxCAUYr0DCy0v7RtcDcskV6xTHoRj0zsmRYGC8kyR0pIoal+gz6Hm4LErdYdHc/65o3jbthW55x0WUoI5RjaxtZregxOqNtLO1R6pGDQ3Nc71TuO/GPDUfUeZzpVQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTumQ94zy5n7K+ARcPVX3vdkWwOi78e6NIqjW3uWvc4=;
 b=WkIujhK1SoH0AdwcMi9KrUFo7ctV329wT89dj382F6lpVdnjYCb2uncdC0NZgaVxOFI1Owrz6a61MAFKkaaHyZxvJig1OyXFjwdO2fTf2cYlxNBnYGbAiIkT/+4adFZ7IzSYZk0+AFnQ9ar56B2uYZsX1RZkFtOoz7645Y0airlvphV/qQAGyM1UMuXGVCNrfHlsuAeHK2NBgSbshMp+YGXYKAo+/3L4mfx+LxM/iHXox0pcdv7nirfe5JhnM+D33glADr1UOepDTiUG9DIdfVn9Ns78ZGiRAx7dfBeFCDpRhB0++BOp03zKCOrfyE81vCjwl1PKuEG5bW4YFtpGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTumQ94zy5n7K+ARcPVX3vdkWwOi78e6NIqjW3uWvc4=;
 b=cwbYoVVDDUzE2I538pD8vrIpmc8K90eyS5o0XBBZv6H1fe+hWWvbnGESVWeA7C2DCyvpRsHcRvMDgIKBNIEB/Msiaq61Pi6FyxbYAYHwdAQlZ1uSPbP5biYLhZmLsZ/D7mP4666QMgS2vvf3f8Jil9hNSJS0iX+bam5IOAPwO18=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Fri, 31 Mar 2023 06:17:32 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::3d) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 06:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Fri, 31 Mar 2023 06:17:31 +0000
Received: from ruby-95fdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 01:17:30 -0500
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE
Date:   Fri, 31 Mar 2023 06:17:23 +0000
Message-ID: <20230331061723.10337-1-kvijayab@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbebe90-0f95-4785-50a5-08db31af9c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnURR0OiBAZT+gPqujWEHh8yKRkgH3iy0QSvZZD+oB8DNQJIbIjsIMSvVocaV6gWqVYZ9Eea1SZTMSGCPr8sH/yZ5bpMZ4m0uwxWpFml+JU8hz0yQBOTcp8wR4COHg5z7ctU2sV/SynauwTdQvWsAm1dVwzErRSutDIKIWZh8ILJ8wL0iwd08lRDaiC06L5feWuwmm2mHMKJhM4llmQlGsTmav18/M2KCWmlfgMhNt/NnVWAI4poXxJqh5U0bZWGXk8qKSsoW35ce/mvevYbpmqpBxF4UXk8Ue7PQ9O3WZRx5OPI97B/SBtJXaoT1AbX7rYQTHv5OFJ9TA/O/AJqgpBJ+sH8gZplBKKuudQHR2jWx15bK3tFDhLhH7TIqE4UnXlrPh1UF5vItNmliQJVb7Y5Qq+ejWwthGV2pPlxkNZ/sfu4XVvSE6WPsQpg6vecmkKSx2DVPNOgmTjoyFydWgSNQzba9XO/Q2wZchIqMn3L7KKUsw0NU2d+WmlYwAY97qhjNneX5CQLyTtV2pIi8F3Omb2J4Tq+8tuvAPtnWWa20f6RGqjdZ7jZq/i2ZqLsueMN0vWQUEqFjYVvEAH0cOHnrbKwzIJw7/mUdw8tU40UoUPGpRxq6lkb2H9k7j8VKHdnypgMOVYnrWbowEv0adutjEAmVVEGVug5MD9O7GLDAS9sFaSdZbiggyg5QlwZqB/aUDSYa8oNQeyMjdVS6ZwFXZf6ePi0ca2Jm9ahXjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(426003)(336012)(81166007)(40460700003)(4326008)(70586007)(356005)(5660300002)(8936002)(82740400003)(82310400005)(40480700001)(41300700001)(70206006)(8676002)(36756003)(83380400001)(54906003)(26005)(2616005)(36860700001)(1076003)(6666004)(2906002)(110136005)(316002)(186003)(478600001)(16526019)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:17:31.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbebe90-0f95-4785-50a5-08db31af9c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
(de-)activation code") while refactoring guest virtual APIC
activation/de-activation code, stored information for activate/de-activate
in "struct amd_ir_data". It used 32-bit integer data type for storing the
"Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
"ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
Table Entry).

This causes interrupts from PCIe devices to not reach the guest in the case
of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
bit in the "ga_root_ptr" is lost before writing it to the IRTE.

Fix it by using 64-bit data type for storing the "ga_root_ptr".

Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
Cc: stable@vger.kernel.org # v5.4+
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..990614b8a1fe 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1001,7 +1001,7 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
+	u64 ga_root_ptr;
 	int ga_tag;
 };
 
-- 
2.34.1

