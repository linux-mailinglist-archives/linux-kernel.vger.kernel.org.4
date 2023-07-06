Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5874990E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGFKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGFKLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C810EC;
        Thu,  6 Jul 2023 03:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNSotEozHfXflzBwqY2hwpYALFNnw3yvgsfGTVUzteqL3jt1mwT8nfLFcj+mPZRhsQOJEIq+C5Ale38g5HPeqZld7bcPX0jy3LNqUYmHW8+80In6C8W8GJRyTur8KId5TkvRoei2OuqlWD/GcWWAQgh7pB4s0Ca63n3oD+rf4AVWmUaOc9O1iBpk2XCAhEeaGC2//iHQnBGZCWsmiCXotcqifDMu+Q4cumQ80cY82+/cK8dB3UnVOXGeum2ZULX3q6852x2Dk9v1PElbC/uGXoqxt8Ktvf9o6P3kq0xP/Fsjxhl3Dt358NBbh5FH/aeI2omsavSjgZCH7tKCB1ZE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0U67ExCUHUlfUb1OY0Rkkzydwvkr2VAqobp+1bOWOI=;
 b=lYyC25oJYv/qO+4gskOt+CMsiIK3o6A4US2+qdDeOZLBUfpV+J4DXePYWAUYPfd2VWD3VGjSVqP6qlANdoij206xaukVc7mZYGwi4ms6CI+q7EqtlRYKmIxpbqwCCwD89QJ/neZBs9qGnE9W0Bh7qXy65prAqOp5DCU6IhLr46ZvjGmB4s+eSepLqxNYVpFZCnJaS21GP2a6UO0Urk0Yh1dZVWSvRZBy34Q+JutNTBKVzuBU2tVbVhJ4A42P0HpJS4I2VWGZGPUJOVg0zmUuX/Hshnngg6r7qv///X3s2/gFXTGzMWV+d4n+7HUvvHXz6DJ0uRLajc80Q/pXyPO/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0U67ExCUHUlfUb1OY0Rkkzydwvkr2VAqobp+1bOWOI=;
 b=pZf9WbMrNLxJhnlFg3RXRonZ7A6sMMyTkda8p4/27NeA1Kq1i12TklZtu5eZ3E36x3kaqd7UIS3Vnkjq4E+9qI20/4KUthrbuJ1j2vU8FcwftPzTxYsZ/JfqkqDhvZcPbRvLJNkQc6CbOxbxRJBqCt5ziHxwd7ooj+IWU4J3dKFOx7qwjLQj2FVSif3MPhL8rvBoAZ1S4gdsTpQsBSsQKg8FmAj+w0Wx3AAqySwGqsLhXqaMJlRyVfT5RuMWM2D/FxtGZz1RIS2127Ssi6cZtUlR+WZN6IDkX47ExH6WdQRy0q7+Q5WFqWB8pN2QRjrztMhFDSPLjd1fu7dBu0eZhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6447.apcprd06.prod.outlook.com (2603:1096:820:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] media: atmel-isi: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:49 +0800
Message-Id: <20230706101100.75654-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c264b5c-f35a-4aa0-95dd-08db7e095277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJVZs/PJZKK8v07t19LpXukhBY0vMSqwzkucJV2qj2DjfgcBE2zYXd/Ll3OKIEqhGaJOwK6PQ8v1XF6Zwl127T9sBlmKn680Gm1EfZjJBmQHKgvS7djkyx8pdCwYSd4X0/Mq/6wjBMFHKHCzYZsDgnNfvXkycidsheHPuHHE/XCvFL1k7m641owSKsvGGZ0WuGOdGPkw8u10L80JKb6hD3qUS63OTrzXG4RsklrfmKLC4IvUL74Iv8E5enNiV+GXnsxNxcfwuenuer4zo6OSPMbTnEmRoBNLAvZFklZyTRG4bQHDSIYP1+DOgoQ1u8eQBETG+yWEis2nMegyXsq3/c7mn2AeiUfVlogwadiScdt/NaorplNAtvrp8SY/Xza6VAS0y7c3X96kP5bZgF6snIAY2oFAFXKBKmkU4jyBMTAhAoExNAKTuke0c4iPE+kGneRaSQhZ8aqUceFRelnYefgVMOuoUR4FLI9A2qNUfEozLX/rnDcgqCgIQbnIhYoZOo4fy86p17pF+Knasb8hK84qUy1E3Z6u0CsF47EaWhpCJW3M0yugfEP9h+ywKSOM5euntKRClUwdwX+Se5hiE+Pw4EPXQlKvr3imiW51a2oeNAGVD6aOtYqSQ15KnymH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(2616005)(83380400001)(38100700002)(38350700002)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(36756003)(52116002)(6512007)(26005)(6506007)(110136005)(186003)(1076003)(6486002)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trduAeWOfMRL6SVXMB4zKTpldh+vOfDQow4EVFyznrkCS4rfEnO71vCkjBmq?=
 =?us-ascii?Q?tUyoejO5+IX0HRICWHjPdJsgt/1uajXGv9UijsJ4TKWSBBx3s/WoaPotvyIK?=
 =?us-ascii?Q?9i3Q6DZCvzB/v/UItxL0u+P3kUwG+x7iN5RoIch2Czgy5gJLV5FHyBPQ12F3?=
 =?us-ascii?Q?lDDXfFbDKF60hyRnXgWQPyxaSOD41hNUJ+/1GI4oc2rbb2qmDGweXiD+4sw2?=
 =?us-ascii?Q?O+yHr87yJyDvASZQ+leC8MCVqCx2+i35/KMcLTUnZrUTMvO7jxkkDHgSGn9/?=
 =?us-ascii?Q?3DkwaMiTfJQ1wjYbObaflGOCdj90oBpoa+V5gDm4ahQFNPHzyrGPo8Y7lhwt?=
 =?us-ascii?Q?W1dg4KQvCXTO+mGtfUbstCSYN2zD8zu13W8SCdnjM0yf+ou8cIAAbee7aJZl?=
 =?us-ascii?Q?hmItovAMWEfqnSQwVarAYa/Nnj9tXcDw4DeJENjQpMkgVQodDHD9UEZHGYVY?=
 =?us-ascii?Q?vUQ6O+FvZjHo+b2Yd2rtBOZ7DEaRQRlAedXLg36lfwJC9VP0V+GdCPuwKMo6?=
 =?us-ascii?Q?qxKKCrQ57NR+IwDThRRxu+d27kJ89qAaj7lncADaQ3R4QBpugiN526k4+7e8?=
 =?us-ascii?Q?sZQOV31EyB6Xz6fVgXhifaa+Mc3jLE1HSjm4it1+SbRvaKx6gQFWYtS9yWED?=
 =?us-ascii?Q?w9eFk/HW3h63gjy8Kv7YzXnRiC22TU0/izT8OY4t6PenTLGW8/eL7SNyZEIc?=
 =?us-ascii?Q?XaJXRhIciXBsXtICPuLCOAAOcjDSbDgy52hyOHfESdhsx5K/ym27db1WxB/l?=
 =?us-ascii?Q?CDuufeSdoK/FrhdHCTosQcYhimMmdOLhnWy5+k2cTv0YXQRE0zLjUsS6GgOx?=
 =?us-ascii?Q?sMrwVXXvhTRLi4BqESgJAtZu7ohgPExSCBMKHcqAY+xMZzQzFLP5/vJotTsf?=
 =?us-ascii?Q?ZcAKQqFEiVtra0PyhR/wyVQAKtqljPw2Z4e/wrwPqs03K+Og+bRxERi+xhiS?=
 =?us-ascii?Q?uVooRV5YwtlO1yVv7XrIklbJJiOn70si9Lpgz4/gvUK0hjGnuv3EDThQJXAh?=
 =?us-ascii?Q?m+dh6D1ERTbf7/cA1ZplPFip36HhnEhK4FewCL6mCHh4Gr4uYKglHJdLeVqt?=
 =?us-ascii?Q?CjKP72eq5d+7cmMTIuoQlH6dVoOyMe2gn5blYBtbKYtE8pX0Eq8kY3IQei4K?=
 =?us-ascii?Q?IJw35pqcDRDCbsvu56bIDzLLxppIEATzkqqd031r2b5tkrgAZJ07PPvqtaS6?=
 =?us-ascii?Q?NTWOFlcYsGruWtPhDfyxmgJcI1eEESM6Bq6xZRpt+hv/VHmrC+76U9xwPbaH?=
 =?us-ascii?Q?EJznh0IA6c8EKHJkCVGN9qYWGyMevqgV3OcC7kKHKjNXCUf+VAeWrmgOctbJ?=
 =?us-ascii?Q?Rdy43J9XXGWO/3O/mxViCBDZMjIHAUidA0texV/M1wWF3KueJzZZVQ2EAdqK?=
 =?us-ascii?Q?HA5D46HQ2Lk3G2Ni9fquFE/UZpc7P/g0rT4he/p1X10cV3obI7mWh3B2UMQj?=
 =?us-ascii?Q?tdKqr0zGd7VwIE2i/x6F9fn5vLDhlq1RF2aHk5pFC4ygcBhTqFFrQNn7+9Sk?=
 =?us-ascii?Q?A/C640Odp6WMDCMJMS5/+awDL/6dCcTbcmq4tIjw3sInhQR3obbr1g8EP5u6?=
 =?us-ascii?Q?GhoKuThfmKAj0KaZaazCGLm8bKTcDth326cSLXWD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c264b5c-f35a-4aa0-95dd-08db7e095277
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:10.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaTVek0+huvfhjim31cSA7gp8PqsMd33MWiknBQhpuXErGh2fRIy4nCNVQgdBJjm3FIIDWXjMyhOQ8zUB2rzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6447
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/atmel/atmel-isi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index c29e04864445..086353198d2a 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1187,7 +1187,6 @@ static int atmel_isi_probe(struct platform_device *pdev)
 	int irq;
 	struct atmel_isi *isi;
 	struct vb2_queue *q;
-	struct resource *regs;
 	int ret, i;
 
 	isi = devm_kzalloc(&pdev->dev, sizeof(struct atmel_isi), GFP_KERNEL);
@@ -1268,8 +1267,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
 		list_add(&isi->dma_desc[i].list, &isi->dma_desc_head);
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	isi->regs = devm_ioremap_resource(&pdev->dev, regs);
+	isi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(isi->regs)) {
 		ret = PTR_ERR(isi->regs);
 		goto err_ioremap;
-- 
2.39.0

