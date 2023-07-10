Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2174CA08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGJCrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGJCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D98124;
        Sun,  9 Jul 2023 19:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5C26/fMZ/rEQIUEvna7Q0+qY7AHhc05bxt+vBk/ZooWk3e7+mqxBPz7P9PrCHS4TgNAmFtZcDVQZP1OWGIwTMj7ryZ5FiIIt3RQaTDktBR3/ByOH4Gjpm94HvOm5qdMX7IAw88gPd/vAaNPV0tCxbVCoXXQYWcbTyyraguD0ZeYiVPmkYQBkLks06oKWRzAm2UnyhSqLsZiMykhRxTOawikZn9HcssKZo2SmPJpogcPDlra0tfbam3Rk2lEA/m1un+vxHPeBg9yQJJh6aryrG5BltXCKIpNRA4q2Im0kZcc3dMmw82YJl/9cZj/GOWR0Q3DVPyhEoxwfwfGt/hp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wov0WAPng7xGpQnpD8bQ6KyMcYu2IsgUV+Bxx9CYA8=;
 b=Dg8cBGrIZTWu6fPOeXRLLtNfV4ePGtA1C7X3H277S3kSJ1SFt0uJQ/EBX+OWv0eCjwNocnVtQG4LFJN/DCvranGswZS0nu0YRGGpy2ZzuksPkNcab86PNbC8YpGTZ/jNQL19kA6jlE9GneMibecjUqHG44u9ft905yadwrmEp8OPBSu/mv6CKb0TvpRDgEixkTV2n+jinQsZQVAnSouX1hzGTSSGVFhOt7ELZWBKUxXP/fOkOSfxQWC5SlGBT0O9a+3Ljvlrut2t2s3wTJMaUIaDvs0vFKDl/gUsPG+foRWzEVFQ1dPRSpoZ452Qu9T7RHlok8q0tV0jUI569szM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wov0WAPng7xGpQnpD8bQ6KyMcYu2IsgUV+Bxx9CYA8=;
 b=AF5VJyG5FoZJAxYwsROWZB/bY9/2C87oKoZvFXVbj1b7YkCRcibMkpsJ1tDq98Y+z0sTpdO4NPgKqAAb30YgFSsYa42yK3cpfeuZXRx7QlYErq/wQcjMGjz/Bamqarib417bJ/4DAWXHq+stYatsltn3pvklQNeGoU11xnx/COqHPggblqwrRLywZImirPyT2fKkk7k4GmmpxJbod/O4qD/YzKcZ74JFsgON/P3OcAeCEddz78IFU0+xF3azVeVtxTm1E9Hwhd/Vh7GiAOt2oTR+D1WZtkoPNSo9nTD5yQq/gtIxdnDQexzLTIZh7Bkv1Adc1JOZQP2NzpmrJEs8rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4273.apcprd06.prod.outlook.com (2603:1096:820:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] ata: pata_ixp4xx: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:47 +0800
Message-Id: <20230710024550.59544-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edfa45a-e31e-4d3a-c241-08db80efd5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atcorhVVJ6nl88HElI9fDNzrt1wzWY7mI0kq3sJNDyAFCV0JU+jDsprhY4XakCak3fbz2YhXsuyQSWWwcJnz9OBiZvrqJDHurJoobbU1mwbjLXoy/0uzbyXGcVGFGt6T8g/hMg0XRHE7/+OdOWOuJkrkzred9/OOR9wtbNuB8mQIbRQxXH6CF36Jfo44O6bSX71AAQdSQe1VsJq6DXVD2xX67SpIX+mud60dwOCFvdazA/U/urys+dJPA8XET0abZn4YNvopYrzgTTS9Sv2/diJTjn1l3BbRqRo9cABFqw9phqd/9UCrfXi/Z0EdZt8xxgmwYjQZTrufh/LR07ijm/eXbr9yJYlrf6AygvC3pBR+ZhTpQaj/LcT7c7j+kNOKVcT6Mh3drZCRQ/Qla1DMaqQrjNkGKPB0LR9gkFovtAzvKHS/kiRxA5svCmfzOzYOF/wYW5YCkCzZTnGAM/YLtvaV5IhT0HsVcELqfNBrJVNRQub6yikAL/GAplr/fe/h9oM0iDmqpM+EaJV58VjbWH5zjZOP13KYJb7H0GZjwEJ0LWJrs60WXD2Ceoc5c6ZcFcNmDcLEx4v8ieN2TaAAlXBDZvoUj+N1Aynki6NxZLktw3YcFf7n0OIdliCcbxBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvN8+oxV27ffm1PD3ANX0BJu1JmaqoW3ru7xMVE6zBhUf0uWkAj5iDVZafRc?=
 =?us-ascii?Q?lFUkywQFS2+KddtcXBVYj77AGlWed6lSEaI0sxNdOXBgCZvJPlVnbncvb8gH?=
 =?us-ascii?Q?5eJkzsVMvaYAeMxaqVioU5NmY45YHbVImJXmxh7EscCuOfzbni+8GpCCMWAe?=
 =?us-ascii?Q?9SzQl01QmQr2FZMhS5LJ0jm2iJG3DF5x1S3UfRwXWJz/5brOND/betKTaV7F?=
 =?us-ascii?Q?moQ1Wi9W6xThsVHf3NCsDNS7c3vEcFScvy9SvaIkGGQnOpjJ+3sGf1URFy9u?=
 =?us-ascii?Q?oKV00CKtuBd+CNDqrnHr/8XaEGgE4h9Eal7EF6lmOmAAFl0dFeNQHOQTmGDA?=
 =?us-ascii?Q?qMy6AIWfTTSMn5NqoBncKSL07yUrYo5guP6/DNaH77umpSQQoWlEJQJSUNjh?=
 =?us-ascii?Q?VW61JJ76bRRxRDIBTIqWzI4oBLw/uLTuIr39QXp7jLjvKbaU+IWgS+Za8CDZ?=
 =?us-ascii?Q?fylWdmeJrUVjPnGA0/6352b5JQELqMFoe+PT34f6jPYIQ+oBA0RBSxUN+/gR?=
 =?us-ascii?Q?5Tk0gps9tDArrF69CU+OvNrKA1okvMkFLouj1iDPlX1ZdnsbWCY+gDF2t/ZD?=
 =?us-ascii?Q?boikytGhJPM183YLufdSN0OnCALFmh+dIpauVIS/1TFFzreoA4xnoJQoPyRF?=
 =?us-ascii?Q?0TbzW43TqmQeO4HmKd6QDdCnK6vi7bEA5gf0e460yypJdRsKAYqemgBM8nZ/?=
 =?us-ascii?Q?Yv3s5mgPvxA08bsgPmTlqTaYWVZpopOCLzSnQmFoppSpwpWY7vTjNb5WReJe?=
 =?us-ascii?Q?xvzwhlzCbzWgGv6KzWmaKXKPy5vrx0liYuOExImiCy9FGNiA+xV/xMs070sx?=
 =?us-ascii?Q?iB8OBv/M9XAkhAkF+TlsNcV2gdjLc6gkZ4Ale0CNLc6VGZ/CtVkzoHXCb40o?=
 =?us-ascii?Q?K8Wh7KdYIGwoaJlGHkcNa5xwknt6UkOcg3tvu1ZNrDoSQL5lobSY1UVBNUZW?=
 =?us-ascii?Q?vyDRCCtEAJ+kqnEgRMOGQzYPpkiFfIGevnaabwxf2a3o8IDkpFO4XJOQ0+Xp?=
 =?us-ascii?Q?PWQ83o26iKxVtvwcJUWg1G1MqoKsxg60ixGKMjKCiPxut4Jtl+3KzQ032LSQ?=
 =?us-ascii?Q?UJTFWTBh/Iu4qOMCGiLbbSrnlMDFhFETD1wwJ7XZ8fcB9spjduxYUsrrAZQZ?=
 =?us-ascii?Q?HdbrZCvwKmQyDsw8AXvg8t3bdryDCH/s3SiCK2WR3jgxcTCieovbocHGYESz?=
 =?us-ascii?Q?RUpfSsQNLubqYz6X3cc+ssfuLgKYYLN0tIo8eHhgiJbYlpQWEvvuoWJsZREU?=
 =?us-ascii?Q?I02FRSISH1wzKjixqXJCvM0sJ0WizkTiHbT6BKvQbTddVhfmHABoi+jXFt7S?=
 =?us-ascii?Q?KUsjSYyQiJrBhYN2Rpe85UJFlAdwD0ZA9I2J20eCIbjq/B1ily1LlRJeZFWS?=
 =?us-ascii?Q?U9HIZHitGqEkSIQBcKoqaHyNC6eOnnLZLGXs1u+ha0jxrNJZkV5zZunW9npn?=
 =?us-ascii?Q?UaEh0lbRiLoAJ2oUY4OQD6N1Vn+1+4tvMKX5x0sEAOzm0bFIS9JeWZsZ5c4+?=
 =?us-ascii?Q?sHsgfKZ7McgERa30zNNlEiqCK9dYbjsDEIeueQmGE6yqqlqlQHrDJ5wd409x?=
 =?us-ascii?Q?TJ18MxjKRDURG/BNpIs8I5hzhHuwErXQ1ck2d4MK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edfa45a-e31e-4d3a-c241-08db80efd5ee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:17.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dYkhtNrP/CttCbfuRQgF+LR832EqSQXrGxxfEKYp+Q58/JPrECBWLLhWutXdRzgxb72h6pZtaqtyWHAaMIIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4273
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
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_ixp4xx_cf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index b1daa4d3fcd9..1b9f67e16864 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -242,12 +242,6 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	cmd = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-
-	if (!cmd || !ctl)
-		return -EINVAL;
-
 	ixpp = devm_kzalloc(dev, sizeof(*ixpp), GFP_KERNEL);
 	if (!ixpp)
 		return -ENOMEM;
@@ -271,10 +265,13 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ixpp->cmd = devm_ioremap_resource(dev, cmd);
-	ixpp->ctl = devm_ioremap_resource(dev, ctl);
-	if (IS_ERR(ixpp->cmd) || IS_ERR(ixpp->ctl))
-		return -ENOMEM;
+	ixpp->cmd = devm_platform_get_and_ioremap_resource(pdev, 0, &cmd);
+	if (IS_ERR(ixpp->cmd))
+		return PTR_ERR(ixpp->cmd);
+
+	ixpp->ctl = devm_platform_get_and_ioremap_resource(pdev, 1, &ctl);
+	if (IS_ERR(ixpp->ctl))
+		return PTR_ERR(ixpp->ctl);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0)
-- 
2.39.0

