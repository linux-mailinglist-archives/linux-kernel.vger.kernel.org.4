Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6F732A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjFPIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbjFPIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:55:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16230CD;
        Fri, 16 Jun 2023 01:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIdpJhXYa6pMHTLfxvno8Kal1U7YthNB4GSQpJBD81fNYEJP1/mk19kfsAG0Q6tDgiYFR5SE9pK8/lsMJeW1TrsCf7VWpMnJhcttDXlF8wT1qRypLsRaxchJeaBKzJR6QdXQAU2eH0In0uvWa/ycFTn2AQp7F/FBgXsAz4i/7z4a2xOrOnLKBMayI9nCU/s2vIK5ExwFSJR3ye1hqvJ+TuWYBZI31s++hlJzStgR/WRAt58zXj9Q9rCYUaAu695BZwTE4Qq1C/DANDxeN0ekJnilWbjPlQSzHtz251t7VVgiY6XdjaUYsZHaH5GpRVO3T7bHLSZmNxYcKVJi4c0Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5lq+fX3FPfIhSaBWlezIPBV1SYr6LEpi3usVLCHP/g=;
 b=erpMIOcGBaBTu4+EelTNwlVOfzJlfw+Y5KpUi1QMC7TktIkdh6liILLXRLlk/J7JmeYv5YfdK13lJ5Id22xSJt1QF+M5TwkgLtGLSXarFiH5doDt3Pn5ViP6/+K0q6JJeOjWMm2SVUgUleIhvixj+y4MZZysAUFbMXta1A+UAejhN9gZFmYeKsdcB5rygfnZ8E6CDtA6zb8huA/y1eEr+O6X0tJLnvUgNmz1v2Vlm54b6d6Xzf+4cTSmmu66+SPpPgTkGjpUq275mjsFliHHt4eamKQlbtj+TnaKPfJYrcp7/QsJae6iWpcnuFP3UV9jGqDGMGwiUhtFtQ2sdzNbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5lq+fX3FPfIhSaBWlezIPBV1SYr6LEpi3usVLCHP/g=;
 b=OYBniz0SuYoM64SwV8y/rQ0Mt/cSXB04BvRxmglPrgoepXOuHG9kuFuGJBigQwvqiPQzM9IyMo7IlcrGI5eWkas37V5Tw85GxVteM+DRbPerhk5hhKBAetk6fhvq5h8493cKrGNoo3Ahfn4JPGmyUlZkiehjVwtyk+JbObIuIOg=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 08:55:20 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::89) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Fri, 16 Jun 2023 08:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 08:55:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 03:55:19 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 16 Jun 2023 03:55:15 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: Avoid setting SRWD bit in SR
Date:   Fri, 16 Jun 2023 14:25:11 +0530
Message-ID: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8a5cd6-dab0-4db2-2083-08db6e4769f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDb5NPe85+LQgt/rN/ynoGQQGWXlH4E2VOlXLC6ATK0ed6fV3jjH/Wezn3/udSPhCB0U59zfWIfLnD9N09d8yDepVJmxasrbM06lP0MRls8jNu938p5CQQw9Zgt8/LlNkvoyIWYwVZpjyO+fssPGsOFBflfvTwA+zPErxL2RbisrxitSR/9PAjT0AO5x42pQpG6uqBkDjt2wW91zmv71u5/XnKFaYuD0j+bgGPVr1SOIdlOMTPefEOduHJCgDvxcZ6cUUXskujlr2SctU8P90R/NkwvB1K+WB8ud3sYi1dDKTuTKK3IYTcuuADTkfAUC0qtz6iMnHtvmMJSokHuy2bkOM8YLT3QODAz1ENUijqGKXZc2kzAaR0nnzgIOzHIUqELbu5v5aCUmWPW4UncB4sEdjfACG24vOKI0Hl9CiX087aIdh3hoKePcLFy5EeDznRHRjwix2GfO4yZSpiizJuHmzXG07GkGYOqhXAS9Np4MJ/2Mr0sdAbAh6dy0KT+166VThUsLJoVTh/bKOSkthM7113Tsgg927QnTc5ryJNGXiCQB7wSoggjWSahlxPdiZKkwd87xXxNb+2DnCeEtTew024AwRJ33JUrAq4HO8Gu4AMYmgfKoyGOClyDmXhiZFJhI6vb9t8DtXztT4j8sSKQgatBe7iHoLkmOnR9MP2SHN94eDyCZLmXBVyItYy63ZSxqUTX+7VUDif/zNhlDXEIFc188F2S4L+xq6BTG3x6UsomuH8nAw4fz0s4c3ePXbI6f9pm+ou+NLewcbWIv3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(54906003)(82310400005)(41300700001)(8676002)(86362001)(8936002)(316002)(6666004)(70206006)(70586007)(4326008)(36756003)(40460700003)(478600001)(36860700001)(7416002)(26005)(47076005)(40480700001)(82740400003)(5660300002)(83380400001)(1076003)(426003)(356005)(2906002)(4744005)(186003)(81166007)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 08:55:20.0416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8a5cd6-dab0-4db2-2083-08db6e4769f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the status register write disable (SRWD) bit in the status
register (SR) with WP signal of the flash not connected will configure the
SR permanently as read-only. To avoid this a boolean type DT property
"broken-wp" is introduced. If this property is defined, the spi-nor doesn't
set the SRWD bit in SR while performing flash protection operation.
---
BRANCH: for-next

Changes in v2:
- Modified DT property description to add information about a
  valid use case.
- Added Reviewed-by tag in 1/2.
- Updated comment description in 2/2.    
---
Amit Kumar Mahapatra (2):
  dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting
    SRWD bit in status register
  mtd: spi-nor: Avoid setting SRWD bit in SR if WP signal not connected

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
 drivers/mtd/spi-nor/core.c                        |  3 +++
 drivers/mtd/spi-nor/core.h                        |  1 +
 drivers/mtd/spi-nor/swp.c                         |  9 +++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.17.1

