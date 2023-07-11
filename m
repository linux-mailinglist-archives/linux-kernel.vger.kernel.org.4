Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922B74E57B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGKDtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKDtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:49:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463531BC;
        Mon, 10 Jul 2023 20:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQKeFfyQAokp2A5MD1Igfs932d2zzr52hHQWX0cwt6npVTUWzvZEhxs07Da2WPtAvWgx57JvGojBdQ7t4DWHyuuIMdybaCOXv4EkokjN0wfja36oUF0/LTvy7uSGqj6GZao6JT/ZGRF0I9WG8hqCJCznDSdo5rx2BH2X1W7KSEBBy+2dU5z3r5X7WYg+DhLJ5rTP3U8kmyhX8vV1ZZRcmL/6e4Gny3+PQ4QmTDARLuJWYBGxUzcCOA5PQki095x/s8mk7q2TikOq10JhDH0/csYABVvXnzkchJDFkz/V46SBNldq+q46hPfk+R+0my1Yhl4yR8/nrJDiKUVlGBnvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYZMZaULZaSNJm1d+jD+6WoxN7c1KwymooFZolcgcD8=;
 b=RPKCdTnMczii2f3/BVivt+5KlEKcRxi0q8h0Tnh2tpZ0UWkmPZdmq91l1YQx/RerE2W510tISE3BjkBSMo/2P72w87Rf18QKUNl1X/o1CYz/7Ryw3qsanewIAqr6cuKl1zx6AXgKyxmdTG1fO6vyBQvKQeekBKeNaTpLuX3bGbU8lsv4N9cN6niI7ZANt/Gw02ldmMvHbnopDa3ML3cZrbSjQtB6aCY8IGDwA0OzCShjNk+HhCA837BCMS0TYHha5Ye9RiMa0H/X2EClcmlbZTmBS0SFdJeH4A69cKZtr6hGU0cLnM0mkVFDFydc99awTigbtxoeZTElbou/Q4xG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYZMZaULZaSNJm1d+jD+6WoxN7c1KwymooFZolcgcD8=;
 b=EKQDZ3DpWdcCK9TeVdIPoDex2sSZecqOta4ZQ0Pca/FUJhNKq8cCem/j36X5/qzzn30/O9JaXuSo8nfurtlcO7lLblNTFyoXK9vN9XL5JciOi3rcGqRHId2SqCYV9FU83hDOgFWgE+yzjxznPJRy67ms5Xs2MLyqf0xz3KTs/QDVzZJ30/h8z54GBTA1QiyWmvIY401yeOaGB2dCGWgW688fPealVxtMcsDlbswzdtzrnqx/lThqeyjzFnZ6DG6gSQMM72FjzOkue6tdBxXtsb48LNPhtUelNHHbkZI+WK5/BpBsTaCpXoujTkgHV6TToCnRGkX3y4qEdGBs9r82ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4385.apcprd06.prod.outlook.com (2603:1096:820:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 03:49:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 03:49:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ASoC: ti: Convert to devm_platform_ioremap_resource_byname()
Date:   Tue, 11 Jul 2023 11:48:42 +0800
Message-Id: <20230711034846.69437-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711034846.69437-1-frank.li@vivo.com>
References: <20230711034846.69437-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f08620-1496-44db-8402-08db81c1c2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJGTuuwEvjq3TFm521NuXM5md9xUXvfglMkB4AmL53pM7Opyl31878ntLLcPgsYKh8k3+N3wHuW1MO11VLz2Re+/GXhV3G1X8HNJnKUlLnHh//gDPekyZ+aIQuKIDxak/ebQOWSOD9x4mADJww0yFAUkwSXfIO5BOJzuaEDjVWJQJaowuCxucg3r74gU3tRJ+sE8wlOp+PKcE/UEQ6hZyG5imBYX1YeHG15Wppt2qKzN6v+CdRyI5AidQBeVMONcsq23Jz3KJnTwDDSBmBQmSZbRpp15T3t3NaeKAzCUvllPDNxXaAVTLMATREpaDeQEJk6C20B+GAbP5Qvf2BOrVKYYUic0RpF6/1PzVSaYcheDUKRTvFMcD/0ziofvue9A/VLKNNs1cRMNaQ1C6JCDgJOOwqMReV3r2Jrdi8wNCjdYh5AhPC3YgT+3KCMDdEs5t7LKdwz7AcCdaN6hFhUk+7kWINtIlOpywX30ZgMWG1p1GuqvQCVN0Ge7juw1Nm6P+H93PlwNXrO9KTEwimxqgcHormhzordOqGZsLc1PgC82auKncw9JZ4uJAelpFI5P7fQqi6XbRro+bY+1qa03VGtAK3xSz9HOBf1+P8fEln03+NdUKNlg6FtvRjBKQ/7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(478600001)(4326008)(52116002)(6486002)(66476007)(6666004)(36756003)(66556008)(41300700001)(110136005)(316002)(66946007)(86362001)(6506007)(83380400001)(26005)(1076003)(2616005)(186003)(38350700002)(6512007)(38100700002)(2906002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/IjbmORQ4kgxDMbaM9DGIhuA9F7kGQpQrRMMZZbC8TNZRUy1GzucN0vppqE?=
 =?us-ascii?Q?Mq2ZqOm/78L+wuRYjml8QVwzYZtXfDSz+hKBTcbQWA52DBtbWx77bscpTJy5?=
 =?us-ascii?Q?Y5IoBFz634k3UJM2SzAtoZ/VSrngDqCMoiB41Lll7IgsdTz06B82jAJfAZ+Z?=
 =?us-ascii?Q?XFURag1TdHhjxrMcEMAvnHogEtnJm76kVi6gSrmnkJ9Ki9zAZfXhEC+Ff2Vn?=
 =?us-ascii?Q?TiGfzK+W/MJLx5UcMX4Yy0Hpntrsh9SEol3ag63fYr5plf1hQvkiQGWRu0rO?=
 =?us-ascii?Q?HLmRwISiMAAQqTGAqsw3qqoVrz2Wl5g0XjhCwqqjio66B8J24L7ztuxIqFHr?=
 =?us-ascii?Q?UMAGdoNm+3x6inrsKKyxJgXkmuMUfJECEPHPKhD+36lL7OqS6X4Yo5zs8NRJ?=
 =?us-ascii?Q?xDkans5TURhJo8mXjbVmRk92F0Ruj5GQX/HAYGuBp1ZqdavHtZTg0kKwrkLl?=
 =?us-ascii?Q?5JGLE/aOS1Bm7XbbSk/sp6NCqhNCowEkwwg7PoiH956RUk8p4Psqj/ZBxRXU?=
 =?us-ascii?Q?RQ6eIQXZEfJdcFy7HGjS3JQ1ufJZVe6h3VpfGKPlcslM2m8c5u24rBxlbEER?=
 =?us-ascii?Q?SAZCzQsvNu3p60w9ca9ESiePaTxuMLy79nTkQrZkIIJvmxD3UEpD5P+zVGyg?=
 =?us-ascii?Q?dq9Z62DoyyVQCJS1iScOqyYqcihUmTanMQMsc6mD9xmKTRHnUCsJvvErulQt?=
 =?us-ascii?Q?3P+7gMaC/J9rkwEQ3+oZHuglUoLosCP8mN6GB9Xi2dsAmNb1qW0gvB9YLiBz?=
 =?us-ascii?Q?a7DSLMQoizm+BQXhZl3IDqxJZT4VcmUfffe5PyizJdDp3FZ/5VejqCMj03mo?=
 =?us-ascii?Q?SnE0YCkOd3c9yO+V15GfJlJfIZPgchMesAsh63ZUrpjvo9PteLGCF7M+3DJT?=
 =?us-ascii?Q?EXA5grHdy9rpDarwbd8iRyT44kTD92YSTEgxsAxwId2Mq4l1eyuFSgRqr5Wp?=
 =?us-ascii?Q?7OMBVB9SAIbb7D56b7NiDvpxaSkiaiictJWBaEKdsdruzQH4iKHedoZrl8fc?=
 =?us-ascii?Q?/+I0SpwqPZ4HAr2wkedF5mG0ai8+VY1BXIRKp8ZLiJyd2BNYyxa/LsrwXpQr?=
 =?us-ascii?Q?sfhGi9kaSpK7rPTeHWNLEDj1hVi+RNSjL/J/A6O1DDMqB0LOZ51H3KAffrsP?=
 =?us-ascii?Q?W0MkftZrTS5ykx/QoGgiSD8UHdpKD3i9O5+sRW9Kz2ZS9OZ49uX7msN05ogo?=
 =?us-ascii?Q?8etP/v07fZT7d6+z+l5TGZSh5tFXnSW14kthBnVdgS3i+3x9+N1zKc9bl05b?=
 =?us-ascii?Q?LoOEOhHlFD64Pq3lOE/dmVen6y+AkVLphPcpWPQRWR10ZD2LRMEF7K75BgZW?=
 =?us-ascii?Q?aGjHNJ8UJv8kDE7F9ZgKIMRJ2RNIBrDa14xu8fuJvxOmMzVaCwPfZIkIq0gw?=
 =?us-ascii?Q?d4G7N/F0vtpEvp0QS4kvavZHeEExcEkaaRQccd0uDZYbRDMUb/bC8xIAS66b?=
 =?us-ascii?Q?1dZZvVS+fNMJRAjskNou/I7lviZ75E6CowzCAJ+YU2RjcVHy1RbSb3RzHiuS?=
 =?us-ascii?Q?/K40SsYSnLkQ1JUx4Q+PcL3hCK8UZEFqd8yT2d+YXnbRzXLSHHhnZy/MVtxn?=
 =?us-ascii?Q?Q07TIppJWkB0H8In43Rqov59KVerFa+/emQr8ibK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f08620-1496-44db-8402-08db81c1c2f3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:49:00.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE+AeSzT45cSx6uuD0/6oetZhSm2D6kQs3O2z66TRgrqfh3tQcko3i7C0fN7idAILsDEl032R7Np29kIGUfFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource_byname() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 sound/soc/ti/omap-dmic.c  | 4 +---
 sound/soc/ti/omap-mcpdm.c | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
index 825c70a443da..cb60af36dbc3 100644
--- a/sound/soc/ti/omap-dmic.c
+++ b/sound/soc/ti/omap-dmic.c
@@ -488,12 +488,10 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 
 	dmic->dma_data.filter_data = "up_link";
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	dmic->io_base = devm_ioremap_resource(&pdev->dev, res);
+	dmic->io_base = devm_platform_ioremap_resource_byname(pdev, "mpu");
 	if (IS_ERR(dmic->io_base))
 		return PTR_ERR(dmic->io_base);
 
-
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &omap_dmic_component,
 					      &omap_dmic_dai, 1);
diff --git a/sound/soc/ti/omap-mcpdm.c b/sound/soc/ti/omap-mcpdm.c
index 0b18a7bfd3fd..35deceb73427 100644
--- a/sound/soc/ti/omap-mcpdm.c
+++ b/sound/soc/ti/omap-mcpdm.c
@@ -563,8 +563,7 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	mcpdm->dma_data[0].filter_data = "dn_link";
 	mcpdm->dma_data[1].filter_data = "up_link";
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	mcpdm->io_base = devm_ioremap_resource(&pdev->dev, res);
+	mcpdm->io_base = devm_platform_ioremap_resource_byname(pdev, "mpu");
 	if (IS_ERR(mcpdm->io_base))
 		return PTR_ERR(mcpdm->io_base);
 
-- 
2.39.0

