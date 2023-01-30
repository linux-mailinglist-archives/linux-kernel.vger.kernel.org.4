Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDA680634
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjA3GsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjA3Grv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:47:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D0C28856;
        Sun, 29 Jan 2023 22:47:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7h9Qjz7i08mVGLpVyhaLCohmbmmlTfeybGAtzTLZ//hyoWyNMPZUvvG+bNFjGvO7b7pTk7qRqK0v8PmsHDBpoDWLXwPGR3tLzlIbl7260LbAoxEfwRLuhWXyXWCW0XSMZBkYsFoU4Vgoubv0v7p73g2r+YzLUip+wnLGOx+9yeSLoHJDbWhX7jqJC5mUwEDAWQUlatOg80X4T9oiA1Z9fldar/r2EnBlqEShVXwC9EKXqpdZj3hEy93b0SwbgePX9D2aN4CV+AkAV/7eP52T/vTikfCioOoOwcEqyRg8h7nQtOEaBoYrDY0rVnpfCehXHBGQUP/LPOdfLSZSNJ+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO/MxKnSPiVLn9MdVOHwrf6HKfOkaiVwxb2kkO0W1rU=;
 b=DzoPscMMrl/ztCFBFcVPeKI7cMMlbQbJWz2lofkQjJKL1DWUAQCz6+F2Tfuk7xjqYKvuns7jqEBtlQ/MkSrlFXpzouhlKiTgCQtaAtJwky4jsyGhE3jAJZQT9x7NXHVoFF8l1H6biz+a5bA9hRidxjjdpTtnJ2M/+kF4/NhsccT7rNVuubdIMzoyGX8bi11DiTDWGKKvkOVaeFWtdtF3iAewSDOdp0hE5ZJUlm9odLnAVkQlEQ1jwUXToFr5YDZQchyFajB71I+OzCIpClx2qP8yzn1jmtkYjj+2KoSYqSui2GZiuDnlYc65w5thaZDJ6t14AJ2PK2XTVRqRb1GA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO/MxKnSPiVLn9MdVOHwrf6HKfOkaiVwxb2kkO0W1rU=;
 b=IM2wSV1cVKQphTyhWbYLmZkmXF1KRlppTtN+W0HZgvsc3iFPEu7t2himyfanY92GboMjo8G4D6TbaTxrAuZ8tqwJUZbAnBcl7sOuwJ+u3A608+sb0W5Tvt/0Oq+C5Ua7uuPsOHAmanRoecsnVdNEp69Iusz+wXX6VncEpzkKZZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:47:41 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:41 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 3/6] tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case
Date:   Mon, 30 Jan 2023 14:44:46 +0800
Message-Id: <20230130064449.9564-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130064449.9564-1-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: b09098c2-2165-45c9-2c5d-08db028de235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uz36+6qbVwXu1tfsqwqyQ3+psxRsNY298AjPEI9H9PlWm4NmGNP4JdreEsX4Gi5FX1wBvrxzncdUuvgJUoonH6hSZFrrn7Iax9KtnIGVVdyIEkp5rBK0lC0XNop9LDaYTDeJRFrDD+92Yr5AfiEsifSp+tSIBKPrTXAtXnf5zNXc8OWuEyrCNZA1LWBC06eJFHqEegkwAwCOhfgSAFdEHz0j40icl/6qNUA9/f1gppvXgS24FBYB45AAnfaZoUWwHgCNGVO7tOWA4Kn1sT+QK+wgZ5Hc9ERSZdLUJyKPS7TrK9tSZ9/b2cxmJT2Y8RoDbP8YqVhpXLBtK0iRE1a8gbcPv2L5POFsr9SiUcsnEQuJJ7+ZnrK8CgB9M3yqghtgKZ5JKyk2+1W5hhsmeLpJQr8kvq4tcOlIAkic6ZZ+OSc/0TU3AfmGGiMOkCxDUyMUhjoddG//FTXbLJap4y5EEVsxwvdTMWLZBYcjO/tcQXVRdKPIUSOhpRdBZ1zKSQk25EO72Nx/HOsieLlkjcFY/iOZ1TtaW4eyrkSs0PspThkmfgMZAAX0iLvFkz78AvGKnOZuy5wF08sGmGhH2qgmVjd4RSL8qitLNb4WpJT5/rgAtME2I5FacDLC7+fZRlbLW/vqgK3m1WtHjRDnSn4FysCGu0p37PC1kt1ynz0Q22g2cCcs2u9vBLasj2kUGvs03ibKpwPD/3Rq+liNI7Ig6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(8936002)(41300700001)(44832011)(5660300002)(66556008)(83380400001)(38350700002)(38100700002)(86362001)(6486002)(36756003)(52116002)(316002)(4326008)(66946007)(66476007)(8676002)(478600001)(2616005)(186003)(6512007)(26005)(6506007)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtVd4yJRjEUpq8QTn5G7A304DBLSbG6MUJ1XFiupdVvN4HbaEVEJK85hXJaQ?=
 =?us-ascii?Q?etGSw4aeKtsOTTva7ap8E/lhR3g29+J3rXpgI8dU4vSt+W/C92y9bIjRe9yX?=
 =?us-ascii?Q?dKIvi/Xf1ajHtOtM2ek4PTaWDCoNisdUt5jW6q/tytdOSuF6+1XPFULCZByj?=
 =?us-ascii?Q?DCTFc7HhwPR1lwDmIa9eWXbNdTolojMIchanlvXvV3z+e1FN9jWqcUqsK9Fg?=
 =?us-ascii?Q?SyT/pjum9Emp8T3iTklSEtF6i8ZW8gOMMXZGs9JD6JTYhdNFR2sdNUL+9rG4?=
 =?us-ascii?Q?AM4Zl+D7kb8EQkOAp6iL2MoJPUu9pqB0jKzpxdYHvCTN+MokF5KT6CskUFfh?=
 =?us-ascii?Q?RYcxr+NjGs7irqU15Lq6zBan8ePmG1YPmVsiZt5xrPzErcnWcfrzibkqtzez?=
 =?us-ascii?Q?vezbnkwe761tSCZuuMKSGNXaUi9dv6Ae2jArZ9sxp5Ku5r68MwrC3QdeGLkx?=
 =?us-ascii?Q?8XoIrlrEF8rn3VJnimBFxd7GiHWL4jLBNRHFAJ4/cyJ60cSjN/gMvqn8cPiw?=
 =?us-ascii?Q?su5mq1WVD4rlWr/BcS5N4yuohrnakxKpHl0PGAferwodDwP38ufsshKsn6ch?=
 =?us-ascii?Q?tC63Ikz3ATaWGjpi8rWBshv5K2CFxhDSrPAs4PBGW1V4veFYEhsSy1wiSYpr?=
 =?us-ascii?Q?GBhG2nY2vbN6ZnZw1w5+MDFMYyqg4FvPoiKsUVlm9ZeB9v10ySxfnjJDtIdW?=
 =?us-ascii?Q?mE/85hJf5MZVfkWeZOSt9NjAMoLQWPhwMmcjaLy+HCmUZrqEIA1htILAa0ie?=
 =?us-ascii?Q?S97cHic9xZpB0AcimLylTLhWK/w5MOf4mvoBGjc2vwrOwqBLbV5Wtmm/b3at?=
 =?us-ascii?Q?Xm1o8IvDltw6tpBBoah1EdjNCf11URcswY6sOixKNFc4ODwPy01X+7maaBWa?=
 =?us-ascii?Q?oXoJCgd3mZWa8ZVmRYxH4pAFPwKJ40IhmjUknctNy2Ac2x+Xt/W6UkIlyu2X?=
 =?us-ascii?Q?z4Fb/arp3E7T6v76fMRIj1pHaOwt/PSCVneGPNKW3Slfp+1fDRwVzrb1gpnK?=
 =?us-ascii?Q?KaD/Yuz9JXK2yGSp3gZUmzp6GWkxlJ2KeXstIN3OBB1wD+cXfL6/LH7RLAWj?=
 =?us-ascii?Q?OjrTdExs23qSK0Wa9acxvoOLnCmBudz0+Eo3gVgPrCWV7/UPIMk9fjW1jdMA?=
 =?us-ascii?Q?7ZsVnDZEeZJTMaea2yXQRcfrYlhjRnxNh4DegBaK3DTBNizryEW3bswPtWdn?=
 =?us-ascii?Q?xhsvSwR8Irv1QrJtougsZPL+3r+ylfgXgnPHx+Ia1EamLUpmr5j6eLmuYVMw?=
 =?us-ascii?Q?ZfIjQ8z7y4xDaozvF1wrScyxm5tRKd56IOKkH71DuaCXLzcfB18xHsIH2117?=
 =?us-ascii?Q?5Jx5uVFlQSIftmIh4ii0PIXzunbrLWNRyG8KWmW8HS2PHYKfbSMSkf8kXrz5?=
 =?us-ascii?Q?uHoxgEDpysUPv4vg1Dow9uT9Vlzk+6ujvftedSU3BhIsWfuPMKsmCHF6xQzY?=
 =?us-ascii?Q?8UygcVWzhv/2lLHC2sa96W1+jUkdIbzLevsMahygMYAPFxFav/r1WZgj8Z0Y?=
 =?us-ascii?Q?WDGw7a76lUOrm6SAugOfT+ToiZsTg2j/CDsrbN9/k4Q7mZ/SNecOnEGMxaiS?=
 =?us-ascii?Q?n8hTtHmg2gb1RtwBAEMOXNaW5D84TTuMCDu3WPZP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09098c2-2165-45c9-2c5d-08db028de235
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:41.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kok5HqlILe4W5Rkrw/yYCFT4EwDjwJMRhmxT6tLjkdQS30QBeeybFbOG5/J2yJ86wTLiVHjlvZ/9Ka4/8UVloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RXWATER value must be greater than 0 according to the LPUART
reference manual. And when the number of datawords in the receive
FIFO is greater than RXWATER, an interrupt or a DMA request is
generated, so no need to set the different value for lpuart interrupt
case and dma case. Here delete the wrong RXWATER setting for dma case
directly.

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 868c2783d2c7..ba6ade784ac5 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1729,12 +1729,6 @@ static void lpuart32_configure(struct lpuart_port *sport)
 {
 	unsigned long temp;
 
-	if (sport->lpuart_dma_rx_use) {
-		/* RXWATER must be 0 */
-		temp = lpuart32_read(&sport->port, UARTWATER);
-		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
-		lpuart32_write(&sport->port, temp, UARTWATER);
-	}
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
 		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
-- 
2.17.1

