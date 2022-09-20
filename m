Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD05BECF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiITSrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:47:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9A73324;
        Tue, 20 Sep 2022 11:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWEAoPa4UGzwJ5Rh6enpXud7ybxqGS/bbhdGym7ofZjD08ZkQezszlmwiri0DatIvNrL06h43gLd2oe9Sez0Gk69FzrUhT5UDSP8TgIdSHPXcbUFz9TkWqXxYrUIjdZXwIq7Btt8VKCdrHq5oWseE2HbV3TZbwvA0BPcyYBAXOHfuMenYpPsIHeBtwPcVlo/ooDEluSnsBgVsws7CZApi1T+b8iWh6K2nGH6A2lhFCR+BfO+6GWzVHk1vOLH64V9zBq+YhUvm59A0Hp795mafsaAOJ3LW2fzYU0hosaTXxkOSr3brp4sTX5iUXnLNwTgukkdUpjbF9FDFtsgFQqstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ8MuUyFzAOWv9x3sFULERidjHCWcZL9ygWzdpfCOZA=;
 b=L5ZCKvLTvkyf4cr4xFSneP7S1LAZ4DstCL0I0tU2qNwfwsoEc6xUy/0OirFIvUOaIh9Rx94SuXIiI3DWrjp9rFIazlHglFKuY/j2sXVR0/HCZ8ZccX4GYVHVjzZKoHxYd9hQPnm/GPwyM2yUTyCBrDd+KddCG57Omq0eYp+7ouzmphfRQjKbgdNfbNxowUKtkFAzJCDJjT9bRFsibsuTObhKW+r6mY/LKiE9zCf7jnVg4gERCxG7jLK9Y2/lmh1OCfYLwsxsdXwwm2yFd5SToJ8RczCUDY7GQT6jM9axRh6hi+/v2ceF/01rJELdFENIIe7G14A5vN7ZlEv5jbgMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ8MuUyFzAOWv9x3sFULERidjHCWcZL9ygWzdpfCOZA=;
 b=Z+KY4RV1LyjpteNuWr8BkYj8A6w5vgKvsPFB+KkGehOAHv+TuFsl9rv2TuiFAorALFTA4DT+e+xlMjo2u/ZzqqE8sShPwWYjwiAVvcLuP95R4mpxb0fZeK5x8t4hvO552NgMmOc7Rtbb84Z/m8yMK/I0iP5NWdhLDSSL/EcdJYsSbfLx/tYjH7rorf0Q8pABX439ihyd6mFsuWWFCqQifbA7Gs7NslZ3cB3tF5IOrFhzRPIEXyTcrY5X5WBrZm5YE6kem8wqIbFIdXVsaFRziB7Isq12X73ZsBp01ddEejFp3Uw1hWiX5I/8JO/wpNCMMb6PP76Pg+vt7DFeDqjnjA==
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 18:47:01 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::4a) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 18:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 18:47:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 11:46:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 11:46:42 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 20 Sep 2022 11:46:42 -0700
Date:   Tue, 20 Sep 2022 11:46:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Message-ID: <YyoKkIjiou4kBwPm@Asurada-Nvidia>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <031c4ec032025a299d72665118d58dd48aa936ac.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB52769AEAFD33D2501B6571538C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769AEAFD33D2501B6571538C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: f457a04d-f2e8-44ce-420e-08da9b388134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfR2/ZtwzkSpLPPnD81bbFquUi7yG53YMVmzOtx4uiVd9yabipHAFTCyGyEknA0r7D5ZwE4KaUSV3hgXr/9lBEUMui/iCq6C63Bt4yx/bw8KF397lkDamidkAYDsGgaZ6EQ59Ptt11HdHHUj6BLbuvAPAOl1DL/GqNiGh872SEz6QT3mgr8Y5n3vSptjEzgeCOQrYCVlDoeJszYY96Jb7xEtwETY+aG27iogAEroHquXcg2+O4zMD3s4ujV4wCQg6VVTbNgklMt+PkZR3+yBcL3iA9fj67bxBaSBYDcPbt2cNn2axqLxkKtI0Zs7BVKYbu6XU6TsoIMGQIcbhF0peUvdBn4DeiygQxoW5uKVcGMiXQrO4izmPPWqJNzBFwyd1Vfgp7hFODXrwttdzuBGyll4C/fIqVqM09aDrQYxbZSazFCuEuNm650Z8KfhfBhwj5+2Up8IwcFEdnBCndJA9t45sg0nhrdIFr080tB0n1scbrltFPLmcAFeVhAi7EVKnHhiqpUn+RgAvA6y6ARDcPOR+qLrp7yVJMMhJFMtUI5VYCTl6x8Vrc464vWOYKqlJNTZVUa61/c/ptMyktgcs6bPVGKB6vv2v4P5w68+mf3Gz8MQtg2wcNFU3DeMIBdZL4uo2nPsDkmoZYEjgw5XoIJqeaxOuFk1OYhUi9m8ZkjAuAlvA9f6h0kdBgNPSShJzoh4PA8qtDSq/JmjMPpB03yf3lstVYXM0mOpIj7HXodkLbHpqZ/OTfo6d9ANJ7TfsJBGBvhTzhY89YUyavvlEg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(4326008)(2906002)(36860700001)(356005)(40480700001)(86362001)(26005)(55016003)(8936002)(9686003)(70586007)(478600001)(7636003)(70206006)(41300700001)(82740400003)(40460700003)(426003)(54906003)(6916009)(336012)(7416002)(8676002)(82310400005)(83380400001)(33716001)(316002)(47076005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 18:47:01.2631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f457a04d-f2e8-44ce-420e-08da9b388134
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:15:21AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, September 15, 2022 3:56 PM
> >
> > The clock is not symmetrically disabled in the error-out routines.
> >
> > Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> > Cc: stable@vger.kernel.org
> > Cc: Sricharan R <sricharan@codeaurora.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/msm_iommu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> > index 6a24aa804ea3..a7d41ba4a47b 100644
> > --- a/drivers/iommu/msm_iommu.c
> > +++ b/drivers/iommu/msm_iommu.c
> > @@ -418,6 +418,7 @@ static int msm_iommu_attach_dev(struct
> > iommu_domain *domain, struct device *dev)
> >                       list_for_each_entry(master, &iommu->ctx_list, list) {
> >                               if (master->num) {
> >                                       dev_err(dev, "domain already
> > attached");
> > +                                     __disable_clocks(iommu);
> >                                       ret = -EEXIST;
> >                                       goto fail;
> >                               }
> > @@ -425,6 +426,7 @@ static int msm_iommu_attach_dev(struct
> > iommu_domain *domain, struct device *dev)
> >                                       msm_iommu_alloc_ctx(iommu-
> > >context_map,
> >                                                           0, iommu->ncb);
> >                               if (IS_ERR_VALUE(master->num)) {
> > +                                     __disable_clocks(iommu);
> 
> also need to free_ctx() for already walked nodes.

Oooo...yes. Probably could reuse the detach() -- [1].

> btw it's a bit weird that although here is coded based on a list
> in reality there is at most one node per list. According to
> insert_iommu_master() a master object is allocated and inserted
> to the ctx_list only if the ctx_list is currently empty...

Yea. The insert_iommu_master() indicates that there would be only
one master on a cts_list, while the rest part of the driver tries
to take care of a potential multi-master per cts_list case, which
practically won't happen by looking at the DT file. But the driver
existed for the legacy platform data configuration too, so I don't
intend to change too much...

Thanks!
Nic

[1]
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6a24aa804ea3..30c5662e24bc 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -394,6 +394,33 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
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
@@ -418,13 +445,15 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			list_for_each_entry(master, &iommu->ctx_list, list) {
 				if (master->num) {
 					dev_err(dev, "domain already attached");
+					__disable_clocks(iommu);
 					ret = -EEXIST;
 					goto fail;
 				}
 				master->num =
 					msm_iommu_alloc_ctx(iommu->context_map,
 							    0, iommu->ncb);
-				if (IS_ERR_VALUE(master->num)) {
+				if (master->num < 0) {
+					__disable_clocks(iommu);
 					ret = -ENODEV;
 					goto fail;
 				}
@@ -439,37 +468,12 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
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
