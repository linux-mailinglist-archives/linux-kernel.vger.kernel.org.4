Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712137047E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjEPIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjEPIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:33:20 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005E5257;
        Tue, 16 May 2023 01:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPQ9dY8uo+x7nMNkLt2wERn5lU+ZE08YQyKfrxKoVLVVcLM8DeEJtVrtqFWRp7BUxL2T4uP4FEZnF6pv1ITyzL8fzMW+fSTOcKvon0AVMbCeahroScPuIy5EXBJ38zegoULmMvGNuC6vKEHUAYT9SBJDiqerIokFe67akspV0WCbi4n1j5XDuDrdupHRC9YJEt+mt6uPupQ/9tPGydoTNSBuJATgW3OmuOgAOUBMvy4W050RlM+TMbJIxuT6n5I9MXivn+51XaluAzrdA39mC9VERc9UoDlF1pV0NaUN4l0xRuFHPE9twrnQ2u7WUj6qIOs12ZPztvh3WRnW4n64oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXmpYfYENdTQaHXkt3X7QJd0fUYmUEb3poP++8q5lfw=;
 b=lpCStfQD/L41hllDtPri7bfAn5SKOgZh5rxs40CcymT/NN2mbneniCYfKAPztBk2AMtcGP8lq/xQkfrdmIrOb98HYAR4cdApMQfQTlAG1cHhlM1q3V2uYmiKk/erEwn8ZRwd+B0m7EwJfaGz5dWmkI5QkmHi7gTGQGc+EfZRwDzWcmPQFg75t3J7UMGwXCFedi+zMVA4MBA7gDCdv07HlSwtQ4I2PLCc6YEyQkNl7m3LQcGxMqz7qFyqDGM4EiOr5v8eI+uboWzuipG4OmxSOGjsIe1jDIJf5GEMd1MJbUoFohNs7oH+hBxGlIMWGtfyxN/3i+T1EQqdVZ4hGsbHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXmpYfYENdTQaHXkt3X7QJd0fUYmUEb3poP++8q5lfw=;
 b=bgq+e2Sj42qazbvv/9bQhFf17kwJUr+smXqHDQSro2GqdDGr2Mdyh2+jF3oMwHYnb3uKKgOHXQAq8/iKcZZMpCrg8aMjWTXYmHW5s3OszMQLLEv2ZBY3Pq8EsVTvWg2a8rWvq+kyQW9HQ1XFYLDQWodb+XsiEf5SgikqeivCZD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:33:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:33:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] thermal: qoriq: support version 2.1
Date:   Tue, 16 May 2023 16:37:46 +0800
Message-Id: <20230516083746.63436-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230516083746.63436-1-peng.fan@oss.nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b06c07-b0eb-4b27-8024-08db55e82ec1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJVN3aduUd3UaCD+vMwGr2PV4jEwl7Fpx9Z1CBW812M3V3fZPbdQaTnXk7RYab0AuhZfhpBWnYqSVcwSWMird2nt9ZjTb0wWSby/v8eNBL8Dc6B16jCL3eC+7piEwTmIQD0vy6juyEXsGY1aQ9joJEHraBzmuDHPRuBhECWadO4qW+Uu9ONtw32wsO3GdOR6w7Fxb4aH3MplnNrPKw0L7CDJS/eHGYz9Sd2BMDh9uyJyqIEJNtRT2MGH6T6KxlIRTlqiBk0nxikEGPPB4h0uVtI+OsYL/RHEHA/CgLAtmUNgJbIxuXYNpyD/C3seE2B+uCZnjZzzerCqMBO6rffqrAQl4DJ8pNaopKVVCFPeEftqFK5WmrEEkAmAMhvLqco0faZydDc2Hzt6bVbw778re/U816cf+SFFgBumvdBkBS3JsVBs/y8274Vf/vUF8U79p5OKvV+ilDerOlVplsi4nLD7yVOaNTOBoj2BE7VmkfCcHSeWZuyfIfUQ44qOjO0IIzmzasq4olNhVp1pYwzMJrEcMa72pH2ux3rRf6FKhkGq6KGKbxrmp9f1S6ph3oKkQ2CQqsvhwOxxvBWL2c8T0G+cNbyWd7wmcYK2soQTIHaO+bkE3aY71ItkHhkGb+Ew
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(52116002)(66556008)(66476007)(66946007)(478600001)(4326008)(316002)(86362001)(83380400001)(6506007)(6512007)(1076003)(2616005)(186003)(26005)(6486002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSjUQhVkLhLvubiYrkWPO+M09EEjOVz6oJuZiFcVWi45RF0ZaQvEY0hzCFfR?=
 =?us-ascii?Q?/F/dvkbUEJB5hAmtYIYaINxoZXOFUfNv8CoOb8kdS1vc1gR4cZ9EMHjZm9Nc?=
 =?us-ascii?Q?smcJli5zS6oS5Z5lLXBCgLPcPcwRnQ1KYbT4UpAWMGIhGQHG/xi/aqI14u33?=
 =?us-ascii?Q?i36c+wbsUSnNM2cRbVzzBLxOT3ge8PSPdSHPpu7bFYXYqN4mYC3MVLsMmupz?=
 =?us-ascii?Q?t047Tgaa0Jg+NS0Sjb0ge/G9YGGUlks3TBn2l+LF+rBmIRscM6nc7NMbVIcP?=
 =?us-ascii?Q?9+jUha/zy6SMo5Awg0imsjsjE2GW3wVp6YApX2BEBYNUi5darbH0PggY0Das?=
 =?us-ascii?Q?DB+F3+Pr3ZSJks/ee0Y8Dw3dYfwtO3rQhui2fuWPsqEeSkaGqbjByVLtzidD?=
 =?us-ascii?Q?2sX7fEjbTdbGuhFh7Aio8piycc7x4bhu6+dLeJtJpr/OxLbZ4hYKTcdal1f2?=
 =?us-ascii?Q?uis7kqcsY6bCo7tH4zw5SbdNLoJ8i7PkgzIgkUTtHfrl/m1Pro9okeLanhN/?=
 =?us-ascii?Q?wgH1oEjgO5ed8p8Zwg0i4Fb6P2l2I79THAcE7St4+/062IEnhmhDqsEPwJ4r?=
 =?us-ascii?Q?fhsdEMYHOipGNsEbrWV/g0sSlu0eXEBH3kwh0OIIqi5VLeZoCvKHY9Kn9o++?=
 =?us-ascii?Q?9CVaDu0Of6C5/6Ah/8+CejXPd0VlG1583z9RrNlKGBhYUE3gxsBlQiLokbvO?=
 =?us-ascii?Q?MSQNU3svxz6ut4iZ+YLzM61FqhAYOnqYSw6XNnI+Pn2qfdYxNfE/Dx4bQgz7?=
 =?us-ascii?Q?epWXCzOo8ewnjlcioBIIp1hIQzS18xG03rU7EMA+oAXKToN4nyseu0QSJlK9?=
 =?us-ascii?Q?Tbpz8CipowFpDQ/Pk5bKCJrRrmlbyA+mXbkfqmI3niB97F8N7QuHhd+03UtE?=
 =?us-ascii?Q?og9O/OW7qqJD1axvcKQfifrMxmAUvMcyoKw/kbufB7GxpQZIRMFEdBglZUXC?=
 =?us-ascii?Q?Hoeu6Ot5hPLJ6rzJPGjGpEHBdgzcrWVELBtBZRik1D93Kke9Uah96XI6Rne7?=
 =?us-ascii?Q?TQIjPTe8aRxP18SDzs9TiI0Hsu4A1nxguWdnUPTppY/9/aSaJj1LH6+1Yp3C?=
 =?us-ascii?Q?G+zVWhfURA0UiZ2/TfbBAsFevTHC5WbsjvWVc9NfjGGkr+Sdk4ARcpUpe/HX?=
 =?us-ascii?Q?j0VFz8DdFxm4fxtu1ogow2lu8XFJco3KCjdCfhQIxLnzJ2RRaAeOfLm4gcg6?=
 =?us-ascii?Q?0CekBqrtVHM5QT1klENTw3GrQZRVgq+dAmH3L/QVK0Zxr1TNnH6lf8p+9ifb?=
 =?us-ascii?Q?nI/oIere+Eyuz6T/1VXkSHRnnL1M10wr/F+mYRlJkjROyVi36iw4ZWEZCmEG?=
 =?us-ascii?Q?rBPErHijYAUiSJU4SnY+0Ch/P4DcTBAHXj/s12PunQm5j6pF0CK7384es6DX?=
 =?us-ascii?Q?GuED7RkNiv1uh6fqY9Dbj9iwtYlOeLfS58EyBmG/fybSxkGKqQUZdd33UHI7?=
 =?us-ascii?Q?aUSkhXczqM6mSLce4g96oxeYp+Cs640/mz/R5vMFtqlRFb+9q4BMlUDor9OP?=
 =?us-ascii?Q?ZUJaZ76cGDJW9Ul0AzXW19Qj9yyjMIP1x9LnNeQkH5EsCtdF7kW65XlMUePx?=
 =?us-ascii?Q?w9/EfJ4bbUZ3Fz+Yda1z8ngzqu0/blVWRifO5Y22?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b06c07-b0eb-4b27-8024-08db55e82ec1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:33:11.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb0ZDV0X3DeKTMlfcRpMNUnbyhbJT6lbUhuAGOQJ79V6jvLaGZSQHSZX2DHlWN8yJEuwzdyXBoJPNJ8GpOraOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7644
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 use TMU version 2.1, which supports:
 - TRITSR_TP5(When this field is 1, you must add 0.5 K to the temperature
   that TEMP reports. For example, if TEMP is 300 K and TP5=1, then the
   final temperature is 300.5 K.)
 - Has 16 TTRCR register: Temperature Range Control (TTRCR0 - TTRCR15)

This patch is to add this support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 53748c4a5be1..c710449b0c50 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -50,6 +50,7 @@
 					    * Site Register
 					    */
 #define TRITSR_V	BIT(31)
+#define TRITSR_TP5	BIT(9)
 #define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
 						* site adjustment register
 						*/
@@ -117,10 +118,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
-	if (qdata->ver == TMU_VER1)
+	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
-	else
-		*temp = kelvin_to_millicelsius(val & GENMASK(8, 0));
+	} else {
+		if (val & TRITSR_TP5)
+			*temp = milli_kelvin_to_millicelsius((val & GENMASK(8, 0)) *
+							     MILLIDEGREE_PER_DEGREE + 500);
+		else
+			*temp = kelvin_to_millicelsius(val & GENMASK(8, 0));
+	}
 
 	return 0;
 }
@@ -234,7 +240,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 
 static const struct regmap_range qoriq_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
-	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
+	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(15)),
 	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
 	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
 	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
-- 
2.37.1

