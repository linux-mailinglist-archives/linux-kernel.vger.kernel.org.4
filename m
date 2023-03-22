Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB16C41D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCVFNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVFNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:13:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E850712;
        Tue, 21 Mar 2023 22:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/bZKmhiJMrs8WXJMfp/76PWnh/glgMcIJr6ky6y3lDUtDVC8Yjy2zSY//Uns0K3cPHR8aGlKp1p55CvTxXZu6iZxbRI4hY8JVYSCU/6+kx1Nga7hgSqm+UxwOMSSztqWLo7+t6NtP2v775Kazw6Mqe52WFOBGzyf7hPqJImAVA56F4PIM3POKg462zxfzCqkmT4xbyWPgRHO22a17VDPJFRCY+g2+HYZqv81Yjy8KcZPoiYRxwa56xHW5BSfw/Oh+OmqruQibMLFpPRJB/MjbM8BJLGUW+jWS6BoHMM2Q4UkARWnv8wySeEEG18iiazYSqgefGjarnkn1oserTTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDH1mR+VhMofVtQNpd6NYflG2LChnMqq8vRh2iszNHo=;
 b=WXnrfhmGgfR11lZ29u01fTOh2+boh1Q3e3oR8viKxxLPQqGEHFECxEZHX0+CSnZ0EoBKQ2Z/foRSsFNeEnAtaxCL+gV96aiki7R9przRCWLxSHxr+cDxSp3mwWjsD/J+Od+chuQ6cYR1ymEKM7w0/PRXQlZx1nOb45hE14o08laBLUB3PGBhfH84n2LNwrrA9ev6nSWUvRegtHbwsdQLuhhEkLMPJVlsUbw3LESfucvxWNmOsI2HNuun0a+TP89eM1kfIHF9JJjku27etD1sPft5V9jRlBcbMAGyZwqMlEgDgVOn/p6k/FaVJ56hpaKplPEmkbOSPiJo4nyiYEnVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDH1mR+VhMofVtQNpd6NYflG2LChnMqq8vRh2iszNHo=;
 b=Ojm4Gf1grQvqw3pwsTv+A0Tex71NLmpbxY14w1j2ZnN10RJZ0O7ZuL8sT/87J1owkaN0BBMOMiZvxQaFUw4ePULaamOg1bgb+5XDte4QP9QntGYKvaejaOjF4a5A6Rf0L/AiGi7gWyBfnzKdFzlbbmsIQvQrgYTqJhw1wWiEeNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:13:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:13:42 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 00/10] media: imx-jpeg: Add support for 12 bit extended jpeg
Date:   Wed, 22 Mar 2023 13:13:03 +0800
Message-Id: <cover.1679461709.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 717cf8da-5d9d-4f4a-7dde-08db2a943474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPvFmWlIT8EMpZM1X7Wk6MlDTzRFMucrtwhmbD3gvS2SC/S9QLT+z09BtJYr62otSmtKvfUb/DpA9xnjlq6fVfM2wbRHkYtOWcFiMLZlLp+BbIF7nt2W4CjGHWdlJBEsObf0MveEyPm4XvfR3xlbqFTCTW8Bhv91v9JwTO5HFUJhs2hwX7y8TZB+z96LNQWqA3n3etSEedsuEFt74fC1GY7stY6XlEx3q2O2zHAJ5EQmcj2ncOPVCItIHoxLqJEVPjQMKD1uX8x6zmxAFUWsT4S/JLM5+dUUzvnVyRhTSqKR4MbENR0J184gtKY+Obv5ihvZuY2V0qULW1JptRWWVCiuNl9HxE5IaNY7lsMqE99KqXgYtccwrBgNYN2V5oaPKpTyemby0831LB1SMLfjmLwYAnj7h0UEeHntJPb8P7uPzb0gea2gNgX9jpgNuHD6nMhB7au8ZkSk2S2FfZ0TjkKNhJhRtQblZlrxOYS2WU+YmqIMxo+L7BksRI179NyeFP12VrPoEEP8Txqdvx5r8v/ukpyCypL1F+Z5EtgO/SS/V7xphWhfKQZXCyLit8kYCUomdz49qX1hLhOlmLcfwFxEkLPNSBSIGBx3xAnUoE1Fp9eONJ9FmPnOAI/yzfgUXq/T9UumXcbaCx0FSwpB9vjiwKUCD6Dl4ymY/9tqGw0IrnV+WEsDV28FyhbDLRT90zhM6snJ0V05VewlewDMsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjj1C8xhzRrXKH6OcZhTSzqtMpDQqkmOqG6FHr9Jy0J+UN+gOSLAJKGyVzAg?=
 =?us-ascii?Q?+pWB3KnFQP2ye59IFcXLSNgvkoWSiz20SFGFVcZ23YbNAINn0SjdC8s/Hdz7?=
 =?us-ascii?Q?IyLGloD72JmfbAppAKGnxFH6QLpRoxEHIe/2GVVpu4vVAUAU/xfLBpazzp9a?=
 =?us-ascii?Q?Tgi6kJWOF1WXndAt6wmCe8s19sUgUKE+hA+CY32A44npBvXoW2JmdOBuPxGU?=
 =?us-ascii?Q?80uZAd248wDWAMd4kZlhN2fDiQY0129YZQe8cPphRKvogOWuOlGB1OGbZxZu?=
 =?us-ascii?Q?8QpVtZW3b/rwH23Om77E8nDITGexQ0wuT4BE5z1nlUGG6jUDqbteeCSLGqkM?=
 =?us-ascii?Q?TSEW1DGFokeTuUqxt8lofJFMcF9TA2ip4l13VpmYcBB7+Kn2UjCWPQwPLX10?=
 =?us-ascii?Q?r6/QoTC49vl9CJIl6TuPypb0qBU1KgwueSO/nDGJEbGDP/TWz4DxFnPkeY0U?=
 =?us-ascii?Q?I82x4te1vVw2tac6Kd8PYzt1uD0+mZLVue5ln/AEjl+Sm9vt6NDkR5n6p0IX?=
 =?us-ascii?Q?7Xer7bTb4RU872xK+VrHk6143zKdERxDpSystsBkOHS+448PpromNrMjdd1r?=
 =?us-ascii?Q?rPvS8sfwbfp27RNQUXQXZxhWxbabVjVAnd4IO7ChR4eg0hfFLYCOH2dxqkUE?=
 =?us-ascii?Q?7YioWH0GFVmfqtYUi/cllmo/aNlk8pEspsbpmAvpKMtu7xjKUdpG6lCmtlKd?=
 =?us-ascii?Q?MuTjaXsvyjZsdA7l8LgPRH+l3xhoawoaCfXQW/wNPZPHOA96ILNiObmKQevH?=
 =?us-ascii?Q?WCn6jqPpktPPU/42EZxKX5cSllz5mTLqDFYxa8sDc8pOi2T63oVXljJ/ETP6?=
 =?us-ascii?Q?DkiB2TediXVuSNNbdIwhJVWkPOA9zvbe0a8/HXCyUMwAkUGSnIfr6kYCW8Vg?=
 =?us-ascii?Q?G8lZAEwMEdbqRN2gqqRUV5OFZZ+6+u9stkzFCR6aPFtikIbxJWMOu8JH1KRF?=
 =?us-ascii?Q?95tJ7Hty6l+9CCeh6LO5AT8ZjaFMjBdMtqe5moLkwCj7R0fosUFQfzToKQuE?=
 =?us-ascii?Q?ZDBF8r5+uvpbHMf/Xeqj4R94ra04AluqUh3jFSeO/3wysdL6JFaM2hwISi1t?=
 =?us-ascii?Q?2MeCG9G5m1HI56Rybua4O9LRp0PetoatOuDfH8UBi6PmoXaWNai4Xjwe1JBr?=
 =?us-ascii?Q?MyirQGfjPaqTH1Of+L3n8fr5TKJGTYnp11dUSmghnpdnZZJGP+2VjY3+Rssq?=
 =?us-ascii?Q?VHSDqw66e1+MPnQXPEd3E6kOB0HYoRwCrs6tYoeoCUTe+MHpGFEdon/pnV6i?=
 =?us-ascii?Q?IgI9envHt3GL4ZDvjVtTrsbnRhh74sRrbaC54JhuLYS+Zy+0/GWNkwY4Olad?=
 =?us-ascii?Q?8bL5WXtEGVMWdAv8/72j05+o5uosCMAWSrBfUD3YUIyCsATU/Cpl3z0qIidK?=
 =?us-ascii?Q?a4J/6wlKiDdOX/rapaWPXt9E3CJn7DWAzTy9uMQOk1gUjqBab21REUfsFNjT?=
 =?us-ascii?Q?dAtbP6rq8OBe4svbEJobqE64/qAy6Z4G3ZS1+c3n2DoOqhZqDhuPv13Aw7T6?=
 =?us-ascii?Q?D8njUeWj1CmD7dk5bl1DPCB5ZiTvXbpkvNC58avJhthCrvAl/+GC1eIkWGOV?=
 =?us-ascii?Q?fvch6ElfqNmiX0ztFKl2QAcUKWQB7OBP4fCw2iff?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717cf8da-5d9d-4f4a-7dde-08db2a943474
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:13:42.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwxsIm+fvibYCMVJiY7z0K/14S7lL8tufKw9960pAygzpQNTFO2edZH4u/nUB/nf9bXo6KHVLsfq+wyUuECYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

v5
- fix some description typo according to Hans's comments

v4
- drop format yuyv64_12, use Y212 directly

v3
- correct the new 12-bit format naming according to Nicolas's comments

v2
- correct the new 12-bit format naming according to Hans's comments

Ming Qian (10):
  media: Add P012 and P012M video format
  media: Add Y012 video format
  media: Add Y212 v4l2 format info
  media: Add YUV48_12 video format
  media: Add BGR48_12 video format
  media: Add ABGR64_12 video format
  media: imx-jpeg: Refine the function mxc_jpeg_find_format
  media: imx-jpeg: Clear slot next desc ptr if config error
  media: imx-jpeg: Decoder add support for 12bit jpeg
  media: imx-jpeg: Encoder add support for 12bit jpeg

 .../media/v4l/pixfmt-packed-yuv.rst           |  28 ++
 .../userspace-api/media/v4l/pixfmt-rgb.rst    |  42 +++
 .../media/v4l/pixfmt-yuv-luma.rst             |  15 +
 .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-common.c         |   6 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   6 +
 include/uapi/linux/videodev2.h                |   8 +
 10 files changed, 523 insertions(+), 26 deletions(-)

-- 
2.38.1

