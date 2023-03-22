Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081386C41E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCVFOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCVFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:13:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6651FBE;
        Tue, 21 Mar 2023 22:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1CbF4fmL2+jR8NsQornTKcbE8j4kI1GpdQe7ZOEk9KX0rp3mooI7XZnbHaDfFke28B19gvBMKXheH9L5lTeJniO4ofp6a2jrJRbEWaTWSZMSOrLTr9LxCEQ3Z59VSLopFWjgGWyK732g6hVraO6De7xm3oIC3BuT0GOMQvwRb/U7EMHc3iKRwDroUVWz8J81KcRF0MYktTX55iRYJAgwtI+8WMQbdtzJPC6jfPVusFpWtQhSKbRhqzq45ZaUUhcZKMJrRQkAtcSV9WWZGQO1xBgQw6ZVRYWs8MlrYXtNM+MYQNOEbYtYYGVIF33pWscrxePHzOqpn5V12Vda2vcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7cKeN0lTqGsO4nqj7pO/oD9FjZqKyVVa6nQ8BbK5Vg=;
 b=Ta4oAAISkgmM8YCKVtOOAPq8vMD/5GTbG/1JB6XbQ+AHucqUyKIKzHcwHCvkqNPIXnKwsGqjzwAd+jvMT0I8Mi1p/X/cdelz+0Io/o9ZghfVkniDHkte7w7xrcSL+pr3twQ+dekQjBodynQ1fv2YdSRSSyiWjvoIZXtFyzBJzIDDNE375DVo2Lnl3uQ0Dk/PYIszxU4E/CkdM8u1M6dOwxTXlLbPa1hn8lwzGfE2XpU5z3CT1K8Mikgj8ZD4dlBVJ5JCx1AVdYZGghBg98ef0LzHNdqW+OuoHzT9PYJ3z2oRYSn2i+cwZ/zbvMKHqJ4L+g5qvLjnSaG3oVl7l/a3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7cKeN0lTqGsO4nqj7pO/oD9FjZqKyVVa6nQ8BbK5Vg=;
 b=DSDnNpPjb8REBeRflT3A2Ar0lJgZ9a7OIfsChxi7eGyHAcXl0QRaeXTMGD4SSaAsVz0g/1yP0LlkNjpu9ys8u9husBe7L7/ssg6td1g6a/0Yhm2gixtH8Qqhw7yySL13AcB6mqijt6pb5KBVWRqq1l9JkenW5nLS4fcf7182g0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:13:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:13:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 03/10] media: Add Y212 v4l2 format info
Date:   Wed, 22 Mar 2023 13:13:06 +0800
Message-Id: <a92bc69054de555bec1d58ca9b767a49d21a6ebe.1679461710.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
References: <cover.1679461709.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: f8be1dba-1b2e-4474-6350-08db2a943b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgnpsEG3eMJtYK/GIgWB1jD1C3IDnOUBGwwFsWYuI4/2mVxCZzdexnd4hga/FwCHu2mdnesyOcmdITUc1uzgg79OlCkLiXdNBF/DBBYWCzGWRK2X9Kv9qhIj+prWB7zDPsHRmTkiQmTLJezw0mpEcAZPOwQKTuwyrGWLzY14HB2MRVA42w+2MLUPtY67/tAnaC/YX6jWefZQjYpmqPskOEJDxDw1STFp91yh7g3XTSYStny7hjiMVSyRFQejdoYAIEZk4j3ikgFjZWxMfpBz5x+qyZRupqihPbfD7pKjFWMwypQ4JpQOb2+YF4cLwIAlBay+1/3WIjvfo0ud+ndmQysUi96vmJiZVb1qihLkft/YNertc9K817URXsPVnsiXHfGyrZrDYF1fY0lbCoNCxGk1t+qQ3MST4lWbhfnjM5PUTML/Oynd79+XkfJ7g11gFhq5TVCEctoYfA2iC8Nb6vwF8MvqGdVXwR4ZJCzRgKWNi/Hbe5/WYIvBf7+XorzoZux+8qSelxuqDBlPjGCkbE7Y4oTpOQnKy4c3iosyDIfwZDXldshws5sxR7G5N3SZfx4K6hWjCXIsdHIac5hZ/QsyqEn7rgHkVsEN/ee24TKb13tIhxz3dll7MfrBRJPX8MG4rbvmY23DCH+IDYscRrdKUilKZroh5PPTVVQXQZWaRL5MXdA3C1zNiNb99BdtnbKRhsSaTy+APaEMURQjaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wymhrKO2tPm+jm0Kg+9KVrssrqAsFc43RWYYzOZNd45F4deD2snxxbgzwjvh?=
 =?us-ascii?Q?QhjZm/CMLxjAJ+83wC1L3P/8bW6RIUfrxbPyZOOPWi6f8SZD2tGMeMFrfCoz?=
 =?us-ascii?Q?1c0uYl82RFVwbaa1467z2zvf6aXUk0ISL1bn2HjSeGxL/Kt78TUiaQJXiAap?=
 =?us-ascii?Q?uhAcLiNN2teBQ1sXE/eVJUyxHgHS7w2qbb5/QHqMAwqkvTYKuLhsRRPoU1+c?=
 =?us-ascii?Q?NGem89a8ejyOzEOngjZyuc3o2a55IpEhKrln4Fcdrt/k1PrFGwJQ89jb3rw0?=
 =?us-ascii?Q?EGmgkkWSK563GuGM3eMzRHktYzBcDFXZbbMdG/27eGIR8flGlg9CC4zT55gM?=
 =?us-ascii?Q?YUIb0JgQxWBN5D6mwerhgKyOCSX7IU6jpfjUV9RmW9eWXbj6XGHqbvU6pZMH?=
 =?us-ascii?Q?AWnchKc/I1f1s9KAoUw3A5xY3dVHt6JyEf2DtKFTkIcPXbKoZNkEBSNIlpr9?=
 =?us-ascii?Q?5/k5/FGfBo3p+vKC92ntaaTRVY6hj8p3Um6B0BbmTUWdXyh8QTQGEb+cs1E7?=
 =?us-ascii?Q?YQ/J+atOdoiS/c6sO45mj+N7X1TjJ7XTVp2spPFWSZjooqjWy0Wx3GqtEE/4?=
 =?us-ascii?Q?W38/dd6yxMLxurDGtspe6EirgpujFcxllvaCTCctKTuh6grUEtzMkMjRkE4n?=
 =?us-ascii?Q?h0sxjrBl5uVR7nxe9kbmaj176hYO8mBJnQoHRdll/SI6cXuzxZvCsiZKEjkJ?=
 =?us-ascii?Q?uwIrDCy3FCb1iZ65Fu1VipH4Sa62JQhWahFBIjGEEzSv2VL9gxU3MKy24Ukq?=
 =?us-ascii?Q?b5HQ1Ilck8aCx4OiwoY4s+KMYKwFsu31xV1jOiKR87LC6lRNrUXBeYrF9/jZ?=
 =?us-ascii?Q?PH6rxsWoGSyXqgD7jHz38iN9apxDpe7KsrQkSmwnpK4RqRug+0CDg/ADIgPu?=
 =?us-ascii?Q?j+tr9n98WR8jTPLC9+Djwbwdwk0OBu0NLgxo+wGctJp94EyPzulL8ljK8Wmz?=
 =?us-ascii?Q?oF5WposMCDRNOFM1Pv6TLgUpRmtC0o8eAowgQHm+/L33pKVwFun9F/+Gab2j?=
 =?us-ascii?Q?NB+HOJpJeswCy8Zc0G2kB1DWxWcdTt21p0zqbw0IsdoKtgNV5mPsetUL8s8H?=
 =?us-ascii?Q?mkHO55lImqF2h0WR86oe/1dpEpYJEJC0QFvECXYsl52yKutsigAZSvY0/9KF?=
 =?us-ascii?Q?keex0MvhH+s/KHyzAFIhWeUFkx9AoLWJcI25sf6X/hzLmmLN0sW0YGxUu/0L?=
 =?us-ascii?Q?kEvy0JRzhTqSjr6gwtSX99jVltJ9tNJo+xVcsUQacBIy6XZccsWB3NX6p9m+?=
 =?us-ascii?Q?ZM/4LNX4xjM+uJAYzCNulkXMsWtRccOJIFZkxB11DLWuFrzESjPhwIhNBhnm?=
 =?us-ascii?Q?Vxqo+kw6FN5agEgSujGBPKNIQQmjWxpj3R23nvoDSSgjhM652/W5tqx/J9f7?=
 =?us-ascii?Q?uwEovTZIRVXsXQ2Jl8BNoZnvcfLqrs/Nvao5Gffh/qmjI2vq9QvZSVXwDn/U?=
 =?us-ascii?Q?9QKSqQMzSkOAujhGmSl5XsznkmGTv9RpPyAQPK6tVjZskBwuQhSkIXMGIzHD?=
 =?us-ascii?Q?1sdYGNtpw284+b6eXWdhdb7gkgaJlkG1/Bz64I9FF9aw0DpN6QqplXnWyj4Y?=
 =?us-ascii?Q?6gX1IgzgLnbi2IhyckedzZqbIFcOuTnEplFPe6kI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8be1dba-1b2e-4474-6350-08db2a943b4a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:13:54.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9KnSpVxMKSwSdmBof0/FxDcGYf4rZTRAY2dM63jlD6zNouJm79UViyt34aO43NOWFD2xr9flIyYPJagbegYNQ==
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

Y212 is a YUV format with 12-bits per component like YUYV,
expanded to 16bits.
Data in the 12 high bits, zeros in the 4 low bits,
arranged in little endian order.

Add the missing v4l2 foramt info of Y212

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index a5e8ba370d33..21ace56fac04 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -258,6 +258,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
-- 
2.38.1

