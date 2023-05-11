Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA86FEF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbjEKJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEKJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:50:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5E1711;
        Thu, 11 May 2023 02:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSo8tCk8DpO60pGsh9sHbT7SStJPjrQnOq/9ehjySBJhQHlkig/Gbw3n0tnk06jgAp1fs0Tpye8quEuyxCRl8aPJi8zYZHXoEtbRkeGyKTdbL6l3i/Ro7xCRJqEFRPalKzl7nlel9iiJfd0jMJA6mIm4v4gIdDFfmDXQKt6PJwQpAWItRgQsO9BXoU6ycaQID8b1lLcHfS2GqPHlpltvrEPGYoAfJgBKNZpT6lmT8To1A9vAzczUkUedHKAAKX9EOj9+Xfhvh//zbELVLK93NEEPyGdsw9QFc4dii5D0hPvFxhbSSfpCFrgXjL+rd+kurBoWfBeRD5lCX3r0/ZOLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+LpaE99Dk9rDWITVPGt6Z5kUPsRwWaajNsKvtpK1nA=;
 b=VrFh81vLJoa2GYw2TdIXZtEMql5pn6DqL5UhyiIflxEYoulacZFjXmTTZC2xZp+QU/pkhGI4U8jllbvVC0V7ylkm85Eocj3p9ClOiCa/r5/b9Ohod+U8VncSM4AEDsd4TXciaEaR8pZgMwzSBTGgMlmdpTg7eKF/p9/6PdFOaNPa4Xjlz3gt9J9u/vDBC3dMte0Hp5J1tBBp1dC6DqQX6C9uByXqzK3fYdeONPvW1Y3nFfjM58RDQvBDQNDfTUN4FFz1t7ajOERmh4AWB1q2FrRa9BnnUcMt4SmOMznaIjfl1lFC1MYDQAxzpzCFtKj3Ec9N/uwgnNf24KcGZiQOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14) by
 KL1PR0601MB3876.apcprd06.prod.outlook.com (2603:1096:820:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Thu, 11 May
 2023 09:49:56 +0000
Received: from SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0]) by SG2PR06MB3742.apcprd06.prod.outlook.com
 ([fe80::e5e4:d643:2a1b:fea0%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 09:49:56 +0000
From:   "larry.lai" <larry.lai@yunjingtech.com>
To:     lee@kernel.org, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: [PATCH V4 0/3] Add support control UP board CPLD/FPGA pin control
Date:   Thu, 11 May 2023 17:49:31 +0800
Message-Id: <20230511094934.4941-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To SG2PR06MB3742.apcprd06.prod.outlook.com (2603:1096:4:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3742:EE_|KL1PR0601MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f90b29-f3b4-4ab7-ee3d-08db52051353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm4SD+6Wf3GcSJklRhq7rMFHuaNND++xne5TEB8wMA5gBRFHVYSIJiE00twlwBi3R/yUCQxg+hTht2zmyPAIYfdMorutY+tc99RJH4omZMqK3sfJAUwUB1oE1NK5LcS01AnUL+FhsVV6iFWZurE3F29PkVqFJTptIjcuxGs6FsxcwlXM9vHboOUNN/gWfngSbt/mEipYf17986CjdXFfB30uYHTi9uOQMdqgYhIsr+1pEtwrsuccUCYarjbvn4w2s1T2BwyrvqmvKk9crdmW0vs0Ck3rMdpxDkvkZRmuvj7a0Agb0wV/SpOceec4I9S3fltnluQ30VpTTq7zFLLHbsDlJllTliEoHEGKVvM7Nr5LPVJPtkaZLa/LGGCbBGWJNEVs35HCUkELMHofu0Q6qmALt3IghA7EXcEoaOLCbdEY69b65mnyEPxwY5Q1u4d+8wUE8i2b3jxNwrTvplUdKhg+jmckV0qhAlCm1wlH6A5gDAKSAMhY+w7EVcPRI2CQDWBxH6HQmFEwp3DbKs/B3kZ6WptGdC4gWL11mCv/IjHVJ+aPfQDkEeB+CKIKMADNck7yH8aOXHdDoOmB9CG5eQDQGbUPGO2JPHE17wjFIFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39830400003)(136003)(451199021)(8676002)(2616005)(2906002)(316002)(38100700002)(38350700002)(66946007)(41300700001)(86362001)(8936002)(66476007)(4326008)(66556008)(5660300002)(186003)(478600001)(36756003)(6486002)(52116002)(6512007)(6666004)(1076003)(6506007)(26005)(107886003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YA3tF5onddJwT3HUobdiUCtcULzu/sfYT8TJCj3mo+zm4zlnd/RpIMNmj/5K?=
 =?us-ascii?Q?IdxRjuVcT0DJw2BGDeyX7BRcx7fs5g23tMKC57Jo8ajfQKSFKNedQRvOTQPX?=
 =?us-ascii?Q?UMmOnAOLebQsGOWX/BdKmA6eK3dVDFVXBibDT/mi70eoxbxnyh72FeQT4G+N?=
 =?us-ascii?Q?FL7SKx3AN9tovEpUaEZjb/cPWwBAqyqrf/dmJklzZA4vdnyCyyhmmw11LSaK?=
 =?us-ascii?Q?7Ipr37VSinw5gfjM8ZS/r3tSRfolSNKSdwlBdbkiP8gieVWzf0/z2oJdDB03?=
 =?us-ascii?Q?1R7yh5GCR0EJBP0Hqfqweqpxyo8/FNsrriu4Q23gl0K3sIfqjqYBYPG8c0u+?=
 =?us-ascii?Q?/KaiVlk2APPCaWmHkwhUci49q/dLFXJ5VPIv8ziPUwGQaggRGLfX0EUy33r2?=
 =?us-ascii?Q?vV0e+n6u0njpavzbxfmOfdqGdA1gMHHcjMp55AGDUTYyE176gFbYNjdH4yik?=
 =?us-ascii?Q?d5qwUeVJmog4UhyOqzXHTOL+qh1c9EEqNzRCgCOkUJoOwHlYLPQYdNtPj0e9?=
 =?us-ascii?Q?H3q54MlwL2RAXqRl0IM+1DbiYtPsjszV5Abl9iQgRQfBR/eqd3T6MAYqP5xR?=
 =?us-ascii?Q?oBuCFMcCTGCg/agF6uOegMrk1p9Xf4PhPHXjGrGqw3Ywe3MzGYe8CyATAvs8?=
 =?us-ascii?Q?3MX8AAye7H+2nB9qaQ+6TWR2zhKqlpgJO8lDj0UrmusAtzPixBAIesMjM5Lz?=
 =?us-ascii?Q?py5qiNhnKcO5vsLBnPlIICGOS+XmLWGLlB/n2Xb4j01GGj3woS02e3Xt7LqI?=
 =?us-ascii?Q?O6s0QuaBsV72FmVMGw+PNb4qtzKWNb/x5OShb5PPk+fVNN0J2h/5fhFx3ylg?=
 =?us-ascii?Q?cZQAukety07XNEL2GAZo5Mzt7c+nbrv8vbD16ELv+lesS/aFHOTyD4vbG++B?=
 =?us-ascii?Q?Icd8nBA2TnUxvXbmWc4QiZ1Q5rs7BDveZ0EVlg9EeLDkPHUlzYMJeWr471T3?=
 =?us-ascii?Q?xyconl33FDrHLCxn3c6PYCOWrp1XEdWBaWicmDPe56TA5ZHZlgKDQ2cuU4w0?=
 =?us-ascii?Q?ldUQBLlAVkpdGr7JQNaYFb0sVePjQbSGp/B3NfiZ246f8C29uHJJZzfhmGyL?=
 =?us-ascii?Q?3gMFOrd1KGtc4KSvMBZwTEdgeKQ+csWTWjjeYV3xAWSdNsvFOKYuK7bqqpXU?=
 =?us-ascii?Q?OBq4yRGuJXrHIfiEpGFatB5oIdFtZaZlGS5xycQvXfemwFxEmlSpSFxiX5SH?=
 =?us-ascii?Q?5ldAGp3ObkTIEEmzBRMiTNTREjQPIlvU95RmX0lXgglvkcRqZS/UUVsmIlsS?=
 =?us-ascii?Q?OlqC809g81zM8ghwP7KV5A/zYHdLlfAb4Sfr8TWpFRuTG8lhnGZ/imEaW3Hz?=
 =?us-ascii?Q?saXJW31gWwI7RV5Mvj0/LMfhEE0KFvyWAMn9HhGDaozXJxBJ2cfZZwNVAjEI?=
 =?us-ascii?Q?wVcHHYKI+LpsFSVaEfeyqigX+PLLjydlMqo6NrUZb1lmbMTspGiUYR25+ynz?=
 =?us-ascii?Q?FX5q0YNRUIUFOKjDEjlrgW515fjY3oGJXfnvUeyH55n79/Xp8rwY6iRZ0hnL?=
 =?us-ascii?Q?sRMcxkULigqW1aFBglwjWR7ZqA7F4bgAve/FRW5Smhis1DAwoNthIbPVx6GJ?=
 =?us-ascii?Q?RAYVy2Nsp2aTOpp/q85wYZmon+FWx9S6P3paqyw8XU5/oCMvesKlGQ2pIggz?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f90b29-f3b4-4ab7-ee3d-08db52051353
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:49:55.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5FI1hyQ1LmJZK6yVGJY0g61oG2cuyEPsVvRYyeM9+rRFF2UdfAJAjit2ylK0wuWNkbA7ALP5U4UjqNOdSk3ZG47VKJPXzBjs5fLaNZKPAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3876
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <https://up-board.org/> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

This is the PATCH V4 and fixed kernel test robot compiler warning and 
remove mistakes with wrong Reviewed-by tags.

larry.lai (3):
  mfd: Add support for UP board CPLD/FPGA
  pinctrl: Add support pin control for UP board CPLD/FPGA
  leds: Add support for UP board CPLD onboard LEDS

 drivers/leds/Kconfig              |   10 +
 drivers/leds/Makefile             |    1 +
 drivers/leds/leds-upboard.c       |   79 ++
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  526 ++++++++++++
 drivers/pinctrl/Kconfig           |   14 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1296 +++++++++++++++++++++++++++++
 include/linux/mfd/upboard-fpga.h  |   61 ++
 10 files changed, 2001 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

