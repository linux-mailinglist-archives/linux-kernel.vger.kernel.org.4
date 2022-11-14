Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0411D62811D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiKNNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiKNNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5C1DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOWTQrvh6nMBCZdu0J4zm91Ejb6vbS89Jlw5JSOpKKwUp4BhE5AejPYuV9zp7LvoQjeXIl3jJ8uXuflzpO98dxgE7b8JCFm10e5G5nNZU6itokrQqyZCd8yH4/zVr5Tuq7DiFhdJhermwM7Yz3RWvPYycbEPRWlWbGj9B/MMRsmpvotgTCzth7H00Z27KqRLXOBO2y5cadFdDwtibeEaMs7+dV/PMnlvJOuA8MUllTD385fryKbDE0YHMt0CUUG/K9sRTPdd35ndrojB/xeQba+E/bU7ul/1sJFtSsYIn38Nsx428kTm+firmc8sdD+n+l4cbz0iYT4EKcKXe6cm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsgrjLBqFXTVeSS1fa67U60MVyrB2XNjlZk4BR3Pzos=;
 b=a8EV2S8nDvGw5cKZaIOn+U5jRvMLHv3XuK93x0JlNHln03pYuFOu4fARLSiwTiSIqFS0JUD5Lq/izAg1QuaWoGPVWoEUHZikhDKXWBtypWQq1r2EfBy6OaYMAwpAEqWiAsoxjWQVUA6lmhFGzrqb0Zv6GmozMj73l//zR1sixNrPcCazZbXMiPL+jR64ZuqgFbJxl36y/aBPeXSy0lolt+ZOmlFJlZRncx7TJgMQca30F1C1OJr1fVcdZE6+UtPChDKEXE85cgCCmV2Td+K65Uh1V/qDgml4Xm7lUQSjmH4j0u88c5OKr6wkdI7TNwpHJAjOAkA5KHpXS6zpLdhiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsgrjLBqFXTVeSS1fa67U60MVyrB2XNjlZk4BR3Pzos=;
 b=i3VCA6wcFhJ2sSO5fwNhHhaqSZsxA4B1Rf4mNw9JU6DybyFd2AE0F70MfcB0nfqXY7YBawASioDobefUeADGrcQYzD/dDK3xyREI81YShHvwRs9zxZPPVmNpqjonPwq09I9r2Jb5sIU+5LtVxjOqJw7oFj4ONzfDIrReGRcdls2CZwJnonWBPbpO+PQHBApvdN4CdcBs9C9op6WDUVFjtTMwkEHNaCR8eAl9sMUGhAR1JY+KF9WktD8PtwQsPPaNDiCOPgA7n8GuWBt5EA2Ob43uJISsE26tg6UwTWhj7RhH/XbEvNbg6KYZ5PBh4y48P5ROSZEEsYUfnRyaBrNl2Q==
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 13:18:21 +0000
Received: from DS1PEPF0000E657.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::6c) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E657.mail.protection.outlook.com (10.167.18.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 13:18:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:12 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:10 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 3/8] vdpa/mlx5: Fix wrong mac address deletion
Date:   Mon, 14 Nov 2022 15:17:54 +0200
Message-ID: <20221114131759.57883-4-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
References: <20221114131759.57883-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E657:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 475ace20-c7c3-4ad1-3642-08dac642b41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsR7TpiJuGKn8g9sVuDpgQYP4NmS63k9QQ58ikCllfoLdoDzjQcmVULeHxk1bbipBsOgL2ftstV7umUbaQcwZAeH4wLHTxpgIPGGrqMOmjbKsMX0VH1Zv/0woYE3VcploZ5ke/HDMkt4UGgz8eX2wUZMpmAy/BFM6eXPrtqUelPfsf3/aMxmVUjRT+t8L6DVRsPIeMzo/OZgUHZ/Y4IHpvhGBmuz79ootIjCXNDDCgeTCEvB73EJGfKPQVwT3zwByPCua98866lp6RpAj816coZYN+7fJLzwvoRz2RBB9CKa/GnMOWHd6alM9fbkAgi6VBR8KLVlAgr545lXgyCkEm0fnZts+XVHMST+vy5P9sCUS78Z8osOaCSj4BDRNzb55kEmsSm0OPf87oPAFFpzRIXChbxHBWgY+kxmQUL3s2TWHKQveDWAAWqK0F7YFe+zJZ9oJ1WRZCQa2zB6SNXYuWOMLQeIIHxy/PUVgIasUeQATYucnBqwpTB46cGz00lgG+IxTcFeyw3+teaSfBE2ycPJDzHBOGIGWBgyiDeoBsJ/biHv9E4/BkmAYgcr9iD5DY3wwOiuLmWwk0Yegcb9h0MJRQh6UezIjRu9h+lXPTZX1f8mMoah03mwkXutXahpNyh4+E5JtTw1gZuIRPb8RVwUbtokaCy4P9RsC4ibPeXaVdz0T+6QBJve53UipvctjLqDbzFL42X8qE9sGnsZvSk1bcQsxxoqnWaeMLqrBgGaGExjhs2K87m60TliGtjnS5sktH56Dku0X4CXwi0JwA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(7636003)(478600001)(40480700001)(82740400003)(36860700001)(83380400001)(86362001)(82310400005)(426003)(47076005)(7696005)(40460700003)(2616005)(2906002)(26005)(4744005)(336012)(6666004)(4326008)(316002)(8936002)(5660300002)(54906003)(1076003)(110136005)(186003)(356005)(107886003)(70206006)(8676002)(41300700001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:21.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475ace20-c7c3-4ad1-3642-08dac642b41b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E657.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the old MAC from the table and not the new one which is not there
yet.

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 01da229d22da..b06260a37680 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1686,7 +1686,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		/* Need recreate the flow table entry, so that the packet could forward back
 		 */
-		mac_vlan_del(ndev, ndev->config.mac, 0, false);
+		mac_vlan_del(ndev, mac_back, 0, false);
 
 		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
 			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
-- 
2.38.1

