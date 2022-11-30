Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71163D891
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiK3OyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiK3OyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:54:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54212209B5;
        Wed, 30 Nov 2022 06:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an/5eE5d39Iq3EH+S0DDm9I2n955ytHBztdR+p/IGGif1k5C5k2hXvYWSTwk3Zl09X10g/lfGdwOSd9t73HRMJxyIuKM2ZF87jrAAlFVd720e7H+p2Bez7dikZaG1SAGeviNQnYP2X9LGdP4QHnL/AWUy201HEXJLjYoMg1IgAT7kGIkOZZsrDm2UwEukdawAIvQ4tGTmEX2ftjmXbh17cJagTW+0dnUuL/3QG0T9UQc5n1NgPTBE8bfA0v5hmbM5gIaqWt24KfOSSjJ5vDgNBmvMs0dW3cNRQWuke4B+F2Rh/UBJJulHGYi/77aCNcNMbzdD6cUvQWhhBMrzKTUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u0SbBtVJwcSYLULPGq75gJGwIV38bdhZh0teNuQ4Xs=;
 b=dnKOHf6d1uZhHK2gLrSXSYj1fM8HVZz5LFry48qBkQ4yFpzmWeQ3pAlYTxH7DrwfgLtgXweAQuDRE/fVnsEMSG38PiS0ibmJpw/yqUta7TqX2Iz7T1KJqFnQOV/69BfQ5n1bEwN1/4JPR1V0VdISv2BpeC0sjzh+Aopnd96BAkBxkwts0kN+CGJsNWFSprrsaURRB+imgTLJXFNQxWyjiSzA0JZu9JIjte+szbgk0f0VNGjG9n04HZjDXzuol2o7q9qWwHAvlwc4lI+KH4Ycd1u15ASgNiNIHvJNKpNHGmdVY6DMILPIP4F/YHuUUbuHHyVu0i9BfWwhLiOSWaoOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u0SbBtVJwcSYLULPGq75gJGwIV38bdhZh0teNuQ4Xs=;
 b=pUoOqlTwB1oVQ5rMDM3cmicVdEKTSbFZqgXgmbpI6uzHWLkrlT708VC7J5s+sDS6BoVXefz6NHEBSUaE7t0tAXPwl6GfI2eRowyp91to/vFKHuexUS625KA4wqP+/efSfi8mQGYAfWFaTsL2jO1BYquFY9pjH8XQ6jgKwSvIw/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 14:54:11 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 14:54:11 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v5 0/3] add ti tmag5273 driver
Date:   Wed, 30 Nov 2022 15:53:53 +0100
Message-Id: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b38ec998-309f-47d2-d343-08dad2e2bdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy+3Usn67EAvD/gAe+auqVE7ynQXr1KVI+UlT/jrdOFvv7TEX8ykpRA6dF6l5OQhhYPcrZkEjqY8ny2crWTEjdAMkRUSdLVdtxeVB2qwARvWVZzFDCQZdMkBa1irSDlxbg0l8tm9jQTmXre8v6itZC+XmCDhOkIE26i7mEt9zu8yZd7xMP6NDcT5N9TTK9ptXlBfs4mt5jXqoCbLSxgAu+ueu1na4vCWA7MVRsZzaueWpqLVsHJf4NnM1ef28/wArGpWPhenvhKRgEWab+YGV79/n3LSgGaXo9B2ZVvjMhoZZF9NG85exsJcY6/0sFmQ3dTcXJZGSFRoVdM36/cib1qFssg8wfSuAP34n917H3hLTged8mv2Cj4eVif1sz8//p8l8F0MuG/vBJ6VJtibBlMQkmzaKVW7pFVqI8ErS0Zk/bzeOy2/JetfJQ1qZpkZD9evRNytj0daUkBBV/Rq5Y2SILhbLrl4jM3iGraAPMBMmxNRMF/YAPzP6qa4PUaNEEULt0kXMPbQxv78prOzASRPnjf5hXa/nvicEROXKFhRBsseXIUlFcRsaF7ENLHbAfQgntBY6hWBOWyBAg2Bo07Ha2KC4yNDyNXtPfXzdN0VwmxHrY5Tn54vMyagkHbibXIAW48sTZvGYvGob86W1FHj882ZKTCvycLq/RMHpaeS1YD6/W05Nb22GrHKaUKq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199015)(52116002)(478600001)(66556008)(36756003)(6486002)(26005)(38100700002)(38350700002)(6666004)(6506007)(66476007)(41300700001)(8676002)(66946007)(86362001)(4326008)(316002)(44832011)(54906003)(7416002)(5660300002)(8936002)(6512007)(2616005)(186003)(1076003)(107886003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNSbsbDhAU+m4vMgsOKQ/kLw37PrQ4AFMw2RksL9jtyov+qtDzItlMvQY7f8?=
 =?us-ascii?Q?nNzg4f+LYStI4bQnyDZMkE72mXu5ZNjeFXO6GrmWhNm4i26eW2NDYtDGEDDI?=
 =?us-ascii?Q?vpjITteGRZWeXzXPRzbvL3wKqcN2PBMy7FcKdukuGsW3Y1Rm/+jaIvVbCocI?=
 =?us-ascii?Q?uu0jmgPFW6HFVIzhLiXuZvG3ttEW2zC+y+YkgCG3wWVenGktRW/z7YWbx6xZ?=
 =?us-ascii?Q?DsLsaDgGaujTJjAH1ghDG9BJsXsyGBsf75YnCZdKRMqTWu3EzVqjvBMqc82B?=
 =?us-ascii?Q?65NRL8DyvakKMee6/jcrJnfnOiWJvGaUzz5/qoxoOHv/hpZUmixr3dth/wxg?=
 =?us-ascii?Q?6L5fq/7TV13azP0VJkSo1wauG8sb2909q8SJcWzEFLRgaFcKlFiPElmdZ6w+?=
 =?us-ascii?Q?ulf7/N1wMPZFLhv90wXa6svyeJrA3CE9q+N0Vjiy5XlbpEShc3AmEQR/MDhF?=
 =?us-ascii?Q?8Nn+sg7/czNVBCGM2MAQRvBsX2THv+PUJ1ndDxquezYXUP776puvNhzY6Cbe?=
 =?us-ascii?Q?zhMYhIWiggIbWMPlkbuTUnpz7wOhwClBWTlkArIr+KhYL3leXFUAuQppCToa?=
 =?us-ascii?Q?6lkF4vC9XqzfKcMNXm6bl5dJMLDtBer3rGCKigjb4NglbR9H4FoBLiAR51iu?=
 =?us-ascii?Q?1lARutp7gsGfq6eaR02mY4CRAhrYAF87mgbLjPpWSSHb8wn7D+N08FBVULkb?=
 =?us-ascii?Q?c1O69pTBWNKszmHF+fLOMFCOaJVpDzMIF/vA4zvnTJ8GhisETfJ1tf+FPLVg?=
 =?us-ascii?Q?E85l5Y+b303LDe125by+VuyHFvxWypELwKArCJXM8eH/WYTFgIoPp4jKXDgA?=
 =?us-ascii?Q?iIGzLWXhfBAjA4IFUqAZxGRNbFGdxo4k0AjxJA0SexhwqWhpRLj1NF+dBZnH?=
 =?us-ascii?Q?6+KzpZGJxYd5I3ne0eLg7rrrV8HjA5lv32ShgkWHdUVrUR/YQtKBntALFEec?=
 =?us-ascii?Q?FbkYlTy1is7i/45ffJYMFGokHQzZEwOtIJPA4jx0xrZAWR0DmGpbI7cK1+1P?=
 =?us-ascii?Q?jAcRo0vw0W3JMafxJUlUgpQX0qh0Y1GmrRXDCgI81e/hMw3tOWsrY1tlBhyu?=
 =?us-ascii?Q?sEgkEWF3r3D2MlikXzPYm0jL3HHlpTyemmaD8x+0LmwJzF/yj2PyX3trJ9Z3?=
 =?us-ascii?Q?VsRGEhsbaVc+PEqB+lh8RC8YHuYT9Ic+BnGCrhUBTNLcxipdHpxgCGn7ChrQ?=
 =?us-ascii?Q?O6dcNTsvP4GZYhgykxX6eO1Rr5WFR5iV5QyBrgvjE9JtgGNIYbQ2UvBHxq9J?=
 =?us-ascii?Q?TO/TkMHy/IZWIf2yxhEhQmF1ddrSftgCSjY0cty99pxZat5f2Uu6BepZky28?=
 =?us-ascii?Q?1ItNZ+oHUhFVbkcMgtqEJraMPT6o/GIx/+d3LfrvGVh3e+AqWhasltDVNeiE?=
 =?us-ascii?Q?kRAs5LA2eHlVlkN7EjbLSXxwsSzNn2IqI3Q8LHTzL0wX4S75vT6aplI+QKDe?=
 =?us-ascii?Q?VFJD/gg1XvHnpn5zq/dM/RDafEcP+9YRhC15ytxa7Od7l6iqK+av19E7Omzy?=
 =?us-ascii?Q?u3WB/y+9CsjO83KuC22OpoPSSa1RzRQcnUyTZI4WFnEu/lFqCF/WKDhxHj4Y?=
 =?us-ascii?Q?sjnSEnGmYTSovoWd5TygyOK6B7/JAwo4caOvlq8b+nViCBPTscB6Wh/VNAs8?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b38ec998-309f-47d2-d343-08dad2e2bdb7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:54:11.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zMAsjAZsnJmHtUk9kzCr6II4kz0+NhzULkAGH0Z+/Vh+PBK/S0iLLxZEphI4RG6PZ1eTerwggTDJds2MEl4a0bjaebIbkR6UYXc49Nq++U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
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

This patch set adds support for the TI TMAG5273 Low-Power Linear 3D Hall-
Effect Sensor. Additionally to temperature and magnetic X, Y and Z-axes the
angle and magnitude are reported. The sensor is operating in continuous
measurement mode and changes to sleep mode if not used for 5 seconds.

Tests were done on a ROCK3 Model A board using the TMAG5273 evaluation
module.

Changes in v5:
 - Fixed dev_err_probe
 - Removed unnecessary '&' for function pointers
 - Removed warning for device tree reading failure as Linux should not
   validate device tree.
 - Added comment for device name
 - Added tmag5273_wake_up() and improved comments
 - Reformatted pm_ops
 
Changes in v4:
 - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type to iio.h.
 - Simplified tmag5273_write_scale()
 - Removed unnecessary  != 0
 - Fixed regmap max_register
 - Simplified tmag5273_read_device_property()
 - Fixed some line breaks.

Changes in v3:
 - Added structs for iio types to iio.h. Using these structs for iio type
   arrays such as IIO_AVAIL_LIST makes the code more readable than just
   using (int *). It was suggested by Andy Shevchenko to move these structs
   to the iio headers to avoid different approaches.
 - dt-bindings: dropped quotes from strings
 - Added include <linux/bitfield.h>
   | Reported-by: kernel test robot <lkp@intel.com> 
 - Added include <linux/bits.h>
 - Removed <asm/unaligned.h>
 - Added missing "static const" for tmag5273_avg_table
 - Documented Device ID
 - Fixed index of tmag5273_scale definition
 - Clarify TMAG5273_MAG_CH_EN_X_Y_Z as an index
 - Removed unnecessary print
 - Introduced tmag5273_write_scale() and tmag5273_write_osr() helper
   functions
 - Use of match_string()
 - Format

Changes in v2:
 Thanks to Krzysztof, Andy and Jonathan for your detailed review and
 explanations on the first version. This patch includes all your
 suggestions and some additional cleanup in the probe function.


Gerald Loacker (3):
  iio: add struct declaration for iio types
  dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
  iio: magnetometer: add ti tmag5273 driver

 .../iio/magnetometer/ti,tmag5273.yaml         |  75 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/tmag5273.c           | 738 ++++++++++++++++++
 include/linux/iio/iio.h                       |   5 +
 6 files changed, 839 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

