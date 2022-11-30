Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78863D895
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiK3OyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiK3OyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:54:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522332AC60;
        Wed, 30 Nov 2022 06:54:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQv4pCh4Q0m1K2sLHHRMdDvRu00gaOxphMp4tZ3mhXFn6wfkPs3UEppB8ciaXVRSAvQS67vKA9g4Pta1oXKVlaT0fzHbnMRe8n6w8a4galaLuJxoUfJQ042zj9I55qW4URyrD99+UPRrEmDoE4/xiJFgZDf/iFeK212Gv10zCYEWkhJX+tcspfxlXY3XD+npJj2LBEE+cp6E0t+E770AIHNxJNfUf9WaxAS0qdiDHWjOfCI8kqkfeMjyIID01PEHNk/cxBHEnm6D4Loe9tr2864Q3/VJXNWCVOa2TXkAE2j1aXvW3YWALOs+vknuj+hfqwUcgOMgswa9XJzKz3TloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KGfj0a4nDe53WaQ65o+byEaBR3heOWkJau4frimBEo=;
 b=iw78QA9eU2zlHOu1jLo2CHm0HdZ0FB8r/X8IlsuaK0zwTmGpiej4tQBX+BnNjg55IpspQu2xVhQjdSKjVRiOrRg846QdcHfBmpOpbnW4wCscnpmuL/egca7Rr8jbDR3CyQHElFJ5gpVEmHspf/pKOFRa+MgsbrnpBXdd4uhn9SlTeGJxbTjpC/MnoPpm1ojTLkXSenE7j5Et4uzjHPop/HKQL5/AsQ7Hx6b/qAaxjf6X5adOMIiqXQZ/W7wMkqQ0NEmnY+14piuTlKHB/A6ry48B2hZC043OyCVU8+wZa/aGp+AmbOT5E1DXktbKVOd1LIZfx3o0t4nZbc8oU0Is4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KGfj0a4nDe53WaQ65o+byEaBR3heOWkJau4frimBEo=;
 b=iPyZXysfYuXK35UXIGcsjsMt3DTbDff6GGIVMU0KAtQEhPdy/qJpp7X0K2W6KwQgp3wGlOu4zIr+psJwbgJ5q2GaHPMhjhhLMGnVUBGiwoMefYPIomPap2UPvihEELr/qPOyeaG2Ebxnh3hKjqIv/5ejfbTzTyimhsYH5sfSwgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 14:54:13 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 14:54:13 +0000
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
Subject: [PATCH v5 1/3] iio: add struct declaration for iio types
Date:   Wed, 30 Nov 2022 15:53:54 +0100
Message-Id: <20221130145356.1129901-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
References: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d13749-aa9d-4a39-4cc1-08dad2e2beb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY9HgM4JCPOR1N0nXWt1WR+XJ+PA4tZzXQvhve+S1FqGf7mTSINE3B6hxaDRRuB5b25bRHudw0HgCufNihtTj5A+i9usJ2kbXFmHshj/PkCSpqeKdm2Tf5RXm5ADgnA8TE2lXFXqnH8z2zzeY+Ikthrmr6hz/g3RiBFbOmfW3SY50r4Hmin48VRLRsupll08bz04ByE3BGrjmsJWsELAapVzH/L3uNSNAn6DYPiPjyemJ8BU2IZaxmyYa2Niq0rWTy5CBIbIFR4zYgeDsn0IheifNq8QaWLD3i36zFj3+5UNwoY7nbHCIiaSH9MPmG7TR+HzFlhrXIPsGd7L6jEYxAGVnipWhq1EIfyWPDHxiqC8Si1X9bt/T+gEVmxqTZtJFScCLuPwuYDnrEDHxPbQaPnS0ZPwjw495ZFUrCefZu3452grrNjmduQXl5DZNyDr1Y3sI8feV0kqnNEqJh8FlxKJn5ykKxTTpVJEJ+zYkMMVn95WqKBkq+vT7/I9r6mr8yra26OPH5h2cDtrq/t4g7g9xrlYEvf61u71AeaQbfq3mY4RcRaPQkvjwQWrX61RA+a52cBCNGxm+/bgqRc8VSRvNUajlSlubnYtGciHGN6g+nlfacgZPHejHDXKpDTN84SPX1FQOd16X7PlwsTN+L60IRlYctstNIE2coiAyBiB6o6C22PgRJ9EoMzb9vFO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199015)(52116002)(478600001)(66556008)(36756003)(6486002)(26005)(38100700002)(38350700002)(6666004)(6506007)(66476007)(41300700001)(8676002)(66946007)(86362001)(4326008)(316002)(44832011)(4744005)(54906003)(7416002)(5660300002)(8936002)(6512007)(2616005)(186003)(1076003)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gez6u7kgTqk4Vy8cAJ36oieZNWiyqFHw2LLKNmsg/RS73nXkzlGVUrGSRMnm?=
 =?us-ascii?Q?FNc2QViwv14SrxzCVeYsoDIJSxjHMx5h1yaSzV/NsMk3OLHROnA8hja1b9wP?=
 =?us-ascii?Q?DQ+Y9cnYnEG55sTBfUCT0U1JJTsmTElrz+dQFQsE8kO6Cm2yh2FVxF9GuLxC?=
 =?us-ascii?Q?6aLQBW3TdntOPIvoHj5xj4j7kgVoKhJGdOk+hOdRfEH3oYWZXSdlxzeDF78j?=
 =?us-ascii?Q?lGG+49vvOv/iYKoQX8Sc4Sjkp54sxyLhjpGDplJuOUylaPBhIJ4/xBt+YaXg?=
 =?us-ascii?Q?qsIK9tH3dyvUesWiGqJM/nOgq/PGqbwWXuZIxC0qV/hNgoPvAGdAdmuWwltK?=
 =?us-ascii?Q?vIZgqjGlQPONPT6NeJsCqaIK9FFzGxbxWUeAtzylBKU5ON/xfZ/pBAxQ8Hgh?=
 =?us-ascii?Q?kA5GB1uCDiFj4Ht9P4fOZ+LLgp1ikfKKE/Pcwvyt0xcTNOrTzDHeD6RETU1w?=
 =?us-ascii?Q?pfucBWn4fRKo4bmdHOJvsoeejGdc4FB6qUB0tKxKpDHXSyTHeLVNQbWPThKg?=
 =?us-ascii?Q?b9QU/sJ3UT3Y+rI3HF9Dm3eXQ9IZu9n91/1bkhzhgxbz5aAYYl5TdC/gEIoe?=
 =?us-ascii?Q?i8gJATHzgVL6Bqp/Li9e/bUblrNfaD+nUsbc+jys5iUQ/WvKrHmRlsF5PtcW?=
 =?us-ascii?Q?PNAa5bIdjxs9QI6K/tBiSdwPvrlMwaQ3sy0+YYBkJRFNN/8b9NAjO5LET4gm?=
 =?us-ascii?Q?AdsbNSbEnPIZ8QWzjz4raHskDds709bEqMGy39DKZVg8eTGiGjRfuJ72i0XO?=
 =?us-ascii?Q?gE3Ff3LD7L0jolO8dBxlWImPRB7aXGwomuLeyHqka61r9qp6FTnlPNA9WYs8?=
 =?us-ascii?Q?Tl+OUgoQ4FToU+NmxunqJAIhWqQ0AYn9cdilP/8TpDIw8A4DLyt9afLgnJOO?=
 =?us-ascii?Q?OqzbFQ9lHaRV41SwVBJIepmo14Q3T0NKb0YojQn2OOr3ihqBAYx1W96UjgfJ?=
 =?us-ascii?Q?PzoeIpFivLswrp76QbImjDB1CN4TQPQasJsQevL5K9m8/ocxWMmB55MAGeR6?=
 =?us-ascii?Q?O4sOOKiKjYYtrHqYEUG/YJNIOWMKPFoT6nFjfiWaFPhbOmnS9UGi7ys9LuK3?=
 =?us-ascii?Q?qedGMN1/igRD8cRRLUP33NpxAOCWTgo+MkWQxHCu0s9VjvKc0N1Yr3wZ01NW?=
 =?us-ascii?Q?/lPy8IEMq9BfBb2lhQnb9B7yQt3WGPq9yBMy/a9PqWvXECqRX5jHhE31wnAq?=
 =?us-ascii?Q?jNl6muhCknhQbIjcS8s7+3bYe4LUMbxVgMdPUk1gXA5I2ieqauMC/ko/XSxy?=
 =?us-ascii?Q?DL43FGBxIchgiGOYLUqXMXM7UWDCbT7gZkoBpUOFKGlzv+KgWzPSMwz4jHPr?=
 =?us-ascii?Q?nrW/YhJg2vLxmh+hksnlpEGkXoZekLMjS/cbScqd2ZXzs0ggKwcP+xwO8SWh?=
 =?us-ascii?Q?WUBcPySt15SiX6r+vUHqBbksRgibzFke4oJE/N9LVTMO5MSj8+lDLTtZ6mmm?=
 =?us-ascii?Q?PPO82AIeql1GuM3ZLV5RXg/+bros5BDz72RBuI9xW1HsxGjb35MbX0LX/cW3?=
 =?us-ascii?Q?9pwHZnrSvK/JRrz+i2t9Fr4spEyfwYHBf7b+bwVseIYiGSyJyE2taCKANDpD?=
 =?us-ascii?Q?yLf7++smdg+F0LUGYRcInFdDv4km8rjiGlS3hJiFempFPmcYknhT3YraHLw8?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d13749-aa9d-4a39-4cc1-08dad2e2beb9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:54:13.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM0nUcQpI7z/Tl/h7Lwmw6tCWfLX5ngCx9I51CRP5q9+6yCIpWNJwbWUsH6zYu3mRpJt1BwubkT2HlMDD2BTdE57OShaG7oDvtBSQ4Kk2E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct for iio type arrays such as IIO_AVAIL_LIST which can be used
instead of int arrays.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v5:
 - no changes
 
Changes in v4:
 - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type.

 include/linux/iio/iio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f0ec8a5e5a7a..e5101bef50c5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -381,6 +381,11 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 
 #define INDIO_MAX_RAW_ELEMENTS		4
 
+struct iio_val_int_plus_micro {
+	int integer;
+	int micro;
+};
+
 struct iio_trigger; /* forward declaration */
 
 /**
-- 
2.37.2

