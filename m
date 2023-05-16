Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C597047E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjEPId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjEPIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:33:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792A3C01;
        Tue, 16 May 2023 01:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLX/OlxedYLQo4Bj9yKSTcsToyuFrHoSsv/YjW//g492atFT1mtENM9jX6G+b5vAJSBamhVID4SzAWy9MNen1YItRBaOOGLAZ5skT/Jf1nD5yUzp2nwErDkyDuBmCL3psjMncFxjGqTeOZ2Ql/RdkrIjDoWgfR4CRQ8v+OxlqSxLzkOOWmp4uS7SCktP+SOg+J9NJn1u867ZOENSkoH7Kdysvmr/Mvn/XalZMxvuRZP8pj24axVJryhf3gy88UxWFVxxfdgscNKfrR5P+MzgUUQT7lO/V6eNRf3lbCFVWCBCaoXf6ahnB9Vuh3vnGrZs4p7T6L/PNQs2RzYfQAKgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlKTHXOziId6LQ8cWVoLEmTl1D3ynNMFsB9JUxtVvQg=;
 b=EKenF515sNJot3nY0MkHcbwfcZj2zoyyesT6O5bTiR8+gcQ1Cb4x9jQRVVUkeBDZXFD9xbl2Lo+qWSNGMwVIUu52ZzHGHzIP4h1EeT4u9b6PO2wVXP3FsFZ5Cp4JcHuk/yYPNVf3Bt98Hxf+34/RrfM29gHtjs7OEEQEvNTQlIbGEjdyB4fagJsH4ulUxwdNkfIsmmgDk23saTmED6twhaCYbt9mJpHdTmQEQuH6l6IXJmnrkp7doeR5s+TTCuT5hcUdRWyV16/SbCdcOYG8mRLH1QuKAvTNxS8Jyjc78ixkVdng3V2tu0eRoNnenpBSGslJ6oeILzdzOvlIA9ToxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlKTHXOziId6LQ8cWVoLEmTl1D3ynNMFsB9JUxtVvQg=;
 b=kXeWPfpJU9uzaWRcdAgJwqgaD0cm4502ALT/P8LNOCPHyvxCszHI52/tub7hSvL6IVDUub2LF5bZYbtNX9YdR+u4+Cdf8QcmmbLE7Anqw5uRPurR8BruXOPG0FrfZsUyteyKRbXodZNWD6Oh8niz7uucaml+q5JGmkmQFPz72QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:33:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:33:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Date:   Tue, 16 May 2023 16:37:45 +0800
Message-Id: <20230516083746.63436-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a273cce4-c2dc-4fa3-d9c0-08db55e82bcd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vMaMLs0KY02/g49zTtBF0DI95K7EeUij7xj+HNJ1S57jN5T8Xg/tlHNpls45KkcZFJ+PSbHKylB+nEK+qPnhie4Q+/Cd8C0lH31GQdujDGgzNtjCqW9e1rtE51VKT8UB6NYOtsJasWCQrhV9cOUyJtj1jcUTyESj7ozdUHprUclbHYTl9XJQSlvt397G9C4SBSSSm0nIhvY54TMg5RS0yOAk354E4TGJfET+hm9IfTKOJ/f5iP1WEeAS44Jk3P3LBFExYU5LPnfP58z0RyoLCe37TPBr+00UsSLYRQRCm8xhQ32GiEKwMGOhsT/NsnaKMOPA+NigvMejaSxN8FdbZ9ER3ShqNRCVXqYO9uEqAPUknYrLV73I5cdtTM+uKpWPj9V3RJYR8nYl37MPfWEG/iw952bDgrbfBj3ufXGo+rz52I4q+PgAfpCQXGCs4Te7il0yUoVQUa7ixW3TMsvzcEQsL4buGNuV/zu6tWf3NMNIR+v+EekN0HsfWaoiER/63nqX2/0bvT/DBrCCprwx70pL7FI+gYMUU37fkrZ7u9oDlQLUMkACUkP02uaOz80WV5JBYanqTSLvqyzDuC2xW4Z4rQbxQC5LfT5BGcMAS0cNL6I+kQVRUCgQljX57fw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(52116002)(66556008)(66476007)(66946007)(478600001)(4326008)(316002)(86362001)(83380400001)(6506007)(6512007)(1076003)(2616005)(186003)(26005)(6486002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UAsRi8QkKLZ9i5jfYUQ3J7JLpiKmGOFDfkCftwMTGmnCY+PzeicLPfuMTy1?=
 =?us-ascii?Q?iIoUXQdgMqtGTH0a8PaUViO/09AmeFdfm0ePXJrKk19NBv+x7zXW1z3iLGWu?=
 =?us-ascii?Q?N25JxJ+Ag5eoPfvsmHbr3aOu364N41zW2royLY7Uu2y3pXYl4UcZk/hQbPFu?=
 =?us-ascii?Q?kofFtQYXIuFoGbbtTGtaLjJwov/gAm0nKXQRhjPYWUjXw8UyGlordXB1WOo9?=
 =?us-ascii?Q?0TJfNKCBnJd5lB8pWkwm3LgB786Vr2ZYIckNTZkWzGSnU+zFXawnDSJptdbO?=
 =?us-ascii?Q?1aIHgWd7WPCdEZUL4q3BpYw7cdXOiNIrvm38lYT0AHw4ub4atmuchcqxJdaU?=
 =?us-ascii?Q?/dU8CElYGRj1SNDoJ8FMzKiw6cr9GuN9ficBBZd7iSIQZG8+bZPhg7xoLQVa?=
 =?us-ascii?Q?6J+P2RPkjYm0vcW+DtX5OtK0kKSeFOy66IhV7jf9xVS/XjE1z9mOIe134aN+?=
 =?us-ascii?Q?ZB3//TIc2NxLOXjK2TtsL5V7klkmZkz3rMeoTfz7DaATlWCL9fDonuC8y31t?=
 =?us-ascii?Q?2Da9EjHK1QgYMwhiEGrZNOd7QvtTrA9BF6Sao+VylEp7xdbeScIx9nGHXoTr?=
 =?us-ascii?Q?oNLxQRjuI0UXrESXzLYJmhKuvJVMdz+sc5sfUH6/8XxrJshbk7klAVY0Fr7W?=
 =?us-ascii?Q?xQK0wTq6jDfWnAD3nVl7I8WIcJvba0IjLQGywHZUwKcOLC1sI9CJJC1nE7Bp?=
 =?us-ascii?Q?PyJMDGPkx8TZEVaU506jlL6O8hbwRsud2xECaC5hb6JxBlAuSDy4JQpkQncF?=
 =?us-ascii?Q?xf1z6METOJ3sP+LrqXV7irprxVkZBq6EAz9ZpqvdBdQjtnDWKbX5BKzCUy8d?=
 =?us-ascii?Q?/2DfYR8Q+8C4mWShOVqS+9F6umjsIKOvR3mr7ysF8Tx9ZXjTJdkON0jnBXv/?=
 =?us-ascii?Q?tSwsxD6GU9E9TnEsG00zecjUPkVjPKQyvb24YMw4fVlkdBiugt2b17SrKQu6?=
 =?us-ascii?Q?LXFbsI0IivYtBu0/MvnccbxsysQmPvHeTQQgEwXgRmAstRAvOqW1QDoUApT7?=
 =?us-ascii?Q?+Vp4IA9e5S4+a7NVjfqfA4lHkh+KqIwSFe+/Fpg5GhLq34gsgYOY3GA2zaBe?=
 =?us-ascii?Q?qTIK57aWbDj0Q9NyU/qFImJo8kUiuyU5b41jL2MFDTaaSo0O8QI3YiQjDeXa?=
 =?us-ascii?Q?Y2ymhF/CBxjcgxST4bntN7h9fG2WWUqINgpiitIBdXlfzINYWvLtQzGTO+JN?=
 =?us-ascii?Q?xSAxtaLvxYQo3xFdc9E1slNdslM9nDlZOwVu7SxrBpKldwpnybfKPZiFP03R?=
 =?us-ascii?Q?dZQE3Zh9spHnGY3q+UPFHQeSaXRrw9ugUL+WcF2nqQpHbHTNCoKGtzUeXzL7?=
 =?us-ascii?Q?ewESTbLowCgd8mPhI0bF2W5ItKU4/QW4IrYsBt6Cw1ErgkySNObzdj7TqxEs?=
 =?us-ascii?Q?m0yNgavJS5cqpbS2+FsZHH4RuO7hf5d4ESwow9vimToRGG8mOPKo0f1G7A+M?=
 =?us-ascii?Q?6GvzKwTn371GoWA2fgOszvhBK9AfjJDQpk0S0z+18ZgI6e+iqbjuCWphfcY4?=
 =?us-ascii?Q?DQpKKV5/4m/3RtEu2pnpnOQdDibXcwiVI7A1E1RUQSon0CKI5R3PqkW838MJ?=
 =?us-ascii?Q?40LPiLiHu83srWBXQ1jcdBR+r79xUsFiMZ6C/Epw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a273cce4-c2dc-4fa3-d9c0-08db55e82bcd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:33:06.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJ/ZHohGvo9au6ASm8biL46fU09aAgX6QOJgAFfoNvtHKH2PplFlw98OZ457D2gH8X+Vcl/KgyKvIKw83/EDLw==
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

There are MAX 16 sensors, but not all of them supported. Such as
i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
touch reserved bits from i.MX8MQ reference mannual, and TMU will stuck,
temperature will not update anymore.

Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before registering them")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index b806a0929459..53748c4a5be1 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -31,7 +31,6 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
-#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -105,6 +104,11 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * within sensor range. TEMP is an 9 bit value representing
 	 * temperature in KelVin.
 	 */
+
+	regmap_read(qdata->regmap, REGS_TMR, &val);
+	if (!(val & TMR_ME))
+		return -EAGAIN;
+
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
 				     val,
@@ -128,15 +132,7 @@ static const struct thermal_zone_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id;
-
-	if (qdata->ver == TMU_VER1) {
-		regmap_write(qdata->regmap, REGS_TMR,
-			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
-	} else {
-		regmap_write(qdata->regmap, REGS_V2_TMSR, TMR_MSITE_ALL);
-		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
-	}
+	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
@@ -153,14 +149,26 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			if (ret == -ENODEV)
 				continue;
 
-			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
 		}
 
+		if (qdata->ver == TMU_VER1)
+			sites |= 0x1 << (15 - id);
+		else
+			sites |= 0x1 << id;
+
 		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
 			dev_warn(dev,
 				 "Failed to add hwmon sysfs attributes\n");
+	}
 
+	if (sites) {
+		if (qdata->ver == TMU_VER1) {
+			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF | sites);
+		} else {
+			regmap_write(qdata->regmap, REGS_V2_TMSR, sites);
+			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
+		}
 	}
 
 	return 0;
-- 
2.37.1

