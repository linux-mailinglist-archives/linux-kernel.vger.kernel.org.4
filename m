Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E336232D9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKISqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKISqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:46:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933B2AE3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwA2P6+S+LvN797qqVzOyvXsmc1lGxeljUTSscDnwad7Ha7QNT1hbJ5KCNwC3eodhPGDIsLbcHXAH43h0AMSJZxhnvk9Gkmplu5+8s1Yarcz/+ww0XqMEp4BTC/l/GZBJqu0R0V1vO5PrjAQCaA9+OKBTRTSeru8jfix3CBcbqHum4d5S4abZ123/Zwdv8NF6T0LCFdTIyTCCXSj1utoj0LERs45CBsibgJVar8B6cbHPJ2tplcfFRdxmvSAuTFdaXSgysi+1VT3vhQr72mxHO3cj5nl+TCh+YX5SvtGRqf7eQOYMlUgl7yvXqmaZB5URl1ASHeoYQc2nsu2arcQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTFb8DCOrGAqfVdbPqQyec4vKZZ/ZflXFnusB2GJrgc=;
 b=ka+QTx7ASWgTlygVYuiwp1ZsrkduuMlIyQTXA5ldREgc5LBacI2gDDTubJQBZgNAyBz+4TjW2nwqOkb561HQJff1nGOskyjeW2bw9E+qIp7L3wC0tgxBLB96lDI+NypgMM1C1hJCY2zxTq1mhgNgVno/qwr18RPK6/g9fBvc/KoZrPpKP9PaHz8yS59/gsRPlkqij0QnV+tKZCGPo4vJoqSMMx4U7gD2x3SpkKc/CGcFDDTEiVXCdxmp2GG9HcK6ai7BN33Y10lrhAyqlfPDxgbEDjnRK/T+2BOdwo4vhGfVCW9hwNwjFuoVcN/5iHwBAUxjZigG+WgjGeHuAtzS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTFb8DCOrGAqfVdbPqQyec4vKZZ/ZflXFnusB2GJrgc=;
 b=EvmTAh4EMrmZOmlmaAvclie0SfX1QGWFVpYEAFg6d4nNLLEorFIOUUdDjw2fG30Lrdxn0XNhUrV2ekFuGwYQWf0Y461MjBAhjRIsMSgnjaK5W4zZo8lUZzXtG4s+/yvIOMCg6u/raLnAMpVvK6/Aa+OqUWik0Je7o9I2rG32HMza5NX5dmVyirXpodsJb2HsAKzogPN04kiI/MADe1c0/Je4ZvEC7BJLrCiqHasDBLoowzqDvgFHn5AI/VOZ8zPB7aROoQSx4EiilCsnRYhUWeqaiupj/Bw4/rUei1Dy9UGbZ60fDnqBOILEO80mc5ykYAqB65WOGHQqew5uDdaqPg==
Received: from DS7PR03CA0353.namprd03.prod.outlook.com (2603:10b6:8:55::13) by
 CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 18:46:47 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::6f) by DS7PR03CA0353.outlook.office365.com
 (2603:10b6:8:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 18:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 18:46:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 10:46:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 10:46:45 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 10:46:44 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <joro@8bytes.org>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <jgg@nvidia.com>,
        <robin.murphy@arm.com>
Subject: [PATCH v2] iommu/arm-smmu-v3: Restore prints in arm_smmu_attach_dev()
Date:   Wed, 9 Nov 2022 10:46:36 -0800
Message-ID: <20221109184636.14264-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6608a618-430c-4409-7609-08dac282c159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVg+KV3HGiWfSKXVFD38KawCA1HHNTK9Y0gIg2oAYKvlQWPwgWDCnAy/E0VabVeTvKjgjsIhplwVxqAbRjTsMpLsyFyoo8kkN/b9869oR0QExaSTBeLlp/SpnEQIoWerOf1g863CK+SKqCPsH6d8o33Cs7DCpajImM4E4sLpC+fPJrzqpS7SznDs2pajZIRjaUClZwuHz8JgzhuPjSjUVRLodedzaFTi19Guu/jGO5z9zdDwJd/y4nyD3qi3qqqcrHa5K3fufzFwQf58RpHVUbOcdHCm6VutrrbLVBhmCHyoQyRej/2PR9IFxkKXvlP1tslAETbinQvipG7pD6KeD5MuHMSvDDRv3Mu2Y5B9/cRQUoZ7a+u9zZN6E3TVN6X8+kYVWPNVjSIII11l4wLoeGL7pnMBEt/MP914d7m5+G/T7efWmvTVT2/pI2+qfw8Yyve1nVbGFcEhn3l4BT/x9ZwQxmc44plVI3Jh+KGMN9H/sRX268lHosbWCEEXQFUy1KWzd+IukoyEc0s9zYAG1UAJgAgLbacDYLjsOghLRi5gC19Yb0GAagBWoLNg8Xi+TbMp8VSx0X8q+2RzXy1wJn6PlEOj3VWyHMg2gKb6Xvc/TP+KZNXSeQlMaFWy/SuGH+ZZn94zYkdr+YvEDUngrqDYK08QGhm3mM71NbswOph5S+dbj2GSzok2UedsXsUwvHh3dBRg0MRPLRO1yb3ej4Zcko/xDPT2PKDBl/KqvUZLlbKjdv7OY/XGMOHXqoRluf9A6qTTFu57MyF+jX+sonlgYW9r9WIRLwUlfKQFSs4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(7636003)(356005)(82740400003)(86362001)(83380400001)(40460700003)(6666004)(40480700001)(2906002)(66899015)(7696005)(426003)(26005)(2616005)(186003)(1076003)(47076005)(36860700001)(336012)(316002)(70586007)(8676002)(478600001)(82310400005)(70206006)(110136005)(4326008)(54906003)(8936002)(41300700001)(5660300002)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 18:46:47.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608a618-430c-4409-7609-08dac282c159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prints for incompatible failures in arm_smmu_attach_dev() might be
still useful for error diagnosis. As VFIO and IOMMUFD would do testing
attach() call, having previous dev_err() isn't ideal either.

Add the prints back using dev_dbg().

Fixes: f4a147735793 ("iommu: Use EINVAL for incompatible device/domain in ->attach_dev")
Suggested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v1->v2:
 * Add "Fixes" line and Reviewed-by from Jason

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..076d3710b1fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2433,14 +2433,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			goto out_unlock;
 		}
 	} else if (smmu_domain->smmu != smmu) {
+		dev_dbg(dev, "cannot attach to SMMU %s (upstream of %s)\n",
+			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		dev_dbg(dev,
+			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
+			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
 		   smmu_domain->stall_enabled != master->stall_enabled) {
+		dev_dbg(dev, "cannot attach to stall-%s domain\n",
+			smmu_domain->stall_enabled ? "enabled" : "disabled");
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.38.1

