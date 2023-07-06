Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8474943A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjGFD2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjGFD20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:28:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF641FE0;
        Wed,  5 Jul 2023 20:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4FM8NrT1b8a7/OFTkzbZlFQ2bdSddtX+YWOdpXd/8+atYANPFkcX3e9lqSL6jGRsFxtMntcfLDABECmSEjmxCmcB92GIGMaDh01K9V/tUCGZkClZRmtWl8RUOoEZo9vjbHbNSweV2ZD0IVyIlSBmpTuYFjwUDfMfUP1Ub9YG0uzE9GfzBp15y0NhWmMzl4aJPxpZiH0a1hTobivlrUgCLwftIXgqlIwk/dkOh38N668obpEgSBJfsJkm5z063y6L2gxlY9GSCfSxfo+RaPxtoeC5lfJSN3N7yqjaE9QOQ0H3Dscq4n/vQRQmslk3+eYSiTIcAvZGQH3p9q7AMnBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpEhsLAKRGIJgSocqGoL0oTWylJP/5TecRrwzNrP1rY=;
 b=mepAR2MgxZM/wzjmi1Ui3KKNcN40C7FVGJ033oBuluhmjEjrCuQh2wbyZHp7aQfLLjEy1Xrcs3cuVo24uUiECfRuzfs2vNvpEL+jWpWF16P6DRKc91TbUJ1iINGBxaXKrbWhLjhD2rdFssS+0WoQfDJPac/TP1YwVL2boKrIkFlfffwNNrUp5vHytgQObDknxGfMZ7iReyk7E26dGOumZWyhb/5uugqs4PDslkyh3huGQvG3uq3WicpZFiNVteuU2FS1GTbCfotpMfNHx7KMnFAsLRHvkpx0lbib/jsdFduJ2VPsuwZqx/gpJFQUwRJK8Ljc5vKoHiDalEeYkErm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpEhsLAKRGIJgSocqGoL0oTWylJP/5TecRrwzNrP1rY=;
 b=mhMkf8eyBl0erdPdLuWU8G4QhhVwpCtrT0Qf4tClRuHxcbprvDqIua7JHvA+cnIE+WrqaoOSTPSFzFlaCwh71jjbwTzHuBCU4V1aBQB+xydDqaZsrDS5okLsRxLeA3CtHfMYPx7hYGleFZmtjdx3ajoE5Ty9I1H1FBECkNKqJWyzwMbUDNw9eVjzfOHBv4y8zVEYoQtEkXCbI1HHHydtSro0X4lrlivsXNPDAemBfqpuwi8IzZYYMkf4m7OK0GoXLpRmhQFd8am6vJDHXQlX5lTz5zE/Cv2vXqoiLR4slZFpJ1kzmZ+kqmh7lVH04dHHUMzY3BMgSJVY3k1g0MJgxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5043.apcprd06.prod.outlook.com (2603:1096:4:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] spi: s3c64xx: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:26 +0800
Message-Id: <20230706032727.9180-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3ce505-4152-4019-1c45-08db7dd0f89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQ2m535yG0Yi0PIIefDI/ixhHso/3GI84srYCHS8nq5o3uc3piRNn8YBEpKIXWXAYMLdIDaBQn26nHeVrh0Wc8nOQtcYBkI8rRTmj836ofDrs2cwmSPgfN1d6AhKZ0e7KcUVMaMTEkaEeHTQGi4bjSRKmMkX47X8URSCE9zt0wkkqCnPLbHJGyU0covoqrEDNmWBC6fgX3T3FGX4eP0U/6NbeOJSomjHOuy8D5kZcgaaMEWTHgjz1xmVpk/dmsgjQUI7xZmPRj58u8MhCZy9pQB5xbrJJSclYaXDkO7eRvCdNENEH6m1CibZTU+YyG8F9bIUugylIb4ouQ3UQnZ91XgiEEVdGPRDz2Sv8ehHd4l+iXhsJJvDLIIEixlvyr1nV8APwUiLxbBF8D72msZ1Ex87cAS3Fid8c6c/4lZGn97ijuv9lApbZYZ1xdIwiMPAYU0Kxmn0R524ZERtqgFQ73lJzGeYvqhKlBtR6ijVOWgBAWNBgBJds6Hd46oa/c+R53425gCQsE8yEl+iSR7QSuutBLPVXYNahSYk3Np5ax+g4awU097iBIwbHgoyTot1ygB+unLxTqF3m5cmSQZw8Cj4C47KWEqT2DTC5qPDtbkG5Id7C5yoQqMMx/L2Ze41
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(2616005)(8676002)(86362001)(8936002)(83380400001)(38100700002)(38350700002)(41300700001)(316002)(66556008)(66476007)(36756003)(4326008)(66946007)(6512007)(186003)(52116002)(110136005)(1076003)(6666004)(6486002)(478600001)(26005)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fe9zm4KPwY4+ymEDbt5n8cPpAfRwzOv/dYUr1k4uqwdhKfcZMECMXl5j2nby?=
 =?us-ascii?Q?Nf0uUMW6hFi9Y4563luLeArlG14bUr/JX7a+NXTjS1HoEVpVJFTceS2US7wi?=
 =?us-ascii?Q?yfjOaDaqmyAslxZTZVAuYLtvPCnMB79fe30cI7iV2z2oYQv8hAuwmr4G04/H?=
 =?us-ascii?Q?fOFo3jR0qXdVI+PqnlsPGdXwehLWeYN/fvOub1GepjWByMJvqJd6MPrlo5J9?=
 =?us-ascii?Q?Y9eP9tEY85esobWsj9S265lRHs6Me2YVf1vWZL8qQ9rR9ymc1AwI3O5Kt+cn?=
 =?us-ascii?Q?oMG3HDeSgNYIW3sYLV8HBup+ru73pl6yFdh3yNo5OKlBAmC04aCCw5zJFOhs?=
 =?us-ascii?Q?8sLvW1zGupyeyo6mMxZdNCejbjly7M/+iOOU/6hwcndefWYza1bJPbomlwo7?=
 =?us-ascii?Q?H7/XA/wA9AdKPA97hdvjsAn8FUS0+SJ4P74OayyfepQxdXMihrSv6cuFk3UX?=
 =?us-ascii?Q?hl3fVu3x8vFjthNjyY50LzOu0Xp8jMwJ6SBy6N8Gc1E+wgNmuXw0x/ejRCht?=
 =?us-ascii?Q?tnJMqbvq2ZprjPA4AJZRo2Su5NXkY9Me0AZLstEEpSUIHe35L/bfvxBuG+v+?=
 =?us-ascii?Q?ulp0QSXeLsMKDts7tWvmiAcyh06IpOeEipvcM4yZoNERWFEozUdCb4xfqV/Z?=
 =?us-ascii?Q?Ell2ga8XvceN/eraQJAkYyE5WYteo5w8iI67pT5BNrqIi6jupN38eeR+lbBI?=
 =?us-ascii?Q?GStvTd25f0BsKhoHmJBg9NgpAyMQff7rhv+NdwWSuoJknWFwkGsJeygGY+LG?=
 =?us-ascii?Q?jHpNCj9w16hXoKPAyRXSms4mktWbgpXaQgS9JeXCXSTrv9blSG0M8GVdOO84?=
 =?us-ascii?Q?qBIT83S5RTOBXcTKr/Lx59yhm8Wc66QyH9RfDCFTBDamCUse8YQ5OEpI6H4d?=
 =?us-ascii?Q?ap3gcxSwZ0G3uZDP2lvSna5JTEYZOc7h8uPoKKivlpz4LpkeFRkU1VPtyYBo?=
 =?us-ascii?Q?GR0vcZg9TXn8guIfgPNpTqMr0v8o4zwHMpYKH0bOZ7heUugwS/KtFrdFtBxW?=
 =?us-ascii?Q?1C6vEh1jy1Ap8GwsGY66ia3lNamMt5IrLhm2FTYwoDCiLIP1BtHHjuvdkzvr?=
 =?us-ascii?Q?hbq6IeupTI3kTKrnVXDrdaz9u7XyKenSoMMOlQssMup8IBD61cv09YlN7qP3?=
 =?us-ascii?Q?AwP6d/w2hlvFbMlKmfzHdf0gISRWSWZMw3qqX7VW78oIxpq/1cyF/WKbS884?=
 =?us-ascii?Q?puO/kHXok+rvFKnA9zYXhZD8rI9x5fJ0TKPJZpoo9YNt66bfaNYu8V6SG7nR?=
 =?us-ascii?Q?S4oVRcYtD3hBdmA+XyirYR5wqKtGzm5lHIwQZzxmRmWYskmStHdCTOOFavXB?=
 =?us-ascii?Q?5SQt/ldyt0jWsnw9wyQ8ph963LTQwp8zjG0R/vzi6cVAoygCACt/EJFGXvAg?=
 =?us-ascii?Q?F/V3zc9ypEbw2aJwF415bluddq0Cu6Ny+iz9tVGrWwATc0sXhLtYh+6WFA99?=
 =?us-ascii?Q?nyi+f6dMcTDzmZKSgDje60hJQdkUPmHWjkApkqgaFaAsJlB2MX9VMrK+FBZr?=
 =?us-ascii?Q?rV4JnHqGbBVxr1ScD9am+zYf+oGKX/fE5PqTpA4Bvw3/XMyM1dl/myu50QjI?=
 =?us-ascii?Q?mXis8uvvTOAAXs+wHc+QxJUBZu3uLh5pleEx6MW1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3ce505-4152-4019-1c45-08db7dd0f89d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:48.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwgt+agqlrKVDuHeKfcIcP4R5g5ui9hyB/OGlvK0uhjEF4NKR7aTjJDx/zD+CnyvQ0vu6zbw5B8616DvJsMD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5043
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
 drivers/spi/spi-s3c64xx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fd55697144cc..ad008597c7d8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1164,11 +1164,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "Platform_data missing!\n");
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res)
-		return dev_err_probe(&pdev->dev, -ENXIO,
-				     "Unable to get SPI MEM resource\n");
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return dev_err_probe(&pdev->dev, irq, "Failed to get IRQ\n");
@@ -1185,7 +1180,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->master = master;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
-	sdd->sfr_start = mem_res->start;
 	if (pdev->dev.of_node) {
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
 		if (ret < 0)
@@ -1223,9 +1217,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (!is_polling(sdd))
 		master->can_dma = s3c64xx_spi_can_dma;
 
-	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
+	sdd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
 	if (IS_ERR(sdd->regs))
 		return PTR_ERR(sdd->regs);
+	sdd->sfr_start = mem_res->start;
 
 	if (sci->cfg_gpio && sci->cfg_gpio())
 		return dev_err_probe(&pdev->dev, -EBUSY,
-- 
2.39.0

