Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0170463D6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiK3NiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiK3NiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:38:10 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB0D27CDF;
        Wed, 30 Nov 2022 05:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt1hAxz1bFB6OVuvScGQqXU51jQp2JzTohYy4emidA/N+y9EEahiVJ7XWrAESc3D5ZUxW2yR5x8FAK166IvVNO1V2SUQ0/BxJPMSCCxP4P/lOyfRXLJC4AEo/90IBmb/23z68lg261U52hSGMC5E11AyClJQhmM8aLELiCB65DSjYjSqCnL3jYYfog7dOaM7d+rZFe1+IV6jA3j/uwloLpkGVSsnOUNAxEk3pGD6bx0x5F5YRY1ZAxvVZgC93OhaRGAYQ0TvdKQS830vlOD7HAzQoWyU11ZQcbyrCp8qZKGjSNI89xnQJQA9+W/zV4t5G+YucNmJwb2uwkNMEVpURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3His+zrSJ0Epx1XGYz2o6BCePmujYxlnbK/1bctSts8=;
 b=I4ihXMddFpGCPptwEDgCojsDJfGNygx+I26Y4DajGpaEIwn9fswxBi3/c3XRcSebx7Bm4vlYW14QEhlxP6M1SWGnGDHPNkoU7njSSKdULVmQGjQjO1QH9jxqcviRnpFAtfk/rATsit/ye3/3BAIc3im/twmMfaEvPJy8MASrZ+E4hVUpiKNVlCPAoQiBMTFwX65C1upSCIRd2YolwYR0d7SQxNsJ0NB0w9BGG8jl3zP5JToCByUuyBeBdJE7tjA41wGy7ODkZ73v5g5jcEINJURvhLYa6Is0LsdZlOm2zoRe725sxJ2cI0C9Nl+coynE3DxJwiMJSyjbeE7m9Icajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3His+zrSJ0Epx1XGYz2o6BCePmujYxlnbK/1bctSts8=;
 b=L2s/bg+onUIy5UriGiiyw27Aoly510KPfYPPR9SqpkjfUiuzLCGJlyjTQV50Z0bwYz4AgPdMm+b6PQ348JE1d9gt65TLQJeOhTFmzA34HI2kwj0ns/N+6cpRvE7Wt9MIBp/xupflsz8IPIYN2LewtOTd/tB8hpaTF9jMYnyRdl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PR3P190MB0858.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 13:38:08 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 13:38:08 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
Date:   Wed, 30 Nov 2022 15:37:47 +0200
Message-Id: <20221130133747.3777340-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
References: <20221130133747.3777340-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PR3P190MB0858:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b48161c-9a10-4a32-88fe-08dad2d81da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eejudW/mH3RcsFkVNREVWpDuuIQUCcXwsczkx3YBIrssglqGN3+yzbIST02mEegehqD5OdhBvTpbqbAAVgKdXgG/EzOGSDxRFqdmT3S9U4/I8XhV9tdoROaXAqW7ghAxyjCaZTV5UyHfGjhDhXmcxP0e22wKmK6bT/Dgh16RdqO555N1N+nLqLEv8RkdMItRH5+XiGS8ae6SVwlWz+INnsAptOtojn5gxMhazJegTovcntbU7wr80G415hA+fKnt3ObrGhGrI28S2IL94m9MveVO+aK8YexoapZgkleXqIGN9sKMoVnSLcg2ARsPGS4eJA9doJrVTXl1zngX02co0XHoFzdBW/Jd7GVmyVaNCh1OVlywt87LRQjacP7LvEtDg5zrIHMBn6RJYJbEeGqgOtK4C0JRdNSfBRK2u0P48Tng9SW3D9PMYO4cl7d2fiNBEQmhkYVOFOwlHejDkDfX822Yrlg3JRaWc8dY9Wk/wJCecKKYU8YFzlY+4nlYtRGBYJ6JePio+CjocUdlN92Mgoh6RqOTmchruvG8oo2iapt/Fuv0/tC+XNEVJF0xVRvwuFbsfWP9ZSvG4KdIX2kpfddTeK2HKJR+BFFn4hJtg2X0ZmrC6+WWbM1oi5de0D+V1xBOIsow7EO5xjB/3slxkOb5HF6AM+ZI9XwxLtMRI9r5chySpW4U9Qq6GbGPli9Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39830400003)(376002)(136003)(346002)(451199015)(8936002)(110136005)(5660300002)(54906003)(186003)(36756003)(41300700001)(66476007)(4326008)(66556008)(316002)(8676002)(38100700002)(83380400001)(107886003)(6486002)(2616005)(6512007)(26005)(86362001)(478600001)(7416002)(66946007)(52116002)(6666004)(1076003)(38350700002)(6506007)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ri3SdvDbobbIrccMxz3BqqRJwg9QmjM8VOC2UvncxXHx0wJAyvgnAspivg+?=
 =?us-ascii?Q?jIWw2xxzBbNb3hko1p7WxXbEOo6eZYzRrAFQi5yUphBLmzZoxs6W7lyiQMVN?=
 =?us-ascii?Q?JqQMXNrfM6Xs+IejC4CQlMFZOlMgNyyI+AXqU88OiPGyYBvznkYPFKlaRFj1?=
 =?us-ascii?Q?1uXw/bUSs2Uuke6xxXGH9FG9ATUjUopQlritdlZiD84JqnR+dHG4dyQMClKI?=
 =?us-ascii?Q?sIFAjMUQrsXvQ1E1UNj8M/T1ytLtBTx/Bu8rPozPqsYCLfW9x6VaazE7shqA?=
 =?us-ascii?Q?miCcdMrMNkguFV+at2+2KgGxGaitlw78t/sNb8jlQfAbrKzajHED8Q4fdglo?=
 =?us-ascii?Q?287jRcvKQ4ufiaQ5kVSMJz7rg8dL/RPAATlckhIp/zBjMbyNfxzawCn4b42F?=
 =?us-ascii?Q?2nrCpzTWRFcEgGNWUbCvv7l3YIaMQjd4SDHYs1KRo66XhDV5FpBpPOm5iwI3?=
 =?us-ascii?Q?yiXsIEhVT13p3+maQgxgHaMEDIjOyK2aWlLbT5oqU249MAWYy7cPfLxqMsAd?=
 =?us-ascii?Q?jwQKO9M2i5y2AHH34MCgDartOXy/Y824MAQF2n8k2ubSzq/drwdqyYSnkCSw?=
 =?us-ascii?Q?HdN17YG8p1RC7uexv7HDG6ketuA/ku+6FV5/b7L7sULwoOe8RntANxRWu/0h?=
 =?us-ascii?Q?+ZkOAqBsSZnXhD96FzlunjVithXrE/toD6Z/9BP3Lsn3g/EpSa+JQSl4SPsO?=
 =?us-ascii?Q?xhKJbdCn622dKYsvuz+nXEnsVz1jCFtdGNYPNeZirQx2avEpYCWuWw9OvIe2?=
 =?us-ascii?Q?RiyI5Asjy5xXUqZGZ5UhkY8R1amLFUB3F1aSsiA6sGKBpBL0gMHPxZL8qFQh?=
 =?us-ascii?Q?UUvMI/O+l8YhtSqnmR6AyRebe0K9ruTCRs95syI0gy/wn47OK+nheDU2u572?=
 =?us-ascii?Q?SMrPHEHv/netrpYC8j4dxvOnT/oij3Kl88gHbf16LaiSsuPFX8DnDnxIzddH?=
 =?us-ascii?Q?OX9ZP2P+4m3mj2ShROV1/PxmxpdhLx/OPKBVTMTGJhScdkeBK/oIqpkd9Gp2?=
 =?us-ascii?Q?Q/tKhsNz610wB7z8VBjEGunWy+NqDA7eB9u6n1AsxV+dcmdEMs93UY/AjpdS?=
 =?us-ascii?Q?mcTj7WibxXO++kkSnd6JegqlKuBLEdYtkkRGE04XSPV2gFKvHcPQvBVlWhWs?=
 =?us-ascii?Q?ns31plxxjYuAxVDMnTIrVE21utbfgJiFRSvwLm2+k+1YUM0ceSE3MfOJPsh2?=
 =?us-ascii?Q?An9YftBKwrgeEQCtIQ9hXAcERmcH9HgT9GOlx6P/03nh0aWZrJxzzYu44oMW?=
 =?us-ascii?Q?fgUjqOjOTZaXof+4arj68H7cyJxjLALzXC9CUdUGVfkj682SNcQZ3Drz4S1L?=
 =?us-ascii?Q?7p1MNs76hjNHIDgecPTNXB01qtqWeNsTvC+f4iFXVmasb16cNYI6HcUsyDS8?=
 =?us-ascii?Q?2mgjkevCIeW855H5yCrDblGU7EX0BIIY1CZru7RjbvlrRTmQ2f9euswGExjZ?=
 =?us-ascii?Q?Tes5X0EG9QRGTUzsHtMpAsseuVk0A3zTRvJ/DJY5eE1zmoph0MGtQ7C3wCoR?=
 =?us-ascii?Q?BFKIwlaRAGnB/HYdjrwCZZnoAytlh6G7jtgiDBz8XbweMlDcoAjvuVWfvozb?=
 =?us-ascii?Q?IqI65EIYjR08sriCBiXM0Mn2bBg5px4tRypZP6rY+sLQkSh2f2gZLdG9YEMq?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b48161c-9a10-4a32-88fe-08dad2d81da6
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 13:38:07.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baUOSCdE/RE1yAAgjxEsJrk6y6ilNL4rdqSsTNvYduIptcdDS4yiqrHbpkD9ydSZxv1Ff6otgCK5KJD7hq8bgu6cWXqiw38Cr3RZh9yVCps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation on AC5 SoC that mmc controller
can't have DMA access over 2G memory, so use SDMA with
a bounce buffer. Swiotlb can't help because on arm64 arch
it reserves memblock's at the end of the memory.

Additionally set mask to 34 bit since on AC5 SoC RAM starts
at 0x2_00000000.

Co-developed-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   #1 Use SDMA with a bounce buffer instead of PIO.

 drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.h |  3 ++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..5f3db0425674 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -13,7 +13,9 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/ktime.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm.h>
@@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
 		return pltfm_host->clock;
 }
 
+static int xenon_set_dma_mask(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
+	struct device *dev = mmc_dev(mmc);
+
+	if (priv->hw_version == XENON_AC5) {
+		host->flags &= ~SDHCI_USE_64_BIT_DMA;
+
+		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
+	}
+
+	return sdhci_set_dma_mask(host);
+}
+
 static const struct sdhci_ops sdhci_xenon_ops = {
 	.voltage_switch		= xenon_voltage_switch,
 	.set_clock		= sdhci_set_clock,
@@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
 	.reset			= xenon_reset,
 	.set_uhs_signaling	= xenon_set_uhs_signaling,
 	.get_max_clock		= xenon_get_max_clock,
+	.set_dma_mask		= xenon_set_dma_mask,
 };
 
 static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
@@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
 	xenon_disable_sdhc(host, sdhc_id);
 }
 
+static int xenon_ac5_probe(struct sdhci_host *host)
+{
+	struct sysinfo si;
+
+	si_meminfo(&si);
+
+	if ((si.totalram * si.mem_unit) > SZ_2G)
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
+	return 0;
+}
+
 static int xenon_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->hw_version == XENON_AC5) {
+		err = xenon_ac5_probe(host);
+		if (err)
+			goto err_clk_axi;
+	}
+
 	err = mmc_of_parse(host->mmc);
 	if (err)
 		goto err_clk_axi;
@@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
 	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
 	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
+	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 3e9c6c908a79..0460d97aad26 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -57,7 +57,8 @@ enum xenon_variant {
 	XENON_A3700,
 	XENON_AP806,
 	XENON_AP807,
-	XENON_CP110
+	XENON_CP110,
+	XENON_AC5
 };
 
 struct xenon_priv {
-- 
2.25.1

