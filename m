Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13955E5DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIVIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiIVIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:54:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D15B4EB2;
        Thu, 22 Sep 2022 01:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfKyjr5sG4m9Gv3jznGU5qchcO2hqfpiH6IQiVvXx+2gJjIGV/LaXTJH/2N4gPQX3t2ri+75wZWC4jwHMS8/lwQQ+mcDrcvsillQ/ifyuEr2RujpyoaCwwskakbGQ3N/FBzcw3sgqmjYm+9Bqyhm9RirO0VuTlEYPbYhTPkILzM21myVgZ71ZcrwRzbAq+wUQPeBPQR0T4ODVZPQ//mEx7J5bPZeDBqZF4sD+29GlPU6oAcw/f3v7OOR9wDTd2qlMrlrZyA6Ha99TqKXs0hUloObFqOeyprCO0Rv45GoloEq2993+DSzxAYOgC6gxIBjYnHL3fh1tiCF7iQ+eEushA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLwkC/P7zQ6hAE0ocHswVqwiO2oH27WCZXrbECT9knU=;
 b=f+xk4Dgq4AqZJASBMgL58GWwpnqzcmStgQ6OIYNssb3kjZYVQSHkCxM8yNcaxB3peGxdCEp2PzpQTNyToVNpHzGi/gmRCaeTgoKZeymuJ2hSDxUe/S6BiAfkdwQtGvGbGGP+5ajvqq1O9405Pw4svO7PXmsrGxsWZ2IlTbcp6FnTR8K5O5enbecTClJ709nJdmevNRQCRxLMd5jRtCQj9mPho3ZWYpnq/4F4I6cZ++3LZ45VEdjA8hvljRqNUJW3sFD5BKAKuiKXR7v9B+sgNc7NKo/D+cs/0jYKge+xF8gv57UZITtnep7kyTMgyxKnnbQcd8zdakUs1BdcMy2+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLwkC/P7zQ6hAE0ocHswVqwiO2oH27WCZXrbECT9knU=;
 b=U+Fnq4rnEq6otGGIX3zzG6Qk11gri+enKOpl945Sz2bsiYz2nAwX2SWS6PKyZT1HELWMhXV5Oc6ktc33BMsGYRIVDorOAtVRH7YS381442Jh+VSx6kYKK/UaD48lBtzlbTLFXx2nKTqRMSX3cqA5Kr4vy17lkazO+efT8iZwshA8+HyhcQErFrAwA+By9XMPHw2W5OO/8sV40D30/DGPRq763bfxtkN5s2eCtg0gKbaOO1/ruBC7gV1/WAk7SC+wnvLYElkeNm11FIjdKUB/VL6FPB0tyJOM1hbg10MjWKBn2SQMRPbBm/9gZZ1IlpYEJcbxGvyMfMnqygFM6khGaA==
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.23; Thu, 22 Sep 2022 08:54:02 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::30) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Thu, 22 Sep 2022 08:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.11 via Frontend Transport; Thu, 22 Sep 2022 08:54:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:53:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 01:53:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:53:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <sricharan@codeaurora.org>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/6] iommu/msm: Fix error-out routine in msm_iommu_attach_dev()
Date:   Thu, 22 Sep 2022 01:53:44 -0700
Message-ID: <23e009bba72c3e46320c59acefbbdd976111cc8a.1663836372.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663836372.git.nicolinc@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: f75ce6fe-c8c9-47f3-0d26-08da9c77ff50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EY6cz5HKMfW8EMqcvxy+tYXZTFM4fk1/fIRyeQa34wiN7ZjZ69Q6DCE0m0NzVMqjUa2IEMBGqqjaV4uvSbJzUTfEDspR5RuTSTBJCTcpSu4xkoS7Kl9gKfvDbZtRl064ommOsAaYY7lAeqLOfbKhG90AQpFoqh98ojNGRHEv5EOzQGlW7Iq12/AXsCR+uWkfTbgH1dV6/Pff5z+KAYxKy/MjEbGUbriOSSy65iCgDw2xet8jzsrzclvd3aAb1Y7Swzz4DCmgBJQtrdrk45LkhWGKSZfK8q04hd37uWOi4Jl784Az8F3/hPYrKGF3sEzIChV82tOdzjcUS3PRVf3+dAkFB6WwVv6g3naDZAZ8OfOK1GoUBuBoeDDp3kpBMmbTN+kjO/lj3GsFQ2Wo5zPWx6Nnfa5agUfBsc+c4Cv60bHF9hWo1X7HmvOgSBvsySDc0ivjsOokZDKa7UkPxXD2h2b5HtZn3RrK8bUqDuW7JFLNpBcU93aTjShoNozhBQ71FuW0cqqsABM0ars4h6XBN8MVOmV8jBdVPTmwmmAVBKQAc909c/rPaZWg7gXRhsnOjPL17jqheGg31ipDwgMytIX4gBlB2E2hbmWHDzzyuOsrh0bALeTNJH5ETk0QW4bfu3p6F5NcBuauN/1AXGYrwzZ4h0evXf2/vz9ZApVOCWvCHs6pMA/OOIYS0cZFBQFi2996G1SsIagXAfQTmdyFEqyginOlJxGtP4ZSiaSQaIBc/bD4AA5XzzLWA4h/1SUJFdvmbbsRxFSlToVrGaNHNg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(2616005)(5660300002)(336012)(41300700001)(426003)(36756003)(7416002)(83380400001)(2906002)(8936002)(7636003)(7696005)(186003)(82740400003)(40460700003)(47076005)(356005)(36860700001)(40480700001)(316002)(4326008)(110136005)(82310400005)(26005)(70206006)(54906003)(86362001)(70586007)(478600001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:54:02.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75ce6fe-c8c9-47f3-0d26-08da9c77ff50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

