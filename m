Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AF5B89A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiINOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiINN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:59:50 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A252637;
        Wed, 14 Sep 2022 06:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ict+dXwKJ00M7wYvVmKpdGR40jyetE/ubjDA73GjwAfdDkSXLJIvI2xX2zeU+emS1otcX/6sZlbwpIhYxhziZuzQGCGDM7JjL7XMEnFZUYPCG1SG8QTQjBEloU+r/NkQCz/OQEO0pzb1Ju03+7xL5rzUy/dYtpJPfogLuz2AGdiq5APisGaBLIQPUYG650UmFZffGz6Tkj3KgxaJxuhMJ44te2EhRJDOIYw06JaYTDH9CxmKoAwALpgYPTXJyfeMiaMyqdcMdwp/x4+B6agV9qy/GKe+Y/CFhfnMH43BdA4Y0K53iqVVC8III/3xNfz7NZyH3c1+hbM+/hOo6tamKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=Rqka9KUn1JkdLlXDtqQPPvPMQI67KHWAyymvjZspKuxRtUj0nUn8Mqt04fE/6nhxFeXft5UKfpqTEhImvwfFrauhTwLMr3sFdp51E/teD40xnao2kH+kSw6m4bgQsxnG3epm2PhW7hnuSC//2A8pWO5mcUu9k5hJfA+oxfVO0VX8h+ir37XwL5wKuR0QqeI2c18A1Ze1BzzvcqqhbQ1YOgAuWzbSWcHpkSxtvZ22rCptH3EVb0dXObY6JihzvLnnKX+BK++XdcrNQUWUCB59d1JUHJJVyrbcoAofmHeW7E3/Ulw99qoCE6z+fK1QKN6HzURkEh2UZY1yhEyMspV/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=Xvar4DVzXXezftL/sNI9MyvS8DXqhtWJCkfjnqpN0vacj8MUxKNZ/JjetmK5EcRI+zZ0jaHMt8pMeQlxtJp6mB+ftbfeoi5tafRMqPReN3/FuLDzzHXrGkQs9gvLPbtfWmVLYpRkEBMoWsfTQPni0LsiS0K0/wgT9o0Ps/xEU8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:59:41 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:59:41 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 2/5] dt-bindings: arm: imx: update fsl.yaml for imx8dxl
Date:   Wed, 14 Sep 2022 08:58:45 -0500
Message-Id: <20220914135848.118616-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914135848.118616-1-shenwei.wang@nxp.com>
References: <20220914135848.118616-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To AS8PR04MB9176.eurprd04.prod.outlook.com
 (2603:10a6:20b:44b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9176:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4bd945-a4cb-40cc-ffa8-08da96595e97
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cs2u9f9QKeyZrGz5QqPzRPh1qbJRMIC8ua8PMROwOVi315mwdqEsdTc4uWqa29S/MlKAlYeEXNMJj6hy6CjwvITUyZiT4BnqU73uyNTPx5yacws9G0mcFarMfXHmtx+6IPyhUcg6f1Wt92XwZHPj4ATezOHhR3NTpSywtDhr+K2aNQe0s34a0rzB76xvD1jzRiD518dXhPFGhHFU29fd72nUlEPlH9LBs2TK9xajErlK8nIQcg3dE0ZLbBxYfiYSjR4MxwtZF0+4II4lsrZe2jA40NSJRK3nM5MoOTMy6SXNIPegMq6gaOv8/FxbTMkd9VGnsKL3vsJ9MoUlVAWf43RV0WJk/Ra2xWb6u7biOgNwz0eZp+m/vv3u4SouxFBkD67k5rO826QbZ1OpSZenwuPnRFl9fIoh27UDJJbPFBNsgySTpBobe9IZfme9jLFiCAn4PTC4nTmI6Twex+A8lvWzUfdp026tsDZWMCxsFAtx9T8JjINeePjHGO6N8k5SmZQRJ6/H0+Av8UihFIgFKCKGdA7LrSFvua1oUjvg0OVQKXtQJAa1VTC36szM2hBSQvPht3YtWQpvOt5sJXDdrgiBRlrDKr10Znn4EbZe2fYjGpAkPR9KmO1s4c4WJkDq0lHs4BI5kzG4chqv/o6qvGTo6SrhI9Zz/SY2c0osfR9vpdyjf/lsqvY8GqylD+rm0GwEi/7DnmwEfZYRlVx5L9+Kx9iYYvF/L97wBcqJuJbjyxkdrx2Zla7TA9DeuXpW94jtFpeVKustFl5NvxU4xamhSPhhUzxjWJTI01DR8+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(38350700002)(4326008)(5660300002)(7416002)(66946007)(55236004)(1076003)(66556008)(38100700002)(8936002)(8676002)(6486002)(186003)(4744005)(44832011)(41300700001)(66476007)(86362001)(26005)(316002)(110136005)(2906002)(478600001)(54906003)(2616005)(36756003)(52116002)(6506007)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UL9767mZ0UWxC7cNPgvvhH+ekfsYA1nG65UCyWXz2oNJVPJX935ltG8uiZ69?=
 =?us-ascii?Q?Au3kGwaA3djWcTLN8gZE9TMMaLeQhKfKC0I+NfrPFdYG4x4IcLKgXdzMT4yI?=
 =?us-ascii?Q?zh7r40XomOWV68KLdD0w2r/Re6evV3nt5ywwRLz3xLhNIWG5piluoBYXQgTz?=
 =?us-ascii?Q?xp2q6/52i9UAAQoavtBvibTw9v29RWt+kw1AHzfdQl/qszlZGKVolFw7u0Mh?=
 =?us-ascii?Q?Od6+Ok6atSLvW1mmIWkk2NPj2/ja/0s9xKAXGGpy+qKfobjKEg1T6s4tnXGI?=
 =?us-ascii?Q?COWNYeKWMZ/6NXIAUmbxiiOXK1In3T+J/kC7sFkZdAH8QNpRQ6FxlTRSmul6?=
 =?us-ascii?Q?CmVil+GRe1XkqImRkTKGno7P5Trxl0iUnEieOPi8jwE4TFYt3/aAp+tpg/qm?=
 =?us-ascii?Q?0gz1G9jcIdVJW81B4Kp55WT3uQNnzd3g0EmSwGUHYMEetkrcNtcE2KvZeGtZ?=
 =?us-ascii?Q?zR2eRHiPSx4TY3ZVdJZEZ6cNFbSoEZm5ZfGXusOGkUo0QC9WWwfKCDO2Ql1e?=
 =?us-ascii?Q?pb6FdDVpbhWEKjOpJCYYwEC1W4pz0Szl/nK3EuQ5ze8miC9e20AG8O7qC7MO?=
 =?us-ascii?Q?n17xiG/mFNicAzBeG3WUrbdwOelKhUSyeQvNdC/Iw3IunR1jqUNUs2TCuM61?=
 =?us-ascii?Q?eDwiBRJi0N3ilNJ8rBasNmLTo0nTIp8PcnERy/fY1jFArFAz9NgPpBXHdCdu?=
 =?us-ascii?Q?srbSndI76Mib2HL02tO1HGPdoJdHRGJCe5sqc3neuD2buEW83+WBD3FcS4e/?=
 =?us-ascii?Q?lsT17Y4wSuZ6asopfFCV34XmCjTaXTvBI8lY50HFtGYtLIe2MKnb1RcufUEi?=
 =?us-ascii?Q?pHRSIkXaCbZIUE2AYrchj4L7ua+QatMTrPcYpEZl5XESHfW6JAzHQIf+jMQj?=
 =?us-ascii?Q?W6D9Fp71puNOqLTt2rDNVqHHfTPhABYrBeoIfaE1/becrYwIVGgci7VBZm5C?=
 =?us-ascii?Q?p2FtZRfV4vXPBwWPwuIs/V8XhWBPEAcmsfr8QK8LPkCZfyao+gdVKKavBULh?=
 =?us-ascii?Q?kY3f1qrDCKCK6UbRFvXifBcSQtCxBZ9uvW24AcAP9S5w0Yb+MiaTjj5oR2T+?=
 =?us-ascii?Q?rnbAS4qGWs/Or45nvrAq+MMT9h1k8T0r47iOpZaEfLdWvaazIk70S+paImgz?=
 =?us-ascii?Q?d2Lk0F+2sGVjsW+l8DlJj8J+rt53MyDn0geBow5sBnDUHZcLwY8+MfWrhyJR?=
 =?us-ascii?Q?Bga+JZr5/TgPKbqFl3r4adl03K6csy5bqmSYEpk5ic2mfBR8SuViA/85aLuI?=
 =?us-ascii?Q?+Dg0+fbZz9jQNQrahSpRVa3M0LZ8DlOWtH3Mtdw8f3dZBcIXA9QvBBfpJry2?=
 =?us-ascii?Q?dp8o5Lz+3JE6pOMXn7tEX8+CfiOqN6jXpjfvwOJJjzYu4HzD8ShhrMT+gRg7?=
 =?us-ascii?Q?I0Xi/ShfrtWLaF1piWgqf0VRByYh/y5+MDO5xFW2JCs35Z4xHIE+mu3ZJCWw?=
 =?us-ascii?Q?SftV7p3zxESdoFjDwl6VHDxtg7/AQz7WIGIxNARjDKo1NNc8l7Ao1N54uaBH?=
 =?us-ascii?Q?cgefjMU1gIYhGhyWwcIhFpq0olZ1L16ejffTCZPf/Puqh6P0wTuEijkB6slg?=
 =?us-ascii?Q?HKKPCzK0II91MSSMdgfwyB9SEiEnBrcxQErXoxl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4bd945-a4cb-40cc-ffa8-08da96595e97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:59:41.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEQlF0njU+XJRO2H7BThQsfYj4pX4bvyYyScpeQvVCYgNP86P2c7UrRg2+jmfjNLp3YprTPZO1Radv7/3szbAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8DXL is a device targeting the automotive and industrial market
segments. The chip is designed to achieve both high performance and
low power consumption. It has a dual (2x) Cortex-A35 processor.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..4f4c9c0a1315 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1034,6 +1034,12 @@ properties:
               - toradex,colibri-imx8x     # Colibri iMX8X Modules
           - const: fsl,imx8qxp
 
+      - description: i.MX8DXL based Boards
+        items:
+          - enum:
+              - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
+          - const: fsl,imx8dxl
+
       - description: i.MX8QXP Boards with Toradex Coilbri iMX8X Modules
         items:
           - enum:
-- 
2.25.1

