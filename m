Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E46FC4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjEILRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjEILRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:17:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9846B0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI2uYnl4g41/srZhLj10ZlgglX96Dn0RX+Ukfeg2Hy9XgCXEYDe1ncXMUqS6fnLQhaXsakZayGW1FwgVQnp7pkrSD8ZB7nZ4mX2eNvMaAJQ5OQwiM28/hBXclRnBIuZ+bM8icie10yZiZGVcikWiyFFkrkZEL3yzx5Mgq+n1kWf0zWnkJVhmTB9oOgClMJF4PrkzV9Mn6dpJlQmh4+aqutkL9X/qJYiqqFXp3gdW1H6Cj4p7dJxdxKVyrVvnZNmmM7oC+hSW44Ml6qZg+BFS1HC9HWtgkzcFQaDrzLwNoysA/Y/UnLMw7IK3u2Hq3g2LryNF7zqw9oju64cgmDJTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhGNxVBuLU8j6nRMP9u1WkiBJLLOolekgHbORFlHSAg=;
 b=LL6WaxnAfG9IhaA+HB8o6AmmWPl6dB3lJzOFQVSBM/ngVQFgsSj+ph8OejNcXddiv09MtAllDJFsCy+dBY4L6iqKR7Us9wiwghDvMl9z9hWLkSKKQMAv6sjvKurYXr5HvsrBdZs8YE4ItkCBUZWJtnLdD/eruonPIBLuHp9XFuWLuQHanZRe+03VN0QTEgLxkCXlpJJkPI9YAUSppi1UsetRvwsiqHNPUUHZx0cpL+1OCrKFHLCEg2V1cj2rvubaspWjCO8BBpI1Df2R55tPaIU9/4DoSE10uUFDDaEMfZr2GhcJELHPenGR9T3P7F1YS+MdoCEqmALOnxVNLKZMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhGNxVBuLU8j6nRMP9u1WkiBJLLOolekgHbORFlHSAg=;
 b=a//lRT4l7oNVwf3ZXTJM7zmnbvJWHSyzgp2wGnOarGAw2LnAvVqkWBPMJskt4OITMJ7HvxW0HjUmhCVFiiYqbwrWOde1vpl8QuuE5f86c0kS01AMiloDHlEod45Dn5A1Yot4M7jXVCHAnPAamtJPnIdciBwtO+hKqs0T4isLGMQ=
Received: from BN0PR04CA0135.namprd04.prod.outlook.com (2603:10b6:408:ed::20)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 11:17:35 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed::4) by BN0PR04CA0135.outlook.office365.com
 (2603:10b6:408:ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 11:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 11:17:35 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 06:17:34 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/5] iommu/amd: Do not Invalidate IRT when disable IRTE caching
Date:   Tue, 9 May 2023 07:16:45 -0400
Message-ID: <20230509111646.369661-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
References: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: a518cd2f-6fc1-422c-d293-08db507efdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V11yhg3vLvuAznKL4fqVe1v3p2vdg8PJy/8HFpUY6i5ab2oDrIAC7E8h8R/Yxd2ARA4DZvZUzxgo3g+yeLO3DdhYTDJJ3BKSU7cVlM/7xbVroXU/Npm417cF3m9FSH8bbDsyex/qGSlwQl78UEe8SLmdOt6EzsC38PM5Epyk259lR3VYBN7CWowY4uOX7V6b9xiDxk506LS4k/UFeVPQ/Qiu7TWLN65/kcCO3WB0pbzh+chCPg2M0AEutpMHReIdPfb4R0sEo8szcEBdNRBUSUZAXRrHaDINLdJlENjU6GkCs3N5W8Ei64kf/RCdVwtQqXN+0a1+HJYpapV994j78notBfS0ZHiY5pNo4nujKakpZkyVRIMqMkiUIvZMgcSg6xDLDmbq45ODoFLjo1LQ7FQVm9lsNqWx94k1YORPMlTnxyydXv7g7Zyu/IX8upMM7oT8bSXiagDFtgsVAzl4WxmJTwImh3g78ILO7zZy75CA2d2wc8JN2AxCeMbVNo5egeAId+IMd7lLJTDz2E44qZtbAVBNub0noKniLVgUMkW8vxdJT8uXVtOhcTGntUjm3zaMREZadEM02OHY6XHHAkzpsIZPx2nAs14xDnzP1PRYuiuBLeHSTcAUFFt6tSJd0kAmMZNPUyAh+MiRtAytx0WFLifyuKB4tNLmmFa8ky5mN5tcLMihy4OhrjjU/qlCK5WyUYSpl/s8g1DzG9DYzCIxo6t5J+Wkf57vQMuKbgrdBb8OaQD3guRnNljRtJqRuYrJDqyURqiTZ3kMsfrDXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(6666004)(26005)(1076003)(8676002)(8936002)(7696005)(86362001)(82310400005)(44832011)(478600001)(16526019)(36756003)(40480700001)(186003)(2906002)(5660300002)(356005)(47076005)(36860700001)(54906003)(83380400001)(81166007)(316002)(70586007)(4326008)(70206006)(41300700001)(110136005)(426003)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:17:35.7535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a518cd2f-6fc1-422c-d293-08db507efdd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

