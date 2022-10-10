Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E75F9C70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiJJKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJJKKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:10:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36481E096;
        Mon, 10 Oct 2022 03:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAUDsdVdp4FJDt73phba+JrM9CNDLiRKjio4pgOrnQ8ARDuFX8BbSoO1bkhd4MPJ8rAR8UJ7bg9UaUHeAduEIaqV7LA+bhVMUUBju+Sw8xcX9p7BX455UMRiwuK/BBy6crpOF0072trzvaR2Qyu8JYCM4iOeVdh2JSemxan53i3sdcIWCxqucdwEBfwck1thXA160OrHw6NmqsA+QlK72145PY3msOzcFOSj4ZXtc9YspEHjaKHW+BQDoV0via8TVZ7i6TfSYDTYLkohnhoRIFg0kG4bdUnDLPeqwxbazeR9Rq7LilQo4mZXVzXY6B5S3k+V4xwECWcEDY2LoqGZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWbtOuLaYJYyGaNQ30CODplj62znUcabKtK03ntUfI0=;
 b=GsyzhrORAUcRKJozIvQ8XzsSaQuSsaIhmkBw/I4f4qVm6XMtiLmpVptDsQ6A+ebueV2QRHG3r2u5lHPVlEvN0hawWTl1f6ALib4fjiTHJDCC0BcDnwQ0GNyfeR/KdnKF6CJNC21gpY7IaLONZMSxTxS3f40BwOOn6u/+MBXbIr1xIJWzDF6C0nswZr3LRtNE+Ni3JooTYA/+PICw2yaFm07/TkcSJC1rOty+YhhDFwCFnvg0SoNc0DDkxju9jaW+RWFDhDiZdedXLo2lOMf2nVNo37fhlsx4v0GLnvjfT8q9KJlxiidajvzIM5IqhJg4vrXIw8InQ1LGE9skOScmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWbtOuLaYJYyGaNQ30CODplj62znUcabKtK03ntUfI0=;
 b=Y/JAJL/+m491bVqYTYsH/DSNUitOeovabJN+MWJek1rmlRrzIYuze3Uf242aVrd/7hkz3spGqgfqCx60IXnPV4S8Uk4BkWUMOG2QrfGgtKvlC8vGrX29S+NXXd3g5h68NSAeRDP4TxIuvUvYqSaLpdajWYshoMPAac6VzfH13hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:10:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:10:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-binding: mmc: fsl-imx-esdhc: update i.MX8DXL compatible
Date:   Mon, 10 Oct 2022 18:11:38 +0800
Message-Id: <20221010101138.295332-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a113ad5-8a1e-4786-6e92-08daaaa79b78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQRDJa4Q4/PcUnXiJxdZnmf8zcV/7uOs2/zzgsu9ZI5F+XQyO4ObdrtALnO7OCI8s3pILk4+gIZ/a87KSunayxTRItp0RqzytkFl/L4esHfcwheGl/pPpeBKHIHVUYV45ttj9CzxRzkkEwbGZjKyxpnC3J8duyeXsudmsaXNikb9kg2Smem2xxJxoShCf7yiPckTBbRC/bp9v8TAWeu3iSW5Z+Vx+dvakcJVvGXFuPd1gBeIsTP5joGRGDLAx68T0HWOnq4rNLm+RmJ8+b+PfDY0K29elvDBaRtYXHpSdWtBq2eE+uFJbmwviPBk1sjsSB7KS/qVw0IpZtKHDPdi1M/180PC6OvPf6R79wiWlWZ9+vBQLc1sv2YGR/G8z3viaLPAw6pcDga1yRhGyFs+rbMnYOJFqng0hWZYe/alZLScegCTImxWRRg5tYCAQa1e7sY1EdLaW3FakFTqznzCa7+fypiA2UrDQgfYF84s/K2qwTc5oTfdkog/CyQi2EoCKf9YcddSAK54d/myIhl6h93ftsW5p0aZwkeNQO6SWM5ar6umCxAne89aH9C0HhDLT/210MVeuYG26ZVYZ2P9X5lR6KKCVkGIvdv3vJrUDAnmGi8eX2B6o5jfAgO+EcfBcbJYs2eB1jQAxaIjbYC9ShgrKTBpp74heAIEwG6R2iwB9RrLprpB2uFLWuUsvg2lgswsUT1Uwf+Uc2QeJJoS26Mg4AfDTvCYetWwQ0pz52+5pVxdtCiJF0szwfNeCbOCpNkuOElV0pQqSpsLD/dhTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(478600001)(52116002)(26005)(2906002)(6512007)(15650500001)(6666004)(4744005)(6486002)(83380400001)(316002)(86362001)(2616005)(7416002)(186003)(5660300002)(1076003)(66476007)(66556008)(38100700002)(8676002)(66946007)(6506007)(4326008)(8936002)(41300700001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGqqz5BYnGVClvgH687kjlzCJpKutFH23S7WFz1U1nkZHe2KiCT2ux5evBRB?=
 =?us-ascii?Q?FNGlXsAcTp3ZpD9lsY93CWp+acUNW8sIwBegrClOuMaBDV40xBuI6qY+0fiA?=
 =?us-ascii?Q?Y16A7dUBtHOJx9HotpFhtprlU6bCmGivGUTUlMcSdwEj0s9svKEk5a2DVqX5?=
 =?us-ascii?Q?sbj+ViFnwrd7Ffr6yqgmF3oZMxDbS0wFI65yqvPigvbGOtjN4jhH9K+kWf7c?=
 =?us-ascii?Q?9uvYb0oFD3f64Q8BXLzDPlSx7z3/pI40VmdpKuX9bGeGwEAyTpjvHTcUQHqq?=
 =?us-ascii?Q?wfMyWQQpkeW8LYpDtgkNr109iUzHMDI480t4n2mEWAcUe298tdjU5X0JhttK?=
 =?us-ascii?Q?xh/K3lD+MkiCm0TSvz0Qvjl+gSpQnaMTyNFcvCMFwDarGo24sHONh9YXNNCs?=
 =?us-ascii?Q?8nqcUjmTuksKpiYsYDgm8JfCHuXDWAbyD6BCXR8/SfKt1kTLBXtx68qoHBNQ?=
 =?us-ascii?Q?EcA/mGvGhS+D8vB43K32duyQ4nXAPi3wbzlWjTvzPGnTnsHWwTtP817YB6mC?=
 =?us-ascii?Q?FHdaj9yeYWG1kU+r3ghHYigk4S24NkA4XAkR2ccyLKvvyUB6Gq20JOwlyZf9?=
 =?us-ascii?Q?PjGbDYqxrdgIypoQFb4ZndSjpGiJg9OwuwbhYTgddY6tVbWlSOrYGrOiSBdh?=
 =?us-ascii?Q?PtkOXMw1PwO4W2OUjU2IU0PghiGY1yc1lN/sT7mGG9/k5JesK5z0Vbc2/zuJ?=
 =?us-ascii?Q?as64hztpH2/8sS0WPJYVQ3p3KXgxq9IaaMDhj/Jocr27yB7Buz9NVZbDz/iy?=
 =?us-ascii?Q?HkQuQQKrvTg6hI7s+X7aXevUDYDdF+pn/uEiRv4w6wQsYLlWyTbaLFS4juhq?=
 =?us-ascii?Q?Rd+InlcqQgHCnZu/kib+Rs7xdipwloau5sCRS7Eij5vbfaLYfFC6VzD6PTNE?=
 =?us-ascii?Q?XF9PCWLkNN0mdjhIejagOQLSvfBEFIYW0OuZ4Kn8ICU32HM0MROnBUKCyTJd?=
 =?us-ascii?Q?kcQhUUTp12KbUnwu869b6jfdK1g+TT5wZGFLTWLNRiuWMbj5WiEhDyXVCA7I?=
 =?us-ascii?Q?Rd5SSIWOOhVK475BDrEM9YmXeIZ3LUOVAFxpvQ14ua8KVl5FS1Aa2j7BeeGB?=
 =?us-ascii?Q?PeyVvCTP8VUuDU2eEm2GJcYLnDts4ucN0zD4YT2+LtGizt17+2HzkV+mlbz5?=
 =?us-ascii?Q?1XHRDlM06oqeSdEbiZdxfIeWdg0+B0ofJtsftH5a78H92H1NY5NFnN9Dd5cI?=
 =?us-ascii?Q?rfqCPNLMyBv5pWiHTYvIGqUFIqomfZN3THELg92UV9S3kf+a+Mbrzw7kyJun?=
 =?us-ascii?Q?Gfpn0FganpvOksUnB6Ta2QPEGMqWol9ChHj39cGBSRWDgoaNJPtncXnKOAH6?=
 =?us-ascii?Q?At5IYO2PMtFcj3orJEwemNJjvyPTveOX15uJgCsP2VmcqCJhI9Ybvu2AOB9G?=
 =?us-ascii?Q?E/pcs29kgCiYxEGFnHhXcnzVoGGdHIhtU8EaZHh32fIssYhF0WCW88k4j8G8?=
 =?us-ascii?Q?G8Gda6RkLLMTlE8xl2iOC/zomRjGNA0NV/qfYJFq92MdnsamJj6j1VyD0f6n?=
 =?us-ascii?Q?lCaLoDtSXB3S/XieyzGToyNNTWnSUWismvTn36YlloGg/nwWfeT2IiVpiye8?=
 =?us-ascii?Q?HqPnF1qZCLw0u8BEMrA8ZDOaODIZG/uqBpj/u0Md?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a113ad5-8a1e-4786-6e92-08daaaa79b78
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:10:08.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X+zGdOKpSzWPbAOl70BxZqLF8JXBvLibVB4aKWkz67/S7vBG0p988ZYlYsaOt8r35QZ+Voh023eASfDpl58Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8114
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8DXL is compatible with i.MX8QXP, so update binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 29339d0196ec..ea06c1fd0862 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -50,11 +50,11 @@ properties:
           - const: fsl,imx8mm-usdhc
       - items:
           - enum:
+              - fsl,imx8dxl-usdhc
               - fsl,imx8qm-usdhc
           - const: fsl,imx8qxp-usdhc
       - items:
           - enum:
-              - fsl,imx8dxl-usdhc
               - fsl,imx8mm-usdhc
               - fsl,imx8mn-usdhc
               - fsl,imx8mp-usdhc
@@ -71,6 +71,7 @@ properties:
         deprecated: true
       - items:
           - enum:
+              - fsl,imx8dxl-usdhc
               - fsl,imx8qm-usdhc
           - const: fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
-- 
2.37.1

