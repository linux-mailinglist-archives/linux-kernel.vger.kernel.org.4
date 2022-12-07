Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF0645F0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLGQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:36:21 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DAE5FB91;
        Wed,  7 Dec 2022 08:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdnqA/zIILjhZY3EAJNglpG0R+F1kFGP61FDtciCGt+mM6cQf9BWbLg5zm9JOJVgcN/v9pi9IIcc+tb1V/feuQ6iilZibrE9O1ROHWla0SyDQmdPWkA4huefVpO2FccDjm0JSvsUYkOUjo1PUEkSvSXQQZU/DnW4PjbXNHmA6GyO74SHb4L1V5sEcMrncERPRSo2m8mV8UzKkQ7ARqeBWXWFXGJeQiratURXT9eBWLcfMuYPs/HpK6UNKX6ELt1oKCRTYY1lS/K7stj1a76Lg0WrYJNR2z1mHi4A4FcuP+TFOsxjbq7qZNQNjWQrHJMBy485t5MKQgfD+vKesyKSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th5K7qCdw71Hsl+OSuJn78TM5KDNp/c3T1w8rf21KXw=;
 b=E1h4poGaA9syxGA5fVC5QS2UtZpHHBSw1+0hBY4ypvxdKSUGNExD48+kS8lh7x+uPIZ/Kj06jZgciv1LTXZe/KsZVgpXH3mAQsOoNYvaBxLW7YcHkQM/alWCva6OCyEwaYlSGg9oSmP75Vif2THnJ1GMd0t1Myd0eTp4EyLlVAihik4iEhl5C/dgmTP7kQy6eR60y1LsWkvmIdveM5YUj7jTGSXLs9IyyDi37MOrRWg/eLhdTjuyNee3mw8QKm83W7oWCW5aD1H59S4yXaA4YNqwrGlvncxEu5vRYsyMUV2SwKv4Ps2m30XZeCc+ny2HDCQo0+Tb9yHxqAsapGTijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4278.apcprd06.prod.outlook.com (2603:1096:301:84::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 16:36:14 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::5e0f:1a7d:ea7a:8b81%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:36:14 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: [RFC 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Thu,  8 Dec 2022 00:33:56 +0800
Message-Id: <20221207163359.26564-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|PSAPR06MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cc29f9-2313-46ab-046c-08dad87127e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTGTd4PJ8QC+YaIxTv6acPN/8yf7MXyV4khnZjkCWyYat9xBK69gXoA4c+NbGjgw3LdgomfLPlNeyBmdFdqBGD16N2RTIdDxBR7EEJw9OSj0KMsA7oixHZEo0KhIyeYj2uGEoSdWpbGrPaEmjoEPYMR9dKjX7jjBO7THHao8/IrHp8sPQX9vB2Yn0QfYfSYqyBy0IC12BBw3rFJ/KjrI5W52374hzQzpImV4u3sISRnR7tDfwaocwuq3Enu0CxWYJIGR+eL9SfH9z3T3sYvrYJfmz7bEarl5qyCNmLqhwMt2ughYa+PytY6SzWq/GeUrihoH2765q34N/gvHBL9wKw50ZnwpQD/A1Ow9Ay+/TbjjX5uAD2oo2Cpsex8HW3caTBiX9XRJcVgpWjdfIzrPiWCO96REgFsxoerYWq8Bc4ZO45Sb3fVC5Rt84WapfGHubu0DG1dz4RPoVlyVOkeNMs67nY0gUwnoODqAkffXPkYNW+NXEsLKWssp+T1PDVpwraRoNu/iHV4L0fdIAst02zFSlsMssuDXHOAQ/JMMseSPtPsDCVcOivZoMHaUKpi5YPc0jETYM1YAP+FBHPbgMWtSW19fJae5gBIJsRaO98zPWY9zrWz/iguVmillx3pA2UrMHPgEhrT/y8nU3U+vOO3iLS2Rmc9KEpGBEPgju+EVXLDdUigBm4iTHVzWdz2nrlZTuSFCoNGpv978jnteT/wsu2IwInY2MLMEC9k44zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(38350700002)(38100700002)(2906002)(6506007)(36756003)(2616005)(316002)(1076003)(86362001)(5660300002)(52116002)(6512007)(66556008)(26005)(186003)(83380400001)(8936002)(41300700001)(4326008)(478600001)(6486002)(8676002)(66946007)(66476007)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcqTrkjRBdZrtovSYwJglAeM5TkykkxCVQdZjm3HbtIWXlAmEMbbqFnnYvvm?=
 =?us-ascii?Q?elxlngO+7+2dixMYygwdMEGr9ORksQwwZtOAuYABIGlON6tj9x0SDm1Hzssx?=
 =?us-ascii?Q?4YHtGsT/5sqLaDMPCV1MbGU49RBiGWtMPRWOVHtPHJex8TFllfgalvJ1Itwr?=
 =?us-ascii?Q?aySP3zbWvZpaj6eVWfB87HRTbvm/e3EzG5w4+ahgitWnZzrSParZrUkDjZVd?=
 =?us-ascii?Q?vvIwEh3+EdSp55enqWQHnDhRMo8Y0+9M5aNkHw0uK5Y7DMvm+6KPbPHNUk4h?=
 =?us-ascii?Q?o7ky0RCmSQe1uFOaqa1nBdgWAAxYwWRXmMlVYTfCCiWBznIh9ddeFQa4jjdO?=
 =?us-ascii?Q?6a/G5GyDO+hala3ZuwJXf21Wl265kPWV9yr+dpi5JQhg9hH8OpW/RONiK4Xy?=
 =?us-ascii?Q?DvG5l6YaM1KiI1v5hFLB1dlNHXTAJY7bAztVJUQU6uOBib0HCDKr/MwBfldg?=
 =?us-ascii?Q?zrOEwcrPTjin9mpGdPrgRFdfB8yBE9+H2Sh1FBn1VI+XXfL2SQPmh6P3aYbW?=
 =?us-ascii?Q?kvOOM4pX1lyCSuP7LR0a31HK9YHpyzzVuVNdCeAArd/2P+csZkwzUPdbyXVd?=
 =?us-ascii?Q?tOnEuYA9udmPjeNZj3LwAtPazd0hdtM+llUbF7VaVgRUPLcBG0AcR5vcAbkL?=
 =?us-ascii?Q?k5/2nsucK3Twftos3gdG6CUX5SnNVmwZWsNRHZrFLBX8MbHjU3W+GDgIx/wD?=
 =?us-ascii?Q?U1m/WY4OqnPznWt9FG9W1wXF+uJphlQ0phsMTiaC7IDQCiREkhzScsxQKO+C?=
 =?us-ascii?Q?rMyci3CbqVf9uJsSt23/CEE9rOWKyH1xvkC+RTK0j53qn3htig9wgtSr0y1w?=
 =?us-ascii?Q?MQomdlXZejtNv8NNzwpyigkeeDc+PqwFIZPUXQmQNPITPet9jIFsddWNYTBX?=
 =?us-ascii?Q?cdVenZHha0jvo07gfmdeOziN1p++AJmA7Y5NXs6XBkhuBVV6JEL4A9ZXY99P?=
 =?us-ascii?Q?QjrrSbLDbZNyNgeoh5B+0M96RUhx06m7YmLlsTWRH7sVKSh7DkNtk5Om+xfv?=
 =?us-ascii?Q?tUM9A7g+KLUaEfQG4sB6uxzBoGoVWUzQHi2cb9TT2603DWH7kxu+n4oslDPT?=
 =?us-ascii?Q?/eVY2UKHE8l+oHNw4DMqDmjc38kMd3cJ8BWF+FXzO0sFQ7d67hALUeY8T8Xf?=
 =?us-ascii?Q?zq+YhtrxzbsEc8wZBZfC6jV6ishBmPjsut/ARvcFJeFIDh9ZY4DS9ZIZffkV?=
 =?us-ascii?Q?kdKbmrNvsWFLZZVN03Uk11aRmjddz8/mtHr+qNKnUYyf5o3vscfXYwjxshmu?=
 =?us-ascii?Q?vT/u/SR/1PFHrAx47Ws+Ll21asy7Op7ruMnVFEYlqWYLmPdvgpznz6CsDFj6?=
 =?us-ascii?Q?Y/8DA7N4pngP7v8/jaTyD0wXnwzdifkEt/rnv2YxCxa4QRzVYl7Z0jaioS0Q?=
 =?us-ascii?Q?kHIsOJFFXbvYnlUWALU7NeRDgKbaKQND9yFju5WkGZQ31p3Z8QCJQTtQ3ywV?=
 =?us-ascii?Q?NMXzaMxVxwD+HhcoWmBd5V63qnDy+d7cozZjL6zHMkDlFKl1cDMlfghXhRNF?=
 =?us-ascii?Q?Gd1WkAhMt39Y7iPACKh2ZQYCY83Ql2hAj0eMagyGJo/KRjLspY/LiP0A58Zn?=
 =?us-ascii?Q?Nh5sqLRRbt4L+991jlecwWGPEFwW/NnZCDjkB/yh2S4apiLIxhESGh5bRW/v?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cc29f9-2313-46ab-046c-08dad87127e1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:36:14.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGjIbI5B9p2aUR5U03nQy6IL0x9IvEvb2cVbuGUeDaENqYrmNuN0tJdAN+UJkRx5xNtxNuSKE/P9rs74+Dem/3Tl7642jqSNpjwSL+98aQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4278
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <http://www.upboard.com> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   79 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  669 ++++++++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1384 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   58 ++
 10 files changed, 2229 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

