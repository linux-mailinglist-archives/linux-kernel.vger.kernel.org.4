Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EEA6A1FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBXQky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBXQkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:40:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2215.outbound.protection.outlook.com [52.100.157.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E03D3D931;
        Fri, 24 Feb 2023 08:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/EHHItyQgvvCvzGX6vgNnLe4JcF3yblRaMxxFxJ53Qj+AOCrptBjOO+6tULZ9hNi6WVfQ8A7t+SmbXrrjAkWD2/mDpZEhIS9dFfWUgspFM6NU3sSNpSiJtMEmQImffoi8h6jXl8xICNQs9+dS4eWHU+AHRHfh0OFKCrUVwjM0EhXiSpLQT/ZsCIzhs3JzR6QAGgsUpGj3XoIEz4nHByBZGaLyHzkhgbLmR/qx6iyWDyIQPSCtZWyzBIq99hVzqDBjH9W/jZtn4h4oEJ2ExbNmMbd5qjyei45JkfCGL+CnI6+dhSLEq1j063QsMkiLRYvqu4FPFBvvoskJbM5cMFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUbptQbiIpnguPTM/jNWf5NbGA1jGKlm7wyR6gHc8Mw=;
 b=kMxy56181u32I5I2/6vIWhcGO5seYLQoAuSqod6wLVPqmzRpEXVCRJ0a8uR9JtWSDz3/xbATWT2tcYeAMEtjdHJFFhggTPNqtcLMux+SnMk0y4bwms3Wuk9i4gAEmDeJpUvZyIOknoaDFVyYyIgrQPM/5NmXlOBKeHzgPyI8Yo1GZ4OuMWrZqN6HMWuqSDIdOZCYWjiJ8xmS2aX4IVjQWsWtwoKK1bnLc2NXGdC2UM1fQKeGdyAsh9ZFfomy8KRpdRKhxlngIhctTzs6XcyL3sQdqPy+ZIlThcr0CPyvSqigNMFANkacE8pcbUPot56sau86vjpQqMSzDNo8/QJhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUbptQbiIpnguPTM/jNWf5NbGA1jGKlm7wyR6gHc8Mw=;
 b=cc/jlEHpDagSeWdBoyRLx5yeUQ3eKb5mlgAATY5Qff+9a0nj96Ar/PbbzNrsDv1V2ck+K9OuFO2d7ZQLZprazfo6kOgbCEkHerMlTZuq5yvnhuvUNcagzvRzwAr3cniWZqmTurLqxrBzf9polGDyKvqM1tSX9QZYodXW9hWxg5lPzpr7HO8OlTdk+YqPflPmvisINyFyMpQu5s/V+YA4UOJ9K75RHHVVxQfVnInl695p8oj3zWXc0sr3pPIqWud0kJD6q66sXjmMEBGVsLXtsivMy8E7XervwQ2kdA/DEoPphoDst8KMcWQZFbM0uPPzRWTZZ+wuBOI2W9GrPZu2LA==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Fri, 24 Feb
 2023 16:40:49 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::6e) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 16:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.11 via Frontend Transport; Fri, 24 Feb 2023 16:40:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 08:40:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 24 Feb 2023 08:40:40 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 08:40:38 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH] spi: tegra210-quad: Fix validate combined sequence
Date:   Fri, 24 Feb 2023 22:10:34 +0530
Message-ID: <20230224164034.56933-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: d899ad83-4927-4f0b-c9a1-08db1685e2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/trx/M/j1n9PUOoZUxhZ/3xTylvSlcN+hrMT8vciHyNvN14FVBbf14aYVfleiNie91iaD1JsiAa8cn6TpAFsejGZY+j68aCiyy4vaAPysxz3G5KI2IUMyrs138Pq+qHkIXk/HEdlrNbyzopWvgOIgs9xy1c+wTuPdzjqa6Eix93jZ2/G2guWfBEu6TdwxhR0B29HEDXl8y1N4M3gvgmY7J8qqkIMozAyXS1ne0eZ1AFANo2xgkZHhhH3ufIMVykC55ke6nF8XSZ28eyimAXnantLyhrMhhtZS+wZaIjikq+KU+7OimnPf1sHv/jwJkXPR6xpWvTSUQgyeW622P8EjF4L+ti2zl/7oeCm2UYvOip8Oz8mFZKxidNIQOGsVcKtBFsx8Ys9rZTXNo4EXE7u9RhzERWTCARXvO3Ft1NmXdO7YOfi4ij3qtSJZt/qCpILWSHa9D81BhAH2EXTlEDMf7MDwS+bdzp159A5g5SJP5gUO59kGP4TOGnnBkhQNNSm9TEcJ+i5zRYi3t/N4kjy9xfOwUIoA8CumTGdF1UBOimSPPRzo1h7OaLAq7Zr7dOvsOigtZt+j+CN+ZQ4Cjd5UgnyBiHvg+EAJ2uLdJ4xO8P0/Qaz/X4vkZ/ow7S+dgvGyUZnWrM1LxgP387zYqRzPrP3jsGJPqIuD0Wg65Bui/mmxvRw9X2O7HltCNiPn2cbrPDTQfuK3eqzye6YMqs4DxN51kq4rGMFamF+fxw0Ra9E48hfpckLgsHWCxOipUnOm1AlTsbQgB6+LEfnk73EA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(5400799012)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(316002)(82310400005)(54906003)(83380400001)(426003)(110136005)(47076005)(7696005)(4744005)(4326008)(70206006)(107886003)(478600001)(1076003)(2616005)(26005)(336012)(41300700001)(186003)(2906002)(356005)(86362001)(40480700001)(8936002)(5660300002)(34020700004)(7636003)(8676002)(70586007)(36860700001)(82740400003)(6666004)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:40:49.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d899ad83-4927-4f0b-c9a1-08db1685e2c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for non dma transfers that do not fit in FIFO has issue and skips
combined sequence for Tegra234 & Tegra241 which does not have GPCDMA.

Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2291effc2c44..39dec2dc161b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1314,7 +1314,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	if (xfer->len > 4 || xfer->len < 3)
 		return false;
 	xfer = list_next_entry(xfer, transfer_list);
-	if (!tqspi->soc_data->has_dma || xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
-- 
2.17.1

