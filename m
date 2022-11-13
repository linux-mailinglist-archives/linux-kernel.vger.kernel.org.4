Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AC626FCF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiKMNpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiKMNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A206430
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgWhlV9tkLRJq94+pCLmQPCk9VV+SqmSKqQ6pKJI1fKBOmoQNfPeZAH/FRLbSExqU//6hGPxVWpJTTd5gWh0D1YYQ+SD6ozLZFDUGflvkwHjwjkpjyien9zb2BNfB66/HN0vzWc7yIMKzpShLdm2k158XTg7rh6tbi34CNvbjkpdPPz32EcbESEiDE7y6nwrO+AfJiuKiWvwoA4B7H7yhKinB+weN95MBCeCxTPl2KbxD0ZH8LjJSbTwY19yOabTC4sqCQ0DE6kHS1XhCY3E+S4AIxMbnAW+O2VfTZcXn30HhSVNeRXwdpdiaZn3SZJ5DfSeDOrk56PVEowaJ9mW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iouLEQGBjZWfTIEQk0Lgglr7+6bKQXTtXCox51OrOWU=;
 b=jTBsr/UcVPsEQbXNimF1Xyekw0LXx1AedXZ6PZFKA2OGuj0ixY7PUrL6iCYJzQ7QRgG4xdBra3yJkGa+aFFMOqNmEii8novIsn0HxsJf16VSIuZ74oTk4VsnRhCjDLQSId9UWlb8eln3e9QhHQBnDVWo3CO3+9J1lgAIEnVDmjpF0nPs/HaMCk/NhpyYAkx67hwMdU4wRRt24OACpWMnCQKY/Vkzmx2I5+PFeY8HzbCsJfmhJQH1eSJXoCqcIhdLQMUBFEKTro2zji5PfNDaa0JXrv6saXUhFeALEtonr3QtGIZS6F7ll0QZonuIgDecj9OuQPD35m0qCKIIkkXTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iouLEQGBjZWfTIEQk0Lgglr7+6bKQXTtXCox51OrOWU=;
 b=CqLZRk1oCrYWvnFbvop3NCREST4CqNNmJq5MYVvumiKo099qVL703oEH9mGsIzxUgYJnBKQrcS/kDz+/wJu0LNUQVAgtffMntdWSsb90dvAmcvSZgFA64eHEfzKl1hxJCt1mjwQUS8TGe948nHJKjBDLbZVKflWGwFoqtk626FBTc1jk1FX3FMj9kWExDZzFR6v/S5vP3k4bxOsZB3ySzSxJBKqQR/pHWCgomkD+xv7HE5eBv162ZPo+tMvLT7ASgYkQ/IWNBD3+EEb/KoLVivTcZ9HIo43vwwzZkQi+v5cF0SVMqej+xHbOh6Wrtq6EJ5rBia57I8J1FMA3+w9Etw==
Received: from BN0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:e8::29)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 13:45:03 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::2f) by BN0PR04CA0054.outlook.office365.com
 (2603:10b6:408:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:44:51 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:44:50 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:48 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Date:   Sun, 13 Nov 2022 15:44:36 +0200
Message-ID: <20221113134442.152695-2-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e521a9-0aa7-4db3-9a44-08dac57d4443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXOtcNCOjW/93d1UAc7EHI7j7/mL0pMMUmx73JtntMX42K2Flr/jKUIpy1OTn9GU4czbi1Ez0B679uJJdP9K5//kH086m5YrL9EkWgCWtgbzoyi7wsQS5/dnplXHLz1l6CcO7gDHK3UFXO1aOVDLEo1FjlQ+9Nmga95IgJLU0RxHowxK2yJiJZ7AERa1izy6bxozT6BrcVG7KrU55OqQR0OVHmnwGWLk+za+uuDCKp0HxJHmtgoISQAsDakvAONuEu6uhXC4x1sjeTWwRRARcvxnupnpSNZX4oqmoQhYMlzGXDJ8BYgJUwDe/bfbUiVdRYXHPNDtqEnPFyJE+o1LRUCLDc/xJ6LEw0vkhtsuITKxrAu+4LVeB4zpEeZ9eYLQBDWRKQBLe7Duo6K4kKlE4pQufjafvAoKhEzoLW1FpFuYLqFKmO5QB+6uJuW0GRrg9O+kMiLpcfhaKMesE8v7fRBudEX07juf2ZpCPX72GxFuBBYHPe/xCIKGR6IVEbG7MV5N9BW9CC9IX2EIANAT0Vl8uvRu4xjw/8S1wk1ysRY0TBq3W72OfsVC//Gp10bxonNPjWeZbGFiU/K7lf+E5/eAwULmfoQmOjYvJ+XUJAAa23GVkTSPCvpsO5Z3cDWhWgu4/ETk58pXVpXN8t3X23Lqk75nMhEiS+Q03WZN9CQaAa7WlGgtZ76k1oeWoGq1DZuQPLh5NxzTk+hnMX03m3Ra76s5iRYPPDtASL3q4YrL9cf5PSpCx2vF3O+wA/h6gqJxJf5PDSxq7uSLoWieFA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(426003)(8936002)(336012)(41300700001)(82310400005)(83380400001)(1076003)(2616005)(186003)(5660300002)(316002)(26005)(4326008)(36756003)(36860700001)(478600001)(70206006)(7696005)(70586007)(356005)(7636003)(110136005)(86362001)(40480700001)(40460700003)(2906002)(6666004)(107886003)(8676002)(54906003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:03.1180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e521a9-0aa7-4db3-9a44-08dac57d4443
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 90913365def4..ea95081eca0c 100644
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
 
+	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
+		return status;
+
 	switch (cmd) {
 	case VIRTIO_NET_CTRL_VLAN_ADD:
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
-- 
2.38.1

