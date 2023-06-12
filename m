Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7289A72C611
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjFLNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjFLNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:35:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813DDE9;
        Mon, 12 Jun 2023 06:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwUgPM8ucJ6Rwpt7b5Im6Zpyi4tJpfAWxHmwLIjPJZD3cVhF08FR1T+fHsKJmtE0dNqoH4PsLIfBs5DK/tWkTpdlz1qCjIVqOampLAVvCAsQWvDGsseqWswRef4btB1VHTCdqs7a5eo585eLRQWbuMgN6OeeoXQ+VGKQ28Lrcq3t3f4vQP6PwQZ5zX3SkqpV6OdnlaAWzUvr7KvpLkunezhEoCIOU9gzbu8lwuIUgciUG5LQH+843wJvuUOGXnmurhCessCRlVWBezL8kiw+TkDlSUa05l/6tn4lQC7Mzl/nW74mGebwWoITotr4qINMCH2v/KDO6wg9juX2GNa/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXY8VQhKkFFOtLbw6Vb87gq/7UAvByz9GX1F+r7VcJk=;
 b=N0V1t/lh/oaQMYxROpl30qg6eIlrjSyfpG32nOf0FN0b61wcIyfVD7YOFsrYpcro+nM3+fNgalaLq+QYoyXYIVCsZwp/d5PceuuozigRWpMkrY6O0gDXzqDFiDcgGGJb7vOFB4PQWCMuw3jArXkwKqCX5T31JDFLtiuYRJudwcLA6b2/1ZuVOYasqfnuj9fk+FRaarIhiNauesMO4d4QfxX2STrQGimHCqQu+Y3tryavrNSkROfUbZX07cb6SQIrpRzIyh7o6/kOn6oliuq2zmzQ/s35Itv20CKNZ81aMe4pQ1cfusa5ZQjbYrG+ZIseCLEXP2LKk7tEbYzhcEvnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXY8VQhKkFFOtLbw6Vb87gq/7UAvByz9GX1F+r7VcJk=;
 b=c3ejRZGbgLllGouUOULdPne0lkP92+fXFzOfrk5kfrx5neY5Bow7ioGCmj80O84zdLaL5j95H/JcL0jS1NWZdyWv6rhULPSQG+hIhVAt3a95tr7BFOFNvTL/EUdyWEXYjbicwmg/2xJr1RPA4Bfr6PuQNGKX1sMTPXkYuubZFTZRtho35Kq/nnH/E/eYxbTP+19Dd+8OEWdp+582qwBSqbX/Pxt7cIyk553DbACOQ1yofCvDtq+G8jhe+mrlxb5aN4Wma+VUPAfdP2WBBONfzJS1b34j2ufnfqQazFm0sKZ5qBtJMcQF7XoLDZ7/13oBeV0TGq67ekugr3Fn2I7ibw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB4177.apcprd06.prod.outlook.com (2603:1096:820:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:35:02 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:35:02 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v3] soc: qcom: pmic: Fix resource leaks in a device_for_each_child_node() loop
Date:   Mon, 12 Jun 2023 21:34:52 +0800
Message-Id: <20230612133452.47315-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:404:42::25) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: ee456492-187e-408c-4380-08db6b49d2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1FYtHTpMcwxR3nd+6IWdRAfuQ8MHG65AvCXvr5TWGIDg8j2/+fBVzNv68JVAwrqC9lYz/HkmPGSuHmftJtdHkKJ6Kb0aKtGHLLzEF/eTbIlVrsn1X+U6N4edWXAtnkw9acffIuDb3pg9/tZQU/tPPZyWKcZjlzWnHxk5cu0faMLyMIXwyakR4Pkeqpvl8V+XoNWBCMzwGnGPCY0VUK6y+EKHMyUSyZbEYLjVIWFqO7davmT2xHy6K8aM2/EbsNGhbD6sGdztC0GhrqrW7G66+EMxICeElw1U1S1Y6ahWaKDsyoC1Pmdg/Ghyoh2BidZwyv2oezFKD1GtWWfKWiin+lWAodkRi2UGUWO0tTAss4jCqSNwgckTjEQwZOMUjCkx3lZHcXZye02uLO9POdSH7/Ors81+mkGAWL1Nhpb+MelKc7FSwICKIrmjneaHcggw5mJFOEcRHUauztHvDM+gMMnU68Qo2SjhSQZXXJ2HgH5p2QyieifUMHIhFpMCyKZ3FkaYopqzN2kaXeragg7DRNMhc1fLMBjqhI6M8LWVk8S6GN2iRASbU+D8fDoZLAK4AttGv2yPVmT0dp/JyBuszPkeXKU/SdWbClCjyxwo8A/k9LltfdGJeEDElLfjwZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(66476007)(478600001)(66556008)(107886003)(66946007)(316002)(110136005)(4326008)(36756003)(86362001)(83380400001)(26005)(6506007)(1076003)(186003)(6666004)(52116002)(2906002)(8936002)(5660300002)(8676002)(41300700001)(6486002)(6512007)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTpY7sKILZ6IQTnGD1gAyjsgt/iOYhWGtxJMag7TRzaDVE5pxOFri8t4Jt55?=
 =?us-ascii?Q?qf58AQwtKzNf5BLHb82RPKZOs9c3boInDhJSud4EBLYvJ4VtQb/BIUlQ75gd?=
 =?us-ascii?Q?pIZHXX2TN2d8tlhgCV8Vnvndk/xAQYgASgfLr+N9Lu1WXB9J40YyewKd5sXG?=
 =?us-ascii?Q?goIOrqQtMB2EL1BvDi3bLqumxMDvVRmOvuwiPyJiyWBuQY3LExLyolzCENdx?=
 =?us-ascii?Q?Uaj1oB85TSVCLZFkQnH1JOxTDsy3+4LFKoEVydkaJMRL5FhIjSd7wqiU/6W+?=
 =?us-ascii?Q?JdovgUIeQgVLebnxgVLpkAChNBvT/Dg38tf86tIMZbkhAKtESJFDoZS/yiMq?=
 =?us-ascii?Q?qC37X+1tXR0Zk0c99tpdcm89+C/0yqkkRRloTDGCJFRqAqiiZH8r3tBqOXLi?=
 =?us-ascii?Q?pLY4Ykpe5TKrwaolbxiFtQqu5Y/PHDzXooZquUNTIL0T38apgtG3YqxMXOou?=
 =?us-ascii?Q?tB5B+TiW0eJ4LpyXwPKat4PUBu51P12JS8NLDYr24H6PJt/+ROWk8T3iCbcF?=
 =?us-ascii?Q?2qvvnMASYWT3sRzhJc2tXtAorhQ2D4r2KlDxcGVnJnjIclMRqmOf6fqLIJul?=
 =?us-ascii?Q?rxOCwt1q5aNLF4yA9PLhxbI4qnjG90zoagVg2G/4TBgkXc6En0Ba+almpGAt?=
 =?us-ascii?Q?kS4xPDi0T0u2fqUaXjt3+mtWnzuZ/99acSw9fKujQaMicWiniwmLMZyMYfy0?=
 =?us-ascii?Q?n7PB4y7z7+eMCfBWmadd9epPIM870xwND1c3Lgj2iS56LXvpKvXerPSR7YTH?=
 =?us-ascii?Q?4fc+NUzS5hXIdL18MQwzov/xpjg50glf787m3DX4GYDGyL9GqXoWymw0Ip8G?=
 =?us-ascii?Q?iZMzI9H750LAy68DBhdDLj6K5rzRpVvma820dZ1P6EaFdzV1goesDW+PqFb/?=
 =?us-ascii?Q?+Z08SW6cEBbs+ZQCOZ1guwsflqifbQJ92XQpXbcMlnKjwKyPAghcnvdAPGu8?=
 =?us-ascii?Q?gPxsoH0qVj3/MuXs/HTngd7H6q6xKB9znG2uGJLYnbxBo22DGnPHitGXeS1i?=
 =?us-ascii?Q?M8wPaqrc+ZHOXHEmKm51iGe1QIwlUwVQ59oa6fRISWv2UJ8KqMyTv+OYl5h+?=
 =?us-ascii?Q?isZbdYHHMnqqyYjZ90hb24IsGnPQcVhagVBCyir6iiqDR/QrzhVHgVB0wtEH?=
 =?us-ascii?Q?9QhEtNTAbpmfxdk1pHZzAxXRQNOTowhirBGBfbQbpL9JLEHyqLEQZhvNjb9B?=
 =?us-ascii?Q?q84aS0GTMDAZbnD+UndXMs+APSu0DLwvk1DKNlCoIFT3o5xwvXmXLfupOro8?=
 =?us-ascii?Q?erGuepk7pi8BCf55Gg4/xUu/7JvgcKFC/hZAYkoIBp+GB0atu4wltU5aeAMV?=
 =?us-ascii?Q?1KqUkyvoS6h1LCYyNjE+syDLdMXpM6bmz8EdO10tI79+BfidmZF+Uldsg7s2?=
 =?us-ascii?Q?+bAa6guBYGIW4tSb0RN7V/45bTcvj0wSaiHGX8DIwnQ+L/J7tjlxR9zbDfoS?=
 =?us-ascii?Q?g6Cd5luSAYQVF6vGqlWcl3q+I0b4qBqbeOw8caaim/TJ4BxG+PrO0ImZope1?=
 =?us-ascii?Q?bhrQqXexktlaolLeaBkwfISjOJ+xttQ4SdnA48PlHWmn8QrWE6JJYwf/5Vsm?=
 =?us-ascii?Q?JXwIj3xVNZivirWUAbMMBRsEW/AubTFjUEkXq7QF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee456492-187e-408c-4380-08db6b49d2b1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:35:02.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HALHv4ZiuGZ2sQEmPpXSulHIfzcFwxhshB746sTYmdnF/OH4v5jQPgkbnZvLCici62jzVrla78BwmBIstLdazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node loop should call fwnode_handle_put()
before return in some error cases, which could avoid resource leaks.

Let's fix this bug in pmic_glink_altmode_probe.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Modified the patch title
2. Modified the commit message to make it easier to understand
   patch's modifications.

 drivers/soc/qcom/pmic_glink_altmode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index df48fbea4b68..a7fc6570fa1e 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -395,7 +395,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			return ret;
+			goto err_node_put;
 		}
 
 		if (port >= ARRAY_SIZE(altmode->ports)) {
@@ -405,7 +405,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		if (altmode->ports[port].altmode) {
 			dev_err(dev, "multiple connector definition for port %u\n", port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_node_put;
 		}
 
 		alt_port = &altmode->ports[port];
@@ -420,33 +421,37 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 
 		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
 		if (ret)
-			return ret;
+			goto err_node_put;
 
 		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
 		alt_port->dp_alt.active = 1;
 
 		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
-		if (IS_ERR(alt_port->typec_mux))
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
+		if (IS_ERR(alt_port->typec_mux)) {
+			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
 					     "failed to acquire mode-switch for port: %d\n",
 					     port);
+			goto err_node_put;
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
 					       alt_port->typec_mux);
 		if (ret)
-			return ret;
+			goto err_node_put;
 
 		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
-		if (IS_ERR(alt_port->typec_switch))
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
+		if (IS_ERR(alt_port->typec_switch)) {
+			ret = dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
 					     "failed to acquire orientation-switch for port: %d\n",
 					     port);
+			goto err_node_put;
+		}
 
 		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
 					       alt_port->typec_switch);
 		if (ret)
-			return ret;
+			goto err_node_put;
 	}
 
 	altmode->client = devm_pmic_glink_register_client(dev,
@@ -455,6 +460,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 							  pmic_glink_altmode_pdr_notify,
 							  altmode);
 	return PTR_ERR_OR_ZERO(altmode->client);
+
+err_node_put:
+	fwnode_handle_put(fwnode);
+	return ret;
 }
 
 static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
-- 
2.39.0

