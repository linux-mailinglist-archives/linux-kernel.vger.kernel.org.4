Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABC63854A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiKYIft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:35:46 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C52D77C;
        Fri, 25 Nov 2022 00:35:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieVMgcGLle5tz3KMgRN8W+CUKdYkh3Pa4t9TLKqYVbvc9tH6EMSiGEMOxbVHSDlinluFWr+B2dUj+AKaSQN/0yzJcuLXbyqso+dvZYHABIvKRtt41qOV4P3yE+HVwpNca0Ozx0DmysQpTKtft087H9a8Spl7V5M34VuUX0KXkLJN5F6bDCP92bpwwEnwFWpSOIW7h6HrSF6jrOoospckADHdBcJlFYTgXOKXabYXM5NJ0Ulk0PC9q36bWJFK0hgAsgnNRV5IUvoEpTCDoqurfAoM8ZNLAnEK0zZ2g1Dqov4zT0j9eOMW3wWe+gYbCDtowP32t2hjl142FJCjWFU/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enM1US8FMpahncww/4bcNY1n7RfIGiPeMREMTRqyki4=;
 b=GxWS39FlX0voFdNxYxZtyDbMrMaz/cFuFIsw4UX6P4VlxzsPsxg8+QLAcbzWQmt3K9+dxG4cUQ/HuD4gLMdgjnuirFU2n4I1NKRaXhYECjBoVTHIhM/5/t7qb9QvYr0wUMP1aa2T1Syjjm9yIWNMPIK8mYaRD7kFLcEdS8E75UrF+hXMyt0ZSUOWeo2LK/xFw9IAwz89q/BHNDs4/L3PWyCdf0UONaWqBY0X4tln0Gm9BiqZrUf0/u3EFt+nyggvel1i9lWkdeePAZ0BuruOijlByT0flyTreVtRcGU8xxnCpkk2R8Lileyxe1ON2rq3mDjhRAkFRD7q6y0xdDFazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enM1US8FMpahncww/4bcNY1n7RfIGiPeMREMTRqyki4=;
 b=yfvBFqlR1P8m2x8+zRgpq1CsQK+sxZCAuJOQ28IllgIF0/3Qj2nFQ6aEq0w1N1Pcc6zkeUjbFI1WS69FfYLkbf9YgZStLRWCTNhXDMItKmFqWxI3xr6mpcpj1o9rySuIfHZARQF63txVWd0EqfpNHvnP2qvKYa3IpigTvaOGfxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by PAXPR08MB6751.eurprd08.prod.outlook.com (2603:10a6:102:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 08:35:42 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 08:35:41 +0000
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
Subject: [PATCH v2 0/3] add ti tmag5273 driver
Date:   Fri, 25 Nov 2022 09:35:23 +0100
Message-Id: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:800:92::21) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|PAXPR08MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b2a8e9-187c-4c25-607c-08dacec0098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmbcjmVc/UihwpGzJllzUcNdWcmOpMMDIohpXZdaljyFbfgdwznjVk5gvY+lguNSm4G2qQ4q1P+0kO2QinCjcXJgwjtMUG3yE25a91XUyrzMGghk09Sz5y03ZxzpQML3r92dJ2gVJ0g7hEfoJbUYxoj+0eE9VvYCfujGI0BfIkS7Ut1SjFlT+kcGOC+82cu643QYPcq5NgWiIdXKPlWVJNTNfLfYE9+dcW+dLKTCGjFsDs7EUjpaIbDg3f9mhmBx8OToOVBP6TqofCcPSwtakwRplszruv2ZJhZ7K+ERspR17+FvrS1UVvJXAPRDeEY0jsKnMprYC6HbsTxtvsGtlkNtREc26NCaQ2Ip9sOSix9lALrMmE1kwFYTxtvVSLXce73RXEvhYCvL/mCDEknFpY6e1EuCWo+0McP/RBBYUMRWYGQAznysKQiVKu3VttG1zQmb8s7zkznTNSB/7fPU35FqdIZiEqSRRac1/pu0whcyE25JH7bRJ4RaiU4+O50MRiUWl+rtt7Nl6G98pCMBq7K+RDPYN0ZTv3Z0XE0KbtPM9CS5k6HuY8RDKj0RpeILneAet8zsHrqKW7zvYevcnPd6KWDj1fFaTTvZHHqAqTVG6LTN7l4lKdr0mLOv2SKmIC47fI5AKG5c1ZUTN2W8PDrBiRKku++CqmMy1MC7s64OUUFkF4bOFBdslADcUc8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(451199015)(478600001)(6486002)(186003)(44832011)(7416002)(41300700001)(2616005)(1076003)(316002)(54906003)(38100700002)(38350700002)(36756003)(6506007)(6666004)(107886003)(52116002)(26005)(6512007)(86362001)(4326008)(66946007)(66556008)(8676002)(66476007)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnaQrHY3j7KJl+VKeVc5kerRYvsUUlb2I/olnD5y2RlZJbqQK0WpHHHVmfzL?=
 =?us-ascii?Q?3YXhH/nS3plMn1ftJwhAKLZ57mB845nNZ4hbb5aUUK19x1Wzmz5q5Pe1B5bi?=
 =?us-ascii?Q?yS0/8a993dHu8LTGdlpK9T7Tn9u56hJcQT3Z/0xoAfH5Riz80Dj6oSTE78Ak?=
 =?us-ascii?Q?/NZ4Az3rjgym8ezIzgVuhnHzuQzYsv8LPAoAk8P2EY1SbXvqdoDW9qqZ19qv?=
 =?us-ascii?Q?YUCGUL27b4XLJdKyKRio5lAzAfBeH/ua/rOPO6kJ5ywVBDBWOuGJ1iHaH1SF?=
 =?us-ascii?Q?hM74CT17zUQOKZ8uvOjnFG3AIjjSNn3m3PHcPHXs7MIRuDlx9Xfx14fVBSRq?=
 =?us-ascii?Q?/GI7fY4bAopfxTYnsXmDSPgEN/f4PWTd9gSO8dWnMSUDI6jq5cLJVzyFWeog?=
 =?us-ascii?Q?Lth2xEFyLxYMhPf9h2ABaw9jPoBUcjfJjrRh6ch8mbYOIcRBRfXCXFfuyddn?=
 =?us-ascii?Q?sDk3R+DMr7Ex3KXCfIhR+l4r5BKHP3dq/lRzRqiE8sBBMWw5kb+/5fCVz/Xe?=
 =?us-ascii?Q?iFHLBu/9zQAuxzmCCfB8h+DCynHk6rxKl07wsooB5TPDodfJtP8Fsg3ZAzAo?=
 =?us-ascii?Q?UiXlxm4oMA0xmvfGJlk6+Gii9iGDK7+9YW0PLpk2tkORQ5GVZORNYPQ+Wm3S?=
 =?us-ascii?Q?muR+685qBSHpuG4DuombssDJ2l5GHXm6AeyVFMPYufNyIpk1k/U3tqg6yt5p?=
 =?us-ascii?Q?ZResm2tpS6esLEC02DKXHDczLb0BjTL7gaphsL6KMDFrc5bZiWCWRyUGvbdK?=
 =?us-ascii?Q?tTd3g6UMRS8K+z5ImV+ivJg131vwLzXKTrTSjnXkKcIDtBbvNOKc2y3BJDNW?=
 =?us-ascii?Q?kC6m0lzfwalLTgVod5th6VI1HVS1lT69b9frGjP/cS8HzXoJxHrhSU72N66t?=
 =?us-ascii?Q?csXc+CxrQZIgz5nYOFX8K9Xy0I/K0vc75JGDnSeuLtdao169h7aJGB7dlAOQ?=
 =?us-ascii?Q?Xk177x66BtA5dMje9EEGQgGMDAHMBXI48pvzrnU2qsp4xnk+oDApo/XPvQxy?=
 =?us-ascii?Q?3iL8rfan7ziDGqXpoD4xYDGz214qATkzdpchkaMAAIZCy0E/9YA5R7ZRnsGS?=
 =?us-ascii?Q?eoSDuLx/vdyu3AMnT8tcE1CVarRVKaqGdsm+AX7K7zB5sQGOOqWzwZY11bT6?=
 =?us-ascii?Q?5XTYmY5EiESjMJSLTBSNMaRoXoSF1ugTa8p0SgMgSri+W3K774sDXCjfhO/6?=
 =?us-ascii?Q?9l5zZGaWlvwpgTH7s/qSHWc/Uejfrc8LxwFCyeiDpPBpe3GK9bnF3Hkurm/Y?=
 =?us-ascii?Q?5IJ7uKgMcRFKSAxUgRoAep/VPMR3l7Ez+GUpEo4b/w7dXfZry5LYoCxvehq8?=
 =?us-ascii?Q?J24Wy3YUNoaQW1EnE80yveOH7IPx4sS2tgU0NsjhpfqwmEKHpez5EcJ2KEcj?=
 =?us-ascii?Q?S8F5O+gbfX+UI0FpCD0ZJ3gR9I8a4QGNSmwCDwwe0aF3b4EtkI3EMjkpLqM5?=
 =?us-ascii?Q?ERWJqXjXv/44Uo1dMwBs1K4BRozZToawsycyi/XMbgj9zgM8fc50ILjnNfBx?=
 =?us-ascii?Q?pTzlCf/fcNAXfMCU4TA+EJP5Ctmbpm79a3YXWE30M/eOYlpMVsI4B8RcysOF?=
 =?us-ascii?Q?YxRLu2jdIf4rME0X0klrh4RVTFH3VEm0xvG78ARcbOOGFpKjZIl5Gv81+Tae?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b2a8e9-187c-4c25-607c-08dacec0098a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 08:35:41.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCBvPSNErAYpgszn/TgIoYoNPghhuFFvUmLSqD9e86P3LJG6MMHyjYfTvcO3CJr/m3VYe4kxcM1QDoFabJJ0Ma8Z5QqhPxCg5E8JOhD84V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6751
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
  iio: add struct declarations for iio types
  dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
  iio: magnetometer: add ti tmag5273 driver

 .../iio/magnetometer/ti,tmag5273.yaml         |  75 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/tmag5273.c           | 736 ++++++++++++++++++
 include/linux/iio/iio.h                       |  15 +
 6 files changed, 847 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

