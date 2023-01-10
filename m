Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7D66434C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjAJOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjAJOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:32:07 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59C37277
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/JmObhkl9+jyLJKujnwUdf3A3DrtJxXhgRyq1FwgDGFiLf95IqYUwbxpuC/YJs3o6umki19gr6nzTg0GpPYVF3E94QXZoEHbP+gI2ormeEpIyRlAApTm1dbMcCss9EqCq0YuQoXBz6B3mtVA0k+9K7s98BtiD1rY5cgH32PHvCdvBZErnYSzP0L9LI/lkPenFG7Tn/NWpDULI6lgPQ/cRZwMzo+kHPVCMPau+YztjbcVjRIKzqRfrIAzrupS0MHKj4NqKN7D8HVM5NtqfClP3TvmU4diJhktIwedcl9002Ygw9jNE1S2QkZXKp5niVjfgCHPAuBhlfEWiC7nzzNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM/7rBbvFmTloP90cbfDESDHZVvtwEhdd3UXHRXpRbE=;
 b=jI5e35NZ/fbexZlrinfXUBFP5B28Kd81ND16CWii1ZrG18L/G2oJM2tdNXwapU3Qhw5TykgIiW95AjJmznHrukhXZ5MyLJm/o51v48vLY435p7n0/T12IxmemgZXk0kt2ulT2tSPRyM7YHbTe2Me2tcPJztgVRyivuBA6wxZHWujfgyqw1Ouni9FgTT25oV+6MqfCOSFEfm/uaDNeHGwR8u712v/G8/al4keF/gigJxFGQ3kOHVIHEVeV99jom9VBPDv13ActRH01Asjo65MP7VOIYCueehzvpQ3FjNNSKJCX6iPDgaT3/L1Euy9JmhIZUwoAnBo66CX03fpjNIkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM/7rBbvFmTloP90cbfDESDHZVvtwEhdd3UXHRXpRbE=;
 b=YkaCjFPQJ9az6l+X5e2x+4Qk/WbImO2bR9CW26Vn454eRC04LOvx3cYnqm0gpiK1qb16SX1YQEi3nwZTlCiokfGkP5b9IP8WUmVS3JJy43aRrbT2XRw7ofzSECXFqJlkuExycRn9Y2YXzF6IszvAur8ngNNivz9ZPm6itVVAn90=
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:31:56 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e7) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Tue, 10 Jan 2023 14:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 10 Jan 2023 14:31:56 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 08:31:55 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>,
        <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Date:   Tue, 10 Jan 2023 08:31:34 -0600
Message-ID: <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dabf742-5c42-48e0-db5f-08daf3176cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: co8R8f9Oktuh1gclZtNKRE7ZNXRbHfPr1Z37K1wys51wAdVc+8NxhEsO6r9/hBaB7sD9nkD6+fKEXImu4ZPE+yc7O5olhEOpBdd0gELjcvjHJDCOm1K8J4AgYkwxlY4rFODY4Bl8SZe5u4Pg01BovutQWdmb/bpx4shM0piolyD6rcw6fJHSbkacnk+HZnrKh+/2KcPMQFFTCYe8RNeECB82qI/SqVrSHLgRHK5jkihf2EFN76YMl5MSA15UVScZ4/iGhmNgvAI4xD7+FkmbTI4LAsNnOQZSWUiTIR0omvmwR+cFGFWLzP6LLyEnmVSpj7oBOOGk8WnGmCFg4ilH4w282E48sjD1Inevjwovw1whJyxN/c1AbCFkmtRQX0v1cfRiZK+K811vFe+Ej1J3FbV1reMlZaEvqYLz19mWONXzaElHUGvPkFsjQaK+dmgSPzw0Qx92J9yPDcv/arTOw9WIyTqSvOhwLKqovtgq3cpjq3gU63p5vm1Pth/neUFZ0YG/poyoT21jxqq6xvB5El81lXCQerWjzq/XGlcwj7Ndf4OkmgWLDriO4pDgxc25UESy3/zPpqn2UEflLbtNQi4B7/zUbU6sbzTSKRtDLQKafHmfbjvWFkOy2EbBa6ZTri55qF5sVx9U1pj6e4ZeYSNC3JTric/C9aOaH+8Wug5NPvOEIdFSbm71C043bpZCX7A1LF9fV756OtHZ3t0VLgVsbAgVNp+pJ4znfxHEERE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(316002)(54906003)(40460700003)(186003)(2906002)(110136005)(82740400003)(478600001)(356005)(81166007)(86362001)(36860700001)(44832011)(40480700001)(16526019)(2616005)(26005)(6666004)(83380400001)(70586007)(5660300002)(7696005)(41300700001)(336012)(1076003)(8676002)(426003)(8936002)(47076005)(4326008)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:31:56.3726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dabf742-5c42-48e0-db5f-08daf3176cf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, to detect if a domain is enabled with VFIO support, the driver
checks if the domain has devices attached and check if the domain type is
IOMMU_DOMAIN_UNMANAGED.

To be more explicit, introduce protection-domain flag PD_VFIO_MASK
to signify an VFIO-enabled  domain is enabled with VFIO support.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/iommu.c           | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1d0a70c85333..ad124959a26a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -439,6 +439,7 @@
 					      translation */
 #define PD_IOMMUV2_MASK		(1UL << 3) /* domain has gcr3 table */
 #define PD_GIOV_MASK		(1UL << 4) /* domain enable GIOV support */
+#define PD_VFIO_MASK		(1UL << 5) /* domain enable VFIO support */
 
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3847f3bdc568..681ab1fdb7d5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2056,6 +2056,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		mode = PAGE_MODE_NONE;
 	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
 		pgtable = AMD_IOMMU_V1;
+		/* Mark unmanaged domain for VFIO */
+		domain->flags |= PD_VFIO_MASK;
 	}
 
 	switch (pgtable) {
@@ -2130,6 +2132,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2144,7 +2147,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    (dom->type == IOMMU_DOMAIN_UNMANAGED))
+	    (domain->flags & PD_VFIO_MASK))
 		dev_data->use_vapic = 0;
 #endif
 
@@ -2176,7 +2179,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
-		if (dom->type == IOMMU_DOMAIN_UNMANAGED)
+		if (domain->flags & PD_VFIO_MASK)
 			dev_data->use_vapic = 1;
 		else
 			dev_data->use_vapic = 0;
-- 
2.32.0

