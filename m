Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C3644ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLFWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:54:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9A4A060;
        Tue,  6 Dec 2022 14:54:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM/sm7qUjU5jUgs/7DL+rIfGzFVGAjx0TL2cUfnVu+X88twbYN2AzBw1tEkOIiJSuoAEAOFvSYMfkI5eVzXSF2Sd9JH/P5Cd6DrDStUJk0jgQCprAfFCJPvwvb3PP0ylm4c/LUnSY/HsJJr0Opkaa8wvVk21P+vk0gayxbCc+FY4886u6VK8w0tMiQeN6KpKyvowXLo5KLpUA0DnQNkep2G4W/LRWZSzAQxS2DEb1Htu4cJ4Weas1GYhXeCHs07IyA4rC4OAadxLCYFZw44tQCoe2uqp4rqwE8Ooi9VeEOpRp7KX+hfgERtd3idiWsIceOQ9yWgW0MGBiVmINN5HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcK5aA850YMuuBztijnk1NO/u6DVdhGVehdDYsNuDbM=;
 b=VO457gjZq3Bm/Q5laqFvFVcwY+1s1AIomSam8lAKGyUcMQkx4/luPOtD0tcdqQFabkOSxNJXXO1AhsrggvY5kPNeTGBLz45MZ/jXXbJeX4eBI0weRoeUQQB0IE85BstTrk8IIsGWUuSAa90bIBPRznVg5MxAZ+6G4/XlWk224XiV18VnYuYetMC1UAzdjknmp02VXKyWBWGjzKHv7xbtihD17xFWjyL6Ds2y+AMPFS7Lg26BnWn48ygXRfwYr/FV49bXYolZfU5w7Ming+UY6wPKc80tI6ktB3h6+yyQAfZ/xb2rfWPJUYhay0ql/nls8MdPVKOZ93Jkm8ULLkB01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcK5aA850YMuuBztijnk1NO/u6DVdhGVehdDYsNuDbM=;
 b=CfP0F6QEcOFXp58nD603Phx3Mi5eaZ4ig7ZPRBssRid21MdAOcNCbHPo7vtP6wMQRF47wAbZ3SjPkFmZxI57Ofc5KDE8iAxvpZtykn1GZ705gmN+/PsvYC2XObfWcJn/a23Nd6oAR0ScwpoUgmWwoZaeUUk424oqjAJpnbKzzIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 22:54:31 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 22:54:30 +0000
From:   Han Xu <han.xu@nxp.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     han.xu@nxp.com
Subject: [PATCH 1/2] spi: spi-fsl-lpspi: support multiple cs for lpspi
Date:   Tue,  6 Dec 2022 16:54:09 -0600
Message-Id: <20221206225410.604482-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5b404-7b6c-44e0-26f7-08dad7dcd404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFHwy08r6co9wmz3hC3IoOSYO8t0Xs7p6Lnxks7EcgtcmJ71qQftNuJU5CddolUhNSx0zqIxOyYh3I0NDYXmRDfIhvrwqRGYYzowubP8I2jaUqe6RufN73UTpyijVyifBlOAow+WG2M5O4Sy7wvcQ7aJcl95Kwpy1/r+rtQoaWLat3RECAyWB+EXhjWEXs44k0zolrnOz0IgOQf7OWOJHAqN/ExO6dYm7RDfNqQvkoYmIJdKbod9KuZzdcNgOmMngcodR96AJJKajp4ycWBgDAbYzR8o7rNEVDlP6KAHM4rGD3qcNrogBSScruGgS5zZAdGuhe+DzT3YXsfnDINsn8tMOGindxEOC71z7mXAFLZ5pojK8tx/JMPM94eC63yl7Vum06Ci6t7YzfGyJBrNxuL+Dk/qFa18ld1OH9fKFVpDcyOjEFTrnQaNkCKvJGL+HN9A3W1BldYm32JA+9DBZ/t/DkP4AxpAXDr93JSUA1FKiQH52lmYRVJSCGGtQj3Mx8PhMik7k1agOxFzp9QyFHKQoZblmUOeGqp8qEzKdsJexka2ezYFrGSplpZfQZ3VfFlK3NF2EIjMOEvrObEUiH98W4ghP5TqXy1bcEbuOAMyCYwnXpZxi0g/02YIcaHZuBjfhze6pNjQSsLW2SJF8danLpP0icy/ZPXm79Rw8K3JKRUIYuyx3EJ146k5ei7T9/rmQAnSrsU0H1g/eUo3EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(38100700002)(38350700002)(86362001)(8936002)(44832011)(5660300002)(4326008)(2906002)(41300700001)(478600001)(8676002)(26005)(6506007)(52116002)(1076003)(186003)(6512007)(6666004)(316002)(2616005)(66556008)(66476007)(6486002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+ELHZ/eiwzxEUcod6xrsQTgLj3bUK0Vj4vU66nuHHssZz2qdgs7qnNFUKOd?=
 =?us-ascii?Q?6jNEUbBBNOjzAPwucC1FNrJ/ZBLUdtLWbGGnlyRQG97dqVqf8QRpH1Mhr99i?=
 =?us-ascii?Q?/sRBb0OGGWmfzD7YtD9ccNi9RgMOTV9gQeVIK7vBO9nDpIk9MCGiCvHiKY9g?=
 =?us-ascii?Q?1Ym1lkR6BUYwk3H2eqmev/HIu73NqOtzFqEjqwSFN+ZoyUmMQVKXiyWIp/NW?=
 =?us-ascii?Q?qCKeRj23PgBYKVc9rJmGJG5Qh2H/116YhgS+c6+uEDl3u2j62QTiKVKiUAgx?=
 =?us-ascii?Q?lZozzk3unuNk0xSBqXmGYnpc4FkZlPXeGnb3eqDfThnM7xLO0cXWid8avSYV?=
 =?us-ascii?Q?CTCQ10l6ZClfqWQ9QUDxYv18smP+i3aimMaaQb1mpxQ7oTJvsTG8RmtWYE+C?=
 =?us-ascii?Q?DDENO+Pg94EH5Uxv5YudtN7c9lNTez1aLFJJ24/ZF4BItUKVyq7lzqptQ9Ax?=
 =?us-ascii?Q?dib6gVlq17DZxs3F22IFQXGnBjGPpUgUMltT/N6sqRjw73aKjSONaUgFWdQP?=
 =?us-ascii?Q?ipipHQDkYa7aDPPq47HaFhN4seaiQFFyqYWDDZ8uXmHNxdCTBjZVrpo5AQ4i?=
 =?us-ascii?Q?btM4+Srv1cjfs3kK4t7zrwXlzc6r8RmI1k9L9QiENaheO6xGV/OKKEIEtHMa?=
 =?us-ascii?Q?YT+tnV4rMfIVrCjpjPfHR8AOhpUCzpEygKRNFEvNAlwIcU5HGWNGTVk8FGbO?=
 =?us-ascii?Q?UBpAzuLTsL2xPVHibMxXyL+V4WyHkthHU+9DOPrFjggh69/8jskzNwhSqQUq?=
 =?us-ascii?Q?sijGQi5FCQlj3MME8HjOlfrZfZzuQWKjgd0PVsrT0wsL3THMRvoSwWyK66nH?=
 =?us-ascii?Q?tqI9qtq31VKll9umlCUCND1MCu6DxmkUUvH+jIbnZTf7gdpEW87ENjhVmvgq?=
 =?us-ascii?Q?JsHKCduL5Y2CG5wCH8sT9ymiIDisvouf+ZQ3xjds49RVLxXH7NOnk9Wwo16C?=
 =?us-ascii?Q?T140TRWmoX1oBq5JNQpX2AMhWqWeXqGPclU/dRtDuyzcu3sIsrSEhlxHQOzY?=
 =?us-ascii?Q?d/SmYeA63KsMqjUUSn2nQEMANmIYMTLEm1Y7zcwAmq6o+Wo8lbPQXhjLJ/CX?=
 =?us-ascii?Q?QaUaaMuJjkqmJN0CcErs9lw09MQpPC1qdl7JT96NSoZokxxBqDG5qJv6Q1Vn?=
 =?us-ascii?Q?kUCQJGdmaF/HVVEiChtZUyE0aZAm3KyWnxLKXhRPVdPP+iADtJzUns+QgLr/?=
 =?us-ascii?Q?HYUZlfL2WFNl66MtK7m6XON8upC9QK/TPzm9Dl8Rajp+aLVkgweQoB22Cdyv?=
 =?us-ascii?Q?Eag9ZOlATtdJGG+rSK/YiUyBh26yFnJT7cPZya3sJL2TQOMcLD26O1bpTqg2?=
 =?us-ascii?Q?BUmCjDG0gI3eH3Fc591ASjovsS1e/K0OBUXdfJuYHdlaROB8LjD9zxLZJt1w?=
 =?us-ascii?Q?bcwyzeTyW0Qwbf7Mmh/3uo4FEwIOkKTDaxVChGBl3Mh1pLGbgw+bb+PvupA0?=
 =?us-ascii?Q?DwiS/vhqWLk3G+VjCK4RNgrWpd5fAteS5BGhOJLY3m2eJ63KOyc/By/7U6zH?=
 =?us-ascii?Q?MGgrF1b8T7+ZyGUxqqbHXXfdimsz7JVLlUBxGcJVkpOxShE+GvRkMVJuwHsG?=
 =?us-ascii?Q?tpdrx7Igkfk4pUa+CRc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5b404-7b6c-44e0-26f7-08dad7dcd404
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 22:54:30.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8LUH0qgunR6xqFFAN0cKEn8hB+R85XI2HqAht5YOyVRi4AY5pt4uSU92HVZCLwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support to get chip select number from DT file.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 6454b88c31fe..7f0562ed4d09 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -98,6 +98,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	u32 num_cs;
 	bool is_only_cs1;
 	bool is_first_byte;
 
@@ -850,6 +851,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->is_slave = is_slave;
 	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
 						"fsl,spi-only-use-cs1-sel");
+	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
+				 &fsl_lpspi->num_cs))
+		fsl_lpspi->num_cs = 1;
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->transfer_one = fsl_lpspi_transfer_one;
@@ -859,6 +863,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
+	controller->num_chipselect = fsl_lpspi->num_cs;
 	controller->slave_abort = fsl_lpspi_slave_abort;
 	if (!fsl_lpspi->is_slave)
 		controller->use_gpio_descriptors = true;
-- 
2.25.1

