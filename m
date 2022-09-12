Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63385B5EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiILRO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiILROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:14:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46763ECF9;
        Mon, 12 Sep 2022 10:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvKQUbZyndsBVSOZc7G+TeClQ5J96hcbZC4DHIYFTBLuLd3TP/HTx8Ti6jSlUfPzZA+j3fDJQBHeuVQMy1wS0UPuf+5qT8lTEh/8psuiHozw/+lTd3DQMQUZ8OCqjdLy0SR3e6FgC83bWJascGwg1Nt+qcwKbTuLo48GbccBYNc1djDLnMZ8Qm+j4TwyfxYxJ+CZjnho4S+fuiCG7EQyDKcCX1fAqYt974ZGfcVwyDdypVn0GhAvxS8GCWZRX8m52HoQCMT6z0yWyImE5EH3X4SgBhN2W1xznQ+owirM326lM/OSbv3VXdX2xZQ5FEaMt+aKth22tWoxT6+hV6xnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZrdqc53FRVz9ej7tMsR96sIXdpSzYieP7Horn9/7LQ=;
 b=XntUKtQOds92a40ux/9IkW203SumeMXeA1ad7uwi2cPWdZ/tnay/F9DzAwJWUDNH6I4/m72twQ9rUpuIhCeQ4um4TIrx3375oNFAqgfEH9ixnuhGdjQbIplzRO/Q+xJts2Chm70XOSVnlGRbXoA8WmTrZE/IkG8thL4Gw5qo+G5aNBb7Lh+ch2Q2Rk1yeA5Oqv7S7+QWl9XMlrkRhemk9xPcoFK0Rn6kkH3d3nl6YrqjmmhLLJ2j8HpUn/F9FHgVbr0zvjFQ2FgnTZb/W7ZFi+0RWDbrq9IiSINI4BgUUGqwVltafhuZnPnchInNQA9EKzGrAunNybeCIBXH2GkApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZrdqc53FRVz9ej7tMsR96sIXdpSzYieP7Horn9/7LQ=;
 b=LFX3d1fru3em7m5KTgv8+qqHhoIbgklPV4WlbkUyT6rUq1fB2WJd3CP6CakR/Cv2dhQ4jriI3NRjtHnuTPtQXzSmp6NXX1D+tMvjFi3U/VHD7C/BSAoH+CyC8v1FRqZi1bmGmzLLb3E+dRwFkfY86AoNwY7TvgJSoGd4Kza/jtS6pznuS2WoPHnWw4anN98q9RX81AxGnPNr4Jz/7JP6sCAuKzERDZouiXHmV8yWJ5MxUAbBrqH6AoK5y/P/tuY1HrHpyyYFrfoxo2J9fzKpTBJGAhWRFU/gj6OIBcXiawTnY/lcb74O76bB42+KGt82ighH1n1w3nJQ8tCDZk5SNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com (2603:10a6:10:2af::9)
 by DU0PR08MB8729.eurprd08.prod.outlook.com (2603:10a6:10:403::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 17:14:19 +0000
Received: from DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8]) by DB9PR08MB6825.eurprd08.prod.outlook.com
 ([fe80::a88a:b945:e903:42a8%9]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 17:14:18 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH] gpio: pca953x: Introduce support for nxp,pcal6408
Date:   Mon, 12 Sep 2022 12:13:47 -0500
Message-Id: <20220912171347.4167372-1-nate.d@variscite.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To DB9PR08MB6825.eurprd08.prod.outlook.com
 (2603:10a6:10:2af::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6825:EE_|DU0PR08MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb64948-9cb5-49c8-03fa-08da94e23a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMe1XQsT35+Fx9jRs1+i3+wioAHyF+XUnzFf5ABK+URH4tU4j6jW6T+aqNv7k89N6fLwgPheQtFkPRdYoQAB3WCd8ymaSCvxyOyDr9XStUXvCgOBDh9Jh2oIRunuXcMJFF4kLj37cYXfLMR5Hm1l3h/pBG6s3BoI31rR/rtaVUOSzcERb8ZONzmhS9boGm6j8+EPpb+j/s3Uo5j+achO9lx6z9k43fJcFRb/8xvEsWlDzU2kYpF8p95p4RkgK9tyvIyxuk/P0D/I67SkWqjCu86fWjgTtwPicA0ax+Lek5kpfTlzqpqOpZgmWFG1A+BtFDGQRUxfrGVNjimzLsZk3X4XtoR94LoCz0O8kbb1ZRh0RrgQVKiTMCCvAm2TIWUY+KEvb0EC7wjoypF0+9bf+cFXWexAwrZBw9DIU9uJT7sSfy2pbvVjY6XmvYVW7f2Irxd2lAWyi2JarcXTZ5pAsfXlm192mPPiqnbuVdWL9D0z/4lyLZGiW56dWlQ9GJ2g5U/1PscE7urru89GSiSXCwPnpakgDPMNoPOU0KgVC5JAoHpCqXOPw9SN/kvA9fYSQdVOP6f1Qh8HGzMtmYOtecIFSs+8ytPGyniNVHFE2Yam5cPsgn3sKd6Ad/q9/1cHR7awLM6F1RTgiNqPmxylQJMiEbF0kraCEvPGYrVH4C9k6eY/2XrQHH4LTRflpfBKOw2RLvFbNBzV22YfQ0hdr3etUMKxHDF0xyxwKdu+OLOqxpzGEVTiSsKRXWZEAnBvWxp7MeAvow2Gu+yaKDzPMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6825.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230019)(39850400004)(136003)(396003)(346002)(376002)(366004)(451199012)(26005)(6512007)(38100700002)(110136005)(8936002)(38350700002)(186003)(6666004)(107886003)(36756003)(2906002)(1076003)(2616005)(52116002)(6506007)(66946007)(66556008)(8676002)(66476007)(4326008)(6486002)(478600001)(316002)(41300700001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FWyVmjJl1F6pp4uBujcmEJ58tSxd0ZgDH7sIQEa/fDirY2HIB3xijqv7uhsF?=
 =?us-ascii?Q?w/S5G6ydfRq9+lNzqUUZ4MmbrsGLZNwFbkJf/Sw8lU6kuWdWqFWGN8fM2SwB?=
 =?us-ascii?Q?ZqkN07aeWDsyB2AihQTClWsFw5g02Umm5wdT1Bp7Q3Q2ewaJ6Pfo159HLPNS?=
 =?us-ascii?Q?txoMQFGYp71hrFufBBarC+DzJhhwzGEpackUsumui0LcOnIpw+o/G2N0iWiz?=
 =?us-ascii?Q?DMqiZKBGf1LbSw010UFcsMcF4TA8yUE+Dqv6UHvx86jtfQ2LApvU+YObsZMA?=
 =?us-ascii?Q?SlClNjhzaJVkmwREwxk9w636VoTo0HmhsFNEWC4bf2zCmBph6UFnOqZGURYW?=
 =?us-ascii?Q?s0VWFqxLRTzbA6sFwBPLGtWMv/gWBhantIOH8FlJC5YWuK1bONFkYCZob5bX?=
 =?us-ascii?Q?dvyfnsBZt/MzQBddRW3nnL8oc2seyBz9QP0omjAPO+tcpqw3uHTMBkDLRmK8?=
 =?us-ascii?Q?G9QF8GPLCQFrbqqO8G+Rgz/qiqVuyExBVKfYxBU19dkLwZSNAm+voqmo+jEi?=
 =?us-ascii?Q?+QjWyqMbnyaE66lHruV86+i/m+2EAJIo50oL5kgy9u3sqOost95O2go3EwMK?=
 =?us-ascii?Q?ZGAwVdf2gZoO+aSbTtnsfdqwAGkSUbxs6JlET6l72UHbBk/IIDyv+WFPhK7T?=
 =?us-ascii?Q?2md4PcL7IY11XqUTFfPL1k6XlNCtAV1baGQ1902bLXhirlYTLpxEbJmB+w0o?=
 =?us-ascii?Q?fFQuymz+PHLJjtDvVfdQ6CgE98vVjKXalJhyG2TxROnFIEU0dWYM7Dh2OUeT?=
 =?us-ascii?Q?jhOvbBWdNEVEqyeIDtlW/jLmMKfvfWLcUyhyN15GxfwxD/McYILjhueN/BaM?=
 =?us-ascii?Q?ZhPDwPfoyi/hjddvZ725Fks17M8lrUflz963mRvIipj3fpMocM8XHaeh9Gtz?=
 =?us-ascii?Q?cn6Vv2xESu76RTwZZxKuYMrkkegsN+j3D/lWaoVCmmZDHlK9q9ZeQBfDXM6Q?=
 =?us-ascii?Q?81k5VvF2yX8wSvmG4BmN9qyjZfuEMonQQjQ13MDcsbqjIQwQfR+Tkmzujjnv?=
 =?us-ascii?Q?vgZponjKQENv9xth7ecUC3jwMFrieiRfYBmHfBW/AIdcLuNQh4lXJ0s7ObNK?=
 =?us-ascii?Q?AhHt4NcybHrDEJgCsBQaDhsDhW+UBJL6tI0uGSV4600Bkr0WmKawfYf1Xf1w?=
 =?us-ascii?Q?KKWW9MyIbTJ5ExtzlWwyF/4wfeAhqZxCpuLtYG3Gm6O/Yy3vY1sQcDoiddvY?=
 =?us-ascii?Q?HYj32TzlEvbnViT4Le2+85FuoUqLckXVCCzfbtXNMiqx/bV/0qF1mZerehzN?=
 =?us-ascii?Q?xTqAyCAnIhAgR5yb/vTcF9rUiMD3IYj0Kg63CpAuQMN3rnAIRRet3DhbWlVS?=
 =?us-ascii?Q?sD80HWHmLRdecCt1ElDExAERm2TKYet7i8v1FUZ4nsj+h4h2TPS4Af9RrdJj?=
 =?us-ascii?Q?2llptUwIwCliZ+HEzTxlQmjxSa1QBmnIvYvhk4sehgZy5+5bziEo5eMA2A4R?=
 =?us-ascii?Q?5MUXTRo7DFR/MRQlO9QPbFuU49jD2YEr3rGYp/+Zr5u+rwWcIPzFmkbzZPD6?=
 =?us-ascii?Q?RF2D4AbvDjguZHt7j5vJRAwo8QMyLwS2yuI53LVv9xHVU8kzvRWWJdnMkz+F?=
 =?us-ascii?Q?BTGkmOreJVM++5IiH0uWe3PuOM1VuLhdGgc13wm3?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb64948-9cb5-49c8-03fa-08da94e23a45
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6825.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:14:18.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0l1rqK7nnPOiJ9VujDwmAzfc3WQpD5EzdhWvoOP//LQ4gGRNyRcZVg3M7rpCQOvOjMdbJVQ/OpveyqUDw5nVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 drivers/gpio/gpio-pca953x.c                              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index 977b14db09b0..05a9fa92283f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -47,6 +47,7 @@ properties:
       - nxp,pca9574
       - nxp,pca9575
       - nxp,pca9698
+      - nxp,pcal6408
       - nxp,pcal6416
       - nxp,pcal6524
       - nxp,pcal9535
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2925f4d8cef3..ba012ac7cd8c 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -89,6 +89,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9575", 16 | PCA957X_TYPE | PCA_INT, },
 	{ "pca9698", 40 | PCA953X_TYPE, },
 
+	{ "pcal6408", 8 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
 	{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
@@ -1243,6 +1244,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9575", .data = OF_957X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9698", .data = OF_953X(40, 0), },
 
+	{ .compatible = "nxp,pcal6408", .data = OF_953X(8, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6416", .data = OF_953X(16, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_LATCH_INT), },
 	{ .compatible = "nxp,pcal9535", .data = OF_953X(16, PCA_LATCH_INT), },
-- 
2.37.3

