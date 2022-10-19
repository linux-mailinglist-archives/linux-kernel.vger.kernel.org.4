Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593D604680
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJSNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiJSNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:11:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A9101C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GajI+GJ73fk8m2+hbixkjMcciviltW+Zz9hXLGrEVEuDTqK/v7sIREV4+eezZr241O/+SEbQc9JBHtUuXUnTOSIZ5jvtr3B3pAy/kClXNT23IDUHJ7IDgJB3whWidUFmk8ph6RlI46EH167/m/4PyZ/6ET0Amj45r1GDYG4N4WVVapStC8G3EbrJqyp/k8npllTUmjWtm5CF5Oc7Yl643PKN7KgXXKXz3Q1uS/+W64fg+KeEAfQfF+aU46ZJkZnfXpnxKmzXvxHetlNP7DIAklNAOB/LMaLaxRSy/D1osYhotP/BonUKXzTJIHVVuqt1csqN+ZcLoAf4bfIhqHw9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02KiW4Q8qfcZnsX/w2U4lROfID6YDRMLCnv6M4TGowc=;
 b=C2zzIiXyAF6SF4Ue73u3SS7wb10L5EziNUMI/hYWOyzaYCZDK0TGMtcJHu4WHSNZjy6fF7Ocuu+dJZya8/Yjt4Vq9olH7b9RIp5Y+3zyDVx0loBbVXut/VhGFp/1oD7sOjLXPEFl51zTYDfuZUH3cl7ChV/ycLPJpiLGUjTp/4wlZ7gezlc4KtTyZVmGI2BlIvtEPpZVaH8tQyeJxsYAWqqZZW4cAa5azU0xJmlseBFv5kjAa+wEKuya5kl3j8nND6onaq2viTvr8defoLMxRaaZz1eX4Pr6HS6HZHTuPYADHPk55YrpMnHDYxv7P1Y9f4VBPHSpXh2/VR6sEuN+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02KiW4Q8qfcZnsX/w2U4lROfID6YDRMLCnv6M4TGowc=;
 b=fjaK1AvT2pmChVHIsIS77rKS6wvhniQmtY5Adj27GegYXSsfWYsDV4cbBznfxGBfmMwpBrsmKNO8pUa37XB+XVFdKdeB2muIDBWAszWbxEbjePoOkZW/ZXquW0uYxhAe2+XGikWiRVikWpitclULC/7A8lso+dQUQMieDYneqV6lpJLBa2jGiDYBO42Y+ZXOBPfnysvzbVmKHuYldAJg6Uykgy3JepIVfZ9q5P79X+VOS+lD9FCW6LjwT/7WwaHYF5ukJDpq9SwRKj/tWDFZM9utYSXtqJsvSeV31Hawk6Y2rg8kA/rl0DNNLmT1Vn+nQEpljjoIPZioDhGiGi36dg==
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 12:55:19 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::c) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:55:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:55:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 05:55:09 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 19 Oct
 2022 05:55:07 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 resend 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Date:   Wed, 19 Oct 2022 15:54:57 +0300
Message-ID: <20221019125500.208841-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019125500.208841-1-elic@nvidia.com>
References: <20221019125500.208841-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: c35ebed8-6de0-4cf1-c7f5-08dab1d12daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuVwqznueACZSI9cW+dYmuJ0uUzxAURefCaSLEftRAKeQY+GLhCEeNn6dfRqCuU/VbWE7zJwUgh213zO4Yr99jR82VmBWPcckNS3FStR8YO3MsjlK58AQqoMcixO0qXnUQpBl7GUYnbx4LerD5FZ6W9SAKgPU6jMPkDHOKhgfaHFgzpKYhyK0yrhJs5V0UgK03riw+oG692fITFm6tfLijmmg5r9Iv0T1L9Ia1EkoztU99xN7LQ4Llla6RKnWuw1El86fZnZSBYmusXPH1sIni8iMrYwqgs1/ysmmyMW3z8onT46DeSwAV2c/NGgFgiS6UjhOPseYF0RJVAWcLuzmxpQI4nmy8Sdfuq5Kd++yOKYwEJjK8TFYBli3hXEchN7pjBwDCyNo7ZCMgTpNieR3Na1VCKQlk59TX81aorfoSkBnjdKwGkkPfP8xOjdhwUug129V8VE7RZDHoO2C3AETOL243GqFPZMm7CaM71oSDi0Y6En1N8WsHZeliCH53S0GvBayUdh0fBPQ/OlHw/ShaMNv3/0l1hHmz58gCetrKFpQDSSlvCKlNgIWhsWoIXtXkSS2R0IKp7EQ6j6+jbqbnqS0TL8ZtWfEsiVv5tZXy+hObZmqlvVtKM5Xuzik6EJmqOQl8HCfDw7yA0+m2pv5xSJbXfH0abg3qK/b+ooDAirgjw8WXiD/pHg0u4XyUT7PHSPrlgN4re9TaLgm0Y5P8K4QvnCRA1J2/qkkYrOMtxSHYTSMjaIN1k3NIjf0h1gmyZRfBjO/dGZTgKLIpQHbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(316002)(4326008)(110136005)(186003)(7696005)(2616005)(40460700003)(36756003)(54906003)(26005)(8936002)(2906002)(86362001)(41300700001)(83380400001)(47076005)(6666004)(336012)(107886003)(70206006)(70586007)(426003)(40480700001)(8676002)(1076003)(5660300002)(82310400005)(82740400003)(36860700001)(7636003)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:55:19.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35ebed8-6de0-4cf1-c7f5-08dab1d12daa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
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

