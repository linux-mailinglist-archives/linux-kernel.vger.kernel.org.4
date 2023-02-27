Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC56A4BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjB0UEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjB0UEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:04:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2205.outbound.protection.outlook.com [52.100.156.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EB279AE;
        Mon, 27 Feb 2023 12:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYaVLeXn3vTxwucR7TkfQfPeCm5nBKZZMPCGgpvBalwKaIVJnocBHbI9EnvIA/MtdfCpOKC1GsXuy+ye+sj5O/Arqo7uHh4Ea+V0kC6bzhTApgrdGS7x8rJ145agMwcSnnjB7hgculb8Gcr6hRkgdoPFmRtRZYF5YTJ2rWQ4oCZ1tbSvFoRGL6GbqTptaMO2NGPF14M4lnGgqpzytBEPZV8xOjGdNCdUb/bQaBilNL1cf3lNt4rLOVLyspj8na4tMNVv8Q262qmjOlXCV3tQqkrH7MJyWbQuNnU6E8c5WFBf9XlQbjnah8mZYXo1rWUiGwE4sLgACTxCv+fEYwJBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=055/tiDd/2RaMUhFhUoTfo8JcQIqkMsEj4PooJ59Ihg=;
 b=YAiINs5iqGD0LyOCYY7MhsAOnhAxYwBsk2DnxoPR+8f31dirB2oetJAgQkByKZozhW3dOKHzo0yGWWjaXf77X5Gu7WX5yPhmtYFyp0mzzWBFtnXornF9QUr08OdWDciNQoIugil0xnErONneD2OQjYd+ARg3vbcjizkqU41nOapeLtAo7yZk/dfuyntLOcOrB25xDU/FCV21sbLknRAlqmShOiZPOr/ryHImjBXgks4gPNMtOcThUmcZM/NLvcKDslYEg1W10ZvX8GUb3rZN+IBs9pWH96jyOc2QOKzkJzhlIzg3cS8L5/n637yYjmzqFkIZ//p72pX/EzVpMfzwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=055/tiDd/2RaMUhFhUoTfo8JcQIqkMsEj4PooJ59Ihg=;
 b=oYEbZCYE+V9kYRRWOCODgh5wpI8DQgyb8pyxiqtexsTqUkUieNRCTPprIoxEtK5PCSJRBRSgS3CmtU0qu2tOU1G4NR2jS51HN0AJJ22HBb0qhSg2BNaagQ6p52rDnNJfdlupXPcmPkCjgHNMURnMKo2SapcD2EaJ2w+wPuIJ+SOKVLcxGc+BubvZHfFrKFcN2Q+HC5/FQg3zkB5xNBnhGQnlSEo1o89h386Wp9ryCm+dKDK+Ke5GwfYxQAR0RSacPooqtZ5FykFnZlV2MMhYzJXBrybtz6UW326JZ9g7FRC1LHQRqnA5YkluTv3PQHNsorfBLnnJOvrTk3nlm9yIoA==
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 20:04:39 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::7) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 20:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.14 via Frontend Transport; Mon, 27 Feb 2023 20:04:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 12:04:36 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Feb 2023 12:04:36 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 12:04:33 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2] spi: tegra210-quad: Fix iterator outside loop
Date:   Tue, 28 Feb 2023 01:34:28 +0530
Message-ID: <20230227200428.45832-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deacde0-2d26-48ff-6bf4-08db18fddb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2nv63fNkbeET/iTzSzgGDAF9zflM6tsogP9TiMYFuwC+fjnlrCNxAqDpMfKpieucFHYU8ZY74uGY6tWPrgy0fmvvtRyn5fAvhRSqgii9jJs8EMfKU9NLEW/p6oTbaASKgaM4/cfn6LwnlLo4OqO34Bj9N2g3+kO5tHTkb4DbBH22iBNOfMY80Qu2Vfagh+Bhd5+cBtk7ca307+YnvUxrM9xSNuS4AvU214kDICx36LFrLTGExW4xY9Goi93oPRWYAXveWn3Ukf5fjI1xYtz91detDbYgxs3j1+djPsOVa7kzR+6l5BNoJgwDhqJiwHAWqX+cXwbcR8OsLvxganhRucwFEZIotpeqHa5ZwHJP/M03pTGG1jk3gxAVobm9IaTfsIrfJyormTGoR0r8RZEwmTkTNGQBUo3QCAFgmrjcDaREAeOVg/cSgdudNZTTJtCQn5ldmu/4Xi9QOmOV315yjsS95p1qizOrubfF/0zPytEVXSqdhS1i0BuvjVqoq1FpTg5nczp2kKueiwCMmKogFUdaSONdWcVdA9CtC1r75YBZOD6xEb1asomzrtXwdcY/J2L/OmmIk9pQ6P2pYNeLEA5v3WrGEKfWCkpagho8nX1Qz0Yzq1iq2Aqdmkf+f2HySy0NHJlYYW+GLvC3o39JMmVB7h66qFSmnNJk7fnt9bAhz7fZCR3PMarIxP4Dlo2KcmPmMLZYR5lm6Oe0M/UxB57w3cjuMNhJqa40GRSwokDi/gwwVpc+MLGR+okMH0kcZy48Jv/2RhjQEC99+YszJXi6XFy/iTrPuHKwW6D1m4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(5400799012)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(186003)(82740400003)(7636003)(2906002)(83380400001)(356005)(41300700001)(8936002)(70586007)(4326008)(336012)(70206006)(36860700001)(34020700004)(8676002)(40480700001)(7696005)(47076005)(426003)(2616005)(1076003)(478600001)(107886003)(6666004)(5660300002)(26005)(54906003)(110136005)(82310400005)(86362001)(36756003)(316002)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 20:04:38.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deacde0-2d26-48ff-6bf4-08db18fddb6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warn: iterator used outside loop: 'xfer'. 'xfer' variable contain
invalid value in few conditions. Complete transfer within DATA phase
in successful case and at the end for failed transfer.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link:https://lore.kernel.org/all/202210191211.46FkzKmv-lkp@intel.com/
Fixes: 8777dd9dff40 ("spi: tegra210-quad: Fix combined sequence")

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
V2:
 - cs_change check moved to DATA_TRANSFER case
 - transfer_end call in error case

 drivers/spi/spi-tegra210-quad.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 9aaca2289c59..0b9bc3b7f53a 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1156,6 +1156,10 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				ret = -EIO;
 				goto exit;
 			}
+			if (!xfer->cs_change) {
+				tegra_qspi_transfer_end(spi);
+				spi_transfer_delay_exec(xfer);
+			}
 			break;
 		default:
 			ret = -EINVAL;
@@ -1164,14 +1168,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len;
 		transfer_phase++;
 	}
-	if (!xfer->cs_change) {
-		tegra_qspi_transfer_end(spi);
-		spi_transfer_delay_exec(xfer);
-	}
 	ret = 0;
 
 exit:
 	msg->status = ret;
+	if (ret < 0) {
+		tegra_qspi_transfer_end(spi);
+		spi_transfer_delay_exec(xfer);
+	}
 
 	return ret;
 }
-- 
2.17.1

