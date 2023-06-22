Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ABD739F90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFVLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFVLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDF1FEC;
        Thu, 22 Jun 2023 04:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Xb6IR7OZIUoYgAqAhwjUNci90KcRPHZojXZ4V0yfJQik0V/Ebju+xhs1UKKofzs8DCIAawQrtLOsZjqkm3rodccwxKCg3edgH4yVnPGOzbGIl5wvl9zqs5F9dfrgIhUd/EJNE9vK0gzFLguZz+nRjTN76GZZa+svLSU4Qhd7MbmkJYvi9wPoFWi5ITZD/66G6IMaG+ttLijS2jTEYRAPZ5ROrcCMxknT6v8L+ZVb3qkToexqixH83vXlDfWCt8KWuyOXbJ0izZguhAdrP1igLXkL6G1zTfWZDWmhQ13psjhex1chsYAxdFyd92ESfoJ1VBNTGyQKTE56q6KiFcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEKvLS3cg3CPxxl4nbks+hp8xaKbrWhMMmp+O7VzhMs=;
 b=hBCgJ97AqC/tYE7VSD1FW7QPGF2sERcipnncWUHxRgLoSab10Ob4YEKzTuJUdNQq0kLXzZmsW48VsYDsICSFpHOT5BkAZJeNWf6b18vKVtTu93O9XYbHQPPHOt6yzKYXunjz8GYBIajfOgec255sBhgN8gEcjAY9zquaG9/aLRqlc3UssKl4UsShsrhlvtTo2DAKPtA12iAPN4wy0oFtnEwHLpYSVOgMfbHN71rbk9ngqQ8SPgDSPQpk1DLVSRp8leVf+FtYeybanqInvNiCnEuf8y+o+YwGjjOL5lBw43us0nRbczLY+0y0K53MhkNs2OXg91RtjOKz+IhbnABtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEKvLS3cg3CPxxl4nbks+hp8xaKbrWhMMmp+O7VzhMs=;
 b=ZYmON/r95asQDiHkO1kJRuF2e7keJFUcwchzMkx2dR8klvky8IcC5c9O3PeS6EQyJh4jDcWfJ56dh9mjUfbeqALnFu9KLEEj52lSJ02pUSqF2GiaA2sVL3VWlh9uNeZjMLTrcmOtIPn3dN5GL3ib4+a6v0j/gdcaTC4dGlbphgDaKRcnHweJyMW6jnkiEKTzI9Kjj+oow3ecUGzFEr183GmULoBMyVtE1ceqgVVh8w4JmgxBsHu6aZ3VwVCCaMOn8ntER61E+OoYgusZq1VZOI+gbRllWvlPB3h4UQSRH0kvl9nFva2xbHthGe9rY0NDF9oqeB/isRXrlOu3o9PRAg==
Received: from CYZPR14CA0011.namprd14.prod.outlook.com (2603:10b6:930:8f::23)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 22 Jun
 2023 11:34:33 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::15) by CYZPR14CA0011.outlook.office365.com
 (2603:10b6:930:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21 via Frontend Transport; Thu, 22 Jun 2023 11:34:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 04:34:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 04:34:24 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 22 Jun
 2023 04:34:21 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/8] Few audio fixes on Tegra platforms
Date:   Thu, 22 Jun 2023 17:04:08 +0530
Message-ID: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: dc206e8b-f70e-412a-c059-08db7314a6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6RxKpbAe31XkSNBZChDSALKjGTmxg1Zg5yXpZQk2FxpODKmYUBlYetcuo2GURIE/jMeEo1+o1AhWxa7IUdFjL7jmRHw3cPlJ6ZDqQCeAKheZi9GCTufSdssPxHsZHx5IyQikkDHCoTpW/zc/Ql8w88oGt29taZTZ1AZrXGr6ZCIWTdZ6OXOjs5RXKdilGMMxNJ2RPk5G7ZzXucGAVGENcA59L7lX1oHN6PLmHh0EbTIEY/9XqU3J6/LPqVSAU+pI/hM/Ba11KZm9siTbYU5qgN3pHdEdfeeQmc273EbpQJ7rTfxw5D0d/zDVHf4t7xS1HdOPg/XCdPHjPqq3rJPA3U878QQQIGgh5UX9alMmuOz6kRAV/6w+XUkmgQDrIIE82YHgZnUzw1I+LjeXpkRFNp/jDi8JsC7jhOMRbGkNIi32orpICjcvDxxWYSjESXaEtMptFmPphC6/2Oe2BgxGqKOBrZbp8r1Wlg3Q5aA9M4nJvQ60x6sdJVYhGKim+JaF6JOFE2YCUs18obpXQmWRqNO352eWZD7fVJ+hCiURsOa1zBiMnkZd+n+nKZCtVqJqqQHmPE4CdQmrjG3UCHyCsybb6thXPceKxf93F8K82ZWxOm6TYKAXRaU0l28uIw9mHPVLkz6Eh4Z5J9WTROrE7aAY5L9Ix2a7uOwJl9z3xuizsHQRLtCeHZJBrSH10lx8UmSUFF5r5PylW5kV10kphU3zUqBQTqL0vGLj5ABmXN7+ZkCLlikV1dY3iaL9h4x
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(336012)(26005)(2616005)(36860700001)(4326008)(70206006)(70586007)(7636003)(2906002)(6666004)(426003)(356005)(36756003)(7416002)(47076005)(83380400001)(86362001)(8676002)(8936002)(186003)(41300700001)(107886003)(40460700003)(82310400005)(316002)(478600001)(40480700001)(7696005)(5660300002)(82740400003)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:34:33.4580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc206e8b-f70e-412a-c059-08db7314a6a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some of the issues which were observed during an attempt to
enhance automated test coverage on Jetson AGX Orin. Below is a short summary
of the issues and fixes:

  * Sample rate coversion failures above 48kHz.
  * AMX and ADX test cases failures due to incorrect byte mask.
  * Atomic sleep in RT5640 codec which is present on Jetson AGX Orin.
  * AHUB clock fixes on Tegra234 and previous chips.
  * Minor cleanups in ASRC and AHUB driver.


Sameer Pujar (4):
  ASoC: rt5640: Fix sleep in atomic context
  ASoC: tegra: Use normal system sleep for ASRC
  ASoC: tegra: Remove stale comments in AHUB
  arm64: tegra: Update AHUB clock parent and rate

Sheetal (4):
  ASoC: tegra: Fix SFC conversion for few rates
  ASoC: tegra: Fix AMX byte map
  ASoC: tegra: Fix ADX byte map
  arm64: tegra: Update AHUB clock parent and rate on Tegra234

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  3 ++-
 sound/soc/codecs/rt5640.c                | 20 ++++++++++++--------
 sound/soc/tegra/tegra186_asrc.c          |  4 ++--
 sound/soc/tegra/tegra210_adx.c           | 24 ++++++++++++------------
 sound/soc/tegra/tegra210_ahub.c          | 10 ----------
 sound/soc/tegra/tegra210_amx.c           | 30 ++++++++++++------------------
 sound/soc/tegra/tegra210_sfc.c           | 31 ++++++++++++++++++++++++++++++-
 sound/soc/tegra/tegra210_sfc.h           |  4 ++--
 11 files changed, 78 insertions(+), 57 deletions(-)

-- 
2.7.4

