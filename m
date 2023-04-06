Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B76D8FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjDFGxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjDFGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:53:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9E11C;
        Wed,  5 Apr 2023 23:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmRyyAde0VeVqIROsr7HMyLtabE+CWzTSaWNf/KNndPmdhs9vBpjgu6fhiENfX1H0WrHBInOCdPFZ+28VsLAfkcysqzI1sPkku9SwE/Iuwv54byHBt03Qnv0eQynGpgn1K5rFJ43GTy09+L85c5dFqa90cYxXaFiCh8hxakKfA8gAHSNCOQK03koQUSc/84n/XJqDsJSAqXBhuZdIeJKRmhX0fGMwddOuiK+FPMUB+11puT0mr8CBmPbiAVst0Ylg3bkF4OBWbM1/gtWf5k6bvSBGSqvfDkU5Q6hhIAsBvDkLcuVn9g6eFpN8mbhNXwHUXFG95419Jd7xebNUMB/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqxe1mY0VPB1zr2Ju23AT2Mr5dYX/Wc8tAnWrDFGQTw=;
 b=FYMNyIzPcYmD60wbuOtqdiR0Y2t1MATOln7i4LX2uFWXqfLU7J1axrQsCvHVargOjS/PaAMHWqlHkFwTuvuotbpJIf8x7yVhqhhE7bKpURV0bOaEpxujIYAUxI3LpszjCQcG+h576mm1EnOsMLAjga67nLsY6dUR1YHa+HF8IHrHlOQrMpCNm49ZJUObuZVJEjyb9ZjPVWwXljMx+YD/4FzkcPDz/MtWkat25mmHmrDMfd0T5ajQZ5BVR9gTj+W/H4yy05XnuUiRk13ADRnLEtHGEs1zgVAYvZA3IR06GZbbZngLSYk/82Olrs3rZOEo+UAxSc50Tk2DNyyQWbr7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqxe1mY0VPB1zr2Ju23AT2Mr5dYX/Wc8tAnWrDFGQTw=;
 b=BWQGhJg8LiBffKOmTpvl0+0aSRGSwCP+uriswRUAhc/bF09fkf2hWdhUTtj4zCs0zHPTWtKwRtn93G5REO+W9D5uvZhio6BZc17frjQltUpMEcyRAigFZZyPFhKtTQpvOWlzHzG4yDBzhR2IbT/kcom7VLOnYmzrkES4Cvp8WQs=
Received: from DM6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:100::45)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:53:44 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::de) by DM6PR03CA0068.outlook.office365.com
 (2603:10b6:5:100::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Thu, 6 Apr 2023 06:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 06:53:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:53:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 23:53:42 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 01:53:38 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@amd.com>, <sbinding@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V7 0/7] spi: Add support for stacked/parallel memories
Date:   Thu, 6 Apr 2023 12:23:29 +0530
Message-ID: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 83987639-49d9-4567-ed36-08db366ba9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfaAMtN5jJ9ExS6KwNNoIA/WKdvFwA2So9fKD3kXnLEw/A6oEBQkJtFAko2tusMnUXaLM9bh94M3veuk+UbrYF8qQLvfWeff7pqQyJGQqLMrvROTJ9D8mmOr6XTaYEsiDh19e5e/rqbxPobL+tQwTlvEGWkMK66kA5LnO+jI3aKjKZDw3GmfJA4VsZGn109D3pczlYblJouQ5idB9NBot84gi88JWPLZY3Ta3Ju1gQZCuKYfn/zJ41YZJxFkOIs1IrlPdAMP3V1C696jhTV8Iea8GPZ8FdGuT2cFFkvQgqJTjxKYO8RVpyFRfw6XnCSBVuvL9twrTxMwXg9WBkNt3rSU5iiiFVqfK2LjKI2UgS6FVndiWw6hRiSRCzWndc0vbu7W+EhnlcmCWhkbiazCjn/K+m5LuMQZUs2B1sYBy9WNhGcgsSffZdaRwGP8bIhisduMtoVhTn103JhrOjFB1FdqBP3fg5ZW8TQRnqScoZitotgro11WRa1W0R4mAAwpfVSUDRWu3Sk5jMKBUxtmKQMZglYZQNeQbf6OZaCwmLG3RgHhBce6QNFhxGYM+oZEUbgprFSkDdYPhIiySY40TBR8M9U6PUuOo8XFH424IVMEyPZkfE+FOEBl/71yEOnBJiVGxDQnl3aNdBOo8Biti1xI0TPwikQWMbGyngxyrwqbeX+s2skIt/jcPNkjieEBxgwc5v2gsFhDBgb2+ttuzNXVePjOxpfIO3b/2+XY86ugt9a2ksAjncd8NXGx6BszvwiWVVhuGFoM6hGKWAWPFTsHkjU8DmrCy1HNtTquwZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(356005)(86362001)(966005)(82740400003)(82310400005)(83380400001)(81166007)(6666004)(36756003)(2906002)(478600001)(7416002)(1076003)(26005)(47076005)(8936002)(316002)(5660300002)(110136005)(54906003)(40480700001)(41300700001)(40460700003)(186003)(426003)(336012)(4326008)(70586007)(70206006)(36860700001)(8676002)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:53:43.9276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83987639-49d9-4567-ed36-08db366ba9ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in the continuation to the discussions which happened on
'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
adding dt-binding support for stacked/parallel memories.

This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI 
driver to add stacked and parallel memories support.

The first nine patches
https://lore.kernel.org/all/20230119185342.2093323-1-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-2-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-3-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-4-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-5-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-6-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-7-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-8-amit.kumar-mahapatra@amd.com/
https://lore.kernel.org/all/20230310173217.3429788-9-amit.kumar-mahapatra@amd.com/
of the previous series got applied to
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
But the rest of the patches in the series did not get applied as failure 
was reported for spi driver with GPIO CS, so send the remaining patches 
in the series after rebasing it on top of for-next branch and fixing the 
issue.

---
BRANCH: for-next

Changes in v7:
- Updated spi_dev_check() to avoid failures for spi driver GPIO CS and
  moved the error message from __spi_add_device() to spi_dev_check().
- Resolved code indentation issue in spi_set_cs().
- In spi_set_cs() call spi_delay_exec( ) once if the controller supports 
  multi cs with both the CS backed by GPIO.
- Updated __spi_validate()to add checks for both the GPIO CS.
- Replaced cs_index_mask bit mask magic number with SPI_CS_CNT_MAX.
- Updated struct spi_controller to represent multi CS capability of the
  spi controller through a flag bit SPI_CONTROLLER_MULTI_CS instead of 
  a boolen structure member "multi_cs_cap".
- Updated 1/7 & 7/7 patch description .

Changes in v6:
- Rebased on top of latest v6.3-rc1 and fixed merge conflicts in
  spi-mpc512x-psc.c, sfdp.c, spansion.c files and removed spi-omap-100k.c.
- Updated spi_dev_check( ) to reject new devices if any one of the
  chipselect is used by another device.

Changes in v5:
- Rebased the patches on top of v6.3-rc1 and fixed the merge conflicts.
- Fixed compilation warnings in spi-sh-msiof.c with shmobile_defconfig

Changes in v4:
- Fixed build error in spi-pl022.c file - reported by Mark.
- Fixed build error in spi-sn-f-ospi.c file.
- Added Reviewed-by: Serge Semin <fancer.lancer@gmail.com> tag.
- Added two more patches to replace spi->chip_select with API calls in
  mpc832x_rdb.c & cs35l41_hda_spi.c files.

Changes in v3:
- Rebased the patches on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
- Added a patch to convert spi_nor_otp_region_len(nor) &
  spi_nor_otp_n_regions(nor) macros into inline functions
- Added Reviewed-by & Acked-by tags

Changes in v2:
- Rebased the patches on top of v6.2-rc1
- Created separate patch to add get & set APIs for spi->chip_select &
  spi->cs_gpiod, and replaced all spi->chip_select and spi->cs_gpiod
  references with the API calls.
- Created separate patch to add get & set APIs for nor->params.
---

Amit Kumar Mahapatra (7):
  spi: Add stacked and parallel memories support in SPI core
  mtd: spi-nor: Convert macros with inline functions
  mtd: spi-nor: Add APIs to set/get nor->params
  mtd: spi-nor: Add stacked memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
  mtd: spi-nor: Add parallel memories support in spi-nor
  spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver

 drivers/mtd/spi-nor/atmel.c      |  17 +-
 drivers/mtd/spi-nor/core.c       | 665 ++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.h       |   8 +
 drivers/mtd/spi-nor/debugfs.c    |   4 +-
 drivers/mtd/spi-nor/gigadevice.c |   4 +-
 drivers/mtd/spi-nor/issi.c       |  11 +-
 drivers/mtd/spi-nor/macronix.c   |   6 +-
 drivers/mtd/spi-nor/micron-st.c  |  39 +-
 drivers/mtd/spi-nor/otp.c        |  48 ++-
 drivers/mtd/spi-nor/sfdp.c       |  29 +-
 drivers/mtd/spi-nor/spansion.c   |  50 ++-
 drivers/mtd/spi-nor/sst.c        |   7 +-
 drivers/mtd/spi-nor/swp.c        |  22 +-
 drivers/mtd/spi-nor/winbond.c    |  10 +-
 drivers/mtd/spi-nor/xilinx.c     |  18 +-
 drivers/spi/spi-zynqmp-gqspi.c   |  58 ++-
 drivers/spi/spi.c                | 226 +++++++----
 include/linux/mtd/spi-nor.h      |  18 +-
 include/linux/spi/spi.h          |  32 +-
 19 files changed, 1002 insertions(+), 270 deletions(-)

-- 
2.17.1

