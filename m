Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CBF5E7539
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIWHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiIWHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:52:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37412BD96;
        Fri, 23 Sep 2022 00:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkybmbEGLzYNujEsYDcBi4lbxbEkcNCHcYMcNt5Mhz17ROY2nAcTbclTTSpfXXwRskZ86N9Uq9i5Tr6RQe0iia4tHF3px2Ja+CF2zgBfxtrvGQk36VZPX5Ho4CF7b2+8FtAaMtij2s5H/g0+2++fabVZyggXIkdvG6nyiusBvLMC4ZNNnQyxYAye7qgofz6RuR5qWhxU+GI21WgHR/5y7fdGTbz3rEQqu9KMVxtiMXeHfmV2rdR6DybRz6AoXkdXnGaBV8+x/af3E5zi9Jxhy+u7Daut0GFvHJACWCVfI8c5V93bn+wT7SD1yiV8D3VNwnIAFJAx5Zt8MQDLaPAOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoCtndPmdJeSta3LWlf7Md99ySwZTLm9PZoCjVX0m00=;
 b=gUbbFRp+7C7YKS62XJXaoHO5qhdBH7toMNL/RD+lvk+FiUovGaLVTzgxQ6YFbcki6651+5Tt77ooAgH/3SS1nsS53be39DJicMIi6S/CdiQA8b5NZN9yQhhI1mnX4vokPYJ23YFzUR2+UaHj6HncDB9N2UxV03ZMWhZ3MqrdXoJsg3CLgl2H9SE9/BEhb7PWyXYPXxbIBv40ON8el0YPLr7+xYtJFR993YKrz1i/Q30C5fhLGopT/JuP3d4vBYKDfX0R6BoYLiO9p+XyHKF/pv5qHPSTUu0O20vrTEf6AUBt4FcYweZxhwEP/kL9DzZY+Wfobmm4uiF45ioZu8Dnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoCtndPmdJeSta3LWlf7Md99ySwZTLm9PZoCjVX0m00=;
 b=CcHqVxRes+6zesXTo6RNFEPUkeypno+mANawPhGA0bf7oUQGx5ACV7WWEqzcZ8Y1OUt/B/+UZs8OaKRqtI/t1AWsSqcTttPbfztY+BdTAi+FRxOQN03TXkqiMO5ZIUnIMNwshIu9zEX7i/wEDDJZjCg7v2CCTizfUo1D6qOh/Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:52:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:52:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: power: gpcv2: correct patternProperties
Date:   Fri, 23 Sep 2022 15:54:27 +0800
Message-Id: <20220923075427.985504-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b60d02-8438-4cae-b52d-08da9d389e2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT6iCAx0lfxkdlK+kos4in7Lto0BURMOjWC5K/ptQSRuD9q8/GwqZlo/BL8zujegvy2ifBVE8OdaxFbK3Bp+JdDDRRruwbOwd8Rp6lsKSNkUAB4LgURJ34uHbO2qRiPtX5STRZlOfdB/mmWmnKadAc90cXPnHuC4DQWIpym1sLS1pzUwGtX6jAzdL+kPzNckp0YZTYWG2t8ny2+3OUyW36KQmSLjZBbpPrenmiH/FhoCIfkg8cOxpUyMIjxstFvdrsgAs4VhGc7rsMk1yrDgHqiRZob/5BOzxrL0VgMeI1vuTAEnMkosNg3DosjAS3qnyVqIO1MN4sELnA7kMgrsUpOOK6rDGzf9Xrc2OX9kA8lagkQp7wVoUlYMGJcwTZ7W+zEKi0YeeQCMu8Wp2ZEDgdqNSbB1aCcqkhNvtj6Hsrzwr6DvH8mnW4dh6JhZOBZuG3pc1wkkPJD1/UGILfqvWSo0klSfJryAco0bFmdjUuhYRxKrexUwB9RD+hYHMiQG17dXGIBLY8YVqfKi1h0AAGkjJsJRxlf0XBvWeqy8JmsDuUuEwvdGh4Z1bg9tQOdHGXRC8PPcPwIO+Pnn1L8sidYhHcDAs3/gfEwycW1ZqGuJ9d42P8UiB2LEo4hc4HM9zGeIX9Gw2u5ckwnpqRCI1FuGrEraxTl5/AkUS9lf7i5ohGJnZ6ETVUjdfwfmadB7MgRYb+camkz7rq54qrUzabHf0rKqUS7lU4Tp3BlYBGMvtqQXsXpxHDivxj5OmT63tF2mWuvdYbnhwJp1SwKp2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(6666004)(6506007)(41300700001)(52116002)(1076003)(186003)(2616005)(66476007)(86362001)(66556008)(8676002)(4326008)(66946007)(8936002)(5660300002)(6512007)(2906002)(4744005)(7416002)(478600001)(6486002)(38350700002)(38100700002)(83380400001)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzhx2+rEASeF6XY+RpJx+RDg5WkKm/mTKNdZgm0A+W10sJLzrCk6B7l6pLLh?=
 =?us-ascii?Q?l18rXLNsHP6+YN/HzX6xPWqeqFdvA/3oHLEQ5TOw1XtVvWwSayeol7KXtGsp?=
 =?us-ascii?Q?1UPDmI2AmP9qAYoIAsp637sAVhRdTMfAvsKvAQTDXlxCPecz0O4XAYgmfkU5?=
 =?us-ascii?Q?I9svL1ayE5DvbhhtH7i+NDKnkU1GYUyj5PBfo8wPBoSAhsm2/y/8XzMHkxSE?=
 =?us-ascii?Q?FzhOGY5M500y4Ta9nA0yYjQgsEmKqWOyW4M28sIShVCKnttAFuKuPMzSjxgw?=
 =?us-ascii?Q?v8wdxst4wKdJZBtqwIc3gya2sNCZ4AiHLSgKMtceg8Mjn7Tj712hCsahfv6v?=
 =?us-ascii?Q?VATUE1+C6tp52Fk1Y45cRlq6s3Rg7xSlg2w4XkMwspxlFjYWrUozEHa0fdwN?=
 =?us-ascii?Q?+PJibeBtPEg+cuPZZR/duktK86P/1/mkkL/z/6qroLNEcstxHd9vhE7N17UR?=
 =?us-ascii?Q?rqL6I6gTeTKFqcYBTHBm7WjhEeYcLFC4/qx+pyrf3XbMDaoG/5pFh/5XORXu?=
 =?us-ascii?Q?hx46m9rcG/8rXhffGAv+dJq/dR6OG+OaLzk7v0402GOTrTtP8gh8D1oD0ZiQ?=
 =?us-ascii?Q?6dIUix57FEPZTQbCI6YbrNloSuNa54IaU6joQnkarqpnEPs7p16xydDWdBl3?=
 =?us-ascii?Q?HVtHtZBbAZvZoVXkp2ZhIaNPBnhUf4LXmeWprK6ftqMLNqx3ytLSd+8NSgX9?=
 =?us-ascii?Q?xkyTWMsPv49q6Bv5AO06TfWBHiLSw6DPWxLVxm0vCRpdvRvOP1Dya1ap1QYA?=
 =?us-ascii?Q?orXTicQi8d4yg61fRi7nHI1Kra0sFSExV6jibosByVL4xCVoLbWybqLcR9C5?=
 =?us-ascii?Q?3w+r7o0NfBQ+Hbci8XSjyPlm8S0ZeNTJu4GMl65x5nShMPH2HNu68UOnK3jU?=
 =?us-ascii?Q?/kUtmxO4cCCH7yQpufpcELal6DqNxB6fb4qqApDrAHDuBEFuJzE+87xDcayt?=
 =?us-ascii?Q?f2mVmWMOHVWvsyJ9liAv3hfgJz1CsYbAt0gAZyB2f4mR74WXx+ptxB7PSBdW?=
 =?us-ascii?Q?dwcAlkCZ5KOSsGRFE4tXkUg3TlMk3uN2uC9ugAVzVSOdq1TeA98x0I5JWnwt?=
 =?us-ascii?Q?qysAteTF4EF/YV28seuDn/2YIoBqlcxdzKpBilobyPtqLQiGQH+J6+/uFKzu?=
 =?us-ascii?Q?NHM2PXNKjw1Q8C4mPKaUEzNRq0GdhUIDhTgNdtR/852biI9Kd+lTTFzGzUMx?=
 =?us-ascii?Q?oO0djDnFLziovJFSRkNobMy+1NQKnD069HN2zigdjQcKFU8eOIQZVYZ+nKJz?=
 =?us-ascii?Q?084MUz0ASQudfn+DoJrrkkKjHfHvaT36Ku1pCmkAC934kczbaIlvzvSKx/Oh?=
 =?us-ascii?Q?MypzZDRQzFPL3iLhL2A+MIqiRZ09AJBHXCbAqwjM+KTllqARRPSAOn8a9AM4?=
 =?us-ascii?Q?noChKZFdy08KkWZwSM8FbPua9vYdVYbsy1yok4D7tKq/i7Hww2gjbnDGvTlk?=
 =?us-ascii?Q?MUvSmawfaFz8kWSpkUgQKrpICC1m+Iu9eMcTxySEZ14X2pzzj3Qn7DghO053?=
 =?us-ascii?Q?qUKYOkKHiV+sN/1VffXxdVuR0i/SOktSE/WJXPF+Ke+GIFd14ZqFgSeNSD2Q?=
 =?us-ascii?Q?yTzMQz/ReCU+7or658nGHXdYIShtW53UB1lXiPxd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b60d02-8438-4cae-b52d-08da9d389e2f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:52:52.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw8QgB0CE/QNyZvTCVcQCt5wWxsJCMDwXqIKoyMLI3sQJE/eJbFZULRpTEnzb3XbmuqG7PXNPpn18ByFHHBXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MQ has pgc 'power-domain@a', so correct patternProperties

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 3b161e01f920..58022ae7d5dd 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -53,7 +53,7 @@ properties:
         const: 0
 
     patternProperties:
-      "power-domain@[0-9]$":
+      "power-domain@[0-9a-f]+$":
         type: object
         additionalProperties: false
 
-- 
2.37.1

