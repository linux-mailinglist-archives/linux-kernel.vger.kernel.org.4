Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5146A6515
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCAByC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCABx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:53:59 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472637B6D;
        Tue, 28 Feb 2023 17:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0cr63iXZwCaxB4DzcMcQFaHEmQ3bw00Ulr6ZIN49wWbBal12yQ0rfUHlACH7VwvOeRSqJrHmfJM4UAOeu4Wg/ourfaSGhaUWan2m5Ef4FSYJFtZwqI/V8HbpZPrzzW77ZfDmn1DsvNZ5UEbfvbWUgrFMMXu5aSJq791/YFrFVy8L6pBmGlJ0kvPa7oqObaiYIeEfi29uXFbrSV/PpGewCh+OdPFZZbk3/oxcofeKg0vME9EC6Ofo5LGP1oVDtIiRy4dLjpsvTyvBGojig/T1oknNGEl1vqYaGslF+yyRuT/Ba7W10XZJORTpoXQsgKMElMNeFFs+zQnv2OrJQzN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jym4EvnACGNSmzPJ1X/gQd6mlIFivlsGIFiOegtOlMA=;
 b=UouTHznYowHf5EZecWGO12Rv7Ry7D9RC/NH+LSimiQrlZd7ZZ70z6ga4FlNTWSkyIRYvVK8FaDUzmpZEqEZ10rgIstrscPN587rQ2NzNaojmhTQ/dDgOIPsrIVSNLIpLjTH/Q5fabVL7FReRo12ba0tYNUoBFEo89atON5gLej5HO5MlHO3M1cNSlgSvV12s6ChLSd8iGrZVQxvqFywV0fU24zxDIlQccxusbXIIujOkTDZBOS9YQMrLSZrEMO9nl1Yx3Xhf/AZNDC6VX3ObH76d+dDnHHxfAuTfVIScsw6YNgj5D4smvHPU1vZW1OtDLa+AheyDZVf0FnLufLrYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jym4EvnACGNSmzPJ1X/gQd6mlIFivlsGIFiOegtOlMA=;
 b=ZeDxlocV3dgPg04L9YpYtYreVk/CcqNFehaUnxwkt27HE9JsNw1JB85ZfG6gX94Cc8GjKkPprKiJZnLwrDzMOEMapFnTqlriYDKOY6D1b39vO++CkuwzHrxKdLbrha8N7IV0DcLLEHuGfTO4SyxRwXz8GZ2xdFJN6MQn3dMblrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x compatible
Date:   Wed,  1 Mar 2023 09:56:59 +0800
Message-Id: <20230301015702.3388458-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52c98d88-7d7c-4e58-1b99-08db19f79b8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCQKaCyvcfwS1zGHFzUO+jedAUNqOq1tgdII7pkF9sW3O/YS2zvBWBeMHqPJhw3lkrIt0GR+w7CFFoVh0/QWeuCqBwdFlMLP6sPtQtKA0lvkufR7dzyfxN9fh4YDrvApUxY0Al9V+lpAyhL9EIYYb935ZfbXclIfxAmFBI9+CrJ8BwZ4Dyaqx4cLotQenFUWWnXQOu6BJnJI9/A7Ey71GWykBHki+L1Yf3cCtMzBpy51ODgbd/b51XUtQq6NYWkH0T+4haKCU8eca7e4zVAOFLy1yKbuHyRfkOugqo7jcSDHYU0cD944PIh098qHYH/YcitLwWW+4lfc48kM1epVLM7q28n1RdN6dZukeyW9zuTO4Tu+XFTRiBjgZI9kmFbjTgQ23VufHFi1GoJJuW5bXUySHwB6bicopwL6t95hVPPPemSAKU6C2KtDUlQp1uZ8Xnb9UDNNqBaU8vTw+2/LRPeIdeeFaKJoTUVM+zlRcA/SPTr3foHnvIbLtRtxpNOgCRLaIcT5tXrlnztyi3is+yQML1KWQcco9QkBvX7wfHTJk2pmEovcG0LG5CfrPk3lAfB4XT9vSx/k1K43AnWfkmDV6UNvPmn6AmYa1wWf/q3zqscwrMA4JVwtFkrk6l3w+PvGuJkzse+CJZOUWLRIJL/u1ETgA7fkJ3nEydNhuL3cyKVDLvHj44M69lhivinybOFtzANlifUvO1mi/6lWFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(4744005)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxh+kF+2tJ5T/ojn6PwjInKwtzHchhNoZSquh8hWxpNnCqHICknV+8TcklLx?=
 =?us-ascii?Q?X8RjyYi6Kgf/EScwpaJ/xXOtY3vdR/aET93BqE2N71P3BniGnjrgtASUpXbj?=
 =?us-ascii?Q?jFP7VxkPLpmIAjYYlhhIcSdzJ/WhXrYl5N2MevXotIN1NBla7on4J7fZWPtl?=
 =?us-ascii?Q?m5wOym4xuhwFUdlSv0oMexyDBGioV/dPms28jDqz8iYncgb8Kc+c2lf5pxWK?=
 =?us-ascii?Q?G3OtvA9gF8MdXQIz13vX9Wv0cxasdRZ4YOogZxOskNp1xoM080B/ZyDFuDLW?=
 =?us-ascii?Q?sBxEhNhSaxDLAeNCgzJ6Q1YkD8zZ9UmBfcJYAHG48xwySYKanl9wDTLy4p+9?=
 =?us-ascii?Q?9uk8uj7iqnnDw+s4cAvMc+1MI0a7mXXYc9Csjc4o9onxVlDHzwHCZdM/t2ys?=
 =?us-ascii?Q?/8HMuQizGY2U3FwhwVdotJig1uKBqKZp34GrQD3Qlv+QJ4KwW5hD0LApyq3/?=
 =?us-ascii?Q?Wzdg1C2p6nX6YbjSJfLWP/pYSkGFtpySF8mBqUQmpuXG4Quk/7YcePLE7LCZ?=
 =?us-ascii?Q?US3eJn8mSCBpJ5RnadGS5fnmj3NEnieUvApA6yAbllJrYWP6OvizuEt+sHay?=
 =?us-ascii?Q?UQR4cc9mcSgl6TGgFFy1OnukcX+J5pL0KAyiW3auzwtWMVeKHHBuRn9mRRY8?=
 =?us-ascii?Q?PXVMhfLYqIjzK44LRFlUt1V+YXc6o3oIWG/ID+rDmkavvrVPYLuzuPn209Z+?=
 =?us-ascii?Q?mH4epvnqEO3j214AsL60PMJoOhJVL+TpTgV8cDyw6KGx75ManEIomoQKJrLU?=
 =?us-ascii?Q?l0+wH4CZ1zqLaSosknl3778BDAKTUHNc4n0Jy8SPr7z9pCSDdMV09PHZMb//?=
 =?us-ascii?Q?GT5fs6oSsjQ3bxvZ4Ljeo6RFVH4gU10OQFWhU5WLtoKK3uHTZqeQstE5kaUd?=
 =?us-ascii?Q?Oed2UVA355l+KXC5haa0K9YLXb2PceBP2D1rrG/cXf0kNz4hdmcfq1d12ff6?=
 =?us-ascii?Q?4Uzp7bfJRqtTRM3upeknMxEeVWaZWB/Y+f8JyjuswlX/o3dU08mz1KZbVfuB?=
 =?us-ascii?Q?BgQaYePxFjgEStLWp11TDzNvtWuAhTvF+VyQisAKddUTjSclrD2hFF41dDl8?=
 =?us-ascii?Q?bfkknSSFJGu8ltaljW9zBSaZiVCWj68qWmze1pfkBql4r1pxMWJGu34OZn8W?=
 =?us-ascii?Q?GxWl9J+cAOhaz4L3/vLqOw/rxpWahaHOrHcqq/cKkfnYZ1b8/P9N4thW+/7r?=
 =?us-ascii?Q?DIY+BnInrFVTXuxO9Mi32twtGXbcIb+k2/KgWAgoh3JD2hegTD90BvObo0mK?=
 =?us-ascii?Q?sBXV0oh3n0yI7Ft0bGQOI9IqynzyOIMtiVrONFyyh57bgr+DEPaP1sPHNDa1?=
 =?us-ascii?Q?D1A186elVhz7tHKsWtGI4xXhb4rJq9CNxaaFk7+vR48Z6Jnwah48mUrN0CEa?=
 =?us-ascii?Q?LuREfoY8KQjJDZt2sdVziQw1ST3Fxfh5AXsFVlHw//MB2IOF264XbO6gmiwF?=
 =?us-ascii?Q?/5Xb5XVgp4zCQL0EzOlU2eO2hzncY1CH5ufabG+mOO10mlRPVSbyggcDIvEs?=
 =?us-ascii?Q?SW3eTI0lCooDaTQdNqXEimsKpk4rtbuWGDf3Fn2vgFo0QfSWXgjEXsND3lFS?=
 =?us-ascii?Q?6swTXJoHMq/W7N3UQ0fBIv9QjQXCJugnCQ+I3k7H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c98d88-7d7c-4e58-1b99-08db19f79b8d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:26.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb6SpP8OjA1CA3bCVR9L2WJMzaICCA+sj0eaXyF5X5keByiBc7jixlMH4Xr+uooHFIHemF+SJRmodOTUWEOTPw==
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

Add fsl sec 5.x compatible, which is used by layerscape SoCs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
index 6878ae8127ec..1a4b4975e1d9 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
@@ -24,6 +24,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: fsl,sec-v5.4-mon
+          - const: fsl,sec-v5.0-mon
+          - const: fsl,sec-v4.0-mon
       - items:
           - const: fsl,sec-v4.0-mon
           - const: syscon
-- 
2.37.1

