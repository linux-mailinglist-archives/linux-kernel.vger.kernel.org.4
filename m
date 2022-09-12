Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3A5B5A75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiILMud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiILMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:50:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8F1E3F4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrW/0kPlvrHgEIVhJydDnaLkoRAy5MbGoRrxURgRY62lJSgGChqXHw4i94aPdp5Kodkzku0pnCTF2ByoVDA/Z8ycAloOntRsYudISZE1D9eTKVQv2EsE+TLcTKnD+CyJosPhMJAzMZIpTxRRR93h/GcZb9gdz120QlHR5QqrPRvm4/B4suUIsbhwgW6ICLtW66nubP2IZtYC33vhlIphkd32IEFrdIYo0DblblrdByrNPw2TouNk/9oJjlyUtxuP6OnOorhQ5z+obgPxxGbBF9rVSsPBS0U8y08isIKtZZdy5NlHLyIkdIhkajsX9ZVvXPztKMvMPAcMpFM0spTmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBaqBt3CeDPHqMdwKkjeLpUb1EMzesXO0zqhE3C0KcY=;
 b=aBkHGncUqNpd3R1/eyhOr9q6vuP6bQojoAK11HZSSV/ki+Tw6M7X6Lz/5r1SaGHzErw0JP+Kjc3fszEEJ6q2A4yyZwGHf+0uGdB1Fayw0SkOMqO6wy/Ma+yUxc338MnOyM6+O9FQ6QW8MJp1xfJkb38WP1U1EEon1xND0EQRt8Y4EzyZ1ZjNrbc5v3hYBhTf3R+HAyyovl+AyYmeaLapi2qIzNwe3XEck+lzmYm0CbRWg1HdiHKA7qfAuSiVMDrAIrSpL5516J+BH3Mu15l3u9pOjpQ+HBUXsSaOebVtIUQljUY7NmGPMzIHoeJt7xWwPhnw8+qPZmEJlsqMUQ+UUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBaqBt3CeDPHqMdwKkjeLpUb1EMzesXO0zqhE3C0KcY=;
 b=IxFBiZDvpHq5ZeM3RGHSYkVn8yR8aAfe/CaKKMmK+jENC5vDeup5nNR0TB3jjzTiykRyWmmaNFFAeCY14FgGI4rnTT/p26P441703r4Y7POROO+3Vpy6qKFOO0lWOHJvVTjvG0Lmlb87ikNYimX/1RlxfEgJeKjXcn2P8PL04oo7lCVHS5TyZlxMGVU3/ThT+el8X68U7VVo4DiXzCjXCJEZfeoFgDEKxI2mAtsip6gOYkkQ3muKhnpihggbG+Ymf060WCeJchxFY5K29YK6I79ymY9mRacAU663B8yhupsIKq04CEl4ZLrEawlVEFDkqGuYACgWpMDoFoUYgSwj4A==
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.18; Mon, 12 Sep 2022 12:50:25 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::54) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4 via Frontend
 Transport; Mon, 12 Sep 2022 12:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 12:50:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 12 Sep
 2022 12:50:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 05:50:24 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Mon, 12 Sep
 2022 05:50:22 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <si-wei.liu@oracle.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
Date:   Mon, 12 Sep 2022 15:50:19 +0300
Message-ID: <20220912125019.833708-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 8505b5d5-a2dd-47e5-09e0-08da94bd5d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAkIRxT/1fu+xjgttRU3+A1XM4yic+gvB9YeFiSAjJU4yBp6w1VtJvzBwo7LC2T/M4k/876q//Lz2qeSWS7wFYLA8gw8UJI6Wh4grSt3oRmtArRsnetUw3oAVFlaXzSef5RR9vkJIb4HujBIHWym/9Bv9J6uqFF32Rf++tL04nHRs1WXPd8i7lABne5hjFhx47SeZYpOyoeDQ+t79GVZ+q/JWpXIJ/gdawx9UC2oM5LdWaIym0rnImp1I3JEEQvxd2BCXAyKalDEU7Q+G5OawOKv1Q7poXKlLPDn0amiCKEwvdHQtkw81CLfeM/ju1ENj9FaWXmFr014WwCI3KYKKsqz1zKNj0y8p+Z2ti7iYCgyGv0ZvE92QV9VhpZo2iTsQXgZWYWIW+Rn7L4tDlqyj/tR/dwXm39f5HmvpE69sN81LX2ordDuja/48Ryg936iH5ve69uWnKZcaLwWZGOfpEclQeSVNLzXoUO+JAoueZoaGUNkzZajOQhBaeqgCFs15kinuHN4DbYxT914nR9DxC5x3nZKQN/QGMSRFYUMLPhigMiP0KIer+r9FxDvm0QsorkO64rA6JaPi18zJ0dGi8f6PP7aSqZ8Vj3Ft9uHqR3w3sR+YHQT5NWLnTPvdsjy2dseuKunAy+yn0zJIlhUZ3aa4Cyt710uZwQuLiEuK4dfKih0THNoqqFalSBvClBFwQWQ4kHEAtbcx9t6R1r/CjWxQqGa18uN2vbjo77NQy6Y1SFa2ttV1Mn/Smep52Mv6ib0tuenSfjLzix5743WSHyySomtjkr7EnwkhqvxHvI=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(8676002)(40460700003)(36860700001)(70206006)(4326008)(356005)(70586007)(426003)(2616005)(336012)(1076003)(47076005)(41300700001)(186003)(81166007)(316002)(110136005)(6666004)(82740400003)(26005)(478600001)(7696005)(83380400001)(82310400005)(36756003)(86362001)(8936002)(5660300002)(107886003)(2906002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 12:50:25.5568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8505b5d5-a2dd-47e5-09e0-08da94bd5d07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RQT objects require that a power of two value be configured for both
rqt_max_size and rqt_actual size.

For create_rqt, make sure to round up to the power of two the value of
given by the user who created the vdpa device and given by
ndev->rqt_size. The actual size is also rounded up to the power of two
using the current number of VQs given by ndev->cur_num_vqs.

Same goes with modify_rqt where we need to make sure act size is power
of two based on the new number of QPs.

Without this patch, attempt to create a device with non power of two QPs
would result in error from firmware.

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ed100a35e596..90913365def4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1320,6 +1320,8 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
 
 static int create_rqt(struct mlx5_vdpa_net *ndev)
 {
+	int rqt_table_size = roundup_pow_of_two(ndev->rqt_size);
+	int act_sz = roundup_pow_of_two(ndev->cur_num_vqs / 2);
 	__be32 *list;
 	void *rqtc;
 	int inlen;
@@ -1327,7 +1329,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 	int i, j;
 	int err;
 
-	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + rqt_table_size * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1336,12 +1338,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
 
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
-	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
+	MLX5_SET(rqtc, rqtc, rqt_max_size, rqt_table_size);
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
+	for (i = 0, j = 0; i < act_sz; i++, j += 2)
 		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
 	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
 	kfree(in);
 	if (err)
@@ -1354,6 +1356,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
 
 static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 {
+	int act_sz = roundup_pow_of_two(num / 2);
 	__be32 *list;
 	void *rqtc;
 	int inlen;
@@ -1361,7 +1364,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 	int i, j;
 	int err;
 
-	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
+	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + act_sz * MLX5_ST_SZ_BYTES(rq_num);
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -1372,10 +1375,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
 	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
 
 	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
-	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
+	for (i = 0, j = 0; i < act_sz; i++, j = j + 2)
 		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
 
-	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
+	MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
 	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
 	kfree(in);
 	if (err)
-- 
2.35.1

