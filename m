Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7F736B54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFTLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjFTLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:45:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2018.outbound.protection.outlook.com [40.92.98.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE61A1;
        Tue, 20 Jun 2023 04:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLc8gb8WTE0RMneu4C+ZshVddN83f6Jpazh6RrzaLFvTkYUYZVJPfWPOjaQGjkIe8nC1cAd4cBBXUOtzrN6DQ6Q46SxhmAwYGG5+IR8iQn+CPVF8Nit483LrSkezJMRujWtjc6B1BOwlc0hZW4oJusEvkdu43orewzLcJJBhA+UXqJykXz5fjLQRjmYTAx4w5YEiUTMoPsqxnLsixvri7osTgVQcv+6iCeejjTap1XV72nXjn3B/WI4Qsc5vvRGEs+gOg/eE0yAri412D6UeuTC1N3bBptatjcnvfj8lAFOKyWANnYc82D3aYppXa+j4yIKL5j5OXjXFnusVDd4sXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV37eynbgOh2zhgBwQJqkX5VSW7V4FWNpN5vP9hUkKE=;
 b=FOv1kFiHlzrq1D8qu5MnE2Ooc11hOuJiJMuv83zmbML4CbjtoBprR2H1EOgCaYAjbplHp4N7hFDSkpIRv8eDIhgmVsqywrnQxVe7qYZYEDNJ1n4P1xo9UU6OSvO9tNdp+nzwp2j1s62A5+haUFdp8eWMJJzShruV46fdsBtMuurUG6tlbq4bhh1xt/Upl6oqsHwlKqyNMxQhBa+zo97JN+0ct2/ZcTgBGHwzF1Mxfr3NS464zmpvGTG+v0xBtcAF9nbc5qoimKwdUJYvxfVXw7eh9rPBEx4EmZ5D/CDcgODQOJ0CoqK2TnWpZ4jxk0OhxIoZ2MiyXpJQWYFNUfLATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV37eynbgOh2zhgBwQJqkX5VSW7V4FWNpN5vP9hUkKE=;
 b=NJ+YlLEghji3JHfHuh60KJgD0nWZXHUDK+7ElMy7igvlrPeHmLQgX1qhXdaLsC8TPcKq2bJg83SUo/ZQ2VGjdapT6Oxj6WNzaclBLFAvk1R8ZEXjzwVUtxvzhS1GSHqzGi4RgWSTYAJUwzyxiZDD97mVHYIEgL/FB/GxI8OOoGd262PnzVVQdEVTvitXvdvbMH+ngv0q1npuigZCn48Y3H44CuVRPZyzxbbgYWUcMZHCjr+xMmD1P4LfoIGNqx3tJJJYYohWeQ6ymTqNeEW5qUm2Z0KeMIL5+XCpLTkiGoc+6Gw+ZlKdX8+PxmCtVUIIkL1EZSbaFRATPn9bc9ugmQ==
Received: from OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:93::10)
 by TYCP286MB3637.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 11:45:08 +0000
Received: from OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4879:5bc2:d533:bc74]) by OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4879:5bc2:d533:bc74%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 11:45:08 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-mips@vger.kernel.org
Cc:     john@phrozen.org, tsbogend@alpha.franken.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: ralink: introduce commonly used remap node function
Date:   Tue, 20 Jun 2023 19:44:32 +0800
Message-ID: <OSYP286MB03120BABB25900E113ED42B7BC5CA@OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [IyIKZIgB8jPUAtxzIfKy7HeEHoq3djEV]
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:93::10)
X-Microsoft-Original-Message-ID: <20230620114432.7596-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSYP286MB0312:EE_|TYCP286MB3637:EE_
X-MS-Office365-Filtering-Correlation-Id: bce8aa2e-ed4f-4229-ebcf-08db7183cc1b
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DcenbC5w/UaZkbuHE2qqzIU3x+wRiMY4EpUeNYayPHFF+pJv7eAhdOK6Ywhj5fNX42hNbkZBR4H+6e+R2NuBiswsM30KaZAYjL04JUXmnnIzEzZI1C03N6lyLEN3M0I3lzyC9KF48cD0mA8c1kv2hewoNh/PXmcv5r6s8jSTmnTmBGw7TxYa+lyY0yuaRW6Nh+dLED0tq9Mo0RzFU+CeU/zLq+hRSeAVwurwXbNHxwF6O3JeA1g8XBQsbJlbjs+tUPtSRJ/MfSpcz/FUNmcs2Qt7FwlCiVVIpgZsBS7ntCBAT2xThkCWi0vqA3Cus83Qagzv7OTSzsJo+a0B7Nw3FwH6nzToRYBbbDlEF8cPIQTUgWXQDZM4MXvlo+VW89NaMnSuvMD55V4tSGkOmkZpCvMt6oYlDcksj8BjlRra/xLS5YBKQ2zdi/CYt/pi7xx0xL5HBzke/0GOp3z5ys0gf2lZXVB3YjHy/OtM68CdnvJe0rK84LBKl6U+gY5Mp4EGNEX32eZkbdb9S05F/FPx3Tv7DBJkbHJFeEd1UbFkevBD7wuyTtCBfJgUZoFXVD+7bUblpezdPXR67sZwf39Y7p6DVsKK8FIWJjeLF4+QVpFTzn1GXQJ4Wci8v1BwkOxEiNJHZorQSaoPFl0KFoevS/Db+6GPaoPebeoUDc/kOzcRCShrJ9WbhNXOIOQle8N8yfeIkFTnxrwuDZnn3cN/fc0AuLlxWG42ZPRDZuU1m6B7+whXgODw6+I
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+INi04W6/V0DJIwpTpXStqd8gKlfhUuMldLq2UzUNhIc6DOy5W2IaRZeB0u9M80gQkkHS5v6V/c24UO5ePhKLIG/1uoYtt8LUs9qT5cBPXyGlReWctpNGDfIzT5vNCiKhA/4Myq0aOM1Xm795SYizM3tsBJw5t6rWtYDpn2Wl3cc3oOf6ZOvUo2W5wPc58rMYkzHsZf7ODqaJJ30rClbr1vNb7robEMZAEpdtk6nGzMmgF9xm24lj8aGUydDmZSeN/NMCmXZm3QBAZeLYExfFDYj1jEVgZlSGVmqenVdHs6I0qbQwRn1Lk4xFa6ozQUWUV7L16/X0Y4+AuPyq2ozSzPPOAdAe/SghgBGsHkMGJNK74He/aVsmuPQ6y4m9fs6GryQL5tPgbbD+WhuP6WNlkq4cfm7Z1tNu3WWhksrKMKx7oNDoKpBWBqZL1wA0xgTkknT6O6uuyh88VOAr+nUrudTBR4GZIO+Jf6r9bZPOyGYp7fk11a3rQJw85CR8C+g9zYUp8am5Hj3Vn8uk6wyo1c/SsgIudysVVB9rFR9o3Jtt21xqVtSBI3hLsu04SQGFNwrWBBwnCbkWnbl2WFQT8PQHHZYuat35FUNjc1FdQev8EcczHWIx6besZzFH9y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3QLNbLyVbaKZxuGhXlHjXm6UERgfDoNiMglyCuVzuY+Hm0Yu1vHVIwBW8xr?=
 =?us-ascii?Q?GO1/M+xuo+8ySYptLgNfraZSRzuAy3HMTxDrzQJdGLBxIcoozVN/ApbkUgAE?=
 =?us-ascii?Q?ejEGnMsi0sQXld5m+/i0pfhzMhudElgzmAG05G5lACSk1kWUZm+38MNTnX0M?=
 =?us-ascii?Q?x5V8nS47IXYdqwlUcdMzHuMe+Ehbd0LCxq5d0KZwpt9JNPIvPTs0exVggU2D?=
 =?us-ascii?Q?rB0C7nfUFmYcfp6Yn22Rf25pmcHInckgTvn6LT8vMhe637FMcpOFb7GHe4HT?=
 =?us-ascii?Q?l3YjkBTUxyAOZvie7rSFi42k+RjfzNxMw+PppZDRsNPcJKyLqhMkMU6m8ifD?=
 =?us-ascii?Q?IBX32pBn5zcd6GSc5KooFixpjXeL5xW5mGXWI4S+QE+BWMOXkWSFFVvH6a+x?=
 =?us-ascii?Q?7sJo7pjOr2tWHl/nhTnnyELNXCfjzfKtOmLmrCMCGBW3I2Gv7sNt2X9M2+dA?=
 =?us-ascii?Q?VHn5taIGNaHLkBotAPf+wHlePXAzWIKksW5kvGnlIRpEaEJ7Q1dIdpHUFGci?=
 =?us-ascii?Q?RCsgmu/ZZ7kwoxLv8G7lykZ4Uuwn8/DWp3LB295iOmPSWqR9m7uIaw5UOdjb?=
 =?us-ascii?Q?Uu3cIINKozrmHBFp7PLGGP4BR/TVLbryDL7O2gaJTVNe+aGAkheuV6wgEfxp?=
 =?us-ascii?Q?vQJnaNj8UrXyfOm8wiXLSt+uJiv1sPkOoRvPijlIe2NzbTU9+9HwF0dl8Jd2?=
 =?us-ascii?Q?+NKgu/LbATRNczK4rOJb0n4sfdp6nxQnYL/yeHmdgUzbewWldLPlz3sIR5j5?=
 =?us-ascii?Q?ciHbTBL+zVJ9+aWUCqZMDw05VBG0GA7fvduzgsL1PpViqvvST5C9Yx3PBpO0?=
 =?us-ascii?Q?NcOU+IgwR079JiRcF3oLM1nsm3OoDoM4IrTnyp+y50MgvRqidRFU7Hnt63b7?=
 =?us-ascii?Q?CKSR2PUv/GPU7xm3zJLaqdaitSf2ui4MlZPDvljCvuEDYdZPXAdVFXv0P4eh?=
 =?us-ascii?Q?k2WfPcN82M9s+DVIgjGK7nS4v/KziqA59rjrfYBRwOCAHRGN27/fj/bsKDEY?=
 =?us-ascii?Q?noc6iV39hOzErD5dm+5+5veyYGhSfiHZ8b9+YJw+B4LNVQRYPiD81iNsYusn?=
 =?us-ascii?Q?ZxCQ9Hd6XTQoxMAJDoap9fjvXERv2K5aex/GSlhIyJdKjt2ufz0RpfIcVrrf?=
 =?us-ascii?Q?0OChdFaLLDpFpHOeo8n1DmKgu91IudeJJk6cqvY/wttwryGqn6Yo8a0tZWUD?=
 =?us-ascii?Q?N9qZu7LH5+pTL0P0Jpflb8q+YfUK3uoiXjzqzdtE+2eLI6R28wa22VyWNDw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce8aa2e-ed4f-4229-ebcf-08db7183cc1b
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 11:45:08.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3637
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ralink_of_remap() function is repeated several times on SoC specific
source files. They have the same structure, but just differ in compatible
strings. In order to make commonly use of these codes, this patch
introduces a newly designed mtmips_of_remap_node() function to match and
remap all supported system controller and memory controller nodes.

Build and run tested on MT7620 and MT7628.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/ralink/common.h |  2 --
 arch/mips/ralink/mt7620.c |  9 ---------
 arch/mips/ralink/mt7621.c |  9 ---------
 arch/mips/ralink/of.c     | 42 ++++++++++++++++++++++++++++++++-------
 arch/mips/ralink/rt288x.c |  9 ---------
 arch/mips/ralink/rt305x.c |  9 ---------
 arch/mips/ralink/rt3883.c |  9 ---------
 7 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 87fc16751..e56f9a3e7 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -30,6 +30,4 @@ extern void ralink_rst_init(void);
 
 extern void __init prom_soc_init(struct ralink_soc_info *soc_info);
 
-__iomem void *plat_of_remap_node(const char *node);
-
 #endif /* _RALINK_COMMON_H__ */
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 4435f50b8..2c60e8df5 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -273,15 +273,6 @@ void __init ralink_clk_init(void)
 	}
 }
 
-void __init ralink_of_remap(void)
-{
-	rt_sysc_membase = plat_of_remap_node("ralink,mt7620a-sysc");
-	rt_memc_membase = plat_of_remap_node("ralink,mt7620a-memc");
-
-	if (!rt_sysc_membase || !rt_memc_membase)
-		panic("Failed to remap core resources");
-}
-
 static __init void
 mt7620_dram_init(struct ralink_soc_info *soc_info)
 {
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index c3fbab50b..137781d0b 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -89,15 +89,6 @@ static void __init mt7621_memory_detect(void)
 	memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
 }
 
-void __init ralink_of_remap(void)
-{
-	rt_sysc_membase = plat_of_remap_node("mediatek,mt7621-sysc");
-	rt_memc_membase = plat_of_remap_node("mediatek,mt7621-memc");
-
-	if (!rt_sysc_membase || !rt_memc_membase)
-		panic("Failed to remap core resources");
-}
-
 static unsigned int __init mt7621_get_soc_name0(void)
 {
 	return __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME0);
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 4d06de77d..53a2ae9ee 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -29,28 +29,56 @@ __iomem void *rt_sysc_membase;
 __iomem void *rt_memc_membase;
 EXPORT_SYMBOL_GPL(rt_sysc_membase);
 
-__iomem void *plat_of_remap_node(const char *node)
+static const struct of_device_id mtmips_memc_match[] = {
+	{ .compatible = "mediatek,mt7621-memc" },
+	{ .compatible = "ralink,mt7620a-memc" },
+	{ .compatible = "ralink,rt2880-memc" },
+	{ .compatible = "ralink,rt3050-memc" },
+	{ .compatible = "ralink,rt3883-memc" },
+	{}
+};
+
+static const struct of_device_id mtmips_sysc_match[] = {
+	{ .compatible = "mediatek,mt7621-sysc" },
+	{ .compatible = "ralink,mt7620a-sysc" },
+	{ .compatible = "ralink,rt2880-sysc" },
+	{ .compatible = "ralink,rt3050-sysc" },
+	{ .compatible = "ralink,rt3883-sysc" },
+	{}
+};
+
+static __iomem void *
+mtmips_of_remap_node(const struct of_device_id *match, const char *type)
 {
 	struct resource res;
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, node);
+	np = of_find_matching_node(NULL, match);
 	if (!np)
-		panic("Failed to find %s node", node);
+		panic("Failed to find %s controller node", type);
 
 	if (of_address_to_resource(np, 0, &res))
-		panic("Failed to get resource for %s", node);
-
-	of_node_put(np);
+		panic("Failed to get resource for %s node", np->name);
 
 	if (!request_mem_region(res.start,
 				resource_size(&res),
 				res.name))
-		panic("Failed to request resources for %s", node);
+		panic("Failed to request resources for %s node", np->name);
+
+	of_node_put(np);
 
 	return ioremap(res.start, resource_size(&res));
 }
 
+void __init ralink_of_remap(void)
+{
+	rt_sysc_membase = mtmips_of_remap_node(mtmips_sysc_match, "system");
+	rt_memc_membase = mtmips_of_remap_node(mtmips_memc_match, "memory");
+
+	if (!rt_sysc_membase || !rt_memc_membase)
+		panic("Failed to remap core resources");
+}
+
 void __init plat_mem_setup(void)
 {
 	void *dtb;
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 456ba0b25..ed1d13251 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -52,15 +52,6 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("480000.wmac", wmac_rate);
 }
 
-void __init ralink_of_remap(void)
-{
-	rt_sysc_membase = plat_of_remap_node("ralink,rt2880-sysc");
-	rt_memc_membase = plat_of_remap_node("ralink,rt2880-memc");
-
-	if (!rt_sysc_membase || !rt_memc_membase)
-		panic("Failed to remap core resources");
-}
-
 static unsigned int __init rt2880_get_soc_name0(void)
 {
 	return __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME0);
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index d8dcc5cc6..d3b842883 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -134,15 +134,6 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10180000.wmac", wmac_rate);
 }
 
-void __init ralink_of_remap(void)
-{
-	rt_sysc_membase = plat_of_remap_node("ralink,rt3050-sysc");
-	rt_memc_membase = plat_of_remap_node("ralink,rt3050-memc");
-
-	if (!rt_sysc_membase || !rt_memc_membase)
-		panic("Failed to remap core resources");
-}
-
 static unsigned int __init rt305x_get_soc_name0(void)
 {
 	return __raw_readl(RT305X_SYSC_BASE + SYSC_REG_CHIP_NAME0);
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index cca887af3..f2fcec1d3 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -65,15 +65,6 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10180000.wmac", 40000000);
 }
 
-void __init ralink_of_remap(void)
-{
-	rt_sysc_membase = plat_of_remap_node("ralink,rt3883-sysc");
-	rt_memc_membase = plat_of_remap_node("ralink,rt3883-memc");
-
-	if (!rt_sysc_membase || !rt_memc_membase)
-		panic("Failed to remap core resources");
-}
-
 static unsigned int __init rt3883_get_soc_name0(void)
 {
 	return __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID0_3);
-- 
2.30.2

