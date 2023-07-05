Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C7747E23
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGEHWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjGEHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:22:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D104197;
        Wed,  5 Jul 2023 00:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuKR6QiqJQgbrQZ3RsV1TIvfwGlF8Acz8XSawRVr5KgVnwVuP35X+X8qLTMYeCtU+KqwyKucJv1gHPoUE0d2MF9yTb8ADv5BwPRBf0j/gz2HI72lds2bIKA3jyIso1fZxK/VIg6X30KppxIgY0ueW6xoz8uebSlbqtk/IBJkP0WjGJJk7dzQkndCcdcazllOeYMb4IUFcEc5oFK4fMRHWxvh6JNhWHkfWJJgdwTq8S/DU2jHuZZurBX94oBbAM/DBbGaBggDVdlLncdlcobU5a806ZloFmG9Mt4fk/ktv9vdvIwc9hK7/1qdU5lbiFeD1BLCkiGldiW4QVqGSjxLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve6PEfCVBMgC0d7FAsW7OHwtkTkuLNpqmg1WfY6MVgk=;
 b=AihtjehuX9GmORSx6WVQOVz20cISlixL+ygIjVd5NzUPqqwIfff6q8/thw3GCf7IySZMOoXGxZipgovduBxJYvuLCZppVwRd92FeAQWhoun9xHYlS3VZbaehOOmJs4bFvpmM/UJRpJgMh6xaB0qrOYwpgcxiU6QVi9xh0XNdf7KriOI0Avbsu8c1+pczQcuAYkpq3B+OSEig3M4moIQx51/8JZOJqtfi1hJVLkttShW0HV1Sfmfoz5jFrJ3BYGlB/kmovfanQXhuCWbfkDYvsTEv5zpQ6mtdz/ZvZx3biALEDbrPTr7y6w5GTB/KuAHB22GdxhxBge7LoihYqlqz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve6PEfCVBMgC0d7FAsW7OHwtkTkuLNpqmg1WfY6MVgk=;
 b=hwUKIc/UeTbgsOJRIDoz4CfTxe7iZLdOGmGJLlQyEWzcn/KbmuRWBj3v0k4Ua6av3jNOr9tPTC7wB/+WROOmvA6QPWqTk0KGQXzrjjxXIopRH53vvyX6trTriSR0fhQn8N6erzA76QQR52rnf0yOM9Ugv4aWPhJtK/TGUHCSE2e1yNg9o1iMlDBw/eH+Ixji8w/ec7GQS4nkCgcROzQXgJQGJhZmMlSWM0F0IAyZCkNYBIRfbQf0tpZYbQL2SoX5TToKC0XUm4u1s2DHQSIXA/FxRVvsKF2nwa8L6WK9mOd+/rWiS8DwnKZpFWJb0GBCG92oMHaxq2tNmuF4xcwr6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:22:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:22:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] crypto: atmel-sha - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 15:21:57 +0800
Message-Id: <20230705072159.77221-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705072159.77221-1-frank.li@vivo.com>
References: <20230705072159.77221-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b05f1c1-359b-48ab-a50b-08db7d288f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hdXSrAEaU2fuw0kLbB72sm64U7sNal2Lx4yxvbHLUY9sAJ+O0Asqx/B9V9kDHYg0Q9TCp6/sRXttE1bRx2ez18Jm/byTp+IdwKcRUieU17Fu5zhz+TDkJkCEpJrXzb1MKUdTm85UJFXrW2KVViqvozgiLSP6kux0BXffYvR6w1Ydwo1X4qpUnhGbkDYupWQ5/dtD3RPi89WcLw17GXLvq+o4JfG6iC+CjZ9cq9muR6VYgU7O7VA4zpNbapu3cAJDtw6SSxobXvvKQP8Sv04tgkFPOoE/XkJ1/hYz+WBQiEps1aE626UFB6+vvUja85gZAz9M5oXM+OSbEp/tcZVnFblJCvbTBhLDRR0TzuzX3tZHb519+vtL9kqVRbz4OlqgBJYAweUVTRQD8gV2CeRfF3javqlVj9S8FQkDL7+h52+fWvFyF3lyGO/S8ihRnd9IW5Fgdq302iZHgjsEN3gtOfOGXmg9iQZpe6lXIZz3fO6pvlWA5uGhLHRwOuWKlJDC/1zqYcf9lgbj8q8NjwoD8cvrYgbP5uVaBHWHgUEkd1STaJHYzs02CXK3v67xBhEHd1iD49My+5nrQTewyH5vmF3CWF3NtH3Hrxr//5Ic3pNuMWKQBpxyrdtOv4+/T9s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(26005)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(186003)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QQk8+MpYrQZSvgspUwswJDyv3yokCOsj8xZ2dImStytfPL31dwrCR+lVM+F?=
 =?us-ascii?Q?IjV9DWeRsziUZEgRqVY0YtofWT6q7iDRE69giJbNE+ldBpaRM0phY3CQ65RH?=
 =?us-ascii?Q?vmi3NFAKFQJF3MpTRM9FMWYq9KUPsmHqqWfGBA0PD4S6CgYlyZrLWiKvss0x?=
 =?us-ascii?Q?IkytsTiHDDW+F3w/738zjhfoiYkLNTg0gDwWeloKIOX6Wc3+3Lgt3aydwCA2?=
 =?us-ascii?Q?ort41iNA843vaz+PXXtk08tV6vT+53QqDnXp8ieXOgiRhEHMPfIWInDDlYtN?=
 =?us-ascii?Q?roN5sMwqkXMvY5lzh42xiyGzpNYXHJzLrHcXu18rULE7CfiE++4eGRtE4tbJ?=
 =?us-ascii?Q?ybpKC8k3kI+Q4/3WnaY5PGVrHNlh7EnrMsGz3gvj5j+eKDE3D+Bhmauyzc2v?=
 =?us-ascii?Q?oTU95tfO/0B+2jHV472WLd3jc95ffxTcEgDaSwNAPsSEZjZFTYRAM0wLQBqj?=
 =?us-ascii?Q?oGavB5Z/cFMtAXPa8tHnewKjJGNpkzt4lnx/VHiKshlRHIt7674yL/JFlM0B?=
 =?us-ascii?Q?ZomlAnZHvBWs1vXEm24yX8vg10lNrMXakcx5wQ0gtKTQXYk4xkouIaWGm+ep?=
 =?us-ascii?Q?4n8zYdWridYBHvSfM7tA9uMI9CACUL8i6i4Qwue8xBUbRMoDMDidq4/EikDN?=
 =?us-ascii?Q?hZxK9+sBYuqnEFcpsaQS68lX03vIIfWl1G/UvIxXLmYWUnfMQjND01xLnP1h?=
 =?us-ascii?Q?7wdWy8MDPaxC8pE6H/fhpO4vFeKAyOd0swYA7efzPj++8I0fdkNuwn3atVUl?=
 =?us-ascii?Q?A2FJir1TNFH5Ruch9q/g8CHL8NTqAUNowqWyTBJ24d49vnYZc0i+4p7XwB4N?=
 =?us-ascii?Q?IbGU08qxikYT/uzDmizpsaF6Ga6CblJazs5+hbmftKhlDLRw+xRVrXj+luqD?=
 =?us-ascii?Q?6eb0TdlEgFLye6mV7AivzZ16JLqiDXgpLh8Oyj3TXogFFP4sAYur9QBLWKsN?=
 =?us-ascii?Q?SWjiOh+H944sHTtIP1DR+SrSBYl5IiDw1CIUIL/mTBHXepcE7sAiYxr41Ivc?=
 =?us-ascii?Q?H4RHI+FE867emtCJLM8w8OG9subvSBURoyckSb3fJvdiEGGgvic1q10VABAW?=
 =?us-ascii?Q?ZQ1aZ/2XT4wbNycr9xB86KsUMAUUsGLj2ZLM1smp6CBmRJSB2Si4faYP7HIH?=
 =?us-ascii?Q?NaBk48zbIUNcCgBXNNgITxP+mg2ixbsyS9Y57uxF63ZVKADB3w5MEV0KGv06?=
 =?us-ascii?Q?j+lPL85DJRpVlAj/C2OZxXkNqhuDKb3W2a1uxPkwlAvdrpoSwumye8yaBpZe?=
 =?us-ascii?Q?cgOX+Hf7UcmQGQP9PSTYkN7uu/vguZYXP/IECVl6IO1SCudYVlX1bp+SN7lD?=
 =?us-ascii?Q?YMvKMReGitEOu+LK0oT1Z77HR1vkOQyUgqFoY9mIGLFDl3SZ4bmtS0EV6zqR?=
 =?us-ascii?Q?MWXv+DSHdmB+EOWWimQYZenYOqRrij8BOOTNW7RRFffw/Rq1lAA9u45l/MsK?=
 =?us-ascii?Q?Bid6PC1xIr2WXYav5fMDcyjCalBB9kPmJX02DvXi31u0D96435GYvaFWQKnh?=
 =?us-ascii?Q?Ga5jz/I7UZ0TJYoQydtr8pCYUpx04hyczt6mRgsNMyoo/a03E6m4sAu6ghjQ?=
 =?us-ascii?Q?OCKfftgv3nmoKct4Q4vCsLbrTktm1H2RJHtuyWp2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b05f1c1-359b-48ab-a50b-08db7d288f6a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:22:16.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6JESOvWFmIAg9ySikENal33p1p9KXaTTJrLL8bjjdVN7ipHWb4UFOvTW8rN2U86IZ9nCRNOB+hbhOs4a7q1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/crypto/atmel-sha.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 6bef634d3c86..f2031f934be9 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2604,11 +2604,9 @@ static int atmel_sha_probe(struct platform_device *pdev)
 
 	crypto_init_queue(&sha_dd->queue, ATMEL_SHA_QUEUE_LENGTH);
 
-	/* Get the base address */
-	sha_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!sha_res) {
-		dev_err(dev, "no MEM resource info\n");
-		err = -ENODEV;
+	sha_dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &sha_res);
+	if (IS_ERR(sha_dd->io_base)) {
+		err = PTR_ERR(sha_dd->io_base);
 		goto err_tasklet_kill;
 	}
 	sha_dd->phys_base = sha_res->start;
@@ -2635,13 +2633,6 @@ static int atmel_sha_probe(struct platform_device *pdev)
 		goto err_tasklet_kill;
 	}
 
-	sha_dd->io_base = devm_ioremap_resource(&pdev->dev, sha_res);
-	if (IS_ERR(sha_dd->io_base)) {
-		dev_err(dev, "can't ioremap\n");
-		err = PTR_ERR(sha_dd->io_base);
-		goto err_tasklet_kill;
-	}
-
 	err = clk_prepare(sha_dd->iclk);
 	if (err)
 		goto err_tasklet_kill;
-- 
2.39.0

