Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9DE6FECD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjEKHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEKHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:31:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1F26A5;
        Thu, 11 May 2023 00:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFKnR0ffBywxe+uhTOUOxqNL47/f2/BFmYzK9nr12p2WR5ue/sEKIJs2ZKhC7HkwixHJJFWHGSDVcpcnAKYxKF5JXWIvyhBZDQAc2YSrV+pAc57o6Gq+6MCz4YnbqznmCDeVI0QOGtrkce5DMhZOE6M/tUcelSoK86Z29hJzfqug+Gd3m36IPdcdPYMX4XIm0nYcgxZqiICe0PzkzQvJ16JtcR0E6yFxn14p4ribdvX6YkPbIYpDbc5mvtRLFvx0r0Eqs1GwvVMnN1jjgsEeBvNis7tqNbq3xYSdDGqC0ONTJxeEPCidjanxMv6u8qVYZ7rt3jFEm9x+VpB2JLKP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHoOlSgK/As9ZUzdyYrrxA/TP6EbbBw5yk+wH8BLd2A=;
 b=MBJUV57FXZksmuljgaYCpKrcHe9xDmoquiSES1A+kQM0jgHj/XFFb76ZyM+ANc2GhOFxAUeCWPv1zF3Zqx1bUrdrtqy9zS7adqhFdrfkTcV4uCQPtiBFVY2kvTB4sDMbw7N13DoGyhrYhVXhPlliqZKiEeE1DgAE8B32rhaYY4uICLVCwXjqTe/wosvN8F92lkOxkVpKo07l6oEoHfvX7TOZMe/p3xWoSXfP8jLMra78cYEGz+HBCNwE8jb49JXq+VDjSHBXAmgrcI0u1PrGjeYDYVgP28Iviyn1bfC0hOc2UkUBIMkv5Vr07YId/azdzpbtC4IrR6DMd+Un0C9Msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHoOlSgK/As9ZUzdyYrrxA/TP6EbbBw5yk+wH8BLd2A=;
 b=DBmx3tICba7QTH7tf1lhKJfoKLFeo5ETky9jtpgfbAG8LqhMJwNqxMKJxvCviKJ6iVR8PstaVYRtNIx1/1hyMJg5IbS+MXnY/WdaR+/zCU67zzdRX/aeDbNqr9hblUziDsTqQ0VIHcoVNN3gIrdsuaryFt36FvZHmsdjNyHocJM=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 07:31:42 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::a9) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 07:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 07:31:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:31:41 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 11 May 2023 02:31:36 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>
CC:     <sbinding@opensource.cirrus.com>, <git@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V8 0/7] spi: Add support for stacked/parallel memories
Date:   Thu, 11 May 2023 13:01:27 +0530
Message-ID: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3af0f1-981f-4400-0a43-08db51f1c463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7LT+rz3DEqOwPQMncQ0jjZwpfdQil++X5aoJNhWmQ/RuPQBEanDeSKy3TQNDJEUQYpM/XDi0ljLteQdUPI8rExtYh8o4ylLPzr1m83c3f7JBNiktNgyH9ptAXCfmYZphI/6RPyLlLw1w/Uea48ivjtC0kvbNf81Uh/T6P9DsZKX4XUCKCbwk8s7S2h2LV++hmMyi3szJ6tzCQ0AI8vYb0rS8PNDgYPZ6dva3nYbQqWC5wK0tv/NR6kZVCaBCVcEoiyHyYzOqOq3JzjeRVWWkiJwz9QA2/QxqbedIZ4ZkpBTC44JCu/3PD6+sezPIl6WdDn6hOgJHmtfPY0Ef39gPP5StlNvWAVcrfAR5yQ9gnWSw+Pg0z21npXSQT1NEti4b06KrzKnyw2FhIcIzhQBYh8fyhNVavYMQbfbLFhwIU/CRyrUvaHOSeYnVHshS2zuIaWPYvSYyUO5RE3wFjQ23wzrrb9yXeb4/NZpRMEelrPGzC8CkQWJfpwawwTz0leEeRK7wazPGgA9hKFbMhcJDxEJT3ktOjGAIGcf8TVanEwZOlXXF6EAFbdh+v0m1U9A0TsuD/63fBuPPlu68Ld/9cnelxuNa0AqtKD20wZc64xSvtq2mU0/HS9QHCjzfSUozTrRH4bUpW7zwQlJboeWLxTxiTzWTmSwcHoVtnIw5ofmmjl5dN6x4ZrJK0XtQxuNsf3DQ1NjHKFiylI+EIMl0DMpQujZxXfivQwDr1bZ/a/8KolYQ8Ad49M/XHRglw0ubXsMTDyEjcypp32EPfUW9SHiERgF09+Ec8ASz3qF23g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(81166007)(2616005)(36860700001)(336012)(47076005)(83380400001)(426003)(966005)(70586007)(1076003)(70206006)(26005)(478600001)(36756003)(110136005)(40480700001)(54906003)(6666004)(186003)(86362001)(2906002)(7416002)(5660300002)(40460700003)(4326008)(82740400003)(356005)(316002)(41300700001)(8676002)(8936002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:31:42.5287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3af0f1-981f-4400-0a43-08db51f1c463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

CS GPIO is not tested on our hardware, but it has been tested by @Stefan
https://lore.kernel.org/all/3f148a0c-8885-0425-28f4-2a53937a388f@opensource.cirrus.com/
Stefan, could you please provide your Tested-by tag for 1/7 patch.

---
BRANCH: for-next

Changes in v8:
- Updated __spi_add_device() and spi_set_cs() to fix spi driver failure
  with GPIO CS.
- Rebased the patch series on top of latest for-next branch and fixed 
  merge conflicts.
- Updated cover letter description to add information regarding GPIO CS
  testing and request Stefan to provide his Tested-by tag for 1/7 patch. 
- Updated 1/7 patch description.

Changes in v7:
- Updated spi_dev_check() to avoid failures for spi driver GPIO CS and
  moved the error message from __spi_add_device() to spi_dev_check().
- Resolved code indentation issue in spi_set_cs().
- In spi_set_cs() call spi_delay_exec( ) once if the controller supports 
  multi cs with both the CS backed by GPIO.
- Updated __spi_validate()to add checks for both the GPIO CS.
- Replaced cs_index_mask bit mask with SPI_CS_CNT_MAX.
- Updated struct spi_controller to represent multi CS capability of the
  spi controller through a flag bit SPI_CONTROLLER_MULTI_CS instead of 
  a boolen structure member "multi_cs_cap".
- Updated 1/7 patch description .

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
 drivers/mtd/spi-nor/core.c       | 702 +++++++++++++++++++++++++------
 drivers/mtd/spi-nor/core.h       |   8 +
 drivers/mtd/spi-nor/debugfs.c    |   4 +-
 drivers/mtd/spi-nor/gigadevice.c |   4 +-
 drivers/mtd/spi-nor/issi.c       |  11 +-
 drivers/mtd/spi-nor/macronix.c   |  10 +-
 drivers/mtd/spi-nor/micron-st.c  |  35 +-
 drivers/mtd/spi-nor/otp.c        |  48 ++-
 drivers/mtd/spi-nor/sfdp.c       |  33 +-
 drivers/mtd/spi-nor/spansion.c   |  80 ++--
 drivers/mtd/spi-nor/sst.c        |   7 +-
 drivers/mtd/spi-nor/swp.c        |  22 +-
 drivers/mtd/spi-nor/winbond.c    |   2 +-
 drivers/mtd/spi-nor/xilinx.c     |  18 +-
 drivers/spi/spi-zynqmp-gqspi.c   |  58 ++-
 drivers/spi/spi.c                | 231 +++++++---
 include/linux/mtd/spi-nor.h      |  18 +-
 include/linux/spi/spi.h          |  32 +-
 19 files changed, 1044 insertions(+), 296 deletions(-)

-- 
2.17.1

