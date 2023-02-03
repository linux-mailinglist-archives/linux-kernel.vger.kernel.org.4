Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98301688CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBCBoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBCBoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:44:12 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94D27499;
        Thu,  2 Feb 2023 17:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TffzOZvivWB4qf6rYt7dgXUJ9BniyyEbapxEmmO5B98B6s9LNmpfw2khYXqSM8upfGSTR7IGF+LpDELPJTGPch74xeXOilfP4hqPkRCTg/eQ6tBCEf/WG677fIgO/dVZQNzbOrT6knm5NnirTUL6zabfJY9G0HZDvCo2pmvVcAURuW8YGcXQND877Wi1nMHMTihQAoqqOHSHCS4KERh48bSbBB5TreNSwWfIL/8VxUMhWFu76qCA+S3o8AT9C3838prcDUf/ebIbJn2n0g6T31gK6Ssx4fZtwGxtXNlW0myWZ2XnwIw48q/tg7lm3UM+hZ1fJfvXfxORR8QRpX/eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ2oTs0/oXv6C3J1ZEokWpdDKN6z1/mrm+AKGyUSYl0=;
 b=JLAkHxCHVeDeKvCXNyVL/udWJJi/jwp+CwwR8unw7b51d0/bkAeaJw+TuziLCkjkzukaB+ThXsoCqoBGkGkFBzQ33Zl1BqHg+qqlxuK+UymVzaVyT09/TKjgMy04RozHd5LHIgqrSV2ZqSwuW4igAvyZlDI8Smcj5OMCVQ1Gyyjui6Kxww1LwchyM9ENAHX/tUGCc1fl3VYQUdBhuNBEr196nnx/hf6+AvjSZeNZjUp5gG7IMYQNIYZgiRSaGummxR7peI0H4BZwU5pWtUKyKJYNQA9rr0gRZUUL71I/lPyo58ITSUd/7UFPopGl7AMGD8k+u7huwhsfr8H7nDiptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZ2oTs0/oXv6C3J1ZEokWpdDKN6z1/mrm+AKGyUSYl0=;
 b=S+yLUOlISEZO3tBomXqJ9buTSKHRLayxHbv6IZg9K5VDsABahXyEEEzgU5aAAq/iUz+DF35f4nGXxOF6vdaE4BjEZaqNUEEvMMU/qYB8i3uBdTmArs8pOW6PmQmLHjoA0Tf3bn/evknfVhwIQngbESxBD3ec73H2LlcCrG40Hq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 01:44:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 01:44:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Date:   Fri,  3 Feb 2023 09:45:26 +0800
Message-Id: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df8d769-0319-4ec9-a03c-08db058823b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vguVhvQyxYD24Vm13cMDluvS33x6LXbyNNddFH99jADf8n6nMMgy8GxoDWmWs3r5WmrfMCncF/Jvgi4LIchStPbGsRyVBiwPpxvdyYcM2CxoccOZk2vsHYFOuwsKN5On6q+Aj+x3aIvywLlgpnYBu5VIdtM/BufwTYtRAp01njrz0V25/jqor2j2jKhPobe+XguxlUcJQSstochI8KzTCi8xf538fOtHExDB751EVdX5lcIpIg4ZnR5itxq9lhiAws9VFas6E4OWj8kSQ3PZtJZ+7MjKL33K2DmSyamfY/SByiOnsWeCYK6z9vsp5n6sTIxzEF7vC2ybyCEirw0Z5aKMzzm6UxKQi+KYKt2uuL4/xlT1JGLvYhPQYk7itwvTozbBAez/+nj6KEoSrPItmPbwzSfCtF7tHY7cUuKELtqiv6Q/AbdHfwKUBvOat/s3TSdHj/8UytPZFvBsPi2GQtmWUhxwMWYtszDaDTuClfpzXoZlwW173IeSMjq4ipNXHIN97C4Hsdbt6A8Qsi9QTNhkzPFMtlqtes+j5M2HoIR6Xsw+7GKYMU5lZSx2cCrBgY6DTVM9C8kuRGlBPerf71ucz3efbfSB8MpqVNg0Fic50CHlJDXVr0npi/rdNHhmiim7j382UBhqBIvFXqOF/IYAIbyspgaOCNMf7gFyPDX5otejJdmDY0Az+UJoUKuXUZiIm/jtsWo12r/N1wz0Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(2906002)(86362001)(478600001)(4744005)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(52116002)(8936002)(6486002)(1076003)(5660300002)(41300700001)(66556008)(38100700002)(66946007)(83380400001)(38350700002)(4326008)(316002)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmnOhMpVICTpafgkgTa+sION7LC/CB4oQgkvEQE7xl8VtDSUmG9G+EzB4OxY?=
 =?us-ascii?Q?kBHRFek+5KaThWp9XB/d5A0AVcnHMvN8CsEO8gKMEoyu+PoDuXTqrZKlvmLK?=
 =?us-ascii?Q?744Ig+6ZzyjYLwLcJKMbP5Gk3rZN1fNHxIxQwsIfnP1G12R20dXVKh4seL1X?=
 =?us-ascii?Q?1JHM7So53f2q/1MkkkWV+kK1eM6ShsIG6qwLr+gRtEM0v0cNgtuqG0U3Ns7Y?=
 =?us-ascii?Q?NHqzdMKbpWXLDuiZRS9RQqNDMlhNzWosRHr1EYUFfBOODiliuvdwt20IQ0KG?=
 =?us-ascii?Q?1urvm81H+9tRgDdSpFWvI7svXdDW750XipeAyf+33Nwu2q/G7AgnwOhtYbZS?=
 =?us-ascii?Q?k3JADcGnApSetBsF73pOSYgsapSdX4tKCE12RWINbYeH1cL2OAiaScIvYm6S?=
 =?us-ascii?Q?rCV9UZBy6aTxxoqC+xok3X/RBPOq78RbX9gKE0NlmWIZmK4TNEZp6f0h3Nvf?=
 =?us-ascii?Q?1839ARhTk40PYTn3Xt7u3Vquqjm+aUnXOi9SJ3JiZCfXqBu2W86vnJMBCIYz?=
 =?us-ascii?Q?fqSDoIsp/b8mApJSuINv9+HwO77OPuwgRrO49GDF5kgYlVqzqakMgSfqBZeh?=
 =?us-ascii?Q?By14jteV2iGP1uj7Rzo/qh9Nl9c3VX+x4OFenC/jjKkUTXhVavVTLTuaHj2R?=
 =?us-ascii?Q?HsN/6FM65rAIOLT7n8ll7MBnT3Z3ArpYOebtP/01opCdjzdb3e2u8PynBwtO?=
 =?us-ascii?Q?p0KgoDbxTacWVfyHZgERi7aZWHH23DcnfnpLkni+44fT3H0I/5PU7nh7bkCq?=
 =?us-ascii?Q?jj1lDNi0EsFjuGeKZF3HePn3ediKEbz2QAjwa7maPPCJ9KkheIMB21dPedUx?=
 =?us-ascii?Q?APYS/KOynDXVePiqxA4ow12fsUAagX5LD6qZLGPH5IMQwJCABiNiM5ijj9FK?=
 =?us-ascii?Q?BoQSTnEekq26hUGcwiouOUPZunCBOdy7r/CE3m6QNyUTJGQ1qPngYwMjbed+?=
 =?us-ascii?Q?/6DEYkb5Rx2hCGvymCGl8wmVRZFxBrnhv7eA1i2faXs5QvPlyB3hCVH6bhOO?=
 =?us-ascii?Q?hn3ciPOr6ajdKmcB40ZWPXVaQ3NpyoGD37FpDRlQm96UKEwIYgG8RKy5Zr0w?=
 =?us-ascii?Q?aFH1kNoVFWQAQNabWTpWk0a6MonUWRbIjYM7qSMjxm5RLL+WSLhQqjxCOJf6?=
 =?us-ascii?Q?IGYpSZWX8gMjXBp/OX1TiEM5Ry4p4sf287rbzy9l0Z6Ew1RFmbwU2rvThM1z?=
 =?us-ascii?Q?nMzFHXowQcxuuBZN2mzorwA9xyBHT0hgj4ZrSDCdDAGgxDYy7Vz7KDMxORBp?=
 =?us-ascii?Q?MiecTPxBWyaTaiixji5YD6umP99s9Aoet2lr632R3y2Wuw3h+VD2YzXleTsa?=
 =?us-ascii?Q?UayDo37sFF34CxCy26wx6fpMuTtUsNWSyDuMvF/aiNz72M2g/VsQl2BIdu7R?=
 =?us-ascii?Q?xMLwcVFlOavzSYGOQwatmZhw/mXdURlWAwl8eamj6IBLozAUnfAjNseH/BZJ?=
 =?us-ascii?Q?bsJ4+vY+w1C32ShnlZ/sLadDNJ0tae5r/bDNZ+1y5W6szQbprx/KVTJq43a5?=
 =?us-ascii?Q?B6YA3iE4Z2hDT6GzEgj+iOGf3F5fx5OkQ3wBXPaDE4EUY/deQjlqAJS0ufnT?=
 =?us-ascii?Q?XtcDYmTwohpxH9h0uNzk3pTH41YawnilrxopviDb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df8d769-0319-4ec9-a03c-08db058823b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 01:44:08.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhv88BOA+WmYfNhrA6GKOEh+DzRvxyv0plUyqVLVsM++4P7/NlQCx6vX8abMp3RQN8nKmEyhS40Ex+99zv9t3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
compatible.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Rebased on linux-next, remove power-domains from v1

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..fefd6610ab45 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -30,11 +30,13 @@ allOf:
 
 properties:
   compatible:
-    contains:
-      oneOf:
-        - const: snps,dwc3
-        - const: synopsys,dwc3
-          deprecated: true
+    oneOf:
+      - items:
+          - const: fsl,imx8mq-dwc3
+          - const: snps,dwc3
+      - const: snps,dwc3
+      - const: synopsys,dwc3
+        deprecated: true
 
   reg:
     maxItems: 1
-- 
2.37.1

