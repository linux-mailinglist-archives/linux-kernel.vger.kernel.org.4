Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A42470166D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbjEMLdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbjEMLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:32:56 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2086.outbound.protection.outlook.com [40.107.222.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E2420F;
        Sat, 13 May 2023 04:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwhETLt2/nr1XBbIKw+mVeciAW0aJSm5mdBRBjVtuuf+oq9j7zyuSXkk+QyIFr4ndeGYiXw7Uzp5n+OhJh5+vQP79rgmrX5hNwjUdfy/8NX5go9Nj3Sgc4ciMUO9vYrpmmnXlTyqzBQfyjp3vWhGSb8STMGvDOmEK0N+jlur7W0UBfISrtgO/iUBcSjdona8GX6VU+ZSaJQB6rRl1rYpWqkG3PCZQMsRcsRu60o8ZS0B9cQKBg24a1Sf9CxFWUXlXJteAZ62u3i/jBlnmfB+aANXRVeRyR4ELKJoOhuw8WR+pPoPZ6BQMVFAZ4Nr5xXzg1JvbRnRav2P96mBPaWKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ICUs9Dxr/DtlIDdR5b42uZKOPdyC6hm0a2fAvtBp4U=;
 b=AIPbabf4rsULRt06W90zGmhBcGTCF9VDoWDYxiznPrKpQWa3i/ihn9ModDffUmlNINZIw4F3K0V+BiOImgDrs/XtHNtNaVxpt8tHi/oOC/vDj7qJ+Fp8X9k96Fa7/GbyFCuDXC+HG2E7th7ZhsU5vKWVxA+ZQU6OIkfEahQQfgT4IYxP47lkJQ9loti+KShxxf6mqa8WyDMZUohZvwgBX40/q4TF7FWgr6kjYFcQFZo3t7jZo8O4auZf3TSsLopIlPouuNnsW0CvJcKpBLyqP84d1mXdEThmY5vxfinjsO9KMR2JFpOOUbw5GDl/8hAivJXFdbRiHGd/s3UiWwNGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNZPR01MB8378.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 11:32:52 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Sat, 13 May 2023
 11:32:52 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/3] dt-bindings: arm: fsl: Add Emtop SoM & Baseboard
Date:   Sat, 13 May 2023 17:01:25 +0530
Message-Id: <20230513113133.1913736-3-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNZPR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3770fc-720a-4cfb-5c56-08db53a5c9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4A9bKEQdKcHgyJuUKwmY9fw+pdWAS+ZoOqSwXp/V5diXInfIe/5GOlSEiTI+T9AlLrGoSiMcUn3z2ahyJTuLc9bcM96187pX3+ZIkX6RGFWzfsYr6M8gKEF0EhdbTa1qWpXRQdYf4ZVGBnhgwyialTH1ATdTdY1Nl4WqhhkJ0LaYccmbVdOLn+JM5y+MwOrY26LLjfn6ebVRJrSVGbtdJViFBnpMLuO1bCOOPcnP4R5KtVCOSZWqSqjQ1Lm+ml3EpZ2Zlr7H/D/h93PDtMAlAYKyOz1WyZg5Dw6zl+LY9UrZoyAVrhwt7nbIR2l+SOKcVtsDYCDt7plB7KnTeJCywcaRMvyP2u7Ep2b/8z34Ao6vMuRq909AhcwIFA8xHKjk2bLJOqo7mjHz8VFnk/cZHl10tC2LfRDIho+x35kHls6sf9eMgv95FVaGp2CnwPPeg5aft5s40MYg7TMoglqpWmcMiOU3/9kZenxDKWcV+0KT1UTirqZB6rkoLX1WCVc4w5cy8DdZPdbyw5SszK12/NdTKL1syBt7mp1KlRfg87ny4JvYKj0/rgdTEOL+4g28XQFaJ7inUkGpH6dR1UGpD/jZOOLaRbNEywOx3ct2He9VKpA+bqwnuKoQT6cX8mS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(26005)(186003)(36756003)(41300700001)(4326008)(66476007)(6916009)(66946007)(8936002)(66556008)(5660300002)(7416002)(44832011)(8676002)(316002)(86362001)(38350700002)(38100700002)(478600001)(54906003)(6666004)(4744005)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UCj8y5axKDLJKIWLzDOsj9v9keBjPMkqs3Rq7lEnPYCYIgqLVtvSfs+3lxd?=
 =?us-ascii?Q?Uz78K2TZMf9/TvbrfoUu8ToP+UxFziFsEVT58wkxGs4h61g18Aa15B+uwOYT?=
 =?us-ascii?Q?zOshpJw58Dz/ROEnIEWhGeR1WtUDUX/X2uuJ4oKHRn0szwcc3I7qWVoIIiqu?=
 =?us-ascii?Q?J5LXOb7RT3hSR+vBB9727vo7gQ9KWuzheWBQUxRGj/vu9NfZ9H6POrioT5oP?=
 =?us-ascii?Q?q74BwwfaN8Cps+lEjrVBR6K966Hv+Yflw95Yh6FlCA0fhj4ia5X+IklqlFj0?=
 =?us-ascii?Q?AnxXe0QqfLu6F484o1bhGTGd/GRQ9XUgs7/U32faZ4ufq+RC4nFyO/GgFUBZ?=
 =?us-ascii?Q?FqhQHqQui7LsMzUobMa54NZX6g4SW6J0+5pmk3Q5gZljS6G8Wv8kM923Xm9a?=
 =?us-ascii?Q?G0op33eEm2Q9whE91MNvIcGuRyU+xlxHm6laZN/iYn7caHtcOBAVcwPW/Mgb?=
 =?us-ascii?Q?bl+b0Im2GAWFU4rF+D1IDLawvd8e9/zEssmM+0G+nccReVyPQLiFKze4hVTU?=
 =?us-ascii?Q?lbhlsm/CkW3LNbx8/pL4jJ1ujcgxlGy8g1BC6+806rf5Wa/VFVJBiip4OZHA?=
 =?us-ascii?Q?0/UDuXDOnbQiY0tvkIiULrnm6AC2Re4uUae1utuDAL/GbZG6rQbzxl3tspeu?=
 =?us-ascii?Q?sYOWm0BqykaLQDfb+/y7rVVj1hjT0Ey+5X3esHHqjnH7tRIl8w6GerbeEcgP?=
 =?us-ascii?Q?VNuIApreZYzLf6jhH5L9RnpDok4mVRbc9v2biKz52VuS66fODie4GeC54bmy?=
 =?us-ascii?Q?apqPgGwLItJCwLPd76hEm44E1SSuNDD/FcNEquYcDvss97ggkJawRBZBcAW/?=
 =?us-ascii?Q?NUkEWKU8wZAuPrz8zvYxAphuj5txYoLXIqU2WfF0XuXMQ5XlPy7Wqx5w3in5?=
 =?us-ascii?Q?xPGQvS+vIIWwNKOlfWjdbywE9f5q9lUfRa5oREPD8Wf+5j2rxmhkKcW3qAJn?=
 =?us-ascii?Q?iFxqJYv3vkVcTrX5rMNlr8NjXNwamA/iFTcVPJMsFuxV4OWHfAp//51UqNZd?=
 =?us-ascii?Q?+RyUVgYU4hzTvuv/2XHI0UMaDXFAEYF6x8dCkA/T2Ro249nkP6IL3uio40mG?=
 =?us-ascii?Q?q0SpyamXuY66uncZ134J6o2hLXCCB4hKnu4HOsCMUJUmj92dt6uyxoIqSmE1?=
 =?us-ascii?Q?kRKzJRHdxT4r7lgedEBq1TkUjeKIKYR/1nGjFnt2YToF7jRSMunRHRaoGkJO?=
 =?us-ascii?Q?riCe0PfuWAN1Vm609u0F+uNLM5shReRPEsEzdB2e42tQRBNN5lPOav8cVCRI?=
 =?us-ascii?Q?Z5V75uep9ExKVnIrJZCR9KVEI0JP5ZXTUEShBS03gs2Q8vY9VVthM3ruRgZK?=
 =?us-ascii?Q?Q+9HTqTaIHIqYoNsYJxDg2OzEMch9102wudIS5/tFfKHjVbeyJdgBk/9YP8m?=
 =?us-ascii?Q?WFtL3MGQ/zitJxFyos7zyNyQQlqDRLRBQrZ0TQFGPKCrSPam9hVM4Y+6sd6L?=
 =?us-ascii?Q?8XHYDtpz9+bdzh0GLBgw+ky1aoS1YwEksyPqv2vZiVQbE+IPf2Z/V61TKI/V?=
 =?us-ascii?Q?J5edLrWjMeZ7O8nEypIQ0BSpf8MS2X7TUKOcc9eCx5zmS1qZegkuBsJLZuip?=
 =?us-ascii?Q?CO0V8afThV64tFsrOkWEwcdC93Ez4V4DEnrR8idD7uQxeYYlVh3idL9pqZgP?=
 =?us-ascii?Q?sCP4X4TgJZooqItYSovUKfw=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3770fc-720a-4cfb-5c56-08db53a5c9a0
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 11:32:52.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRa1HaiiyPrZ0U6+V7ikPKiZStoiP9iwkmkNBzxJ0gi+DnINHnr4UiZ0YrKDA1bL4P6yg4n1LyHItOrbWJNge3TKYtqAFXh4vSNgGDyFoFEt1FLrfGoKp8ka2s0ekto5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for i.MX8MM based Emtop SOM-IMX8MMLPD4 and
IMX8MM Mini Baseboard

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..742773cb4e14 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -904,6 +904,12 @@ properties:
               - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
           - const: fsl,imx8mm
 
+      - description: Emtop i.MX8MM based Boards
+        items:
+          - const: ees,imx8mm-emtop-baseboard			# i.MX8MM Emtop SoM on i.MX8M Mini Baseboard V1
+          - const: ees,imx8mm-emtop-som			# i.MX8MM Emtop SOM-IMX8MMLPD4 module
+          - const: fsl,imx8mm
+
       - description: Engicam i.Core MX8M Mini SoM based boards
         items:
           - enum:
-- 
2.25.1

