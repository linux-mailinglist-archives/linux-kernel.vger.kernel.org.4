Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196762811C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiKNNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbiKNNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DB20F6D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE99RCdtGJBhV0NoJTenDG4A3lKDPESNCIlvSsFk8rFdbUGoOgCF4bZ0H80vtLd2UIqVHsN6QvD58pgD+ziGg2+n1mFKXyNeyxZKLtnWxezKI/7wcbIBK2n4sb3lMTWkNLn4TP9wz/VgbcUme2rzd/ZQj8rxtLEkU2OiPisxfcqIbcr4e+Fn7uxZJb2ry0ZfSaQLW0IoV2wQEI0zHFNs+gV0ojXOe3NsD3BQenlxzDGOC/cuya2uCfHtdvqyi5Rur/UtKAvnp7UzCMnzrgGvMNsWVkwZ7vWWFKKURTdLemkv3g1h6URhF9a8icchjwX4XjJKyiBsG8+XR0av2nwj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuIYSLHvDxPkQHW0/KqpZT4mZEcCGBG+8bXOKR9nzh0=;
 b=VRm/sb+INWuewnqmhbqwBWk4zWVDW782zqz0fmN3PrcToBPpVrf02yCnnFBarsd6oSB8fltJR0f9ErptoxCwbi9t2/GoDwa5DfJrOV8DeXwFb37ebZ6R3nHjjCKiod2Nor/v64Ypqn1L4fOlBFTPciBX2t2416jt1sVREUEvKPUCCLrIQCZJ4wzHjJ7D8fe+J0rH5UDfZiLbuXkYlRrZdaGPTlqc3bN1MDQeDvoKy0Chfq+lFliAW0neVYRIs04dTKOEdAUApEDmCGKBlZtIYUYD1QuPjVXokZzqp8CSDwxxENhwVbHi3Uo6F5nFbsXoj7IXebIvY65aZPPXkBK3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuIYSLHvDxPkQHW0/KqpZT4mZEcCGBG+8bXOKR9nzh0=;
 b=ExgzBv3ABD+VE77npqFhK3USruClSitdOqUj8+vHx9Mt0hwv5JbkK4MtM80tpMvYkYARF9VY3yCfyo+mqOCjN49P+aFDqlpGIYRjPoZX9FwB9zVjrbdS0l1mwTHrlDpq1vbfb4tD58BBcp9yP0mU2R40+QfDP+EcwyQWL/WLTAUFhlwcg1Zpcy0ThfeMfy+0WO09T/4T2BVSGmi+ZzsQYA2e/MxJQP562IkV4qaZ7SXF5ct9Q5z6UO5+E9PN5YD7uLtf2wch9zHP2KwsLX5/fib12CZGqcvCkan3ceuMiWMTzoUE1yMguDTru3qSzUdlZUgMsAF2wcndMd0J+qDxfA==
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 13:18:14 +0000
Received: from DS1PEPF0000E657.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::6d) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E657.mail.protection.outlook.com (10.167.18.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 13:18:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:07 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:05 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 1/8] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Date:   Mon, 14 Nov 2022 15:17:52 +0200
Message-ID: <20221114131759.57883-2-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E657:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: c8948c31-853c-44c9-0e2a-08dac642af9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNv3QKa6+pK59n06fQjn0DAGrS7xz4qpcNmVffeRVGhwaoZajT0tPXg6Zns6VBUYSOfsmbGeF0GcGK+mIXY+J8qlDvG11OPlBNExO4KUrUa0O57rTop2wV2HmUaWbPW60IT1cwIIRYi/Hv4DJKbqBeWLXuUnpMmWqSNJmqHgU3OijkhpOPqHKnaOfCLnppYRX9J0SXKUfQqt4vQLV7IjyTiLi4bxOInmdVfomWoiybH9Jd+Awylc+pm/spLymYG4lSzXIsxkksrZO3AkCIIrkxWR1PKWLt88UsZGuEumoGp2Nk1QxlaDNQJbw9cCCHfVQPKqsKCf7VBUB4/U1iGwfHGfjJSuY73rBcYhJ+B0rZOUsds+fHtQ/3k+W7NUB2QKyjSzO3FwF+bSXMMpD0a7HlQ444tHyiw4dPosz6U8KDzz13E1b797P6SLGABb1xOH6HXNoOj0fdbGxjx5ajAttrWfbviaguQ3oJmwz7HagZ1BiYpPk418m+L2i9ToUhYbwvmuE2XAUn6KBb6/GIFHx1KAFTe18J1SIZD5BHmC/4kR4xWFu+pCKqnHiFW7Apjr2JOk3Jj4ck/ggb5punc2LH8ZKd8P4/5FH3W+tlitgQEcwOmsyZToYqrG7eF1nMyBxpOPRrn0HjAXgIZKs6p5KV20wcw586g8u7uN2Cr8u3lS6s3nu9YNUsW89Ud82GpHuEGk8CgO9SLaQIWAmXIR2rS82Q7OjLZs2PUm1UinGhYQf3wpjbUzpk/HtS5QWqLwrs2P5MAHtrYGsghge5i28g==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(83380400001)(40480700001)(47076005)(426003)(186003)(336012)(6666004)(7696005)(26005)(2616005)(107886003)(1076003)(356005)(7636003)(82740400003)(36860700001)(2906002)(5660300002)(478600001)(110136005)(8676002)(70586007)(70206006)(4326008)(41300700001)(54906003)(316002)(40460700003)(36756003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:14.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8948c31-853c-44c9-0e2a-08dac642af9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E657.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 90913365def4..3fb06dcee943 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
 	eth_broadcast_addr(dmac_c);
 	ether_addr_copy(dmac_v, mac);
-	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
+	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)) {
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
-- 
2.38.1

