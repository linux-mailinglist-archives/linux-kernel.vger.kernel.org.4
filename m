Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8147768BCB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBFMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBFMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:20:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42723DBF4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:20:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcvlfYdI4HYb1xchLzuuMZ43BfTC1ZufVMwe4OF8QhfsRbtgVJF+2aqB7YEfFByxBf2afDivgy2ZRERS6le3ZcMAyP86JF7XEHq6Ueoq7xr7Tk4Mylh6ijH6fnsFfLcrUfbJiYCaznksivTfsHymXFg7zlI7GjhUQOJ5PNFqN7RCZ7I0ZukGnyIpECGDCbdw54mgwHC/26BIZmoO2dEZFwVPf/jvMrT56MmleyeoozfC6pLkJA1DSlPPl2Qt60A6fMNRcL1C+L9wtNbsBZDPoeiTyxsRIWI/ocKEtd3Vq60svTidaS+nvFg4VD0+bRLf3lWX49mevdY4uahQgHdfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO3VNNWM3bQJvY0yQ6/4vFDS411jRWvPlQ3nA847hrM=;
 b=hHPPcjADj5QMbyknmW8dBszZzyPE80z2bKLHy2ZeS/9IEMnmqmeZIrrmRFyd1eI5WBlxXd4aKFLlKpoFWL/oAkwGkZ5Ufl4MYErYUKUgGCgaR1Ja/3SIjWYLfOE+hsn4fFeazlfzE0s4glhSLl2QAzeluVg8Us2Qf5Y+Idm57l+ONSsLtqjqDwQDU6DWZ7tgV/dzqrp60tp0GLOMvp7Xj8Saz/Nw1y5VYPPGKa/ve9+MoxnBAtmet8Bte8ratXjACIo0A2aOB/k1WhMVJv5xwctsn4revM8Ny8MOu6cZYAZubC1wEwrywO2OgodoLrjNd8xz4xSBDFZEDGCm8ATvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO3VNNWM3bQJvY0yQ6/4vFDS411jRWvPlQ3nA847hrM=;
 b=t0hcTL7Mjx9DGBsuKA0aNdEM4s50ezJVeJETjTwLMrxwNShtylz3lxdG1uuHuwafqjxOyzwjd6v7bMDLn0RboEdlkJ+p/3YWRoThiNA2qM70cgeSK4KD64YPR9x0fiZo58Wg8Kvyd6MpouyNQAAXFJjtZUF3b3Q43xGN7tcKRUYohDjWyWDm5NMWfK313K8nKE8vDj1PuWoQg0jyNlyTp9VnI7qZhTGi/wroXzl0mda7ffvI+S4WmAHMRRoGbb5xRa9QDsXrPQJ0XpIQB0GWrp9Sx9PpQ0vrK/QZAojTV6EF/D6t0AEf2bSPgkQuOSniw72nBkxjEwJ68BnLh6cT/w==
Received: from DM6PR07CA0115.namprd07.prod.outlook.com (2603:10b6:5:330::6) by
 IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 12:20:12 +0000
Received: from DS1PEPF0000E656.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::2) by DM6PR07CA0115.outlook.office365.com
 (2603:10b6:5:330::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 12:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E656.mail.protection.outlook.com (10.167.18.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.21 via Frontend Transport; Mon, 6 Feb 2023 12:20:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 04:20:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 04:20:04 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Mon, 6 Feb
 2023 04:20:02 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <si-wei.liu@oracle.com>,
        <eperezma@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: Don't clear mr struct on destroy MR
Date:   Mon, 6 Feb 2023 14:19:56 +0200
Message-ID: <20230206121956.1149356-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E656:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: e7eac2d3-5007-4461-d6ab-08db083c7efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuUhWijXEBkE2u94UE7AiridNdTNQJTL6DPBvXvS2neVbv2TPkfO8bz2obQgLmBS2ng7ewDU0PiKEgr4P5b56qykxJXDonvPGTSPyL80FXfqDbWW6A793wtaxZVqHsZ+tdkrvmO4B3p8HarnkJdcIEaVunMYTNVzHVcmpW/P2nzHtwfiGFA9gWavSmUKbia0i8s0EFEG5OVf2YdQs0LvN3JveySgxWHtRxt1HcA65jj0FXOcGu6GVDmoPajnuSSHDqY4Z8Fqxq8rz0Qy/xHEyTpoUV7jQaRY7L48YJ1eB1sTRhO1HB1HIHfr4bBybW+9J0THh+BBKUuni1dAvtS536NQRIARVcr4KwjRYDZpcfiHxtB0jGOj9V9kb+baqarb6M94vMSH9yqSvr6Jn0hu4kmVbmSJlfuxGL6oKX9UFeqeREuUdcG+RZO93LBuXrElWjV57ltMoy96OKSKotwkvlIujtKp3+5H1zSd70vpxgJDZvlqVHTQFBg5bHw1B9h846mlz8bIns92XptMXJSNKdMo51u51/CSXeGbry+/Qtd+yEOYhuxlB2nhIHhwbjgb2l1esclQamgrufnlKlap9fYbi0dbKezKDnGT5XPwnZrdX2DaDWFoKJV29bGAwCS+lFzhyl39m+eOyAtm1nbCYXX/22xqJiuINF112XnNs5p+NdiW2coT2xXmZ2EMpi58CS96aja6+AIcrwq3C+WcWw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(40460700003)(1076003)(6666004)(40480700001)(107886003)(478600001)(2616005)(8676002)(186003)(26005)(4326008)(70586007)(70206006)(316002)(110136005)(7696005)(36756003)(82740400003)(7636003)(356005)(86362001)(426003)(47076005)(83380400001)(36860700001)(336012)(5660300002)(4744005)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 12:20:12.3184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eac2d3-5007-4461-d6ab-08db083c7efe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E656.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing the mr struct erases the lock owner and causes warnings to be
emitted. It is not required to clear the mr so remove the memset call.

Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 0a1e0b0dc37e..03e543229791 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -503,7 +503,6 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 	else
 		destroy_dma_mr(mvdev, mr);
 
-	memset(mr, 0, sizeof(*mr));
 	mr->initialized = false;
 out:
 	mutex_unlock(&mr->mkey_mtx);
-- 
2.38.1

