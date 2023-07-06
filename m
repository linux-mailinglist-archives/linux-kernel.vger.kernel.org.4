Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BFD749C21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGFMnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjGFMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:43:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9001BD2;
        Thu,  6 Jul 2023 05:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6/Kr1wDgrkct+pMDhN4EOKzI27/1Jvl+rpCxViUDjbLXvokucV0d7X6arG8bmEW7rLu58ib31v+pmefCMI21hVluiS//qIxJA8fby8FOmARxrp2t+ZT9B/Nx4OiEr6nbZ+d+Ez5FpZdXkLGQcfyxpzhq990zOkZZruiSHwRz8BjxjRf6JNykvBt8bSq3/+hlWn+toqmX/dABkX7UKDy8a4sCucaremIPFzfCfbLeSG1h1eMw5eESJDFD6FsQhl3mGhRNBXK/nBg9PGGjC9PSk21oHlylSgKhTfntirWBl54iinUi4u+ggdx9Mq5I70CZEo5SyC0cN14t0zflkUbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHSsH8SuT0tJu91niLrJMTc5mRQtnVDgNMHgs3qgiZA=;
 b=ec9DuaylIC/IthzK8EZo3x4gj8D4DsodIta4E2AAa0Di/LNfQlkDITZGNb85/3GvqTgKdpPWaYDPCyY3auw6oHfWj4oIj/xteoDE00cja2cXVhWkdaUM4wU9tkD8UuSUsycETybKzaIVCs4BUl0PpOjs8RkmubniPJRhr3cxRQzng8YtHt6cRVxkfTwb8Ylh6tmU8HRmYC7b2IL0dnsOvtfKxN9knd/K5/6cO9aNiC3dlWhD7OBTEUpMd272WQw4mWA+jAWZyviVelHpuMi3YEvd797OWjlWQ/JOp1pIOIodWCXV1NEuo6ZHh6QI8xiMic6GqvF/JFTtU9JQAmhdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHSsH8SuT0tJu91niLrJMTc5mRQtnVDgNMHgs3qgiZA=;
 b=LMiV41VIJXMim360RTxfhGZJCcnuDys2RJcWsKAqyr2CZjqALShm4wK4ot2TPuodQcEfgOzL+y/VPuRUl5HosP1XJR8BvNhf+Cb+3TvyAWPWtD1DoDDKn0ujmHrWqvSyPagt2VVOoIjASQ3iO1gWRQKtRxQ80D2MNUpNuXBGZ4hHY2fjc5aGW0yo0OmgmTAiIs4xQ1r2goOjEsDMR0Dc6XDNPKd81sZ2hijU84lRTMdyaEO+NxqngO2AR6p9TorpiVBvT67zWn8PbDecxmPCPMppnDfUR02qJk5g+POR9HRX3gP/ac9zuRRhxtI0tH67+JrkQU/ChykRVIM0sRYZbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:43:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:43:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] pata: imx: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:38 +0800
Message-Id: <20230706124239.23366-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d304469-1937-4ab7-01cc-08db7e1e8a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbI3y0uMC+huKDSdlw3Yf/z2Y0oXlcW5iPb2mG4AqcP0H0+Dc+3giCHUjpqfL4pddzRvVcBYhw4djhUz0WX04WVaFWnZiKmKQS15sHAXxv0NuXUGdFqLIdAqZFy2LEFyRT84DAw3DFgRtLO9eSgIGv8jWJjmbPG8q73w/jxgGzkfQlZkJ766n44aqU7umlbNTDzm8jd5LxdKYZjOq9CW1VvszDmcTnBlv6Ceco8ppiMO8UWuJpz8J49csoCsrpAl8CkYsTSTebL8RZg2lIfGy6hsJ30E7wgHiZe7Mv13PTa7mAxwukcws0Du7DL+CHnG3CVI7XDg/e+vB70QNxol91oyGwS5oPYN2lCVMj/34J2XoqId3yjPuzfMsB7wq34qD5/x8+2Lglaow/0+gNMMX179cfA11XfVF4DaRG7Fm0gyWZhdAwwL5kZRcw4OY6k9FJMjh5zzBRMHLl2McErBM1aRc3V99wZos/GE02zM9lGaT3bIe3KVA2iIZ7maQdklUn4W0PeVCm1HIUhaCD3IPGOgPETM7k+2rbfmE1k9/aMG7nfhWb3hS++QzHXFtZE0EPBOUB627y2uf344Pld08ldd7VU/vuyfF9EvCbMUW0f11QpYblUUu6GMMuHvXw8p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4744005)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(7416002)(2616005)(66476007)(38100700002)(66556008)(66946007)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(110136005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOCrDvjk4G6cmSNaak/SfhvOIUMA9OhZXgkhWFSnstCzujLfce28JHu6NUXg?=
 =?us-ascii?Q?ROvmeJ53UZRazk+Ih7ZT8HIQESWDeVLrk9tT2QdJgk7x3A8KDu82cOepNOHH?=
 =?us-ascii?Q?IZSXKFjf74ZxxiO5c6iGWMlGM/0EiaiYfAvoTesxGveIbkjl3c/LfdLIvLic?=
 =?us-ascii?Q?BvQmUgEFw1Ymve5WeWrT/K4a/hn0wJIuwGT6lYUmf/j0viiOcZVrYi/QCoTS?=
 =?us-ascii?Q?4NVayA6LDUSwJO9eRFDg/yb/4M0V+5eM3zXuT8MPZZMijp2TKgav+2zZQR24?=
 =?us-ascii?Q?czfZGCWdXE1LpdfgKf8MShPzsviX8mP+ltNCGrhGD+gjYDWdRCGO0dB26ZQX?=
 =?us-ascii?Q?VyfSHDr+RWacrZSCn9MbUi3v9/S5ny56zPgLBunvc22P3t882jLaJ69x6EvX?=
 =?us-ascii?Q?zeQ4aHdSHyzennkdAv44DBSsBtma1QvYvyPFH6mxpsbS4JW8y3b34ggmq6iP?=
 =?us-ascii?Q?6RKusbeJDKYDUCHu6AuweU88atbDkRtc/RB4qYNvNaRqMPad5I7zZ83j/aN+?=
 =?us-ascii?Q?BK1+PfVPmAvQptlgHdAagBzg7mMnW+rWu/Uq5/wz3cViG9vOF7BDKz/YVHzh?=
 =?us-ascii?Q?DbKQdQNtq4SvF8h4hq0WyvF0Rp1lrwnBcn+UlCarOPKjPnLD3nKZBU1hR41w?=
 =?us-ascii?Q?uAURvkQQWSH7+VoC/GjnaH8gRHqv2kVoZkSCrKK5EsewFrvPNP5GW378IUjO?=
 =?us-ascii?Q?QS19je9NG8DojG76M8JuZ3Y8xHIyCywGDlv8ow76bpISYUsNmRIYI43HUMX2?=
 =?us-ascii?Q?2V0S1iD4AABzr2s6/7vRllgoGaU7H7jUDh4LzuPsdqD/y0DB6Q9HP9uO6OnI?=
 =?us-ascii?Q?9XZzzHbtzcqeOnDmzXp3JJqpZpjWcR0UZC/6/TGDwej0cpzASZLqW/3oRkQ7?=
 =?us-ascii?Q?VLP31cuhSgslNk/grDhNBf0ERYeJx8Jl3dGzNgRfjq+zF/5exWAHkzg7ztoy?=
 =?us-ascii?Q?XpJZKbWKCzuM3GiMriZVbiYMxwsqTJAh+f43FZ/G8kGot1iaTF/xybMmFtTA?=
 =?us-ascii?Q?P6HwD57CJemyGD5KKfpV2q7z3/xa6DRyBLdYZEpH1HpWbc2X2/fHio4udYqi?=
 =?us-ascii?Q?asa1ey+W/AQ213Lge/Fi/Hf6KdHKPwJDid91YkgDzA3ZV0umgOssXo0eggal?=
 =?us-ascii?Q?l6MRqN0BeOgsY73w4RYZbCK5NFtUmJO9mmZERZrSyu4zPWinb8PG9KiivofD?=
 =?us-ascii?Q?uCMntxBsfOWpyEaGWcWSBINB4HYJi29rHwWAuBUbuADUdE5i3TG6MdhKlArV?=
 =?us-ascii?Q?ZfYX7cqmyq7qWFjhK92vE5htgeCTuux7BnHVVXHeTSYV1Xh9ebyFSuSRCQpa?=
 =?us-ascii?Q?6NroXjI8glOtBqvqaBTCpRhufMYqCGDvKkzPEpqtpnTDlwfKRFa7tJwhnkJ/?=
 =?us-ascii?Q?qUvgXulvsPiu+omn+OSOmt9K7MZRRsL0q3Znjj+P/zr/zRHJglH9U/Jo+AGQ?=
 =?us-ascii?Q?9VjrYdesYDWVnb+0RNfudtyubWXMVrwTTdceXfG6axm95/g5OngDJN4XX3Xe?=
 =?us-ascii?Q?HvF7Xo+udNc62rbm/N3G3pePILWPjg8O349sudj0bjaqkIwEo9DOqyscmq79?=
 =?us-ascii?Q?Kxn167mp6izytcrfjPVcksSrOGoE/OAhVgfW5bgB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d304469-1937-4ab7-01cc-08db7e1e8a1a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:43:03.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH/aLEKj2WugelEr1iGJddH5W9dg2dJ2/4idd6BnEj6Pp5STyrjcw0hza8AR6xeVomsld7zTWzonwQh+vVaC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/pata_imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 4013f28679a9..65d09ec94c12 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -164,8 +164,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
-	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->host_regs = devm_ioremap_resource(&pdev->dev, io_res);
+	priv->host_regs = devm_platform_get_and_ioremap_resource(pdev, 0, &io_res);
 	if (IS_ERR(priv->host_regs)) {
 		ret = PTR_ERR(priv->host_regs);
 		goto err;
-- 
2.39.0

