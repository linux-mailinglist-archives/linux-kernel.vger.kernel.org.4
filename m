Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4C73F118
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjF0C7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjF0C70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:59:26 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D11FDA;
        Mon, 26 Jun 2023 19:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9aFYo2Tgpk0Ku6IMbAhQfmw5yUrmTmeS7OQBXPtGiWsaobEmHUDjYLounZh1z4EKLqTqQp/qfwIdnNmZVy8Edo3hguhdHZCwvvjM66xIkZ41gkpN1IZSbGeo9dKPbf1bZ0cTA7EcYro8PcPywo9/bkBwA+ttaTrC+oB+yKmCu65BwXxJVlOu0yERhAk7qz5KZGE+bYVM5U72wVUH010NKg7fP34Mvxd8hInUEFOtGYeB158O8NjbInoLInKIRKGFLJoba6CQKsmWinGvrd1BhYoIPrgF7aTSvWNm3QulcAHzWCX9aEccPu8/BCI2P3JMRK4OldotMWorTEdR7c2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjjZyKG9jF42LCNNSk1Iz4aHlrkNNT7pgyf6RHLVTw8=;
 b=bd8Wrzse/7Ee/jScV3scVCWPtuBNetZ3RQmANtGYYaZ0TQrOYYGP/LlR2W5fcNGA2qGUZ2R8X+HXZ11444sPh5B6BOlEeklit51ZSQlCZf2GRPseamfK707FuxPMrAEXzmKGfn0HDSMXVBwvtmJNzjKiSPbOLcCgQ75vRDcEdMXwRUJHraVGmHG1vmENLtGqJCWn7j0B+vnWtsX9i9405cX6BV8c60ppDC5ZBH8WX/PVnwcLyRJ2MDZLXwOmH39T1o7NeN9GUQqdiuGgOFi+M7F3gSFlVfu/ZZPOQDSlBn0KDwa+5yQMEK7TpPeNyV2EoGzssqNtcmoUkuFh3v9JEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjjZyKG9jF42LCNNSk1Iz4aHlrkNNT7pgyf6RHLVTw8=;
 b=BzBlOwTeMjuwjBgy2XvG4o6D8BVeMTj8EjEU1qKIOfPXemuHuRWzOvaX7lt5VrgeJcRkuPuSlCa8sc2mbGGyMJtd/tdJjFH6omQJcR51+1nPZ8HaRwU7l8BTwG3elP25PnMTAWKj+CRqDeh8foYNxiuVK4194iHf+uEsdYfRtKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:59:14 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:59:14 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 3/3] dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item
Date:   Tue, 27 Jun 2023 10:53:32 +0800
Message-Id: <20230627025332.11133-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230627025332.11133-1-sherry.sun@nxp.com>
References: <20230627025332.11133-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 49413eb5-82ce-4f02-13a2-08db76ba7d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDibyijYC6kAmrydapusHiUWp4zlJ+UiUrRNbBdIHKUcFWIlIomLZ6FNeG4lpCShtSBtKmaVut/lueCaHXnb85teSFS4MpHzilrhJ+zyeka+TIU/Q/Bj4u2Jndhie222mfkGpt+w0UGqzpEPF48pJvSYHPnPWtDHyV/JHDvOqS5jsWXQ08OiBAaVxz1u5dqvtZ5G+49/CwecjlYWuiraCcWd9aw6nNvpYmD/p4i8kc5GoYG6PSUKKPt7K1UngV5V1HiAYRJrANmMn3tzgH2BU5ZefGTKJZHdVGVu4cE5p/nuivx+Bc5FKTQSMJyMuPtfN9AI/9L6Y80eyfxFwIazVMC0OoSLYRcy4Q7qvu8Of9z/8qOEu4W/dOHxQXaTW0pnRN6CWO1SmMM5eFKHk33na2Y42z2x+5CQFTjzVrazQGRF8aE76j540FE/LuOoEBF57GADJKJigSi08nqbOwrYIADue0WYELn9HID3LBrw+Zkmxzr5pEfElLCUh/Z0CHUyqsnEGw0OerRIfRdxMvwI89I/9jfIevLm5r3o9RU7h0sLh4z7BtkX4HOTDS/BZgoVBB2DoYVIqVZj/bPN7L08q0kNBVHVscZs9ALWj9fEwpH+Lvp2PMV1CfNEJXnieR9g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(316002)(66556008)(66946007)(66476007)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(7416002)(44832011)(1076003)(86362001)(41300700001)(6486002)(2906002)(52116002)(4744005)(26005)(186003)(6506007)(6512007)(38100700002)(83380400001)(38350700002)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCDxZEDwXYyt5Kn29keIRasHYaLLfDj/uRyWzktVT09cpT1A9J6RMmU31/f0?=
 =?us-ascii?Q?fRjGKOhzpKtUUuF6YpUtazARUqpgjPXMuTmWo3AeHiaTaDW/XEKla/e2719B?=
 =?us-ascii?Q?nZSb2TUjX60xbAf0v5Xv6ZR6hOYWAyeg7BoRKeUNm+KGOs9Tqf/cmZSyMRiD?=
 =?us-ascii?Q?nom/NDX+Sh9CbZa1YSPUz9dgMcRsKTlfqReb6uJigFCO1Usvdi5yhkEmMM1P?=
 =?us-ascii?Q?tSIsioc7jGB0nm0AFLrlWFvlTrCv9V8bURMxpXxQ/y7GFWBg/CId/OHmdjZS?=
 =?us-ascii?Q?5WZsqBlaKVCUAsM1YDs0oDVn7QZhao7RtlD73yWuqfzA5Y6C3bqFGf921x/N?=
 =?us-ascii?Q?2PhQlkp9Yq8z/ruIKffsn4VLNjqvvSkv+5qZDIzkgXL/KHqqXJ2rc1gtsnkR?=
 =?us-ascii?Q?quLKGt9gATh0+dcJTW2k2DlaDuCVAnOZsAaGAR/F+L2For8RBXyPGHWAb4GO?=
 =?us-ascii?Q?iDWnIl4Z8gbRR383OfdGYDaSKOcl1DJ4AhpgVLz5SBsSbaOCAbcE2anAYVav?=
 =?us-ascii?Q?RjarV8MH08wjaBLm27ziQPRoNNVaLlAosqibfCcBpzWwNZDVxN6tDhg6R7SR?=
 =?us-ascii?Q?7sXc3s3LW6UEP4D/PeNRqY1LzR95nRfiRDRW+eLEvuE9CXjoYv9dypQ3BvmK?=
 =?us-ascii?Q?kemAIRhwaBTI1JjaO+gcqM3Q0GSyk5uqjaqeFxOARM1MD9eqMaf9AQGDwu9U?=
 =?us-ascii?Q?CT++XrONUrZgKxkZ+7eUyBZHHMrr+SYVU1I8iNCbHj/D1j7qAxMg7WnGLSD1?=
 =?us-ascii?Q?rH2jr9BSHvTOdT5xxSr4rnHJCMKNa2JlfA9g3LDJRXLSfdxDjbZUjdMz7vTY?=
 =?us-ascii?Q?EekYb2y2G22l1bxm+1/rv7EuINuTZg3VgOPl6dCErIY53YQHn9WQdKzdHcNI?=
 =?us-ascii?Q?bgRJ0PVC8jWl4Ty9Xjj3NyBTJTk5+BnOQXP4x0QvM4qgsOWap1v1z/pYWy7C?=
 =?us-ascii?Q?O/DWVxc5DRiMvJi25x2qxmBu1XpAn6uhnKUXVTF15dODCgYKFkBjL/OGmHKj?=
 =?us-ascii?Q?VTi+BsR+phWoXl2OTlebLvuRv+PwCMBuuVGImgBdjeU+R9q4ASHx/ZLKK+ni?=
 =?us-ascii?Q?Pj7L2bFUbiYvT2LI7TCTJjexcYC/wEEBDx9dpdeFCUmDd7W0DZEhal1n/+j5?=
 =?us-ascii?Q?elvY/VOKjjUOSL4xlFpAR1srcf2tCySP+fyz6vP3VwYX9Xaaav+T95lQMsXk?=
 =?us-ascii?Q?DJoQJVNvWC5BRrzHCKtIYjP1Bnxdf/TfpSS+K5eQ8K+p8errv9AzbqQjpAwB?=
 =?us-ascii?Q?O1nd1VggG89gf5Q/SJ7ZrE0p/l4YlGrD3+SOvC30DEcsbfka6Tw5f0nIGcQZ?=
 =?us-ascii?Q?4xy3hOJRH8HTvjnmHxYP8UvfRyviAhvmBbjzamzc080n6G0bzBq69DB2S0An?=
 =?us-ascii?Q?6HuWnGWHYrnLF+Yk+WQRpipqAvW8BEFPZFa26rnE/TEQgMdvgMDb6aHi0lj4?=
 =?us-ascii?Q?1yI6rcmu0g5JOgv4paeSXHSUHlmwvoYVpjtP7KCD7za6GHJCZRAG3lhWOqFM?=
 =?us-ascii?Q?5XJ2Q6egxZ/Gyn3N/9a4mSUYn3Q1+ZZjuZ+KXPmUXjVyHbdpIB8glHN9vx7o?=
 =?us-ascii?Q?li0wiVLTSt1SP0gI5bBx5h31Huw38mtWE6ac0l7N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49413eb5-82ce-4f02-13a2-08db76ba7d91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:59:14.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nombEiwIiRb/gCpMC66mngkALV4RqZeCx4J1BMh9x6EltxHOrvEEToJ8y2fxTKt5S/QRm5L7clZ/JEtc0iRFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the fsl,imx93-lpuart dt-binding item, imx93/imx8ulp add some new
features based on imx7ulp lpuart, so need to add "fsl,imx8ulp-lpuart"
for imx93 to enable those new features.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 93062403276b..3a5b59f5d3e3 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -25,9 +25,13 @@ properties:
           - fsl,imxrt1050-lpuart
       - items:
           - enum:
-              - fsl,imx93-lpuart
               - fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
+      - items:
+          - enum:
+              - fsl,imx93-lpuart
+          - const: fsl,imx8ulp-lpuart
+          - const: fsl,imx7ulp-lpuart
       - items:
           - enum:
               - fsl,imx8qm-lpuart
-- 
2.17.1

