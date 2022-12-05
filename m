Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1A642715
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLELAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiLELAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:00:01 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2118.outbound.protection.outlook.com [40.107.241.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255019292;
        Mon,  5 Dec 2022 03:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic9l6lw6d7AQwrJoo4eELrx6h6ZuqczNDl79CU0hG2LWjsTZANClr9Ttl3/95rvG3xL8/pqevATnKwP7sek9fJyNKHTdlhAleWhHwVqJpUPtDnjIUsF4fD4OhELFCXBSwp/dbvMuNygG6KPbsOHMMBZbcE2WuOhsSe5Ub+KPBhF3DcXmkAh8kdLWswfDRuwDgklkfj6GGkCCVdxtLFU5dvgmCrFqATVYoH5netYuSKmK2oju9etr+2lpZ4YqDnKYM/Oz9dIgPm1yRe5ClfyCsQSStyy2Umf//YuZE0kslhytEHsb3N31aUmXvKKZyExRjL9SZk9pawN+dpCx86rQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuldcKvKeWXVmKDJ7yaKSDt9K0l06pHPOxoH4W4h1gY=;
 b=bvhoc3qJiEMTGROY8JWZDMtLA6HoQhGSp5sS5y/N1sAb3K+zja3g2e5mqAlQLGztXRrTZqfUtZ39jUywP0TG7SkvuSpBkmOmefilIoTG+h1vnyDxogMrTto/283jzAD7bfFhuo8BkXT3lZg+Zi4DVoYC/Ymz+04zeUOa0n6icOC5hpHN57SjTycOU+spX0gXy/sCdAYrkyDUYxmbX1KdNHb2tGDTQo4zikcGMQJrkul3I9tKy7N/xsXO2NiAJGFlSyshqioUQKPROolS6o44vpoUCRZu/zBXuvtnfRjNbb5UfM6DR4Iz9d6oBYLdr+g6GyWRjgX6+OOwb9n7HoEUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuldcKvKeWXVmKDJ7yaKSDt9K0l06pHPOxoH4W4h1gY=;
 b=dK2HoMVgHF4TMoT+Ar6hoxmcRHCYM4KeregMPWw8BCszlw5zD34heAkXB6IscnZcJnx5QWi0iTEkJkxrKquTeJ8RzFPoZOv32Ohwv8pDG+0M2pi1r5cR/b1OczhqJLhqh9kVpXzEaqnAcMf+lL6zYRWTKjW8CYrH+YWoOpIT5dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM8P190MB0980.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:59:51 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 10:59:51 +0000
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
Subject: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
Date:   Mon,  5 Dec 2022 12:59:30 +0200
Message-Id: <20221205105931.410686-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205105931.410686-1-vadym.kochan@plvision.eu>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM8P190MB0980:EE_
X-MS-Office365-Filtering-Correlation-Id: ba06d64a-842c-4ae7-6165-08dad6afd538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP99TKulsQ/XPm1R3zFFu8E4YHKtOx36NsL11kHm8R0yAeRRgxsfBhzHcfVeWkABqUk+PaHfLDirm5M180KAQ5qd5w14SwW0g//5n2FMqSTuKtK9fifxuwE1u0lSC6wD0R/Ob2mPZB5grvqKhj4W/PjXo+NwzMvKRXYY3Rh3XRJs8G9Xr0Kgc2YXr5LFdaXRyPA4yeWtEWnwyh+ZygEED2VG2E0Hwa3MQ6/E+rHRtjva0JOY6ng+kKXbjuUR9GK/LE6o/Tb0D3eMs3hc92vMmSoRrkEg7aaqzSYfz5+SxtZK4u06BKs6swY1S46lTGDE8kuCNsu7+rWuwem/+pzMLXiy8GDAav5XWqXsVwOOElFBe3NQjJurnplo3FXWAWIanPztnjZ/eQdftpzmXS5zxLeATpftB7RJPpPS5Y21Z5R70253Nxn0IsIsA8Boi4weYJebAGn15p6OViMUKdMUDhdD/bDFDEYRs8antR8GAn8wA8TKLVt5DzKwXctLauU22K+P0EsmlfxVhVdJGjaCorn8UNsWqCeLrUs1itIPvOObDMKnC4PO3z89DL7ywT4preCiWP3P9k5n7xOOQqIS1j3z77YAeqHzoNJ1st5OsUig51BEcMyJzJxqaCHHR+UjYYeEm39vJ3IXTzXHxQwTgyGmKVc2iCYemI+LVaHWHRy4e28gEPvcThEeNy+qwHdF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199015)(36756003)(38100700002)(86362001)(38350700002)(2906002)(41300700001)(8936002)(4326008)(44832011)(5660300002)(7416002)(83380400001)(66946007)(478600001)(6486002)(66476007)(66556008)(316002)(54906003)(2616005)(110136005)(8676002)(107886003)(1076003)(6666004)(52116002)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88ZUkP+/xJBFJYOQ1P5vFxypZv4Et7fu4X/DoRzua41khsaUYTR29PvpGqUE?=
 =?us-ascii?Q?Ox3Tn4dK2erCjVSRizUx1LQR/LgXfBF2NgEI8b/PmG4SSW8KEPkllg7s9lIC?=
 =?us-ascii?Q?QSuqkJzdZ3UOD0yPZtw+Et3nI8nS/MyOZyOYuLBLbT8WXbYhhsiMYG+ZC58n?=
 =?us-ascii?Q?z151jaZDsKuMfezEhNuaTr85N6leNYApyKoe2V2UB6v5JfzkthxJXyphDMT0?=
 =?us-ascii?Q?3/40jjZNVHnfhpMi2i2Wbtk1XvQb4f287IML2TrNc5SX2lS7vmMl9O0Rioz7?=
 =?us-ascii?Q?8/oAS8+DmEJ1049qBlEM7I/d9suTEi+gCxtzR+M2hKyqyhTDPusVB3JKzf1Z?=
 =?us-ascii?Q?h2TA1RhNQEeUrnK/uzcXjBi4C6z7kmYWYBtLn8kwiibtNjGfZILYa74cNsSL?=
 =?us-ascii?Q?Tc2H+JtVHuBe6yZg5cVAHjfCBoHR7kcSjkrts7KySFUWzYmI0X3wZoUHbMOP?=
 =?us-ascii?Q?KJ9+kP49q14X47a0wOHEUPMrIdnsNA8eRTMP54gGh2YJPn8Nq7hTFWfZSw4d?=
 =?us-ascii?Q?US1SsGgXP8wsyhKtCrDTIePyqOc06n8hdtFie0+EgWKvxJN8kOZ76OjtS3l5?=
 =?us-ascii?Q?AvxFNIsHqKY7Nmvmv5CvgH/Gy6i9lpFXlU7eYh4u2ZEsoxFkFZtht1TxR7Lc?=
 =?us-ascii?Q?KiLTnfMmttIv1HAJXo66X7stRuE25prfeO09LsktbJFWZtWqrMiu5PljeuCZ?=
 =?us-ascii?Q?Gn+en3Uy293GZcUmJhhVUGk5yjfc+R43lURIGXPeioXCA5c+EHGcaHOgRAum?=
 =?us-ascii?Q?nh+746mFzvq71lPEA0aTgWVebiGXhHelIfhwMXMans8JZpXymrtGTDd8tGCH?=
 =?us-ascii?Q?0qSyJndcJdhB+IYD3JAzbzuBMLHkyc9KHuvTN1PNcDOF/Ae3vJrZ/7MFWXx2?=
 =?us-ascii?Q?OIIA/NzOgnqocLt5d7USHVkn/lXQatihGy4glZMdqKWcttyuPzz+cUEhal7n?=
 =?us-ascii?Q?khVszXPGkcu4TOLOdF3VOgzSp8xOuZZzq7TiCnJ++PGAhkb0C8S/VIp/aC0w?=
 =?us-ascii?Q?XOO4HOMyTiLggQmv0cOPOLp5vJ0Fa2IHaw3z8lf+CwWDwVjPe0kyw4dwko4B?=
 =?us-ascii?Q?vTulrpapf7DSLamRD5W6K6MsmwAg9tAU+48fY9BB8IGmETfAB+pkyHhJMJU1?=
 =?us-ascii?Q?Luwb4l2Fy/jp0TySXoH5P15NcQ4b70tcsDrLei/2NLo1+tzmnEZUxOw2mFaS?=
 =?us-ascii?Q?wbxNwEV1Z+WVPw6yEStcVd/mCTN17Y3MTfxejhp7vOtEZBt33LTVNaEmQj3x?=
 =?us-ascii?Q?EfGNOFPbN298rnyETamPmXkOzeRmZ+Rn7/eFX3STjTsWV25EgcpFlcN7PpWi?=
 =?us-ascii?Q?ImfJyxMIgK1u9pow5Ss1hoeK+98DrTYjuFm0owVukSDTDuAk7+d3JhW7umpF?=
 =?us-ascii?Q?bW3oN6H67l1fmOvQIh6YGBEK9ECmWWUzbO1A9NPzjQEuH9647zJmppp0MVIB?=
 =?us-ascii?Q?clO571oW0jqrLdev6gRs+zIKEDbrOq3FHHvVCNqjCw4XipP32JRu6orVi5l2?=
 =?us-ascii?Q?kbLE4lvUcFXe1HgRuDKvewEdi4scPhhW2zUrRjDNk6cpfN0uRhS1K7EMm72l?=
 =?us-ascii?Q?o8tP20HLR/MMBTtjSiFPY0pFtdMGlYCpAldCPKJNzstNl97Y9DIvK8wB2v0H?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba06d64a-842c-4ae7-6165-08dad6afd538
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:59:51.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HiSZn03lR21RbbMBAfCkeErssuLgYO2ZzrCjIqmZh/DbMf1reaHU9i9F1DFqECxtB4Vs+wTAJLerXX2Ufc7anSYmhN/SCP3TlVDh1IKM3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0980
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

