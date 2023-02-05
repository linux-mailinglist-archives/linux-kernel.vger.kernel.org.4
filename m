Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196C68AEB2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 08:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBEH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 02:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 02:29:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C817CF1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 23:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzYHFPQ2hka4nOxMN/jxotG9oL/IQgdiw0NQOmDeRemDGdWbKkiPM7YR9TKpsDSIbmv/870PufHP/4tcqyU4RbzsCdlciCk/awd7ZRr7MqxLpCs151VUPazwrJUP3rKz3uXXTixHpfO9MIIhhq0EQbakrZ+jXhAaKvYwGo6Fp3zEUt516e4v7BMwZbFHEuduLb84LOUiB9WqkjiQtDTMXTf2RZ27ZHGjL2lboZ1MX1FElRFHTak6bzsIWPHylNvE+KEq3hpAXY6jMah5AcwbBvSaXPGuirGbn0c/nBPsMfeHiCMetbpXSfoTLiZuo8DliiXxkHrpWxCB4xNiXqF1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPUWYPSG6MtK8eSme18NTtRfK2MQEoSRrIpuqqsoSpE=;
 b=b4IiBuY+mpLNjU6WKiKMoMmV4O1HJwWZRt/0LZQsX5tHHUKKYW3RFz6TDZaFLzFoOAGGNKG97Y9/mU8Bfvv8aR2yFAohIbPFwunbW75T3Xw4J+UQ71iOId9jwI7Lx7D4VEdbJoZouNgTby1oRcToH/j7KgRFQoMmqFl3dRuBwrr79xDQmwXwoQtAPvS+2OMkpOO/t8oisj75L4uwQ/c5VG2pNo5pi1YBif9nU5c05pR8vWpxNF9qgSLT+z/iB28n+xr4xPqhH+0hm2y1/PcliIikT8GlYccfzVrCKcOV2wXMGm/3lKTkcXij1Unof6ehUAZPpFBRV/FBrZtG3QuXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPUWYPSG6MtK8eSme18NTtRfK2MQEoSRrIpuqqsoSpE=;
 b=TotgqDjyft3DXByuPnlaWd/tRtDHWpHlkT+nTjswvNkLOT/yWCtNLGQomeHrqHzSi9TZ6qZ9+MwIP49iCB8Kbys/vDnF81sn7iW1D6/kNaR6sNTSXrr4O546GoPoIDJlKtNXifVo6EUu+tLFYJ1bHUSU6uiNW1kKrFpqqF5cZOD2WFLNSVAnAOzM2QWihVF0ipOZYL9sJOIEllmTBvJCA9RC6gYIFlBAQKdybi+37+uFVgpKDHbhcA65399YA8daroaCxAqsfr0G3pE6o7ojNsW0ZhvfcGkvSZY4znuR22MVB3FyJc7E44khCnwjjIH9tiz10E1MB8K1xrsORBSAhg==
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 07:29:27 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::76) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Sun, 5 Feb 2023 07:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Sun, 5 Feb 2023 07:29:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 4 Feb 2023
 23:29:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 4 Feb 2023
 23:29:17 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sat, 4 Feb
 2023 23:29:15 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <si-wei.liu@oracle.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH v2] vdpa/mlx5: Directly assign memory key
Date:   Sun, 5 Feb 2023 09:29:06 +0200
Message-ID: <20230205072906.1108194-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307102a-1790-4721-8bc2-08db074ab6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7wfTSqiQDposzcJ9Xp2gBu3lYgD/ul1SSxleFboObDbOUKLAz1I1Gbwy0LwNkmQI1K8WfjNfkCqfqLWf/NfvTfkN3XkjOUhOqrDhgv5ecfOnPdE57/h7UaHZCuIB83ukkSy08pZ/EcfQ5X1zfTEemUcZJ8R1jl0frlfFSjk589aVAtAETHnQyhftguWs5LRgJwR0HeeU8nZG5XZn/G7cloukFFmzUyg/CqKfYbsrOO3v+/7wJ21T/8tj95rvoJunTClZdzUYg2rRPKNNgYpOzdwi62bBTQDPbQ5EMvqNworx2qmVQo0Ha8mN1Ae7gb55kU5032Vr0E2d6Vz1gzIPULRZrAUEmaMfVgbu2MKU/JjD+wVq7X3X3dsMbWmzrezzVt6XqSxLbnmNbgDtNpsVANBcR98vfetkTL+QgVaApZmTYeI2GBA/DMjlN5r1Wbn1/IgVFgqE0RlSIJUMYmeeySSN3WZnkIzskKEqVkzX6KqN5khz9ep9/wMjRyqOAuhOGkcSs9UuSYQmBrYgQLBICILNvbSLVP5OOJleAjh4e+AihKWLwtAycBFwP8rPXVAHZ2mziJ9KddKVS3wBDOYxirPLHii1KuOPwxkvomkRgU9z9xUFZyPlqT4se4e2Qf62woadoCjqEh9FIPXCCYGYfhFHManGOVjSrHx0fio7Rv/rdscLpUqPgYTOZBJlkw/xsnm+xvAdSqNYaSxGBpRMQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(8936002)(26005)(1076003)(41300700001)(186003)(40480700001)(36756003)(7696005)(47076005)(426003)(336012)(2616005)(110136005)(316002)(70586007)(8676002)(4326008)(86362001)(70206006)(82310400005)(40460700003)(356005)(36860700001)(107886003)(6666004)(2906002)(5660300002)(82740400003)(7636003)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 07:29:27.6531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307102a-1790-4721-8bc2-08db074ab6c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a memory key, the key value should be assigned to the
passed pointer and not or'ed to.

No functional issue was observed due to this bug.

Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v1 -> v2:
Fix bad grammar in change log

 drivers/vdpa/mlx5/core/resources.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 9800f9bec225..45ad41287a31 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -213,7 +213,7 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
 		return err;
 
 	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
-	*mkey |= mlx5_idx_to_mkey(mkey_index);
+	*mkey = mlx5_idx_to_mkey(mkey_index);
 	return 0;
 }
 
-- 
2.38.1

