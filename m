Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B75FE75F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJNDKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJNDKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:03 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FDEF585;
        Thu, 13 Oct 2022 20:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB50MSyT0i+30CNKxcP8MVHmQz9gvHA2MyfiIVpsxZOQa/Iaqqas3iK5EQTXCUNPRa5PDB+q1IiwyJttrYZaMsYKfb2M5ygTjHpnjj/0csp9uoPI7epsBvSKN/GHTaImvHKj+JzXmlQOQ1Bn/VEmS0I8pRAGqDEXaIKpiwPLFt7om3kiPHqCCYXJliqvkDcsAbZ09TElGik98ts53GVoElT3h9VzqL8KYbV2nNUcxAvvlh5YHSSN+F+Yq3ecM4Q9ySP2kYo5VloaC2zN5IIbkuWRQEtYorrM1yO7nTEf4yYkNobk96laLGRIMcvh4g64ycoekQAyv0ryuiSXbjo9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=YA8Np9mciBOA30wMFaFIpGcIX30KDDEnYfO7Q0WpJXMj2ibhGemgu0TCX2cQkG2uS97fYonIkqVuTjGvEpWfCW+qxdXxcJT7ITeVyb3JptzqPWo4AX3v+NxPF7SCMcaO0JYDI5tmnMksstTzU/2YoT4AiPGxc1+3H7rREg6LV6//RiOeH276Sr44lEgwFs6+jjCihcYqJ6VoMkld+OCCkKYNpTlGCpwtWz004w1SO+sahb6fXQ5/r07L1edi8UJ8asLVXxAvS5O2r9EJ9lRVKsGMtGirdeuzfE/w1oq+K8ZVXZVqYWU2uyQP42atbkvaK8zZPpABdOWgCsg8Medurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=bbpzJ4GxGv4srGogXdJ7CiXHvVGkz5DBAmQZBxDUUOicdKZTL64IbhQSXQ7H1903nBs5MrehY2JlNZ1jKjLanDUeAHbBkfrFurtcL2uVPzLl6myQWUSiO2Ekk7d2CVkBtrZQ25j1Xn3q655aFenwunS/da3hjUWwZURVfh6uJb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 2/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Fri, 14 Oct 2022 11:10:32 +0800
Message-Id: <20221014031037.1070424-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fac485c-3d80-42af-0989-08daad917b4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9flF/KG2jOhAO4WLPWUoCkcHBaBJaQYxApzxtVp1KuiAuTPXuvY3ko7EOICCGgB4j7L429VVBSm5KuPUbT3c7j/Nz00RMyCSMd0GpVWKkHK/AYDiBEm5A5pwM6f1gaJ1+uON6KjwCbbKB6DTn1ZGooIflesn2nmdgxIv1f6kVVL7AKvTMdpdMK0hUPu9IiW82gT/4vHnuXUxnlCiMaueQO71XgUsA/7p27GGT60KwJ253SjHNpImUSxlt6aEJ42+CAONBlrXhe5aH+3byQMaJeuKi1DlMj+1RxRpWYrnzhKOHkFEed9AJ6tq+yXIzaORDal/QDqwnjo5qEVBsy0yU925sHqYr52OTYqPntR8C9KG1w2GMaQWf400b+ovW0RDGdXvhDhb+xwkqUNjTIytTXGnXSFhSVpBUOR1qa48PJJKm3KuC7n4Y5Ff+ayC0psCH6kJdNPEg5H/8WXdKjF1RkbOhoeQTQ7I+eM12tXJqOyliF1M27AnsqtElpxx7iGo77ft5SugAi2wzg5kkoGWfTwGbp61ppJkq4oynsK2LFLUEguZqPd5o9HjnUJI72wRiOezVjIUr4XcB4BZmR8KxmiOpu2bAj7OgrJ3jnfVNgqGDezX4NMrVhjiGExuFxStgYob1tSbgCi9y6VyPVLZI412DFJGGLLeWnN2FlXH5uVBlg3G5i/p9pGtI+DuFxoFLGfCakOh6rgjAD6IeCA85E4IJV5yayw5BxLpmVxiY8G7fFszgLI44Kg8meYn3qg+kslqm0AWSYENciWAgSRwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(54906003)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCBEGri4AV5gFXGqBGy2zMDOK3GrggV9c8jtBX7vgHkP+buARSM5KEJ8nFjN?=
 =?us-ascii?Q?OCtDoN4vCw1YQo7ROqButTe8UZTPULRCllq5pyHeBErYmrv/hjGBnvdR6tKV?=
 =?us-ascii?Q?u5oHiRA/bzC4wIRQuBBAX5+CEc7vK/1HxPXMdVEwraDykdN097n67R74fHxt?=
 =?us-ascii?Q?mlQBWJwlsz0xcjCCr8zT9F3HYpFzJQRwJalSEN5afCCA3XioJ7/Sj1ulb9/E?=
 =?us-ascii?Q?1cDPTr6OdNNRTVIFGrbIC2tlrkBd6GvUPonij1rqSYu6GumH+6rCQBaoSCyZ?=
 =?us-ascii?Q?BVBEGT3SXooWNlvsMA+MiaoDAU/gSCahxn1t+iAZ6874a9OxSbXAE3lSWcci?=
 =?us-ascii?Q?Cf20dfp7xoK033m1P61SKZZzwta1KJcRnxn3F0I/lobzljAVVc8EPUJGWSSp?=
 =?us-ascii?Q?5nRfvO9aa7XysoMUU1Ja6TWkE8qbiuwHsA6XRPqMmZyd5xDKnTdLaeXk3J/2?=
 =?us-ascii?Q?7mFV1Acqf2XHtppwQ3cNFeBAKvcyD3r64E8DgGNgW65pD5cDjG3FAyj7R2GF?=
 =?us-ascii?Q?4XXmEZhWKk25GD2uEMQecZtoO4VWWFlznFTAhDpQXPcIzYe7nHtkYGyzjNgW?=
 =?us-ascii?Q?7Cy9MHDTPtavfbdJbTWnuRhQdcuTDbyDF3S+NMrN3dxmDQ5sHGu2DQbWIlbZ?=
 =?us-ascii?Q?WQsXzei3Way8+J7mk0njg5GvOgbcvSsLNfm27lQl4UyJGgk2McNjov332wyX?=
 =?us-ascii?Q?VhQELEEgVuko0Q22x8x09qvs1tn/7DeGo+M7cwItwSR0up/0fn4RV5in2GEs?=
 =?us-ascii?Q?wDLwgUxEE3hzs5YBfkoXBZho7zEuzbPEMKlpEohAjKX/8cEb6vk79MZXmwds?=
 =?us-ascii?Q?VHI/UirxDCQMaGwddKRsIXrPqJ6vopAUY2qJ4XzXSK4y8xhPyhTrNrfrpp/a?=
 =?us-ascii?Q?sCOwVvm2kcvE91DSLjRlmpkff+Mbic59e6HBDvQdt7cWg0Imb0QL9zMOS5Wa?=
 =?us-ascii?Q?qDQ3AW8p6p1uJSu2ZlFF79WTsSRpbwTp/PwL9lxfRCTn3aWLZHEkLn4FWs05?=
 =?us-ascii?Q?/AAKla903yc54HUWvMczzA6R84DO8lerIbUx/pO8djgNd3zW++N9WJRFi2Cy?=
 =?us-ascii?Q?AjTCPeKmn1V4oCGYHcRDALfNGsRBDvtC+Im+D+UkuvLeq6WVeiKAY+if16Dy?=
 =?us-ascii?Q?M9d/F7aYZfUziqpQfv4bAenVW6cgO7W/yvx1MGPm8pAICxXywq5yCC2DwfIV?=
 =?us-ascii?Q?/BjsDoSOlfFfx+TcPpv/bl03kTx4giWRaCRJCgkZbnUSk3FhDIGnu1COK+d2?=
 =?us-ascii?Q?D7hyu3PhcN5NsYmU0xcIVWZX/pPrEtmJmHMOHv4rvIKaOthjxq7S+Dtx1Cq8?=
 =?us-ascii?Q?LG9MdJS77T+K78q4dx1fqkTDes3mUjYRTKM3MAO3Xyk7dg22JstWe0csZea7?=
 =?us-ascii?Q?rPzmu51iifgljGF9lTSE7uCpzz56APABlQBq9x74jARTgnu5MvbJpXGHJqUb?=
 =?us-ascii?Q?zS/6wEmq1smf9oDUfaMJ98xY2kakdurk/d4+hGJMkuNx0RjXVX8AjWlYruzc?=
 =?us-ascii?Q?S4I7LqL/IQMEn2I3cSqsyydrmmbw+Kj5HPnA4E4+zXln0zGt0MomRBrt9kDZ?=
 =?us-ascii?Q?Ml2132DOsnC6yef2UMvWxGVgg+2dyQffleYOZs1U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac485c-3d80-42af-0989-08daad917b4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:18.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L88eVMLYfGTGgvFJx7el4Wx46U+LieKz1RtGEuCM06BpyT1UbVoLD8ykl4rgfjaBWyLhapmAHwp0GksPQZ30xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 70322e57b6ff..64e783234e38 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
-- 
2.37.1

