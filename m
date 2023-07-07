Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1DB74AE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGGJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGGJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA52127;
        Fri,  7 Jul 2023 02:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJxgtZMvE9bAmvEqmWJceX7LjCDHLVz5YO2peFR2s6pSlPSzkR1ThZf/GsWQJT2GU+ytN/RdSX2kuiwbJUk1HiHlE12YQni5OxViJo/+kRoQqaQLbyztLHfDTPx2IsPLhGzDa9HLaCCbvO4aqt4OSbAnMXCjZ12kQqfSwP/LTimkysWm/j6VTbZwhvixxQoQCkUyDr4xqur2JzyHzjDyyR9Jy4Cib2ysZgE8nrqBE7tobtBU/obbGae8e4f1pv0bt9FghWBaJVOeqLqddFXQP8ZG1pOWci0FkGOXYPnuOh5eeJtvg75lud3JFovreqW8OWrBrODG9vMYNhrRM+NeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtVYOYMZOlBwAc8uttTTZ1VtrI2xEPdSeZsb4KYuxuQ=;
 b=a0GGTJdLdzjaYt30luFHdDMwsmef84l32SfHfD/h7WU89O/yc9YfJvFqWKlO/wq7HVDY6ZgeeWmJAHe0OeXbMUJv9HBzVdG7ATEMNv+AKr+anE8cL1921lR0tLEOkz2NGT3ohKW/Fqr1JlaD2QE0EASuEQG9Nd5QMwpzsgs5iYTFDmUNtEM3EcTz/ebrenGR6vv+i+CJnJ5hoVV5YqhvT7+Tx9Cz1uAedJf2IbXNlaQ2RqZ639fhYfuNQ+aXVCXQHwUrfk98p0tm8snuwZCwPOcaKvJPOZeUmWyW7gwXBZPCb9z3MrPd9+gQ6wIV3WCfHg2gG2n4IZ5qziO68zcAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtVYOYMZOlBwAc8uttTTZ1VtrI2xEPdSeZsb4KYuxuQ=;
 b=SWS6O2xBaHf6tAvHlq+kXp3KFzgrzVwHSA5ZUiQuJiqg2X7eYBd79EGOlO2Xs8l1hKqGGPnLIqjTN5mBDLCUfPrB0XGOW5POIRGUvM41wjHc+uGgUjNicZNuCwogJuYZSPO/Qu39/sgs4KMGF85nUv8CiKRUEgSFNHfMbHnKiS6x7/VWP1OngNVwBjLJbLd4m2dOm90+4yyB040Irqr/upGNgLg+qfFvwlwZKPtolzfUOJ8RDLQn68piiAUxKUKR/tfBWAUXlLNX4bCmSFy/Pdyqumee0h0XCGKYqcRczjmXQt2Mm3oImxbzp571nfAUIfD4gBsVx7qSVRlcyZtYrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4356.apcprd06.prod.outlook.com (2603:1096:820:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 09:55:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:46 +0000
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
Subject: [PATCH v2 11/11] ata: pata_imx: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:13 +0800
Message-Id: <20230707095513.64224-11-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2fc700-1556-424a-5d29-08db7ed055da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qHkd5zB70sqjE0QCFEv0slivRWyzWI9XPKDxJRftuSdYbS/YrL8y3Cd0VtdiEI0bMU2zSlRHdkzd4y+KKFn2nPnf6NuQ0Q+nGbf/I/IFG1TDEKuT3Yp/bnP0vu8TJ2P+Z89RL8sbaPIV9JvpulzCL9wz9rD5nRgYav3cCATdhdxDcHpcrn8I71R1vhGcJTyqJTR0daA9kE1JzEbBP/ExzBb+mqU3vKimzSUN4iQH03KFwqU2lYeI3nrAL7xtc7GZYAj5mX6mxIdH8bimyWvhDJNRZz1fJrUsG8ddPeNOyVfJc8bTQHls2M3VfgcWdiMfUVxYFvTpItts+mKO5kIakcoHWR2DaX7CXrHJ//P5qB8Fvbf9m2SwvEgOOf09XAiqZPEvSOSaI5crE7MNoLqy/oIQL/jy0jNT7llOGK7cDHoZu0JQdlIbAZRPMtNJMnn1JthYYoS6hmaDjYgszjFidHiHObkkgAnPKqaSt4qNLlJcrZffqX5j28PTlZ7sban4DXj7IOKZiC8Vf2VKAcXOnliNQ50VV40d6OsgJky4h9/mdpKmzSC8UJxE0IMzlT772byqqb1LDUMzK2WLoipveJgPLdWe19bHz4n5kInROvSKuKqe9VJ4soWnBCsdtEV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(38350700002)(38100700002)(2616005)(186003)(6506007)(26005)(7416002)(4744005)(41300700001)(8936002)(5660300002)(66476007)(6486002)(2906002)(52116002)(36756003)(86362001)(110136005)(316002)(66946007)(1076003)(6666004)(6512007)(478600001)(83380400001)(66556008)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPTdjDEbOnbDpgaZoSRhJa2Oe1Snk4UFJPLavdSpqVUZKmJXIceQK3cQ6hOx?=
 =?us-ascii?Q?2Y3GQDgdcjwXEYx0Ia2vCZdkw07mLPUJEIkGkQiWqcuZw1GK8Hn3dW5CjmbO?=
 =?us-ascii?Q?h+czjIzv72GR3p2e+0F14DV7G5SuzdB3Iy0KZDNoqmH6nRA2zYFUyOkBrZfA?=
 =?us-ascii?Q?MQm3SGaI/xyqU2RJRho+saMp+e0o+yRritEaONxAeJXHeUNnpd3sKd74kmYi?=
 =?us-ascii?Q?x/pxwSmZfkIByzivWOnpln+2g6jxg3aoDi3vjAqOHtZ1PfyjTz9IJqqRv2Vs?=
 =?us-ascii?Q?/DNT8EAirA0qZNMjqdGSOA9v641eDJkW5u9cSfxmwbSUnX9Xl7cl/daE9CIt?=
 =?us-ascii?Q?sDpgKcdbo2T5+04R64xe2NuOJiUI4YGXZuZIIuULnkfKJdFVoa2yXcAHejei?=
 =?us-ascii?Q?NS2jRE42yP15B5/D2I5IVghnZThR2TU7BVNSubyH98EfQVC9W1an3CtJn7DU?=
 =?us-ascii?Q?sKCXGmMnZDteGv8kVAibxX+drovL6zJeo5jE6QRucgz/jY6vzC1bqlSX0n0i?=
 =?us-ascii?Q?Gtwv+T3QWJKvrfaYYshET1Fr1B74YVKd+aOhEe/N8xPxPKfO4Rzx9UhjQonj?=
 =?us-ascii?Q?q1l3hnfL+YOddzMJXvfoRyD9ISSQsdmlh/tFWA0lBFYm7st7HDWrpXXp45Wb?=
 =?us-ascii?Q?Biik6TSanOt124xwdwq8+/LN1wtHpX4vT9Rnn+JgBU4cXXigHeVjl/1sUAad?=
 =?us-ascii?Q?OxoIZ9ef1m2EunmbRF36RB/HuJIpI+SzrRxtUgjB5+sENWpZCWYHfDlPEDzd?=
 =?us-ascii?Q?fEwSINuq8Q4QiubbLTjSFBPNgoz8+LrYT2ydRWPf3ttX253s9DQgKTpnWQmr?=
 =?us-ascii?Q?nuxGdSyB6fpU7WwJUs/NYtZge9Fsd2QnzczhuBkDZifh6LwS0FycG6iOplwH?=
 =?us-ascii?Q?Svzg6QsnTZu+SKjHbfBue9iEQcGT1AKvplP115dRNMzabuzZEzCjqPF45H2H?=
 =?us-ascii?Q?9tMZMj3ES+xoDif2QQIzaYma6O1Q9ZwsAkJiQU/7/1X54P2bPmuIC+oQImyz?=
 =?us-ascii?Q?/3K5CKcvmGOJjCwM/QSFdWCQaqsQca173cDjC+thrIuSToNqaUCk4bua5DCY?=
 =?us-ascii?Q?4Bt1QEsfuxHvyUCSvQEGkI92Hvp2/qYr5U4cpTTxfEa5GFR8+x1Yb+gLTTO2?=
 =?us-ascii?Q?TK2DB8MlRvrNyV7FmZL6bFPHGiqUC+GlCklWlEfGnD759mQQPH9bzEhb0Ct2?=
 =?us-ascii?Q?/lvr/fUMnNG+lNq22LE6LSKk9qnA2CbLJVFs1K8QFZtHUwYKHrpwbJECq30k?=
 =?us-ascii?Q?rjZ3rtol8i3/ibN5w1reX8k1UwjgLxFuqt+QA8ngVFbI78jf7VoTFQM9zJLQ?=
 =?us-ascii?Q?FvZaFY4kVksKIyfJwd5SLE4ZIlvkRY3/xYcVjbC8G24O4zvU0jCHBr91NDMK?=
 =?us-ascii?Q?LNdad8LZFBVrBSuYACfM7liOZs/lzeVKW3dA+ZTYyMqbUq/NYmbOHnR9Q9B+?=
 =?us-ascii?Q?dPRNgt09OtSVuLFFOqST+y+M+Lu/PgmMp9V39xYewHWcWGwjcWt29Texi66s?=
 =?us-ascii?Q?TPI7QJOMIsZfHbc9ChddPPVqh7S93jTBVMCEDkPjDtox0NIOLoQITCp8lbqb?=
 =?us-ascii?Q?oz/ez/47LQWKVDP1uYKPPkxgqcSTpSejBzOk36lt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2fc700-1556-424a-5d29-08db7ed055da
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:46.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YymNMHZu2lQxwqdbK/Fp83y5GtQ3Ml0XCoAA0wPX3bZcE3Xgl9UuuOGXcoSAgQu36XGg+cZjysT8ftWgtF6tjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4356
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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

