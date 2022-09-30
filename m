Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD93C5F0CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiI3N6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3N6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:58:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984715C1D6;
        Fri, 30 Sep 2022 06:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnXZfXvfNQ8s3q2E20xHc21slaNhFUBY8nbSgw9cpr+jydwop1qCbydI3u/D11wKx4oCfZwG+cFgs5tt5AYDgCZnmCATOmbdG2s0m61P/BgX1/7HMAbNfnQc+bJ5rurKWainQgBWcMmKUQpJM8zQDwgeD9s1CYYV17CdS17Q0jjo8crvuuPzIkvsNFFPIuIYs/7Vn9gk+oFHsAaoh4wQrUv0bTDBBF4lBuL5/U2OUxA/YNIk8gkys2mXtEsXtkJ5fAYu7UQABZUGW2arJYQ+ySzF3ilmiMpCXurIZGH3fPX7b3TB8/0lIsLavq+gbUawbTLdydIwaJHcfluP6CDqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCpcAUyorv/NMdCZSNiyRIFZAcZkpCHM7m5XKjWDvQ=;
 b=g/Sb0fWxs4jvqCN8UDfmjgqAzfGgw0qpLO9ldqIsI8N2wjsNGo9nbs71C5qLt274hARCjCpFTHrCUyMt0EIsPzmIWJ/LsMo00u5XqJt+bG1JSz0I0Q0YeSy6vAUTjMOh24S4nu2Mt2u8jT11GcQwEcqyX80XcnIPGXUKTdn7xbAHlq6RxyQ6OAHsgrzMmJi6WbcPisWwcMLTVSkz+zoRCrX94WuwU1IcmkwwTgvTveGU9/OkqIkwfHOXvFpXBsyimUDGFan0sbvcMG38Ld2qbtT586vo86XcncgLtL1rIABmk/ofG7FKF5fB6l1PRoRzYsLFNXDYmFbCDLiG4IVd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCpcAUyorv/NMdCZSNiyRIFZAcZkpCHM7m5XKjWDvQ=;
 b=ZvU5NA6ji+r39djUhG3Ii3RW2AF3iDEx3gSuzNaxIY0tq/515Yt5gu4cRx29GNBDsKbDcWAi6UtjQMxYxC2LExd1jBnbWnD27tDXh2NWwA7vVVuSKWem1dFYfLiKAgVUlcc7CRiKZaXbOk/RRqVmsZK8UDCgNsuO1yVL1lrrsSbs2FSxfWOpMBn9QOEoHbfbI33KtiYPzDxIJBsn3cp4LCu7szIVolOUlK7vvfMLlYvwdexP3sSmlFjE9J5ywKOPmlQ8GrsAiNsh+I1ECigu9+0DcjsAJgIaxF6YnVMXMdqwrE1IAxHudZTuCYf3RB5Aq8fYmtfqQ1n/IbpzJ/GBig==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 13:58:18 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::fe) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Fri, 30 Sep 2022 13:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 13:58:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 06:58:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 06:58:14 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 06:58:12 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <treding@gmail.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/2] arm64: defconfig: Enable couple of audio codecs
Date:   Fri, 30 Sep 2022 19:26:33 +0530
Message-ID: <1664546194-735-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664546194-735-1-git-send-email-spujar@nvidia.com>
References: <1664546194-735-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: aedc0e19-2d03-4bb0-8148-08daa2ebd3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2Y6sB9Dpp/x4PNa5XmZLSIIH05G5lkvM+yIdLm+kwP3JdzYO67cC4f3OHShPU8VotSeiV7lJCxdmLw1nfUwyQYul92QeyiqW+kb1q82yZ1Hpau+bU7Ozo/Ze6ep++gxDcFMk+r4z0zdfQZaDhTevDZWQv1FxWxrbcaAUs9KTTaAAB9L9BTiLHppCT+9gaXriwGb9AJLQAiUmP7CNdfIza7KER96mA+mPiF6veOVFzkkTvwK06yNKm4w1261WLgQUHxT27RbzlH2BK0c2G6DY9ivBM0lkXEis8h3dxp+0dU+4uGCC3D/Vun+AYrz+T3njYXTZUvR5xiJy9fgP+vnQDgiOToFE7hrYn6zcifGNGl0wQ/FpNTsnXoJBDY2zYOtYOdWm9WNu0TYWeBgCh/9hWT7qnWFcOgR/OntzuvPLkhx42mQEkVYOb7GWbCocZ2eVBeYQ4xxU7VVqBjq2WASCF9R7qIzOXLEYMcNApNKItEE8dPh3x+nXHPBCiQPXYycN9fyDziETGG1qtDz3n2pEHB3vjYIS9hmMVtNc6t/5xz6497k7d/x0TIdijpMqIopf0a0BWOnFcabXFYN9KcX6ODxu6MWxwcFPhNivLR/yd3bcxv2ougwoK3TgbUmyFflYZAfKpuQ+a4OrL7LWJOtnl2GjJoL2NUCN6+GAyY/8UkZq/BJjtYgxHsVScgJF3bEZIfXzIVm9w/uSI7TkprWZREYpm3mc+Jlw9R0rq/BkeTd2taBtATgAd4JelnE4K54tpPyT9kUdkY8QD6s+sgqCQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(110136005)(4744005)(86362001)(2616005)(2906002)(8936002)(36756003)(186003)(5660300002)(336012)(356005)(426003)(47076005)(41300700001)(70586007)(70206006)(26005)(8676002)(4326008)(7636003)(40460700003)(316002)(82740400003)(7696005)(107886003)(6666004)(478600001)(36860700001)(54906003)(82310400005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 13:58:17.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aedc0e19-2d03-4bb0-8148-08daa2ebd3ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable RT5640 and TAS2552 audio codec drivers.

NVIDIA Jetson platforms have 40-pin GPIO expanders where custom
audio cards can be connected. Support for above codecs is typically
required. Also NVIDIA Jetson AGX Orin platform has RT5640 as onboard
codec. To support these enable driver build for these codecs.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a943883..b682318 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -843,9 +843,11 @@ CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
+CONFIG_SND_SOC_RT5640=m
 CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
+CONFIG_SND_SOC_TAS2552=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_WCD9335=m
-- 
2.7.4

