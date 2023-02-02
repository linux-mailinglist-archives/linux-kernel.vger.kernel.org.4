Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E00687E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBBM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:57:46 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEA402F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPALYRuKCED0DXE7UOTZMGR3xR4/B7BDDgurqsT0v7fU1MtYGRTsmPN2Qevsu2E1BAaNxd1glMKcXmCV3vTGLcoNIbLPFwvjsDJJ+9ty0/kMYMj590J1YP1BoX2nl9YocHc+E25yt3gIQ3QeWPDpJzJQWfumVAzuoMgR4ikKTlPYMTVLmZBghg53+X1aq8IR0JiSr0XLAyb1EPf45wYO3K0G8J0xDFkjzFViABBgbCNkfUxViZBBkK/QbOuwyNMRdM5rp118EHV0EWZc++B2d7QK3XdDTwRvzlEMvTISwI2ebEmvhf9SjKWFNaza6r3I5jCMHUNW2rQLJbCpCRETMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3uWtqNfWll3Mwkg9MyDs0MsIgcYgl7aa3dveu3YcQU=;
 b=kOyhRHhUDrGvGSnTQOQBz7BW6klrsm4hliFXTKq+rrjctHakXGjJXs+5fW2JJfyUxQwgyMxQtO9SScYO00qPPCThgFUoyyV4CteBfkwNLG6SXfGTtzGav06NhKIUJzZpwA5Tua+IR7Y989uhR2sp94oGAbqI/I4VQmZZ1Ve6/Rn6ACjqUN7MDKMMtKBBfKkkBt0f9gQ/NzkUAaMYl07m++HJYvxiHKi8WJO1YYSpbvOj4GDREiVpImlZ30afqP6IIT1OsJG1tb3NPahmPxnlDJMHpqndwcb6cn1nF5dn9ZBGFrzczG2DQbJIsnZbGuM9+AjJYe1yi2+e1ygnwa/F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3uWtqNfWll3Mwkg9MyDs0MsIgcYgl7aa3dveu3YcQU=;
 b=swCs/gpvr2m/WcwMaBYzfQHPh9KllO1K6wS0QTaj5kxmiJjTdo0fykqSoaRc/ejh+LTaPobQR9DRjCAULO67sYBaIfJ8BkZ9ey+5qxCpbbhHvnxvfzDa2GPtvyRz8v+WHqu6UfotvMH5FK3aDw4KNxbPkVWTj1YQVYPPVfsYAvZJulTwEQUouGNFK9i810ioQpmpTqSYdu8zF8Gbycw/eTZddRQstzPKx5iUSZ0TY4XuAfiJrpbY7z8TG35xPrTN1Hn6eChSPMSLxr+xCMPq+JADdv7b5G3oo2oFUwqcNRyIcs5JQ3q3ZWmO/UEMoV/T7X7xKdRJVDesQgmz/wSW3w==
Received: from DM6PR02CA0152.namprd02.prod.outlook.com (2603:10b6:5:332::19)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 12:57:37 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::5a) by DM6PR02CA0152.outlook.office365.com
 (2603:10b6:5:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Thu, 2 Feb 2023 12:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 12:57:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 04:57:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 04:57:26 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Thu, 2 Feb
 2023 04:57:25 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <si-wei.liu@oracle.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eli Cohen <elic@nvidia.com>
Subject: [PATCH] vdpa/mlx5: Directly assign memory key
Date:   Thu, 2 Feb 2023 14:57:18 +0200
Message-ID: <20230202125718.1013961-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|BL1PR12MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b51fdea-343a-4bf1-979d-08db051d0f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxewuFu/UxanJ+TWai724X89canSlBXzemu3L8kNtRW760lrik0IhS/+85vCNUJoAo73yo+CECutF3mcS/iG2HnQDWK4S2havcyRnyKwc13wnb4IxuA3jNXiGr8CLU6IQQyLAKWH51j7bGQZO1od04KHkK61pePrfy8aWHRQYRUqAy0NBWGATH7aCSRIa9YbXhnO7CZc+VJ7oRPQERD0GyjvMYAW/g9kLSYjUTcbWj9hmaD1oi/G3IhhtADE9he5hKHleM0sABZVCLhV4rsws5l4A8ojVA/p1P/u5fDJSYeFxAbGSKYp9zosW1hvYEnLD+JG+1wNI31Z0T46rO9Vni9E+JyKnJcJmIkRA/3O3EDFJtb3v90+1nv4xw4JjO9d9nS/iZ/4IeDum49XZmWGSwCjYZzfzMoxfVrTxz4IyDfs+mgV2l3N60u2+h6Syq3th2a+GCQkwaYKQcLH3MBdmj58fGCV6BYBjeJdgJGudQq5sOZ8oTNQ65ppxRHroHKX5T85kexn8qBQDPs0rhHRjTDk49FiSzZsODrYbx76Y+lp/0ZZY/HXTeJ+Nbssg5nVYQdET+6lah8EyOjffMei/OmUqC8101zLOPWFyN+f6AlHoYOow581eWdKwQGC9Q33p9mDUwZRhQW+Z/GbnA9TpjYWGf2NOjdDnM3+gvGBzLh9QFO0BHzaTexLr4vSiBnX5dU5qiSPmmKYTntkZt8fBg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(2906002)(41300700001)(336012)(8676002)(4326008)(86362001)(83380400001)(40480700001)(2616005)(82310400005)(47076005)(426003)(70586007)(7636003)(82740400003)(316002)(36860700001)(356005)(110136005)(70206006)(6666004)(107886003)(36756003)(26005)(7696005)(478600001)(40460700003)(1076003)(186003)(4744005)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:57:36.6839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b51fdea-343a-4bf1-979d-08db051d0f1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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

This fix has is required but had no real impact so far.

Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
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

