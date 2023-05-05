Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D306F7FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjEEJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjEEJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:14:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846FA191E7;
        Fri,  5 May 2023 02:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQRERsh9RyKzPAD7nzjHAdO3Q61PaHcr5q5BKdbewkH091hlew6nOJPj/3zWa7tGnOY9dpm67xhwdvjA7Ed9+Q2SoVAB5U1esCUIrJqAARnB4tXYEEMcVF7zoCFRMV2ySeROKF1U3OtFc/syg1uJI+ZajwEjJLGhWnC5S7I6Abl/+qGvW+2Y3a6LcyK5ffW1/nueLIOVTCVB5jCkrzCDlZjo6ne2w9NhG7myhBEWPcLYTm6Xv+KqhJOCU6xOw4w38t48rEw/9PVFdAqTuoc9+xPuxlXyB3bzZcKwHXBvYCRM5364N/HuyVC4pqXnBMeVsqDDfc7bv0QjKdLNEJkbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAY1lPqAFzpk4yEKZvQTsAandTTbpMyksnkYJSz9c0o=;
 b=A5YXQTgEiV9arWu+oJeT/Sm6qURxKnkcV1kO2/IpFcOZZBatE5+1YiEGcxSLC5F8BJeS3dbYswxvJOIUNHDLtrx6rT+nIxsjI5k5rp6r1T3bb/DzsVleDHtS1DfJv3nFgtGM+eepe7sHyUOz+ksb2htZRS64PKSEzMgJw1h3tS3Rta77Kf7ISSiN41JhwJSYSiKAUtf6iBuwXrwrlQ/8xEb2Q0m5fWNqHiVhYaKu2qsFiUg+ByUBoKW78d6Nve4POKcumDS3/RfSchpB3eKc14hCVspAc7qPUFHSfv5QE0nuR5BpyO010iBDU0+mj9c8jVTMHUGCsOOTaywMNXUvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAY1lPqAFzpk4yEKZvQTsAandTTbpMyksnkYJSz9c0o=;
 b=hchZJ6SH1Z9W6c/jxwHvg5u1RPEfgWrmOR1MrMENHiAE7lOaYA88FH7K2eI3VVJIb8AuPYYhAHh1JtdH/7AOC48sGXDoNO+y0Qc6JHmKQoBRjXk+ba8Lprx929p8XXg+3Mv8nQjjUUFPGaQRNkZhVOg/F8UdaFlnZfwPQft9pE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Fri, 5 May
 2023 09:14:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 09:14:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: nvmem: add nvmem-cell-cells property
Date:   Fri,  5 May 2023 17:19:06 +0800
Message-Id: <20230505091906.1820081-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d0360f-7e49-48e0-f8e3-08db4d49140a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1/9YYKgXouD4AwcybyC1yzPoT50mS3WJ2myR7s3vFLb/t/6tApjRNA8MwNCIlE+9vL/XyHm35WRqfF5uGGYRpjAW2Y95q0cG/rtVwuQI7zR3fx9Y1js4EUz+UBDgcuFsmcF5Pe5URiHaYzjio60I8ufs6bgaUqqMR2bf7f7uT494XMyE4bfRLX5359ZnKb+BG/7qTfAOngXktZBY/Wptdth43wwy1TG+2Z4Uk/ohXjmJu7dk7/9KigePZBn4iEradoL70BB6SjEhVbdHxUc3x3WLPULJZCYn9zEl8FtMUMMMg6jxXQ1gKaBfDfY2nPrTMTJg9fHRGTdMuOG7k62KFL5mPKyQ5apx+C3AIYgL9X5dE0tti331VawsP3+N9lhAbletBogGVBLvGCsBiTvt5Xk9v+Laqsrxm+P1D+GBPMZ7q+cyPVEo1f+nB34949DlhIrnzsC+aqp+Cg4O4lHyC3opzYm6b71Kj4zdU6AZJugEmtvR+jZdjJqaXe+6TWvXQ69MSLfpB3IvSDP/mQnscAzDiePUQ5qMdX4vZOAGvTlqpaZbOJB35aiSf8I/u7zDkjW5jNm7u/qX+QxIw3bD06jaJz1hawebu10nAlLch2nyqb2wZqaNm8mjv43GGzS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(66946007)(2616005)(478600001)(6486002)(52116002)(66476007)(316002)(4326008)(66556008)(26005)(186003)(6506007)(6512007)(1076003)(8936002)(8676002)(5660300002)(38350700002)(4744005)(38100700002)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlzgSpOfeiDYSTm3NkXGZ3lZaoX9eimW6aTJBL1oGkHg7ZF4HVSP4mvqW31D?=
 =?us-ascii?Q?MibITMkx0Vowhng7fYSAv78qtM4yNuEs8yEHhdZsLbyQKGCPt9dWAh1S5TFb?=
 =?us-ascii?Q?+qS6c6A1VgsVEB05v04gU1pXF3zYP/MAZzSrwFH16Tw0i3fhB1nK/scJNjKW?=
 =?us-ascii?Q?z5MEda3tA2PJ1RN6MDyfq4uGJtHA/5A0u/mUQfiLEE1CiNbUvRNuyDXDVmw+?=
 =?us-ascii?Q?gg9yNk8kaBFm5/3w18iGMWeMLX2uOLmmiLMA2rXqNo1ge58o5uTYnW/ah5e9?=
 =?us-ascii?Q?vIMDWoGp741Vl5/SoQLq2WZrRlTyO4EH3rvY6aK5NRFs+p6fE5s0UyVSKvlF?=
 =?us-ascii?Q?YsoUVSC9tMmS6fTIv4469p9cO7Z454IOAbgSVbe4Cc65PbblJohsqlnievCn?=
 =?us-ascii?Q?LWf7iSHedzfDzVL2I35sogdhnfIgJW64OmKyENzPioTkLIsZw8P7MwQP5ueN?=
 =?us-ascii?Q?t42IXtEflRkY3D9csO8rNNMw4bvGg+clXBEbmDneOwts8R0nHPQiBxnBwm15?=
 =?us-ascii?Q?VOH1ma+HLEhB46HnhzVVzcYkvsmRCqKTh3eU073MlD/utvxUCOlfHLFHA/0V?=
 =?us-ascii?Q?2HCIWTsXl7H3JJVA+M+/EXRJwLGuBDW8bvv3y/UCz1GpUbhSZBApIH4aZxho?=
 =?us-ascii?Q?f3do+HOMy5ZnXBFl7QvwURzF4/knIVnPB4wXxhedbnlC2AVPQfY6S7tCvlGB?=
 =?us-ascii?Q?hQOnv/Eqpz3NjUNHRCQTpyqhw1K3smNtB+LXRBF1CvDg/90Io9lUUKxnY3kB?=
 =?us-ascii?Q?JdolbMoI4Mgr7RGzqtLiHm+UO/fag3fXxkUV4AixYgdCEm+pEl9DhJ4csMLg?=
 =?us-ascii?Q?M7CcwoEXtcBxpqpM5zObjZWXA3eJsl82DOx4w5p8dmTEgz3AkO4x155XRdm1?=
 =?us-ascii?Q?MAGF8dAmSQd66x5D7SIYo9ExtSHKFFGmJFXNcQYdN8ZX2xjEePuFUANDgciG?=
 =?us-ascii?Q?y3zqJaRRYRxN+d0UVMHHgihYMp9azdqRe7z8inSQEkOyK35CPrMQ1/lNmaPn?=
 =?us-ascii?Q?XAeRYtcb9+WLJhj6wFqXfRGemLPIUshZZjq5ArrSroMCOriGyC9C03aKdQe8?=
 =?us-ascii?Q?CxV89CEhDTLacgVEshcYt0Y0fdctP8Mpqy40mM59FHxqxa+VdUQuDNVvXEPp?=
 =?us-ascii?Q?Qs73Bx3Kb7KXAH5TZAEZLqZfeKfZbL2X0HEZY247HjI811T+e4ue2fo89DTB?=
 =?us-ascii?Q?Z+vFSPnWM36pmCu/q9rpR5qoLGonMLQtNgwU8kt8JPr69qfCALfeqE98m6hn?=
 =?us-ascii?Q?psaqdWKtBJCbf5yPfLWEhQ6gGpVwPW03zZNydWcP+qV1iq+GS+JVcsAxp9fd?=
 =?us-ascii?Q?rxJcg2Y6bWITOxHH0F2IDd0hxRmUe1crLELGn9PqbsATfX6h0Z62jCSTAfKc?=
 =?us-ascii?Q?Y+yqqMfiNa52N849QI2nZw1FH9SQW41UiK7Njapb4Xn72ZBywzNqDbf53uop?=
 =?us-ascii?Q?MG7x8KuBhWVcrOIGrkGVFK89zfE9JsDJKCl1TJwF7Q6Mrgz/WdUWa5Cm846J?=
 =?us-ascii?Q?iO46m0g/yyl2pnPlcHscXG6U0USXKGp8szFwf3UyB+MkkXa2Ym6uEuLHc72t?=
 =?us-ascii?Q?nog5IWFL4tVOI8gywymOj4xAhOvXdH4IUNJW/W4c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0360f-7e49-48e0-f8e3-08db4d49140a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:14:07.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9Hr6HoxMYZb9Drnt9kioLLTcuJg5jbmiDmpQEiffXXPFrvsxqVw5PkXi09NelvfAAevsFXwXHvL75SU0Yad/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The driver has been using this property, so add it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 75bb93dda9df..3fc3982da102 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -67,6 +67,9 @@ patternProperties:
             description:
               Size in bit within the address range specified by reg.
 
+      "#nvmem-cell-cells":
+         const: 1
+
 additionalProperties: true
 
 examples:
-- 
2.37.1

