Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1D6E79C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjDSM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjDSM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:28:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB415A13;
        Wed, 19 Apr 2023 05:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNohnLL/Wv2NAhUeDpPt5QnSI27FaOdyEna8N6R1hFWacdpT/EWWv4nK91Cg4L/TAj6OmkVcuw5A7c7m4qBpUzrMWuCPBXdYq6l9hJcUyUG5iQp1oJfCWKJqZLN/6d6GqJwjnq2GOFd13a5CvE/y3/0CYgEgVCk/H+Z6sIEzXOT5LlC6jioKj3/R2juG2NxLZMeXAUck6bMYYO+6G4P+lNl6XgstvT/klFVb8h6RXCPB1EUwJe8lXm3J0I1FR0r5Qj3h5JKJX5WljQ6oJ3bWtcxMJJU6dR5vRdt71zkM33yUM4jxG1aHagaHRm47+TE/L/eFXAaL5RebttzHB6Kxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dBZFctoi+HaxjOjd8B9Bvo86l9CZ9XFJYprHXz/0+U=;
 b=PFwcGS+3FR3Ok7IQn3TCYGecLTu6LYjryZ3HBhLfL+rFnEAIKiQvEjhb0n7XZPd/qGoKLESSDeV0x88QKyiNtjTxly7bVmF2Sbzby0R9DQheNZNyEUOOHM3PEpsZNbt8lSy8r5IJRR26BQ4yzz+4Z289sd+ZiLV4lGAdlD8NEspchQ8fGyh8anTZY9BaKklEsXWN4hnBnGKqXc3VIxSL2jgXZaWSbgwt+VlyOuBeX7ibVnOhVJHmBNyXUivZ7eWv1wITcDNjlxcBZ+1pFPB/2Yc/6PCkTrhs0ctxmxZE87kZCCf1O0CVXXeP31WGEC0JhiqHX3YJSbEj3Wm8gpsGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dBZFctoi+HaxjOjd8B9Bvo86l9CZ9XFJYprHXz/0+U=;
 b=Z/xr+hwbSbV4a4LYMafX43pat/X9mUzt2BzAjVHEGt/IqvjxkD60yeIZGl+0olw/u0LWSDdJZD7qfxQg6u+CAvt0rbEpGIqbIX83seM4deC+cmGwoWG0XdgM+JmnNRGiEQMW9BvMKGSRx/VcFu2D4rjH0v7JXT9V+2hGjWWHYvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:26:59 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:58 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 7/7] MAINTAINERS: Added maintainer details
Date:   Wed, 19 Apr 2023 23:25:38 +0530
Message-Id: <20230419175538.855493-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 497d0195-bb9e-43c0-2e4a-08db40d15eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2CiAkPUF9tccGdpz+yJxRWK2JaLLaWCYnMIGEeysiix0U9wS/FvaiG8yB7kniHF5D4rEWLkoJ9UWpoorpHiac2ha+WnoXCDsP0S0B2qr5IEoQkOYDuAf2mbVyRKsgLop0tcKEt0zOIJjdqRK42wcajpgORNxEPAnjHgyxeUHbyW9ydhx5pfiLlzcBqo2FzwWQo/NQpV/IZW5D9I+pjf9pG7LlSFRj7n/DowyIW3/4KPBE6x/UgyWn8NqZolk7a3tdzTZVmhHiBk4Y5oX/tyI7HucD0OQw0jUalql+Sn0bugpcsOWYESmMKv9ETOdVkwXLUKzOKanhjlOlAVANwkyPFiFnYcap29X6Ov+U8A7f/1TBhhPHJWWRPJlhiq3bd5y4vYHPwhR8jot0wMwnAKyWHAK0jOcNphFQFPkkCOxRLvGUACvKCk4BZk36q5gnOoBA2twpal/Qr+IsptnXLf0cMH/HBHQISXn7NuyO0RMRBaXSxCYXpjVot0dsPVxpEu0fIy4ylz9o2ryMPdw+Mucva3AqN+gDqVEmCk2j2eIyMAmX/bAEWK7mtaFL0u6lcZ8R9ljGHQ6B4m6w2R9dADmQB6AfSmrHegwlN2kJf6SZm8QJJTDAKPePhB2uwExcRMs3FCYccHbz+q9YlH5libYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(6636002)(83380400001)(478600001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(6666004)(66556008)(4326008)(66476007)(41300700001)(66946007)(921005)(316002)(186003)(5660300002)(44832011)(38100700002)(8676002)(38350700002)(2906002)(8936002)(4744005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByWPhJRzvZLGgg5QRFz5p6Bd7v7FPNrGsxGF/4Kq9/Ag2apJrClbX3y/ifsi?=
 =?us-ascii?Q?88yw0638NDXoqJLxDjLW2qMi9w3+AppNiWhr4IazkX8cSOVUukuYDZ4DFF++?=
 =?us-ascii?Q?wo0TDSBg1Yq3Ic097QieeYspOECdX7htTk2AXGqHLJnS99a8qMpfau94ud5w?=
 =?us-ascii?Q?3GSxXVoSZt24ZvxfDrNdQw72EN8FxJ9bqmIMmpMfs2jZ1IV61nJhpuwxqNv2?=
 =?us-ascii?Q?MCNg5gD8hKt4pqxnn5Xc+KccIrFa74+XRTvHhXZ1p8L7BoBZ98CzmhEzVYA1?=
 =?us-ascii?Q?k4bGpzIvM7LSuLPXNNJj0jVD56o8UOlThIoJRfDGFImqfIdHuqCxll9dFdIT?=
 =?us-ascii?Q?N7xDSuKhpVvfIVIk1xhdeWBZQjVbm1EC3uQc0KkfPQDgozJjYT1IrQ2d+YiH?=
 =?us-ascii?Q?heVYMkvthlh4Es0VXpYaTgFnxAG5kO+tE/sq2d46QbRM1dj6SJYQxsTPiOUa?=
 =?us-ascii?Q?mEDEdgthBVDJ4kX8YI7QRqeJrTXvI7zR5ZH9+aDlhBJCqo9/jYETTykEtfeJ?=
 =?us-ascii?Q?5Z37B+bx35GAPtLFqsiiLrEPzyiBkwnyRk/RU7s/yn/OKvC8pv8FUGyartki?=
 =?us-ascii?Q?ZkZdaPOX53wcrr5smLYsijnbOvIwUCVQ2ekNjFjhXjoTk1UQAFJ4jdcNryJq?=
 =?us-ascii?Q?tAC8+Bpu34GfER4T9TV+U8i+2z7cSxSgdnW1L8erQWZTXfwLAQ7tO7zNSgRz?=
 =?us-ascii?Q?uQBO+c/JaZTIlpo6Dag4QJJpp0rJ2XyLcq4Z7VTXWx6FO9LN3gHR8zHSf5AN?=
 =?us-ascii?Q?zohsURpq52ZtWToa5rozjruR+psJiZr5bxDHBU3J0zSICP0NjzDo7juEJ40k?=
 =?us-ascii?Q?qI7i3DfG9qoUwzn7mIhTlWSPk9TEGbyQ5aJeuXko8x1mU6ie/+jc7wwRvzij?=
 =?us-ascii?Q?MwSuukbAuoRS/KtS4amHYebnudrFW9Qp9cCeXNvjjEvFsMSEt3Cxewof9h2t?=
 =?us-ascii?Q?EJ9iJpU+YpUzkdIx8ACEN+/DvBYHLxC8zlI70jY+b1mbgoE8BuSVtA8i728l?=
 =?us-ascii?Q?CendY3pWkv3tyGN4jiUDbuL9qoM0Sc4hxQGUpl/uHCAz53smB5lVgSr4yiJU?=
 =?us-ascii?Q?5Tq8+s2+hURAON2ZEqqbA8dPX+uSR/aEBHLR6JnmCZCKVM5Y9bqZchjhPjSM?=
 =?us-ascii?Q?FkBFYLkwk0pN6S0YCsdyyqScOmY2YI5ZojGbKRue4BO9rV0t9t3hyWAxecio?=
 =?us-ascii?Q?HgkfOTJQmQKxwimznwzJy1naGajsi9jYymYSGqvJYIGzWOSUyK2ztmQdh+8y?=
 =?us-ascii?Q?08KaJstkOMI9f8NUQj+FQpcTeP7c+wz5Zl5QQ/2J0EnugowTmD3ohKGEGrfX?=
 =?us-ascii?Q?p1hmX2uPKPVQP9A/HMzEK9EqB0Nl+mvtCr/LK9P6a6/xU+6aH6Yq1uXDiQ3z?=
 =?us-ascii?Q?i9lq2m33gaRyUe8jqKAXosj9rFtRdca4U31mqItz3va7M3t/GG0m43q7tn0Q?=
 =?us-ascii?Q?Gz563zuKmW7mJCBT7BqNvLHlGxK9n2WXLp7gCf2PpaPYIY+MT/SqJIuz7Z6f?=
 =?us-ascii?Q?XlJlBW9WW0B8q1IGvr/FiZ7lSwow6Cpa2yI3jffYyNlfg4ypb3hWo2CcnUZP?=
 =?us-ascii?Q?1LH9x95GymJzakE2TL2hUUbvhuSMBchRmlLQLXfV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497d0195-bb9e-43c0-2e4a-08db40d15eb6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:58.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Rwdl0R+jTrODUD3R59xiwmS8p7qKzW55Oy2KnKTuiLsE7QZGWf0oK25XOqCZiWHO5dN2ZJaGMCRBvCz/xq1HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for ele-mu driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aace8..59201de85009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8103,6 +8103,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 F:	drivers/crypto/caam/
 
+NXP Edgelock Enclave MU DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
+F:	drivers/firmware/imx/
+
 FREESCALE COLDFIRE M5441X MMC DRIVER
 M:	Angelo Dureghello <angelo.dureghello@timesys.com>
 L:	linux-mmc@vger.kernel.org
-- 
2.34.1

