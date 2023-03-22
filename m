Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348536C4220
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCVFWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCVFWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:22:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67D5B5E6;
        Tue, 21 Mar 2023 22:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMHNc6tKM65n+O9XQRTcJk6UT2WZphtp39OVpu6nrhaAkPZh06PHCVuxnjP3u4Y0KUzO/++/2PVrN3HonM6L+990SmjFHIf0CLrIQSWw9kquY4R07Wq8+0zb72ghPyVSTy7NmObSHHAU7oiPTrxzgfKNTmfFFfXx2CzYiTmNXsLLc26UYzFHLyxoVBCNKElAxmnLH4JlsAYlQxRbkpVpWi5OHAeaHlo/BlA+e/kca7u7s+cVxP5cuujzZXm4wLrlhMSN0jT/ReifanRD/Lb0sMtAlw3AFiYLJ0rxDQJoVw4otMmvNSVlvd7GqjB5LMUrfmS0wXoj+tefMXz1dSssGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=a7vavTb264Vaq+0HqJAvxGDmhkXtiq6tI9zafxmqd/CywMIVlluUZb9I1Vy1OxiCLhMzcoaIO23YxbM8NuIs/7CI6KnYIKuXTONPTOUbWxwwdO/v8KQLMFEBzuo75eJXh6BzDLqo2ZjHHYJWPz3JqRHLWdhRbsc98jxwveeaVZCk4Vk6L83Lie3fhtXqerEilj57zTbPk7n9ZKUaXRHcPdJk+Iz5AOFex1Iy/lSWk7dbejlWd7DY7k53ahHRlX2QrekVShh6xGTohovKCNWsbp/uo18QppCc3LURWp8IvbMVJOblUDVg3FslKKE0ZoOZmU/uAr5YEPNXOpej1fvdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=CVvA//n880xMvGtKXyZla7KZIfvGQl+TsQ6qGkAaFJY4g3+FPOwqhA+VkYyN8f28so/F3YevEtJpGFvtJut8KoN5u5J5Keafi5uMGStKR0EA5BKSNz3GSNBB6dlWM1lVCTehvRo3R+z3C2nDoqOnTC6HrHL1VK0Xgj8UQn5fAZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
Date:   Wed, 22 Mar 2023 13:25:04 +0800
Message-Id: <20230322052504.2629429-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b38eb49-3ac0-443b-f0a7-08db2a953155
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SS4AUYdVq68IfHDcpAVd69cYzEC17jfnt+4ekYDjPWLdNLbvO+54u0zRgitjHH52xcZ0/rpPKeGqpsgvc9v62Psj0251pKaUDCeJ1ZbDVAYYdu6Lx4cvinD/eecD/cHxbVDCTFaIvegQwjXxqNQdomhc1GKxVPwHFXBXAZE6vvTqgmmbO5C74BFuV4saJFEQAtwCn1NYdemDF5G4GnBka4py8QK+2pHuHQSVkf7QDvuk9qfsRXhq7gacgm8QEQqc+J7P7M8TOUhbNI/zbkVEvZaUAl9zYs7nQekNDqZxZ5hyD+XoK1eCOUl0omrJcgLw8QoVLrj0msnj5s6G7d30V7LBoCTsr3WXCJRdexc/lzCqkcrpKQOnl/+p9PUprMLItUMPxFaCAI9JKJPOz+nogLd8lOGA1DgVNcbQ9BoZlpMfkjiPXKPeFmPcge3z7/ob5FXoRY9F9EYJ4cfY8X+NCv7/mzrKjdSrib8ZNeVeICac92RbFr1nH4RYQjVsGQQWIB8S3igs7G52PRph23d7NXpekwlKEs5okR6Aq5Ap5eoY9PhNJ2nnnHroMDiiDCjDlkPuDarUJShtr2/s8FUWuYPjlL0MVfXENA9nhOugIb2HvD78IB0aJyfGvkvYCUw+t4ivEefpIJlAJxpwofQ3EVBx0lLS2x07bzaGgUk2ep6ZGTSCvnnLIANXFzj8y0N0aPWtySHhS43lC5BIDd0jYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(15650500001)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(4744005)(38350700002)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMNWhX1p8fHcigFpjHoqNUzkHSI+RAQWFKaMxvdXIQy8cWKNDDepVqJzoj8s?=
 =?us-ascii?Q?RlgNHP3JpGM10KKpdLlN21tt/EzDz9Iq7mCMTJXoEI+NF6YPFNfdtvZ5cq6/?=
 =?us-ascii?Q?Dp97Sp19z+t/1eHUyo48jS0FirZMbhpLJ/fYw+sMqHTIl4shEZUSNarguU/x?=
 =?us-ascii?Q?pCe8IdV+nFga1Xb2ysOdloWDiaIyO4tUvv721waOQIOCg2oNFTdkOHPvJRJG?=
 =?us-ascii?Q?8HahK7a0RyS82JnVUTj7pZWIdoQZMdcUsfMUMx5asolBI1bxj1PzLbTunBIb?=
 =?us-ascii?Q?MvtkvnyIK0T0jjntt3FK/hzAFn4CxNPHsKLhHHzzVXkykqke0OPNR+jI+k9z?=
 =?us-ascii?Q?MRUQ0/jlimeTEsGRnIieDVkhxRmH+dk79IA8en05hJt5D397Doh7uIcI9e6s?=
 =?us-ascii?Q?0/SGcol8sfrgoN+BIS7tdShn7121LCWxsRet7y/oKVlD0q2hhqD/DVOPoLSg?=
 =?us-ascii?Q?kTvb1peF+A+dtVQnV8PVKyTX2PhLikoh8MuDDfgLefCMVIFFtkPgAsnWsJnh?=
 =?us-ascii?Q?BDkpdySOi+R+xhTslBS3I6ksH74TbCFGyoyTuXn1S4mSMW3INiy7SlWZNNot?=
 =?us-ascii?Q?ODWCUsHAFoSadA2yOxS5nADYXboMn3Y5Wm3ZN/RXIsXOkI76giYsKT5w2ec5?=
 =?us-ascii?Q?cMapCcwCrB0jNEKIqA7JeNrxRxRhuxV7MeKooMs/tP95DekyHAS2dlJSjHM2?=
 =?us-ascii?Q?AVDcleYp9I6C8xmStwAud6OZmb893ml2r1wH/3auKUH8jaaVa40DqExTBqSj?=
 =?us-ascii?Q?fKb/fgv/w7cUxfYDPf7+idRtd+fQ71DYoTu7QYHyL8jQKP4V6uO1kjLYXnDQ?=
 =?us-ascii?Q?ZJkl6cmIP25pgnFolOa9ZSOUjflChjPrTPRCl9/+Mf5//aAe/xwqmmqTh4hU?=
 =?us-ascii?Q?g27lhUADxaosRQ/GkTgW+MCA3Jr8oSny0TjsLWsAwiWb90xIU8bMIgvZJmiR?=
 =?us-ascii?Q?j3R+g2/tB0gp3/S2aeMygPiwsVmUX+bRo8zMW0eDS66/FRjjqc4B9hEPhYbL?=
 =?us-ascii?Q?Fu4sGWoffMiuSHVqZ6i3qf3oerdNMU0IalxQl4XaUFjDGwI39ZR7kI0MiH7B?=
 =?us-ascii?Q?p306++D6RiQhswA1VZ7PEfVRMdbDlXePljjmkW87LqtB60l75dSKbPTGmkmr?=
 =?us-ascii?Q?P/ebchYNdDSaQfrXBzCNF7p3E0Eh35reCrlknWMiEVRrk/ChoXGe/LmP+bIG?=
 =?us-ascii?Q?pKeelvF0x2bUCBidVgzJMGalYHWiFItOamIY0Gj1yqjFnk/xl1zT2XiA69qk?=
 =?us-ascii?Q?798Vfli+AQSfnDg5K5rTd5SQwd6VTLIMS7Q6L+7q6awkLroY4FfpjYjsEeNU?=
 =?us-ascii?Q?f7Yub0OwviVSeSHilAvR0zRO2bL9DZFGRQxusWyNSXTVavd+0WzZcBut83wy?=
 =?us-ascii?Q?XCYpZ9mRBCXnkz8HgfC04kxep/NBEn5Z4UJR7WzOa6w+4rkEkAY0nfpC5LGl?=
 =?us-ascii?Q?3p1zmmzaHkDCgQoKG61slJAeL5LVOMaGFfrGpqrVXbniUT1n7ObVPoz+N7uq?=
 =?us-ascii?Q?lXeabssoWMYmy4KVGv6U12beK+E//0fMDhkoSG5YT9gxhZkQrIim/LCezzu8?=
 =?us-ascii?Q?kj1YepfyvGVI7XnjIxUeeN+mR/sC26AMVrOq+Lzn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38eb49-3ac0-443b-f0a7-08db2a953155
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:47.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ba7iDxi5wqs4K8tY5T6q69lnDWkzh3K15SxfgTRkDAYEMAn0uaQVWJeXZN5Idl3FeH4661FPPt84USljA0GRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, update the compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 7f7d2d5122fb..f91bf719d4e2 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -189,7 +189,7 @@ tpm5: tpm@40260000 {
 		};
 
 		usbotg1: usb@40330000 {
-			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 			reg = <0x40330000 0x200>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pcc2 IMX7ULP_CLK_USB0>;
@@ -202,7 +202,8 @@ usbotg1: usb@40330000 {
 		};
 
 		usbmisc1: usbmisc@40330200 {
-			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc";
+			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
 			#index-cells = <1>;
 			reg = <0x40330200 0x200>;
 		};
-- 
2.37.1

