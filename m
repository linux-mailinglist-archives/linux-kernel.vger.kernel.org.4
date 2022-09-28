Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EA5EDE42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiI1Nzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1Nzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:55:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5C38A03;
        Wed, 28 Sep 2022 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl5fc9a3xPo5tD+4re2N73KFOoEB4leZbR2MZOuGLKXklV46C0XwCQZnOBnpLGAFZ3ELx31b2VNjPouRC+uIVd4qoXAMgaNc8UEW5OORtRIb48PxoKySF5eoOuYYCuGd4WnafYUWF9wI/TYw9hcWSMVbmb1lGlmCvwdzXEyf3pnzqvGlTO4eXTH/9xv101SjY/U1Fe535gQngdw+rR/A4vB7GeP2ODdjXSllVG6KtyTaxf1b6vjs2JTs7vYXvz99pxbW3cZlN1EFTGaFEvD24lxGRKWviUyRclmZC44v/HEN7H7l/jgPHKjYI1cCRg3jBuRaZNlxPoBQrNfsZpToUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Bh2q4y5uanFBQ6WCYjKnLBxf3VVdUHYsmG5bcIb654=;
 b=JkpdJ18kk50L4dDuda0MXnEdkW9L2qRRm77a96kf1fbK5vnE2n2dpdhxlQo57y+kkS+w2UN53l1lodr4brNd+4/ki09iztOiPD7TFB9B7BaFOOO3Gzqe4gVb/CztyrGLXoAo4AjQZl70gilXgRd41JqLlvsUSYSaUuLDBu4nOuxkMD1BtfzUVP8qAPsSrsjApe7/rGVw2trtDcxw5XvnzQLK65wE9QwFmqGy/qHOoZ0lbDsiIYvM9VOtC+tin5HC+i7pP5/Ybyn3puugLVe/wTbpRVNpn2fhe1XmOFuexsXL3ecG04GJfHonj9I7xob/Gf+jjeRkqni+VaGZnvaBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Bh2q4y5uanFBQ6WCYjKnLBxf3VVdUHYsmG5bcIb654=;
 b=Dl4x/oKMDasRDwbmWWtxmr0u6MmSzUOk1hGNsIT/ny+hiKgFI6VlZZYAwuJd0pbTSFH4bRyWpcKXO5EYPdm5jG6466f3ZkNsc4yalZ8fBIME9UyqS5yreFPoqmQNiAGYDodUBukwWmVuzzcvhFc2BwUdTZ4bYuYmrixlNsUvpk9n1LWLfCWHCa/+kLnv6/uchdVincHBLRw0XZy35Hs/y2bo6EGnQeLy/jsw3Pm/JNpapTXSq+zXHQ3CbAR0bsEnsk72xtvciAkgmJOnZIbT7z66QetOKdu+/AlXWF+sAra8IdhlxOqgxyqrW3klDZR/5EHylBTOyqUlJsvKq56yAQ==
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 13:55:38 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::53) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 13:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 13:55:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 06:55:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 06:55:22 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Wed, 28 Sep 2022 06:55:20 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <waynec@nvidia.com>, <singhanc@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] usb: gadget: tegra-xudc: Add Tegra234 SOC support
Date:   Wed, 28 Sep 2022 21:55:02 +0800
Message-ID: <20220928135502.3458833-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f76d3e-ffe5-480a-4232-08daa1591fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZQabGYN9gfu3P+ub4fmm1IQEfFN03tQKLIYVR8PKaa1j0QgJ3c2l2Eryajmkm9npvzg4BTjYydDJ5LkucYjwRb02OgL+kF1jdWUfspnaN5x59eAw0hnLDvgFhNIqVatpugk+ePinzF4BGpKUBsIqh155R/ZDYeok3FKKGpFjnuCmvIJAWIlXImV68BP89FCc50Jos8S055TcYAn8C8sUCj61dfUUnysmEjU9CMr6m0xRELQe23oBFXJnC8XzG1MW5zx8SM/scpHCkIk6tfeeQCFrO8/cAJZ8oROT3TxqyZuDt468933xnzIVdbrX9yNOjJ6vbbh1vuAzrk74RY/8nNjirZEytU7pIY/Ic7ZvcpSxlIVuITdtkY68POvFrKwY+54NKtDxjMNZX/lxbIVVQbXHwjMOytwR9X/OwpmdeQwsrucTX9r0QTk5c/K3T/kyumtGBEEfLjiqL1rXc/R9lt7ws8I/BIee1FB3tWhiIYBovoJ8eYVZapBza1glxeT07GZl9iAfqVnhUdRa17Xl4459PRa4A0cOVbAYzgN9CcNDfur24vXH4DWGS40oVUQHomsWHK6L9Q022k+Hj/OpCGYBebbeU5YhD3l71fimtyA/j1CwUX4H6ICxjPMjb8hN4hgpxkeWBG+chz0dOwjY5kv7We5Rq2XJyaDRxB2qIUj5rbGimfNsPPoeEMSD4b+9bSLyIaV5d2MLOAXLbTAsCtcBu8TO7wbluVioeWdXKkw/+ZCmO2H1bkGvJ0mnMm9B5M15sSFiikJ3XK8z/7CsA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(186003)(356005)(7636003)(86362001)(316002)(6666004)(82310400005)(83380400001)(40480700001)(478600001)(36860700001)(2616005)(82740400003)(47076005)(1076003)(36756003)(70586007)(26005)(54906003)(7696005)(6636002)(2906002)(70206006)(40460700003)(110136005)(41300700001)(4326008)(5660300002)(336012)(426003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 13:55:38.2349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f76d3e-ffe5-480a-4232-08daa1591fd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

This commit adds XUSB device mode controller support on Tegra234 SoC.
Tegra234 XUDC is very similar to the existing Tegra194 XUDC.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 3c37effdfa64..53277aa5a270 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3656,6 +3656,19 @@ static struct tegra_xudc_soc tegra194_xudc_soc_data = {
 	.has_ipfs = false,
 };
 
+static struct tegra_xudc_soc tegra234_xudc_soc_data = {
+	.clock_names = tegra186_xudc_clock_names,
+	.num_clks = ARRAY_SIZE(tegra186_xudc_clock_names),
+	.num_phys = 4,
+	.u1_enable = true,
+	.u2_enable = true,
+	.lpm_enable = true,
+	.invalid_seq_num = false,
+	.pls_quirk = false,
+	.port_reset_quirk = false,
+	.has_ipfs = false,
+};
+
 static const struct of_device_id tegra_xudc_of_match[] = {
 	{
 		.compatible = "nvidia,tegra210-xudc",
@@ -3669,6 +3682,10 @@ static const struct of_device_id tegra_xudc_of_match[] = {
 		.compatible = "nvidia,tegra194-xudc",
 		.data = &tegra194_xudc_soc_data
 	},
+	{
+		.compatible = "nvidia,tegra234-xudc",
+		.data = &tegra234_xudc_soc_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_xudc_of_match);
-- 
2.25.1

