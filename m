Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347CE74841F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGEM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjGEM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5FAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMb0QfrZNnMx1JykyF6nhJ1SZ4+6y4NVGpb1E+KgpRwcgtZjWxTLce0TW/3wgnKmp1NFE20ygefksJygk22wDst/WHkliltltSXBqvX0OUt6Y1Nh/ZEFue8Uh3LVPDV5lqmnU3OT8lgwek7w1sePYD09W9dgqwZB99LPuUdCwvtSWASNQSCrFYClj2iT0J5PanOAqh+FXeFKiDBWaHZYBTl9bl3wBU50RbYXMtxjthGph/h2bY0JBbx6r9hc2Xkw9rtHqc6CDWihyAO5X1ib1+tuwc4sSOiRrHqc4roK8zyCZt63bQ3VD/1SbxWsgDNU+HVSN/O6/w+Zdcv3gXfnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2owX08cTPpggMLaRweX3EiWumvtcP/OqGrR+fzbAIgo=;
 b=dcihm0RNA9ZFncss2wWNcHT84Hw24iUpcdfRx9NWHR7OmgDxxqZZ/kNp2V1XuaUacrpoNnYHLlCOrWqvgviZ0pFr13o9aRkMovBS8Q7VoG2OQaQ/Xq4pjT5wxUMfdGEKpbROSQOfJENmRDDTsy3toINSkKxQ/wn9EY6DER2dcIUuM16AJ7+Z1coIY5JWki6viURDbq7+Z+ABzB5KGa2O+Kj+FT+uu3bHwNImImPfNgCmX/2T+LrRqE2vPBls8urlqyKm+o9tGM67fNjSOG8P533Ncg2rdxsVdw3ldgNhPK0Xbn/B8Z95Z5f8kcnFzzSEUMfUlDpGxetXxGN0M5dCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2owX08cTPpggMLaRweX3EiWumvtcP/OqGrR+fzbAIgo=;
 b=fXtntZQZsT0P7pFrjumUnjfYxDzj5LgcIMElE5AYfBO8nQy0+t/YFZ1vuCq0yOK2hI4mXyik2YhVKZr59JA28o1loYxuiY1loUvPGNDWQ+z1KVOSTQmTRgN49X0xv0+DeUX+cRJQF/CHNNMsqBrOSs7XPjFeWjLnX/4FnZhoZlDvqU69xLS2ileYwB0rYXgJPHEYGfJoKyKdYkUbhBzhJfX4qspi/ZKecQ1rtSm+kCdONT6vuP5FweugvXcO4WDC5wnotGaBAgXYbNuV9pMVS1nViASujGgnUaGcQlZpJH3iKBlpWE73bLuUE774G6bKVx7JybDK/s/ahdme6z8dJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:27:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:27:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] soc: ixp4xx/qmgr:Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:43 +0800
Message-Id: <20230705122644.32236-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f23b66d-f10f-4f09-e52f-08db7d5322b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In9RHuZknBx9oxSA4IzVfKr2HEOeTeQl6GfD5ixR+1mgRn9LZ4x8gdK0hOOYyXOsg3a+/mcbvnpkqHz3f2DR0F9EeoZ6t5jy0+L9a5T0jcVpSVG82L+93LODq8aDfN7ylX7zjzaLrFIV8fWph7tZT+9W1ZHDvWF4GP01opmNmeq3WvlMnF0tha2PrvBAc2EQ79ekuVUgJxy+MJ23WaLvzo20mJVqDP6pcMF2uPVhY9c5bJSPHG97b6PH+5j4ilMkYoqoB93D06KgSXCUC9ewhgSYa3KdTMwEmsSxsoXj4jBhwqvGu7fN3K24WcU2u2IIIVPqVXIAsQivA9y7mgoQSnmYHMbCoD5jRUASoPJjzbcI9YhgFQEfBUmqph06vu8A5HtqMHR5g90EunwY+MieWspN9jN37CWce4ZAR54Yfr2vZ/yU5fidPVjIXUggNlnaCEAI2gQsltc1Xw3LvpR0lh2NcR7PTwX8/hSgDoOtF2OoAnWpt8Ouk761VOj0zcR0CMSXp4lr36JSyuDooycKuV/JhuMj6A1Jbian1U3OjdfMPab9Bkg/WlMz2kTjJgCe/jaTeTHq8G3JPAR5mTbDrUSivBs//5/K/Y2Go87Q+uIR4rJbu/hTB/y8DoQTnlgLOWpwDULBFi3+lpORmkCfWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(6916009)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2oJCvGU0l89yS2MZnOKBMahLMg5efu5g1IsSM+hCInJystilmphUDf3F7EMq?=
 =?us-ascii?Q?uCD3cv0vV5IUzL2asCPedvBSgz6m5CLGrcYowqxtPn5bmLLDFbHWSGTwjClv?=
 =?us-ascii?Q?zuDKOQYmFw390COJNCFFGxeA+bYdBlM++SAyE6gsgNcABnYBYUBavHEweWZ3?=
 =?us-ascii?Q?kMiHT+nN6uMq25JF41COCtX7rLOh8SpH0gZHQ4wW/fM7N50DL0zsNAABJ3EZ?=
 =?us-ascii?Q?Sevodo4MNzffqOXKCAjDMwg3ilLpfvlaznI/O0gnTeutUNuz5aUA727Jxpbs?=
 =?us-ascii?Q?BEP9YpUNWbVmkipgDAioRsMluGi4O6mpsL5SI1c+sfhi3QdP7KGeuiSxQsU9?=
 =?us-ascii?Q?V8iFxysLEItmzhfCAN0dS4kuXpaDheMEYqDDvtU1yaZj8a12LtlXbRr5x4Og?=
 =?us-ascii?Q?P/A2LkUM/8IIWBf94X96mPOMIvzyd38tOu4pYizceTWNuccMaGdX/9b2B9Gd?=
 =?us-ascii?Q?1qosPpGaFHeI08XZdDEeXFABrDZGVkTHCW8s2LHA6H8UWb3OkSAtL87/0fJ2?=
 =?us-ascii?Q?0lBpuTa1uRyUBYKch67Tq7uLkx90wWOQPTrKRsKlnIPOpJSobp4N2DeDhfjs?=
 =?us-ascii?Q?XlvGDPVEljogOp+DJ7KvF9MaVtIp70iHAkBG+wPWUFrm1v9yviBSe39FCo6V?=
 =?us-ascii?Q?BIY3B+Y0Ex5qxL/6Z+znsjcI8s2WptuO/oeH2EsZLeJMVB+YAjxBsCYM3geA?=
 =?us-ascii?Q?ghARBvlt5yFgwpSUWk+smGL9lUsocwkWqwyNC8uR8HXewx7Wxf6l2RksIECh?=
 =?us-ascii?Q?dxr9iVg+prcbGPmrfOKsxbEiQzCt27MnQYHQr7YRkstl4veZd2Fc4mtsZu8q?=
 =?us-ascii?Q?3mKWBMVZ1slwhNTY2laFjWl9kNKVWEfjBodGerowdJWTUfZxRcKxiOvEvQXc?=
 =?us-ascii?Q?dR78pkLL5cvkReyqZnzfPff45fA02czQWrO/bV+PoOxc+8MTzx9B5gtCpPyp?=
 =?us-ascii?Q?O5C+Oc43i4lqngy0Rz352YSPKEE3qp2/w73MClp9m0q5lBRWb5/2ZKyXuu6w?=
 =?us-ascii?Q?iRZVXMTyXb4BbnyECIlJluPifoO2ZVOFw0Zo15NR1xuFTOaJrhd/IbAtkk5a?=
 =?us-ascii?Q?+G4114nK+h3cUjF5qiz3aDkvArmaGqWZBkoRvFxLhnbLi8eRN9SpQVdVSD72?=
 =?us-ascii?Q?OUjmvs9vAyl3Hy9N3LchyNTIgLtDqa/0UEZnAaeJNw4ptRtoBmGXbhAWGasf?=
 =?us-ascii?Q?NU16PxYO5Up/0G4wD9pVsMc/ahuB6KA49wVmL7MMWxvM8RBPe5fIGsjyjb4x?=
 =?us-ascii?Q?Ib2Nkfp6AY5lMWRjuf/dozaByxXYlkLTD77SiaVbT1sv1ajrdL8LtZ4EPnr/?=
 =?us-ascii?Q?CFK/SFRKX/i7zKLBxXRw5E2x3zXRqxM6AYPiHNSw4ICKcVKHs8eSLN1yV4tv?=
 =?us-ascii?Q?Ybg87sa0ya5sdQiULZMgtDoEFVzJxnq2YJ/uLMIdIyKjGAXPmqxLBO/QQRQZ?=
 =?us-ascii?Q?snWapl/ohPqO1fcJs5uEZpuEaVR6X5ZyyHKkI2/fCDjcc0UJY+peG00MzaZu?=
 =?us-ascii?Q?qdpYf4Hp8jcNS/mL2pku4lsX9y4tFHP9zDRdC6GlcyecS5Y2IzW1+sHgMJsJ?=
 =?us-ascii?Q?7yGWsTfL4WHCnmFStwAgNiRAJ9CHt0GEYXvzWk8z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f23b66d-f10f-4f09-e52f-08db7d5322b9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:27:02.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGG1/kDeXDevw1K/TreEJpni6stDQF3UkfP36hWo3M2llzRGaIZeJ+MVKewuN99AmpXcxthfH1tT9rDGgF5DDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
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
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 291086bb9313..8d24f39ac326 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -377,23 +377,19 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	int i, err;
 	irq_handler_t handler1, handler2;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int irq1, irq2;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-	qmgr_regs = devm_ioremap_resource(dev, res);
+	qmgr_regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmgr_regs))
 		return PTR_ERR(qmgr_regs);
 
 	irq1 = platform_get_irq(pdev, 0);
-	if (irq1 <= 0)
-		return irq1 ? irq1 : -EINVAL;
+	if (irq1 < 0)
+		return irq1;
 	qmgr_irq_1 = irq1;
 	irq2 = platform_get_irq(pdev, 1);
-	if (irq2 <= 0)
-		return irq2 ? irq2 : -EINVAL;
+	if (irq2 < 0)
+		return irq2;
 	qmgr_irq_2 = irq2;
 
 	/* reset qmgr registers */
-- 
2.39.0

