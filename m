Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4E6D0082
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjC3KCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjC3KBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:01:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FD7DBA;
        Thu, 30 Mar 2023 03:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afDUi6k+OTfJ2heCf23QIA5SLoIIq6kbX3V+iVWEAuxCOEQhVUsFqDcmk52VDmAUhXRQIFxKLqJqsQKOGRdi5IKk0KGUqz0pXKj5xIRuv9jLcXjBwpsjCFF+Axby58dvewSFSUh7sTGtKtRO2FWEiqADaFJB19Vi4hgraCr2kC6xQ41uL1y20KGBDKnIdE0W2yaGGAuIbOvY59d+YJxAch25nk3MoEgJ0JrD6d0SbyEL4PJ4+pPfsBY7JLTrVJp0pF1LV7YpFyREvpBdTWayEPBduHEkdShVImQxIsWAVwpCEK/5GZkcxSECdsukOOndxDtE/xdbFcKbvqxcELyfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJyxWdi3lAo+5DH2LbWTVHl/Q4h/duUCVp2hix7lE7o=;
 b=lDbWnm9oTE2Fqydx70xL2dtdqdflOrjUhCXM4obmEsJJ2v6ToRDeuF8ehP1mGJoVo3Rd6TC28xTdNE2rRhQZMea/G5QP8LexLb0F6H1Dx7WlsR4AaNvUnJCqPDmxwcszCl0rcNTEwplHnA/6eGloqj+jlu5N9GC9168bjWLQ2wop3FtV5QITBiSWIK3aaGE+bSWbAUylp8Zd1kgtb9DB9n3VKL2kSiJDpQOCJdMAyftCnrT/QXcLDt6aPq4237wGj2A6Shcqg4oF1ntncA/A/K480ZUQQL4ZjS2RVTyUps/ROaFHFOXZteer9DDJR2d4bTEGjNEkosL+vTmVhuMphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJyxWdi3lAo+5DH2LbWTVHl/Q4h/duUCVp2hix7lE7o=;
 b=OWEiaw79Zw+98bZDmPBXNzcfktztlRNL3M0Qor76mncnQaZnRuxkbZCcKiQQPOxHDBwD4n8xI/iU/6HfAFQlB+wTMFbnQGauMLFz1a4YeXfbRUBvuiQvhO4usi8D3VUIqz70IfnqnONQPqSnHjm/nhKy8CdjBvhLrXOCdyganv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 10:00:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Thu, 30 Mar 2023
 10:00:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
Date:   Thu, 30 Mar 2023 18:05:49 +0800
Message-Id: <20230330100550.2049687-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: ddabee79-8ecd-4670-f01f-08db3105a2ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHxIX3aRHFST7Zhf0wGXgDxu6k7BDhMbVpovFfclL7KhjAhoR2Be262zMbZyXtN6T4UAJHWOL4UnDvpNNs+30RJaDu9R1pnjRYOzP9oAH3LvlHtp/M4qfdJXX0YlN4G+Fm7EbZjdx5sEprf00y0E5Bd/laMxRzEU2c9eIl32njCscPK68Aypya+eAcZcSxpPwA2VDs+PP84o548uOWl1PsS4a+cmEmArAgOm9GFX8ZY93KcQ1pIc+7NyMBu9rGleWSKdOxLgkINgWokaUv8qV01JNhtizTR4q5o7K5TMtAE+LuBxb+ARfSHkzfVnEt45qTCke9fDFXnpBCh/wzwIQKWc1DwJU6ftXeFNRhzVjKR7d/R5U2p40wwZ7sLU+VjZ6+hsiDXehwIB7eMi6PBnyWANVT2nIS+BqtI0y5j90euuwhkwsgcRDUxPKFmVWjuqqFHiFVGF3Dc5esQTOXuth9ZEoMYDHA+xSyyyZ32zGO+Sjw/Pqepyyco+RNVbbd4D6a5CWp2poeQO8cJbfbTqtrcslCdSMhj+Coe3eRqm1B6X4PIOKL+PVzeTcj6wkmY8n9Xfa5YrUAL5npO8BEbZ9/wLGDgym9ZM+WMxHqA9cULmVmtjFTcOgBY4FKGfx8AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(316002)(66556008)(8676002)(66476007)(54906003)(5660300002)(38100700002)(38350700002)(41300700001)(4744005)(66946007)(7416002)(4326008)(8936002)(186003)(2616005)(6506007)(6512007)(83380400001)(6486002)(478600001)(26005)(52116002)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sB0hRN1i4gNjWARHxO9hCZS4ObjYhajTvH7gMhQKWtgEdReZ1vc6gUmflnWp?=
 =?us-ascii?Q?tGz23cJ2IOwZPQobIk+MvZ6j45damb87fePGJgMIgaq9FmX512aqJge9zPdZ?=
 =?us-ascii?Q?ll7zTgP5pNTsRyvN7KR9LgrzYrEepZQAppcDgbh/C/FBswb9RpFL1YXkxlZd?=
 =?us-ascii?Q?mwTonjN4Idm8c1Rb2wOsmN7ia4X9HqbvxYDc8oXunME4gV+W796dfQUNUO8z?=
 =?us-ascii?Q?l+s3rCB65SQRGnPd+r55stjOnxk4/S1iFMdGw/I84RY7iUaCU/MfRNYcOXDV?=
 =?us-ascii?Q?5liUj7/BUKq7UCM86vffbqITvPcZWdLrvPTJfnn8iKNk52AzmDANWe+HhLQt?=
 =?us-ascii?Q?mmPvMpLN4s1Evg+3RXP7PjRrnbILHUv7iT0AO+FqLTBO+uTzCOarkqDQBQa/?=
 =?us-ascii?Q?gxUpii4yxg62/MxdUCcVauzDY+JeSu+q63f8ZpFptfVqnyfjz+R01jwOl6jk?=
 =?us-ascii?Q?mUH3Otx2bQxBiCK1ZcIMawSk7hBT/HvmxPIF6Eqo4d+2SvFTPMRBhLkQnZEX?=
 =?us-ascii?Q?xWdt5TIveEhw/hY257jXMdNyeXCB2Diu8ToUzhCtPxqgRnqD+sPhYX6/pGo7?=
 =?us-ascii?Q?ZNUpUx9MXfvvaRam/UE3BewvgPZte0rZc3P3f/mlaC+egCjw40tGBPlL4Clo?=
 =?us-ascii?Q?Kq+tGgBqitsp6PvPHo+G30QWEXeXIz7XZ/v8rwrRyJ5pS1wrvN4xvFw39vX+?=
 =?us-ascii?Q?xGRIcQWnXU+aVSQ7v861zjWMeyiwLqcVU/KtwaNf119f8sbvESVJZZUFjfwE?=
 =?us-ascii?Q?JhFZpBo4t/Xa5AAhgKXmEmPt0wnWmDPVpGfLJJfs2e7uFMkdsr8TzR2dPry2?=
 =?us-ascii?Q?zKFSajHaJRnuVWbc3D66WRamG4LxPZBDzRtxLAyNVanflanJHMsnl8WRyDYr?=
 =?us-ascii?Q?3rzJSaGijiuANA/VrSKfbHF5NSFZcPzJ2U5VDR5irps78BLAFVmJ2L+AdJOo?=
 =?us-ascii?Q?2cmNT//pyWakW20AChVmHS0MC7n88JpvVlgsf3ouvnIuud3cZzAOrzFfIVzr?=
 =?us-ascii?Q?1n5og//AiweI2BybJKIHLbxaXNjCiZ0e4jCdIbxyEr+Nm9U2jFm85Q/E7aov?=
 =?us-ascii?Q?w/pTGnID7APYqt80BlU0jIlV/Lr6+FhdccyFDj2EVf8YAGXueevx7z2Qjv2W?=
 =?us-ascii?Q?UsUfpd/5aoPtYa4eEQjYXweE4fQLw3UFAL93JqiNMVTgt1XlDSHh1LP31if1?=
 =?us-ascii?Q?vPYCyADTDQC/Yhyj9z46ycxjibQt95TPvzGnbpGzNbbG/Hv9l6bdNR771xOE?=
 =?us-ascii?Q?6JNZgB1eV+Jd+6F3NJD1STvqMdDEnDhSrpm507T4nx4mOsnxh17d3TeHFAtZ?=
 =?us-ascii?Q?T3OvvdsSKVPRa8XhVvsAfVrpVBFidi+tBNy2VvJrGnGbdhFpk89asFybI93O?=
 =?us-ascii?Q?fpleUpP7ZBIRMLWj+e7js8aDv6CDB6iiRbW1OSRNgyZcMvjQuZ5EwtFqNrhl?=
 =?us-ascii?Q?jcariAaxhTioK2j05mE4kQ2w/h65c1vrDehvaPc6SH+4lIOMFELGsHc6vva8?=
 =?us-ascii?Q?AMRwHTUe6akgzLPqCzJ2yefLPLGvX3dqSQlHRAaCC0kX27Ihx3WeMnSgGsWR?=
 =?us-ascii?Q?fGFJ1BltHUAZ6d99rr6WlF3b042/qy7jdPtaZOhg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddabee79-8ecd-4670-f01f-08db3105a2ec
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:00:48.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98uzXF0SHVUy6iVFaDan070REwYQDIrutXcM/Q4YD85Sr3XOTUDeSjnuAg6objkfVgyttNyVeCyy6jR1/ozt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

And bounds for gpio-ranges to address dtbs_error.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V2:
 Enlarge bounds to 32, since it max supports 32 pins
 Add A-b

 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index be56c3faec0f..bb9b40ef3112 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -66,7 +66,10 @@ properties:
 
   gpio-controller: true
   gpio-line-names: true
-  gpio-ranges: true
+
+  gpio-ranges:
+    minItems: 1
+    maxItems: 32
 
   power-domains:
     maxItems: 1
-- 
2.37.1

