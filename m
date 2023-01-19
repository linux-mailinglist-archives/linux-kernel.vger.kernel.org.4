Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6D674203
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjASTDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjASTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:03:10 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9C94C97
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8Jfj3Lp+iog/vlYUmiOGdT6c+LTJA9QbzZAht6QrLOoL2OEWvwFPQHomRtVa+li09vkHefsuzKfd3cWpG+rbc2shghpWJz42OhuWNpOSOjFDWfgSzS6cc9olSZo6Lpsp9eHjDSPXunPW2UmvQKVqdJJHxCpdDnwCUTm/3quYG4l3h2WICt3pGlrlAEquqZROf79gbcA29iYud/9035KHrJaGbBQOJ0vBeplN2wS3xULOfYpKB8DZgOBA819Ifw9Fcz0Dq6MaojuYRKVfVNZvj7siucjmCEk8yuR+jP+uujNlJZkYcXRzPeFAxlEDjgWEzlVMen55JF5cJa3+O9OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzwJw8z8JIgxx17JOcxrVgjYz9CYBxVkCsCpssvrqOQ=;
 b=F3SfegTCGEFINJhekk23Nt8k3N95b9x+FfrHwCgF4vDS3QV1rcBhnsOFFlZBvkPYeFCVMymi+6WLBU2GZOXeFyU7VyV/vUnNqOxraKivnRiAYBia13w7MggBu/A72XiKHAe+R50cHpVhjj+Ldeim93D6IvUEqXdOLAtQywjuCSAQiI0fSzdmFrNOrvWGxWhpdw0kfiNLI84AYOn6g/Yb/K3zxG+lCEmCQLy9Z0QdLp/PU6bsF2oT9TFGKHTcru2cUhCmhOaaeixCtEab1nTGfBZhGP1+QrykOraf/RQwQfcSdOhplQ4+CULsMqbDpQ1Fgr6iyu/nfHdn9LzakQ85vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzwJw8z8JIgxx17JOcxrVgjYz9CYBxVkCsCpssvrqOQ=;
 b=G4yIjkD6gcUMwgkOTAP6WncypGRxf0N/YHXslihbuBXcPcWgzSoGGxVf8U/pwIq5o4uF/p0uzf93OyMRBMDvOPC8rYg7D9cWlJnqSwpDFg/wquFAJlkfRxnLdRnhNJ7R3lj1dTMOanrh29D9KavQly/XnOGErlfGDXH38woiII2fQdH6sqIQAJI5G7XmRfzWta78+RO16uuVV3oHBf5Ry7xEckoAwIh+d9dbQTzS2VqS3yqraDr+NLC8Kpc73qishsHzXIoWWx2rKn+fIoFpz4Wj9KLFeE7aei0pJBHEgQwLiZZEcjt5H5zy/ZcQHe+qLOVsp+EJAe7E4d5gTWlDuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAXPR03MB8202.eurprd03.prod.outlook.com (2603:10a6:102:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 19:01:08 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6b03:ac16:24b5:9166%2]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 19:01:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Xinliang Liu <xinliang.liu@linaro.org>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3] drm: kirin: Enable COMPILE_TEST
Date:   Thu, 19 Jan 2023 14:00:44 -0500
Message-Id: <20230119190045.1619043-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0052.prod.exchangelabs.com
 (2603:10b6:208:25::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAXPR03MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ccbccc-d445-476e-ac81-08dafa4f85ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvy5q/fLnqOtrb8p/OyV/AqXnDs1OYzhlIbtrHeBrFtfSThI/aSE+i59lETGvdWeQc8dCHFYe621/D9Ul7geCmi7/Xcf/fLPNBZ9fpS2MX6ucK8P5CUYn0C0AIILXzW9U7XddDoW4Gocpoj9GQbutbJn1tIhDmP4Yvd2nB0JpYaVbvVYuHwjXHaf+v8peBuGvAC4cjkmA7Nuqjt3AZvzuPviqOmLIPLAS2bC8PJww4/YJRA65wqgruhbFFQVSX4Vysse4gywHeaigaVME7Wj378f1MbeTnGAezWh8XYSmlIpfSZkIZN/JeFGsQnW0x3ldEb98n5nLf4dcB+Lr54zYOkVXIga5+FZVu/P4949XqlIq8J0hL1a8VS85wZcBGdSiq8GJdHhi/o53CtKAo6yNZKU8+QfAG61UyHnxTM+xYT9WJJp1MbQhlr47ejo4JSu1V092bP4h32CnLTVpDHi3GB7d09EPT5Vn1gnH4UZ9FnoipuyYbnsxNcgdgIBfl/S3g0sPGtJteXKDkgKBuU64N+mvuxcDkB6NTLKZXQ+PLO2yeNQYBC53/SZ/Q9W7cgKQCRQXVV3Ryn6MBFIElO6WREyCmIpFDBI2tC2LEri3UshaAJwq94djqaQnH+SkVsSxVvSrmBuiEdTMHuiwYPT5rnadi5wo91j6wywmxF2fb48DYApBIrjll0Zl12UmaDZwgltNx9fsTncZJ6Iph3FQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(346002)(136003)(376002)(396003)(451199015)(36756003)(83380400001)(8936002)(41300700001)(2616005)(66476007)(110136005)(54906003)(316002)(66556008)(4326008)(66946007)(8676002)(38100700002)(38350700002)(86362001)(44832011)(5660300002)(2906002)(1076003)(6666004)(52116002)(107886003)(6506007)(186003)(26005)(6512007)(6486002)(66899015)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3KQfJPlzhuYGEbe+cHWS2OUGxC4KtgHUa+mg2kTgAYI647IcNpvfm2lOmw3?=
 =?us-ascii?Q?hPzDVsFYsqQtCPS4nuIJ0Dy/w2xiENNQ8ehw6NTqJuMZ92LrWMkivGqY5lc0?=
 =?us-ascii?Q?3VvLF/dRtz6sac7DF1ExzRIwezxuqlWPsXSxinruNAbRS47N5c9peLtrknI9?=
 =?us-ascii?Q?r29Wdlsq3c2SMTY7ZQ7evagxTKJFOS6On5FVl5ZKvqSMM2AalGluPjovBQvk?=
 =?us-ascii?Q?V2Zie2AWsf1jyuha3jdpczhlELVDgONrhS8+4Z9PLgyznwWmenEfXJZ4pJns?=
 =?us-ascii?Q?YQA0K9y2VHfJziOutuq6xb55iX8TwLsmF3ajr8x4+j8AHth8WbXmPxGiKky1?=
 =?us-ascii?Q?enJMNYrgAj0gQBw5vOQifTzxGmXnHjMFP+hJWdI0HA9RK+8XHGygVHhHGsDW?=
 =?us-ascii?Q?ltjIfIukSpqlOAZLEW86ecNya6VbfzmFiitDM8y++izFWVjXxEou3ICtP0yz?=
 =?us-ascii?Q?9dCGeghqLZYFjZcCA5GmKpBJD83s8ojWd/q4UUZHSCGrAnIAajNCwm+7HuR1?=
 =?us-ascii?Q?xAMBml8a/dftQ9AsAADhdbXpYynAL5Lsfz+pHRoya48rPMxZUMLqfeSHnacu?=
 =?us-ascii?Q?MLBevP4ZmY7uQKoNMYr4Q7IxSX1RwU39w+L4K1fEDj+ncpVvGBhOpRONXxb5?=
 =?us-ascii?Q?KB3vXBC5Lfukuu5fCNYu4zg01HhkWKC4n+0M7090cLMdqu5WLVTfjSrlEkjf?=
 =?us-ascii?Q?SoIxIQxAWesGKRVK/V9wdEYUJxj+DKZzQjY4EC1HK5iGB5mnsNbSCl9k7k95?=
 =?us-ascii?Q?D7P/yXBwSRbPjA2RMUk65sRpSlEEyMZwGOFnjWZcglzq0G3rfivoohuziof8?=
 =?us-ascii?Q?t1Eo4lJ02Ea1avn1b5xZYkcYHYfIgUE5bR7/H09preCbBbvzOXnXDNgMFFUH?=
 =?us-ascii?Q?Vsn+TI8DScstTmmAd4vrBapKED36Qkro8JUqyrRvxf06n00oXZwyFMClfF77?=
 =?us-ascii?Q?HFxvbbcoCn4nnu/5F6Idw0MG7qx5b8ViYqZfBX9ObBoISbJpjAP9FJ/My2Sh?=
 =?us-ascii?Q?hV3vceYR2bHRXXW8URfoa0Lhq7A0PftlIWZOQ4s1PtLDECC9C8K59l6nYagJ?=
 =?us-ascii?Q?rK17nUqaXHrypbrQLQHLrJZxy4h8FyPXCJA+rp00k/y8sOFgqnqpM5tNFjoc?=
 =?us-ascii?Q?nraJasaY/2TgJQn+Bpi0WLJnxVV7MUSc72IDEtcNhUcgTjJtgrOG9kx4uuyj?=
 =?us-ascii?Q?wFHBxzt9zfX4x2MJt+gLgmRlO4SQaKHcsqMJlgNMfhPRSjiZPX/CGT8lNdBA?=
 =?us-ascii?Q?sm5dJsm8FHsSXGfdBGi5BDzJ8CETAfVU63GYJ96yy+7mPKnTJzWj7C0fCOmM?=
 =?us-ascii?Q?Fh8pvOUJ5x2Gu8uDN+MyYy64FWtWc1Ta4B1C79ipP9MFxcIUAE3vli6+awNC?=
 =?us-ascii?Q?VAPNJzA1dChju402AH6Nt5iNmE/fRPK4xRjGxhx7/tUySs7iUYXE3ufPxMWV?=
 =?us-ascii?Q?00kMJIqfcHVQkqg8JamzQ9hLqjsQCQLewuGsFJF4KP/7qZEMAnqgbz3wkOuD?=
 =?us-ascii?Q?1nH28j29LZ1k3zJyVUjGoz3KNXAySjTZ5T16WWhregxfDCzHwmaQ1STP3UFH?=
 =?us-ascii?Q?gbeKHLaCZUi3C0AFZFrqy8RH/uH43XsUHwV9J5T7Mzb05o/V5rRbgUGbZUKa?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ccbccc-d445-476e-ac81-08dafa4f85ba
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:01:08.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPpaQbVJgQ5dzliNy5pWNlrQQ06MHI3xf7CfGN2sldsSiskP8ZtfkouB5AWwf4rOhYxiGqxldhcNESSeys7Fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make various small changes to allow compile-testing on other arches.
This is helpful to allow testing changes to 32-bit arm drivers in the
same build.

The primary changes is to use macros for 64-bit divisions and shifts,
but we also need some other fixes to deal with larger constants and
differences in includes.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Include io.h for readl/writel

Changes in v2:
- Use BIT_ULL

 drivers/gpu/drm/hisilicon/kirin/Kconfig         |  2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 10 +++++-----
 drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h    |  2 ++
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h |  2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

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
diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
index d79fc031e53d..a87d1135856f 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
@@ -7,6 +7,8 @@
 #ifndef __DW_DSI_REG_H__
 #define __DW_DSI_REG_H__
 
+#include <linux/io.h>
+
 #define MASK(x)				(BIT(x) - 1)
 
 /*
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

