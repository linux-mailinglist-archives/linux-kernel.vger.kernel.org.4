Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D062A6BDDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCQAvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:51:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF4AAD002
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRbP07e92BLf59bd01vryGQK5ADR96QudMtikRhAqk65ctCFm/1e4BR3oEmY4KbtGTjjdZS+W4HmL+/4IAvxBbrpjO+KfDzCvUIOJmZb5p9aan8BZL+YrLg6CCIC5lEol7zc6htJk/UTVt12WTiHk0t+l8Q+F5QkNkKoI7AUn/SIR1VtJs7JEd3llosfdShoN2qgPqU65BL8Gg7XYWG/24t7bSJFqtHtbGN9843J4CmBbu1a6fBTrfTMCz2GUGVeL0eBK+ICwLrREDU8gowER4rx336M+B/ZmpcSfEbmWagNqZiGiL4rQ9pPlb8enh079tPahjh01IKso5x9EjbLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUz15MfUvzSGECnOhhw+y5xhvFXOcZVbj5XBZznfREc=;
 b=C8SUGZgKnxNsbJQhybOG01qlG41xFSY5Ki/DMxTq6RXDA738qWT9mqVERrrdSpLKP1vyRqb60FGxcvmqg8BjLieJD3FhCgW0KcswObsaQoFTCuo6+0XhZ3MXxu7dbbrKNFun1intscUjil2CX1WhojumxGiPLd3GNPPwNVa1hiPjevLRj7th0nMvHWcCYOXHtiutV6nb9GzoRIca2f158WNT8ybJrNZXvSqYxhlt7245V8nk5NnYCmJMTvadg3FObcAj7rZUV/pdeWDNL1ZFEoo5bMC7YGaJQHgrMl7DM/ufxBVN1ft3ZuJzUhwO/m4IiCj4C0CZh9JUsPXkDowcqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=rock-chips.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUz15MfUvzSGECnOhhw+y5xhvFXOcZVbj5XBZznfREc=;
 b=fhH7tCq7PbF3fngEeCSFKSoA7XRiJNd2IJsMJ8/EY8xXuIoMK8yeIuqxCHKC/BzeF+33PUCDrcz1AdxN+1mEoFINc3XfJ1peTlObdEZ0qFHWg+8JJj4LSumwgJg7gTeJ4gC/GnJKywHZTjwMhvH9/dhRVz8eU5ehkASWE/OHtyShsKmU9WBTL4ev92lLF9plEucW4hLKSAg4X2zo25SbiBMSuNA8JxGFO/SSVGYHUuGZcP5NlbduBAUxWjORMu8w/ZCHHrDpsL1mXWjR1LnOmsVlLJ8/CzVaHJjdShGk0lkGCCv3D8zejnfM9JYrQkhYfE5TJdu3E4GZRmP/mrRxQg==
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 00:51:47 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::b1) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30 via Frontend
 Transport; Fri, 17 Mar 2023 00:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.18 via Frontend Transport; Fri, 17 Mar 2023 00:51:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 17:51:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 16 Mar 2023 17:51:39 -0700
Received: from DESKTOP-4MCOVSH.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 16 Mar 2023 17:51:39 -0700
From:   Toby Chen <tobyc@nvidia.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Toby Chen <tobyc@nvidia.com>
Subject: [PATCH] drm/rockchip: dw_hdmi: cleanup drm encoder during unbind
Date:   Thu, 16 Mar 2023 17:51:26 -0700
Message-ID: <20230317005126.496-1-tobyc@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d57ceb9-5627-49fd-c141-08db2681c903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u4pCTy3qpubxEqCdziqsbGMcLB1EwAI6l0H4+1REq+quMPFqZ1fAwTgvvWguR7kMXRPgUUFPvSQLSjZjo34OZDWGBFd39IlQHK/BxSSLixkt0aPkVcr3ZjJdUBpY2UNVEw3wezFzYqkrQlxiMPhtIpcT4zveY51lzlpjDQbl5a0FwgIMxsm5MUYV/1YutPfqw3JpM9iset4UgdBkvh1X5jp9zDCLTastF4ovF4fILPbbb/0m8Nj1PW7IbLFmCw+MAEjfrbLbpSUqq0lvbgDoBLyGOaFFAn242IY22+rsthQv06gjnWj0kIbBSN9RPYKfdwG3uIbtmTdScUL026pAR+DbRMwfslGI7+P62Gr/x3hKDZ2BQVm+nDnn6lx/gNc5DmNSCWe0py57c64rRqcbvkpiwCtsEzbbgYD6aHozc2SoHpAY5we0Zh+7H6LebwMJHcfrYRrso/f9MHHs9T32xt6OeNDLisjknb8FOFdm/7jq9zMLw4JnCiBAI3Cxm6/nLSlCsvfBWiiRetckBI7EC/ZaT4BTvIecqPd/W3K8yDZ0zYR2afv86I3FJ3D/kH3oJUUMbjDVSBdNW/lD5G8YXWIkie8rHXkdMZDVKq0HGBrsvYs9lvfsiaZSzesd8e3hwmweEMIZeVELO7kzDeqg8jlTEoPdMNziP1R86BKwmF1UEARrYpkkYHIPxQ1+fERBHn3vYBwqQjB/zhFrJNAIXIyWDU7sXLeis0r6eLtOeCvdpP+y5NsyVBIjhSKEdKj
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(70586007)(47076005)(8676002)(426003)(70206006)(36756003)(7636003)(82740400003)(82310400005)(36860700001)(40480700001)(86362001)(40460700003)(8936002)(356005)(5660300002)(2906002)(4744005)(478600001)(2616005)(186003)(7696005)(26005)(110136005)(316002)(1076003)(107886003)(336012)(4326008)(54906003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 00:51:46.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d57ceb9-5627-49fd-c141-08db2681c903
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a use-after-free crash during rmmod.

The DRM encoder is embedded inside the larger rockchip_hdmi,
which is allocated with the component. The component memory
gets freed before the main drm device is destroyed. Fix it
by running encoder cleanup before tearing down its container.

Signed-off-by: Toby Chen <tobyc@nvidia.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 2f4b8f64cbad..8aa88e6c9e5a 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -642,6 +642,8 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 	dw_hdmi_unbind(hdmi->hdmi);
 	clk_disable_unprepare(hdmi->ref_clk);
 
+	drm_encoder_cleanup(&hdmi->encoder.encoder);
+
 	regulator_disable(hdmi->avdd_1v8);
 	regulator_disable(hdmi->avdd_0v9);
 }
-- 
2.25.1

