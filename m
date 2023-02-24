Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB976A1FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBXQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:35:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537F2D17D;
        Fri, 24 Feb 2023 08:35:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE0rK1np9AnLixzHsPql/4YdHhaVdP7+2X6g0Xk6s2yPlH3i4pJ4i48Gp/yBcdOb5qn0Z5wP6XYGW3M+ZY3KE7/8E5xeOSTCIrN6GtLrCdbVhgtHIrnyKan5Zbds9IzzWYSKyCA3RKAiR2H0zF0YGkkj4ztG+gRPuZG9nrPjkKRcA9uYKMp0917YuwGOeOmVB55zuy9CvQkyvrMROUtRDfSBWy0EjVtvgJPS+ccEk+5ctkL9kzL5YrCX0iUbAbqRIM3Dek5ylkMWMANrImPVAABCpZzjCCe3aiGDbcqSVaNtQPYSKHySK4kTa8mLC+soYxm4k1r+PkRyhMCXpFCtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nuIThKex0qiZDLcb4AtTevGybOn7baslpjr03brnXI=;
 b=MRGOIZtyNX58kRE+SAHP0RO9o4gp7Jejcageurzykx8W3cqsjG94vqwZN/wRf0oFClTdF6bWA/QG0ijtGRSk77LeZX0HKUkMPPH7ZZytNe51dkjXVv/UtCSXGCEe69elEhjItzzyrvxCwN7Vq57lN4TysjzseMl4dyBRyQtGKpqm4BFZzW/XvlpJGOSXctV30gnXj2QJyjhod8Eg9BswLUJbcaR/r1tSWlvOwFHZPA9K78vG4BksHE89vLimB3XaPhDUmvUmm7NOtlsTB2ownqaXwdGcEaNaxbSPNMdbZGx7FKXn46U4LcYvjdOEdnrJs5eeSm8Zu0AGJ6IVNHHzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nuIThKex0qiZDLcb4AtTevGybOn7baslpjr03brnXI=;
 b=SqCXOFfG+eV+d0T0n/Lipnvn6QfbFG+vJXmk8oXUYs1yOy/khPNHq3ddq7h9Nv5wPUrl5Dijvm0EH+qvozdz8Ll8/DjPaXSSH1QpARuLYv4Az8ZvfPkaaPjnmpCXfW6HbGFaGpWXb3x9B/52xSiOlIK/8qrXNTwS5m8VbdtABUq+EMPvcyyGDyy2nUGzYtvDKp3R+e02mL6Dxxgw979dvOAELnVZNjp9drUyq6rxP/qfRnTxSTGupMZgEyv/0d4i6IHwqC/Uann0K9djI0M7itzW8eaXlOYxF8VphCqBMLAbwnpVI0/X/OofUmMCaamJaZ0t+bnr5fHzC8uTT5MCPQ==
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:35:43 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::e1) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 16:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.14 via Frontend Transport; Fri, 24 Feb 2023 16:35:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 08:35:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 08:35:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 08:35:24 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Date:   Fri, 24 Feb 2023 22:05:13 +0530
Message-ID: <20230224163513.27290-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce4fbca-166f-4247-0d96-08db16852c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05rnsV6sGKddIOe9/E77SHqAVfMBFu7/zK51XrpzwNlF6A5iLgF20mPZ6SKCsvlYznOI4WUxaRPXL4jamQ5VawTZpaUuMXve6iLF6i0GYQL8rE3vScTOz6cbsmofMMqcQq58MdL0uNRgljIlIjsbRzim8q3yS1HW30Fh5VMTI7wKsRiR0Vd79V+lvyqcTEJCLj8FikturKZv8NimuPybfkaj7RR+CPX2q2K47wysEXK8yl+pG6M8MkUYtx26Naf+YlM13GPP68fouWYkwPQvUdPQPlGb8tfQkN/TQae+gjVRy1QRPeB0ceuOSL+xpVKc3NrhSps9V1T+JS4NKLtSV7kWh0bPA/TCcy3bsi1oauTb/U0/ryASxmdhKKYYNPpOcjMBwa3ETY+OVKYAZ329jSzXcD0Xk8qYptjlWXxZoaF80AlV7Bxyc+PFVikFHX01PtnNPYRfO5al2iSbfdrlNbKzIOySzUIIShH8GmkjKdwTpeTeVX0LpJMw4owkRI7fp1KsbjJlZbNe7fof01bfrLsJT/7AKrzmgMakePKX6xTX2ddxxl7IugdW6Rpifc4/7coRomsfVixoND9lZyqNgbiAZHYwjxn8dF596oi9VPZpkmby2QU1Efrh7O7KxLGc4l+4C+Mjd0PJrs8KVHZPqmUfD9toOtx80UhI3Jly1Rag1raG3xDKSuIQF/zhF8MK3gYvEb7xOpFITC/HVPwgRImcGW1rWgf2ex18NqfZm+Gzj5SSprwTLrvLMvwNMxqi
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(26005)(186003)(5660300002)(4326008)(7636003)(356005)(83380400001)(8936002)(82740400003)(8676002)(41300700001)(70206006)(70586007)(2906002)(36860700001)(40480700001)(7696005)(336012)(1076003)(426003)(478600001)(47076005)(6666004)(107886003)(2616005)(316002)(110136005)(36756003)(82310400005)(86362001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:35:43.2342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce4fbca-166f-4247-0d96-08db16852c5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warn: iterator used outside loop: 'xfer'
xfer variable may contain invalid value in few conditions.
Move transfer complete check within list loop.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link:https://lore.kernel.org/all/202210191211.46FkzKmv-lkp@intel.com/
Fixes: 8777dd9dff40 ("spi: tegra210-quad: Fix combined sequence")

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 95706153f340..2291effc2c44 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1178,12 +1178,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
+		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER) {
+			tegra_qspi_transfer_end(spi);
+			spi_transfer_delay_exec(xfer);
+		}
 		transfer_phase++;
 	}
-	if (!xfer->cs_change) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 	ret = 0;
 
 exit:
-- 
2.17.1

