Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA6654B94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiLWDI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWDIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:08:55 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFD215F1E;
        Thu, 22 Dec 2022 19:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaaQqDPNABDlptIco+oV0CENsORV31SY4Grau2Z8XamJlQz9JzsQkHgyOCGXRwrMgL4kRH5fGyVkMoOZluDGlRx4wdvoXxm4v/M6DuXK7It2d1R/ppkuWjlHEpaLJX6akGS7QIp72end6xH4dfBkyc+TQeRpX+8hiL/1f0sbDm/4FySu4BjZy9cYdTpV5fhfjC9dyPUkQXi2TdVJ6zwH9zuiJe/7SsOYkRYqhJAEamRHAVBxaDcBjiVaGZKMo+rJEU4B7MsFvGT9gGqMXA5LID2cz7bWpPN+Eto/Eg2CXcXn+zVnZqosgHF8J2Tnk12wmvHulxdHcQeHQmgWGROITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQevHt15V7L4uiPLoNZWnUP2iqKyYfHwkgs42/xyN/Y=;
 b=inul9JlhwpDG1n36Kw2xfiOJkh9vodqOiRPZVhIHI25BLfeMhbUq6/ir1lVHwUuFcIJJyEgPWtiGt0GHsH7QFylYV+ssaovWItOd9HTQDZl/PLywUcEzDvXz5k5r9xEe22sygrQaTEJcVF/f+PZpLH50LzOnpJsDj97CWj0+0gwHHpguu5HCwNjO0+n6Jjz2suAwznPS9sSMoBbRwboQWmus6Fohhhgpgs3GodHWUBZTUQAn+Pby/XZmTpZ2r1Z1wzJPy9H6P5dUHZO1+ocnGo5suJNAFxhBit6V9hRE97NlMJP/wYknXIxGbdQ9ssqeN5KnXe/YPLMsrCh07tmRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQevHt15V7L4uiPLoNZWnUP2iqKyYfHwkgs42/xyN/Y=;
 b=HLRpGkxQZu4sLJfvaw+PI9qElGuJ9rXDi7N+1NZtgx8W8IlZ1o8snIhtk9GqPqVg/evJr1UfMnzWo1S18fZ3kk4weaEbpE0NvzJPUFLjzuU2wIBCfE1Vxmd/ACr0IHWEMjhIcqIYEkUU5pjjxknqpoO6u+9DUyKIEDykY/On7BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 03:08:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:08:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: usb: ci-hdrc-usb2: add i.MX8MM compatible
Date:   Fri, 23 Dec 2022 11:10:11 +0800
Message-Id: <20221223031012.92932-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e6be95-ef89-4629-aa21-08dae4930415
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBGXP1BH57ZDOuELbiGIOqno4KUvAwXy7R26CJCQzZTtYbJxBn6wcKP3H0FkjlW1V9+LBVCW+Cp6cTRphuLeYWWNBa/4uteOXTegfCUtED8i50qxF039iM1Wl3EKXXg6g/U7OE0iIXKfupY4yziMSR3JLowRvMXz/t0X370tLWQ5r0JbmT60tfgIqNeO5+EiSh33n6qqe5dfCEix73sxzXYGs13yofzgL1DlDmMboDld8RX5vLigIopJuLnn+60+70tvaXuBd9d+APQvpchfaV6S2jToBg1DfkeCgTYAOY3RRCNbBu2UxL6tdatxAHwjlDjcfhQTeZZAWFsB6WYxr8IwuAxMHeClWoUliaQDb7VKjuFHB4so3lzIK8r1a881itvTdTCHYftX2LY0r02jL9Kh3tbgslLlEPJ7QBHF+kGMBCFwPVvO+mQXQzbThuGxT9DlFiCLbDYw05EpFzu3CJrzwHQwcXQ8Aj5bEXaVef5QB72mHyC8EYFEu3TjPTD3be4ET1ageL4hHgFTUUe+IWuWpyXKXO6q6rxzXGhDByOPEN41Wfk6WHMZdR/a4N2vu0PUKQi33xnXFgVjmr75DPzy6ijNhovLVIQgXdiaoB/5ANoRCipwZ4msYqZ6mYNvPLvTfFnurDeuJM2BbKRkU2kclxHVlmZ6fwX9HfC2KuThdEHTrFkASK6wU8kgvqTsNzEFvEIPMFYYDETLOQmGjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(8676002)(7416002)(6512007)(66556008)(66476007)(5660300002)(38350700002)(4326008)(66946007)(6506007)(6666004)(52116002)(8936002)(38100700002)(83380400001)(86362001)(316002)(1076003)(2906002)(4744005)(2616005)(41300700001)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTjtyzxKVyHwRGgm0TKXxEAxc2zIQMj80M/so9cXouchn2/EbVHCz3Lbwh92?=
 =?us-ascii?Q?CMqsMnTdgncfopMyBZjjrJnNDzWyps4ppobhngbDmkakqs0HlC8EDlW73cSJ?=
 =?us-ascii?Q?Q0qWSWg6GOdtldT/Vg7HJcBoS5JsDnzwnKt1vU1ph4RdECkchYzRyxa5byK+?=
 =?us-ascii?Q?fnLDxoJnZNdwEOGtqofgefBiR0JfHS1/DvQ1QYPW+DBthDPnwltVUSyO4Z1Z?=
 =?us-ascii?Q?jhbTw0eGD+erApaYjEVzZoB0roTsSC9VOzLrQn4Qy0rXnIAbPSknddUsmWsN?=
 =?us-ascii?Q?Z8Z1tAE6tETyM8scG9j/lRiQSzl2Rf7WnmUzWKLL+ruwl3zB9T/M1meuqIDK?=
 =?us-ascii?Q?5qeOAvGDzNPI/JFY798oiXYeBCoaOiy409fo08gTiA93Nv4vbkQDXIJ5krWq?=
 =?us-ascii?Q?GIBrHgTH3Zw/WW05YcgDY6haWVZMEt7r2wzAU2hPOqqgdklDi5AsW8itxZgc?=
 =?us-ascii?Q?nEWH7T++TtyDxXhdyaKE4JMU1JNHTpPUrAq8ZRuyZWzYcyo1p7JULhp0BVmm?=
 =?us-ascii?Q?Z/OEHFNQ9Skzt16PUXTUPH04VpKIWtufbHHtZakXfFpWHed6usAiLApOnqF3?=
 =?us-ascii?Q?luQsBS+oid4eM+/9uf9e9uWLFJ8qPnkXjuiqEHK4a5pb8OMS+t6rlMjlhoUb?=
 =?us-ascii?Q?0C74KsBBxUiuZNEIIMT4S6xkKP+qFA56NZxV/aHHyPbyg58+LP2x/SUbsiEt?=
 =?us-ascii?Q?uT1X077yxDzBkk+Fpyy74w+uW1V1lYRjuXX4/6iY2l7fh3YsGOY8Il+oT9Ro?=
 =?us-ascii?Q?B1se/FBk4l/qYCgMb2lqp7LDJwSRoo3q0ldxF66cOOT9gx8tKW5JZcrkBbGO?=
 =?us-ascii?Q?0A0mz4daI8e74qCeRCYn/qGhtZZvVa0ZLQo8ukxvXfKBQuFfVVtPWOGUz3/e?=
 =?us-ascii?Q?Z8tRi8LNBgSCXFg3hqyKQ/yuZbWDLLuDFWamwbXL1pH7rLnfmj9Ybrkp6gOH?=
 =?us-ascii?Q?c12sgNPBqTQMuXt2TEJNgyJL2/yDkUeu6L0fyl9k5ZFKKIIkoO3Ynjyhxaa0?=
 =?us-ascii?Q?PSR7Zsdnk2JVORXxXp5bX++Kxdr98uVxRid03rNv3pIOK+InS4jhNDlEBGCg?=
 =?us-ascii?Q?ayCtKS6JCdZ+pVny4NB6FFfyFJ4O0c5ZX66NnUCFmBaFhpLFddbYmKSPajAz?=
 =?us-ascii?Q?L4RoDX+Wo/hEfHvnFVC69Mu55Liao3b3rA3T1Hyi8wxFUCsBssuSybU7g0OV?=
 =?us-ascii?Q?l7Ln3xcLT5mwQdNkTm2ztenOVpBrxSE+tjwKkBa/W7GD/rVRTuZC/tvD4rOu?=
 =?us-ascii?Q?z/qf67KljUH/THb2WIeCcxa2ymdloQpopRO8rZn28rH8HyM93kZrmop8ml83?=
 =?us-ascii?Q?HZypb2tZfdIomSZjatKo6E8SWTkvw8YBLW1d9oSFvCgR8OkI7EtTiLWkzB+D?=
 =?us-ascii?Q?I3oUAFGUqSyLt+qwFe0AWwmI6lDmauozT1LEx1FIcmoh7vAUB154/3/nYCRZ?=
 =?us-ascii?Q?6LJbtUPvVwL03QTjPU9iJJKXl1ows7f4zg3709XRCa0vRSwt6SH+nFEy05sL?=
 =?us-ascii?Q?3B+zC778KNx5kGyjfPpjdQH1VySC8Artxg5MXRc54ENKAGBTAT3s4Tuy7DUR?=
 =?us-ascii?Q?RvUhoGNTmoANLMJAh1Bu1rqK4bbXUEhnKMmM4RCW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e6be95-ef89-4629-aa21-08dae4930415
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:08:50.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oRI/aQuw92fcvmHAGSohi5neJL2a87GqpLXUjAnvtEyP0XGpeh0gl4Z6qhV55N/f3rwhrrLKHDZMhoBSJ5UQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add fsl,imx8mm-usb compatible for i.MX8MM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

I had a V4 patchset to convert the binding to dt schema, but we are in
the process of ARM System-Ready 2.0 certification, directly update
this binding doc is the easiest way for now.

 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index ba51fb1252b9..72ceea575d58 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -11,6 +11,7 @@ Required properties:
 	"fsl,imx6ul-usb"
 	"fsl,imx7d-usb"
 	"fsl,imx7ulp-usb"
+	"fsl,imx8mm-usb"
 	"lsi,zevio-usb"
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
-- 
2.37.1

