Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C323B5BF90D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIUIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIUIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:23:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185C83049;
        Wed, 21 Sep 2022 01:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3j6l1jWaFdiYWiKvv1nl0TkpM/iy5DsmqQmJR/hldPBCIaAXz7MBGoCLX5tUF0rILc7Vy8ROYaRTlhVQo8xkZVWqveEre6opRr8TEUE4ZhkSAmlFL+hfQb0maGGmylnuszAovEIwD7ePN1zPzHIThzMkhd4n9cnf4SJMGozoX8kB2+KUvRq3G9z5eLKj0IZPAk4Lv/ZsU+8iLSIgs3ruRrCIUSc6yII2BxM5jggOwZMs3BSZhLXzAU7pY9/D843XrcRoLT45iWii/+0FHrKvxLZXuVCPvqwdC/e6xVRYQYg7OZFfzN901p0oJbQuRATOYGGpAnAaqzknA9PTWaxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVWuaU1xhsyPp0FldJ+R6UJIQ/awjc7dyDtFiRvl6jY=;
 b=RcsTFJ7td2VjW2SwOuRgwQINX+xTwiw1OM97AS9fBaQFKxrmyi887xdtoeCQDAtz1l/6yLxZ84CjaU7IK6IzpKY6c2bH3XsxgSCoutnazo4rLjlDXJwqgDXivuBlP4Swt+PM4haO2S8g/Z5anyQLVCYW47hKrZrtiyDwVZDj1gGdHUn6SEYu0ocP3p5xYGa3GMNpswdwUzBFKQyPMaO09mKe1xbiq2wVFU24oJdSMX6aTveTwG/kJZRogEs+OUNyyesjUfbON7ZWtmA3TH66CoHOrc9yVxnVlDSHouLC5DxFPH7/0ZPnVmab3N1mnwiaY0YnYr5mNCAlT6cP8EyHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVWuaU1xhsyPp0FldJ+R6UJIQ/awjc7dyDtFiRvl6jY=;
 b=ipwFkZuwiUfU3lKQATOOxY+t8sf3oCHScGZWrtQKMfpCOS/RTEF7IZ2qtt/Xcckbn/ifz2FKzssQwkdvHtTNAT5S5KqVxXt3rD9C5Quc9Jdn4ZAyO2cXN1zFFPwBx+HzLXdmJQJC9vYWRMUa1OtMgBpN6UFEOHBOX7cOTdu60OwxCPAVxo6fvECNgIg2vZDJBeUxDe1mJ6nHW9dL9y7WvkGbSWV0ruHECDU9QiZW9yBGtb21AblbNXVvuVMMqXr2IYeh7+odvIZ8PVBj8y7u6sWZfiWFIysgkoM1ZA+nfyIruGyiDJD7EE8CMmgWsWWs2OEbjOrd61RSuFHNUApaHQ==
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 08:23:17 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ea) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 21 Sep 2022 08:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 08:23:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 21 Sep
 2022 01:22:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 01:22:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 21 Sep 2022 01:22:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] iommu/msm: Fix error-out routine in msm_iommu_attach_dev()
Date:   Wed, 21 Sep 2022 01:22:53 -0700
Message-ID: <0ec6d333a98bb6a11e254ba49ecb385e50a52588.1663744983.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663744983.git.nicolinc@nvidia.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: c28e9011-e55b-4d93-a295-08da9baa8926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkGi3iElH8VO5hBbcX+MmSaUhOs23Lit7EgYWINzSEOP3P3vyuYdQFq5igkdtzHcc9D+PaJ0GL7F3PUDdla5dn+sCmbuxxVo9Po9KzZ8Kxh8UA0k4rDuaWH+y7bcsds770IilHEZqKJr9caOQ71w5AFrHYj6n4SVMt/1ZsNDAFOj3nbxQgRyzJMRlGODlOlHZLNP/Q/y5KXFsSxY/9MJXAfLgj8m5fuRVIWzgdiCKyjL0I9pzVG/YPqov2VvL2rcHkiTAjrX40o3ShaQ85Rpt77g9CllZBafGACKzTH0l53Pzb6dCj2z7Tt604/T15QRh8HRJTEENexf4K1P2fBdr78D8k00Hv18C8uNruPX7CcmV4odNSsx1WiZx3l3NmxDBI27d+AuNXHbfOnmAyN0otSx6gdOq33eQN5jWL945TbA63Ntr4ylLokLJ3XuztBZrJAlolv21bVhvDY88Q3NzbyhOP4RJy7DNGyGyw6QCZDQj3yhvMWvm6WomRUROWfA7qU9+ZeVmjCWTUGBxb/5/8+LoRv4rVOl4GhFI+uSXFhBsUSwcUp9QPoRpMju07qlyLgEEoL4h08bz2PzI3vgZDvq1Atl2SaobLNGX4RXO936TBQqkIxbhkc97BnsHrhWx9LGc78KQ6J6rwU7wRxKxp7O/Kf3ufL64MaPXj3hb2UytWnV1ZdjqCbzJRCI16spMST/80eRj3pjOrC03yfG6LHsKdMl470vIrrIpHSyF0IKnq/gtiXPK+kcE1S9IxtxpjQRRMGwses/kntGCEEOzg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(7416002)(5660300002)(82740400003)(83380400001)(47076005)(40480700001)(26005)(2906002)(110136005)(478600001)(8936002)(54906003)(40460700003)(316002)(426003)(86362001)(336012)(82310400005)(356005)(186003)(7636003)(2616005)(41300700001)(6666004)(36756003)(70206006)(70586007)(8676002)(4326008)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:23:17.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28e9011-e55b-4d93-a295-08da9baa8926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error-out routine is missing all the reverting pieces for the iop and
attached-ctx allocations. And clock enable/disable is unbalanced too.

Fix it by adding __disable_clocks() and calling msm_iommu_detach_dev() at
the end of the msm_iommu_attach_dev() if "ret" is non-zero. Also set the
master->num to 0 in the detach_dev() since attach_dev() would check it.

Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
Cc: stable@vger.kernel.org
Cc: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/msm_iommu.c | 59 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a24aa804ea3..14df722f0060 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -394,6 +394,34 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
 	return &iommu->iommu;
 }
 
+static void msm_iommu_detach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct msm_priv *priv = to_msm_priv(domain);
+	unsigned long flags;
+	struct msm_iommu_dev *iommu;
+	struct msm_iommu_ctx_dev *master;
+	int ret;
+
+	free_io_pgtable_ops(priv->iop);
+
+	spin_lock_irqsave(&msm_iommu_lock, flags);
+	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
+		ret = __enable_clocks(iommu);
+		if (ret)
+			goto fail;
+
+		list_for_each_entry(master, &iommu->ctx_list, list) {
+			msm_iommu_free_ctx(iommu->context_map, master->num);
+			__reset_context(iommu->base, master->num);
+			master->num = 0;
+		}
+		__disable_clocks(iommu);
+	}
+fail:
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+}
+
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -418,6 +446,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			list_for_each_entry(master, &iommu->ctx_list, list) {
 				if (master->num) {
 					dev_err(dev, "domain already attached");
+					__disable_clocks(iommu);
 					ret = -EEXIST;
 					goto fail;
 				}
@@ -425,6 +454,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 					msm_iommu_alloc_ctx(iommu->context_map,
 							    0, iommu->ncb);
 				if (IS_ERR_VALUE(master->num)) {
+					__disable_clocks(iommu);
 					ret = -ENODEV;
 					goto fail;
 				}
@@ -439,37 +469,12 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+	if (ret)
+		msm_iommu_detach_dev(domain, dev);
 
 	return ret;
 }
 
-static void msm_iommu_detach_dev(struct iommu_domain *domain,
-				 struct device *dev)
-{
-	struct msm_priv *priv = to_msm_priv(domain);
-	unsigned long flags;
-	struct msm_iommu_dev *iommu;
-	struct msm_iommu_ctx_dev *master;
-	int ret;
-
-	free_io_pgtable_ops(priv->iop);
-
-	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
-		ret = __enable_clocks(iommu);
-		if (ret)
-			goto fail;
-
-		list_for_each_entry(master, &iommu->ctx_list, list) {
-			msm_iommu_free_ctx(iommu->context_map, master->num);
-			__reset_context(iommu->base, master->num);
-		}
-		__disable_clocks(iommu);
-	}
-fail:
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-}
-
 static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t pa, size_t len, int prot, gfp_t gfp)
 {
-- 
2.17.1

