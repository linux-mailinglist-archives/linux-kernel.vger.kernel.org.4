Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D9621999
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiKHQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiKHQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:40:04 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858149B5C;
        Tue,  8 Nov 2022 08:40:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDP/DiT4gYywgf15PKzVEjllUxBBiqt0LEDTOVEI95p8Bk4W8z5tQzoSwLY00Hr78WV15bYIuz0GHrVOWgojHqSx9OX5isfy6a4coUQhbK8euMkGTIkGzNMXcU2nQUX9BnlPC/vfzP+cKxe2OClYVQeUkrpJom2WwRHLL/3OmyiZ0wwBUEW1WNBkx+Hk6p66+0/wFOA5CYMfTsxFRC366JgOJz76A4V9EGTDN/ChL7guZIlrHm3e4AdXhYz/Ys01XU/OFuDb3mWb3St/Zu2Ebb1rxcwlf8zvzYlUBEuIneyERiScEpc0KiaIZaZAY8sFlis9mjLdy48csVq6+M2R1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqLJiN1mWpZA2nRvUOPQnuS+o0OX9y1gDcn3qU8xRbc=;
 b=WoQDTkacywCexmqvSiqQ3yWyd2h4mBKhrjiHEpPKSTexxm1LSYlhMESnpDj3poU1S+lTicLWceATKtwRMnNzbl68URQR37aXpvKsA0m7F5l1fz57qOdBmCQVwQ9ClQgk9lrlWV5SNCfUPWvBUF1wWOBK9C7Dxdpxkt+bhGwNtiTsZdjATpb8NNvQxlV0sozpJ/ccOdTN3uqOlerD7cT1ZsUbmL88fasvsZJ12UIUQAm40LyKDpZoSQuanzHS50ccGPKQMRnpeIAQh3ufCgBsWGamHRFOOWHQ4HgLkJnhNbyDEImNlgyHxHEpXxm0pxsVriOVjiaN+Ke9ccW520YdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 PSAPR06MB4454.apcprd06.prod.outlook.com (2603:1096:301:8a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 16:39:56 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::9ac2:8b0a:9ad:24b5%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 16:39:56 +0000
From:   chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH V2 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Wed,  9 Nov 2022 00:38:49 +0800
Message-Id: <20221108163852.15926-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To SG2PR06MB3742.apcprd06.prod.outlook.com
 (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|PSAPR06MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 564a95df-70b1-4fc9-53e9-08dac1a7de8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6CdMTzufVsP7yWKov7SHihkw/lp8c3nuF3vKHv+YxkN4bxUb49ir/HaDKXY9ejafZaXdDmQ+XgjzF0Sh7+a6QVgptuAAsvfN8QM573RRynOEXbltoQZP18DqPDEbotLojpcjtEsnHDUx9B9IwiQsLZ2IidijNHSeRWs6ZPWnsBMzHN826eqy67lYBGXDS29P4zX1HP3NjeMYFI2IQShr+ISeQpbrR/kz4HPkZeqosCbPSeDdmPIptNozZ+yYt1p6h9pJ9vGFLE5FhvtWpO3ZerWc6ylGArRXzdDAqeRTKdTjP36nuqFvttfv9Cz97Ssun3mGzs7jvy25tNaIWCdA1qpKJl9tiHc54+z5X40bYCURcHJX+VtF+QbewS1dpyiacHjg9SO0PNBgBYLgslvRauMDEv6/gyrGTlAeUhI7RvzLncLQDNV7NIL9cyW+Ck/Wbcr/mQAm0L6vQ//4Zl4hGF1pomwcAbXojkhrtF/jWU0RntIagJJ40mteHJJi5iNkraoHsEv/s3FG35hXsn78j7fR1tjr7MDb+wjkC4XWlisSjQKvdx6sRo6OWr1QVYRgXfbGTvnZuXdmyQ6S1r9+l6k68Uw/jbIXXKQLSQMdBd+wBq6BXpPtnIvhHQp42xbv5QEKqb74aI7ZsPPGsLqUoibYIFVIyzsVddDbL5Y/RAYTTMfOP4xXp0kNVmkqhGk+ExbRvTWtMvhXwjOrvwNkMXToJTaeib9DSS7Fdy2C1xpXFXjRKBDOaxUK7Gtl9BkPXkb86fP0I4f831M2fYut1h5xZOCBQ7wzPgLRjMqLDo/UMtDOIEgchPtleHTv7wB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39830400003)(396003)(366004)(136003)(451199015)(8936002)(41300700001)(38350700002)(38100700002)(52116002)(6666004)(6506007)(4326008)(66946007)(83380400001)(2906002)(66556008)(66476007)(6512007)(26005)(316002)(5660300002)(86362001)(478600001)(107886003)(6486002)(186003)(36756003)(2616005)(8676002)(1076003)(43062005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFJf3q44pU/o4tyzPQcoa/CI9jPSrsZzT/yxOrSGUz6h1OWtZVn+OC3CKfdP?=
 =?us-ascii?Q?+bKKL42dGRRhVk000ceZMbWTbYLSppGNy3oy4QQRTP+1mIm0rvosyLkA9J9p?=
 =?us-ascii?Q?MWe8FbvY3nAhzKjdlcbVCIA7z2/P8Z+FAQJYe51Hbd3Jv9r1ZvY4ZWSjy+CO?=
 =?us-ascii?Q?GTw14VHSQVmzgiFJnM6KhdHtZ1APRfx26aM9C8nFyWyriW7IAXAE+VH9jCza?=
 =?us-ascii?Q?0d13jNpmvCm9oLhmq15dt67tOxLOK8GHZxNsdi35QvyqOJRWqqyj+koTHOe0?=
 =?us-ascii?Q?r4R/cTfdLDOsgCHOTvB6wL25Ne+DwpLajV12WGHgtMB1qfkuCuxG9q0a/G8/?=
 =?us-ascii?Q?KdO7UjGs2fcB6dHVSU34Y8EB4jujvpEgn/PBOEDB82iMemiF5XkhQI1xxVKy?=
 =?us-ascii?Q?qIhEAELJBPgibVReqaUFkoYQDJopqMotWUHYtwbwVz5c/CX+mc98UD59O9Ya?=
 =?us-ascii?Q?zYDZl4RwVVftKUPNii+llOoJocYtsGQCL9CLv7cYlheDLWRlkMF0mvRTaW/W?=
 =?us-ascii?Q?9AVodir9aSIaUB23SnYHJ1ENzfkzSWGbVYlv/VQNIdH9uAzFxRE2QYQ+RZby?=
 =?us-ascii?Q?XIbf/7SgAyfnD9HEunvRsjddIa2bv9OHw708ITeqtfPUGbavIDOK5ZctULFF?=
 =?us-ascii?Q?tDVlMwY2peYREQ+RDCWYxGotP/LyXAQt8KHCo/hKLLKVHRc2q5eldrnAdgIR?=
 =?us-ascii?Q?Nl3strZjH0ElFP6IHEsefsf2S98axHql8+4t3ss/5A9xXQXBGWvXFQwlY1x8?=
 =?us-ascii?Q?grXX2+Y7/hcknvuaVTLKbi70DDUnpz0sb9FigxHxGLRLj34tfvnt5i1mZ8vT?=
 =?us-ascii?Q?QibH4GDOXj7kVCj+NM8Pkv+dyLED1FHtHeOnf1Blpmg1hweRlmhVrYz8lVwV?=
 =?us-ascii?Q?stbijxaHaK1YQjS/9+Yn0c0LKcW9duknnQGH8SKp1B8auQk9bwq6nE2YJh62?=
 =?us-ascii?Q?7FF9LIa3HwOLEz5JfmbE2DPXdWnYT8dq96G1cX+hDxL1jOTkxqfa0apP/ci1?=
 =?us-ascii?Q?bW5iVBmO5wr8Dhezx7UMTBg2KiV4vXnfnWn0C/EQI0ukABnSzObDi/M7KJrD?=
 =?us-ascii?Q?4aDiv4SoX7sDEQsdNP0wQjEACMy7tYE9qOr9/vJGVPwQ1Okt05e1x7d80e7S?=
 =?us-ascii?Q?fldU6FSXLIjlH5CVg1cj1mws3nZIiUZuUHrjhUL9mRfsgxU3tvRsx+6FYoC6?=
 =?us-ascii?Q?/Ov2jUgLXTFWxj3tKVR2sEMeso0cwyugnlpY5eS69P3deK0ZUU4pFLAft0CN?=
 =?us-ascii?Q?FJJCTCggicqdol/+HAA+NSNA2RgXzS/OgXeA5ghKrkZzFdTcxJHPAylK7k2u?=
 =?us-ascii?Q?oGAEQNR1Ba1CWnUtu4dXkkvdRkaELJtYcSKc733M5CtHFwpSKWaF07DG10c+?=
 =?us-ascii?Q?Hi/S6LkwlmqgVN17i3AO55ocv2CbkDg42/TiuvNyPWPeiUBIre6UbONEffNp?=
 =?us-ascii?Q?4bJR9ATQAg6Ti61Lh7uBWViQrEvuSg6bxL8LMK8KHD/PXBeaJmoYgVmh+2lu?=
 =?us-ascii?Q?+kjsCyDBm2xe3Zdh5k9FCf4L11zH7k8+aavdapeI+jVSUPRj+Y0IODYngZx1?=
 =?us-ascii?Q?hhS4LHd9RLNDwXEg+xXM2EYtGz0NQGVnu2ZTSrbGEvy9g51+nb3JWTos6fF1?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564a95df-70b1-4fc9-53e9-08dac1a7de8f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:39:56.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/Uij3wPGroCLr2WzNbL2Vt3yu9FC278B1UnOwbVIdI1Jr4A55+LOIUgqzQtiZF5QvQjXON0IG1IWq5+cQEL4+qEqamGqeRAAnOZVes7HBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4454
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
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

Change history:
(1) PATCH V2 1 (mfd: Add support for UP board CPLD/FPGA)
Refer 2022/10/31 Lee Jones review, fixed some of the issues.

(2) PATCH V2 2 (pinctrl: Add support pin control for UP board CPLD/FPGA)
Refer 2022/10/19 Mark Brown and Andy Shevchenko review, fixed some of 
the issues.

(3) PATCH V2 3 (leds : Add support for UP board CPLD onboard LEDS)
We did git send-email this patch to maintainer on 2022/10/11 for reviewing.
there's no change on this LED PATCH V2.

chengwei (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   78 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  632 ++++++++++++
 drivers/pinctrl/Kconfig           |   15 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1588 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   56 +
 10 files changed, 2394 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h

-- 
2.17.1

