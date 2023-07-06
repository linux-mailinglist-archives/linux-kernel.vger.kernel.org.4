Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4C74942E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjGFD1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:27:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E061BC8;
        Wed,  5 Jul 2023 20:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqu1kaHTUYf9uoi0V/XtgsQOZ5YnbX8AxPmRAqI2MMy3NcMvo2yNbn8ld2rpzlUF4eXbpqcgRtSYDIJnIoKbbHqT6VFyz9aGHc8en9FFTVAeg2gj5WReL6EZIUcl0zCphwPJpaor65BoJJLwYMxl0Gj9EflRXyThhJFT1LX8aS83WGSmAApaR3NFMobPae1S207NgkGDEmR7BKKXpsrQRGlMPd3u/CL1PdN+J1Lkzh7/jZtR95Lb/jTZ6CBdsG+6Bd6oZxRpiRmMy0IJzBQR687O0D21sqDf11j/6UJR3iF8J8uz8DE/uENBjAd6y0UiQ0GKSLdBxD4GnKQuu7ifnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaDQ0vwX9HldvBjFoyHQr+L8pqJOBa4iWflW0cp9eJ0=;
 b=SrHDhD3W247cKwksO33+1zxEbmun+zcJvRIefiN5C3rEyId8C+je9trpn6lzZW0/tLQg2tqj2zduFjDL/go0b5s0JjVAoo57lZWb2GVBfKeFynpkFfbJiRk+haCQweY0/vAaMVJXI3qZ5klco7g56YeXjxe8KlnX0IExRWe+tCP8jh3ihtCw9XyNLfiUEv4F2XRDwcvbrn2QDzSWPwYN+aIiHipi+f0E1hK8Es/R/swjRPZDSkSyTF1aEvh8RH1thqXqwL9E/Flgs8HEqZxN3laKTk4mCSuwY12vQHAPEVLHc+iN57ko4EBCPE8jq+gHM4G9Dhz4tbxRwSFE20YSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaDQ0vwX9HldvBjFoyHQr+L8pqJOBa4iWflW0cp9eJ0=;
 b=KdCXvFKkNqPbhGxZ6QgE5nO3rjW6afe5K0xgpdQhhV9mgzab6XFuZiwkJxceXHmAHiy23yWtNRDLTGaLpASBWoO9cUqXd59yS3YqtdV6dINg2gQnDqI163NWuzLXg9W44FEkbAy0RLWsWA+82DuvVBa33MjrFAwq/WUGMnY4StrS5z2ZAcWe1hi8alHJxHrZbS0cCmHbvbJs6teH2+VuMmlGvLvjaSnqGHa1Co3QdwzDIn+IFvN/knwEDt+9a1UMszGBJoX5yHPImXVmxZrv/t7qTePFqp73aMH2pEjngNQpK/+3F81pvWzhtAxCl0k24/Leq9qySqOEN+Gy89EzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] spi: ep93xx: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:22 +0800
Message-Id: <20230706032727.9180-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5e0a72-85cb-4d1a-c718-08db7dd0f3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36AvyyM5WwQlWp9mu+pZSwZ6O/EVkySSnVkbkjWsAEyFH2OWcFS4BGrSf2ptIQxEEVq8YVEqbwMXXyZST7/34FHB7oY38mbYmRWQmVtsofUccXQDFvZlffwSUtcjHP32IH/yxrWcUP50fHRgeMlX5dLeeRweBimzRGzjJjYuKArJWQt7Fp3zgxNS2kJxcc4oROHEX5ypsPvaUmKUtjJVf4w8QM3fw67+wp74XUppDWK5fMEE4O//pbbzj9lv77X6GRAeCi16HFnVYzDBHNAOjAFQYSI/M0bUmWPQNAdkCHRmVUTrM+RI7LIO0cOJNbD5xnY+Mb/mvi4pI5COycsJPWXq/0S96IZb+TSVw0KjGkOYQa0TSUfpUI49OUNovKeiSdyXKbhtnUjsdnL8cCRbccOu9bPT4ey6iDl+tbGIpOu5w1augpJnFin2FWPN6mQLvmKBWYFdxNlot868/WsD6UpQEU50O4F/PU4IpNfRBjd/3qG36ha/ays4DYXZdb67WyL4VvGJaPm6m70kMj7Yvu09dr8+pb4v9FxKGMfs3cRYjVCl4XMCa1wxv/dU7vXPLYFJY5LAj7KoqCjEGWGmtKGBYgPnDQY6mCwTduhciCEOa3gO9nude1EzzTz8Dh5n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(478600001)(6512007)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(6916009)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXQt0U4/5HKv2KjNLv3N9icNx1vf30oZrvdfwaXgiG4h2mORu0dcsJLDtvfQ?=
 =?us-ascii?Q?+yv1D4Uo5nIgYTHfInswsvsO1B46uZfTiQE0knns0EanLq3Lhxq1RjFntAAp?=
 =?us-ascii?Q?BNxLY2zE1z5FfzW9qYcgYrQrFkZE9oQ3SRED6jlRcHpZ+LdXq4EljHNPhI5e?=
 =?us-ascii?Q?xLqnHC12Wm3jKq5dsONqLM00EpeTvHa1uiZSt8it2avTykNIgoL+Agmg8DV8?=
 =?us-ascii?Q?x80sNN6RW2WfvEzTNxSU7vLd/+K/dfMzS3YQDSFOj5Rwe+FMUgceqJv4C1j8?=
 =?us-ascii?Q?0EpA/TT4Q5PzSgGmZXIEdengU/Oo3GmvM42+MGLP5dZD5Dotsu6jtiRoyWHe?=
 =?us-ascii?Q?Z2YG3jdWa8ZvsdQPLj1SWaAw/2L5qRBX+IXyd6DKe+v2XhkPhfg8UDkfbCnD?=
 =?us-ascii?Q?MAAA6MHUd37eUFdWiNoMPW1YSwNJmAVtAoxr+ggpVJHrbGahnY042DezubaO?=
 =?us-ascii?Q?WnZ1bZ5A6ZGCEfpLs6br1kcQLrZYOO1sb79FqhuVinGGuvV4bmFvLl5ZTUGw?=
 =?us-ascii?Q?9NwKC2P4lUsKWmZSl3Bc940Q5G0y9eLTQYR+j9oESFdPPtr3jnZaFjeBwiOM?=
 =?us-ascii?Q?N7233zoqCzMp7LBXDO4RLRudc/yJDhvYiaB6aZrYQc7b4yoPaxqNNybcFFTf?=
 =?us-ascii?Q?2Jdsh0bijQDxc9KX0/ADdQ1DHDbKeI8kgM2jlbMk8MkcWwl7I8e+Rsne1Zzu?=
 =?us-ascii?Q?x/1lPZ0uuhT6Ao+EKixlCNdbVeAD7kW3CygrM0tb7eLNRZWWrX8/HTvlInMt?=
 =?us-ascii?Q?aU7qjRYiFwL7yUX6jhQVuXLA0MpWr8F0BrnCix66CYixukFyZBJhDUMbRfa7?=
 =?us-ascii?Q?MFG3V9xezzySwosCwWhOoW1B947KEgRqj+z+Nvo3RkgMQYmxRJABV58jYRl7?=
 =?us-ascii?Q?5RkdTfqhR65mpkUSkTNv5Bg3BduuavNtSfYsXX8QTmOgM6yGdUPsBehJob6+?=
 =?us-ascii?Q?/maigNtWl5PZsyNF44yxoDGAn9p0929uSWBoxWBbjXwHaxTxhriBwYPK5hr0?=
 =?us-ascii?Q?jdoU0h6rn+vdQSZgDJGgI71MwM+5QoFxHHwTvj9coSvC7loM1zLOv1HjwSsL?=
 =?us-ascii?Q?bZU+UcLBtzdjkk6KxzfPhwMGK46+Z2hxXu05UWMMUn0tGjzR84IVhLPcjb9u?=
 =?us-ascii?Q?t9o1iUN6NL4D0iFH+Yq3x86JhBZsJ0bUSHOmhjm09Q1GXAk5HX9RELKj84lb?=
 =?us-ascii?Q?8qG6wxnX/mSYJ8v5ILXw/SFkGUX3nzVr2CYp4u4itjwBI5AQUy/sFHdupE8L?=
 =?us-ascii?Q?33MgVqj6cFIQZU9TAq9PK3sYAicsJ9EbxuVk+2fcsrh3HtP5/cqMY33kcXfn?=
 =?us-ascii?Q?NbxZkf1tjPHfI5KgijyxDGyqNhIha9R7aRZhzN6HxLQ/JDFrR5xkFS8dtOqd?=
 =?us-ascii?Q?6F79MrPRlioidEN6ktSENlyBCuuEatrUlvOJMdHH5nPr2cBfxIt7zmpnIJaA?=
 =?us-ascii?Q?p9FCdl/1ULYQnPROjZGGDJ9Gctx9gfB63A0yjy7I+UdLVmwobM71V6vEO8Zh?=
 =?us-ascii?Q?UqoFdWrz5oCHbePUKwJwQt2CpbZGaURdrbfLre/7f/crebHyAmSvYAFf8yOb?=
 =?us-ascii?Q?UvljJK4SAQW4dVumU+IYx/2zMbBQmgy4khn00y4r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e0a72-85cb-4d1a-c718-08db7dd0f3fe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:40.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llBM/2anIc0zivl/W6MTdsjWdwHr/XhR3d+3z+jdIE0wPs14z4bS9xhXf/tNWRzPWLxhJxhsN93QIlNO5bPang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/spi/spi-ep93xx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 1615fd22f9a2..3693b3d425c7 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -661,13 +661,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "unable to get iomem resource\n");
-		return -ENODEV;
-	}
+		return irq;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*espi));
 	if (!master)
@@ -705,13 +699,12 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	master->max_speed_hz = clk_get_rate(espi->clk) / 2;
 	master->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
 
-	espi->sspdr_phys = res->start + SSPDR;
-
-	espi->mmio = devm_ioremap_resource(&pdev->dev, res);
+	espi->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(espi->mmio)) {
 		error = PTR_ERR(espi->mmio);
 		goto fail_release_master;
 	}
+	espi->sspdr_phys = res->start + SSPDR;
 
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
 				0, "ep93xx-spi", master);
-- 
2.39.0

