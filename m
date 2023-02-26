Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654FA6A2FA0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBZNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBZNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:01:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCCC144;
        Sun, 26 Feb 2023 05:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6X8W6jUwmnpcLhp+6ACCgaNWJNAguT2vex6M7ONqxgC5zrDAUtNWBw6lO1l/V9PL1aX3pvyyCDlrg09JgZ/eLQAUyWHdyEU094nBvL2uAaPeu/COQ0T1OGldrxMAsKS+juMmr91HS/BHUaPotOYiBmzQNF0ki3GIBIXfmz4DkqKVEviTPb0kAhzuOgl4USk4tPk671EI1RuI+5YNhgXuaO+EfEJDvgtODm9wAxZWHN6Wg4uApYAybbAxHjsIc1g+tyNaHN5k4rQiQ9ZdQ7MhUxkklnithw6nCTceNRi+wg7+8K9JuR/McCw6hRzj9Th/OHee7SfsQoLfTujqwbZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLE+w9Ng/SLjoQOcrJqxJ3DddnGg6YXZcwRSdPW3LIs=;
 b=mP/10j8VSQEP++ic9FeBgGHU6qzPrMw3YkyzN5GloLv14auAnbY8LSq+A8kZiG/GAwEAqcESithY3/LaPNu/rIyWQpMTssgyURr2viq88T7/7rFA+jElwJxZxwF5ETg4C+k8RsDxIvt28lqxOgZcDNiytNYc52Kqv05L7bAuG8uvbMrrpXs0Mx9Ea9mbpiEtpUbVwv7uLTAWJhOMO5+n4vluFbAXu8X44OmJ9zub1MWwHzHciNV0LFR/6O17S8VeDkgGM7Nykn1BQM4CHeJ7frbPGnIK1ISEcgCEdYSL23/1Sw1s5mwQqbsW7yEajEfeS9Iy3rnmx13QIGqvJGgEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLE+w9Ng/SLjoQOcrJqxJ3DddnGg6YXZcwRSdPW3LIs=;
 b=N8yqEWoVhLqk8G5Y4v/h+N5OwmAwmQgh+SHmzV2dxrmXw+crju9Kb3yUxLJaZ5qQaEfsu/amI0HT1uV7NVgt9lhYFxwcuY4kcwrrbeqnX47vn/y8/Q5zoRO9CuBWBTLNVedmnbxx4tzKmy52958CyQW1s8qJwcfNmlPJHN9tCuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 3/7] dt-bindings: usb: usbmisc-imx: add more i.MX compatible
Date:   Sun, 26 Feb 2023 21:05:35 +0800
Message-Id: <20230226130539.277336-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226130539.277336-1-peng.fan@oss.nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0eda63-63d1-4a6c-ff81-08db17f979f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZcF0fzwWWr1Kn5B1g52SH7OGQOwesAeRa+uzL4Y+47l5/j4ZMGjILLTIQ5LhiA8v2gyuG2k+GHDL6uNbhfJnIo/LjgpmlW76A+vqX2Of8ys4tqVn5migihNvxEcytgTkWXieMe46o9JF0T6QiyWt/5xjmncxbFKbSC8V7D+SxQGX+vUCmqZzdSlC3q4C78qX3I4g9Rgg0prCj5O5LmG8ukU5njc845bGKHCQtfaYhVwQofkgqNkdTAz7rF2eEm9fDIOUH9FlCDu+0wLBVemFWScQsDJJjSexCl7CY8dLOg2UCGdUxHRkfmoBE84lSroOck70rvKtqv/R8vVYBAHeZdCRPXP9KbGGhBJKRRfjlzKDVma39tr4nqDrZn9JMNnB9FwsckzF0Z59Z2aaisS/3y4qbczLNPp9N40DxpBukX5S8bQJu65qY4aikwAWVV26mvoIMpPQjQf4qiH1p41VUfzNSmCQzO0IQMdletyKYWq/7pcYif0W8kzfabhDysh5tKmGbAFP8VGnrSr1gTvXOOHZJm0347NIROrW+bzxRwx/l6vdiCg9lAXFkLZI3pHBhICWSA13Uug3/OqiJznlgMhOFZIeuAP+lUrMV4oQ8XfWVMUwMaR56Dd0QEQad/XpkYMj65DGKBAOoSub2cHHghcatAa4GhbcSEWib44GaDHIBvu3cpKgLVU6Hvew/ZhJBwgZVLkUSmdqqcj4+oc2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(52116002)(186003)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUHAhB7juZJ6GFL8rOQRRxWK9cZ0vMTY+Ye8lpk25f+5bR9dzHGcpdZjEtMb?=
 =?us-ascii?Q?l/yxMexLMnJBcOotqgbhLbU7Q8nEb1x4j0N+hMnYIokCBv9Tpn2kpPlf4x89?=
 =?us-ascii?Q?Z9m/1rykCC5W6Bq1GdAOeU3pgkiJ3L4h6xh4+TsJ7fVp6iOzohMtVP9EfnDi?=
 =?us-ascii?Q?R0reDZnkHCWiKtCjHl9saDcLLOyoKcJtpEF1T0XOqbg/5qH43jtbldtQ9naJ?=
 =?us-ascii?Q?wB0QG51BE4SlnlhGi/warx6SPOMlygAbNwVDsC6faLnb4sKDsY5jhAzHbXAi?=
 =?us-ascii?Q?CeE2+i3PODgvDdRQGcq9IHhOpbn/YSdfQqSHDDr6YZT3PJPeUgTaltgQcsCH?=
 =?us-ascii?Q?vrv2rx6XfI9TTjvnMfCQSZywth7kBTvu0mPXkwo1NNYBzTsY0kpIsGfEbnyH?=
 =?us-ascii?Q?Q2u7bJsV2IZzXpFmz/ozYz620TLRG3tmghFg0HDbbZrQnK4knU2gO9VEiwuf?=
 =?us-ascii?Q?x9cbld4Y8tnyc6fUhsykv45on0AZ6LleDxTk/fgjdvWvAByNAu795OIuycEw?=
 =?us-ascii?Q?dQgTtYxzVHnJeOKxMKcU6kr9cGILI9trP8k6GtoICZnPWnrMV71MIOad/v+G?=
 =?us-ascii?Q?jgukBzg783D74X6Ly9q6PTDHmhlxGkOH8ODGGqhxnsfcGItY3YYSdFoVlXVI?=
 =?us-ascii?Q?LwKcUzJLuW2O99m4HQZnJhDjgyFRAHjBOKf2nVdG1D22YKv2elYk+b/Vlu2c?=
 =?us-ascii?Q?A8ES7iK/c4r5mEuGEfD5P5/G0OS2MIRQ/0ztSRKnauqjSrieWQv5FXiMt8iS?=
 =?us-ascii?Q?flQPWota5IyVhN2KFCAV23CpQeIpsy0FNx8NolV/MEv+XGrW2UeoYsx/05jO?=
 =?us-ascii?Q?Ko5lkYBEgo4UHECN7f4U2XQquIaEQkzuFpTyTrmtzje47L+3bJovXqv0cVRi?=
 =?us-ascii?Q?UisiLjCOGZo5zT+2KCp01pCX67BHAUPIxedHMnocmhCAHx979inbJHrvi8xH?=
 =?us-ascii?Q?SzxxpzCEe/0HWnAhu2GIIZ0L7J8jrIRbf4THzq2fL6GMB4W6o2hhWeu/YL5b?=
 =?us-ascii?Q?VR0OU87XqluzjD4JirPMgyeW1G4s3/HeEPjZZPiiAirGSyqZZolcVHuTc9UC?=
 =?us-ascii?Q?0Ecg/jti2kNHoLQqtujLaiZwIriPGSq2u+Mw2zvkU7Rph5t9npZzQ5bLNbbT?=
 =?us-ascii?Q?sWbtR3XX5aextf/dNT2iTbCwfodHYPOOjnKkrFzIUZbmGtpPD9u5A9Bff1hq?=
 =?us-ascii?Q?hGuKXyIU7JJFGBp6RI74I/eWcMMqHB0ItMh54sBqhqWXN+EPwinvHXQbyEqV?=
 =?us-ascii?Q?wQVfbh6PKOefKeGbEJSI4zs8PWDtIrW6HyzjBFgMXB0yklViGrRt+fVci6v5?=
 =?us-ascii?Q?XoVV38JMnHjH6hVIvahKwb3t3vbQzww+mwACCoiHw5F4yPP9lEljZjI0Gu3d?=
 =?us-ascii?Q?VxgehHfA+/qMgNtekrR/IGPEjX9nnI/ijdo7RfV7KLOORJRDU8fvj6zxHyeY?=
 =?us-ascii?Q?/w+vo0yOiNWqZYK+gPaRTtH08Gv+0P+2raLvqwPpzL+Y6k1ogtMlkyKx1kkp?=
 =?us-ascii?Q?wWXxlq7oBuLJW7zvcfOT4svIUNifCXL2QQx90ojrstF0rarZxG20z4tCIrQj?=
 =?us-ascii?Q?JYF7f+LWXbtr8VcfX6EhUDjzCrKE8gAGHT3uqroS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0eda63-63d1-4a6c-ff81-08db17f979f6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:46.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwNeMrSwtt9eVSKC6FHpLWBibfb9NiKbMtq5nOpQhQOtHdqc6E9MG5bJ60SXWwH6WzJfDNdAo44yLZN3kv8ttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more i.MX chips support

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 37b982c1f97d..5398e9533883 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -14,12 +14,18 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx25-usbmisc
+          - fsl,imx27-usbmisc
+          - fsl,imx35-usbmisc
+          - fsl,imx51-usbmisc
+          - fsl,imx53-usbmisc
           - fsl,imx6q-usbmisc
           - fsl,imx7ulp-usbmisc
           - fsl,vf610-usbmisc
       - items:
           - enum:
               - fsl,imx6ul-usbmisc
+              - fsl,imx6sl-usbmisc
               - fsl,imx6sx-usbmisc
               - fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
@@ -27,7 +33,12 @@ properties:
           - enum:
               - fsl,imx7ulp-usbmisc
               - fsl,imx8mm-usbmisc
+              - fsl,imx8mn-usbmisc
           - const: fsl,imx7d-usbmisc
+      - items:
+          - const: fsl,imx6sll-usbmisc
+          - const: fsl,imx6ul-usbmisc
+          - const: fsl,imx6q-usbmisc
 
   clocks:
     maxItems: 1
-- 
2.37.1

