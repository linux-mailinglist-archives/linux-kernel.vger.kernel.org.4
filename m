Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA126B21F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCIKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjCIKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:54:54 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDAE8423
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNbmqyVciTqVOBMEHEeEFQS+9mkyUVuBBBl1iNzV1mH8F0R+KvWNQ2o2WP5Oh7Kj1HmvNzJ5K/iwQlk6q3kSHnke7LftZEWseFu6rOR6cwfcyf2PpCq7X/yWwaYHqCYcT5Sa5hwQ5lwsNMrxFK/LDMf3lc/8aNdBQz5Wj6x00DWxrP6IHZOJsYQQGqdBU/SDm8eAiVSNYIaV3RrrGo0AjeP8jHbNh+ltu3jg8DDSQOolkI4Es03PaR37Vqqkhgk34KXEsAdgjR8rKgWh9AzojQXt4F5JFOQaHCo5FPxnQkvmLFq8ZLRC4GE24ofQwSuxIEJ7PlFRRd2o5rcdSQMtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01G6gO08B/uWnt1JfG91ZSIhhTkT4A/+8QJfB7wPVbU=;
 b=m+8XE1dz4FNUptum+4b+8jy3JUoaX0YzZF1i+8a76tUrNv/N4pDXX2TBTKkuGvtFOsUMUzTzJxOxi5uqSOUHzEpSxcLGoemoJOJU/f2lUWq5NdELXxesHXIFW32a1Ds9MSyRrVDvgWL+FzQUtuVSfw8+DbtwzqRkW66YusPtnGrIs1e+xxtK9n7bbsjzUTiV513azQ2zZ5WmF/QTa0o0COKhWDTLaKfP2qa0PQ6MYFsBEpD1PFjciG/mK82P+6fH9y9ao9ThaG9Qyx5gWUW4HaV2HT3EltpseXk4VM9X6KzYcujHZyanmV85P2priZylqZe3DEY7IbRtt6HxpTGhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01G6gO08B/uWnt1JfG91ZSIhhTkT4A/+8QJfB7wPVbU=;
 b=ieuk/JH+pt4efosD3CBwoEmJxSECqymMQ9+MOJiWN/37CSwqITBkBA8aAobN0gsJPK+4avSXIzlVfM0CGFLNZcNzMuY08fHckF/csw8RVxRudJFP9LARJ3OfXEeNLT55EAAB1I3G9PNVCHUto6viMlLylK3ZFcAX8UjqQCIg4usb6m4LoWfKTZBWRhTpAFqzx6MUvpE5XLclcJwnccUhp5T56r+begwKRuX/TulU8GySv/xAv/+XHXVQHy4nB1DKZOh91aJZ5jLP3HwgCrI1suZaQ+KSW0bABSAwUyhZoykDouTEQw9lBqyZMTQL5jxpsQGN5RqBtCRmU0jg6ZAbKA==
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 10:54:45 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::3a) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Thu, 9 Mar 2023 10:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Thu, 9 Mar 2023 10:54:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 02:54:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 02:54:35 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 02:54:34 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>
CC:     <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 03/14] iommufd/device: Setup MSI on kernel-managed domains
Date:   Thu, 9 Mar 2023 02:53:39 -0800
Message-ID: <5149b7e711a46e81aea8515676cf0e45608b3afd.1678348754.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678348754.git.nicolinc@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: f56f7c7c-84df-4e8c-b1f0-08db208cb19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzp/q2s89mmRmMG2JtRD3iM6C5AG4h5iaRtYtHQWIk9LbuyP/2uR0DbYlVJ5chED/tsDAyi3hsj4Cr5k1yjrEAoPn9n/VsoAdNlqzcUwVm8rCP4vvPePMh9DiUZySRbsZW+PYrSwIOtJPceTVEKJD6Awd1bOQtNHeRR6ltp3VQIIf1qE6iNTKMtqn2GrhtmAUKCyJ80rt76ttbfZHZxk4ysJAr+q2lDmJWnGBfUnGWUqmXyAMiAOU+FYPdsEFDGXsV/0YHwVIfYWYHdzpdEDCIKxYpn5AH0MqMazpEetmIog3Svz6pdBLuUZXQ/Lbd/wk6GIU7J7G2WMol0omXSGeH7NhXLXV9FnFByQtUpyFZQEffdMEkeoWFwWAftej+5cFCuY3d4tipztIkyEFHhTDi9HrHQetSIkeVgWGw/ane0FSvzOpNXm2OrF4rjctvbLsgq68QBvcIgYqfSLMLljkLprRg2lwuVewQfVbw89zWs1ZWEzK+sx+yGGt9dEEDf5qO3vBEgRtp1DufSXvfHQQ8akz4hiHmCR0DmFuz0kV1Qm/w4svQm/E78lOGIo70Z/yvNS4RhOqVHDs8HHOXkb5j3UneqCNNzNg+A1b5Rnas4RKMqSiJFrrr43UpeoTD6YI8e3tPq7u6f6emW9P/MpMWYRbgHYSosHhOMBJoJrO3ViSlmnvuR9DhmLAcTrvRhDA57n25NPkj/Hzdvn4VO/jp7GexjUjLQRZoFmcXgOgAuY7TmngpIjeZaZRrU5OS7/
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(7636003)(356005)(82740400003)(70586007)(7416002)(70206006)(36756003)(2906002)(8936002)(5660300002)(4326008)(8676002)(41300700001)(82310400005)(47076005)(186003)(26005)(336012)(40480700001)(2616005)(426003)(40460700003)(83380400001)(316002)(54906003)(478600001)(7696005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:54:44.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56f7c7c-84df-4e8c-b1f0-08db208cb19f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU_RESV_SW_MSI is a kernel-managed domain thing. So, it should be
only setup on a kernel-managed domain only. If the attaching domain is a
user-managed domain, redirect the hwpt to hwpt->parent to do it correctly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f95b558f5e95..a3e7d2889164 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -350,7 +350,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
 	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
 	 * domain after request_irq(). If it is not done interrupts will not
-	 * work on this domain.
+	 * work on this domain. And the msi_cookie should be always set into the
+	 * kernel-managed (parent) domain.
 	 *
 	 * FIXME: This is conceptually broken for iommufd since we want to allow
 	 * userspace to change the domains, eg switch from an identity IOAS to a
@@ -358,6 +359,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	 * matches what the IRQ layer actually expects in a newly created
 	 * domain.
 	 */
+	if (hwpt->parent)
+		hwpt = hwpt->parent;
 	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
 		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
 		if (rc)
-- 
2.39.2

