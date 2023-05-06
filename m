Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39B6F90B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjEFI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEFI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:56:51 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCC49EF;
        Sat,  6 May 2023 01:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+ZFw6xnl1hYzuSVddmTjsJEwtFOSR6hH2zfJPUhIdAZsWHXWf5YZIf4j+8/aZx+qL9Kz0JuuHDsTUKairpK5fTQlXuZ8LAaIqmUDMvF7SdrlBktPUd/oD33na1u5QpVXWWg+A7j0dPjgm9jS8t6Y6O8r2WWqD+LV1ShJHN+5Z5RmhuU/T5VLTEfacGj/xkfPWx2HTdzyspyKz1F5y7NysgnA/c7nE+ItsTvYwobh/EnDm/kADf+fbV1YU4UaJCzQ6idoWVS+Ki66dTTBLEyKYGIg3hdgmVa96WdPPqLq9Kz2BB93LLCOC25TdfnqUJh1M0IuiRs//RTMbA2HXv8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LNPv21s/A81wgsD2AgcZGaXOy7KLCkEVkhLT/3xnC8=;
 b=cb8iPLHgyux8X5C4JRAKUYJFRO9uR+mRnmJHu+KjSJCZ/E8Ebstbx26j5MjRLlBH4UUpDWWiT6Ry34b6WQ66UjjJYrxgIrQCk6wwINCxEf4pZ/7OxBQREUGJxATPtU4posMW5vjKpQG4BV+/7NgrgQbExCVsNm2OdLI7UPSjRKJ04bapwXWLmE4rkMnavTxaXlPYmx8KIMqe3t4Hp5ELGbuvC0cXbea1lOz2xgrDuwJTvSILYIglBqv3PsZY9DB3lDHHInWsJoDLY4ZsXMcpuf/q2CYBOfqo1UIhNWzItZdAo+EJyf1Dgv802oqD0CLh/FUejF1M9x0cpUW1lFy+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LNPv21s/A81wgsD2AgcZGaXOy7KLCkEVkhLT/3xnC8=;
 b=CmXt9LvCrSkt40EN3GpKX/Aq4V+RGtACSXLNlxQN3m19L9eJiNi0Ke+PXdecFQaJ/WflYbc9RbRdoo2FiCFiQzc87Yk2uSiRKWWZFIJpLJyZWfFbqvA7r97alve7LVx4y18C8P189ObpzicU9ri19enZ2OcVZqIp32llLWNkPKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 08:56:46 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 08:56:46 +0000
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, haibo.chen@nxp.com, christophe.leroy@csgroup.eu
Subject: [PATCH 1/2] gpio: vf610: switch to dynamic allocat GPIO base
Date:   Sat,  6 May 2023 16:59:27 +0800
Message-Id: <20230506085928.933737-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 297ac551-5859-44b2-83b8-08db4e0fd1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psQMqaheClKEJTUFfPox1SEYk9iddc3AJGstZLsEkxoEFUXlFlQUap8kkhtfsZ2M9g0Eyh2BFe9hzJyPN5J3yDnAlsHa81VMVau+J5olGHjH5plWO0ndLgu6iV+GXO6yZGdlo7cKx0g1ZQZexHrV/p/UaC63aII2W+6/+nm+1ZpF1SlzjUB0WgIDeQGG8dbeOstkdzzOop6ykb+riS9LeC3kAW49fF5XCV24Co3NiN+OeLe5jNpZxvJ8Ho1b/bsEVbfuZ8Wlx10rx+WjUpxSM7/nH6OapHubIHZ2yrW2Q0GQR0ndI6gGCjG6zvE6mZveBKk+/X733GHpFNhstSLUqWaYBVaqcEnCJngwJ8ICTEjnpXiFhJ1roExwUZW+hX7L/gQxiBoxw/Z695yotqPPa4mhN1vE9Ka9GMYCJ3rvrUxU6rnoEzFL2Dm3JZV2Xe0Zyk/a/sIxGLhFfZ08dBu459AWHSRry7kRhezN6swMxJC+8Fkg0bjGNyNUZ3SmTJf+WL3DGaRsig9yjc3xHAGwS9NYFU/gzFOxHYvUgayjMyKq9fWQKWN5EOQb9FsKmXTTr2vTFajFjE5E50D8jJRv6r1RtwspNORttNqTL61ocNxEXuc9N0zFO6thb7aIQxZh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(86362001)(8676002)(8936002)(6486002)(52116002)(66946007)(66476007)(66556008)(4326008)(5660300002)(36756003)(38100700002)(38350700002)(478600001)(83380400001)(2616005)(26005)(41300700001)(2906002)(186003)(316002)(6512007)(6506007)(1076003)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abZYqCnEwRj1cu2ss9kBTjuhefiTB56CYes4g4fPbBGliOr6Xfj9gtPCpMQe?=
 =?us-ascii?Q?Sp2CS/XTQ+Brwb3HpLhqM+RZ6/hN2r4L1dFdndqARyZBnYpCGuFwc0AVvrel?=
 =?us-ascii?Q?w5jU8kyNSpVXsXEpHosrvd0SCfTCOG/7q/Jt7OWv0CJEsV8ivjFKbNa/wVdt?=
 =?us-ascii?Q?swVMtPFnMmurbivWIyrcqx9JnnxCnefo5DB7Hbd2FRk6HIhjD/1Lk83Dqsr5?=
 =?us-ascii?Q?UU6lfKBnLKI1IV4bkAG98ep+yiZTUSXMUlPwIGjHRtqL0KRtLQAdHIZxZ1vB?=
 =?us-ascii?Q?pMAzdbcMdKJlHoLKTgjD/jHKGu5k3ZNr+poaq4TU7IkyIeVLXgu8hg9jKXW+?=
 =?us-ascii?Q?shCRTj09zu3WkhltPbhR1Bh0MC1QzqESYRaxTsjxlo5pPs3CCYVn34wNJSOI?=
 =?us-ascii?Q?OuKt/g1tu0uulwpi+8yh0pvITBLoAoUnQfSIB3iH5/ts1r1OwdVKMEqVW+Sh?=
 =?us-ascii?Q?l+7KTpZUZTypC3oF6u1GhqJkIgNg90adVPNm2GtHfkRBhC/m/NVjC5H8SeyS?=
 =?us-ascii?Q?Enwe70v4eeaHSYVvX9B/PK0VXiZcqeZ7q3j9MXmM5pp2j6eiTvO0b+L7hcfm?=
 =?us-ascii?Q?dwXTXZjAcppmQjWNN6/o3jKrhJ+woLHAb2Cus7DQ2dgAPqAsfc9JK/HMSOp7?=
 =?us-ascii?Q?aW3XTCmC+CAK7aUhGIlp2Z+UaBF5Bww+Wcl3TI9lfOpvG7SiNjamWpqD31F6?=
 =?us-ascii?Q?X5pPwzF1W7fRR+96Z2GMeFWi4sPpuLBVca/hh5tJb9u+C4y7iFRuv/n8mlh1?=
 =?us-ascii?Q?vOKtFpF56krVebgRd2PIy1xI2zVTZM5C5TAwHZ8NCBKegGGMim90pVLeM9nk?=
 =?us-ascii?Q?zU3JA03ELbiJJmxoomCvf/7TyN/NNsoL3YXhmHHLShKjaHC9bq4z6a107wOv?=
 =?us-ascii?Q?iFqYmWcRYOik/mdgwhvkGOB2UfVX847Rg6CSfQcbOn1No4NYIhD+7hLG7yC8?=
 =?us-ascii?Q?hT7mypVAbao/EwTkU9fjnafobbACVo3gzK+JKrsHTd1HAHg1NyOPBaok+FIG?=
 =?us-ascii?Q?jeREagVSyk9JDZ0aUXzM1r8Vimir10dMR0N16H49AxVOR2p/GqKQ+/qWPzZq?=
 =?us-ascii?Q?fE82VGq3HyfL2cxh2KW9mGV75gehsCc90ELrkjkFFB5o87SQuowfvdz7OXj5?=
 =?us-ascii?Q?wTz6eQx8+GsnediEA6S+Mw6whP+3zNY3P6lK6WxjlJ4QpyXbKR5UTJo8gjUs?=
 =?us-ascii?Q?ROpgTARYjOFIyCYQYMJWXr05cBpoV/OO71LrNzMqcXDeQVZ2jdpk53ilN8Sb?=
 =?us-ascii?Q?3xXLfg6XcsLB+zmrx9jc4RW2EHAFjeHqjKT3Q2wwITQYPoiofdrdxsEs5ZCY?=
 =?us-ascii?Q?UsYnhL/nIH0TOcoBPVPwMStexYRGaCNQ52h8yWhjU4agjPTAZp6kyKjWGUM4?=
 =?us-ascii?Q?NhSKtl8x94CJKAlrLkDmPUkWeyJLDiUC+RpxwBRp45amA/Z63XgSVr0vY+5C?=
 =?us-ascii?Q?FAkXqyy5oMTrvAUA1aAVe7Mqi/G/nREz/gKUxBTlw3w2RI7ur6DcmJta4wTM?=
 =?us-ascii?Q?Rpf3IW+wMt2UyJkvLplgsg1oVDmADtHFkxr3NMXOugDeQB1MUdDJyS9AsQ6c?=
 =?us-ascii?Q?nXSyTDHXJ9+xWypSsf9Yw1o2JnPkw6U/RLFAd8r+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297ac551-5859-44b2-83b8-08db4e0fd1ef
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 08:56:46.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l2WyHKr45bVNAB5yo9EmoOAxk2HTNwxPD9BjnuFjWWLBwupx6tsl2wfp67OhJcwaITRP6y9CGQjTF9rT91Frw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

gpiolib want to get completely rid of static gpiobase allocation,
so switch to dynamic allocat GPIO base, also can avoid warning
message:

[    1.529974] gpio gpiochip0: Static allocation of GPIO base
is deprecated, use dynamic allocation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index d3f3a69d4907..70e16cef7738 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -259,7 +259,6 @@ static void vf610_gpio_disable_clk(void *data)
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
@@ -319,7 +318,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->ngpio = VF610_GPIO_PER_PORT;
-	gc->base = of_alias_get_id(np, "gpio") * VF610_GPIO_PER_PORT;
+	gc->base = -1;
 
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-- 
2.34.1

