Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F95690C02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBIOiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBIOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:38:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650476032D;
        Thu,  9 Feb 2023 06:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqwq2daZqbw2xoVElPMHJI8WnnIpcyzs+ZXLZBc3vd25HdfGB4E5jH2/1BUtRe2IjOm9OFG2cfRElt5SBVi4xtfgg6Rk3cxR5cjZAvpJk7w4Hv2IYzp38T+p+z1f4JUUj17wWStI6nVr0KSgmdFC8L4pkgdJz6fWrXKUlhf4vSDm+ztAzEfPnRxfylTaorN5zhHqwHa9YInoWMvv4v5O34OKv6cFFowasyZImMeb5P80cHnBbCdq5ubZIuTbZ9RtQLG3Te5n5hQ/7icPhHKQRhGE4QeJPKdeRStjmYunk5P89gTJvIINs7hrFnU5kBnLh7wk49SBhnLCmfgVVCTs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMdaSqPKE55bR7qk1vw7VG/3FkD/erVs22Kw0FyP3VI=;
 b=fGDk+JRs3Ob7N1mpXoUFMd+1tjTCptKPAupw/kw59wT07r5GTmpqgb+pUC8BElmWTdJAd0NpEiri0cACNpcomdKZjWRoijwamlVNgtC+K/ZT51hqyCZ7L62n4Lf2dAl40V39+IeLr7fvpl8Z1594Ev7d0vkZkrwAWL3/jNAlP+ofY+IN3di7IPWIcXJMcVATqOzMo+VgIHoLSMbWyf2TA2rhcHjmABJYdP9KEPBNTVpgik+fVuiK7mHLW9+SwGCtMqVwka0vLJvpuQx6CLvUxkZHKS8tdXKUyUxp3Mu/WFihOcCu9rIWPfwsHVSz0EeAIIBKp/tYTSJkNybeBEG+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMdaSqPKE55bR7qk1vw7VG/3FkD/erVs22Kw0FyP3VI=;
 b=XWgDWsnDBq8PCTC3290W/cOO2vosIIw6wC0fzUKr2MeGvF1Wugq5O4QIQXHQ9GOuVtAZ7a6gYh+JpaIIt24u3+UiUTJ2ChHpC/UNdcsGvAw3IDK66WMGQFb1xlj7X+oMN7MhNazYaS8mLd8GtuYIXrY5GtrxMfsQLHFeHRnGo1m9JGi22nRva9KBr2q8NfSsSwJtzcRh+9oIfrsIa2uzJCHYoRYdlN17dNGsCZFgqgDQDeG8g94QHy37IIxv41Gg/SiiZ4rN18oVYLjWowwlcxCAzwZykyRoHAkwacYV8SJxb9YUCbPzHsRVjOhut4CKL7H2m6Wk9IbQRqAxcWMlbQ==
Received: from BN0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:e7::10)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:37:37 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::f2) by BN0PR03CA0035.outlook.office365.com
 (2603:10b6:408:e7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 14:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 14:37:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 06:37:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 06:37:24 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 06:37:20 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <oder_chiou@realtek.com>, <broonie@kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/2] Codec support on Jetson AGX Orin
Date:   Thu, 9 Feb 2023 20:06:55 +0530
Message-ID: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc4222-2731-4003-8124-08db0aab3064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuPsamz+Z+gprN3hFIcS9iYrMX+aV0oY48JfrsY3xIvSTLdSzBKutAcNtDVwKPH2zhbEkQv77hRZCG7sJ0JjG25fA6IFU4BHyCFEjPbUMk2wMMlbk4Aal/qVB6C6Z3AXApC9bPxsFD6Dx5jmE4W52NXH4yZ4qxQLGL20Bhj9FyxszIkPVNZwS/77ycyQa+7RV2DxEcGnmqDZmdBV1hJEYKLR64KiLC1WJJtgisjvVm6AKNygNOMZ/9eq3BX1kFt7n8lH0IXNvxTi0iPewrnSYltOYwSQiYu3u/SySRhzWrjtMFl8pCa+HFMzKgy+D9MR1aeW+5+EfafzLp19AOChbbOQbEnY4TaqiHDyLO4L8ls4FKo3uqJYHg7VQvRjz0oZ0ZuXGfL6Dv16ukd1WipquXxbUkG8HoBiEBZ8FG1U9vuZXRJsNgLdiXIB4qtWUNHQ6rukGJr8PSJF8AEkfbG94hsBKAVsRei7nFInXhmloqskGJsNXN68ZJyZVBIgBrEB7GTJhXAYgGy+zUPcawmfeDISoR3BkX6wbxwQ9qdDpjwVx+WPOz7OsOAw7dDQ4tifPjaDubWUKz6hdLXEdKMkV5tn9V/hXawJZoVzzJz2mjjW0pbFwqE0NeaRW2yTbTkbw26mpl+rkBwifqMvA/TtJdKyw2VuSrRgPM4aZsL+ILmJ+7av6S+THup08/aOZ4tGmQVJ+Fu41VFVNtNr7Cl0xw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(2906002)(82310400005)(40480700001)(478600001)(36860700001)(26005)(7696005)(2616005)(336012)(186003)(83380400001)(47076005)(426003)(8676002)(6666004)(4326008)(40460700003)(107886003)(41300700001)(70206006)(70586007)(4744005)(86362001)(7416002)(5660300002)(8936002)(7636003)(82740400003)(316002)(356005)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:37:36.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc4222-2731-4003-8124-08db0aab3064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jetson AGX Orin has onboard RT5640 audio codec and uses I2S1 interface.
Add DT bindings to enable codec support. Series also contains a clock
fix in the codec driver.

Sameer Pujar (2):
  ASoC: rt5640: Update MCLK rate in set_sysclk()
  arm64: tegra: Audio codec support on Jetson AGX Orin

 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 47 +++++++++++++++++++++-
 sound/soc/codecs/rt5640.c                          |  5 +++
 2 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.7.4

