Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1CA604646
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiJSND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiJSNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:03:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932151AF36
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loxVR+cO0xcn71aTuiYm0Nr709ZwqZUHoy5tBfoHtfLd8pHd6ldRCXuqbV5DkrbntYplcyYgSKxaQwdFFi7sNQJ3GXDIZwgiiKdU3o1GU2ELQ9qnXcHct0dhbLi3ebrStATTAB3TghF/i99KxW3CTRZzuPyl7tjz+DiQyLJfy0XXg+oCxaA5nxhB0JKOH9drn2ve4YJxjppdsd0U28qr1ZMzQsfjAqNtGdRCQj5pRgdGt4oYNbcbp+b/LHre4Lr7lFDkDZnnd202CzfIdUXVsUofxdBTkmtQTFStoFY80jocdO0nrs6AWa0Oh5lcmTwadEHDsGHKvFXLQFnOAH5auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b1WbkgVUdgVphboZ2mUqLEFFKxWn2NcOrVzWdUAccY=;
 b=h8LAXwOCRJvI4qZcG+44xOUxJaerK9wS5AQl7lVLPWcSrw0eWRWKUK5dZf5c64qrqf1wHnIRZONlqAm1B49MnO7Gt6rHKwTPtakgiqT+F4O+r0nY87axCpEbVKx+PBqTviHyTfwiTiN5bYqh8Pe7gAXyCNacG2nmhdrW2XFdhy4s3uCmogth1WZjfVYUp57YnYhXR9MbB6w3qgsCaqZ+430qGDbQtiD0gKIAA+PVckju+we7PHShMDi3vFEi1o3X8jxQPOhvy9PTReKJJT1JV3dfVh6GcIAHGPQ/c6dgWK5XBcnDyEWnzb0g5g2o3pkPwh207praqZh6QBTO8xmP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b1WbkgVUdgVphboZ2mUqLEFFKxWn2NcOrVzWdUAccY=;
 b=LT+FgCmbn9yMJCpxTaKVFXVY/IwYOyLhTywPhRHjkVRDoBeAprXtuk+/AlEt+EaAyOfLDafN0mL5XSPLBaq0iJ8rsbhon0alf6YJO6mptgp10iejhjL/tgDbyhwA6T4hJDjF/3ScYgF3sHj33l4eBDhXIKZiJT7np27JEj5a90/WnetKfO2KxAE9RDnlsM4zAoDKEaQWloDHKRS6sgKvBconFzy21xsQbIy4hQhKC8+AWeQt2N4AHKQDoHywTwkqxUxyknmG6ekXAxgQnNxIvvosiC6TYA4XVE/Y8OHQI1e4IuqcCt0hgx3Fj5pcK1k63UBtWavo2afvJN4lZItwVw==
Received: from BN9PR03CA0480.namprd03.prod.outlook.com (2603:10b6:408:139::35)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:46:28 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::fb) by BN9PR03CA0480.outlook.office365.com
 (2603:10b6:408:139::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:46:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:46:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 19 Oct 2022 05:46:17 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 19 Oct 2022 05:46:15 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Date:   Wed, 19 Oct 2022 15:46:07 +0300
Message-ID: <20221019124610.208113-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019124610.208113-1-elic@nvidia.com>
References: <20221019124610.208113-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bf2afb-3a0a-4dca-faa7-08dab1cff10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrTF5ze/2pA+scIKX6Dzv5wOoYHolvneAWZFBXiY/N7pTivEr2LpyQN2F6furocF6t3bAsEZv7lRVj1bTD0imnM8KOe4KBtzuBF5qC5BHtxrSi4WoiTAWYHvpI0NV1RFycLq1WVIHRE0FVUxj5/IrJMC6S00JEkb3C9soZuLOE12GUD8EtcQkohbG1yOP+HsEjXtz7w/2I5uWf5wFvkEj7rxTU/KOL0jUbOHW36ikQRiDmX31Mc86wYrmCThVm5E1IvGaqDd4yo3E5oGDDBW0yA4VNziDQP+PCJbeN8sQzcEMtrG0AUJZg5FrlMGyHXiV4fi9WiUgf1vE+664lnP3b363FsdQhUMoTaGY96OrILPwAqJKEno/Uk15MY/9o2I30o35E6x8CegemE1Vy1lBmNxv1SPL+yN/wkaQAKM/25JXAOr63T+GQZOQba6ixflKKLkAxAgB2QjxvswFB3XL1zZ1QrPrTG4OZwy7Ta7bwpE3SSUWROIC+X6v8hT6CBLW3vM2XWYE4hZ6B76u/ccmpINsHSA5LaR5vdkukHhyDls8h1T+COhe7lOHh9/yX1ZDYmglZkcCMQgaqE0V7vvBBQrW/6bYZ3NpMTi8bHwwf6Q0875Y0iFurZ8/KrpyQpKoJqiPKfP8rhpVTmObC5DLG+mEUuI0fkoW/5GkGxJO6SRB6iGmg1aGnlArrSNt5OTRE284hV8q7+yxcgEIc6C6C/rcGlnjth0zcvfTHtfZ2voEp6KRxQPK3nOwsxO3KiNfJY9ZV8mFlAniG6Xd+294w==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(36756003)(426003)(47076005)(2906002)(82310400005)(7636003)(8936002)(356005)(70206006)(70586007)(41300700001)(4326008)(8676002)(7696005)(40460700003)(82740400003)(26005)(54906003)(110136005)(86362001)(107886003)(316002)(6666004)(83380400001)(5660300002)(186003)(1076003)(478600001)(2616005)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:46:28.4690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bf2afb-3a0a-4dca-faa7-08dab1cff10a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the VLAN id to the header values field instead of overwriting the
headers criteria field.

Before this fix, VLAN filtering would not really work and tagged packets
would be forwarded unfiltered to the TIR.

In addition modify the logic so that VLAN filtering is enforced only
when VIRTIO_NET_F_CTRL_VLAN is negotiated. When not negotiated, all
incoming traffic is accepted as long as it is targeting the net device's
MAC address.

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")

Change-Id: Ie93d6756c301774664973adc19718618a7008947
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 90913365def4..1bcd8dfa9b7e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
 	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
-	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
+	if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
+		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
+	}
 	if (tagged) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
-		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
-		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
 	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
@@ -1821,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 	size_t read;
 	u16 id;
 
+	if (!(ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN))
+		return status;
+
 	switch (cmd) {
 	case VIRTIO_NET_CTRL_VLAN_ADD:
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
-- 
2.35.1

