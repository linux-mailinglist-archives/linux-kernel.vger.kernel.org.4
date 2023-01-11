Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C966629A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKSPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjAKSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:15:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836BFCC;
        Wed, 11 Jan 2023 10:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyDExLZW8hWvvvR2vpD9HyW25dohUEkqNX9bJYlh+NWYw0h4XEN+lJbLbtc4ailQcGpa6c3OVbu5qrp9P7qZyqDbOEU4lDjQU4FBVCJSn9pbKsIKROGAd1Lmh74zW6uPNp2IAeXcJg3H5P2UZo88guj2rLgRg7dpapW+AWathouSoDltrqJ3BEKq18diKfJf4YVimnFvEPYXk29TRIe0RRqgD7RrX7CsDqjFCmC4F+gtczjmHKpdKOmPU7ruwE8x9ALvRlQ/hmAkWVrK7Jk3R6LunVWSZnPBJVQLDYV/04EaNa7onIaHw3hK96GDWHd+81kWQQajpWR/aB4BwhSfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS9YCJFcaEcghGjbfin3UWhYgVrYRwx5bdBRwCJnlDk=;
 b=FoMIpam/dAMiNVGVU6ZLIAQLqGYDIVKgzLm2SggvVrxRpn2UmYmg6kdaQiRZJ9L26dAoGVcKFlZq0+EuHwhG7n3rAnmpUomz2DXlkdStiptf44OWq9siPmkUgdUKCHMo+SZXuyshX415fC55pu8p3i+4S+V01Lr+1JBAI00C4pk3BgVQMIQuFRPNqf6oKfmMUs2qAeUuO9b6bKw7QeqUE2gjsytU1KLU6ddRqDL0X/Ck1OJRsxu+4pNYlKmdsaLloa/vFsdEN70yxdYnKvyrZXskzVojluo0ERWkoL5AGznnoi/OXtojjJ/khsULu5pTzCO+97UOEP3lD0SSsIFXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS9YCJFcaEcghGjbfin3UWhYgVrYRwx5bdBRwCJnlDk=;
 b=FvUR6xco6ikhsIjdpOhjS8VPmOhfzYvEIcbxJpEHLNToXAy1AcbJVEfIZt8/88Sh7c/EwTb3BQA3WM3easU/zZ/f6cFT0mtngzhus4FbOl9U4gt7t6r9dUpBXX5c8syip5sXC5nrny57OssrrkzNzpBegk4dYaeWEAOLRMmrDXr1syq+chOW52gCfcCURZsNwlvQtzNDTZbes85Oy3ApUAKru0Ig7nR2Jv5ksn6U8wNA5m0DFxuAfGNWE5MLLHmdi5FBmiO2/FAgMgMy+hjGRrZcc54yDnE5O+E7S0vNTFUv9+P8s7Mff6QC5FHUQzaKwSbRbIrgyShsMlWh80v8Iw==
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 18:15:27 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::54) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 18:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 18:15:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 10:15:15 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 10:15:14 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 11 Jan
 2023 10:15:13 -0800
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: enable host V4 support for BlueField-3 SoC
Date:   Wed, 11 Jan 2023 13:14:58 -0500
Message-ID: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: ca05a5dc-004e-4b0b-f38a-08daf3ffd0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w30hnXMYdU0nNliKg3ND4Xi7xtWKIjDXGZy6KGMLvdBNaBkUPgzyIc4NN9c9/CbXn99hYhGtZFzbqwv/SEu/qURBs5CV+lB1GL3pt+KFLm8t6/0PN1s7pYzniFJdpcPP6KdROf5Of1xwNLi8O5ThQSAxcrQ5yc6AVZUyro20sU5lV76CEP/uWCN7k0SNIrucW8km7tFgk0ewznCtydEL6h1l6iLHPz1P1UIYwZecqF0uyxWXyHlnUuhRjbtblBD1QbS1D/6ruTVs6qQbr7XEAE47WOBM697oAviDWFmsKIolmWib1Qr+T2o9Sqpqy2DxqQMBCxFdDpkIVPSdJxy+0aIkBYCK+iM18bXWdrhvaFMqyryPdSxcFNDjQrBptBmtfaHyoGVIk4m9uZMrfg3ejFBHYk+JcW7EGyTlQe1lKQfBB0t3Gx/qBel1sN10blaR6MGBVci63DB7/mio/Yv0notna5VgVBagrPyAVQhLi8CdDGKDWJddjaSaUyiV0OzqEmu0CrqM7Cdn2KUYExbhx08hK5jkLCRKyoYp8mJXJxrn8bSWVhTkDJX0Cj6UQgCSQ1JGBE/j5FXiqDS9UXTcHdfbLkRE8E6xpkQOpsEqyaqX97LWpEaPwgQWXTLEuihWj/lE6N/ytZ7bE65L/88PZAAscc4l7CVOTCyeLHIg4y7gj1Mza+Lsb38VsNXS6pnyWbVf4ahgYb1M+e4HjyjoZ0V4cEx8xc39e30XEkuktN0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(110136005)(47076005)(70206006)(426003)(4326008)(36756003)(336012)(54906003)(8676002)(2616005)(70586007)(86362001)(36860700001)(82310400005)(356005)(7636003)(40480700001)(82740400003)(4744005)(8936002)(5660300002)(316002)(2906002)(7696005)(186003)(26005)(6666004)(478600001)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 18:15:27.0313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca05a5dc-004e-4b0b-f38a-08daf3ffd0d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables SDHCI Host V4 support on Bluefield-3 SoC to be
consistent with the default setting in firmware(UEFI).

Reviewed-by: David Woods <davwoods@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a7343d4bc50e..49338670c89f 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -528,6 +528,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
+#ifdef CONFIG_ACPI
+	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
+		sdhci_enable_v4_mode(host);
+#endif
+
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	err = sdhci_setup_host(host);
-- 
2.30.1

