Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492963A6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiK1LHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiK1LGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:06:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62661BEAB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahI1IqZLKuwHBMdXdhxMkYt5Rdc9EXXbzRDv1hDHXBC3J8DTxejSFb+ZlzScKg6OQrIr31wIlPiUfs8ZWFMiSsB72XEiQQUDqNig5kICNVyElZzPU6EvcXlRMqMYXRzFs06PGcUtCdfWYyYk4tyHlTBUSn07QmTnCE6+YTKWi8fd5hvHuZ6UxGYZJAdznpqIEHWw4k1hpDSv9N4hKbaJZZIj7kytWz0HvjPY3NJt6XzoB2JsNaig7xFG6FqOrWpodoYZkznComR1MSk/sPbCUuUukUAdaaqjsHRnoedhOZ21ynFJQg/aD1DjlrSx23Xxl8DH1vWihlnVd23TWDJoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwWYGFIbaUvI5y2Uxlu1w+BCCK2ZR+oJ0MWBnquPX3M=;
 b=eNAGSEb8/O8CnWaVJbZimjO1XcfizSa4xLInLpa05xyxaw/e79Z1xtcfZbXY5VjOKT9UNE/6tltXEUMEXZjnyttTDvX8Ui0x57yjp3JXzBG1WDAlXnhiBIAjb1ZLKdBJlg4UsR6hMpzWwF2Lo/i6zayUbLx+3Jh4fJ1RJPCHudNnxawS1AfA9eMGQn3L55Hwal6PKZHY/pQXFX3ClJuyCj7R520lquAIBBMTuc0tWUrB77j7WGEd+5RILLwIFOpR0wFUAuPL5Ag247AVFpozWu++spbwfWv/dNCTeWTZCLECYvmueDhgSIIYpnLknkZy9ZhFk+VESsZXZ6q+ZdNYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwWYGFIbaUvI5y2Uxlu1w+BCCK2ZR+oJ0MWBnquPX3M=;
 b=tYZBPWnrupgqA5PDA7v3/JgCB0oUi91OIEil12GHPT7PpIls4BMAHrPDeU6Hoc8N42NR5iwibwDzj4hb/uZ0c0bQkMjS0GdP/g88+DGI+zqC79cq342cuggO3sTMUKxCRpXHsMpuWj932UZUtltDjg6J7O4Dh2mD0H40KjrupG1NdIEF3Yb6Qneo9nzEpZILpppBfcr5NeRERTsn/hBQa8QCMKnTFoybkiLgKilt10N9DQ2cumqIdZbNb1scP8azQsybq5Mopdtb7+OmzIGToTqeXCxLctmwOXgTGW2y1ZXpQDqKHZeO5P44wgnENOTM5RmFamHYsOdhh0V4fPlE7A==
Received: from MW4PR04CA0230.namprd04.prod.outlook.com (2603:10b6:303:87::25)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 11:06:32 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b3) by MW4PR04CA0230.outlook.office365.com
 (2603:10b6:303:87::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22 via Frontend
 Transport; Mon, 28 Nov 2022 11:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.21 via Frontend Transport; Mon, 28 Nov 2022 11:06:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 03:06:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 03:06:22 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 28 Nov 2022 03:06:20 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] arm64: defconfig: Enable HDA INTEL config for ARM64
Date:   Mon, 28 Nov 2022 16:35:49 +0530
Message-ID: <20221128110549.7452-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|DM4PR12MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: d11827e4-f660-4ede-a839-08dad1309b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdq5lB6ZO1P0Qf3xTgoe2f4AojnYkgTFz5Pijh7l5us/i2KP2agWUQdWMN9l/AJAzbSCSz7tMa/0ZSR/gs9VKz2fj7uw7y9t4GzczvlnI8O+WW+06z5A4vZUXOxS5piRa6wVKYGdahlR2n+wk0f6Kc3rCyafmk6hpXMw58nEiP2Leq71a4eiHPt60AS9IAJpJXZmGmlzjPFn0fQxqkezanCpKjSNGrSzrspn5pKBtDgcu/ITr+rcumgvMKJyRVpjaKOgn6nAR0WhE5q3Si4nuV5BhCENy7JUlRqXKFijcWdroCh1VLUCZJPirlJvVNvJUrIxXZxPRH+oyt+/ad3Lp/EMjnZ2YYH359fkz4BVRMpmWW2aitdkZ7WCaDe07sXt+mni829F2SmFY88r1fA+Hm5HB6KRcfN3XIUPHklGnefm83TaqYjGPPZ/BP68E3f8L3DajDnMK5mLitTfev4UZXXAf9ez/jCydnCTa7q4cZB+JrwEwTOGYmxcjVmTyYuVlLb47UHTGzIqDCnMxFiUllBR0Aie1844AKTgjpAdpm2BgWA6DiVZ4usfQU749bYFOziDfhGufyimDxHTFnH3o1lt2RjP2igqWsNKlp82eAauuYtK1KYghycOZ44/47SyfZ3Xm8i+oWOPQVjHn5MLaeJ1jChMiplqY4/kq/bufl53cVV7aZT9Rt5khVRyr0W1qhlz0j104NVZ1Nm8iBMt73ndlYqKgUgEdMMTcN5vFE0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(478600001)(70586007)(316002)(2906002)(54906003)(36756003)(110136005)(356005)(7636003)(40460700003)(426003)(47076005)(82310400005)(36860700001)(82740400003)(107886003)(40480700001)(6666004)(26005)(7696005)(86362001)(336012)(186003)(1076003)(2616005)(4744005)(5660300002)(8936002)(41300700001)(4326008)(8676002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 11:06:31.8553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11827e4-f660-4ede-a839-08dad1309b3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card
for ARM64 based platforms as Intel PCI driver was used for registering
the sound card.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03b61f846a0e..a5b9ca025421 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -805,6 +805,7 @@ CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_ALOOP=m
+CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
-- 
2.17.1

