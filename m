Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D646A651B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCAByc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCABy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:54:29 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E532E0C9;
        Tue, 28 Feb 2023 17:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYf57IDxg0/42ltybBOUouihOfVupGs5VsnzbD0k640Ie0wi7yY7Ct86RTbsDwuO8JgN4zpahaqG7IaOIjM2mHNWUmvL0FVNb9eIj7JAk6GYoxQufrhsaKQihzQSZSLiLKwc13RwAF1XNumRamhSqykN214t4jwcDdlMVc5VyV/kTxRyNeDDlfJ28ckgGyCYvVlJB0JfoMpVs8q80jVS72iIiEdoJlcCozyfPIsMjOD2Zy2JwI6nPB48Q4wKl0hPDkI7JHwziUclf0PhWdGw7rQb+O017bFuUD0rTcJYUCUMynSvKXpeEzdbJxnYfzNwZyMqJ6curgRzDzMFGvSdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfc5nRTg8j2fkhT059PVqQX14N4GqMTLIHxTeZC2Hhs=;
 b=G9E0u+ONavshkkfMnzh+JQvMFrj+8u5KrWYAXqorF469wjI4msZXUy1A4i1E051HBv8++DEaGxZUV8yCeeVcvTKPolaSMRC6Tajqvq+1IJPImKXUbFoLOkdXJny5qCaMQS8XYw7OV3LuxSp2FH3z152t+/kylAin/7B0+eHVQzcfdm/ASpfhI6y/E37R/dGOTshiV5A2d2cWYZCJd9St1PubKMI0ABBEIJxWIqoUZs05/oMDCtIAAZl3VLCz21YYMq5IH6YxgUjvQmFPHvPooij5BADL3RVfB5PWDjy1PBjchT85vI2x+/OWTfRRtKtflidFINmpSXu7grgvKFzxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfc5nRTg8j2fkhT059PVqQX14N4GqMTLIHxTeZC2Hhs=;
 b=Q4S2VQaJvrVC3hy4I1dJ0sXz2/ziOWbUMgHrNaTprNZ6RObYo80A3gWDykU65rRheOGRD04dDdTalW6HUz9jpOPqoIT/kqZ2lWb/RA+5hAOmroU93evnly/MDszQ5B9VUjkq/yeXlOl9yCNAXADUWSOTr1rwV0g9P695VSBoILA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/9] dt-bindings: crypto: fsl-sec4-snvs: add snvs-lpgpr support
Date:   Wed,  1 Mar 2023 09:57:01 +0800
Message-Id: <20230301015702.3388458-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 090c9973-1710-4421-a0e3-08db19f7a185
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7wELC/kaAjDbbmfg82ad7Iu4y2P35XAkj+2twsd9KN38LHKkJldD85OFoA+lkU9K6a9vpmyvEc05VPM+EoyBUD5CERChs5B+192z2GG7SfJaLCpi8pfk7dYMGey5WU1aKn50uJ8W5nENg5UsgAY5icpLVy/y8PeF9zu6AOhe5kMa/+9vsr1ejV1wy1HLWCsKwQJvlOby3XUmW2IEUAp0AQpn8CYwqB/V6vTllPtlPTCdb4frlCNAq4n8g4SOdiqeObP/bbDOWvzLtopELYo6hjE8KJmI8iTUk4zmvPBIGpqP49QhTe4PgcTHvKXikfI7AAjKYcvbku34yvX/j57TDI3UhETftxRs9NdLXw3LfqyaNpaf4E+RhgpN+9BPejizWrV+VSBw6Bj8jPLwgsSHxOO3C3vdW9Sc/TnysqZCEgWspnursq5hYEAT4oO6bP/2Msc2/p6u59eNgLBFGZXecatTohbZw0EqsiO3xJsAVAckwohC/GrpWtP4FfCXZt/GgN2wIXJyIzPyR8nge1Pmi3hoXEvVPrYn9kSU56JuULKCzI6ZJO3N9Q9GB2fzQOZ30ATz5HPeANHeRxYbykJNqkr7dNg4KW9gPsIjOmkC0M8lk+G3pBIE1s88skdXPGt+0pzC+yF2OcXFA9eGi5X21/JOO6yOuU7vqRXxP25B8gMlGseObJNOl+8H4YWZvNoxdIdgziJAFcfAuGiQwvmKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(4744005)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhD+igRAPDpJubuXyw5X/9RyF/+iDekwUsF7KG82tgqqocanXcl6/auN6VAZ?=
 =?us-ascii?Q?y184LUCaBtw/04ABkb5XfwfsCzBjRCd7IaOlKPuLPfyS5ri08xikY/d/k7gV?=
 =?us-ascii?Q?6Jea+hwAGmPqUpoVSNGb9rBlWqyANFW2LgD9/ywI5jgAhPYMbAedNXryrTFt?=
 =?us-ascii?Q?OqFJv1yOf/4o13eSzZIIEfMIGnSZkRtiE3rdavJXTZn4jQ2av7azMCzHajwJ?=
 =?us-ascii?Q?3UuzlYWmNJ3FuYy1AElLUBSchiNyWjTe7PyWm6yYWEBDseVZIb7iUM7WQsoY?=
 =?us-ascii?Q?RC9G94bLQVrBCx7Rx5q6y7tb5m7dhCXyUUPKeh8900L81Mmb5dNHVpOXD0ee?=
 =?us-ascii?Q?6w2oAKy44hwQ5B1x1d5Z8d/dgwm2PCWOKB49Dk+OoHdhNNTNOBPfjypSc1it?=
 =?us-ascii?Q?KDMzWI/UIoh6aujkIdFlSOMFGAZfQmZ5lOlMIYntLN1CKfjirK5xy+GPdcPf?=
 =?us-ascii?Q?t9Lt//QtVAebdFCVCmKnsGx5QG+MDVy1ZF01PEJRokvPHzl0QoRU+LyeFcKM?=
 =?us-ascii?Q?DpBfPXanp0G5tQRM3yaXPoTu9U+ri+VVuBkre3KjYSHmfDz60cu5tUu0i6sU?=
 =?us-ascii?Q?wy2U65XZOT+IWM7LKH+jyxtcs66PBv5dimrl5K4F5Hp1ewUuynt5SRex9j1H?=
 =?us-ascii?Q?Ka5gPfFU8P/uOlwcZZx0oWKF+f78pO2ST7Kp+i6utD53R4k6VfWztNXa6ocy?=
 =?us-ascii?Q?EUOuTImEFlsNTpqfbZ2sPREDXRQFruOqT+h8W+6yElvLdKl0keWy3NG3s9sF?=
 =?us-ascii?Q?E8Wl7odfyEwm47MFzmnMDZ0Q0qTle7h52SbtU9EGGpP3w0PwLF2mzGljix0v?=
 =?us-ascii?Q?yez0zIy5TZje2NEJS7huMnwBNoDdAVIT9Jva2ohjhXxEICC4DoqDXYoS0b+7?=
 =?us-ascii?Q?dLINOC6MU0ql7c9WGSZs4oNxJSNdqdqC+PNrrvx95pTXUa0/FtT/9skTlYHb?=
 =?us-ascii?Q?jc4dqFJ0ZwGE2cOQEbeH9ZZKGlAu9N8CizZY3kOQyOs8wT/1jvIV/n3NP44S?=
 =?us-ascii?Q?6GyDw/Ohsuo3QxAKEzx0D63oDvNTf8NgdgMZzQr2Mm9sX9NrNbVjGp8F/nvk?=
 =?us-ascii?Q?VsL1DbV5WW26TimqmrwhzsfD51p0q/LKCUTsOwWR2gnBWAyZpggV+IBk3fdr?=
 =?us-ascii?Q?WMUFKDRuafKMyndTgek6ZdncXcPtvd+VOOM2ybQ4v7r7QtdQ3I7xxFSBDPY/?=
 =?us-ascii?Q?EArd+300BttrJ4qWbHhbuiLqN0IqYmpenLHQAB3qCwzNeHJwIO2YC8XWmAqO?=
 =?us-ascii?Q?EhOkyebqd2qmuJAAQ5CxlkFCc24FLu0RLt9M+AkdXiWJYPy6lgOqTzPmicBy?=
 =?us-ascii?Q?+DuAXa1EkfqmFSrSZIoBf48PaDI13ajbXh9Qq657kCB8BTwrs3sx/euCoBLo?=
 =?us-ascii?Q?eFb62lNER6ldGLx8PocooRuipE4ZDgKkiWVxK0eKxnm9DQYNLUdSXJ4yYbUo?=
 =?us-ascii?Q?63q5o7fwXLSGaIwVjFIVlIuL1eqrzU6kkcTqEh7JbGf7Ov0HMWeP39SSq8LH?=
 =?us-ascii?Q?A5+TDuLuXkuAaJygRGaHAbaZnmm7WVyl8uwqo2Hby3BFByF4IQfFNlRt8/YQ?=
 =?us-ascii?Q?fUD+YgJrnSn+HHuDMPGmrImJ94ZHZElLWXs3+Rlg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090c9973-1710-4421-a0e3-08db19f7a185
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:36.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddAz7t72iRcsXDMTmigQ17CCmm0Q3CT4xGbz9hUzAxC864iKZaH8lgzNdNXRNVn40Q/r6HE/qmGVjySUg+BT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add snvs-lpgpr support for fsl-sec4-snvs

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/crypto/fsl-sec4-snvs.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
index 1a4b4975e1d9..688057ec5c97 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
@@ -124,6 +124,25 @@ properties:
       - compatible
       - interrupts
 
+  snvs-lpgpr:
+    type: object
+
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - fsl,imx7d-snvs-lpgpr
+              - fsl,imx6q-snvs-lpgpr
+              - fsl,imx6ul-snvs-lpgpr
+          - items:
+              - enum:
+                  - fsl,imx8mm-snvs-lpgpr
+                  - fsl,imx8mp-snvs-lpgpr
+              - const: fsl,imx7d-snvs-lpgpr
+
+    required:
+      - compatible
+
 required:
   - compatible
   - reg
-- 
2.37.1

