Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8D65E6D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjAEI0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjAEI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:15 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BC5007D;
        Thu,  5 Jan 2023 00:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1NiXRNPyGgiDAe7XkLB0hQz1M2PzEr0Ecb46fnVuDhMPhw/4t3FatZLpWiAZgY3zcvpwyx4QyZhTQi0dKdcnZdiuRQA7BisVQADHeKaC4XV+cW1DW9rqQRfr/YZbpCvObZmuD0GD876BejBvMCwFtvHOFk7KIW74mk0ACCpwjdG7IQAr8uQHlP0ZckK/0qw/L7vtgzMrV4o4XcqKV62UpppehecCVMJIj6w3gm1E5fGwftwBJz3+YpcHEr1ey0IWkhFUxorG7GT68Q04FN69krqHrkQZSn7wKxXgzdDhYMkFNrA4ffBuqY6xjXU5+UgL8Ty3A3JMq0FbhTxXoLTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cmjDbM9CwyqBncNx8qogTYlUutQNsN6a5GlZMHDs2U=;
 b=YoeGG9+kQUpi9ect23lirVXJjbhDRJfRyKfgWQOwAlzHpMOJz9M8iBYVggtyEjL7Prssc9+yl0pgUFhFx+638jKCFS7ibsGwnRsOK1diLHgw77/Di6r8ku3GhCFKGeqjNNdR5NjtfeGUOOAkk8AIuRntd9L/OWgrEOZMuWdGMQapYhD2pk1ub6nZYsTvuXX46y6hf8hfjBQJaj4CV49gixZ22FUP8iUhsjJm24tyQJ/o9oVhQ0NtwB6G18QfZ3kWNWint3o10py1WQq8PM0P5+k6AKE7qXwnYDhj3+Wbv11RnJ3Uu3Qjh6jxYXDyW9cxoL911ZVqq3pS8rPmILP/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cmjDbM9CwyqBncNx8qogTYlUutQNsN6a5GlZMHDs2U=;
 b=cD68RAZyizo2lwPPGd1puYoi7X8v4ydVKRlWMEsIIlf7le1Fi9rSwYTeLbcUuf5d+dDdFwAIR0GpPRe4x8o/GNerZdnOZsXJ7vEnOJIxhfVQO09SdCYB2S5qlYs3riU7QG+63pgt6cGELw4v5cgt6A2Jo1PDKF2+lMOVnS9J0wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB8771.eurprd04.prod.outlook.com (2603:10a6:20b:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:24:51 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 08:24:51 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, aisheng.dong@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] thermal: qoriq: Add device cooling support
Date:   Thu,  5 Jan 2023 16:22:34 +0800
Message-Id: <20230105082234.16962-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230105082234.16962-1-alice.guo@oss.nxp.com>
References: <20230105082234.16962-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6053:EE_|AS8PR04MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f91bc9-655f-4200-fc03-08daeef650cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVkFMDI7kRxDmSOYlpuUKmPXtOX30mcpQs/SpVqA+dUaYRHocqC9VIEy8jbHqhMuCeS6mTZHDymQ1S1nufrmUPWzon6l0eSfCqow/RVSLP7mZMXy79zk0xGq0zRyn1uEBPFgzq6NSEy3Vq9Vjki3PQCiW5BWmFj2rez6RLVIecMq7MF/OpXhWDOvhovOUvEbBVHCp2lCriM3KPmnWpFQgPniKUN/f8hPy7Y/gpMaRR/9BItI7GQr8l9g87pe0l5JbGGlIyRxhSepFmyVT0sbLt00tDNsraFQZHsTz2oEslkcXOaArk62j3Jhe2xH/qUq01X+JlbxxnvB/4WX+19P+d2aTrB/wkr0h7NKHszKLjnSHdNldi3V/PaBquTHqa5aRzsLspKr0oqhL4ukOWAcHf3Bm77Dwff9OCXxSlARupbuq73YX9HW2r8oXCqI0f+KVs83mnVx82lxGop5Qq/N/idR73AcMhTBGizE5TpvAgdlGBYLktVmZZuH82t5Gu1iIrB2hJhc8meI7zms4oXbH4VHWQojCOcsn9x02wHOqOTEhxgRvbB9cfgVWlyvyRIXpr2N6SYPZ/f08uc+MrdovSrPtev0Ay9YeUzxJRf3W7lV46OHunpXXBfFLwWiKlQ/ISyTTQnyvENLGidzXyC2WEFCJlYfRrD4RPfZGmGko+La7CQhkXxBmuk13j2nSGrBbP3nlb73HRyECezz4fGqpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(5660300002)(4326008)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(8936002)(2906002)(6666004)(6506007)(52116002)(478600001)(6486002)(6512007)(186003)(26005)(86362001)(83380400001)(1076003)(2616005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uAab30O5oZCFbyCQN29ycvPFCCQnpz5yesK12WwNMtxgTMaFexAN+ynvIn9j?=
 =?us-ascii?Q?ak5w8MAHjG+YURn0f/bib4UqsVx6Tauwodj22BslOIobVJbrFZOOJEOFuHkS?=
 =?us-ascii?Q?VyOx2dCwuTkOUZKm+HzqPsIi3g7732xBN7f9id6a4dzGFBFHf8Hjb05zNwBn?=
 =?us-ascii?Q?dwdZbK+coGyBPaY9QWHWF4EZ5e6LL8Y3ZI7OfTcJ4EdwqPr576zsLZgFvo34?=
 =?us-ascii?Q?BGguUtKldrrkbAQzBaAH88z1GXQHHXyC1XlIjwMvh9GCe96BJZ6PWdxYG/d8?=
 =?us-ascii?Q?AxxbtbNJcJXGOmfXOCZ/Z7F+V955hvFcXScw8+IxVjptBtZ2Gevj8zb35w1/?=
 =?us-ascii?Q?VPXd2S2jIdfm+vasTu/Aa2qj93ZwKhAFLzgKtvKQ95ScuDvs0JIYQuZQgKEn?=
 =?us-ascii?Q?b9F+yQDNkMhyRgJiiVUFF5UmbKTI+dd+eOBlOyV9Cg35h4Pdx3Rx5BWB+Bdg?=
 =?us-ascii?Q?h1rt2B8Hd8hlbA3wgDpeqYrrYlQ2902Ar7VwTBxdE2Z7Zwt2rU8BmM+U4PJW?=
 =?us-ascii?Q?Cai4rlPlu6tqBw9geDj2gz38GdQoXlwkkzJYiD0twVu8sqJHI2VbURFm0WC8?=
 =?us-ascii?Q?HWJKZzsPMdZnUEz1h0tMUuAneAAg4740jdUtqKiH63euKRvqqU3MsPCKxDyv?=
 =?us-ascii?Q?TLdAhz6OKGth6N4q966QMyJpzhgGdIvvzhonlvhvoLzo3sSRGPJxTQ+9HE5s?=
 =?us-ascii?Q?PhD2mz5pwa7BUmczAIvRjDGxM5JURlAuTKYgeApk74jJRQeu2GwgHD4Ip5Pz?=
 =?us-ascii?Q?x6ttJckmc8JeRs7laHYCAkdXJxXx3MuaG9Dy20m1t23kRGmXUvahX690eqaW?=
 =?us-ascii?Q?vG2gFLOPX57o0hSD3NaTypvnO42spjhfeixoNHGUWjWAuohsgXF+qdPorZym?=
 =?us-ascii?Q?oUBS4qeIYiiHYBhcy7s2z4HsBXF4xxvZBu/AvhTrC7FTZd1mGviSRXUNRygk?=
 =?us-ascii?Q?au5a57eIGqQmtgNvTR3kZjyK/OI1OJ5HdbAAFbZbfV4g1PFsQHsV54mxi8QY?=
 =?us-ascii?Q?ZTzTHXPJi442IUibGkWW3/tmUuZVEKbgZ3zFnJO4nwzM9ixTodsV2tqJF+jL?=
 =?us-ascii?Q?k5TtyHJsOzDWqQyjnYuFjW1HNUJ2cypVIcfD+lw4QoJS52FM4d0jNTdFUWYJ?=
 =?us-ascii?Q?JB17bxVaurYjrS4ZZTNcP4NqO3yt9r4tGXQjSFCM1E+acR5dbvr4t7Wt7m7X?=
 =?us-ascii?Q?+oQVPM2PSl2tQlz8lQt2WAuUwg0TwT3Rs3jteCu/4imwcC2weqyx6VdAg00H?=
 =?us-ascii?Q?/Z9OpYgKn55pgUP7yw1qMGifPXhRo8JCPgNjDDxzAYZGzv+5rGpEDy3DRyut?=
 =?us-ascii?Q?uFfoC/HwrUA5NZ0kgTd7FsbDbGpuUpOQS6gAEfwQbtkkBeBFe5voTBqw12g6?=
 =?us-ascii?Q?hwdhqLIujzc4mWF4NMqm+srvM5NUe+8A0IaQu6yGdyb66Qt4YAqnnsz2tZWT?=
 =?us-ascii?Q?w/qqoeVZ2jt28NUynCOswgHaxPzyZ0TkSJrMN5r2prtbWLapIeWceNDW1Gj2?=
 =?us-ascii?Q?/YF7oFTIYKaTx8BbMZDTOwnH256r2gaI/oPfMv1Wd7Ybz8usF16yrvUWYBUh?=
 =?us-ascii?Q?62aG8KUUr3EyopaHhE3o5ECDBKEPyp6nUQSm/Ov/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f91bc9-655f-4200-fc03-08daeef650cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:24:51.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXA2qqWWIb8CODQcNIp34p8kd4rsjX7/be4uqPlPYjY2vHGNTrJUIzyUXplRmP0FFg7Ko8cbQa6j9JLlSvufbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8771
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Register device cooling for first thermal zone manually, when
temperature exceeds passive trip, system wide cooling notification
will be triggered.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 83 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d111e218f362..3c21b2d184eb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -3,6 +3,7 @@
 // Copyright 2016 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
+#include <linux/device_cooling.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,6 +28,7 @@
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
+#define TMU_TEMP_PASSIVE_COOL_DELTA	10000
 
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
@@ -68,6 +70,10 @@
  */
 struct qoriq_sensor {
 	int				id;
+	struct thermal_zone_device	*tzd;
+	int				temp_passive;
+	int				temp_critical;
+	struct thermal_cooling_device	*cdev;
 };
 
 struct qoriq_tmu_data {
@@ -77,6 +83,12 @@ struct qoriq_tmu_data {
 	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
+enum tmu_trip {
+	TMU_TRIP_PASSIVE,
+	TMU_TRIP_CRITICAL,
+	TMU_TRIP_NUM,
+};
+
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 {
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
@@ -122,14 +134,53 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int tmu_get_trend(struct thermal_zone_device *tz, int trip,
+				    enum thermal_trend *trend)
+
+{
+	struct qoriq_sensor *qsensor = tz->devdata;
+	int trip_temp;
+
+	if (!qsensor->tzd)
+		return 0;
+
+	trip_temp = (trip == TMU_TRIP_PASSIVE) ? qsensor->temp_passive :
+					     qsensor->temp_critical;
+
+	if (qsensor->tzd->temperature >=
+		(trip_temp - TMU_TEMP_PASSIVE_COOL_DELTA))
+		*trend = THERMAL_TREND_RAISING;
+	else
+		*trend = THERMAL_TREND_DROPPING;
+
+	return 0;
+}
+
+static int tmu_set_trip_temp(struct thermal_zone_device *tz, int trip,
+			     int temp)
+{
+	struct qoriq_sensor *qsensor = tz->devdata;
+
+	if (trip == TMU_TRIP_CRITICAL)
+		qsensor->temp_critical = temp;
+
+	if (trip == TMU_TRIP_PASSIVE)
+		qsensor->temp_passive = temp;
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
+	.get_trend = tmu_get_trend,
+	.set_trip_temp = tmu_set_trip_temp,
 };
 
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
 	int id;
+	const struct thermal_trip *trip;
 
 	if (qdata->ver == TMU_VER1) {
 		regmap_write(qdata->regmap, REGS_TMR,
@@ -158,10 +209,40 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
+		sensor->tzd = tzd;
+
 		if (devm_thermal_add_hwmon_sysfs(tzd))
 			dev_warn(dev,
 				 "Failed to add hwmon sysfs attributes\n");
-
+		/* first thermal zone takes care of system-wide device cooling */
+		if (id == 0) {
+			sensor->cdev = devfreq_cooling_register();
+			if (IS_ERR(sensor->cdev)) {
+				ret = PTR_ERR(sensor->cdev);
+				pr_err("failed to register devfreq cooling device: %d\n",
+					ret);
+				return ret;
+			}
+
+			ret = thermal_zone_bind_cooling_device(sensor->tzd,
+				TMU_TRIP_PASSIVE,
+				sensor->cdev,
+				THERMAL_NO_LIMIT,
+				THERMAL_NO_LIMIT,
+				THERMAL_WEIGHT_DEFAULT);
+			if (ret) {
+				pr_err("binding zone %s with cdev %s failed:%d\n",
+					sensor->tzd->type,
+					sensor->cdev->type,
+					ret);
+				devfreq_cooling_unregister(sensor->cdev);
+				return ret;
+			}
+
+			trip = of_thermal_get_trip_points(sensor->tzd);
+			sensor->temp_passive = trip[0].temperature;
+			sensor->temp_critical = trip[1].temperature;
+		}
 	}
 
 	return 0;
-- 
2.17.1

