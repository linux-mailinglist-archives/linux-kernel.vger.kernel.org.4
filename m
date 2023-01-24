Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7270679096
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjAXGBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjAXGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:01:22 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8AB100;
        Mon, 23 Jan 2023 22:01:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5ipIeDK9yCyRSdve4NDjIbXWcv2I+/oicim13N/s36ZAALl9S8eQGkaJEcDhqeSLCheuUxWOzAvc+ODKyyXuoIh0Io0RzzdyTQOUi5UEdD6QAy62n9iBocIDpY4iRNbVKi2Ec9Oq1dVkWBMeENRfbiKSdJx6jqnLtyBuIblka/5hnnZhB4wgKNU3ZfFXq2VzeqPLsBdJReEokEIddw2jH6jUj1ZceLARnrv0InzEbfnvjWYGVIrCo/DbAHpm+koqbse//Wf/xAIvEaAK6Vyf0YRe1LSH9X59Uq1Sl6liQCVIW2b4ui41e28luVVGomUCwofej1zB2nT91Wj3L8LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGHRZbjR2vwDdoOnHgHnzDp8tBeORMaWDHwbnFIU8pQ=;
 b=Vp8QS6Zmw8TR5aq/fjSqG7+CvFxJVzFbziVjWbzH6OuBzzoOSeuzwEoHrPKzPfYooXoP62UF8CguSJMX7LG2jAjxQX8IQx7xaS0IBXO6Uutt58mn0GtPRoAyQpg7wrSCZtLEAw754IWKx42gwbccgtJ5kn8AT7XOzbCACeKR/IaUYkro/bWHxSo+ug+lhHDqhXyURIuSz/sD9sPPPE6fTicoPwtfd/DWlE/LOSueNux3B1V/zi5bRTzoh5IlFMqcK2BfMmLKaGQLUdY0+97OUW+ygssIZ6XeTLeBrSYBUkS3Lz4kKlTSVN2S1QCSPiTPSKI+eRDdP/iaSXTGZOzsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGHRZbjR2vwDdoOnHgHnzDp8tBeORMaWDHwbnFIU8pQ=;
 b=cD1CbPXNrenO/rayBr0u3uEOodNHiztBm3FVMKWZstlOk02oPqKmpEfloRKXJmP1moro+CeD8OTXudAq31DqtVPgsWZOll/dQAeBxr6OsLaukGqdAfEuqX0us+LJb4VUdbeK9b2h5DYqNPT56Yw8POpYXaWEO0WZTkDdiGqeXp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB8949.eurprd08.prod.outlook.com (2603:10a6:20b:5f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 06:01:19 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 06:01:19 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v2 0/2] media: i2c: add imx415 cmos image sensor driver
Date:   Tue, 24 Jan 2023 07:01:05 +0100
Message-Id: <20230124060107.3922237-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7794f861-0b44-476f-11b5-08dafdd06946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaSDicYiJhJ98zxHv9fLuSnTqO6RVSSvXzzQc3qsp9kGETld53Qcdu6ycLIGRi54i9NcqGIbcyROicZ6FhvJYEgOxx8wJ5+J7IzxgZ09DhW/H6GKAO6C6ONuEh6j/SsPVKG0//uvD25/ITn7cZKMBOstqxBEmTCiJMYKcw9qcKeegk1beY7d/nXlO3+0z6GvbgJlIWmzCkujszHXauorzOkIKkbLN3EA83w9/DS/Jg0yLMv6mBMV+jy4/RaNvbcDql39LE50bNuMA4sFSXtBVfOnbTHA/q3AHFgBJOYaEHvFhrjzeNSlJaZ/zNA/tmmsaJn6ycqj86DhpYvqLrWWxR5UW+Y6K1yVA5AJC3oALzEohbVSLtXjGvH3NMq7cV6jKEdvhgmfFJ/aZ9ug7Ajhkg6PezX6am3JmL25nELb+wGRNIdcbGy3jE3FKLc28qWjK1tnUJt/cBwHCZQgdFvZ/Zq0uhEid8e7FfOLzO/+rJO6+0zko11s1UMiZHYfW3hso6CCPUS0gPnMzfS5nhQ5PtecIxMoJsB2sxNw032JrzUmaKCD7WNauFaoJspem5CPlOlNiDCuorQFRJvqeyF07RWIxZPtxwgnDoAN5hacH4zvhdX1JeQbkE58d5se6a9ypNBCD2zE9dCc+/MkN/nRmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(451199015)(86362001)(6666004)(6512007)(1076003)(6506007)(186003)(478600001)(6486002)(2616005)(41300700001)(316002)(54906003)(52116002)(4326008)(66556008)(2906002)(66946007)(66476007)(8676002)(38100700002)(5660300002)(7416002)(44832011)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZiQfhGRbTyh2nHMq6HQytl8kdjwiqZ7a1l2YwGBhn/fRzrdoejMyA+vjRYv?=
 =?us-ascii?Q?RjWKyp67+khDCTn0w1KuPgRHNfX5/+HoyxtEzBjdpqb9iAa977Du58Q33aoN?=
 =?us-ascii?Q?m2jeKmo6Ib0rzFMWAF5boxLjvrTZKpbLldaZh9YHlRfO+RbbJbfhhIDhIahx?=
 =?us-ascii?Q?k+XkQFbYoJ7306MOc7DuaS5GTp0uEQOokGF38gihRhRQEacMZgTvbfSOlANY?=
 =?us-ascii?Q?oCTJFWAgfxsm4zqLzOkYJ5AoWNBcx4h+umdjxd+rkPaEZqo5P07BDxnivAeu?=
 =?us-ascii?Q?+PKpeYttsVE3KOw+JVmcxxt/80bjfIRGbpwJJtjKBlnIOJsf+3bDmISoRqmg?=
 =?us-ascii?Q?96zlNeh92FIikgJ3Zrt5lKEy64+dKMf/AfPapOiy4b0Ub7bTCJe+RfMSvoh0?=
 =?us-ascii?Q?RgpJs7jesktAajNt+uzOwGOBJc02j05k+TO0RzCUv6VmCf8bzuEBb4yk/1lN?=
 =?us-ascii?Q?BQ5WmX9XdvSe4HPyVh3h0xd7YNuCE8z/Zu5dW3xyNXWgUuyZmKxRJZ8YyoZM?=
 =?us-ascii?Q?Xr9vOPTnTaaUlxqykoWeHqiBPyyH2tA8bPgjKFx3P176Vhm2H6PF+ok4n0Yv?=
 =?us-ascii?Q?ouGUBAlWNKbc8hgCc0kRf4e3cf78nl82Rpq+xPH0B2WGDuKoXkZao+vl9DR0?=
 =?us-ascii?Q?e1VvmNxL5ZsynrO/M7iUHF1xwIf/fYCQc4cC4asq1aimLy7BBTGx6Ip3MMPU?=
 =?us-ascii?Q?qHX0iP7jUW4JVzhdxXTzj79MTupVdGv7VZKHzFtuaD46BJ/2aY4es30OV4tY?=
 =?us-ascii?Q?U9jLXV+1BOIT8XLwBEgHsLMDTl5b4b9jtBbAoqo7lDcg2V1MAGgtRyttZ/SA?=
 =?us-ascii?Q?68PJe6ClyBjaLwVgVVY/RGKR4g71t6YaCVn7FdA3O6qpM4ZB/4OdzG+xxDPR?=
 =?us-ascii?Q?MJ4UtkX6Q73oQSBtgDq602YRK8PfZ+G/CYFuVfjYJFwgp8U/VyIou8LBJf7k?=
 =?us-ascii?Q?XO5rioRRXXjm1HrmfOs7iysZ7zFN2HabxWDOm4J9cm7Wa3AQBVKM+/vk/VlU?=
 =?us-ascii?Q?HM9+kPQjlL7GJJ/T6iC1duHDZKJ9uBTWHSSVvAwNMPs2/2v7/rtyAylbDCDp?=
 =?us-ascii?Q?5qO0wk2DdNWhskBfUNqnGfjpwSOW14i89Yd6oFZGdazxYhIUcOU91FPUWhHz?=
 =?us-ascii?Q?qkceiuy4PgM9LlLG+7YD+kwqjNqhcX2/VuxcAHjOhpnK3gLS6diojuy0BkM5?=
 =?us-ascii?Q?cPb2bNeYaEO1dNEvAlSXvflxkTkRw2QIG7nX4eaGU1vb9pxCBwnGvLdnSVph?=
 =?us-ascii?Q?+72mDY2IggzUMkpKBBLIM0lLVGkB9WhE9Q8QxK+cgFmsNXO9O8URMmS2IeRA?=
 =?us-ascii?Q?H3vGA9+dWp5wM162svki1DY0ZP46LUeHmjSW9+TaWBs9xXIlvXAcdba+XerE?=
 =?us-ascii?Q?TM1wSOxllUCT8RhLRIFAUkvUAFkfDbYFEaLYUBxG8AHgyVEPrsd3PauoRyUg?=
 =?us-ascii?Q?WNGhhkcFsWQP0i5Ig681oEBQEwQyhX7QNr1ST9IZ/E2lscF8ujaiuClHtCxW?=
 =?us-ascii?Q?JegplDB064/TV9oKyP5BnU04x0XXhn4nf5/1I5aTX7mzVXkx89YD4Op3tFJZ?=
 =?us-ascii?Q?YHcZfN8lfG0V6p9YCLgJ3N4kYXXaZFBr5uZWnoc53HzlL8/1voTS45YAwHqt?=
 =?us-ascii?Q?h1VyCwmmqI+rx0lENnkPCRQSLgDCUZeFU7Iy2Ne6zU7FtfIYyrGqRfhz5eXh?=
 =?us-ascii?Q?nSgg0gO2pZ3OwVvq4y7BE9/zjT0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7794f861-0b44-476f-11b5-08dafdd06946
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 06:01:18.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKszYZKNBDym9kjTduDtUCBhlKnzCy0Rf1ktP2XdKh2y2wrLTu9LTuxeqEItOCn0y8yOfTZ/oBF2Sb83DR9xhMFGQAB3b1T4vRO3IN27oGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds a driver for the Sony IMX415 CMOS image sensor.
The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
solid-state image sensor with a square pixel array and 8.46 M effective
pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
1.8 V triple power supply, and has low power consumption.
The IMX415 is programmable through I2C interface. The sensor output is
available via CSI-2 serial data output (two or four lanes).

Version 2 of this series fixes the port description in the devicetree
binding as pointed out by Rob Herring.

Looking forward to your comments!

Best regards,
Michael

Gerald Loacker (1):
  media: i2c: add imx415 cmos image sensor driver

Michael Riesch (1):
  dt-bindings: media: i2c: add imx415 cmos image sensor

 .../bindings/media/i2c/sony,imx415.yaml       |  130 ++
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx415.c                    | 1296 +++++++++++++++++
 5 files changed, 1449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
 create mode 100644 drivers/media/i2c/imx415.c


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

