Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF6653C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiLVHiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiLVHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:37:57 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3F19017;
        Wed, 21 Dec 2022 23:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoubS52VFMdJCh1DyTZg14AphzUMXTywmjWsx/qiqyhx660zBTWJYg4t6rwMgkiJJm/AVss+YpwGnA95i/pzXTNArFXjfPWc5YQw94NeGPCBJTST+GXdxEolVeL2sDBFxmrJi49wpUGsFKQU9uDotDWbHcPZ7kKqMYY0W8kepiZwG5oM4plLzKRLka9ZOAiQ8U/Pql2P51kRaF6yTtEescanhdoe4hT87pe0emtlEHb0Cry0vO2f8Hkk7nfVFTpEOBHxpRw8PFBohz7gQ6u5cEj6lETPbI+KIL0oINfqXR54qfZwS4ecWVcWO6YFCc2UbSUTlzo7y1CBN/f26Ttmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/lqA8Q+64wM+MNKa6vk8MLd/5oeOu+M5zYEeDzhxTs=;
 b=RwuGa72j1aTSRWnKswdoVhRE++mZh+HmyFhStyvW4PywcoQcZcflkrSS/djO5wKXYFDR1EFK4YM2+VrHpL5GUJu6fR5rV3EouVhQSARtLQZw4wC8o8Wr8VQyChdjSYvte55yNAhfV3d8nFTDuAUU7zD+rJnI5XyOMrUXiZWvtG2gJ0NirD0/L3c6Zm6OOo1b+tI/ltYRziWYxiDiVoDWvAbbjHuCFtKk2vKcGKle2nDhWlb9l+TV+I2haXKSphy89dKyETUNQi/jHRnJUOyp3uUQxOzu5Rbj04w4z3b4Gndsc2O8MNQwlhf4zlc2hDt0bnqXj9LoNlgliSS3tdarhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/lqA8Q+64wM+MNKa6vk8MLd/5oeOu+M5zYEeDzhxTs=;
 b=VieX/kbWXShKnHtQg68AJAE7XVs6sTIHEPKm0xoeaaQ0h72KXbmgdBuUCSL6JvClFysG7JvWyHDQvbeemnngG6j3MT6U98HY/H1nEr1wjWixbwGmbZQiNk/MT8IN4MSxAhM8GU1Bp+Hzl37cHyywHIPJtDRcrrhi9iRo/5Qr84c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 07:37:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 07:37:55 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 1/3] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
Date:   Thu, 22 Dec 2022 15:36:16 +0800
Message-Id: <20221222073618.1064415-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222073618.1064415-1-chancel.liu@nxp.com>
References: <20221222073618.1064415-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: a98c97a3-27d3-4b67-9df4-08dae3ef70a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ewiu4Pa8qjzt5zwei+XpHGp3w6OAiwpSBRqXQHIP/j1i9vOo/IrCamoAgDgdcxthuZqBSNMkCFji0psvwlh2mDWfyc2DxWBmxQ3L/ufx/8fFiK9PAtjYc1KowAMi0q9lpAt1/MPH/wy0gFcFUaEH4W2ZsyYlTRE8q45Wn6lHxwn2MuZ5IO1+TVNQUsx5hxSIuQHTsG/IEIsvxA/QFQEmQOpAW1GZXgAKNkn/tRRc4CnOQI5lxtA7vVSVPW+zCXy0fOeIKIBSi3xKoHQ+7JcREwUF0ooHCAuaft0UxOIAYIXc5AUwxptakPIXEeru6Ye8SHLaUsAgvucXT3ZDLbVaqTnv1dgW9uIGoUcuGucOMCo+vKXSFYv6Rzc9rtSJocheLmZ8wZ+KYFspm+cAo2pUtK8FGfsyAveJZxbG+TcmASd+dgve40zjk4dZNsfSCyl16oL4rFXfjB+ZvdjX4GDxM/GkjH9tXEk3FO1dssL1p6TTBFzKSA2MzPoksQEv47v9adZG6Men4TeJnHsMjR0ON8IXRlch5wSaRZrJ5MLox4VDQv+EauhmLNYLTBobXFqNn1InSYE8kh10uYRjk5lmcWgkJhexx15tYyvZqKqSAUXGY2uU+8Qe5yyJCa8/RoOatIlVZj8xGeV/X78ea4KniifGNfzYYUtOVs8uwu117WBoxarHTISVYCbBtPpNZz1y4INo6bemB/MMjK7EBUuUcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(41300700001)(2906002)(8936002)(4326008)(66476007)(66946007)(66556008)(44832011)(7416002)(86362001)(8676002)(316002)(5660300002)(4744005)(921005)(6506007)(186003)(6512007)(26005)(38100700002)(38350700002)(52116002)(6666004)(36756003)(2616005)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WnHJW800Yjvjf4IA8TL17UbwzLck0gwD4eXZhx7pFdMP4u+9gqni082Upmdm?=
 =?us-ascii?Q?1gwBMcp1dhDiTiKht73ZnNiKxXSoyARb3ARQwYIbBVrZpe0Tidl9nVBDtJ+I?=
 =?us-ascii?Q?i9RiIzfZ6EisIvfcRd9P/OQ7d6rOMrBZ8raQh5P0OWYMwhkvbUeQv+5FSzjy?=
 =?us-ascii?Q?dFAKqwG6iBkaV6yPwMBGP0y60rTaR6PsfQQYvrxAPd7TjFKW3fZbKk/bbTHE?=
 =?us-ascii?Q?3lViaTTfuEckUWdMzRLdL5+UK6cIApjm1IImC7S1S+8Q5rQDM4i9lXlKHrJQ?=
 =?us-ascii?Q?rG25P7SGCnxtktooePYS2tWNd1EGJfjPW4Zta5AUmKXLwpHlZ3FhHCJnED0Y?=
 =?us-ascii?Q?eYDYCT+SWCGylEsIgFo2UFyEFuf7jB8+a0uER7hQ5k9+UMpk+y+KCRq/5nii?=
 =?us-ascii?Q?UI37MLU3/nNUV7JYl/5RFGwxivYkq6OBgzEKhgDc73KN3sOs+AYvKpKoTRhN?=
 =?us-ascii?Q?Z8dd26mh3FXM4dKR7remjeAY4+2t/rijB5OkMGS6jBSRPENtDx04aW5LSyAD?=
 =?us-ascii?Q?cB/uyLNHrWVrx8/y/6uCzMY+tPYTZnlO3IkqKZk7Xk2mRo9Y9PWiRm18oCqr?=
 =?us-ascii?Q?8v30irCgMJ56WV8JFSETw8ZKEPLz0u40SzUx7L4RJibvHdCHg+eMQn07TwR4?=
 =?us-ascii?Q?KkwB4qfTLuTigDUYUpLoV5iW17zu6azgD0OTQ7v6SU128uQb/VEqQVcCpacU?=
 =?us-ascii?Q?jmmfDaExfhzgroyZLicHMfbLdxLXeUa1Gj325WCwUc+btdAP+/jPdIcbstLf?=
 =?us-ascii?Q?sDgLhYCQHw5EtRu7bJ63j5CMWR175eqMoi5qysBboiGJUOSdbLuG8fMFxz/p?=
 =?us-ascii?Q?MqEsn2WiwGRBMMpIa/bcbQpvFt3iI0YMKwVUzVZ7ItoqwaR1n7mMINDR2e6p?=
 =?us-ascii?Q?WghCUNU0WVyu9e2DOP+HmNKoVPoiVmh5k+PUs5qY4l/S6nXZLPX8qhSHL4af?=
 =?us-ascii?Q?PG1Uvcs/G4P5NkC6mjTyz6/Rav/0ADYDqvhPIEdOjqQuWLb3fgfjoUryf5i9?=
 =?us-ascii?Q?n3TCFykqD+XlbonU4Y33UM5qjivvCG7Isj/Hklmx+miZpaskPS4oSTUnlhsO?=
 =?us-ascii?Q?KtkzLd9ZANluFSNKeBhiOnbsELxM7AJXPa/8DCeZHc29+52Y7mLh8db3CCUK?=
 =?us-ascii?Q?yvE71q9UCWvI0clsHRSSFgR3iAMNwxU+Xc3TAKJG8lC9zbBADMOv4Scbg8gp?=
 =?us-ascii?Q?R937v9ri9U4X8bVd5F89s8/wKvl3Z0F9sB7jy0dHDfNcPDndYMTYXHoDwvXE?=
 =?us-ascii?Q?gCjM6apDocQTTqpENXojKJ2YN/LT+mMHfa+qg1pVxRGccEYoVIim1xuLIo+y?=
 =?us-ascii?Q?gDQJWiqyMgA2HO5Lp6vM/LObbuZN8D94z1xQ42bNv/dmXDXv/do31SrX4WXL?=
 =?us-ascii?Q?ZRoBxDbpxYM81upu8zyA0UCe4i88uAn4GNAndhL8m6zPr0xVImAixMnY5Ay8?=
 =?us-ascii?Q?TbebIHGgwijNd5JApFa2IyoR1UqTLFKzTBK7+0aP9foTQd3yGc3Q2FVn9xFe?=
 =?us-ascii?Q?zyJZpsY2DymLdxJgENwmkYuurjcCvhS4VWZV5lg6oxwAxaTxl8RHCK+Xts3R?=
 =?us-ascii?Q?z8MVGIr7AAApm838NEdxwUq9JGx2KKQ9Z3X8E4Eq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98c97a3-27d3-4b67-9df4-08dae3ef70a1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 07:37:55.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbSZPJcisNvmjkyy1iL47lceLGviPb1x2QXsRY3HRwZv5X3P6Ni7grDQP/HONL4XXhA8w2gPLJjdu35jX3skmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "fsl,imx93-xcvr" for i.MX93 platform.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 223b8ea693dc..799b362ba498 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - fsl,imx8mp-xcvr
+      - fsl,imx93-xcvr
 
   reg:
     items:
-- 
2.25.1

