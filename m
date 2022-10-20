Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13979605C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJTKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:30:37 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC7A100BE2;
        Thu, 20 Oct 2022 03:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxSjkkYBH6IjRYp0LujJdUEI8CdQN/FerfCgWxjnUTYDr/CdRVS89dajDHgEbgIEZ8unH1PVH4sgJvor5adwl2NUtSMcTVuqJdd8Y9hLgzc1NLwc9BLkSf/H4Lwi1WvC7F+DpNEry9QOs7kHf3uOXSbq2ZFNb7NjBXqWOfvMKH7ogcMTPsZObUWCpSHxaKqqJiQL8f/WV/nxt8+dz47KGYq5sM11gpj1l7RI6drUt1n71gy8UPHi7ewLqCwij8ha+YXAtR8SiXbYtVh/vlL07r2smtvE2q6qwDBc1bWKL2JHwgfW2r+JCTLIlPnQvAtqhyl59DcdpIlvWtiOcnNaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrMa4n55yeYb0XzUda5Aiijj4Hj6Adwv5vuxVGIF3q8=;
 b=OhlAv3Yr/A/mUmjhTMxy7xjvpakH6IgQfg75TxPUmEy7W8JiSMOlesjb8EN6VLWwtJ3qU8MvU2eO4NUgxv5BJCTKl345MioQeg4v62IMXWFMBMDnaigESYFwHFWGtj3d080o2zW526Rur7TsPBmD7ndQjSoFEozI3HAkveKt7pPjHXQ5FTFIUoDcdTU7mZHUzw0GURm4alRjnLOpl4+AOVJ307l+Ej7vlPCkRJ4vix+a5f/G3U+YtDlDdHcd0nTsOHrLJ6/3Lb0869cSOKjuSy4N2TxqdDjomd+8e8SXF6ARy6b139zj5kz7JbHQRmJ7yZo/56dUHRlLITteLURTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrMa4n55yeYb0XzUda5Aiijj4Hj6Adwv5vuxVGIF3q8=;
 b=NVmsoGZEE+YmMJ1kPV4cjabGT2cy4Haxkldp+jWlxd6H+0oE3+3xRdMYEQw9suySMslpyKz9E5jt+n8mpxDdhP52wLWiPecfMjqHnAgtecLZ6uhDjYel2LOWKPLTqM6nV0SeurJv672owwpuhuuFZ9Yfeqj9bdlGzqD6BAHRacs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8060.eurprd04.prod.outlook.com (2603:10a6:10:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:30:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:30:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
Date:   Thu, 20 Oct 2022 18:31:57 +0800
Message-Id: <20221020103158.2273874-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 8678b322-e5e8-46ce-b459-08dab2861e74
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KJwP+hOIaOUN9rum2OOCXPA1PIkfDsKBvMlmTLtEvlB/Lukb4Ylc6CynHEZex70may5EZfOrCfI1T6tQSlzaXBKLk1/9Dk7zmuZiYU82/x/Ag5QsDSNlF56ojaHcGrvg5kZKNBUcVdGWEny+ZOGk+LHCYjkJrJyYUtsVKzwyUhYOuqZ1GYKD0P5a8D3u4LJn1p4M8xAEjfX+XOlz1PtwwgjA8Nd8N0oKuk05s2CDnYotec2QG6kyC9vSy7zalyRWxmlxR9hANWyklUY5xhG48Q6nH3xP+HzOeIL+u6NYf3FJwbSwBnFw5+p933uG4zCZ6oGckJ6C73TSDCHuSW2uAxmy2MWM2HVwO7ai/wuVdKrM6wITNH3K71YpMuq90zUDNWsWHdQ8iBNmWyczBtDEl6uOG1bhZNkSMn+CQHbxfYk89D7VX7UQEwZcT6terzGsDj+v/9s4zY02Avz+MObl/mJlDJuTw7yROF/oIboZ+JUvBlcF7ubeEYPTQSDsubnSsroWPCRZAZ7jPDTwQu+bkV1/a0yI9vUTem3dBTaU3dUoVNyd2TxkmmayErqjNo8SvbUlgly9Eykq/QgHf80jC5GvE7nTzqz8sEcSsw8UuJRXRmVKlCfP6jhkmrujloo1W5n1u0s2X8+r5AzCxVBelJJY+or1eW9rqUEgEUBHEBTGa8t+FuSqkpjABS+JMSZjC32Ff+rrT44rZYI4K+BabxgVip8u+Uo2lUx3Hpv1Vz3WiFoE4jEnj3irKq1d29hfRkVg7kGLuqoA9+JbKCY7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(4744005)(4326008)(66946007)(66556008)(8676002)(86362001)(66476007)(52116002)(6512007)(41300700001)(83380400001)(26005)(6506007)(5660300002)(7416002)(316002)(8936002)(6666004)(2616005)(38100700002)(6486002)(2906002)(38350700002)(186003)(1076003)(478600001)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uT/Qpx2EN7M/GKW6p4BWPAa7WHrRTB4AWgeYei/kd+zaiPx8B3U2WyWlztda?=
 =?us-ascii?Q?e+AWCcPAN1s0gMOGt+eFoxo30nvphyHUYGOKM1p7CWyK9uP4Ft4J/s+AANxM?=
 =?us-ascii?Q?o4+xxy6KRBgrMx1/hX4h+Kkad8kMyGo05TZq2G83iYY2OBd/Mu6D7AKcm3p8?=
 =?us-ascii?Q?anbJA3QJddHPHk7/xWzH5GPoVEtcymZp5tCMSyPU9Md/sWiTmEI7vYMlhHvY?=
 =?us-ascii?Q?Lv8592uH54ve0rQS4zqvHYo3q2psenxyDxCK0mNeX9/mPVApp8GlnT62knCg?=
 =?us-ascii?Q?SSB7ix4o6uxsX+uF2C+uHrIwL8LCfCH7hFocGwPTBRVRlYyWfbCxG4mRZUW9?=
 =?us-ascii?Q?m5ZpfD0DV5bKNQcs/2VDrNAIUgc25X8nOyeAB2NqX2+WrMx0dmNkd14RWFMd?=
 =?us-ascii?Q?QoLOTw2CbnvvZK15GPd6SiczXVP04Vn7BWo19CJl7rJvKur3hGG8i1h1NASS?=
 =?us-ascii?Q?KeIx8RAozaD6jgmnvBXNy/npSY7VKIiblSr9faYE5HPBgF/XeeZ1EGhNXNxx?=
 =?us-ascii?Q?HIkwQGH7Por+KrBZgtF9KkR8Gsmko05fR+g/LB1TMzMiBCL1MiJB5yQjMUvg?=
 =?us-ascii?Q?NDDlYCCjJLRwKd88Gj55S6CWpQlxon3r5zmwGqk1sdPd6f9PXs8P1yw/tV3O?=
 =?us-ascii?Q?z47xqvx8s7tpZlLITqYztwi2dqa6sbYNX9IFNx0Eh3OVJ0r3UUiIFVW6V2bE?=
 =?us-ascii?Q?m3y8fxNbyaZVXj8NhO2ZcuvvhGs2zrE3E82N/I64M1u24Pq99KZCkHzlXblv?=
 =?us-ascii?Q?kQ1y+jKbUXxt44O2w1/o6MeYfJ6zMOQnoTNfUYtyxGnLMTdVf5t6KSQN8vmC?=
 =?us-ascii?Q?bA2SLOaV6nF/dIw1XWUAdL0r+pG1euR7lwfy5H0rLAmvnYfAfRKWQeWfHMCU?=
 =?us-ascii?Q?sAAvVK9NQje6lZjcCt7zQ0c93IO3g6cnYU2a6ROeCZoe146Zj0dRZh9OnPAp?=
 =?us-ascii?Q?CY3lz6+wrGwuvHw9LfRotFrBxvDT44nocfAmHD2qJ60jifK5Dk2/VZUnouhq?=
 =?us-ascii?Q?54yf83e19est4ciSZGce1qAVpKRS51y521X27kmr3slbjW+HP/BeFxnxeVzj?=
 =?us-ascii?Q?G9xO4oKMxs5kM8hU0mCZB8CvgQjKtnBXsFoNFr09f28wk3ZKOrlsNzPLTUYJ?=
 =?us-ascii?Q?XbeeMGO0I7kPeRsnF+18ZrQE++a9LHKSmygRJjaigkeOAf41xvx2epsagRr2?=
 =?us-ascii?Q?shLi3flvTbKUFqq+L3fY0QVeggbzfwSyB1FsN/afbcg1d62SOApEB/TKakf4?=
 =?us-ascii?Q?iHDy0bzsyjh558CbTjYq+gxynrkv+7LsX7Bzf4zsSZ5XPT68S+7ghuix4hDV?=
 =?us-ascii?Q?Mn9e6ymAukwOf8ShMoBCgGut9g7+4yYehl9Hs7UjBx3ehPGGmGxhzNhkpHDN?=
 =?us-ascii?Q?+dCw4tKdZSYGyn8CZejsoMh+/th7Yj1UZsl3mealkGwGKwD47g8/Zg2kqqPn?=
 =?us-ascii?Q?ZHraST8VDsdMVBSQ5IMOmg8yZmkBdnaU1nNy/E3xR1WtyP0XGRw2GtV+eTnn?=
 =?us-ascii?Q?gYQ43fg75XmPDyspPYUeXvSWkc2Im/m8VaPIsGNjVB8e0kWiBqUu/aYlmEeF?=
 =?us-ascii?Q?xBI3HREHvz8fhKW11wEpPqq51XcejaeltN4zLhTX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8678b322-e5e8-46ce-b459-08dab2861e74
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:30:33.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+A1kW8IuI2KGTygB6CVBG+vAfCBHnCX0N1unvqQXV24EnJTOxSm3ap6uC0Ez2rTE9Ac2Vm2PA5C6PZ1vqmasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8060
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP ECSPI is derived from i.MX6UL, so update the binding.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
index 50df1a40bbe3..12cb76711000 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
@@ -22,6 +22,9 @@ properties:
       - const: fsl,imx35-cspi
       - const: fsl,imx51-ecspi
       - const: fsl,imx53-ecspi
+      - items:
+          - const: fsl,imx8mp-ecspi
+          - const: fsl,imx6ul-ecspi
       - items:
           - enum:
               - fsl,imx50-ecspi
@@ -34,7 +37,6 @@ properties:
               - fsl,imx8mq-ecspi
               - fsl,imx8mm-ecspi
               - fsl,imx8mn-ecspi
-              - fsl,imx8mp-ecspi
           - const: fsl,imx51-ecspi
 
   reg:
-- 
2.37.1

