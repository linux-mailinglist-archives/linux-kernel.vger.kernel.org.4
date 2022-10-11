Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1D5FAC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKGUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:20:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CD2739;
        Mon, 10 Oct 2022 23:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxigkVhQ9fYf9W91LJnzvBEUvRQYhyR950ucOMMEnIUUNKNYgjGEaxE/xL/48nCFvsicQ0Lw0XWSiA7xnih90d3hDbzk+xm22use5mXvNpdN0pvwjl/63O9IqN7pIv7bYLfmElmBV2utR3qK5fE/iPhDvFuxEzWOZbUaADJDjpkIXBY8c/a+nQTNfcZPNKuXlFdzUxLnwY1yn/zP6qtsaHa2fwPBD9pCozEYu8/rssKBk7I2cofinxUJK2qOPaG37ZgGxQf8SCXjbhRenYRsNoss1+6e5Mn1HRoy5DPyEj1UK7awtqkRGvqO+WavEw2Q9X4f8jlUMhzmrUkEK+SQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVLHWReibXH1v3nZrgS93beRwxbYUKNpAcbDCKvqe3Y=;
 b=XEtoa/Rmre3hvbho0+No8ShcrLG503Fpjk8IeOCfEXupzB6fURW27Otom7pxRxZtsi13ExM3IRo5MP4zE4sZ0fCyOFURRPf8JfIHoRNL/uZKw2CU8+iOm2jwsvs4CEFKD2ZhzRCNUZDjAKM5dpZQjUvUiVIF8c4G9nb+xMivOPiCR9Sgszz+Fi7zisCiTfHDwdOqAxzlOHyWnA6aa7wU4zFCws5/BSmATxld3VWiy2KDFluqtuIQlDiRg5Qwx3DBSLSA4T0PVT/oY+QBM6eV9dWNPKlpuN5zes/HODOZy1If+5TMIZAVbWpAVaXZknIITpZqEvpNFwSpmBAsswNKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVLHWReibXH1v3nZrgS93beRwxbYUKNpAcbDCKvqe3Y=;
 b=ypLjgzgtZrc7cHtwzyEQ0Dp/F2xBveKPkYj+rWNtiXw8KwTlxUsTLDZIGIPyp1DktSfKrTbQzuHE7yOMYtDyJgxV6xIo+daVG1TiMLGdl31R9zdvSo68ZIjvRJZL6BKV6N9vG3IPpmviox+BZLLLxj5bJ+Tz9bFo8u2YgfLizbk=
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:20:45 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::40) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 06:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:20:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:44 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:42 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Date:   Tue, 11 Oct 2022 11:50:33 +0530
Message-ID: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|SJ0PR12MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: d436c894-ed5b-492c-ff13-08daab50bb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upTY3BMqGTuLadZd8srUAnikMMX4zGLvzCAheo5TZCvzmSlcernvQ03JF7za3Fw4h2Rlk5M5393MK7VEtHA5XuZSzfy8FfI6MKLM7utptGyUx4b3ypAZkI7l4zbXQv08B0l2rwM1vzENyb2aAky5OapF4Tko27TqfM+z9F5u3n+PdHzWzWR8airrRm55cDaAzpLvjTLt5juk4ScjRzQXzdMAhIsk4Wqb6KNw47HhWwSRTEKamz5SW5VkFn14NE9Fi51ALvuP0/a8jN0ozyYkpGYo7GkmOMarlX6zscZ1inIv6b4JkkxG4NpL7vN4evxoDNLhScwctW9yK2w2xMTEqj0Etf9t5XjP0MGnEPfVKGiSKfhbjyG264pxe91u6fVCfxmbBeS8jC/0OmAHmaQoucowZSopGw9v4F2JrNB3iGFjMOzO/n4bJ0sFdAJsbNmaNMIl1AyB86zJWNaN1e0FJpfi2tbVXY6eBa+ClBlAFdtLNyw4LwccCihA1aQdA1g5dQFJofx8GtcTbb5jeEYpvQ4YJ0pEZAnv6Td87KO+fkpFe8fJbw8z1B5YoFsS66+GHXsEYFMPpnrADwcviSGNXA+nUX/XLcfdcXlmO+6A7Yg/esSyyUAUKU5HR06dT4ieselgaHuqRaWTdDzHeG6lwB3U5mouKiGs21h0hhbfOqY2jF2dciMtQuqvfdf+pq7HYSEAS7X9DQwj78JWXegwRsEs1p63Y1vPE6d7XAIpK8vSmSwqvl5PWEsqhhHqO/Syd3fywT6EQUOiy32KSZou7IkoGhvHQ/7h6HZNFrkPwOITLE18/Eeh07S3xUKm2H+q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(186003)(5660300002)(2616005)(83380400001)(2906002)(336012)(426003)(1076003)(8936002)(41300700001)(40460700003)(356005)(81166007)(40480700001)(82740400003)(82310400005)(86362001)(36756003)(47076005)(36860700001)(70206006)(478600001)(6666004)(316002)(54906003)(110136005)(8676002)(26005)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:20:45.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d436c894-ed5b-492c-ff13-08daab50bb75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix kernel-doc warnings in GQSPI driver.
- Avoid setting CPOL, CPHA & baud rate multiple times.
- Add Versal platform support in GQSPI driver.
- Add tap delay support in GQSPI driver.
---
BRANCH: mtd/next

changes in v2:
 - Used of_device_get_match_data( ) API to retrive match->data.
 - Removed oneOf and used only enum.
changes in v3:
 - Arrange compatible string in alphabetical order.
changes in v4:
 - Used subject prefixes matching the subsystem
---
Amit Kumar Mahapatra (5):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
  spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same
    SPI frequency
  spi: dt-bindings: zynqmp-qspi: Add support for Xilinx Versal QSPI
  spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on
    Versal platform

Naga Sureshkumar Relli (1):
  spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI
    Controller

Rajan Vaja (1):
  firmware: xilinx: Add qspi firmware interface

 .../bindings/spi/spi-zynqmp-qspi.yaml         |   4 +-
 drivers/firmware/xilinx/zynqmp.c              |   7 +
 drivers/spi/spi-zynqmp-gqspi.c                | 191 ++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h          |  19 ++
 4 files changed, 184 insertions(+), 37 deletions(-)

-- 
2.17.1

