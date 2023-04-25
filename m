Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476476EE14E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjDYLv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjDYLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:51:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C62E67;
        Tue, 25 Apr 2023 04:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsBsi1ACZb9hCJVKLt/jDMrXfSkYrEhUTiyPOjzKKUW68lkKa1dA/LWMwtt/pG/X0BlKtEvOmMHjD66NWYL2C6eVQShCC07aTzSbeQSdzW5DJeDhAiTy0DKmBiYkqZjb5CPiQu6q3b2J5DTgnJhuMz6q6PkFgDwE2757ZMpXsfSB4IYAJzSTh+cz7+pz+kZJhmLtczGvAqMhnD3dmR5YTaW34l4rWDdeTqfrraN1DSUBHeoQLpqOYOnFX8Kjw1xUcw3AUBUmY8+eZQX7vXMybZ3C67MhHYZh7nndWIBY/KnIKRRYLCsKSjb9WpKSiyiBVinnK8UVsL2s6eMw9vqnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPTyOIfb1O2zUDAwkV1u45duNt5qAJy7KGiSnpKrFM0=;
 b=evIE1Ie+BEcYH56WgcQTkCgSFhELANYCPI4pfpqZoxyKV4xSnaQOCzhFpfe4/u7T1FJv821guDykT4KJuJBJz71XV+AJUOcP2wGnVo3REiL61IbgoeX4Gln4mKDMv4pgsoqU7EQYYrE/vQ+fCcjHkPAqHsA+YgZaNzQeY3QIgjkvta7FDGNTK70cktcJR1iL5RpfIGH0HRGkcw/xwKy2jT2tw1D2MYd0uMXTrF1ZFqzgB3KZbTPR0ipMQ+/FmwlEiZOZuD7ned9TJ0s+HePCyM6jNtwGOLe1b+eNglcoovnQOxYPUuU6gOj1DYPcHEwp1erMs3P8O0XwXP62U2BSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPTyOIfb1O2zUDAwkV1u45duNt5qAJy7KGiSnpKrFM0=;
 b=DjfhgHnezzNPY8TuynqPgS4mB+Oy69Bqfer0m1SDw33rnOewDRnzjJZIz5p15muEuG2hCNexFDsZ38050qrBuwNShKdnUDDknLTmFDmQuliN37CUYOrrqbiuCI7yxJLDft9rbtVPumleRk2It1vymk5GymlgWqqV2rLMadywJ9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:51:22 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:51:22 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [RFC v1 0/4] Input: support virtual objects on touchscreens
Date:   Tue, 25 Apr 2023 13:50:45 +0200
Message-Id: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a38eb9a-cd53-4fcb-bbf7-08db458363bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxO3iKAWDLuQ2otuiBX7Fl12JRXwM5Vv9zlDo8Qt5AZcgxdUQ6S6MO7ntgpPFT7Zk69Amw1F0wVfKjMCASUl3Jhv2m2mv49QpW5VuvJR5lpPDUOpcibs2L5t7QDpciTvESC78YBf/2A0e5TaNy7WEaLlRmZo/lm9FHABxD0mTi/YgybuPpHjGIzUF9dF1T/pnO6nP25afAYt3NVNhfZi+7H6xo9aucvaUrF4FBSh8YArsT+W+uSZT71zfL5mw07mfqWuue5kSQQ1puSq6+WRugj9DOE8XKARnn/Ach5lF8FYkmbc/YiucqyNZ/1O158So+v6XlBmuNNZndg3FElBPRLiVkbr6sVvahZkXTkYpj9rfuVkUxFInxMeDJl0LZ3uIqg1UoCSDPKKbjw9lqBGpkQkeFconn7gmTyt6wB21P0Lrl1A9tBTMukjJhznKMsm7lkgpz2ri71jZ+NGWjaTGvqhaVWkenb2ciIFoKk9kdPPg9uqFw1S/af5xEl/WgmkruEVg1QhSoGH22TChiFL9zvurD4yjuyXixv+bpU8uh/xx9NrPLyuEU689dtmW34ca1WjMfgy57u/coqRA9ahFhE+MRO8BVXuS5JtiUeZpRScHtJypP4n7+gvATDGU6rY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(38350700002)(36756003)(8676002)(8936002)(54906003)(66899021)(478600001)(66476007)(66556008)(66946007)(4326008)(7416002)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(1076003)(107886003)(52116002)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfuOMJeRYo9mbltgHF9lOme7eEv1T01sOCeONzRH+UjRj+R405U14dPh13ih?=
 =?us-ascii?Q?on0LoxcUGwSCwrbVobqjbbtch5L2RlBZlFBvx8kvoIE30kt7HhB5QDYa7PIX?=
 =?us-ascii?Q?2igpAbfUgzHQYUW+gYauLQiwMtYmlVslDN+wYvuTjxF89fBlPJ9+THIdp9lf?=
 =?us-ascii?Q?26u308oVsNrR130t9bMfVTaRqXFYmk1bR2mWiyHe336CeKwtYnPnTxoEzWld?=
 =?us-ascii?Q?gmwvydZVDQMAsAQi6j2xB5MlWwh6NFNQkxlGJhl/jnUM/9sr6LuD4eAeRdHV?=
 =?us-ascii?Q?GW0WNf/ex35RG9hEG+0VkgKWqCCh8wdsfAQrOemFfsJ5DMqeDdTtOilEE0fv?=
 =?us-ascii?Q?6mkvLv8bxda3QSbI1lNckcsCcb3u2oHlqH3bB3+2Dwq9v8E4DdrKs3r23jqM?=
 =?us-ascii?Q?JAeZWTM4mvjPCailWk/3DA436y3r3rf5YEdRe3Mh/JdDFmbGQoBPFSSHVlSM?=
 =?us-ascii?Q?szBSbx/nrBSYMiPdoyIukpvIUyDAPi3FcZi4BrdXYrIu26aEmC7WBR4ygZWF?=
 =?us-ascii?Q?KHuevhvhdWe70jcOa1PmXloZmXVkRbERiI4Gqm8q6Yf+OtTaicntN+Rf0vI7?=
 =?us-ascii?Q?Z9gLNrDseBZz67yO+UR8/0vDBaG7lnJWlR3rSw4fx8u+RYLqfFPmLykitC0j?=
 =?us-ascii?Q?kklu+GDsFuHt2Upx2M3pTvwQ7j0lePXGALqi0p11sYFaSu8/F4LBlPwCtn8t?=
 =?us-ascii?Q?2fYiISUEzzgeGswagKNmRguJVfc3fbnh2FZKBUx1wzeLC9AuBE4lofPFnZed?=
 =?us-ascii?Q?eSr95DBSrGrc8bicu5LgzvI/XvXl0lP68e4hhQByYArGcT+3PFw1V7tShEA6?=
 =?us-ascii?Q?+Vopzkg2dWoj6iP/d8i+e5z54erV/RsFASis4XJ5AbCnGolY+Z31ndxQJwFy?=
 =?us-ascii?Q?smRCFY/gD3/bZRHDs+IP9zXtysf5lcpQd/+DugRbYhJ5Zb7qurGqFHPDFAwE?=
 =?us-ascii?Q?+Dj1r4sPPWswao3DaT8JYSS+HZ9IHGkPoa3o1DCk7e7Zd2A1AhqEfhcoQqg2?=
 =?us-ascii?Q?EzwOkzC2+CyeSg8WCZxby4kCEfm150FVHBpOsPL+wVeeiQ1BCuVWPvwMDvXa?=
 =?us-ascii?Q?GI4FXp3doOYBCFwOlh6UuCY9WXUA9oDkQ9AihFrCnoc5exVnVaqVVTIDzDI1?=
 =?us-ascii?Q?f4druATeDJ4wERArp1ALK39cukn3cF9ND/slwB3i9Y5gsnkiiMnwkLhLVVbR?=
 =?us-ascii?Q?cQO22RgQqrefpnqJD+4bgcQa72sCLAvEW2qeZOEsBEwxCzOwf712Jc1pe/0T?=
 =?us-ascii?Q?WUnghRzZySNaW8Xmj4SJWA+mpdPOxJvC4imn02QSrAkrxMEfltYPYRxTdYQT?=
 =?us-ascii?Q?japqm/pOMmDQFv0AF2Mltxp4fCq4h4yR1kZ4VfAzz7vod0TTVJH/7UhDFyhY?=
 =?us-ascii?Q?v1686ETTMdwXXqVeKhyD7RGFnkd5FsCdORru2JkZ1/2Pxq8BEtEfkOjrQxTB?=
 =?us-ascii?Q?5xWwCZaTxdloSgdzW8SzWZdZw28yhe9bLsMT5Cb2LA8nE4FW+mbnsM7boh3Q?=
 =?us-ascii?Q?4pI8Fg2PeU1+MebOIH9DvdxOjDAx6UL/7ospTQt4TmWdZKEorPy4agPwUhIA?=
 =?us-ascii?Q?N21/VuFnhEp1LZwcJ6i5mKNgFfzjG2i8nAYwNRIgxoKgbLOJcm3u7dZNTxPh?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a38eb9a-cd53-4fcb-bbf7-08db458363bc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:51:22.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6wSsk58pRWk7GljHOL6oHqqa6e7yT45zXnpv757UAL+bv0umri2KVmHKEqypG/On4zbu351iECZCdLHCVvjkYLKYQdJXY+NdQoTne0hu1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, these patches offer a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in ts-virtobj provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as virtual objects and generate events according to
the object descriptions.

This solution has been tested with a JT240MHQS-E3 display, which uses
the st1624 as a touchscreen and provides two overly buttons and a frame
that clips its effective surface.

Javier Carrasco (4):
  Input: ts-virtobj - Add touchsreen virtual object handling to the core
  dt-bindings: touchscreen: add virtual-touchscreen and virtual-buttons
    properties
  Input: st1232 - add virtual touchscreen and buttons handling
  dt-bindings: input: touchscreen: st1232: add virtual objects to the
    example

 .../input/touchscreen/sitronix,st1232.yaml    |  28 ++
 .../input/touchscreen/touchscreen.yaml        |  54 ++++
 drivers/input/Makefile                        |   1 +
 drivers/input/touchscreen/st1232.c            |  41 ++-
 drivers/input/ts-virtobj.c                    | 305 ++++++++++++++++++
 include/linux/input/ts-virtobj.h              |  59 ++++
 6 files changed, 478 insertions(+), 10 deletions(-)
 create mode 100644 drivers/input/ts-virtobj.c
 create mode 100644 include/linux/input/ts-virtobj.h

-- 
2.37.2

