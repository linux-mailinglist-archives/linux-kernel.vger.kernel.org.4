Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633886589B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiL2Gaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiL2Gag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:30:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C8BCBC;
        Wed, 28 Dec 2022 22:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLvO3XiqudoNj8r/ZyHc0EzzBE8py2dW9EW2I9Cmho+kwD41V3y+KvThu86Vu0UJAxJh6rW/7Bs9bRp7UncF1XyK2KdncdnmdL0PhVm80RpPzppdMkKpQxuGCesFfSm6cH42E/NJq4S15ibwv9yB0oN88b88iWOLZ10/w2zDLn3H0rFS5TlQEuLEd5noWo5W8IEi+hiLRZ9haG9lQ0Ul90DaNhBjKHOzvSctj27GHUj19tCJ4XHwPAsZ5lQAKYfKEhpx4JqeubOoVVdRJ0TDBKlkaZxoG+qllHGpNqZMj+uF45QWEB5//O3jaBWLRPj2mVTjwv0r9lL1FEIe2RIeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/lqA8Q+64wM+MNKa6vk8MLd/5oeOu+M5zYEeDzhxTs=;
 b=TROjN2wOnBVlgjmkM2aTXmITJz7O11ifJf7xZc1x/aWW5ax/pHzu1YP6tBlnpZrZrn74YafX3MoPWiRtOrBLr2lHS4NlrcDaNpapCtylBs+sruw4IPvnYoqbUQGR6SiKCUTL+og/KOP5o6jfhJHtxcskM2ntnTX0Ed56YiVvlHF9AqEOLbK/JBfndCoLkRuDFePW8RmLXwq6Dj3Sz4Ub+Gol4uPsRmo0f6Nkdlils9lvaXQwwayAQaahhSBofPG+4q39AFVYyJOajfNi9sJbOojzFkVG5O5yqKt9euEcPE1eW1Nj5F6SQOXJqCHfngXdsP7NblJcijC9svw80AM6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/lqA8Q+64wM+MNKa6vk8MLd/5oeOu+M5zYEeDzhxTs=;
 b=QEorVnfmd9F/uYU1Qo+ecpSMbeguA2E/tHUz9PrFbPT7+uDjZUI4XoCreZuNa01su9nI18ku08RYvvy3jmH8qnTNrdhiHS2VQzgqGtviieIdRzVhmgl2Dm6NZ7XM9s05bduAFY2UMIGPtMA7GqQSXUEnVMARKahbuphDmqGzxio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 06:30:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 06:30:33 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 1/3] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
Date:   Thu, 29 Dec 2022 14:30:07 +0800
Message-Id: <20221229063009.2396716-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229063009.2396716-1-chancel.liu@nxp.com>
References: <20221229063009.2396716-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2b68a6-451e-466d-596e-08dae9663034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlxiBUfooEMyyYmqbygXi/ryFm2zXs6xlUcwh5i+nJBmYHHUgcO5MXKYtcg60tGxqod70EHGpG3z6yCzQT06zEGIZdMC45bZgsmvl1uUVkrErzvOeYOZOkpDizS24r+k0yBh4EHZMmVVAYDMcb44uOxAwv2XsM0bZhHUng67y6DO+Fqgb1qfQoVK5Gv6xNnNffBraChw2zXzhHZfuApF1zzHL9Yj7UhCZQ8ePiCOtoLV5rZ/6tbV6PC+YBJCsJEl3OufJWRLjo4rnpoo9j5rUWObRKnrmXP0XjqycQFcXF2VV8vaK+fkgL9BlmMzGmnTQKIkpK4g5OZ6gOyerQ0InkpudhGV6PNuGMDUr4zyDI4fJpUnobQ2hQ4QAI51XcuehGlIGV7Hy+mUB1DzeBfE5Uvfz1ay36UJ2nDUQD4gCVxWiXzmsTDQAFpdvngAyVtoNXBsrdWageleX9t6G/i7D/KfK92S08YjpAVQXpyru3AhL2HflYQ7nVWInqTZfpERnWWrqtYK2r9YG2DJE0lWjFhnLY8GaEwQSFGM7CJcjyEryJHYltW1+bD8n3Sz2Li/NU9Y58qoMrk9O6XgDYty5844kfdmhdCp123ZyJ6a3bAZv9srq598q0CRiesHE2j7IqPjkwEo0StzIt4851NL9MflYwIv931FQQ45dQNzQrwqdcpFIUiWA0B7PUjRtAhZ1Hjoq+IIvsMq1qP8E5gWTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(8936002)(4744005)(8676002)(66556008)(66476007)(66946007)(4326008)(44832011)(316002)(2906002)(7416002)(38350700002)(86362001)(6486002)(52116002)(478600001)(36756003)(6666004)(5660300002)(2616005)(38100700002)(6512007)(186003)(26005)(6506007)(921005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zuF2tvRfY+v6IRTvgywiDaion7p2RZqXPKt49YkzXUHxq9q+lgdp/molatdZ?=
 =?us-ascii?Q?SINOEfk0FDzZ01+pe8/7p8rUL15mmTB15xrbf9U07WqCMSo9oPMiUuHIJwXT?=
 =?us-ascii?Q?pMBUV7AY7905M8Dkso7OV5ImNDg3rGHsxHwsnGtsSLJpvK6HWdC3ySYVSf9E?=
 =?us-ascii?Q?UGSMrk+/qOmDZQpsWiLNQTV0xVNTGRCqiXBvx/hEYsSmwzha8uhAJcBEg+/b?=
 =?us-ascii?Q?yZtUxJ9861I4vBW0qC69CfsyO2TTdyNVrs3iSFl+G5LSk23RQzLqBrN6vKV7?=
 =?us-ascii?Q?7DbxtTTtKaxMuZ1XUZAsDNXOSBHRfl/rYqdJ4Amj3xquOvZ7Sze/mZ9ZOqUx?=
 =?us-ascii?Q?wgirB/vobsUie6fs0dmvjo0PsSG97yZHPpTlDrbDHzBbC2Dy8B8USRFSm90S?=
 =?us-ascii?Q?0jRD6rK6yede8o2dbIrZuo04uDu7c7CcElub7o9imOGvid1000Q8pdF57Zse?=
 =?us-ascii?Q?nhNsP3VPfEm+bd4bYbSqx4Z/a2w/mhK9ka+Fq6NelgB2z3tiin0Lbho2AVoc?=
 =?us-ascii?Q?pVYK1kSkMGgcSGpOPpMXNvTaV1v4H6P4IKa0LG65p88wB/01RcHtHrRyxvaG?=
 =?us-ascii?Q?lfK1dNb7OXpSTxDqCd0EAcEvAVV6ZsDhI0Cy7+XofqLsOOmE5RFWU6m8hZm6?=
 =?us-ascii?Q?Vp7Bb9CQrW8v4CFrqHOBrjSth5FUckp1Hgv18PNvF3+4sIp8dfiurUzMBJkH?=
 =?us-ascii?Q?H8e5TyRdPnVGrKLesSrHa56WnlnGncRiehOSF55bVEw/K4bPZA84T5okX49B?=
 =?us-ascii?Q?3ieZgDkLfWjuEEcYi7YF7YtxqE1s9qA1bdjOxhEtoaWe9HBZkm8Xuohwz3WX?=
 =?us-ascii?Q?fvXZQQqLdo4W617mXPlU4Ul7neiQbNXd/F92Ox8kBD60iv3Ra1opeZPZF3zu?=
 =?us-ascii?Q?HxgxsjKfilM/HVVMQF3TgqG6T+B96Q4pz4LpwbuRX51LjFcnqIzrmh9yLk7d?=
 =?us-ascii?Q?H9RVmtRW+0Tc4k2rVUujFrXWcHAUMvaKDgAw1VriGAN1w8UZ8IxsPpeYVd3W?=
 =?us-ascii?Q?GRUbvUpOX52ehrNQWfBmQefZ8Tjpx9Q0Mam6dKBRECBa9kapRCS4Mq8RIvDp?=
 =?us-ascii?Q?rwqEie3IIX04ENwVLltAJBPhIV8Eoa1pQrQScnCvPI099USu+5zyS8CSzAS+?=
 =?us-ascii?Q?8AJp9uFsbKdhUDTrpvolh90y74Ol43aQyMfYvZ307cQB0zUmWY/b3Lj6Jp0Z?=
 =?us-ascii?Q?PHPCiIYJH0NiWl1EijsiWkm/nmlVovOb+s63W94zRbgPFYEgaBrSm4canvQm?=
 =?us-ascii?Q?12dCzE8LVyLpRBwjX8kf2fJdlQQeaZ/c2gv7W3uF6gxFxT75YslTQ36TJ4fs?=
 =?us-ascii?Q?8dBIR/K5DmS/5svVL7qpxz/awjnFtu5zocpN4XOqAsETwH5znPcdE3A2rWrW?=
 =?us-ascii?Q?3oU7RsB2UGL4MzMcIjzXp0uaRBeayDpdlU2GlOVdAXoAbEpKnvmXw7idR4Ps?=
 =?us-ascii?Q?K0hRF3GVBYuX6Th1AmC5U2nX5C26L7dokn2n48Y0ErkQMv21Sa587k/f5Zf4?=
 =?us-ascii?Q?Duxx18Nf4SIUJsPqeXo1shcKstu7KaAjvqHfv5jOriNCGPse8/IsYugaEkkh?=
 =?us-ascii?Q?hTX1IQJN3TdPbbP7cl1cVmEAgy4SyP3bA66++6wv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2b68a6-451e-466d-596e-08dae9663034
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 06:30:33.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VcfrKMzTyFTVgJvhqRn67MBoYg8+j8Eod6ayFfwo8d7BicIm0sK/+Db8rsN2fhmab9kEJkTkvcy2tbG5abioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "fsl,imx93-xcvr" for i.MX93 platform.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
index 223b8ea693dc..799b362ba498 100644
--- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - fsl,imx8mp-xcvr
+      - fsl,imx93-xcvr
 
   reg:
     items:
-- 
2.25.1

