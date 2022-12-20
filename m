Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E7651957
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLTDM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLTDMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:12:25 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF72DC0;
        Mon, 19 Dec 2022 19:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMbfURUq7bl4DXOfzoujT0ao1SIngcTGFx12W6/ej2JcO34I0nRExFlh8Oau8q3SFDtOU2kNjz3efH1yHVt9NPub/w4wO3JMQIlaN6fzOFCletB/SiVGnwgMZAxK+JXF6CNLyCTsDOmTFhVNtkasU17E9GLoJQlMr3dmcIOL9A/85vY2/zqIytuQ/KvM2z+5WlhTigYik9r9H4pvH7qBCr7oslkX7OLdMnjq8OLfLhd/RGO5xG/ErI3LTdmzjVM2P0i7kfIMAqorptuIipRBX3UQGHkrun5IQ4FQZWJi37r+Skr9cN/YZId4eO32niNWnOoKrCX6Cr+Vi3JHovfnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onDvRx36hzQTbrWH/7EsNnQuFRKaCZVGcXYH3ZOTRNE=;
 b=PH9OUbkh4mX8ZfTWsWhgxQitHWWGwTXDVAuWc5wYX9Y1FxehpXc1tSA5mzZLHNv8/klF1OFK51k7Pax5vp4FFFFbe29cNP8/3yx6MI1LFAdInDc1PduNghZB7J6mQ1NojZHW5oT5+tProoPnLszSnhPjXQa2d5kiLjuaEIJBbMtlZGiv0u05V/Q4+mv0rs2O0gAXTteuyXGh9ja2nykH1SDPVurbwS30kpdsMQa/pDB+LlWsx8soBchJSdi/Gqc4QLMX6zErkhUrTlDLHm4Ak4eD4BSElqzQUMcJxOhnYQMjwdQAaMqJTkMT5jWbLnd95I41c+XILIc2tc1WPre+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onDvRx36hzQTbrWH/7EsNnQuFRKaCZVGcXYH3ZOTRNE=;
 b=QwWz3d9e0XmxVbCXO2BKqc3XG+1VtYTElIGp0K8mXGJe6ZCXkbaMfOrOLk4XjQwV1q5xrVzQGWjYKt2QKxRgvmvESzwY4WydpHzwo1jmJmjcMes7NhLok41AyZGXc6ZX0qwSnKINSAFsGqhRi/cF6V77NiYh4uVLOkF6/mQbCmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:22 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/10] media: imx-jpeg: Add support for 12 bit extended
Date:   Tue, 20 Dec 2022 11:11:30 +0800
Message-Id: <cover.1671071730.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 137a8540-4fb3-4161-a8a0-08dae237ff1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZlNrVIMiEBiXhHGP0LHAwx3Taig0cQNmAowA1jJq90bZ8cNxokahOZIng5dfz1oq8JgL9ydroSyKAXl0pt0AYAN2+Zb/Gpo8O06j6PMUapGqofyDtTT2Dlg3nWXnueVLuwgOz2JhL9dgHfhAx4ghK+kovUfOJ8WIZDWjq2vFmQLcczBUBj0rbealrxs3B6CRP5K5H5GXFWrOigUBXbydG/iyaPsLTRgEbSFb6okYOKCiyUupslKXDptv1ua+/ebPTG2UHB8kybwCX1E45FaD84P8EPSj72vZKQe3XiM7Sy2SGxRkmNvFi1DmE82dBoCyA5iStwWDqlxldlwI4Zu8ngU9ZkH9Ox72Jbzpyw+9xor4uodUJLlMdQAnAvRJ4xYtECwUSlrzOj3Z1smDbZNIxKbby51L8uRR3dvyTenWogK32mW2fMB219I+JQmjw3b8q+7NXI6DXa3KDRGLxS/Bfk5QQJQz3pWg+7y2j5TM5GlNZzE8mnMbQaTaqKr60LXkOKkTLZ+knYEFOyMr6vmRhi2PVgbRmQmidjHHz5L9x1wH6ya/RO1n8K69VES4xxNSv/Bvue11AjAZlGUzTIhDBE7o7yc0F7Y8WStc39x3s3Y8dCvj/uumkdABt83zmf6xgyLEOSoWr7Ex8DRy+A+qFRu+088AlCLlnnYwZyDoryFnQIWmoSShfHjJdpjQ2ujJ0qwxDArvB1C/+fQuQnkhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GvBuRMnFE7mtWANEHykkc1oc2i5x3MZp/AWpoBoNB9xp0f538e6Kj4oMAWC?=
 =?us-ascii?Q?eyRaDcyxNA/KRnqMnBdrtifGgkDkll+lFKRB1v9Icc2LftSswE/4zVbUtVNy?=
 =?us-ascii?Q?DK7C4PeHI07eLnJ+nJre0cksIB/obWI4XvM2Svd/jEwIVtqO/b/adNbE0YFZ?=
 =?us-ascii?Q?mxJhnucAj1Tm2LerEQdRnEG7ENUoNy977cBJlrcOmfYX/U/UVEgz8T/pYtg7?=
 =?us-ascii?Q?Y2MgjP5ZLRT2ZfvmrGQfeWOwanBReZ061uKLQwmfJ7WOD/N6sItNgvsXxc5X?=
 =?us-ascii?Q?2JiVYsbA6fbm5dFEzaT85wHsM5AgZq3Ps4Mq1Nm96tlLe5DGg1pp/mh2HFkz?=
 =?us-ascii?Q?LMz5Oh6H3NxL0mrT33toSxT+DfXdOO0v8FhfXIa9ag+eKEW9eVulWO0eloLt?=
 =?us-ascii?Q?rBjyXvIe1N1BZGrMkfIsRJ3J6IDs7455s3INZtnwYrhhz5xQ7YQRsOzw2nHs?=
 =?us-ascii?Q?XZhealqWW2rYJRQktHHtWxl+NJXGVAXE4wAsoZ0SOa2Dk2IZJ7VitLBImR+v?=
 =?us-ascii?Q?vw/qnyXMDVEsRVfYQi35kDx1PJyIYHf+5n9cLkmRSAG8/puL5DIrFItxP523?=
 =?us-ascii?Q?c9XkPqyrlU5vEAqaMqureJRLfE15/20HkDidWqwWu3lZwYzJRmH/OLrhSJ2H?=
 =?us-ascii?Q?TxJO8jEuvO+cY+C3M/ZULs2AmBu7ydbiOlcgi3UI0usYj8Qy/545YLC5bTNv?=
 =?us-ascii?Q?kQDZKO9kV9bAi1tfPj/cGwe5J40jELW9Ca3F0iyuoD2wbtHQER5+GIxyr82C?=
 =?us-ascii?Q?f0WogQiV4hJnw7tDaK6Y499MqxH+7YM7V1q//7Sgbeeq45ExsBnUS8AGCKlA?=
 =?us-ascii?Q?am10p5ADmWt3NU+vAHkh60NKGNZL3t8nvPXQMn23uaKVIWUzi+mNoOayrF73?=
 =?us-ascii?Q?jCeiVIU+vi/7+iaXdYeMhteb8HrqfAYRkuo8p+2i85lLuV3eFDBoZke+LVjb?=
 =?us-ascii?Q?Q+Z/bPJYtEWeshY+IYUGXbBqktIaBNC1Z0hxjHgYu9Xjr9f4T13H7p9LFEme?=
 =?us-ascii?Q?zEpAWnE4A5UjNr61XZCizcGeFv2m1dISKfzyNto0yFTd6+rQrmJPc3/N1Ddl?=
 =?us-ascii?Q?T047tyDekq978DAH49JcEIiXxUMWqCeGxEGw+gfb46SlHvmUoypkOnCMD6gn?=
 =?us-ascii?Q?HykHkEW9rM1ZV66dUIwfnURXEinJuAcdsHYLX2C9eaerKO+Pcl9auGiOKwia?=
 =?us-ascii?Q?3tWT5h9T1DmDwPRLAMSABvXmQxvpcTUizpPqXp/o0ExNgl75GGmc1VR7N5Fm?=
 =?us-ascii?Q?mymKxXdyeh5dYSkNgllPmDJ84wDb3VvUh8vn/Gd3898Ft4mhgJeth6ZosCEA?=
 =?us-ascii?Q?6um6SLlUkac6WL8EgUNoo68x10DE8o658xeYs1azBkCWzfjN6Vijy/fqJIoG?=
 =?us-ascii?Q?s+1m8iRgnia1blPpATO3aR7flZJQm4zUv1qQkCFJ+K8HOMb6tXI+CkpU9hA0?=
 =?us-ascii?Q?f0Gmssmu+6gTDMzK216t6PPldk7m1Menaijqw411zwIh3caqIAaI0iw6Yucm?=
 =?us-ascii?Q?XndInzpmEvyR6Wnomx5qvMeNqGCONB8g2ylWPALNrB73UmunRh/ggXljAacx?=
 =?us-ascii?Q?zTWIrTs90rIfGn2L2z9r/ZDvMqd6dfZbJFcvJYpz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137a8540-4fb3-4161-a8a0-08dae237ff1f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:15.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5KI4vVUpng7hdCA0BypxJ0WkB0jVAgu1NWFJ4DwSdjFaMNJ/KuJismgPnjE95uDKthahxmfCbpHQZOK644cIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
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


Ming Qian (10):
  media: Add P012 and P012M video format
  media: Add Y012 video format
  media: Add Y212 video format
  media: Add Y312 video format
  media: Add B312 video format
  media: Add B412 video format
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

