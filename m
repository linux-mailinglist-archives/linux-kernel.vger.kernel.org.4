Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BD696038
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBNKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBNKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:05:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91703C9;
        Tue, 14 Feb 2023 02:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb04qwn9PXmYcUqSdEQ46z8OpwODyOLwih/TjYIg+bpXTcdEt9Y7xOqi8uPqy95QliYrJzucQalSyl92GcsAGlJwzV4HO6fG1OtIQZAg28ZgamPEZrFww+cemHS+8Xy2P0nCo92zkfar9lekGvb214qmaTzHvHT7DkalSQwzpwOoOdrmPfyns25IXrWBQBfd9uTYqXafb3gAGba6vR3wGjaWNLkEL/8//Z2lWVsUgShV371PuxV1d2yQYk0/J4+T/GR9ACZQrcjIX+pNLBvd5uE4qWauxRzMy6YoHQR8DnZGwi064TVAz+ORJZf8U2Lr616GiH7y8gUK2+QL0qDAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOrsBoPhECNHqasjJ1rF8JBKeKWUM21NJl9RtPGkntM=;
 b=b8fbIWOcxk6T7mjmfDEGCS5Vhouo8bcJZG3ww7cTHw88tGE6agxhnCelCS9mLPibpowYdeQ9CYS/Cos7KUBJkAK1ZAwy8zrxJOM33HbH59a4WLaRJmogpgnZZtntuEsN6NRasWLsKokMxsJ1Uz1lGZOwYPXMdpsLA3WiGVFQ9Ktg9rKFdNmaUN3h2Pk2yk0Ncl/vzJZPBPbEZjMinDKMJzOwU5d9uY56flFFAbGNZN8DLTLWlO9k8QAeGH3wPPeUQSMmO3a4iyQ/2U1fmbibLfK08GANX2ix/sCa9Uvh9Q0i/0HhWe6BcJC0qMwmD+xporgO/9VQ47nQRm2GTGFWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOrsBoPhECNHqasjJ1rF8JBKeKWUM21NJl9RtPGkntM=;
 b=JjYyJmA3XZnrQ9vtpwi0/4QtWqZ1le8xo0a+wAQB2Hh9RVI18yegZsc2MpZayEqAON4Dkexr6/nEid+3bmozUPSrLuC9jP7eCARxZGR3SUlYFU1KFeYYHSNZGM1u+N/qXjDaTxa5Dq0nVlweNPq251s61P5qaeogGthUfOWm7+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 10:05:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 10:05:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/10] media: imx-jpeg: Add support for 12 bit extended jpeg
Date:   Tue, 14 Feb 2023 18:04:42 +0800
Message-Id: <cover.1676368610.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: bddf0f03-9247-489e-ad84-08db0e73089e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjFqgsTZr2Bfrggd0ipDHFFKj8V5vCi2d8x80wRrchFPCmHQ5qCasGKnu5ZgQDHfinAASeR8qHCElK8vsToCpDz8zafbrpjb3fWLMx9Rpa6qaUGH64nQha8sbPMG1HtzNIkHYFECQKDrMyZJIiQ5y5rCZfn6RNiqrhssKm9eqneznsTv7duA6YL3Mb4tiDyDSUgC9aU4esupI9N51pSDoK9+wng7LAFL7DLKEvGLGj96QRVsbSj3oShySWoYnM2DhKzUpbrQUMvmdEv1qnYc75yhnCRtr8pU2k2S32vYNqx5KYdSw/tcTr7x2v8EqaVsVQrvMoedIP6cNCq0DAudt0JCDoCh9cAlUeXDdJ+5bJM2LizcZ5vlY35GFDUnH6xOMplKdMPoH1wUR2IkbbnniKQMk9cmP0pcYXI5kP2am7koIxpnXBq1ryyWV3W3pUc24paq90sUkZ9rko+ui5hhOkfzlgYAe0jHf4AVFI8lBrvaikqU1EzjWHv6eIN+SstMMtVAGdyxtQPGS75GjwK5WkTtkg7UKp1079gjGPxiORTmVLkuu0j/l16jYiNRQKqQYqz+KNtZ31xNqfj+wYMTEX9TeUxlc7Pzd0nmyLChrYqtIIE/T4dxEegSHSv3JaaW/TzmjRzkRX4rn80s5//B6vC5Flwb1WKQRElmyGqrR9Gb3wNOSBx3uuOTPuwvTEvtQqyVV8ifxo2xgpYDqkGqSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(2616005)(41300700001)(8676002)(66476007)(66556008)(66946007)(2906002)(38350700002)(478600001)(8936002)(38100700002)(7416002)(4326008)(44832011)(5660300002)(316002)(52116002)(83380400001)(86362001)(6486002)(36756003)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZXdmv0oHvke65cVLSpDmR862z3GsA/eesfK5d34fNdOcJxj2hs45jQFglxl?=
 =?us-ascii?Q?kWLqt5sRojnXdb2eOYoPSkemyc6oUSlXy7R4sZwiohCtIxWUocyYAJ4F7Z+I?=
 =?us-ascii?Q?ckuxGW5V8SzzYEPEi2vlsqgsAHNtOol+zV/CfuFtvafEJuyirCdpM7oaExn5?=
 =?us-ascii?Q?zthb1c06zyiXi1uWkrCKSrrojLS1RBgsrl7tOUZgGBi8s6sxELMGGW/60+ao?=
 =?us-ascii?Q?mLv9BV8JmWeYoMGPvrdgbsQLWsL9UeNFORcEnzqKDS3Q8qu22wnT8OwLRSzK?=
 =?us-ascii?Q?4dw1lThULZ5VPLQJ0JmdIfrMtGCsAdgQtgjfTFQY6ybCyzwyNdlgTuJXltTp?=
 =?us-ascii?Q?D7xZUKXa/SPdbgyh8JejtU/2wBer3AfzQYfJuZXCoxDFxB5tzdwtd2scKuoH?=
 =?us-ascii?Q?qQbd9LpvB7V+d6rBoX3WZJ+v7h7eB9mKdbEDaEReEKXdzORXLmqZh+l9GQDp?=
 =?us-ascii?Q?x95aVMWmtSU4AenXqW79wm1VBN2369FTBXTizWm8aVO+jp1XzGt2Hziqhyl0?=
 =?us-ascii?Q?0q/F+p1F8Ff93fBeF0oY4fPj4NhHSz7YGZce2edJfO69owIP1WbNAeXxeoZz?=
 =?us-ascii?Q?knA7kSINSfixzvt1ubfkgALHMlRMSGHF5G7pcdKtlEuKiiy6QaNtO7OJ5GXQ?=
 =?us-ascii?Q?AYE25eKRxMRmQDkjb1L4S8+6COaAagTgqBpbIx9QL1spyXfXDdEITwvrnLDr?=
 =?us-ascii?Q?pgKzHkrgQRFAnYOfFw46vmd2U011esO4siZhvApz2JCwMvHVxqkHrvP0IK5i?=
 =?us-ascii?Q?a+Ds8LfiV+bb/Vpi3bACsdQVKWTEnK8HkVKCyVhbixJyhk1Qcyy50c8Fu3I+?=
 =?us-ascii?Q?DjIIb+3YRR+zwcOtUm2qKe+y57VS8W0NxdWnDfcd/IanFOAYSIHUrockdr0Y?=
 =?us-ascii?Q?VmP/6UZmU/9sFLp8MpLHxjDgS8N8+yCDIF58D7BpQOnkyYthTGhokP5hG3Mz?=
 =?us-ascii?Q?zgKM0mJX790vUd71w/f+He/2H6V1EqBlOrAV5sObKd1vMSww86sKfJqB5ZhJ?=
 =?us-ascii?Q?0agQ9aOOeOo74jKSohfknhQ11keIVdd+LBxO06p+NSjY45Sg/kKbIU6estes?=
 =?us-ascii?Q?V1O/aNdFmH4AR7LOvzhmvvpjDtarSzRz9BBi4P1w2rF9UttsHTd5MtonNIyd?=
 =?us-ascii?Q?vsh4RunZonPQTx6xk7JctADCFd0gtLANj0/wGlQyBQvoiMoDXMHor2k/qQq2?=
 =?us-ascii?Q?UJl6dNS1JJt1iCofURSxh5W/Kmq3y+sYRr10HG1aXycTWQ2tFrOwW10UOXEA?=
 =?us-ascii?Q?s3CjK/++82hZgidJz/Y9AN7VVSJXAmlsmY/Y5Lo4M1WG0dUbtHseu/oNqf4P?=
 =?us-ascii?Q?zJfAo4vYFWPeSxGX+d3HGzbeDEl2T7ltuclaJUOJV9LMgS4k9ZsNEtlEiUar?=
 =?us-ascii?Q?1J3yj4rvm8faacg2DVR/vVwrd/1ALOO25bT3MBwFiQ3qcPJkQa9shQ2A/483?=
 =?us-ascii?Q?OytMGgivMsWMOVOZjCZZ4T7P3tdr0H/d212PD2mGaHfwhJY5MM5SohN86u1j?=
 =?us-ascii?Q?KpkYrNI719W4To+r4pwTyKy5rz0hHDAOcyP1VDsModHI+2aRc4xqt9GQusYB?=
 =?us-ascii?Q?VVwNbNBjLVuGHli+FdREImIDniRV4nzk6syOEE76?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddf0f03-9247-489e-ad84-08db0e73089e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:05:43.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp8bSv9cezlaKI93UwdFvNwvMXLzJLMOu8Xr5YvJHm+xYAdG3/03awryXJ0WFiBEsyMMRQfbs696Fbua8DXXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the imx8 jpeg codec support ISO/IEC 10918-1 Standard Baseline and
Extended Sequential DCT modes.
it can support 8-bit and 12-bit per color samples.
Currently we only enable the 8-bit jpeg,
and we can enable the 12-bit extended jpeg
with the new defined 12 bit pixel format.

v3
- correct the new 12-bit format naming according to Nicolas's comments

v2
- correct the new 12-bit format naming according to Hans's comments

Ming Qian (10):
  media: Add P012 and P012M video format
  media: Add Y012 video format
  media: Add YUYV64_12 video format
  media: Add YUV48_12 video format
  media: Add BGR48_12 video format
  media: Add ABGR64_12 video format
  media: imx-jpeg: Refine the function mxc_jpeg_find_format
  media: imx-jpeg: Clear slot next desc ptr if config error
  media: imx-jpeg: Decoder add support for 12bit jpeg
  media: imx-jpeg: Encoder add support for 12bit jpeg

 .../media/v4l/pixfmt-packed-yuv.rst           |  70 ++++
 .../userspace-api/media/v4l/pixfmt-rgb.rst    |  44 +++
 .../media/v4l/pixfmt-yuv-luma.rst             |  15 +
 .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-common.c         |   6 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   7 +
 include/uapi/linux/videodev2.h                |   9 +
 10 files changed, 569 insertions(+), 26 deletions(-)

-- 
2.38.1

