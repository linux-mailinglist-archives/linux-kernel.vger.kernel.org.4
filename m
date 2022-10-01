Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A646D5F1C1F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJAMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJAMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:22:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2F7F11D;
        Sat,  1 Oct 2022 05:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8CPf666fiEgkX3dF86gXd256pjrANRNAKbqwt7I7wYwvftNiGRvq8WHt20DsvVRrZDwA5ICMuyEAVdRe/Smsj/D5HUP9ZFJ+358tEr+FaKOnY/F06CiYv9EqU7JMIW3TsfJwC9pXPkbwNKjNFARk0EsBYcM4OguL1FcyTMMi+tNTNtL0hzH1GHsFDBgicwG/WrV6cdG7vS11HWFgBah/7OTrJMCN80DOlfFrkHZRKjbotePIsNuR/j9uXRMHOfecLqKe4Tthw4hasiVD/A2Lfzmj9sOjo9fujprqRnecYyJiXjxcPg8naypV6VLC9RF4g/GiS7tTAGMMXhbjImUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MSrCnvW8DGSz9k95zlCz+heJ3IDWKGDv2taoNVvEdQ=;
 b=Rej71zXnagQj1Y4WLhZbUC4//0Fjxgmh3LbG5q4FiP9HSKhAOLcIOU5iFhRqd420+/ZP69QUp3I3s3RX/j+l+ksJC3JbmDVUUPZiVUR/4meCNOXLPwZ5sz2h+RDewnQ1hf4LmbXjjJ5W2CgIvHHOgzrcA7zc5qRu4nOsRwhHjv3ztktXom59JSNzij/4G9zWjadwjJ1vnirK+JU17pqA9bST1JsCPcG5ECknoAZYdGhB9AoA711c5ZFsbCH6hjoDLtyi0A5btVy6HDeO2zxQKS50Uee1MRc94Xiler+N6hwq3cyGN6aYiRYKZvmad0dAgG9eKwLxCqmPKanc2cInfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MSrCnvW8DGSz9k95zlCz+heJ3IDWKGDv2taoNVvEdQ=;
 b=rrYnojhbHt6P4Inwjtb6dmR127uPcIWrL2rOtPAgOSP3vjhJPnuYl5XuYrzjYrX3cRrqWqwgML0JSMwHamGkC5jCECw2EYdml0ohFxjZo8T99RPwcCOgGKKFR8CltMdhjc5t5HWpVjpevOp1dtoP6HZPWcD9B2fcQj1zNemCAjMkIpWkZwlUx/ETF8Fe4YwPV7zCNErBcPx3IpP5ILJ1LZWSWZFJtYg2cr79glOhQv8JSjQZEzsB9aI/CWIyJu9wHSYLAJ/Rxwb/90dU+A32fmzNOgG9e6QdXAVDAYO8rgmuF1DTjF6+lwQscp2ll4iaq55JZtRiTarDs7Xx46hAFA==
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Sat, 1 Oct
 2022 12:22:02 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::cb) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0 via Frontend
 Transport; Sat, 1 Oct 2022 12:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 12:22:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 1 Oct 2022
 05:22:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 1 Oct 2022
 05:22:00 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 1 Oct 2022 05:21:57 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 2/5] spi: tegra210-quad: Fix duplicate resource error
Date:   Sat, 1 Oct 2022 17:51:45 +0530
Message-ID: <20221001122148.9158-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221001122148.9158-1-kyarlagadda@nvidia.com>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 638e9e17-2c96-4b89-3924-08daa3a78b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gtCKIwlXOuDh73MTsLwaqOmu0yruaq0/1XtfwLpIiN1BczsopxpoqTtEOjndm7F63k3/5sZra9Y3aj0fekpxlwq5KZ4pqYq69j76rStcvNMi7LXSsUIB228YWZCNlJHEck8q2yi4yDqLgvEqVYFngmv0zwarDZO3KMhCloGjhYa8IPEQRcU0tRg7y9JvA/f42JyZ41UIRr41uH7j2DAps+99zyriTwoofvGV7zGKNWjUXdcY6CO0StK5H6nHG0k2/0aI0GxSMUkfVaW8eeKCt56FIxQ2lINxA4o2jpMa1VwbIoHoM3O5gILvxuHRMQs73C75X+zCjvAEGMhMBL32ARuMQrJyzgGjjQt2O/IHvn4SRjbl0DZ2KdTEaVA9L3tAxfvBeB0XRW79edda97SJ2UQ3V7fNsEg3XqCKiK2hJKEBT4mMpJ6HKopTGnnE/UsFW4NcHAfc/iBIr0NJcequaJxC6Ef4hBO9udfHSpnm8DSliI6IuC2QA/QZB5X4OsBDj++QwgcwUlX6mqZ6HPJy5o+zFUury8C+LjrJ9vPB/rriyuB5mqnesh7E9dbex1/5gngG6eY7A9gM3bZoALM16CFzU9/p/dobGQf+xAjx3CTWTuDDEliE1qiIt+qjPNCrFaB2GbwxZ6aQeRf1yF6DmX8ZqzKIlT8MS7pMmgPJzcI33So5V7y+MQXxqSmltNOociqi6rEMQNudVanmhWhSxIeX8s5XgXi4B7QfZsJ6wQGFuCIMXTvl065Uy2C1IFDlecothnqowAf52K8aDCfoA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(70206006)(70586007)(4744005)(4326008)(36756003)(8676002)(5660300002)(8936002)(7696005)(110136005)(316002)(86362001)(478600001)(54906003)(82310400005)(6666004)(47076005)(356005)(336012)(426003)(2616005)(1076003)(186003)(82740400003)(107886003)(40480700001)(41300700001)(83380400001)(36860700001)(26005)(40460700003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:22:02.2546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638e9e17-2c96-4b89-3924-08daa3a78b9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

controller data alloc is done with client device data causing duplicate
resource error. Allocate memory using controller device when using devm

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 904972606bd4..06bf19d0cfc1 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -918,8 +918,9 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_qspi_client_data *cdata;
+	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
 
-	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
+	cdata = devm_kzalloc(tqspi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
 		return NULL;
 
-- 
2.17.1

