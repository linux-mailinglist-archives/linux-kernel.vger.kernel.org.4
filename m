Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7ED5FEC17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJNJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJNJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:48 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0BFED9BB;
        Fri, 14 Oct 2022 02:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPAD1hQp+6iaWWUWF0F2qYLSCnpa+Ap2JXyKg53iMAGFFYGXKe03QLwdeCOLMaZ4e4yXJ6mrPfq/CFIjBvS4sX6gdkGr0tMfPMpCjxgRmvDYEZNaOSvcNl1C/L1XVqXyEvNmNCFKlE6LvIX3i6lvT5EQXJYGmo8LkCvx7Am+qsP2+EUy/F3XTj8Ko7IFuB8JQEVoe10iKNMj4YaUacKcTLYb4XpMUpDwUtpkiaGdrXDgqFpI8B7ULjdagYuHQEyqsh+UJa0ZRJLI18KKpbulIYu8jltpm9VAsovfFiJN1arvyu4mBlXEzaptfWBKB01PPGCrdeymoMMMGmnToNDJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBOAa//Rdq02gzFhd1kiy6nTuy/KUaDASHAplHiuvuc=;
 b=DlD8jQ+zq3vgeMnf2fbHrPUk1ZfX8b/86pdSJs4VPKKwXVLY9WgDomrndM1RNoXtjYN6EEkmUDj7vRvUygRAsL2CFAubDc8rsYTX3OJSu+ZYyWdClJ+kz7FJKB1FWZV2wzJ+sCXEj7atDmy04pV3cyNAtkCikdjPWPgZbH3s84NJYgHqSrAKRWvD1LM+7GpKR2AMIZMGdzENmxWTv6+CLrGXUxKlYTC3mIoPOb0do2eCBa0zor7bWWqH/LmiBJed1PGemIMpmyHLGdXWN8iCWyvxanqvhcjMj+pb5y7txAe+bgNKxGFzwEuvGJyLV9ZR7uuyr8JC+OQF0W4KsNL8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBOAa//Rdq02gzFhd1kiy6nTuy/KUaDASHAplHiuvuc=;
 b=ZRy+WVXs2/9GbaCCO6jGuKfnU9QUX97oM2h+QiyFY49HBNu4oeLwbZeCLzTNxixXHHiimmLVXAMw1dfg1m9dizADlpe+hyb8x9cMgdAFJ3cNOT7skKZDxZqBHLYYZreoNCnThF3yGD8sw1eU/pvFQY9Psa2Z0DcMe479MfjJ17k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] dt-bindings: usb: usbmisc-imx: add clocks property
Date:   Fri, 14 Oct 2022 17:51:44 +0800
Message-Id: <20221014095148.2063669-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 73667a80-9d0b-4dfe-56da-08daadc985e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlXaZzOzPi9WNPdCYke2ZoLh2yXdXHdbPQvb3bevSkKV81BptV0QHBSLk4nCbp9uzQCkQX7YzlOzb1hRNISbm50XqBUsmaDrrmA82X2sQLhFo9QUMIbRg6emZyq2/0rYngd9XJYqdibJPQwm/qFwr6pM5PRG9zx44tSZz4pJbziRVgmBnzfty13bYAEqtskJKSM32IM4nPMUtrQ5GLbBniRIWTaIvctEq6Lzn+8XO0l7uFMwtu0Sv8pSEGSi9aEOs1JSGIJUxG/h041og8grqLGhEW1L4FvDh+WLEy6xxKuD0j/6Cdr1ETAk4/f52p/S7rw+o/uQmOCTTnAyNR40XNXiR9KCw2+Iu9PhFwvg/OWOR0c08INxsG5NoeeIWCq3yDxyCEbQvDM5nmJt15WG9YyO1n7fGP3F14nOZkCyg49eZEYFw6+YpOPlBr0wLpcNaEeGL7XNBapC0gpKYcOMSu9n0IPu50XTk/O2f6+A1Cjq3Q19KwRBNykzAptAU5eo8UqQbDA2tOwK52onqnFyjkNDeRku5c7CBRan7QdDXv/O3hgENL2E/Cz0GlLcNUXXlT36LDUdPF4t4Scbo4qRsIER39MIL0OIpI2aXlFhlhCful/DrpNepp0h4zEf2vAxXFGo0blhhAfE/KQEKBDAKOG8rVjqygsJ4Qi0VKcVzD+DSqv93PdEBDRiP3LTJjI2SNU6TekJIshMeJB3c5PEY97MiGxKcCAayjrs8MEWYrKFVbDIt+HGGv3AKhnGEKxKku37njEfSU0lEUHtIdNSFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(6486002)(38100700002)(38350700002)(316002)(4326008)(7416002)(83380400001)(6512007)(6666004)(8676002)(66556008)(66946007)(41300700001)(86362001)(26005)(8936002)(1076003)(66476007)(6506007)(5660300002)(4744005)(186003)(2906002)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NqnMYW1BKoOKlPphZDcX+JQyJHj7ZvTLCPYUc/V8LdCDRTAJPYnJD7A1n9gU?=
 =?us-ascii?Q?QuShUZmSRQZJQcgkATUj48QVNPB2mBvL4mHAyfx9XJYSN3LcAwb6L4ULVDU/?=
 =?us-ascii?Q?OnYXGRoYQay2pddkuIK1gvbasmx6fS5UGMLmru/YzShB6ArAhEGUglbBy1xr?=
 =?us-ascii?Q?v+Dxw85PsH6xXvkwAyj9fl3YufGslvYgJ4WXP3PqiAiaGqdqQfdHaFhhG9Zr?=
 =?us-ascii?Q?Bv7gS1yMqdNk/TYsiG/Da3HL4L/p51k74ghtLjdubQfuklMlkbW6iUCoyl38?=
 =?us-ascii?Q?pM0kHLzzYi5keMUKZ4ax64ggzILxqIbSvFTep6/QdKoJS0SZe8igDRupRgPz?=
 =?us-ascii?Q?Ci70PAF4rJv92WVBTgED14KpTAggyOVtj50ij0v5M5ufhvrdYM7afNj2eZY3?=
 =?us-ascii?Q?Z21dE8NUVrumw5uRf7WXvKxQyJ6UMZ0e/X/PmusNJ3My8HdrUy4L2alQYGhc?=
 =?us-ascii?Q?q9e66wbia+TJX7SxZlAEtdOSPxUg6cMedkBjEtXU6hPDlxj3rPTSLuFzcR96?=
 =?us-ascii?Q?BILwd0xrFIA83hO42yitziAvh1n/cDu5QPOkuhD7cn8S6qMtlg7YpkPYskWU?=
 =?us-ascii?Q?qQq9qEd/9V32OMBH75uW1ZnPpOJ/IKVAf18nMMjSXnfbK/141X7+BjfFR9pD?=
 =?us-ascii?Q?Ees3DcIvzrUcN6xjz+mVl5JVdZGL1OUZa26tqr/+ZMm0eQd0Y+KRPJSC5129?=
 =?us-ascii?Q?tkkb7KUv/vHYIsOdyYwO2gGldrK85Xu97KX2W7G4H5DzdCAaPcV4UDgPOKyv?=
 =?us-ascii?Q?OgJ1YVniuBAasnSimbctVOyogXO6V055Ak5H/JUD+O15GJOZ8wFj1/B4B1VQ?=
 =?us-ascii?Q?onVZ3ENACTHy/8pda9ZCvcg6O2utEkHiR2FtrT7zOQA4YKvemIwEwc5jv92c?=
 =?us-ascii?Q?7+EQAAlXJj65KphpSU5heMDJd+jHfxrwvduEtUb2ldlEHulO8L9GAQ6YTjWe?=
 =?us-ascii?Q?AAumzVUl27/sDQAt8mBODBpAqndXEQT2gCTpt3PynuS/+JXzwluHFL+5WFFi?=
 =?us-ascii?Q?nsRZMAcluuII6aw0Vo+fTl78vUALfcHDrcWTvyhVNbh4WSH7SFgUbTEmy/JM?=
 =?us-ascii?Q?9KKy69GByF12Oed9StxaITzTCkmDXfcIVmbQSRfnQtS98DRmWnrNMRrvIxAR?=
 =?us-ascii?Q?E2lLyP+N+QPY/6bBy2S/aPkFi+OMAO5qvhr3qcy11NgWkkzcqmdnw2vgaFWQ?=
 =?us-ascii?Q?dqKk+Wk6UX2SSZr5x2bWI3peOOddsqRS/jFLn4jvn+nYaCFrfBOiPbreO1kH?=
 =?us-ascii?Q?4JjuArvt1eoxd8bDeqgrHuizg1q/hTMLbUr4QgqEHUCqSWu6747JC31cXYky?=
 =?us-ascii?Q?yuTVXB0CtTSOBahdWDDhqPsJANFC/yPISx32g+0QjdQO+YrKqe6JkCDmTa28?=
 =?us-ascii?Q?+HTmaRlqQRWq82+zF1Spawn0eilqQUmsYTbpPcRIKbu6Ahat2n9pEw9oqPGw?=
 =?us-ascii?Q?Be1aW0s6vuhTiegpSbJdwRsXIibja+GWqnqCiAKl/i+A+ff2TYu5EF3kAOMr?=
 =?us-ascii?Q?bElxcHIh174KiipfIWwtWQuHdDpVhBxBlcH9iR+vr3eStbyYovADLlyTXpJ4?=
 =?us-ascii?Q?6UB1kHq7aSXeN94cSZnOPfWbsVllThj1YuWujW15?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73667a80-9d0b-4dfe-56da-08daadc985e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:27.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6EO4xbgqKNu99joYYRY2Dkp6gqiuyNPYQT3Rg3ry4zL16gDndxge3Aw13hnxVAAIV7hEMjS9IS2XRplt9aO5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add optional clocks property

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index c83ffb6729b5..89e2035436f8 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -27,6 +27,9 @@ properties:
               - fsl,imx7ulp-usbmisc
           - const: fsl,imx7d-usbmisc
 
+  clocks:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
-- 
2.37.1

