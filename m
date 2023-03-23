Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD476C639E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjCWJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCWJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:30:27 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B82279A;
        Thu, 23 Mar 2023 02:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAsMTiI7sLNFg6GRRW3skaK5pAM+9sPuHI3XIJTEvEqg/yMEHLFeFX8DPQCQmxe9Cu964yg7dqlF3UKb7Afi7cjNZ7ekelkzMXd36UZRfoYE/YEYpCdw49e4ACmSixbrPpgjkB47dKqrJQEchYE22xKuRZHfBGQH9WBB4wWmEmhItCaTxm00/lyBnjvl2Ln0OyUoZA2+P3+0TbujgTaV7Nuoz8QLfTojU4vHqEPbjWHks6+/FerDKPYNqhNuQxT/fkjIApzMraA+lRphKck8F6c/JiWGdVv61X2Z8wRNxj545akIm57P1R/MqHkKUp1+1axTlDwh3MxLNXO7nviM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbz3GiohZiVB4z9XGRBUnrI+o11cZQG3CuHoxnEdJ34=;
 b=OC8sHPpoCA0U7xwDS/GA+OokEXV5TULid8J/bNiAwI1c08HLsW5DZujNZnpFhJk3l3CHFvrvAjJH0UYbJk/PSRBtAuxEwhu8jHIJuU9sqnVoJQ77ZTN0HWrHUHngC+m/Uf3RXHMkxU68gfkN8U4cFiyGFGUswJ+U9iAnXLILRkL/E1cc5RDzdxjCIMhuotfzo/bTde44WJ6g5/kXgZaNRBzPgfzQ/tQF+7N81V5mHGN4y+gWR79B9WoJHfTCtGYgtam1gpgcMD1jqqn3ASuqpXL5fRttK7IUsxCWNbFMyE+8tTQoviE5h6v2thjdlfpP1iyIV0XgrUAakwvZJxN6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbz3GiohZiVB4z9XGRBUnrI+o11cZQG3CuHoxnEdJ34=;
 b=XHsqSPDTx3BBGf1MUVwmywrV1JhSO4iOnNkg6EIa5iBybInsjGv7xyFwTKmbeNeV8+QbByBXdEYFqF0gsfst+701EaR5gJIFznizX92UBQnS9fa30OW6M1b1bZA+C0671xvJgDIeTxm1jiVyX4JhGLQkrH5qoYk64zAq8R8VARA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:26:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:26:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, aisheng.dong@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: input: fsl,scu-key: add wakeup-source property
Date:   Thu, 23 Mar 2023 17:31:40 +0800
Message-Id: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: e3972724-d9e8-43de-d8d4-08db2b80b3c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+WrTukaYctbdtFrXXcXeb7MOcG38HZoPekFnKMOPnWud4u97qv/zrUiAGgkn533q6lHsyQkAuK+IMqLSf4J3OjpK34hh4InnaPkesRGAJ25ufkc1C1j3Uy8QiYxyVsY7XHLwlL6mafKfjwzQpzqBxGX0ADQQ6Fva7a6iJHwHKb0yY3kUtQBfkZPXOYgDq3lgiYq/ADZfagaHpICZmk5zTJbcfNPAavo2ztmYNaCFy8wHnOhb/hLENGLnjCc6LYB0nyRWgsIPe08S51MKJmdamfyRBxjcRJ2JXEunt1SHMIbS99fwtexUNcCIAp5nTd2zEPrZIuTEWL3/hgy2m0rUvi/BzpiARS3Y36HVeNIXXSnIf6/+kUXjdh+1QtN6Ny6oBnw6gwvzo82q5hukwXRboyWKX8aY4TMcjpdBmLaiYxZTdnqfyUWUqyEkXWtSVUqmipb8pSK5PEEYp5qZY3beD4Q0UZNJnkl1cDyCmwnjSuK2BaxdQNDb7NUlILY/OLDRpuX2LLs2aF2W/+4dKS1D9m5MK6J1VKUtrIG8b9FRTv9QpgLbwixskaGcgWB7KTU6rKMVF0IhJcdfeuV6C+XWWJi1dz5j8D4OqK+A7folefSvdxvAROKofSjKrcI+vbae62zC4FjdX1lOnNUqU2g5oOjA3951WmArWDhFg9yuUrEPxZTpn+KcIh25TES91j6NQozts/MljKukjTzyXAmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(86362001)(38350700002)(38100700002)(2906002)(4744005)(41300700001)(66476007)(8676002)(4326008)(5660300002)(7416002)(8936002)(66556008)(66946007)(2616005)(186003)(6512007)(83380400001)(6506007)(1076003)(478600001)(316002)(26005)(6666004)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHhpTmwlXM5XVZRTTgVQEtkH0q5E3QLfvGweVIW8FLPtFcugENUcGcuKW+6K?=
 =?us-ascii?Q?jXXchhKW/BDZ2/GUBZc5ZXr8DG18K6hTLLJZps/yEYwxagzaOtoHTGmevP3t?=
 =?us-ascii?Q?kfNjSiVTJX+yoAlY4xhMtmqRd55Gfjo74MtTEN/IjPES1l7Z5On4kuydztH9?=
 =?us-ascii?Q?JsiQwoPvXls2aPfkjDtkLyPaIVefLosUYyKWa/yH3zilkxWW/vnABzCQTT9D?=
 =?us-ascii?Q?nnqzzTFw7HTPNp1gBO3QOkTEDYTl4Mp+mtUCeC6fMfPx04vSR2T7bFM5l2ly?=
 =?us-ascii?Q?x4vAffj85DjBMiwRzTx82ggkV56tmceQhr2wWnLcEcpBo4uf1gLN8dYWsPDM?=
 =?us-ascii?Q?DwTdryhxUh+r1pxVAxjD4+RINW+aDykMTyLwLmCrWHRIHe1vx6LAy5bpRDec?=
 =?us-ascii?Q?2RbhjSLyiDNulEYLbZLCt3qPgsuZrYmlJ48p8nk/0QxjNBookajtNd1arkIm?=
 =?us-ascii?Q?JWcBzpY7tcoQ3tP4WNr6Z010B1oozKoe4KIjkC+RiXK/CFHyseg+aJoGOHSR?=
 =?us-ascii?Q?otbNWQktvm5RMakPlOt/cjA4WU2XPHIsuwsaCjtg5gMV5UzIbG6RCGU7yEcM?=
 =?us-ascii?Q?NaT+QKYt+IETFGR+iNnKpfFOpaAnspj9C658gDqYH7XOfJg/7qDtwI1WeptN?=
 =?us-ascii?Q?3cCSxgrNqVI9UB96K0WK4J5dB0+BeUkW6TComHeH277o9tk3Zqs9u4ipNksj?=
 =?us-ascii?Q?JcP3S7eBGvemBHOAIVVhRMEx2x2BvPHKXpCWYD3WPCKCI/tsyofBYuTuGy75?=
 =?us-ascii?Q?SXFSIXhySzPKg35z144re3+3nE8f0qMwjRh2X8pQTHGI9559zdDbdqR9N1C5?=
 =?us-ascii?Q?wU+f4Ukmdr42c38jIDwvIVBXO5Mgd56eZnZcf7jCBSugoMmWaTxq7xhxvYrw?=
 =?us-ascii?Q?NO3nG8U1cqHP0zHHTQjv6qJQwQiAFvZQ8ObDrp4MUqjOV4n9gMDA8RWoUDK8?=
 =?us-ascii?Q?7jPCRpYoMJQbXKx71cFRuDnP8ZoQfL7wnXFrx0MRo5ittNkR65GEOgH8FFHH?=
 =?us-ascii?Q?ChifBGIql/kO433AOLDfjoqcRexdWOAmUeb11+GPzECilNfbFnGiCT6RFyh7?=
 =?us-ascii?Q?ecpu8dfizhA9NDHw3ZpqsBdUefLkOaJrIUcfRl5Y2Fca5M09B3QiIi9D4MGM?=
 =?us-ascii?Q?e/utEodKaIr8UQLMJVyjZdqR08shNNCJQjuTQ+KfxGrcn4hYWq8HaA8d4JoF?=
 =?us-ascii?Q?WzqPAEZPf6Jtqlxyia1RF9bcbp0krnAj5ZqKPKgzEfCNRb43w5Bk1/KP0w8c?=
 =?us-ascii?Q?vg1KtWCigAUoMHSma79O4ICVCk2wzqjfHVH0k4jOr5joN9Q5nFm6KSxW4t7x?=
 =?us-ascii?Q?t5L1z3v/JTad6ol8xUaLbfs1HSvQVf8x/t4vlF1ko+imlF193V2FMUtkQ8Br?=
 =?us-ascii?Q?yyI/A24lKCJIBv2JC2+XALd8QE99oB+HI7yzcHoFo7P1CmrcRWOUca4GBbSP?=
 =?us-ascii?Q?kobIlPrLvgqn7WA+OY+C5HtgmKWSnlQU7zqBITcX4q9vNafz7ADo49lO/E3e?=
 =?us-ascii?Q?ZXAORMBy7lEiD2xleAI1dyEicEm0Qxkycuc16lpoY50QcMtxvs4Y2dYePLKW?=
 =?us-ascii?Q?Wfrc9Qoi5yjeQAUviCXVP9YzgsHQTp5kPDykML3n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3972724-d9e8-43de-d8d4-08db2b80b3c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:26:38.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRjh5s6O+iGFAlUwKnmsJAIslKwhOnDPUS2pNUcfhjCmIC8ZLYVhLYI3O0HfaBWvl47eN0xK1E9blffsDNjVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8603
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add wakeup-source to indicate whether it could work to wakeup the system
from suspend mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/input/fsl,scu-key.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
index e5a3c355ee1f..037d4aa7364f 100644
--- a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -24,6 +24,10 @@ properties:
   linux,keycodes:
     maxItems: 1
 
+  wakeup-source:
+    description: pwr key can be used as a wakeup source
+    type: boolean
+
 required:
   - compatible
   - linux,keycodes
-- 
2.37.1

