Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6574A9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjGGELL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGEKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:10:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379130C6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cScvd866mxtlB7evb8DI64dPAACuRrKdFaeL6igOsGwG2N8dCTwnrdXy2lde7Nkiyql/l4HpeDGdPVcKOAsDoQl+rhRn3ahNrITt8FXDkbfHqjnfM5PYdQDhWP5HGy5m/yg6UXQ7ugiMcUsT4NEOIn1vMgwZH7wWrFIWQxCWOtRu7Zrd/8kHMTQDVLjBFEu58xszfHl0MmNsN961nOXGYinXPO6UTD0U5/s6RV0uC46qic5UpYWFhl1illZKaHy4mxGs3Vl35G8O8brmoXIPRz9yShrkKd28gbl/DwNX+IbWD+5xI0yMDQrzLnJ/Tud685HztqC4tsEsOvw6hy3+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veaGrOk4W7LBkRnDyPIaURF3ICTTqQfsGdlLPhD04XA=;
 b=j1XLYi2T2IRqLuJscEtrKRfQkIpgg7pCqhrjgT4OT5CBT7RLqxUAsRQwp1fiabxVMMJGL5bpKFeijRc6rN44RnTcEvKW2VUCEBNO2RemNwXabKo7UlRRSQJWx3HUW3yz17dbWlvI3kjp7ZiM22s1UF2bvVEZzbyKt0BfOXoXtplGlIeHZKhOAF+1CrSDvYEo9JfmPFd/PGCC5UVx3w2z/qwPWPo2zeZpDvFern3bx26wYZODN4NVDTcxRG5ebHojuKhBthULrDvqpM7cmxTP8z2ucPLIwHTRBOfDR9ATTM2Y4pxtYUOdBmHN/Ts2qhexlkeHNOpKbxdYsSJmvfjuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veaGrOk4W7LBkRnDyPIaURF3ICTTqQfsGdlLPhD04XA=;
 b=YTlqnlu6L9JMLEIWi5dYfyKdCIKiGNFcy03e55MmwLEN2yTRW8/2XhhTT9StrDX6k+jkh5T8F2Gk6moaIqBLXZykUfb7RChQuSAWwL581Va1RsofCqGerh6pb2IJ3BCHQztV8VBfnyUZp9qCEOvOk4SYitEPBUuXp8LUMxGTY4uMocL4jua+F/B4Ulc69/cZ2+BQoG/OgS/wUQ0k0qfgJxNGOT6hVDWKJlr7fQfRCpOvHcEj8II92S6IaKyDyv6reBIe316kdYt24BbEon3e8MivrPziq58BZoIUeEFkvompRn7UkSC92G0MrgEvRQ2NYIomk255LuNycnWX7zvc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:07:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:07:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] mtd: st_spi_fsm: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:20 +0800
Message-Id: <20230707040622.78174-16-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06272e90-4bab-44c9-cef2-08db7e9f9eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqO5+ElHY5/gMEJtW1BFprlCEuSO2YO0IVDgJ7qwOUF08/KLG/M5TTRjnUdOV9fpbgENo4BFzbqbtWV1KrCa9geIsWz0R1rzDxve24smDfwWOu+oqT8UVDzZLGoep1HTwlbAPfwjD6DXW/QSlJ/eHHZE7PCUGX8ZfqHiB5Sc2Sc7PvVqvmH5d7UdsxvJlsheAqzhmvcBtgd7Li8QEzVpAaUi+8L2fpeA0U4GIokbeJG2BHk044DMkHdOHBGmEvkjxnMvL3pa76HWkRdoCun1Iny2qmbu9RzVrG4JPwulwMIgUYhXzt0/CBaEDccIqKtGquFMKY0n8Jrff37+EKuf0iNIayIwKushHr8Kx1n+H/f/qmyGxswTaNxOpCWq8fI/y4lFIxykC2gaJohGkAC7Cp6USULs1VL+f4SpWsxbSoqVCysk2VyrYZ1qJLcfXEv4bMbXjskQzifdvcv3cR6YXN9UQhIV6vmUDRikfvLCotpQ0ctQTQzV8LpQ2lmVMFCkpA+NOH+ltYtlAi+zTTDvBqVWixIYrUyClOGq+mnb31/bePEmSiUKl5mlZ1CdebYNgYVDq6df1Y3t7tNh/xEdT8FeydHFGa5GkcizLQpHZOp3Wx3I6iiS54D3TYwxFbxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnM7iN9DcD6PlImcuEwA9F2jAITlSiwFLcyOcY5t0oWejB5r1Rdz/egOlcbr?=
 =?us-ascii?Q?9nJlfvkSPjnhvRKw4aKRpdiU6zxUdkTZ4CPIFiZccUev3obqfjQ+fkH8jOwT?=
 =?us-ascii?Q?2/FKqv5YsaEiE3K6G4bKC91S7zFpASNbxplBA1oKHhS95zsRFRrAk6SjIaog?=
 =?us-ascii?Q?kpvzHQf4M0musFdYP+bagkQ2t9kbL8010laUvb6csors/1kZY1Ex3rdLAgU0?=
 =?us-ascii?Q?L/sMeEPwaZmc6WTakSRKaG1XOV/k5notTT+puX+dcyTfRoz3BoSJk7CT9aMt?=
 =?us-ascii?Q?clEezmXAg+7vWx60r0orMMfoXgEliMc4XBty1tasOL5xY6uyK7ipt4Unzoye?=
 =?us-ascii?Q?YZXyhEPNfszod3bG2chgruza2N7bp2RzK+n8Iba9PsOU3eIPxJF6xAzb+HXQ?=
 =?us-ascii?Q?4pDqwaLIHaoK78TFWs2p6inLYunIc2JskoBoWU5jqApZS9Xh/8FNcXlIgAt2?=
 =?us-ascii?Q?FCVfSH3jSk8xf4GyGmA5l71hSWT/aqXs4E46v8HVwv+clxQjBUbQFe29LToB?=
 =?us-ascii?Q?Hwd266KJrLv/NWcIvchl1ATmlkUv/xfxDibzU4j8hRrtd47ktyPTpvV3WT43?=
 =?us-ascii?Q?F7BkG+ZqBbufVEKzt402TI4eEV0ij6WpDPjkamiSPAcEVUGQ2BLAAHIRoVth?=
 =?us-ascii?Q?0qq18+N6zXAuxBvLV5to7IH0Q1EGckI8ZhpsaLLeR+NBQfwakQtLsuvf2yfp?=
 =?us-ascii?Q?8/iq30m3PjffEi9WEF52C0S+EQ/M945qISd7Sb7d0BaUFdwJU7CKZeIl7qjg?=
 =?us-ascii?Q?6Xhe0UdFJCEEz3xOOYL1Q1KJNy8uSiXA/6JfsMi2JmSfzg9d4bWv0h2E5cW1?=
 =?us-ascii?Q?wO/LylOPJO3qI7XjvsuojiBhJG6Xjl7SGgw82cXipLvBZQsbetqlgqsxy5MO?=
 =?us-ascii?Q?/zQyozQgAaWwWByAcoHRn6O9iX/93FySp9km3WxIuCE7IkMgN9/wFiGfwOAM?=
 =?us-ascii?Q?trFkvsfI3YcL/5l17zxOG+5O/aAeD/2sABkRRtwAgJIxpdTmWcNUHS+GiTH8?=
 =?us-ascii?Q?/9Mj05wKQqQmXD2ITiXmJM0INn+HJCJm0j3ay5vdJMsP80lyR5xQ5hrvHQ+e?=
 =?us-ascii?Q?ddGRO/F8QehTuIUbrWcmmcGz9DaEu6/+6lJNqjowvDQvYZ2VZztSEyH2o0aO?=
 =?us-ascii?Q?K9igbwRd/TsfUMr9Kj6ocTUb/UdH6fKlorbrz/m0FWeXlr2IL4UUWms2VzMP?=
 =?us-ascii?Q?hCTVUv1rgWeJuk/FgQQ1+1JHpiQrAN4grdDUz9cRikFuii00Ep4TuaPDCIP+?=
 =?us-ascii?Q?YqPUY+w0yEckOGNrEuBMggkn60MDMF3GPYsuCf2i+TQ4zl8hGqkezsc7/siz?=
 =?us-ascii?Q?b0yjnhMhK4iXPoMSSj+HXw12hEsuryEInwAyoVZCFSmMR6Y/nwnT+YUU8GO+?=
 =?us-ascii?Q?9pL7G+N9iGCG1k8NwMzPN5RUAn6a97F4y0E4q+ByBFyDayOvY124OpzhhKwv?=
 =?us-ascii?Q?F9Ge4vQ4xrFbQq6Xkpz5DuDg2qsZ/bWI4+NKq/0Iymor8yZB9zVfrkBP/rey?=
 =?us-ascii?Q?sRwST2NKliAIB8Nlf62iOzI42ly4QltG8rvLuHotGRfDOYIZ7lsezGxv1mcn?=
 =?us-ascii?Q?szuRHs8pc/LZIAxIByxCTrrGJd2Bbi1OoqU4mGrj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06272e90-4bab-44c9-cef2-08db7e9f9eaf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:07:03.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQG71+L3xJ0l2pOqWtasg/SFhLhSoVrCCTpMyDDIc3CnZpKRpOoe8mwcaJG+S/V0ho1zfZK//W22+/Qno0/gtw==
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
 drivers/mtd/devices/st_spi_fsm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 3dbb1aa80bfa..95530cbbb1e0 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2016,7 +2016,6 @@ static int stfsm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct flash_info *info;
-	struct resource *res;
 	struct stfsm *fsm;
 	int ret;
 
@@ -2033,18 +2032,9 @@ static int stfsm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsm);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Resource not found\n");
-		return -ENODEV;
-	}
-
-	fsm->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(fsm->base)) {
-		dev_err(&pdev->dev,
-			"Failed to reserve memory region %pR\n", res);
+	fsm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fsm->base))
 		return PTR_ERR(fsm->base);
-	}
 
 	fsm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(fsm->clk)) {
-- 
2.39.0

