Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B195717737
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjEaGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjEaGxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:53:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375E183;
        Tue, 30 May 2023 23:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTUlPR3UyP8dbnc25zSvxo1ujugHzslJ8qRVPNmR1WeMVa++CuPjAbLO/ETaQdfLxN/ZmAoEOaqpHr6mbrOyb+mq+csVCThISx3CSdTAGT6zy4KcN2hNrciasUtBCf7aJ33o2fv9O2Hbc2NR5dgYdklKmf7nl/odLSrQKhP//cfr7L91AOyq6qNvrR4T9EEIvPN5WptIhfVpst132oe7voV760DuTS/wLEzGzShMFSvCeEhB3F2+mwrMxp1IbTLFRiK+FTKaCRkh2bURMr3+dH6OxbFCdpOnxch4VsRcsYWsbrK2mYXKNmvP7GydXfXTxZjIdcC6Gq8dCz9swGYMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbeiposDPchdDHX1hgYIIbLynUXmwdHraPh+/lGK5C8=;
 b=Gen8Tu8n5bW3MclsHJ42UGSv6Gq8cnQq8pBd4W4WloHeAgmaCYB94aO5eE6hAX+mc+NujOL7jWVnLsSvk3eToD79dPNq12cC1UXrenVNonoF42xae8lpr8TvMHII0jY0BU/X4xJkKiElWEMQAxmzV8LXdnc5SATy/+F0Wmd11QGDX/I557FYV6+nSp7i2qGc+rIG4f54gX2DGXbnkAqdTXVPaW/OFBlBhCt+vioxEVzlY0VK5K7yuKAII1fxKCc/KLTuy35rsCH5BqvPOeG0TcLTsqxTlVfC0hWJiiYewFAcmmbb+kIa5lAgSnIZhKpBPhJ4RTrO8mb3LOL7YxoMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbeiposDPchdDHX1hgYIIbLynUXmwdHraPh+/lGK5C8=;
 b=fhQV8XxSwvshPxivmarKXolX9E5NhThiK58k3OSPz4gFnmqo1Ccr5807ZxgDSonDSXmHXP0gz7Xt6VUWzBWC4PiqDfChvUEQSnoh16gMVdoyMLpZBYkVJUuR82oV+aJlXozq04mm2QhE751pPorO38Acs9RgWIFKFA19YxQzo4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:53:15 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:53:15 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Date:   Wed, 31 May 2023 14:57:23 +0800
Message-Id: <20230531065724.3671795-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230531065724.3671795-1-joy.zou@nxp.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: f173be87-6516-462b-ff91-08db61a3b54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9PItByObyrLIxGnMjC3zUFDZYvhOMHsugi5/nStok/DQznapQNNVUftR/npxS6gjpX755jhyHdafCod+xWYxBBlp3UVCMNjAjfIKglrI4L/qanpJoy3Gq1zhA6PQ8m7aldrmkAa7kXs/8jrebnIjZXlor5AGAu/UYbkqctsaObeo5xloum4xvRJLlUcOJ1W6QOlhskSEqkSm00bR1zWwC1pSs9x4cQFyUb4XVopEIOe0TVcuKJXWXZxg4tCn0fL7GHRVgsuZ9TPV1AFY/qYxoMmdi7nf29WusBSaX3RPGqDrvlJbqDfBisQyI1Fm+Yk/Wed+IDGuooqBn9kEsEgKcWBfaW32YIRpUQL8n3s8SOqe0Nase7lHbzFKE2aodGGKIUIcGAHWHa4mneLMjTi185rDEmQKLuapJv1zrtUZ17j9IVWj5DJZXwt2l82+XJiTOBKTH/VxOXH2uC167Q7uz5GjEkmiDQLzY36Jo4VIP4bsdmO/B1Bl6dvYqQ6A+stQxoLcyvEGvFy/dXbNA+fcgP1O/bqi3oIIJXuzTUYzuljwCPBWtPAEbUxPE6z82PcNQODb1b5MijTUlLIpxRhfbC1G8P7WABIIJN9dc9Ma85+rBqeyS0QyGxhi/Ojq3qW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(26005)(1076003)(38350700002)(38100700002)(41300700001)(52116002)(6666004)(6486002)(83380400001)(186003)(6512007)(6506007)(2616005)(478600001)(8676002)(4326008)(66476007)(66946007)(316002)(5660300002)(8936002)(86362001)(44832011)(7416002)(30864003)(66556008)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ET9Oh1h4g4TvYrktV8Swcfp5LvCCeFbOYfqfSDOzqglghrmWdmjMDkG1bCWQ?=
 =?us-ascii?Q?qpteTNL+pGxZkhCNINSuRIxZ3d7/0QljdgVI0CQ9v3qCYhPrTV5KQU1fLR7g?=
 =?us-ascii?Q?7LnqozzbdZg6YsVkGC/CAXCFAkcEMKd7sUc/IC72a2SDGzihKm9exJm1+neT?=
 =?us-ascii?Q?sKMLoagXuesuBj1ttWKtZqDhvF/jSIF79s7A5ulpWUAMmdsud7jHXqZLR8ty?=
 =?us-ascii?Q?LxEoqEA6vd+P9SAn9z+PJuqVJl6gXHhU/fn+Tc43F4s/ZnoK3XritZln/SQ9?=
 =?us-ascii?Q?fET8piiANePkPuqJC5zsobAnCjYE4ba3vkjPlXZyauHThF0UatjwzRMlZ+XV?=
 =?us-ascii?Q?CxTuKEGjyz4rmCYnU1SyeuEQZlIDKEKTJPepJViJnD0PrTPWQYjzWjljPkTp?=
 =?us-ascii?Q?l9PVdCgBxKi9KcYAm12+Hp17E6b1SRL1R8lJm8iOaY4x2aBlBgeTqY7jBmWH?=
 =?us-ascii?Q?xDRsls+f0zGgIAYCNYBWKKBTQlQnUvvPPjGJtACX5OnxVqjsR+/uK73Zjxqq?=
 =?us-ascii?Q?ymvYn8a0vte0Wfw8xmM9yEnpkblHsPA75ThFnrPxDGbWJtz/a+jDUsQumKUs?=
 =?us-ascii?Q?RGyTKdPRyw5TE7PaArBsKV4JB/CmxctJCMsdEAKsFaoVOlMk/aB++XVSbte2?=
 =?us-ascii?Q?POID++lIKUi0LpGS0P2qCM8Fl9/e9zJJQkVHC6eHq0i3JuU9A5Mt4l+f5GFq?=
 =?us-ascii?Q?55ZKfJjqWlXl3lsigZK2ZFXerF50SaaaboJAIDc9CJnG6KrTy95dP1aVBZip?=
 =?us-ascii?Q?cLZNBQKLzImeYK0tjG2S13237sIVmcGmWTDBwDKZ0B44Bac53KBJjEyWJz9Q?=
 =?us-ascii?Q?0AZ2juthwycUCaDMr69Bivwkv0SmGd+OeJbI2I2SpwVy6snMC35w+yZmPbcm?=
 =?us-ascii?Q?/cToAELUtH7mw/JbE9ujqEkD0mlaBNp3ccTaTo0b7+fcd5ibmxbo4PtO35N9?=
 =?us-ascii?Q?wiarH7Xu/m14+hXWxZa6yX2NB4cU9EsSCJMcUgVP430h9k1LDw8ZgRLlm2GU?=
 =?us-ascii?Q?koq7O5jMnZUwAIPWZKtj81XLrD5174LbrTRJH16kKi/3mpS93l+Qhfx1iZ+e?=
 =?us-ascii?Q?NaxgJU3TIsaS6hzoRcXPSlpftuCCjNzbFOXfoCt5otH29NU8s8FY4eXYy8yN?=
 =?us-ascii?Q?qJ0ky/hs0JUYjXVE0UnTI3rCbeJfwnzXLuoWAw1K0j3o6UteEsgEmfTYRCR7?=
 =?us-ascii?Q?tURc4ETZ4j6yUjlIzRuPjGvZeiYJXKtwUpQE1xy/a/E1PeYqYfAGpPqWZ17d?=
 =?us-ascii?Q?HVnzI/Pc2NG5V7R+YyUSnHyLW8bsZrKyzNUFuurmtx7dYrzhG+4OTodCR+OO?=
 =?us-ascii?Q?i25J143dmNMeNMr+WHXQtYsodyTrSi0I+AXKIq7d2ammeH9wADPZrQn6hxOe?=
 =?us-ascii?Q?dEY800jJ4Nkp/x3CI1cE5ZbZYiCKiA0mkci4IPFKIrEtFAebx6iV+1TaFvN0?=
 =?us-ascii?Q?Sn3i2Th0ryj9DGYFGzdy3sktbtczODgxi+h1ZD6fmwIpruKVqvDFmMPrmpuS?=
 =?us-ascii?Q?5HXnCwR3BCl79rM7pXqb451N+nGrZ9N8S32Q6m6ytJ9sTDkFk50/IiNZXsAZ?=
 =?us-ascii?Q?5aSf/WFrm7CKey/D/NXUtb7pNwkwZyoXXp3Ucdtm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f173be87-6516-462b-ff91-08db61a3b54f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:53:15.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpeX21F7Q3vYEft+dX6kZe3rKS7hGZikMMslJ0lET3JJHoK2epAMv/RO7Vnzo0dU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for pmic pca9451a.

This patch support old and new pmic pca9451a. The new pmic trimed BUCK1.
The default value of Toff_Deb is used to distinguish the old and new pmic.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 262 ++++++++++++++++++++++++--
 include/linux/regulator/pca9450.h     |   2 +
 2 files changed, 252 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 91bfb7e026c9..654aa4fbe494 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -104,7 +104,15 @@ static const struct regulator_ops pca9450_ldo_regulator_ops = {
  * 0.60 to 2.1875V (12.5mV step)
  */
 static const struct linear_range pca9450_dvs_buck_volts[] = {
-	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * BUCK1/3
+ * 0.65 to 2.2375V (12.5mV step)
+ */
+static const struct linear_range pca9450_trim_dvs_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
 };
 
 /*
@@ -663,6 +671,207 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	},
 };
 
+static const struct pca9450_regulator_desc pca9451a_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck1_trim",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_trim_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_trim_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK2,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.vsel_mask = BUCK2OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.run_mask = BUCK2OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
+			.standby_mask = BUCK2OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK4,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.of_match = of_match_ptr("BUCK5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK5,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK5OUT,
+			.vsel_mask = BUCK5OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK5CTRL,
+			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck6",
+			.of_match = of_match_ptr("BUCK6"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK6,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK6OUT,
+			.vsel_mask = BUCK6OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK6CTRL,
+			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO1,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
+			.vsel_reg = PCA9450_REG_LDO1CTRL,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO1CTRL,
+			.enable_mask = LDO1_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo4",
+			.of_match = of_match_ptr("LDO4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO4,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO4CTRL,
+			.vsel_mask = LDO4OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO4CTRL,
+			.enable_mask = LDO4_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo5",
+			.of_match = of_match_ptr("LDO5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO5,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
+			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
+			.vsel_mask = LDO5HOUT_MASK,
+			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_mask = LDO5H_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
 static irqreturn_t pca9450_irq_handler(int irq, void *data)
 {
 	struct pca9450 *pca9450 = data;
@@ -708,8 +917,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	const struct pca9450_regulator_desc	*regulator_desc;
 	struct regulator_config config = { };
 	struct pca9450 *pca9450;
-	unsigned int device_id, i;
+	unsigned int device_id, i, val;
 	unsigned int reset_ctrl;
+	bool pmic_trim = false;
 	int ret;
 
 	if (!i2c->irq) {
@@ -721,6 +931,22 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	if (!pca9450)
 		return -ENOMEM;
 
+	pca9450->regmap = devm_regmap_init_i2c(i2c,
+					       &pca9450_regmap_config);
+	if (IS_ERR(pca9450->regmap)) {
+		dev_err(&i2c->dev, "regmap initialization failed\n");
+		return PTR_ERR(pca9450->regmap);
+	}
+
+	ret = regmap_read(pca9450->regmap, PCA9450_REG_PWRCTRL, &val);
+	if (ret) {
+		dev_err(&i2c->dev, "Read device id error\n");
+		return ret;
+	}
+
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
+		pmic_trim = true;
+
 	switch (type) {
 	case PCA9450_TYPE_PCA9450A:
 		regulator_desc = pca9450a_regulators;
@@ -730,6 +956,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		regulator_desc = pca9450bc_regulators;
 		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
 		break;
+	case PCA9450_TYPE_PCA9451A:
+		regulator_desc = pca9451a_regulators;
+		pca9450->rcnt = ARRAY_SIZE(pca9451a_regulators);
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown device type");
 		return -EINVAL;
@@ -741,13 +971,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 	dev_set_drvdata(&i2c->dev, pca9450);
 
-	pca9450->regmap = devm_regmap_init_i2c(i2c,
-					       &pca9450_regmap_config);
-	if (IS_ERR(pca9450->regmap)) {
-		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(pca9450->regmap);
-	}
-
 	ret = regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID, &device_id);
 	if (ret) {
 		dev_err(&i2c->dev, "Read device id error\n");
@@ -756,7 +979,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 	/* Check your board and dts for match the right pmic */
 	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
-	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC)) {
+	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC) ||
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A)) {
 		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
 			device_id >> 4);
 		return -EINVAL;
@@ -767,7 +991,16 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		struct regulator_dev *rdev;
 		const struct pca9450_regulator_desc *r;
 
-		r = &regulator_desc[i];
+		if (type == PCA9450_TYPE_PCA9451A &&
+		    !strcmp((&regulator_desc[i])->desc.name, "buck1") && pmic_trim) {
+			r = &regulator_desc[i + 1];
+			i = i + 1;
+		} else if (type == PCA9450_TYPE_PCA9451A &&
+			   !strcmp((&regulator_desc[i])->desc.name, "buck1")) {
+			r = &regulator_desc[i];
+			i = i + 1;
+		} else
+			r = &regulator_desc[i];
 		desc = &r->desc;
 
 		config.regmap = pca9450->regmap;
@@ -847,7 +1080,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	}
 
 	dev_info(&i2c->dev, "%s probed.\n",
-		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
+		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
+		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
 
 	return 0;
 }
@@ -865,6 +1099,10 @@ static const struct of_device_id pca9450_of_match[] = {
 		.compatible = "nxp,pca9450c",
 		.data = (void *)PCA9450_TYPE_PCA9450BC,
 	},
+	{
+		.compatible = "nxp,pca9451a",
+		.data = (void *)PCA9450_TYPE_PCA9451A,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pca9450_of_match);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 3c01c2bf84f5..5dd79f52165a 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -9,6 +9,7 @@
 enum pca9450_chip_type {
 	PCA9450_TYPE_PCA9450A = 0,
 	PCA9450_TYPE_PCA9450BC,
+	PCA9450_TYPE_PCA9451A,
 	PCA9450_TYPE_AMOUNT,
 };
 
@@ -93,6 +94,7 @@ enum {
 	PCA9450_MAX_REGISTER	    = 0x2F,
 };
 
+#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
 /* PCA9450 BUCK ENMODE bits */
 #define BUCK_ENMODE_OFF			0x00
 #define BUCK_ENMODE_ONREQ		0x01
-- 
2.37.1

