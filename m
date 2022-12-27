Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B83656CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiL0PwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0PwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:52:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83FB489
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsowKUddiTZ2zeqgU0bmxOUCGU0W/bbIPUECPyw6y474skB1kzA4Qdwy+fm3CxvLLrgBR/z/YHZN5foTs/0/uDeBKaHx1xr/eKV2HyAg6dvWyT0ZnN/QBeO4VIwGDYofhvqy/IPtrzSPxZROUD44at20/gxfQAQwoDnIQXqGTrW8TiPPgpsr6MX5n3P49wr6xGjUo8sWc5f7tKRYwa6mVG9Pstlh8UZBXZkl9RLBTevtwvNqbfPh3pyxJhQbmVHvxb2Vp6t2sWNusTDwTenLsQTsGFwPXloDJkJKB9lejHbQFKSSBcIdPonC4OCqSpFA6afMZFteb2B0qzR+g7VReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTeHriYmwHWDPvn8o0Cut8a8jiBiuZGKxOW1FCEbSrk=;
 b=P2GYjoxapXRar8TEjImGxBF6s9KlnMqI1ypm9d2yXd0O8aQEnlOZ9+n5oszK8a6GgGjJzG98ucu8wDhOy3WJJQno4FKZC75LBiceXQiS6WmvIFRqaOBrlHbrwbq8LK/VHjdlcylqfAzj2MGJSrkWbNInnIZ7/bXOczM3dLhIqzbkdg+GYpc9ii8mIIwKFZ9F/AeD/4sFTX0PaRSlrXTHBxFe7s04y9kPe/XhFWChfoV5V5/qJSW2X/rxP5HSg/hj35NFH2cqSLdfRe+CdiDzdQaI48dOd2glBUknp2wQEFQd26c9qm6EHbMzhr7ISxn7vY/lxNdVVdL8+cVicKtjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTeHriYmwHWDPvn8o0Cut8a8jiBiuZGKxOW1FCEbSrk=;
 b=lL6/XNY5ocGB54LLzS3qCjV3BgIHDOQvGehNTCtPgj2/jBelIqFiD2qzexD2MY8KxHJ/J6UgtklGhq0XMQS3TCWT+l3zllh47+xKptWs9caSrGnq/TdT8v8msVVXSL1+iogzyE+No5fc1ZskA5wqfVJe0Y2jzwS7saWYYY7pzJzm5+JCmaAV6WFpba3opPQiZh3HQiplOFCi2HjK5bl8hlotOgjihT/5B+42TBgqGvtZx5xH1AXE839kqKle5PvVc6YAB4UwgKXgoyMpahWAe+M4i+ntnDWN6XyUEE5Q6FL/8yY0o/KiKDGzWLxSQu/MLOpio+8WesUJ8FWI3UAgwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DBAPR03MB6567.eurprd03.prod.outlook.com (2603:10a6:10:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 15:51:52 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%8]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 15:51:52 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] drm: kirin: Enable COMPILE_TEST
Date:   Tue, 27 Dec 2022 10:50:56 -0500
Message-Id: <20221227155056.2271217-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::14) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DBAPR03MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 280628b0-47b2-462c-8573-08dae822459c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1/UoaM9PMZ8KKZY+vdyrJqgODqgcxEikYMzAlgpMqws0e021HtPztbUKH2jDP7CzkNvDCNHzUxVyFm1KAcNuGyXgpESbHxSbSbtC/8Ab9iETdZgI4lZv8DlsVnLM6d2xLQT3O/6o4PKrg194Yr+TEz4RTWrT0m+DfrYKdQGNrd7u8A12xrI5YSfXLLCtyZszz7l1k4LDmwf/+HUFHZw34eNzlDkK+H44PVfCVr5QYnxnGMryp+UGMKaXxoQ0Ll/fmvOpZB9bMa8/nXO6gUWn6nsG0VjDNyZRRvj9qorYQDMnadiHNkR7jrdGzIeUzkMC3RIc4IBoEWBg1QRHax+1UcwkE/kBiOTP/8JfRuKiUKstQ+BApvO1Jz0RpaZcWxIWNWaJvwpFsZW/x0p1yvecOLiN4i07X9vJVEcc5CcZ6tXK35WH6fAhsKXRhV5t0VIsRb/4dPJc0CO3kUSUABiyeA12Ie8sw1yEXoDva2j0b1L3CmRzmFhhQ5kpgTJJTik9MZALsolcNbksm7h1K10/c1CP6OJUxaOKlpi/5oeDZm8IGgegMSoVyftaHfK+dv7aZoQHGyD3JAJYALVwlcTQhADky+LK1X6NREbv6L/fDPr+rRkDS31R7PcW82pKtfFf7jD5t7M9VjQeAh7SMwk6tkm2veEZ+NnSa9q3YZ8OBpiCfU4HlBzAuNRrr5YA5V/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39840400004)(376002)(366004)(136003)(346002)(451199015)(83380400001)(5660300002)(66946007)(66476007)(66556008)(41300700001)(8676002)(8936002)(4326008)(86362001)(1076003)(6486002)(2616005)(38100700002)(6512007)(38350700002)(26005)(36756003)(44832011)(186003)(2906002)(316002)(110136005)(107886003)(478600001)(54906003)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrT/3W006wlj9F4t3PGyMLMQm1o9AvibyCLEa+2HYp57p6+23YzmEALf0vPP?=
 =?us-ascii?Q?p6jg3nTm/Yf06A/hTJlgHGuJGWfFB6PcAGRCjRbe2gzLDlbPqQLM3dWlLobA?=
 =?us-ascii?Q?C4lXc6gtvy1KK/XzcW2zOroZBJ40vACZ+sJtJBkMoByoLu5pJCZpUdMHT9Sq?=
 =?us-ascii?Q?d3JR2N6r+ou2tcOuu8ls5aFt8HpfvukxPuS0TVTlyxJP1ZEJEaY4lo+sepqN?=
 =?us-ascii?Q?nKkAGEsZWP2v/oDQLQA4ZsPVZWt4E5d8zWw8SVcsopm1jSTPmyGPaB8zKBn+?=
 =?us-ascii?Q?dzdqPfNbnT4d6jiPa+gCUClc+g4++rHJWq5sgdm5FU47zgmgdfbwzzX09/Kj?=
 =?us-ascii?Q?iz+Mk0awK5X8dspXL1y6C1CKgLGSa4MFknnvqQ+27A5r+VCI8NS4mWOmT35C?=
 =?us-ascii?Q?ZitFh3tsd/C9hCYp5Osfc2lOot8aZP7w4xEfjZJVPuMUvFGIZC1k6PpYetur?=
 =?us-ascii?Q?//ivh5LzlHH4bqaH4ODdlSUNmItuJalN27kzUvVkAS5tp1awQUlHRVzvcCsb?=
 =?us-ascii?Q?dJw/5fnrsc8ohPTX2Q+FgBr+SSJeNopC63FF1KWHZMS8zmZ09mIWh2m3kj7X?=
 =?us-ascii?Q?GjZk4gFyAfaq8YzEDPN9cRSoIVJ0TwB1n5MOYyq3wCr38gvIdJz2N0p/a3yo?=
 =?us-ascii?Q?vjNlah/Y7+Ul7fFR+97bUA1lpywWqjASfJTS3g/53OcezxcSicaKW2w6mTSo?=
 =?us-ascii?Q?KMMsIRN0/eo8voNxstiInXSM3DTk3wVwczDsGGAwGmsUfg2Qg35gIwj+TZ+h?=
 =?us-ascii?Q?BN9Uh+B4n2r1/sohDWyLRru9jg0UEQdApR1N7ToHl+L4FO9gflYVTvjAnbtn?=
 =?us-ascii?Q?8E2Ulmus3ITaXmO3GCma0uVTIT/i8Vj6zgPEN0VdDMshFMEplXiCXdY6mHPs?=
 =?us-ascii?Q?5OxmH7CijlbzVxURJTwlaZ+g5hficVi3khcOfFTWEEhd4m7AYJMO4/Z680tl?=
 =?us-ascii?Q?9kAO8S4SSV226RaWxy5ztcUhd4xdBaBW4W1qGkwWvPTICc0Zlf3Q8q2C3bBy?=
 =?us-ascii?Q?tZtbC2Fzg8JfDu7YEBI+pJz2vr+KIYxPrGDkDev+DSSS9er9XB6Hzuiv6ESc?=
 =?us-ascii?Q?89Ps6t7xTT13wPalG9EzRkKL3/Z+ElytWeaXI0sFd0HEn/Cw7uCx7ImxnZMK?=
 =?us-ascii?Q?jPrZUQ1L06KvZxVwOO0MN9rSXa4pdf+Dw16c1oIONcwYQ9AqW0/lqx7g5loc?=
 =?us-ascii?Q?W04sSvfsf9An7kQ3ZZOi08Yk3gwLtYJP74hgMWp8j04pH7qvWkLhV3Ga0GoK?=
 =?us-ascii?Q?lGdS2X5b4zEQh+CN4XE5TZf6jVXASoGv4FUTW7bPwlv5EwWmr8gqk2u1hQ+I?=
 =?us-ascii?Q?4h1sYHegAPhOiBheoRS/pj3VgxcnGW40RHlr3m/r/+MfRdGvHMBWo+1vElmY?=
 =?us-ascii?Q?OLTXhRaqHoOwsNto+6DOOAGQ3rdCI5L0Tbc++Lh+fpSWuTdPKInMPuxw32r7?=
 =?us-ascii?Q?PV81oyNmMjTRN8nj9Z3gRg+SPAVG7b5v3261HM58yuSopv/3mxM6LCrWuleU?=
 =?us-ascii?Q?TEU3dD4EQraoSMcFdazIVHYLojwz6LaFbWG/L+k8PpmZyJdRIpPPWKVhhwpn?=
 =?us-ascii?Q?lQbGaeMEvMhhmqRtlxDjjfS+vJ9Juqz0OzFGMFdyo1gfp+pdCbNvFyHoFNPb?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280628b0-47b2-462c-8573-08dae822459c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 15:51:52.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQWA68ToZm9TKna+aYHaGyn3eXdiaX72XF2HC59PHB2rtgkIXJqru/ueyf+uV826xiWrh5uz7iSlGm7AB2DPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macros for 64-bit divisions and shifts. This allows compile-testing
this driver on 32-bit arches, so enable it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Use BIT_ULL

 drivers/gpu/drm/hisilicon/kirin/Kconfig         |  2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 10 +++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
index c5265675bf0c..0772f79567ef 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_HISI_KIRIN
 	tristate "DRM Support for Hisilicon Kirin series SoCs Platform"
-	depends on DRM && OF && ARM64
+	depends on DRM && OF && (ARM64 || COMPILE_TEST)
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DSI
diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index d9978b79828c..1cfeffefd4b4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -157,8 +157,8 @@ static u32 dsi_calc_phy_rate(u32 req_kHz, struct mipi_phy_params *phy)
 			q_pll = 0x10 >> (7 - phy->hstx_ckg_sel);
 
 		temp = f_kHz * (u64)q_pll * (u64)ref_clk_ps;
-		m_n_int = temp / (u64)1000000000;
-		m_n = (temp % (u64)1000000000) / (u64)100000000;
+		m_n_int = div_u64_rem(temp, 1000000000, &m_n);
+		m_n /= 100000000;
 
 		if (m_n_int % 2 == 0) {
 			if (m_n * 6 >= 50) {
@@ -229,8 +229,8 @@ static u32 dsi_calc_phy_rate(u32 req_kHz, struct mipi_phy_params *phy)
 			phy->pll_fbd_div5f = 1;
 		}
 
-		f_kHz = (u64)1000000000 * (u64)m_pll /
-			((u64)ref_clk_ps * (u64)n_pll * (u64)q_pll);
+		f_kHz = div64_u64((u64)1000000000 * (u64)m_pll,
+				  (u64)ref_clk_ps * (u64)n_pll * (u64)q_pll);
 
 		if (f_kHz >= req_kHz)
 			break;
@@ -490,7 +490,7 @@ static void dsi_set_mode_timing(void __iomem *base,
 	hsa_time = (hsw * lane_byte_clk_kHz) / pixel_clk_kHz;
 	hbp_time = (hbp * lane_byte_clk_kHz) / pixel_clk_kHz;
 	tmp = (u64)htot * (u64)lane_byte_clk_kHz;
-	hline_time = DIV_ROUND_UP(tmp, pixel_clk_kHz);
+	hline_time = DIV64_U64_ROUND_UP(tmp, pixel_clk_kHz);
 
 	/* all specified in byte-lane clocks */
 	writel(hsa_time, base + VID_HSA_TIME);
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
index be9e789c2d04..36f923cc7594 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -10,7 +10,7 @@
 /*
  * ADE Registers
  */
-#define MASK(x)				(BIT(x) - 1)
+#define MASK(x)				(BIT_ULL(x) - 1)
 
 #define ADE_CTRL			0x0004
 #define FRM_END_START_OFST		0
-- 
2.35.1.1320.gc452695387.dirty

