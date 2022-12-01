Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE45063EA41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLAHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:23:05 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357EB2CC9C;
        Wed, 30 Nov 2022 23:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2PSnjE175gYe4LcHflGZ57jJefq7YZdwBEeCm6pJctEP57npp18CekS2xs+J76mE+kKpMbwPyrO5A6Cacq+FKjjtzi/ymRPiJqO/D5WvsqOo5Ldb34wyEvlgosHBGtMYMqxGgFr07dz4//rIYZxKQ+h3I/0txuTEo3kB9HRjNXY4Ar5ooUUwiQeYGGmAmAQD3DjuR3XjpbIw4DovWMh55VZYQT3lBCF0BBrvunu7ZP41dvLsWKY6Wavfx1vW+5J5/MNKxNWwMaBsKKIs1mHI/QEZyaxwFCmndQkg8F7wbkSTUfgq9IfWT83OHSH8AkCwrDoP8nCXawTjOT4s+xinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N01/BmtDBK5ZUeuDkgd2/tRX3rmMf3hZCgUmD5PEi48=;
 b=OvFXtGrgcI7c/M/qoHl0TANSBX1fmRHf2jrhBpeWBa54xA1sH3eeF2GGO6wC4tnXxplnQ8hQsz8kdRryQqiem+XYzVbdIq9fbjai9NOY6OFYq8gaO50ATIxVmvOTGTEJOQW/CR4X6sLF13d7TTuLxTgt7U9C1cFqf1pDag1su9eNTGLuBujKOtqpPpljdBqom0EvQXa6RukwTlwJBFfMwbtigOkrWkRlumIf4z2OGSHdDydODt+3BOL5xQlb0oZPMKs5zmnR6TGkRWP7RaCxSJQOtkA4dtVwIFXhHnRJOe92daAAVSoRQOkxgMCnJNOlqPAKLdmRkFpCS9zpBjvg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N01/BmtDBK5ZUeuDkgd2/tRX3rmMf3hZCgUmD5PEi48=;
 b=p9NRgrFKzbPnZuKbqruby+1Rsee91iZ6OdmLe32Ycn9eOd9qG0oOExoVmRCYdMgAyP/c6X5hjD01MHLGXeyF6dZ0SnYL6L3wD1ejL7Lr/FGGQUVa7iz9vO3E4rGwcg5Xi6YHmpo/1xzPP5sazZvTEH/HVpJDdKwyzobY/XsYHRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by VE1PR08MB5565.eurprd08.prod.outlook.com (2603:10a6:800:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 07:23:01 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 07:23:01 +0000
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
Subject: [PATCH v6 0/3] add ti tmag5273 driver
Date:   Thu,  1 Dec 2022 08:22:17 +0100
Message-Id: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0024.eurprd05.prod.outlook.com
 (2603:10a6:800:92::34) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|VE1PR08MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ab4e64-62b8-474a-2349-08dad36ce13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3u2bN8PiePpcATCMDwUuMD/L7efCKhlAU8mGwu8TjIl3ccumVoRVf8rOUZEfq66a/kZBy1YzksR+lWpjQ3PS4lipktwUEaUwAeSHYWnyUeku9ZhVzQLn5ebpZfqAlVFIx2i2zWgOpaZU/0zZFj9Oa5tSdiv+vD44+3opshUaz31WS3NYZlD6+h4z6W+0BPEfllXfbVDeOz/i2GV9cXeAaY7j3wtYMRdUoH1X1zse/nZquNrXZ57XAbx6HRcHzWbVQE2IrzcN8l/LGzDkobXA09mIB9aeKwgp576kxpl7+2kZDOr9UU8gw+Hvy0GDe3Ln3Zyx4oM4+vpQ4rXrNZ1gVThuu0LxnD4+5egcWzk1d3ihfQgu46RM/JO0oSjwSBUOTonFo4KRBx7aFG90YT/9BSc217m2xZ7YH8uhVxM/fagFqXv+Fx2EK7VlkV6MaCg5kQUwvTWJtXmvjy0EhgO+eZ/kdwaZ/IAMuBcs5UrkA8Qi2U9TMuqS575lFZs0tE0P7Km4dFGV4T4wljqJuTKMbMM5QFzQYiyhwFvWHB0OU/V8plkJo9a8dgJV3caMug3GsKz5Arc8kX+0U7ZzmUcsQQVUh9xApMIOgvlg+/KkQYyO5/3RRTK9zrWaHCXg2iA3T0r/xfQPsIbcwHBkbkhje5O26LTm4bFX171UrmS450XpJmLhQiU87qwcsZDnX6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39840400004)(451199015)(6666004)(6506007)(36756003)(52116002)(6512007)(6486002)(478600001)(26005)(66556008)(8676002)(38100700002)(41300700001)(66476007)(66946007)(38350700002)(186003)(86362001)(54906003)(4326008)(44832011)(316002)(7416002)(8936002)(5660300002)(1076003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQ8P3JNcyr7J3iGC8/ShDmTHCw/PHeyJmH2EBAWrClFsWWy8QlQaEdNNOkpH?=
 =?us-ascii?Q?Ik46BBEdy3ShL+C6ZlKpFPaV83Sk5LIH5w2261j02BCyIWBd5WjRJcWqVNkB?=
 =?us-ascii?Q?fMbuEdvvL2UwOYDHV1QjvcUYB7vkozikXCDMgrFFD0BV+HuhCXb9YOz1/S8f?=
 =?us-ascii?Q?dqaYLM8PuFazYui/VrPdPrqm8NUS77ybIhP9obDBzhA322W2nNWOcwy4MBCH?=
 =?us-ascii?Q?KqBKsaq0SP2mzBkqZVWrz8mysWdEeyaSaql8fs+OdETu2MxHfUngPmEySK0K?=
 =?us-ascii?Q?ez+MkiCQlNAMoGvKnjmimvq39hnE5cRf5xFm2AFsBvh6C1lBxTXH5YTonSSZ?=
 =?us-ascii?Q?jAwHIlb9sAqvD1CseNf3a6vMjlPESzbGaD6rCayphYFcM8zIs27CHujpNceB?=
 =?us-ascii?Q?urujSD403wO8kksvOoNntZbbPXa5GRVQCgAordGXNghNIzOZgpZkQhOMYXhs?=
 =?us-ascii?Q?v1jZ6D1c/IQb1L0MU3TrguOXORDdK1/MlzHzbL1IdSHjmgFRTSXFKVdzx89b?=
 =?us-ascii?Q?CDEHngHD/BV6ffiWHRhB7GzlZaYQFnK3wReTuyO+O8ZEqEYurouTmKl6FUzW?=
 =?us-ascii?Q?tUjfyZzlP2FkL3IXhuHKO1J/ry8Kyo9UTAwjUPOm4cRG6OEx9pWdktLYfVmK?=
 =?us-ascii?Q?6RF4UE8wic5pzb0Oe2Pz4bOqsgAuSdkq72AA8RDKuzDFI9PbZJOIkdaYE7ld?=
 =?us-ascii?Q?WfCKZpIa1EPBbb4Jn59YM/xZXZQa5cLFbIBSxOvWzBFU3HOUXPbuSvakxCvh?=
 =?us-ascii?Q?1BQxqHVjkpKivPA6FEG2E9qXiNNsDPrUFLhkStDKMsH3gCN1m49c1BKo/Fmr?=
 =?us-ascii?Q?jod1mDqJ5RPFssMh/7UGr1CifbBKirQJZEsVcbP55jvvcX5YyzRFkAvuoAQX?=
 =?us-ascii?Q?Kp9AO/Fk16Dc0fw/JORIreY8CiWxw5aqLjZxlvMEJZW3mPAxr09wFBvI3RMa?=
 =?us-ascii?Q?IqnkMGm2SX0+BaztI6h8/+swxN/GT/81TzF/l0bYCa6KvOknAUtRoyZyLLxT?=
 =?us-ascii?Q?UbqRfD6RRfWgL0jjXPJXeFok+ZfIacE+p2iLWIjpj071bK67thBvwZZaYUZI?=
 =?us-ascii?Q?1F8Jr6b8cYbISLiHoPsRXnW5zeRfUEezYdQjPE+If0pdRYHZA4hagOLaTUWY?=
 =?us-ascii?Q?RIDiDp6qSMfVqDepmp/VtxqzwhDmugORafpnL9JTB7rzto0IIZzp9GAfKYoz?=
 =?us-ascii?Q?b8fckYIdA2EhL/B0tipGM4S5mInuwz906LF3FWoEgKX31FibRjCoWu0tDAdq?=
 =?us-ascii?Q?+8NWA1RfFlF+bJ4RAPbnNQMwq2PDi5CxYgroL3avUw5k67RWSl3LqvT/+zPE?=
 =?us-ascii?Q?KsMdW0pDSoglhEUuQoREpYW5IUsL4ZbVXJUBJbxd3244BHaEB1LUSQOjNUrX?=
 =?us-ascii?Q?xyREYhk24IWPN2QnUdpglF1mQ3IjMfAdzOs3T9gwayFWOZ+MjMXibGCo7ASx?=
 =?us-ascii?Q?tsdwNUlpcu02rBarf43KOEry0gRGlDOpoJBbXlNfV+QUZ5EUz7E634N0ahen?=
 =?us-ascii?Q?b4jJWSdRHBVSP+YJ+dyjr3JH5h1AwOtFCaBM7QXS+enng0ZCoPNq8dLoSKHt?=
 =?us-ascii?Q?IHJF8tdRZkW4BqfngPW0lhqHvmMroOQvvxQemer6yTuAHzngswAzyOglcvli?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab4e64-62b8-474a-2349-08dad36ce13c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 07:23:01.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv6KwG63ysbQpy87r/dGqAIycHerLRJ984zakFc9ErBpDk/jtjrGYwgRVaIo7GiDmO13plMVGPjTUi89Ca+0q1UVbU0nitUriuduz8VJ8Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5565
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

Changes in v6:
 - Defined TMAG5273_MAX_REG
 - Added comment for wrong device ID
 
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
 drivers/iio/magnetometer/tmag5273.c           | 743 ++++++++++++++++++
 include/linux/iio/iio.h                       |   5 +
 6 files changed, 844 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

