Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C486EF654
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbjDZOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjDZOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:24:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECEF188;
        Wed, 26 Apr 2023 07:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbK3z6iFFuVcKF9hz9NyRN3vYdPiuabZPLbx2W77zOeJmdxILjAs+s9Bbx9L6Eq77gTblTUlIicYwgqKWwU0q6PKvrdLu8vtHaOr9qykr/G94OOLzVbJ5Q2SLzwCMMd2aXy3GnF7fFSX991OR7c/Vvk3KqeNlsrLdmQU7aAIc7e3u01JxXaEZG44aS+No+pR6bXUGdrUt75UYHzg4jwtrzGMqWNqza36MY5HuczGH0mfKsgw+imJ502/PGvQOgc/WhMHIYsCPgj11T3cu2dsrvcEa3OdKqjDru/wnl4zd5EjUScGBWl9/0RmucYYDB+3XvbuhKAMFAfCH+6QRz8ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LugBc8R8jQy35B5YaPS7gJjoqxV/e4VPAkfHSORXUQo=;
 b=gvXmR8FZrJtySxfWdhNR8G/Cx8yd0D6TGAjrhwK+5TiSpWCe1EILiiHCoyCwPRSVOIvvSDaJL7PO5jnaTm/1HT16jpVCl4iH1W0cdJNo7LDqWPuj9Ou6leaCvVwQL8FpRz6mPT7NtJCN+vqpstP5z8QfVe/u6NO74kclKQrNlUGvJTl/9lFC8YPvO95cOD7UQAmVX3ouX7bZQgQfhWA0L+8ha7vD3Bj2nPsnzAtQB0YMXiXqnAWFx9eFhc5L9/TPcUxVUX3x7iq4AhgsRVueSvnwHnlygbMBJzCrfJAsfbeMYa0Xf3zJH7OgZpPvnCpya3uew4A6Jyn8rpWHZkdiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LugBc8R8jQy35B5YaPS7gJjoqxV/e4VPAkfHSORXUQo=;
 b=bbEnizWX26IhH+eftvkUQsFVFIVeYQs28bJUqcsVYBj7JPgyAquM5AAfpIKjqZUvNuqsF+z0/frIl4wAvQkHPAf3MTxSRX7XqnJsNPQAaeKO5onbhnzknSceuAOhTfen/VmtD000RRueE5pDCU9LXYgTrweVarr6Q19fdnxJLiP6mKjCCIOg+dFudV6kTQPU5edV8Ko/3D601C0EYCMNezllHiTYdK+QORdxkjjV84TPjz3w9UeXqQDSp9se1fVhS+B7Ec4VCQ7dPRyIqSkqgKjWtQBjfO1XDHtC/+SJGOUuFMdjGyRS8+wpQpXR+/t8MeQcq6Cc2cLK9P0uGFQPyw==
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 14:24:05 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::8e) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 14:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 14:24:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 07:23:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Apr
 2023 07:23:58 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 26 Apr
 2023 07:23:57 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: fix potential race in mlxbf-tmfifo driver
Date:   Wed, 26 Apr 2023 10:23:44 -0400
Message-ID: <b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: a420fcb1-c1be-4e36-4a13-08db4661e43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVD0cRD/2AcBuTW2+6x0jokagcdDVk/UKcgGthM9EKIczH9J3TECRLK7ILzw1Y1LmFaWJIfxMDizvFAoeUsziF5QIXQkPOAHWM8THmHbl6ZsNskbEjW4gWVcP9XJMMEdXNYv9wQvEd7/EJt8hCnK5g5QLU/EenBhpcgHG/eRQqCCEhluBbV6wtnTECXqbkZhkGPIYMgfsnnU0q6HmT3EmcFgN1/GCmFScHqf+5+KFKakSvXVB+6haztR5zSnyF5rZvV9P/S6ZUAQfii0no6faU9H+9Cm4fyZd7k3eYbGvIRpUlUYjN3lt7p/VTtcUW1yZFcesL/w+F7j9okhsu46hbZ32Nj1KSDpIaVmM7yxKs9v2MOxvtTxWLDDbn66jCMtQdnz54y+Q+92V5sBRl7saOBIOodoQVoWDBXwinPysuj2UTkfLwiCGrsony13AicfocqixxvQ2SerszIZc37xspAcY5cXnCVpO82YVFk5l1CfcIO3Q6XT3Kau11txZa9NpqE5ogZYiS6P0Dq3vvlNlOWiaflIqP/LCDxM5fs+mxG45bVGTrlHeK1iUQ8g+oa5FsCliJZR6u026k71F4kryZjfhVhP8m34IZmdXOXoNfx3ytVWttU7SbdEoyVqfRUhl8/BD8GZWSsVJEMVYy0bNoAVGUI0+i1TA+YjtcracmvcGzJhK6vZhYfzqNmrgIJyay/XaIxS17xuxZR9AAQbgG3veQiCYANP1zMOgFqp41M=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7636003)(356005)(82740400003)(40480700001)(36756003)(86362001)(40460700003)(82310400005)(5660300002)(2616005)(26005)(2906002)(186003)(70586007)(4326008)(70206006)(54906003)(6666004)(478600001)(7696005)(316002)(41300700001)(8936002)(8676002)(47076005)(110136005)(36860700001)(426003)(34020700004)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:24:05.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a420fcb1-c1be-4e36-4a13-08db4661e43d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds memory barrier for the 'vq' update in function
mlxbf_tmfifo_virtio_find_vqs() to avoid potential race due to
out-of-order memory write. It also adds barrier for the 'is_ready'
flag to make sure the initializations are visible before this flag
is checked.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 91a077c35b8b..a79318e90a13 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -784,7 +784,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 	fifo = vring->fifo;
 
 	/* Return if vdev is not ready. */
-	if (!fifo->vdev[devid])
+	if (!fifo || !fifo->vdev[devid])
 		return;
 
 	/* Return if another vring is running. */
@@ -980,9 +980,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 
 		vq->num_max = vring->num;
 
+		vq->priv = vring;
+
+		/* Make vq update visible before using it. */
+		virtio_mb(false);
+
 		vqs[i] = vq;
 		vring->vq = vq;
-		vq->priv = vring;
 	}
 
 	return 0;
@@ -1302,6 +1306,9 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
 
+	/* Make all updates visible before setting the 'is_ready' flag. */
+	virtio_mb(false);
+
 	fifo->is_ready = true;
 	return 0;
 
-- 
2.30.1

