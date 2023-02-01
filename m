Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73CE685F58
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBAGDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:03:22 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2551438B73;
        Tue, 31 Jan 2023 22:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+JnFFYkqc1sNOovT8Q1zcekx9BuurqHcnw3hv8eGXuto0iXZ9jX4wcFwIpVsiCNi4n2k+RaD2iFY8zb7/Tz4IlEiV8O35+vPZQXVZjJ9svUmVzRMP+lHoUZig9N+YYjXLGFkY4mDxISMJ+pUX2roHnOVZvgoP6X0u8lhR4JY712SZoo25tILljC1oTAgswCSLwfj/nc+mW6WBR+80rCmsmHOpiAFaJwA02Je9MUtqRYH/i9sXiC6tQJvtM2J2064cSRPxK/XyzpUcWxWz53FLu4Z44iTbAhWeDofLI8saRL+lOyqQ5686NoRdYrmjFXoFLp1QiOLVmVX7uwny3slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvdvpM5dE7xZYJvDkp/k2QjR0vZ4lDiCkOJNMP1oh/k=;
 b=Exi8LjAoRni4wXE/HwxZmBdeIl8GcO2XdAW+Mn3mbi+eBI1bxJeRf5aHAXiEY+e0MTrbakn4Yu7spBl/fDBPKNRaaHaeyraZ5HAqECv06HjLOLhYglZVJjvl+NEAJ13Jzd65zvwYcYEBSvv7U09iOHNPnmxBNv7df73RAsO25jlKm/xi3T1kXjK4hxdDGN1n2ZmheexnzUPKgObFPooBqWlvZytFErTv0EJoeEK4NYhceHZvnpZ5zNJAQH2HaZcqB+IGiQaAMaJev550Imukrc6ZWDSqL2kLcpl79SxZ70IeXvWeLEA5DF/bWglJm6bk/d84fcPdcQZSq3tWMYPavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvdvpM5dE7xZYJvDkp/k2QjR0vZ4lDiCkOJNMP1oh/k=;
 b=eu7ys2PHgJhFDpNBHUB8EliOeJuJAZTXdm3PPlnoEae4Fdx3XhT4RuzLVgHwY8r79XncOCw9ow3NasvoqKqjwawulbYQRlD8qsJZhPDT2e/5YG6eBWXYkfrPy5TgjoxopTlBvC+6Seo5UzkA/HfeI4PQUZT1vvyNAxrhu6hRHPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:03:17 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 06:03:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/10] media: imx-jpeg: Add support for 12 bit extended jpeg
Date:   Wed,  1 Feb 2023 14:02:22 +0800
Message-Id: <cover.1675230665.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: f056cf38-5094-49ed-bb66-08db041a0305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUWuf8keXgWGfClq1KvqFAG2cSANtCr1Xy12NGRs54IB7Y7g9yrqB+rqcmmaH1kPTHnmwjMlhPVRUYhqGhZaZCzGXVhme3BYcKG++T5lSDfDXl5X50ZZiMjsAPcvlPYXzKPd0UWinGuozc2Kju8ctpwRlUBn78o8i6ZkzpoZ7kao+7ykIt35JhOKjPALk2p1zaHAMPxZHVNpjCiE1du0LaFoJcnP91+5TqSmRI8rlqftQWAXPTFiBogcXymX3BmMndUpbBG/OBQHqCp+0bpFCe8ZycdacZD6rbrTKEzzUIs1y+NeOJ0aceTnSZ3qsWEQatdbEZpNsG7u5ZJpXGOgcfMHlnKVK2XJf6/jwal3SVc+bAr2X0u+XqXzZNNbKVQzGDZXYmKjpzNUmMTaSe4YguPbVKQy/euNi/px85AzGO9GiTr0LaQV80a96v9pMMNmwT0xi+SYTZE0nUMa+xwbPkf/DEy5HTulRAw7pdTtGNNjSfgqljR7JES6392usyxQHr231C7F7KqbuCSUy/TcEmvncTyBvglvy2jNLPpYre3W8maZ/EJZK54H6El9y9d+L5BKjRlG9QQz+npSC3lJDiYiFDHo898zmrsqvEh6VjZ36NgWnbd/A14UZJFDSP6ryUOhM6eUEks8RovieCDT3KqORA9qlgNUgq0F+36BDmT42Uhi3R9aafO5j1omyzoXnQcpfyDWX8lc7uT721WP0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(38100700002)(52116002)(2616005)(38350700002)(36756003)(7416002)(8936002)(86362001)(5660300002)(44832011)(316002)(41300700001)(2906002)(83380400001)(6506007)(6512007)(8676002)(4326008)(186003)(26005)(478600001)(66476007)(66556008)(6666004)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFQSJbOlq3ja8WunFBDEGaHhpXuy3Fgm0HCkMVx/aFFsyEfffu0dY0A1iH4d?=
 =?us-ascii?Q?rBqbld9/Dl7yuIyqlH5wwpWbDFWutzyC6yKz2TJwMtHoYZ8pdCwLbhFIcvof?=
 =?us-ascii?Q?h0Eb0BdpRRqYH28km/VONr3L/qXKm4nAGmLA8x6fei/ax2JQbDzvvOlcryg3?=
 =?us-ascii?Q?E881HIbwg713GnZDLWwlVAmxY49voaMK6tRrBTdVWdk4dNvw4TFKOC9cMWeo?=
 =?us-ascii?Q?1ZDvaOz62jxQHM8SN2c/Xyw3KQYqsyTwfES5gPhaJM3UEYL2JnC3Lt0S6RAb?=
 =?us-ascii?Q?AKZiXeMMtiRFLe9wcFDZCRguYKj+r/q7G/FgFIZO56gaf/SULIf+wwuiEe0c?=
 =?us-ascii?Q?IJiuAegIRQ8ZWm37y6JOVwAzYnM+J7AmZ2uwL7YJxy9qZ5zUCH33/qux+CWF?=
 =?us-ascii?Q?JnqLpXJryiYszxKEcq/Xfv4KCT9Qo4R94wA+Kexu/Zh1F+93zUh841u2JkSS?=
 =?us-ascii?Q?Mgi5l9cOgfyI45Zutpm6EeuoT8cMe9TcHfYP9z7QlFPAGZXEJDyn42B85b7o?=
 =?us-ascii?Q?L1NLf6EMlQTWXEMqY+1CNfw7fqn0cRWrzZ9QSsRO09UwWZBzQDHtZbsDNd4G?=
 =?us-ascii?Q?/SfFIX579j53xOQNIOgLWItwLYuBlNgWw608gzp4GI+ssKZ2rbSMLh4kqesS?=
 =?us-ascii?Q?cTRAkVqBCvv6lqrvaHg9VJUsMUbIaPv/xzQssWtlBbZkgBcc34LJYGq3VSCD?=
 =?us-ascii?Q?AAXI10IH4xcNrTy0WuxpAQhba2qwPVMSyLYx9tfhglqr8DMSxPzYiszVNvdd?=
 =?us-ascii?Q?R+DByNZ7pE8uE3MdcFq/SOBjbkuBaTUNp1jVHae/keTBZIWPgJZ6XL/F0yxN?=
 =?us-ascii?Q?EDvVxU/nWD4Hu4tD8BXh/0FCu6ipYH5DZ2oK8Y45Od5VSkCCwmoMZ9Uu1mKx?=
 =?us-ascii?Q?B+e2MQf6DGJ3LIKfaM1a/ytQDsCvPd7er9nhX3El0LxR3lECCTCm6k0dG9vc?=
 =?us-ascii?Q?KEp2PkICj2t0rt/sgtAf1D/fNvEs+Dj09b+QPp5ZRLi5cOMairV0fTCbINAA?=
 =?us-ascii?Q?lbeo8fSsMTFjJwEcNCnJs+xaR0WcAIs6vKIbdvKLSXZySVc7MHVhiuZ0KboG?=
 =?us-ascii?Q?ZSdZIqHYoG6Ch/RB8VnPA1HuMjufcTvRFuEjcsZ+8tDgBTKab64adk0Yqjw6?=
 =?us-ascii?Q?K5jkCVDK46mkGpPsiF85rK+4XBiMYDqdqKsn1gmQQvK9P2Ei1aJ/GwMuMt68?=
 =?us-ascii?Q?+9d9jGImwT43rZ9ic4ncksGSnmviLS7bj4exi0PnUsV/DQt4nqz3eWzuOdj6?=
 =?us-ascii?Q?S4AdoJBwS5/eS31HFd3lfc+63wjyFw6fZbq/jk9DvHTIdRRMwPq4kYiJHkq3?=
 =?us-ascii?Q?inMN++Lw6fYN+bb0+F7/2LUTk/DvFgKpD8xIAG4KCJCfyQ3NGg4cBBznCHr7?=
 =?us-ascii?Q?s9xhZ3BtkggaVoS3RiiIItXLrQc3hyEkoHHUPI90n78vC6Ij01LeBEV40FV6?=
 =?us-ascii?Q?n8cV3Yx9uzinFdL5/86TsPadLzLqlGmddmROhzzaCVJOI4/EAC9cPANjtk2P?=
 =?us-ascii?Q?8w6G6fsRgkyc+m7E7J3FrbfgqO1ZtBCelWZjamHjlkXvdXh41SUIgF8hGMDS?=
 =?us-ascii?Q?V5CbMiScHD82m9cdLpZnEek7ohBo++Tj0OdQGinS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f056cf38-5094-49ed-bb66-08db041a0305
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:03:17.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrYksgRGvA3rXfjEBvAphMBuxuVmUAmFm4ZutanIRZMaRxW/Q5g3PWRiMJfNpxi/w5Q2uGG9PZb7o9RuMM4ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
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

v2
- correct the new 12-bit format naming according to Hans's comments

Ming Qian (10):
  media: Add P012 and P012M video format
  media: Add Y012 video format
  media: Add YUYV_12 video format
  media: Add YUV24_12 video format
  media: Add BGR24_12 video format
  media: Add ABGR32_12 video format
  media: imx-jpeg: Refine the function mxc_jpeg_find_format
  media: imx-jpeg: Clear slot next desc ptr if config error
  media: imx-jpeg: Decoder add support for 12bit jpeg
  media: imx-jpeg: Encoder add support for 12bit jpeg

 .../media/v4l/pixfmt-packed-yuv.rst           |  70 ++++
 .../userspace-api/media/v4l/pixfmt-rgb.rst    |  44 +++
 .../media/v4l/pixfmt-yuv-luma.rst             |  11 +
 .../media/v4l/pixfmt-yuv-planar.rst           |  94 +++++
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  19 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   5 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 326 ++++++++++++++++--
 drivers/media/v4l2-core/v4l2-common.c         |   6 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   7 +
 include/uapi/linux/videodev2.h                |   9 +
 10 files changed, 565 insertions(+), 26 deletions(-)

-- 
2.38.1

