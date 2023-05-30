Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C93716349
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjE3OMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjE3OMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:12:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4145D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Tpm/6DqcNXLQWXdT099SEPaT301wC4AQ0FjWDVZp9yD8rJUvStzXS1N5sM1pGcHCOA94hDSqtc+WZ2L/u4Lu+2JZ2S6yVHJWqCIBx6NwQ60/167YLjMBbaKKUaiAUoXA5eI9P105yoM2JGN9irwImdqIahj1NUaztVQC+iZRuqEP5Gr8nlbqwjIekdyE5HMNG09Mbj40cICEK7d8BpZftyw2sjtF7owXxJOQyyvhr8bpQs2N9m9n8OkQMnJ1wo6VL3+uO4U6mYp6uraxp1n6OKKCg64PMAAo3rImLZ9NapJjyE9NxFAb/xyQGcQs6SAJHMJymXvcBN0MrepcWsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dplin9jP/RrG09YT921BmrFYs1i2xvloS5wsq9ZNzQo=;
 b=U8E3RKW70tG7TwZYGf6Gmo57KI+zTz6OayNXMxByE6w6Jj7rv+jcAu3g/brlXNfAV7PErF87i+Rq4e//mAyvRFNVbJP3UVxmD+KaKs1zFxBhEkr9VoRRZ8tRWJY3Tpj3n2/aqDgyc/4Z/UgXLCKoZrTkCMbA5VysHIx0HmFFgJb4nWd7zxF46talXBSMLynyUHlqOLUkmoahTB8I6FfFLPOnhV0TtQUiCefWyWm/0e6GVKO8XxzWuuoE4hAxCvHBPmLhUxzzKbz4E53C3U/3oAJqJsOcpaypTg91oEoG78Z0T1esjixcVsV4CtK32bBObgEgyY10oeC/2eWTbEWOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dplin9jP/RrG09YT921BmrFYs1i2xvloS5wsq9ZNzQo=;
 b=Gm4ryB1JyePlQ4e+fgoSWDeuodsCdxtA6b0zJ6Sn2/W1Fqlol7bb8y9aBIKPM/M+qKdJ6Pb+0dkxT0s6TyT6wHxw58c+95xrmOyWP6FjXd/VVJU91xg8erqz1k5nOit1yEClEF0NaBKdKLAma9wMXce5OA+FQ3CLlZ2ylgYLjZ0=
Received: from SJ0PR03CA0260.namprd03.prod.outlook.com (2603:10b6:a03:3a0::25)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:12:05 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::60) by SJ0PR03CA0260.outlook.office365.com
 (2603:10b6:a03:3a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:12:05 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 30 May 2023 09:12:02 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 4/5] iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
Date:   Tue, 30 May 2023 10:11:36 -0400
Message-ID: <20230530141137.14376-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e52a11-1585-450f-6627-08db6117d909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQyTcyWUg7+clYu6S7DQEesyA/PyrE6yL/PCtIOp6T0m9Bkh5asVuQwPTODWCpv9jrf0Azcg16fPbAFje3wqFnXct9sd+1i3PH2m79WHXuaSOzcxPZnLNykZOKwxsKFCeLKgXAzejqSB0NbKChyAtdyqy9srWi2BGF43eQ2r0i1Pf2ukqx2RkemNNx7u9K+DgtVND32CJ4ruvMBwR/csnTKbR0D0eTCeII09AE2y1DPIMfCZVvU8vK1xFDl12iQQOjTEUdy1WIMlmuHvLdUNi0Hlwq0JEqfPCeiV5UPtizH1CW9ek0RkrPgwCMmJpjuPs4yzRIglxuV/Lz0fN7NUNKkJswgbcx2OIpjjkYl00bUDsnsKes4g1mtmPEBL0e3kOnK8wAK5S6cwSGY3+OFQuYodle+wCCFxwgOD1D2sczmrl4sUxOwkj8SWweJomDlqcuQu9j+DDPjtPDgaiO9Fo1D+3Y15OugLarYZXxit9ugr/XMfPfm7IcwwiNIGXWZ9jhpd8c6Ev5wCiE93BvmzxMc518Jw6vyXSgHxSVjQ4q4jAzVQd8GjYNdd82xEP6qxkCH812QJ6BxxRwWFC7eKhCFTmd2CoXdgSDWbFXm+y/kzNdmNtFcJ8LttOgJuMrWE5V7zPRFSk2o9xyML9ngKkao/J24L3Rs0Syq1Zlt7aphmX4KGtc8NNMCVGY0VPDXx0CxLgYdEAdWa6k0iMU0U959OcRSXSter1hBmyhNVOJBfIFunM/pZKNgao60/LwgPpMMlfhaWNB+q1ZjIYhSddw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(186003)(16526019)(2616005)(41300700001)(426003)(336012)(83380400001)(1076003)(36860700001)(26005)(7696005)(6666004)(47076005)(478600001)(110136005)(40460700003)(54906003)(356005)(81166007)(82740400003)(70206006)(4326008)(70586007)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:12:05.5064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e52a11-1585-450f-6627-08db6117d909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Interrupt Remapping Table cache disabled, there is no need to
issue invalidate IRT and wait for its completion. Therefore, add logic
to bypass the operation.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0c4a2796bb0a..51c2b018433d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1273,12 +1273,24 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	u32 devid;
 	u16 last_bdf = iommu->pci_seg->last_bdf;
 
+	if (iommu->irtcachedis_enabled)
+		return;
+
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
 }
 
+static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
+{
+	if (iommu->irtcachedis_enabled)
+		return;
+
+	iommu_flush_irt(iommu, devid);
+	iommu_completion_wait(iommu);
+}
+
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (iommu_feature(iommu, FEATURE_IA)) {
@@ -3028,8 +3040,7 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 
 	return 0;
 }
@@ -3048,8 +3059,7 @@ static int modify_irte(struct amd_iommu *iommu,
 	table->table[index] = irte->val;
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 
 	return 0;
 }
@@ -3067,8 +3077,7 @@ static void free_irte(struct amd_iommu *iommu, u16 devid, int index)
 	iommu->irte_ops->clear_allocated(table, index);
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
+	iommu_flush_irt_and_complete(iommu, devid);
 }
 
 static void irte_prepare(void *entry,
-- 
2.31.1

