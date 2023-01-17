Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9149466D838
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjAQIbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjAQIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:31:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CB1C32C;
        Tue, 17 Jan 2023 00:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3Jl43/ihs/qgO3JB0ibO8HbJQ+HmjSVF1oyQ/9Oj/dJ+/AMcEABcIV7Rh1Vt7ZQtXtNclA/enHofmLvJd2RNc/fD1A4waeeQgyN9hop4z49REHfntidDoUDMeAxWakrr50RrAoEuAkIn1irQEVQQNur8nZrOAg8V78plJgC/WcXTQ/EbgLheZQTFNX8xnZ2BTooWKa4JpV89DG3iS/bItGDaHvMz6bDVrPP/+TUiCc9aSFeloVUXUR0XwfLXG2PZadgbQfJ0Kj3tC/Xf6a6C9SeIDEzRxJ7lA7ThAwiuqnTqLVNslRTC0BeinKnVtT96NCHFWSN/CjflP/ys771aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c2mxoWhofvb5zp0UnbhOk6V22PLIuT0os+sudJ+q58=;
 b=FuoDCV5NROFo6LTr/gOWDN3UJUwVFrafOORaPeeKDXDi7RinGH4e/4iJpsP6XR9Mn0pmCODkYL3sY4p3HnDMj6LTvp6cJnW/RKGbQdALD1BHAjEDZ+CRt7ks6SKAy0HZgzkLutgw2bxWjffWMAY98IGmkxDCi1zSOT5V3w1G0ZhV6wdKw0xTpUjF3p4Ddwhl+OoKTl5VhNl6WEPbnt8H7oqZAR49dMJtSuwNrgSVU1PIftv5xWPNLuQiZQuA5OkbO/DGonGDD6qoQQ4Y3SEvdjunPblurPiN+qN7Hc/mxUv+OllqwBTWJAWDhLY+iczO2iZdqbBX7jnf0Hy6cQamvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c2mxoWhofvb5zp0UnbhOk6V22PLIuT0os+sudJ+q58=;
 b=l5vYzVw+N8r0LagUSRQspU27I0RvT9YCD9FzdUmCAtrnZXXZp4D9lSqqzAcGh2LR5fO6WbwWHrko+Z7uaa/+5PF+JG+wM+P0suQpyTLljH7wSNlECh/L0UxhJlOKg2Nw3DCjEopWpwVZTMt9ZSzIW7iOFmKCengtiuD2H0sq+pd0cPIFfXX+ZVCyk00T4P8HnZ/EBzqnrjCV3aZwCoupzNc08+Ohdcx/o5wYHjCUPJKWzdC9kipcI6Sm8zaai51hw7ZjPB0kYCWWn2/fQnAckx7MH64w9DUTu0D3RxDU8k3wQXeWWPl5xS3AAgXNR+RjOUZBFf001ujQ81KzZQOykQ==
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 08:31:20 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::68) by MW4PR03CA0183.outlook.office365.com
 (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 08:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 08:31:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 00:31:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 00:31:00 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 00:30:56 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <arnd@arndb.de>,
        <skamble@nvidia.com>, <windhl@126.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc/tegra: fuse: Remove nvmem root only access
Date:   Tue, 17 Jan 2023 14:00:55 +0530
Message-ID: <1673944255-8041-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: aee484da-eea0-46a8-4869-08daf8653529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIoqAmmDEs+/i1P4wXXZSKtikk1Bz6vyJIKa81+SNkkXFgBx+xSzOC4DrpFvJ6nhvGL68g2jEMzq5cE5ZxA+SX/IDhXg2MYP3XSaA2F4C3nzlWGUDf5Y5l5NfGb0tX1ySLCooI91UtvCC3nKh1sGWgfXkYXbIaZSlztHQqqY/HO2g2v+sb6GzV536E2bwWX5TK63rGkzyw15vsybZW9ETWcr1xocUBoJF1+kiprW3ZNCrJ5kzGh4PIRnFpjDznCvz0CvHEcq9p3T6DDgP0gbTuY5iP2Dcn10mrP3vyV8dmvIednro7WUzvamXIpneMxP/R8+rNFSnNZOMZHtJSIAMvrk6G+ejURAAuuoekTDJOq/vBhC3oeCwGvNZxyr7jCSkkkLhN3wlVEKMpmmxhUWYDWoycjGajJtC/7vNu/oxkDJ6Ju+p0KnnWZCYa/peQvX8oavKaV5LKB5EthHBKDO5MdNjzfPorNvCGhiXIPQpszhiletXBje/ixO2Nhsxt8o2sA8unwsWxI1EdBCv+h/rLIq8WjUOXTQdz075Kx5hIEvMO4EmqCBYjaD0fVseqwOQh7xM57i5VvQ3FjnovPgbeL6k4TJQwBGOU9IS4x3iWhU1f8UvFRn+/mBsOxuSvZZjbsbqPt0ysY/Y1StZ31wIjAAgTCRGn9qtoR0laTk9KssHtBzsxzIgj+G03lzlCfA5DQblZt6ex7o/86fLzfmSg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(70206006)(70586007)(2616005)(47076005)(426003)(41300700001)(186003)(8676002)(26005)(86362001)(83380400001)(36860700001)(5660300002)(8936002)(110136005)(478600001)(7696005)(336012)(40480700001)(82740400003)(316002)(7636003)(2906002)(356005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 08:31:19.2067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee484da-eea0-46a8-4869-08daf8653529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To read fuse values, various "non-root" userspace applications require
access to nvmem binary interface.

Remove root only access for nvmem userspace binary interface.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f02953f793e9..d7a37f5d4527 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2013-2022, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2013-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/clk.h>
@@ -166,7 +166,7 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	nvmem.nkeepout = fuse->soc->num_keepouts;
 	nvmem.type = NVMEM_TYPE_OTP;
 	nvmem.read_only = true;
-	nvmem.root_only = true;
+	nvmem.root_only = false;
 	nvmem.reg_read = tegra_fuse_read;
 	nvmem.size = fuse->soc->info->size;
 	nvmem.word_size = 4;
-- 
2.34.1

