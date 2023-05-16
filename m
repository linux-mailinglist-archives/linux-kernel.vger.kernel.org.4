Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362170528E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEPPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjEPPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:45:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1D9011;
        Tue, 16 May 2023 08:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWxB8PpozUkSfWfyvqysBTr7M75oXs75wcpjU/HbFGTe7++t0JOiA6bWPbUD3VDt/AY0JYEX4SkIi/4Umux4pWtgCOAEGbanfzOGmZBgFCmkqafVEAg4OSeRJYNYaQfnoQsVxpz/bDxXtGQrTjhq+3hFYhats8s16hM5Fa3xaeTbuYsuaKUbhgThjDjEy6zhn0NG35NuWY5kaaeYcXmeGnMZtvkE/KPuJCVyCd0Gel+BtxBdLtv6wSOBunJO9/w5wJDA4yx9QgXbLdeoq5vxptvNatE+5lqx+0Tq0u76qd+b7np/CDv5TNmE4roZkfPgFrj7JCbDV1PZJKipzX0Nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRD3I70Nhgh5KFb8QvDbjFiZdXp5lgtUoKw+8YSgtAs=;
 b=mA84u4RbTq6rAszhUbMYXjim3bdzSL9iPVZFVz3vHfrNprGPrlEzA9Kf38QjTrDTwh1NVIkzQBmPoZyK+H25INaq/62EBHl5Acshilx1MOdDDWlzZAiMdWvrzGIv5ta6RoTJ5xz8Cz1qqXWI1tSRLPnqtxfsJcarHP768Vm+UIXmAwgw6o2Pvw2rPPuXrZw8GBSecx6lFpUateSSRF4SYYJxmUe1kobip7WnL148vHT8qj9EdKS/7emr0qC3WoUyz0VcMSsUYhKzbZk09cRxA6nygxcyWc6RSTkAqhHSO+fz123taPcDS4Nh2qjGxg/ese91P8cWI/aMMrALlhuY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRD3I70Nhgh5KFb8QvDbjFiZdXp5lgtUoKw+8YSgtAs=;
 b=D7o21Oy7NG3/0WUyaVvL2DCOlZFXlY3L+8X3mVbJ5mpZz1eUwyZ96qlHpF41uQRI1rGG8FMTHZlmFuZn7kZOTaneiCejX863e9zj2R7yVlinPQ26Q/j72B1E2s4K457FPLpwyifEJnCdWFIBxcwmMnLU8PY3xbRFWykJOWg8PpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:44:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:44:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 6/6] dt-bindings: phy: cdns,salvo: add property cdns,usb2-disconnect-threshold-microvolt
Date:   Tue, 16 May 2023 11:43:29 -0400
Message-Id: <20230516154329.3155031-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154329.3155031-1-Frank.Li@nxp.com>
References: <20230516154329.3155031-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b50ba5-1772-4407-460e-08db56246714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKMFajv4lmzDEB4N5LuEqEO0JW+ZG9erk++ne3si7yBiueAOmHpWEqNv2Br4uk+Jn/df8cqMS72J9IMyhrhnBybLYBK8vd78NOtTz1a5VClpq51zpTLYWdhDJCTZgXAubpEDAFfcC9o1d91R1ue29CH6TXO0Y7Ps6ayeqEaE75Hki2t8V6341v/7fkcZIkSUjQll6QYm3SFl5FwkTRg50e5hfoLFcwtgMNkVY+0EG6oFIqlLUEfH+zQU5GR/uuJeHkK7VvdezQ7dZXv4BP71hi5O2JpbaFf7UAABZ/9bXmFnZ+FzZQGEhU4sd3c7dLXbseeKXeq31+tnUwxs600Z+IHlpXaAsQneIXYVKiaYcU6dLJ6KZ2TRZ3NhG19hGA33+DeLoESNDRqqu7xxdogz+fQU9B3IBBIosLLeTRlZs/bMTgdlH2UWTRFNCJhp/QiAfzmiD6GtyNKAsydD6Z8XCbNHCOF9v7JsPALhbs7FZMWz2MVE5+drlLdWMMV7xlOcEn20kZlsXnWF2yPLYBqPLkIirSPljD0MC7I9Aiy/gLD/HQk5uUQzHioaNCBZtqpAcJF+tOVve52PIdt9GPZnm823Xb1IgL+TIOENjl6kEQ4A5BCW1/7s7KuYnp5mj0rD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(4744005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jFpWTRL0ZpetAW9zwsQPv9QD+Lcjth4yXbLjnpgLq7QTH8Jdr3w+HgHjlUO6?=
 =?us-ascii?Q?UDc7+zAcdeEvj/2guyDZjrZU/1W62zPFn1Gfp35lnq1WYEHU3+9piwY8jcDo?=
 =?us-ascii?Q?pXmB85OTFiKl/BPTlazsPUNFmzyiTOjQ7uGXtPwLCklZcF3eKMN6lsMrfmXN?=
 =?us-ascii?Q?WFoB4vHIYf5l8/bIb/PYlOhduxqp+dAaNqnGvkO4J8UAphqzyNrsK+0pzr/p?=
 =?us-ascii?Q?XdRpM121+q6OctuL/0V8hSrSMyelcEtkTmMJ5cSAUkWkg6+YqLYEeENpvrjG?=
 =?us-ascii?Q?Nwqheu9+Jd32L/aTq32jdGdoC0dSqHCDuMz2b4K69dNC6yUzaeHzQzlxAUaE?=
 =?us-ascii?Q?LXnlv2xXxBrx77p2vDDf/8rx1vXGDBUmedOBPrScFt+uhDdCUNWpSsab51ML?=
 =?us-ascii?Q?LvxtYkN+pNroa8usd8Qf8Bza56CNokpd9LYqfir8feCb9JARb3X9+VvSOMhX?=
 =?us-ascii?Q?+zGkZAq2NDQjQIl7pl4dHfSQRENj+mYdfu6IMw3lVE1uLCLvERRIPUF/o9ob?=
 =?us-ascii?Q?WEDpZ10Yug26Q7JV9HC9fyZxOwt8l3M3pkq2jbxGF+UsHQws7GTsf9bg3Sbu?=
 =?us-ascii?Q?lUOxpUfNYI/3q0QdID41aQHz4OnuTntNdYNyuGvleq8Vxpcs86qnguqywWye?=
 =?us-ascii?Q?FN5kumN1pynlDTwgEU7oMGJzl05VUOzxm046ByOXxOgXi7Me2Q4c1Tniv9LX?=
 =?us-ascii?Q?IU9Pt502mJloZxGNMiDM7L+i2K8/KvaDUfq7mGTMmUjRoyl3maC/DbKiuHvl?=
 =?us-ascii?Q?44r4lD0uhhKj/rhb+t6ymt1tdd/qhVGTlVBHUROH/7xROdpilzP4Z9nVAqd7?=
 =?us-ascii?Q?2KOqtbqd4Iw5xyRjuiWxij++vfLp92F3LdjUa6CIetnJgJ35DR+s8L0cRFZk?=
 =?us-ascii?Q?i3TgJJ5OUN2XjSDfHW6z7tHRjM6i62ruNptGcJH9zOQ5TAoar1JuvrzHei/L?=
 =?us-ascii?Q?/0zmpN8nSblQIpBIKrIr/aea+FBcG8/Z47bMoztbSyutKFihogPVlNoaDo+f?=
 =?us-ascii?Q?eTg/x0rQL4FzbZbS64VsYDPDmfnsjMdi6EoC7eBq7/utVu57gEIU1fJ+nZVU?=
 =?us-ascii?Q?Mrzu71RW+LFPv0kRDEeMdhexc1QBHZBUZmI9Dc+LWOSM+7gdQlwM6FpJ4iiQ?=
 =?us-ascii?Q?mkt8MAPzZA2FtoQ35SF5QNdOKCJfQAgVQsE4ekkKMyIHf5Wr+irRQ+KbN9F8?=
 =?us-ascii?Q?A/Dg+05pZOaGFLB6W/mukZTliK4ZrUF3itxjuPTXrOoVfzYlxo/VvkqARjzN?=
 =?us-ascii?Q?fFc2KKUq26Amtfh1B52Al/vMYx9xf7PB3+26DOEc1hFWvMJ7e2L7DRiurvUG?=
 =?us-ascii?Q?YUt/SX33rzyZ5cl7mUxV1xTcdCSlMrOI8+0sgkcPSh2jKaC/5BOtFTxmKFJz?=
 =?us-ascii?Q?rRC0dbbCXzMCUr85D6eYtdRDq0Io24ije0oOMj8+muXCbDV8AVDlu4rEaRJ2?=
 =?us-ascii?Q?ASpRNGJqAGDbyTxIX5TLTtoEezWnxFQkEl5Oz1copotr/BCby8mb2jZR9OPT?=
 =?us-ascii?Q?8/TBdHEt5042cyVLykkUP7OHnYWam1b5IRZCRzaBxf3qIm8SY+Bko1Gg975s?=
 =?us-ascii?Q?N3y2dvZ4PtScZAzHuCxpa/z/XX6TaB5b7+HvG/BO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b50ba5-1772-4407-460e-08db56246714
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:44:15.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERDHbxSWMWdbywR7WePd8ahnKt2DbLU9kzyaZ+Ksvfmdkm+PAr/SwVeJvNnHgE51N1bs53wnOXZ+Kk1svVPH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cdns,usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
index c9e65a2facd5..c7281a7c8244 100644
--- a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
@@ -31,6 +31,12 @@ properties:
   "#phy-cells":
     const: 0
 
+  cdns,usb2-disconnect-threshold-microvolt:
+    description: The microvolt threshold value utilized for detecting
+      USB disconnection event.
+    enum: [575, 610, 645]
+    default: 575
+
 required:
   - compatible
   - reg
-- 
2.34.1

