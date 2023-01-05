Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBC65E8BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjAEKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjAEKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:18:49 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8333D63;
        Thu,  5 Jan 2023 02:18:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9gNGNNqGi99DDYBHW54tTTb8I45V9ttIaWo0/kw9PqglDtZcoIvfYXouqTdSWHcZ9k9aY98c12WWuFQ0OnDhPyjXZC2DxzJBcM/aJtCBT5rVTlpJzSc75VLE1hxqd7zXu9trqaFGL/fjGpw/gvOu9qYbQmhfbPh+hkYwj8hN5t/jP9XXk7G9/jaUp7/JyJZFD5DjKun92ImQeUiK08hZCl7CQJRv8tFuXMHWQleIgBAfYYlRkkZou61gmnCFt7uqePt47gmGhuHV20J8Wl5OJAPVx1oNnZGmhwjXAkf6udQppIqukfyV2QGSjChUafcaH4a+PzugYEm4uYJHp9qTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlpPpNYvPVCjP2c7H64FoabqZdh+z3HL3BQL1ylLrVI=;
 b=Z+i1TvFXhaFnYjDuos5YzP8rQjAXpSCqpJ768hWsskSabAOyeDRJF3p5TPCvAlhpEKRM9Ca3WjKMOAVAIoogt0jMwnwG0XL2UKYzTLY09DabvoIcbLrLCim7fRRNZmmepiJulcUoap0hYWNBpgUip+tjvqZZ7pwiSsLqpoweDm7aroItl3Li2bqa5+mryqxk7HClthUiac7WARepggWEnEaefoPyCEkRZePbgnrwekMpc5OcgaEAHX8lOqURvJ+jRl5zUPxuHeAwuAFFJRcNXO+BhLmrAKDq325GBB4Er7JWhar6dEiQ5+pDXjB68/TNQOOwOxi+Y6wHF6w/Ulm82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlpPpNYvPVCjP2c7H64FoabqZdh+z3HL3BQL1ylLrVI=;
 b=Uakkmo5asZJNON3rQLlgBe9oU9ozqCmz9j8XQSkLKneNGYuBbBw2193u1OvfjSIka5F3titsTWjSkFBsl2v8dq7A3Lf/vYSSPNpUoZMngce/GSKXEy8hQQeUoSd8jkTIqLxBfRH3xD4TuHRIsne8+qg+XKuwOifo70B5jCdgvEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:18:44 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:18:44 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 2/4] thermal: qoriq: add i.MX93 TMU support
Date:   Thu,  5 Jan 2023 18:17:46 +0800
Message-Id: <20230105101748.6714-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230105101748.6714-1-alice.guo@oss.nxp.com>
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 661adaa4-0a16-482a-425d-08daef063990
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL39zXp9Y9v6dLc9Ifag92W8NjyEoVFzwYAaKz+vk5iweEonDpfpOD5wdmTbAn4KWI1P9zIx60DeWCbu/OKtWtSremrpzv/r6TQBdu/1Bdzdc4yMxNW2IYB5OEXs/DP8hM3XAUIgwYNBY8/hvttK73BTLRVEY2hql2jQ8sHe1Yz2Pao1vtVrXQgatgoWhKtl4pC7zWX/tAbNzcEVyFXIQ8Ljd7TGcwgGEz7GRYq33RqTHVjnAm9f43fCDhTEAPzD7dRe8opne9UvVxtRqdvcaxBJ6TXxl/CZqN9G4txdjRP2zUjJeNCwQC44RtJoE8exzqYfonlonCZ1CTOKZvhFpVGSOlKIa5NsEaKaDTTUXbNmQ1qu3sjIqJWzSs+GTnpbhvhCeQ3J0pW7il0nFpABokoDh/m8NVAHE7rjkwM/sbaEkIvk8OWxiSjvedG6AYhulti5/zoRFLkrhvrOdAiax0x76Iqe95QiCskDo7zCeaZJZeCn6/i0RgrS/8x1bcDo/qgX8nxlULtqBTO09aP3uwCNGy2JEhilJ0CDW3BtPl70/gmV6Y1haO60vszRIjG91aw36zN807XVJlclzJwocZyFrI6gilXdA1UR+KjKNa6zgAgy2bAmijneXbAlNIvLCZyYZ2quKmt7Mz0vlJFoxpOqdoeqe4Hb4OToNuqMny4btpGkvrHF5lJMLgSvcCJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(2616005)(6506007)(52116002)(186003)(6512007)(86362001)(26005)(316002)(8676002)(1076003)(66946007)(4326008)(66556008)(66476007)(5660300002)(7416002)(41300700001)(478600001)(8936002)(38100700002)(38350700002)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlGZmJMZXpCWXpkV1JXUThta3BWWGkwWVNiWmMwVHBLQkU4UERIekp4SG5X?=
 =?utf-8?B?UllJdFdMdUYzOU00eFc1RUdWclFhTlFPOGIxQ0FEOTlIUm5JNi80MzhrR1Z3?=
 =?utf-8?B?S25tU0xGVzNBdEFYSFpYYUJ4NGpFSERhUkN4dXllUVByWWc1emZCZlhMZWxL?=
 =?utf-8?B?VXJVYzVqMnRrZURPUXNuRlByd2ZiS0Z2ZUZtOFQwd3RwUEhoWEdLaHcvQ2J6?=
 =?utf-8?B?QS8vTzBrbXI0bnFPUml1bnlGRDh1c2tQMmNvTm5oVy9zUmlUL0VyYmpxNVhp?=
 =?utf-8?B?MlFqTGlSc0FIQkNHczN4eUdLNjd5SktjYUxpZmRWR1k1M2c2Yko3MUFPVi9X?=
 =?utf-8?B?OHBRSWZtZCt6bFBvZ2R6dy9KT29oNVJxallVN0daMk5FTG9RNjV6dXRzR29J?=
 =?utf-8?B?ZmhjUyt6NlB6ZnpnNGFpQmd6KzRPR2xoL2xOTEk3NTNRTHNlRnV6MU9yQmxa?=
 =?utf-8?B?RWtXazNrcVFOb251M3RTdmIrcGVGT0dXZ05TOGE1ZU5SRFdxbFVvZUZiZXAr?=
 =?utf-8?B?SjNSeURYaFR5T2lOUTNrVnJsZTN3dnlBZjJPSjlKZ1o1cmx2dTJ5dGVjOEla?=
 =?utf-8?B?ZUJXOHMvWitXd0VMY2d3SUhYZEIxVVNPNU1wSGNQUWxvR0xpWFUwUzdmUkxS?=
 =?utf-8?B?UTJOM3JZa1p2bFJheTBSQ040YVIzQ2pCOG5peHJzNUJIY3JBS3locFpHVTZi?=
 =?utf-8?B?ZElCWGMydjl6RUpndTR4ZG9hNSt2QTEvTmRDNjI1emVKK3VjMElEZUNGN3ha?=
 =?utf-8?B?S1M0a1MxbWkwSDFteFI0RURrWXZRR0xNRXNVcVI0cFQ3WDlIanR5ZGRrajZp?=
 =?utf-8?B?Q0tKRXV0ekNWdXJ1UXdLVGYya1daZytuSURFQW55U1hUd0drK2tza2Vod2J6?=
 =?utf-8?B?RjhaVG45QkNYeUxEbHl5NFR2ditJVWQ1REhrR2tkb2c1UkpUWFRPMjJ3Zndk?=
 =?utf-8?B?eW5pSmwyeUZkRDQ0QUxXSHpmZmZxQ2dUT3FNMzdpVGZJbUtKODVzSHJsazRE?=
 =?utf-8?B?MjdkS3JabnFoRlgwaFprWStqYzRaN3plVno0R1poNHdrVlJlclI0MkRhNVB4?=
 =?utf-8?B?Q1dqK1cvcTA0U1lpdXRYU1NMVmZJOUo1WDRnb1lFRjBXcUI2d2JWY3ZVeGs0?=
 =?utf-8?B?Zmh0RVkvQTBLRW16NFcyQUJSaTFnUXVpNkhWUy9rSUNtZjNRaGRCMTlpbmFp?=
 =?utf-8?B?TUc1VHhNWWl3NmFIRHFxNi9wLzNYQ1lscXVranFkd1d5MnlvVXlJQ2pSRnhE?=
 =?utf-8?B?VDA3R1JINDdaZkQxRTBCT2xFc3RMakFkNys5V0ZRc3VGcjdEVUxhOEJnbWZN?=
 =?utf-8?B?TTVSMHJpZFpkQzlwbThESHZsSWJKcFF5Umw1M2dMZjFIeFFTNis4OVJrQUdm?=
 =?utf-8?B?RG0vVXVtYWRnbGRmYkJ2blJHYmdrQTVpcGErOUNVQlJuV3h5VEl5MDg5Wllo?=
 =?utf-8?B?MkQ3OXJVMUVPUnpPWm5GNHBBU3VTb1QxYk9jb1ZjbkdTYlVwNCtxSHliNEZC?=
 =?utf-8?B?RzdPcnVGLy8reXFPUWxhZFVLWU1BbUtOWmFJRkUveGRpZ0VyeTBOWGNPQzJE?=
 =?utf-8?B?Y1FUbFhlUHZlLzhNSlZETmhSQ2g5OXNSK3I2RVpubUIzQ2syZjk3YitIYU55?=
 =?utf-8?B?ZjNVZGZKVmNEb0dlUE1LMTVvUXFZQzVMWU1ORnRIbHhQL2hKSDZZc3Facngr?=
 =?utf-8?B?dEtXb0padjg1VzRpcXUxMFUxV28zYnJxeGJPM1pXQXo2Z2J6SmFQNXhVL1RR?=
 =?utf-8?B?RnNXdlFqWjA3cDg5cmllWURhV1Fxck5TMDF5NjhMUG5HSFJzQ0lwM2cwLzdN?=
 =?utf-8?B?UVNhaHVOZk5oM1ZhM2RKQWV5Z0dITlM0d2l3ZzhzM0hQd0J4dFRnc0d2RHE3?=
 =?utf-8?B?S21KZnNHa3d0TGVlaFpob0orMlBKMHoyOXhKWW1CemhseEF1UnB4Y3lVcXR4?=
 =?utf-8?B?d1Bmd29KOHdDL3lDckIyWTFveG9GOGZaNmVKcHNKazk3QUdQOFpGVzNNaXBY?=
 =?utf-8?B?dzVqNmdnei95b3VEQk0vemJCK0VKWnJsbjNwa1Q2WjQwMXg5UmRETWxaQWtP?=
 =?utf-8?B?TmN6SlJJRDQvbEEwOEkxOUtxL3RIRUNqRWFCbzVUY1dFcnV5aVdxaTBCU0JZ?=
 =?utf-8?Q?XmWzL4RRzRW5NuwsOROsKWFtp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661adaa4-0a16-482a-425d-08daef063990
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:18:44.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXWQ/NTVbO35Aw1YWAKdxJ1Z1URcUTWG6Wg3/sP6Wc4lEsN0Sl7fRC3TdPAT7i+UsVsbtsEUJO2N9cFn86b71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

The procedure to program the calibration table of i.MX93 TMU:
1. disable monitoring mode
2. configure TCMCFG
3. write TTCFGR with TTCFGR[CAL_PT] = n
4. write TSCFGR with the sensor value of the calibration point n
5. write TTRCRn associated with the calibration point n
Need to repeat steps 3—5 for all calibration points from the calibration
table provided by the TMU device node.

When TRITSR[V] = 1 and TRITSR[TP5] = 1, need to add 0.5K to
TRITSR[TEMP].

IPBRR0s of lx2160ardb, lx2162aqds and i.MX93 have the same value
0x01900201 so that use the compatible to determine whether the current
TMU belongs to i.MX93 or not.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 56 ++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d111e218f362..18030bd68687 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -24,9 +24,11 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55010c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
+#define TMU_VER93		0x3
 
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
@@ -52,6 +54,7 @@
 					    * Site Register
 					    */
 #define TRITSR_V	BIT(31)
+#define TRITSR_TP5	BIT(9)
 #define REGS_V2_TMSAR(n)	(0x304 + 16 * (n))	/* TMU monitoring
 						* site adjustment register
 						*/
@@ -114,10 +117,16 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
-	if (qdata->ver == TMU_VER1)
+	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
-	else
+	} else if (qdata->ver == TMU_VER93) {
+		if (val & TRITSR_TP5)
+			*temp = milli_kelvin_to_millicelsius((val & GENMASK(8, 0)) * MILLIDEGREE_PER_DEGREE + 500);
+		else
+			*temp = kelvin_to_millicelsius(val & GENMASK(8, 0));
+	} else {
 		*temp = kelvin_to_millicelsius(val & GENMASK(8, 0));
+	}
 
 	return 0;
 }
@@ -207,6 +216,33 @@ static int qoriq_tmu_calibration(struct device *dev,
 	return 0;
 }
 
+static int imx93_tmu_calibration(struct device *dev,
+				 struct qoriq_tmu_data *data)
+{
+	const u32 *calibration = NULL;
+	u32 cal_pt = 0;
+	u32 val = 0;
+	unsigned int len = 0;
+	unsigned int i = 0;
+
+	calibration = of_get_property(dev->of_node, "fsl,tmu-calibration", &len);
+	if (calibration == NULL || len / 8 > 16 || len % 8) {
+		dev_err(dev, "invalid tmu calibration\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < len; i += 0x8, calibration += 2) {
+		cal_pt = i / 8;
+		regmap_write(data->regmap, REGS_TTCFGR, cal_pt);
+		val = of_read_number(calibration, 1);
+		regmap_write(data->regmap, REGS_TSCFGR, val);
+		val = of_read_number(calibration + 1, 1);
+		regmap_write(data->regmap, REGS_TTRnCR(cal_pt), val);
+	}
+
+	return 0;
+}
+
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
 	int i;
@@ -218,6 +254,11 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 
 	if (data->ver == TMU_VER1) {
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
+	} else if (data->ver == TMU_VER93) {
+		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
+		for (i = 0; i < SITES_MAX; i++)
+			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
@@ -231,7 +272,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 
 static const struct regmap_range qoriq_yes_ranges[] = {
 	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
-	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
+	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(15)),
 	regmap_reg_range(REGS_V2_TEUMR(0), REGS_V2_TEUMR(2)),
 	regmap_reg_range(REGS_V2_TMSAR(0), REGS_V2_TMSAR(15)),
 	regmap_reg_range(REGS_IPBRR(0), REGS_IPBRR(1)),
@@ -319,9 +360,15 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	}
 	data->ver = (ver >> 8) & 0xff;
 
+	if (of_find_compatible_node(NULL, NULL, "fsl,imx93-tmu"))
+		data->ver = TMU_VER93;
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
+	if (data->ver == TMU_VER93)
+		ret = imx93_tmu_calibration(dev, data);
+	else
+		ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		return ret;
 
@@ -369,6 +416,7 @@ static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
 	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,imx93-tmu", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
-- 
2.17.1

