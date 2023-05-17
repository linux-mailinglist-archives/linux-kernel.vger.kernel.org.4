Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD6706DED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:18:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02610DC67;
        Wed, 17 May 2023 09:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcyKvMF0PryWZIxJJ8qufcw5qvuCUHPJ8g3jMdaf67DRRIFRwpXwiWaxTeMxyeOYRcOcWFPunZLGiqBo6B21urgI/QkkXCqoizkIiTZYfc5qQDLqT+B/LvSnGJ4ZLF9+IbKpKkBnLDKn+O9fslKz9lBJ5QTVQvCdfqVbfSurK/iHTdE6cUMP8VUUw3VNadGxuMsFkxe23pRcbxlYHv2RjCE5qkULhcbsmvSpi29J81RWMFUnH4PQkw5vPao5LVfYH9kVIEvJGtVcLLy40o9QBOMhvzVIgRlN3XmRgITGnTNQha2qvweUgUkr3lL5KDt79uxVvHd30OtPdGEN3C/3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRD3I70Nhgh5KFb8QvDbjFiZdXp5lgtUoKw+8YSgtAs=;
 b=lEgoMX5EeK3kiN80CSLJKSX/Mn3OeLzKyLR7T6hiBghzDVmUOKhQNDdcbJD/UIcatIdE4xKGPqqk7npmXIoXIDjb1c0/Er8e7FfND7VK/4Kxo714R0w/4ZYkHx0UdT7RcELE9r1/bhIYNZTMkADmBiQH/X8u9wUjHrWUY3MpCXh9UErdMI3VWKGbgf1aCVnhCFIBlNr3mFDS0LjRiv7So6Jh7cugZ88/QOTp6X7kIDjtxvZ0Uwhsk0nxWmidtjlvrgymubJNSGD+6AstV/fzifIlg2FQUGCmGj8B0Gt3Pbd1aU/llGzp3ucvket2PKgW9x66JGq5wDOOZKJourveQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRD3I70Nhgh5KFb8QvDbjFiZdXp5lgtUoKw+8YSgtAs=;
 b=lQnDDlGmZm9ZPjDsDs9nResl4gavPxzkntPuvI8THQlgf/wuZIk6zSjjqhs2e4qXSVDhkLqOQxbZgHsCAdQBZRr+julg28tyE3zp6iPpr918+IhcTNSs/z7UyAzQ26J/Gw8Ya0LdcYUoG6OEUFQh62a0Wa5KyJNLRbJ2nUdnn+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 6/6] dt-bindings: phy: cdns,salvo: add property cdns,usb2-disconnect-threshold-microvolt
Date:   Wed, 17 May 2023 12:16:46 -0400
Message-Id: <20230517161646.3418250-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517161646.3418250-1-Frank.Li@nxp.com>
References: <20230517161646.3418250-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: c62beac5-4d9e-4c03-87ff-08db56f235e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7aEbNDrMs2+D6zsdaAtQM/X+D/sO0Dz293ihy96qhVYpk0SNFZkvxmiTGYPQkynMHmESiAsaMiMsR4wp1J6nNvuSLHCIqEy9wZOK0RY0RMNkYbNmx269HXIBitE4MyClIIPVSptExNyjm0VNieouJRRrHhSj1xtXiUs/vG4X4168pwfMJVxzwKVJLMQyRJOjY0aWCud5YHdKVPSwnk/B+OMnHv9yrP7FWTs6hR5ujK/AxSzYxuQqfK6pKS4JczZlAD/pfpzuenTvq5kxYF3JQcba+X/1z0C5eqgastg81ADt4QhJTndSGZBYLecu9PvdZDXPY95vynPxO0GjnaxCZ2IqZJNysj7MQssjgw01dxqr51+xgw/2UEhTahi1qnpItG6LKnwNDVMEElJBdOGEx2oXcm96DllKsGu2TeoqboUNOS7riufD3wPilPpeTOVrDYGfQytMRaMTXIA5vKc1R2DgQKtsVN73u2PsgwEhXQZGwXaqBIXQ+SQua9xOJZxHbHu+YbFoPn7CAuhcaVBQcpoQsAdx7+jiu1x1QeXKoSbQGimA9LrzCTNpJQqd7/92HWbAd62vNWD+eEgEEKUeiLompRaYQufiCt0pFnG+0enPovDJjpG3ddjGHeVO1/o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(4744005)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(83380400001)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwWyqBR7kmsUtMD1IWQnR/oUaADza0Nl18OKY0IvOOW+1Kdl1hkwIa+Z/yHP?=
 =?us-ascii?Q?Nt8ZVgvyDytysS8b3wIUDGhATMgDe4M9rBt0jUQuTCUgvmwCMyO82XG2POTU?=
 =?us-ascii?Q?tA7TtYyy+D3SC7rxHd37PAzslWvx1AbmPRPBOML/BjzRoXo/T/kwTROpi7yT?=
 =?us-ascii?Q?qgaY3ujPqtTguE5365PtGsX7KPy1R+LaMTSmTTRwhQBmierM5COjs+9R5Kko?=
 =?us-ascii?Q?f5cLpUZRqB+XZBE0QUc3hPBtLvlOvst5YqAi+dBCWv8vjJszzus+IH2OLSqB?=
 =?us-ascii?Q?MlXxEr9ssD6TwSmADzQ8zBNv5GIB+xv3rUdJoYpFw504JyAOJpp7OFL34l9U?=
 =?us-ascii?Q?/k3CWcBf7pr5+nskk3wz9tm5UWDkSqH/pGP6BM1czPOOUjhs3LCGk/L6BTbf?=
 =?us-ascii?Q?NepIxXnJfXrMfXrDa8KbRf/8RqJzY0r0XcuLiXV+SCvcWFoabV/nNV/DgD4Y?=
 =?us-ascii?Q?f7CS7C7hBTFYdJBcez8mSGGtOY5i8pufYm24RCg15lSpdrrN+29AlCv/+K70?=
 =?us-ascii?Q?OJ/TsLjwBr0nwNlH6Txrx8Vpp+6D1u/lM1XEK25gcau8kKoZ428aBmGl36Y4?=
 =?us-ascii?Q?pN0ZGedjv9cUbsn5+kg4tRtOt6bSFGzYylyGAnQXwwvPo4K19vcv/F+BGJHF?=
 =?us-ascii?Q?APchvcjux2aeVRPwEoi/oHcbxNx2i8axuJSiYPWy7viNrxPNHD7zi0IWSb7U?=
 =?us-ascii?Q?pivuxhTcXEYpIwhVbtaHlrGrX6EiXdYuEybjnfyX+3YjDTmBI/3Elr8+I+NB?=
 =?us-ascii?Q?d4Ifc9XLNYBc3CU4Q/7khRQxPBYfsc0gJg0RyN7JFx/jw88G4opovfhFRA+e?=
 =?us-ascii?Q?1dJknoN09+kHQ/SjntaOKhijG7UimsRAUltYgXKLlp2JJkGvi4n1cavLvE5/?=
 =?us-ascii?Q?FR6u2a2yOe+Y1amOOACfkGFTnvcC7XqtFFxXihWiGTXis2Fxoui6HGWTy2bq?=
 =?us-ascii?Q?G8ccNUzxb73/e8wWESKT5g+cSgf8de+7vGhuhX7gZT3E0N3Trb9wHni7ECVG?=
 =?us-ascii?Q?J0QKOGinwGUjEBfoZq3fsvsvn8qmT4rVEBF5Y4ZXw0cqa4SO3Hksgb/ft4un?=
 =?us-ascii?Q?5g35t9ickPtT1rwr0gOm80nSSdZt+O9a6VfWlOi2/W0/NwtETJ2g7rlkXL75?=
 =?us-ascii?Q?WbZ3mC3o9TWrN02fHcAnt6IPCMJ2pmIUVTfgqQo6CfdHQossSB2OH6VqH36Z?=
 =?us-ascii?Q?B5BTjb5rs26Lw6qwmpWfJAtRkSL0mRdoIiCTJONm0G04X0uQNy4/nffsGlQJ?=
 =?us-ascii?Q?I9nq1zYTtLRYUbe6hZJE9FkY+54SJ689i7NymGfooIA/RjvomRk3Wo1rTAP2?=
 =?us-ascii?Q?R+RzvlaljfkIfH0nn1r3CjytSrqDLx42+TVU/mAAhuQFpdSvQhsH7WkgDmcl?=
 =?us-ascii?Q?GfbzZ574bcLwED7p/ZTArzxpIyM7g9l7lrZCWXayDhQp/sI1h5VvtYPMX06l?=
 =?us-ascii?Q?wHbxhq2n+ebxcg1LEmaywXgPFeVdXazBvvfEl3a0uRo9qAAT3rnA77e0CSRj?=
 =?us-ascii?Q?3Wz6sxiEg6Mb/LrMVufDVIw+okKmbssRJFRV/kwC9eobzedjguYES6Um2VRB?=
 =?us-ascii?Q?+ssThiTMGFXOmikFruk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62beac5-4d9e-4c03-87ff-08db56f235e4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:29.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMjuGoQ7+3Z3IKPkrubocHUGPLlUG3jxQXw1WxiIbbBZ+oqgityiDrEl27JyFQm7+GwXKfyb+bbQcEoc19558w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
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

