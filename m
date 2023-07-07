Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50FC74A9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGGEHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjGGEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:07:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908421FE2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZM7Tc5hDkOT69Js88pxqOGaO3PEu3uDjBmaYdEULhFc4evpYOaa+nN/if20TwO9y7Z7oxpzw1KFDFm14Nt/U1+mjXGbey6Hpf16TbtohYQDqBgP3wRTWKxN/FFYU7tnxsc8dx050YghhH/Xp7adHDlf6Ikc35SkGfbsXmB3dpC0X3l0OPNb4VGjW6P/j6T8+PD/K1pBJ95s+f2pdv1+ZpXFWwnW5sHIzOuLV2U5QPEExh90YKNEIpA++l0G/odvAGFqHl58JDNeuSsQolLuRd5y1FLruBSx67CtG8witPNfoxzTOeoWf3q3L7C2l/0XddP7SbskWguCtbC/dPMNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XInITyQsNMj+hfMlycmip1bPjJnMPN5QO36XTxhOSb0=;
 b=PnC33IUE2EujqQSHR+5Jx8FxoYib1hvO/AtXdL+Sffj1v7nFUUGpaMIls+6v8JAJ2MQfmVk5Whh0isO2dh3n0mG4E+cW+Cyd7+94nwtH4Dw63uYP7Iw1s71Ob2zqE8S71RqLDGFm1hilRZ0YjD9jixvR0urKgsVQXW7NUfibw0XaMrAsrMsb87id5UyMcUyyoibZ0wKrYWP4v+VEP7r1vIDNZWi66fHf7wXckYFS/VvVD1SaA0QapseIauHBEnQJbEok6PLQK5eZPq1r46V0YuwH7O/jQe+gU4P60Hx/5Qvg5KsD0Cyh7vsCcDqm55KTgt81h/Jnds6H2JQiiSk9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XInITyQsNMj+hfMlycmip1bPjJnMPN5QO36XTxhOSb0=;
 b=ObyaVLvmSlVJk21tsxwsMcF0PDLmP8ybuWRmPgAR3XGfaa6QM4FB1kzJuMAfplIM6Xx32FlFHSh4YeuElps1DYSlDTnWKWTlvsbT7PvQj85NFWWifH/NHocJNNrZGcEHlCwkBEIpW+PXqps9XGFnt4JP592nyf/WpOso5umzWRNwK0FP+royF+1a5sb/l/N8A8C0muXhyD33BgCG3Au3Ux+TiRddETgV5N3CCbLxqmvsZHmXXVA3DH97C0FaWAIjunhZZDDR5TSMmhgVcHNmdwPtqa1hESK8e22BokU3eT0qYKP0ZjGlJ+nxh3IQMJ3VXBw0IoOevI4LQIpRXT4KMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] mtd: rawnand: davinci: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:13 +0800
Message-Id: <20230707040622.78174-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fb7b64-c487-4187-d4aa-08db7e9f971d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD2NlGasPM9NTUX0SMQUAbFkYkYpaNyz+BSgf9Rxhki2+f2tkGnbkE5wfh+ILBw3x5gsAHCSjkSDk5GRmsIUnfY6tyucfXa/fzff5LWR4uaHk0ci2t2Mq1DA87Uh7hVF9/o/pYzv43U/gMoK5f2d5xxOy7FDBn0l0P8+Bwb6tbkYMLlvURTRTA4o5Uf3Gm/+ZwbZycg9PWcd5faIfTmHzowQ3Y+zzQNxEV7uoZv+oUJTijFiSTEQPdK6A7cVMDbRmnquJlE+/yiZxpPQUZev28KIExCizuyn2SC8MzHSyObfWP/tR/8Q9ut7ux7981wPlcIwP3VH2N8MxJA7Quw6OeuRKZ/tC/qg0hjCQH3zfH2/vCc0svP2go5DxcYjO873vwM869Mog5EcJWhWOW8st0PB7r9uMESAabapo7gFtB+c7eLUM4sbrobhLpbOH2mrcthpuDEc3qtUp8IXIsSS0DWUNUjoyjeDazDJPHtyJREq1vF/ojsf33eq/NX3qNLnU1IhDAgKdlIGoVdzQNvFJn8MTHEVZVoke910042W7tkjT5PkiDdMSpjwWVJrZ3phCc9+G+/kJ9XJM83IsVmm8WonA0rVl2+/z5mAzZss5S/kKN0vNlXNxApWH92OrUO8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gii6EgFVwVGiqwDhZ25MD5k2tnKOyvYLInN1ej+3tlUv6LfELkUqdnkgki+k?=
 =?us-ascii?Q?aXOFA8YnVV/SSdncBn4Je09iSNZfWv+6Z8hg/RwEa6x+XzUBpDT/YCZ2OThd?=
 =?us-ascii?Q?8tsuiCt2FhBOw2vocN/tLl/FPnapEyt8QkqTiCtL/huU7WqQVHVLMR/Xkjrp?=
 =?us-ascii?Q?Lh7bFmAbIHa14ePytHKo6tpWn8CrqnXmk5wg+f2scdDVpLXkCj3QZpdComcz?=
 =?us-ascii?Q?MEKA54Clm0Ahb9cxqUFBK8epMqHKSpCR5ad+RJ75CpmOlAZVzlBc7Yn5UuNq?=
 =?us-ascii?Q?IaCySzCbwnrOcHMP1vj1hDe/4inQlYw8xqa1XCekZ+ZsQtR+6EE6mYx/dpPt?=
 =?us-ascii?Q?EwuPoKXEDf69N6N2SGU3oNoS6VHAOPdws/hL6JZS901rTadQH7eP1LcHG3Jf?=
 =?us-ascii?Q?JC9meltBzi7V+hYvmsBU/dRlaQR9I9t2cgPFIA+EhLr4Qm6db46ZXK4uWZ5I?=
 =?us-ascii?Q?1Wztb4RVba6r6OwXYPz+zKmrFMLeL82N+lRehAJHmT/KkyJ7dIMrti9DC7iw?=
 =?us-ascii?Q?ST7uX3C9/0Qy235dIN1T1RgBM4C0nT/ybtWeCHcK4pvt+sDug5jHz9kaflei?=
 =?us-ascii?Q?TlEAjQjmRpp7nvyuRamqdcTyTZBIxu6GDC2I4kXNRQ8VtionWl2nqcmPXRoc?=
 =?us-ascii?Q?iQU01cIWsJddcHHtC2U6Mmx/N/LHzQpSyfagm3uoGZbR9HHzwnxEr2D6skAT?=
 =?us-ascii?Q?yt/vxzwpCCDIySoa/mPns5KaouFv6YJDa0w8c9wIcX75mAx60qOEiChANiTU?=
 =?us-ascii?Q?d+moCGDZonlrYEj6riUCyPUEwQeXZyIsCMF9edInvm2BflkbH/G9wLlOm1WZ?=
 =?us-ascii?Q?9yj+VS3Bc3O6K9bQZKxlrWWZps/b8lc3FYGlXw5R33a2gB8QOsplWk0dMOdu?=
 =?us-ascii?Q?krk66pyK0wr0qx+tPhev2wMwzf07MA5dbIio/0TesTQERx5g1DLh/1moUGhy?=
 =?us-ascii?Q?wHyI6/KyP1h1AijPtBRIOW5FHZujLWAVS3ysTICZ1TIZEtK+NAlK63KSiOcd?=
 =?us-ascii?Q?A+4HJO9vvixmCKhRgDI2enHSx4qi0hLxlYnhEoo/+2r4HomPdYsjjGKjysPo?=
 =?us-ascii?Q?stA6hyNI4fhwv5N22GkiV0fHJDI2dmSh14xWnqHc6vXUT5iBHNo8GH0pfJ95?=
 =?us-ascii?Q?k38JvSe+14UF5eD9/tM+nYyDzkMfWSvgOBHDmgA58lAB/Sl59SmmTNL427ei?=
 =?us-ascii?Q?Zq/Oc7nDfbItl2sfvjGO7vc1Xx/aOPOzv9S0n2b5+2raxIxqnKJkFL3Z97te?=
 =?us-ascii?Q?5vWal+b9budPfa1c8wRqzF6hJIgbKtBmAwjUlelJvjawAHmvsqlgXlaufbLk?=
 =?us-ascii?Q?G0ZEIIO3Txcn2mCQCCySlaJNtVm4QOXybj/4Ti8Y+5XXXwl5SwquVOMtXRnj?=
 =?us-ascii?Q?yOIOVbtmY6Nlyae+QdbNF+0dU5ytoT4wKvykZVt1VN+AkCIfXDgiEhEFq5ZK?=
 =?us-ascii?Q?RJiCU2f9BYlgV/lc3peVN71oQS+vcFpdFmhYM/1V8Zt3vgTFikBlUqk4U4vk?=
 =?us-ascii?Q?F7Zmq7+2bx+QLDz2inEKE/DhfLSPO/wtGoHViXJc9gugW6z7Pupfnu4rCYW0?=
 =?us-ascii?Q?scYq1KZFrrOy/Zheduph/GNwgTWsjlFBlv/6zgLv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb7b64-c487-4187-d4aa-08db7e9f971d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:50.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 282XpQA4IWoYnJxmCtXNNruJtMKRdMp8sKzYA80b71RqmUxyjFbdRULCSURqL+1so8+tW67chIWqyptzcTnmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 415d6aaa8255..2db1cd1d3d03 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -710,8 +710,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
 	struct davinci_nand_info	*info;
-	struct resource			*res1;
-	struct resource			*res2;
+	struct resource			*res;
 	void __iomem			*vaddr;
 	void __iomem			*base;
 	int				ret;
@@ -736,26 +735,24 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
-	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res1 || !res2) {
-		dev_err(&pdev->dev, "resource missing\n");
-		return -EINVAL;
-	}
-
-	vaddr = devm_ioremap_resource(&pdev->dev, res1);
+	vaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "resource missing\n");
+		return -EINVAL;
+	}
 	/*
 	 * This registers range is used to setup NAND settings. In case with
 	 * TI AEMIF driver, the same memory address range is requested already
 	 * by AEMIF, so we cannot request it twice, just ioremap.
 	 * The AEMIF and NAND drivers not use the same registers in this range.
 	 */
-	base = devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
+		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);
 		return -EADDRNOTAVAIL;
 	}
 
-- 
2.39.0

