Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4D65E6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjAEI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjAEI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:26:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CA50047;
        Thu,  5 Jan 2023 00:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEX674ADpaIICADKxAO17lPo0RF4N03f9o0YW1niojCDj08OjaNCf3Z0rJa9sGoK7H25awxuQ9c7ZUX+vmZhHr2txGwZP8f6xjxZtylEt3ecdL0KEF3oegKrdlAvHNYHU0hwq95CZga7BxeBuSccz2VVoHqWUwGw4KgwFEklyRTgCIdEz8nEP0GC8KuPrgU1ONThn3B8YfmoSczsvk8pHLPW+JG15BY6XR1r2BOUa/r3IohsOVfuHRkCsO4jlkeBjfqm3I42Hqrwcy7twmW+eG1azIu7NQmb+rGVm7TJNE31HRt866jIba4J6w16CpdHJks+WPZ8JieI2ckkE6xrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpQASw28zsvT4u8rGArOefZkKgG7vvLOEkQF0Gr/TgY=;
 b=NNVY9lxxh8lYmYMRTvpS2q+7D3MohK7amDpgdGSDk7VD2Quy6VoSsZj306d0REERJXrdJLCj28ZJMbP9lvo0NxCoUwoJbYnZB7ixCY+IcaeU3Nf3VkQ90wMrf8LWNiYkRrTphYSl12pncp4vXM/7ho03qi6Hh5eqT+Wv5SooAh2xnFdO1It9xaTrmUv9YLbXyaOPkEHY+26+VG78jFLhkl5ZvkjbHjxPQL91861Aq6+UtC7c2Bry+LNbWZNkxCv+09xrbBkqAn2eC1IrVD/zJLCriAcu5DZ0WSkcBSnZrvwJ8oJsZRuA7qwm2xf9RVmOh4dbinw+GN5DKSgfqEO2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpQASw28zsvT4u8rGArOefZkKgG7vvLOEkQF0Gr/TgY=;
 b=RwbJ23WhdJR8H8Bmy8+9uBACShGLXdx/etM6JUqJlzlKRXrVXm2x4LAPqLEXR6RLmKUGtvwGjWZwbJrKLbO8bJfOs4/22Bxika566TSzdl3KJpVEhuZVOmROP8eEoWlJ1nKcErIa/r1tKKq1SIJK1FChP2BofsvC5u5Qjsab7A4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB8771.eurprd04.prod.outlook.com (2603:10a6:20b:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 08:24:45 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 08:24:45 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, aisheng.dong@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] thermal: Add generic device cooling support
Date:   Thu,  5 Jan 2023 16:22:33 +0800
Message-Id: <20230105082234.16962-2-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6379a957-5603-49a8-6ffc-08daeef64d67
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smYXcyiakQUOmfCKr48kmNby9Y4q/lHAjRUw0bcX0cus7EDyPWDW7z9/g3PUdWHj+IgpiMSSpIycwJr5DwCcipFcTgZY02cnOp7HUuEMLiLhdQqXF8K/4WIhbocrrhisXgdoEnSnMvd2fHqlPuONpcLJFcK+QpRdyg473lwF4pV1ichWM8cZQxFRtRVfB0EeYKVnL/eqZrDbxmpsSw2sUiLQtzx6bVetJrd2LU+f1p6K1lUXlctyOQwleZd1jEURYQOOQ7ZY1t1AxMWXMXQufeD6eYtAAfKNRVJoEXVSRwMgKyD8vGSoPVhOxjICYyKqTShtPOMruoFY70cXexYWR7PTJB4QRLDIofW63oDxWbi19ZnqVbNvVRrY/hc/JCpmx9zN1h4WKKPr+Nvmr+7B8/T/Dkm+SnHeLyvhnMOdviVh9MHLTK9PmTN7gW5EXY4CKdQ5mP2+Fm4LQSUJklnmyIwC23Rm6D0ayXUcPH5XxjFA0eSB/b4aT88KYmTZmuKRPM9NOXBAPqVgrobfhFkRWoZZb1pppuKlK0MueVOjgxd7K46MJyga2KPCfe5KrX10zkRcGidpZbinb+BSyptQ/L3R4P7OMGBo3vKltk3z/ubQy4PNsbWi8059WaHJTQ5FVkuKSwIIWdqiOTYJHPpgY2sIlUNUu5S7i+n550SLi7AwUlpDotwzaDCBo6DXfgA/5/wDISS5fbKZLtHcDL9xdyZAtFly9brRamm9yA8MJz4nfNNF5jwReuLrFPj2Qw36
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(5660300002)(4326008)(41300700001)(316002)(8676002)(66946007)(66556008)(66476007)(8936002)(2906002)(6666004)(6506007)(52116002)(478600001)(6486002)(6512007)(186003)(26005)(86362001)(83380400001)(1076003)(2616005)(38350700002)(38100700002)(41533002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQZLEHyv3Wv2gP6x+6XzRFHwq92rcWaqymEuGgmi8Wl3X9VAixLL+GgqxRNG?=
 =?us-ascii?Q?NSKFBLcSq0Q/qvK+7dQa9ss29vMAbkLXlmSaSR8wsjzRutJZW0gx/Ig5tzEw?=
 =?us-ascii?Q?E+FOEQxU1guTMo8r4Q5wOq55JgRY0hcVI0Ay5Ry7ZS4WBSPx+V0jAwvP6jxj?=
 =?us-ascii?Q?AzoWAMU7j1GwcmxQTxT/BUp4yBK+plSGUp/ruzefGeppubMFiOQ3z0RwJxsS?=
 =?us-ascii?Q?MhUTz6s38ghwm3Hh9AbbpfQa6IlbtJkCN8w3dbbf1Moa3MpU44jyLg5bINyE?=
 =?us-ascii?Q?7r7OYErPFPvE18CZAGcfeOFhWyG8iWR2UXZKJaVwfWCIuLM8qpMA93+585VP?=
 =?us-ascii?Q?OtYlqx9wwjbZXorWbXQJFcPWZ2SmfhBY6U3P+4sSaHeLIkO73liF4auC6ne1?=
 =?us-ascii?Q?gtFdLiojL6cZsJDKFbqUqn7slctIZG2KbegWKyARrr+5G1I5DiCk2CRC7PcV?=
 =?us-ascii?Q?J7J8GObj9tTTbIEHNbN+U+hgZoDSngQD160IZ9RBkq5bQKVE0rEr/dHyEIr9?=
 =?us-ascii?Q?8ljTEcKXFwj7OxqiMDWSTV20Yh09EyrMyeK2K2njOht77CDAFWSeUHMba2Iu?=
 =?us-ascii?Q?j3hiiDcSOih/NsTDyLYLvBVjaIKtk3VeDDeBabDzok0NKlvjMiBt4u4ijC+m?=
 =?us-ascii?Q?rQEgR30o1XSGgrIyNXyT/BokanNBOrWyokBab/q6tI+fM64Ehf71scjtpUVD?=
 =?us-ascii?Q?Spoeq0NHHE8aRVDmCDtGcWsP72HUWMzfvVPOrk/BokKd4bRWxGJjsL1oAHMl?=
 =?us-ascii?Q?1vRyf6HZiNyWx/lzCbmuh1mESGWkf/lyDrNVBFfUlXzkMdIzAhdkWraBuQ00?=
 =?us-ascii?Q?hVpk3Xf1yBvWPtrMRWpugxyhBxq9OTjLVwKzuLTDP3Fm3vviviD7TE1ua4Am?=
 =?us-ascii?Q?rSEH6PNk8YJhgFzVBYJAbpfO5J38D8i73zHdSsvy7067ORkf+aJfdP4z8nqy?=
 =?us-ascii?Q?cqvJfgDnOjh44S1h2ykqC0msP0mwar6PLqGNXQ4cjQBeIO0J1b5SMkOiMM8g?=
 =?us-ascii?Q?HRJlQBAakVgNnmhvM6BQWl8fp11pXOX5dsin8KpyjnOVVIbJ5ELMhz8a1ymY?=
 =?us-ascii?Q?a0RWfwu1R3ek8T/D3L2mSQ3rd7IlYGrkRfgp+HxlEwLa5uFGrReJ2xGoMJ95?=
 =?us-ascii?Q?DQTLMUw+MxMTCnUMj4mBK9YCfw1Q7RCXRdu3y7VnSEgzLGqAAGyB+tgKtwOr?=
 =?us-ascii?Q?7QUeOU48z5xbb7BpUo7zGhZtQtiYC8nJRBTAUeh2BOI/vdfclKsFWSoBwotS?=
 =?us-ascii?Q?E9w0MysAG1h8ND0vFeO3sA5bbw9mQU01Wx5SI4y1WXpwnhppFWukIMBZhvWO?=
 =?us-ascii?Q?DuHPPgHijJ8thR2R3mrcfxF18LGGccxy8uDAvpp8kzyfhOA2LOXpv+HIS1uu?=
 =?us-ascii?Q?4lCZQtl9jY7pytooM0bazpuuTthhFMckhRIEXkM2eplWre57T3qgJfCtYWwb?=
 =?us-ascii?Q?y/rAXemKebfbZCLRMuJYUSSthx9i2WlQFkV/IGjMOLdkHkTtHAgRVqiQH3+8?=
 =?us-ascii?Q?TvZe/M7vMy9tHmVY7U/BePf477zafZlyfSMB1Ar6jfQmKFM+wWlMQkXqM86I?=
 =?us-ascii?Q?TS6UMg0cjZ0KEi4fxTI4ji15QKVQxwO1rr++P2JE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6379a957-5603-49a8-6ffc-08daeef64d67
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 08:24:45.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4U4dYvTCGlAq8Huj8BtmxHmmODSayyWTimNRmHlFPgc1+7K7RZPs4s0pG8VfHuv3xvLKDFukDKsoebQXS0uMbw==
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

To compatible with previous implementation, add generic device
cooling support, each thermal zone will register a cooling
device, and when temperature exceed passive trip, the device
cooling driver will send out a system wide notification, each
device supporting cooling will need to register device cooling
and takes action when passive trip is exceeded;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/thermal/Kconfig          |   7 ++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/device_cooling.c | 154 +++++++++++++++++++++++++++++++
 include/linux/device_cooling.h   |  46 +++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 drivers/thermal/device_cooling.c
 create mode 100644 include/linux/device_cooling.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..2625903b56f5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -284,6 +284,13 @@ config K3_THERMAL
 
 	  This includes temperature reading functionality.
 
+config DEVICE_THERMAL
+	tristate "generic device cooling support"
+	help
+	  Support for device cooling.
+	  It supports notification of crossing passive trip for devices,
+	  devices need to do their own actions to cool down the SOC.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..77c4b2e525a4 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_DEVICE_THERMAL)	+= device_cooling.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/device_cooling.c b/drivers/thermal/device_cooling.c
new file mode 100644
index 000000000000..6bd668ee545e
--- /dev/null
+++ b/drivers/thermal/device_cooling.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Copyright 2023 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/thermal.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+struct devfreq_cooling_device {
+	int id;
+	struct thermal_cooling_device *cool_dev;
+	unsigned int devfreq_state;
+};
+
+static DEFINE_IDR(devfreq_idr);
+static DEFINE_MUTEX(devfreq_cooling_lock);
+
+#define	MAX_STATE	1
+
+static BLOCKING_NOTIFIER_HEAD(devfreq_cooling_chain_head);
+
+int register_devfreq_cooling_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(
+		&devfreq_cooling_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_devfreq_cooling_notifier);
+
+int unregister_devfreq_cooling_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(
+		&devfreq_cooling_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_devfreq_cooling_notifier);
+
+static int devfreq_cooling_notifier_call_chain(unsigned long val)
+{
+	return (blocking_notifier_call_chain(
+		&devfreq_cooling_chain_head, val, NULL)
+		== NOTIFY_BAD) ? -EINVAL : 0;
+}
+
+static int devfreq_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct devfreq_cooling_device *devfreq_device = cdev->devdata;
+	int ret;
+
+	ret = devfreq_cooling_notifier_call_chain(state);
+	if (ret)
+		return -EINVAL;
+
+	devfreq_device->devfreq_state = state;
+
+	return 0;
+}
+
+static int devfreq_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	*state = MAX_STATE;
+
+	return 0;
+}
+
+static int devfreq_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct devfreq_cooling_device *devfreq_device = cdev->devdata;
+
+	*state = devfreq_device->devfreq_state;
+
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops devfreq_cooling_ops = {
+	.get_max_state = devfreq_get_max_state,
+	.get_cur_state = devfreq_get_cur_state,
+	.set_cur_state = devfreq_set_cur_state,
+};
+
+static int get_idr(struct idr *idr, int *id)
+{
+	int ret;
+
+	mutex_lock(&devfreq_cooling_lock);
+	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
+	mutex_unlock(&devfreq_cooling_lock);
+	if (unlikely(ret < 0))
+		return ret;
+	*id = ret;
+
+	return 0;
+}
+
+static void release_idr(struct idr *idr, int id)
+{
+	mutex_lock(&devfreq_cooling_lock);
+	idr_remove(idr, id);
+	mutex_unlock(&devfreq_cooling_lock);
+}
+
+struct thermal_cooling_device *devfreq_cooling_register(void)
+{
+	struct thermal_cooling_device *cool_dev;
+	struct devfreq_cooling_device *devfreq_dev = NULL;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int ret = 0;
+
+	devfreq_dev = kzalloc(sizeof(struct devfreq_cooling_device),
+			      GFP_KERNEL);
+	if (!devfreq_dev)
+		return ERR_PTR(-ENOMEM);
+
+	ret = get_idr(&devfreq_idr, &devfreq_dev->id);
+	if (ret) {
+		kfree(devfreq_dev);
+		return ERR_PTR(-EINVAL);
+	}
+
+	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d",
+		 devfreq_dev->id);
+
+	cool_dev = thermal_cooling_device_register(dev_name, devfreq_dev,
+						   &devfreq_cooling_ops);
+	if (!cool_dev) {
+		release_idr(&devfreq_idr, devfreq_dev->id);
+		kfree(devfreq_dev);
+		return ERR_PTR(-EINVAL);
+	}
+	devfreq_dev->cool_dev = cool_dev;
+	devfreq_dev->devfreq_state = 0;
+
+	return cool_dev;
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_register);
+
+void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
+{
+	struct devfreq_cooling_device *devfreq_dev = cdev->devdata;
+
+	thermal_cooling_device_unregister(devfreq_dev->cool_dev);
+	release_idr(&devfreq_idr, devfreq_dev->id);
+	kfree(devfreq_dev);
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);
diff --git a/include/linux/device_cooling.h b/include/linux/device_cooling.h
new file mode 100644
index 000000000000..83b709e7c893
--- /dev/null
+++ b/include/linux/device_cooling.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Copyright 2023 NXP
+ */
+
+#ifndef __DEVICE_THERMAL_H__
+#define __DEVICE_THERMAL_H__
+
+#include <linux/thermal.h>
+
+#ifdef CONFIG_DEVICE_THERMAL
+int register_devfreq_cooling_notifier(struct notifier_block *nb);
+int unregister_devfreq_cooling_notifier(struct notifier_block *nb);
+struct thermal_cooling_device *devfreq_cooling_register(void);
+void devfreq_cooling_unregister(struct thermal_cooling_device *cdev);
+#else
+static inline
+int register_devfreq_cooling_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline
+int unregister_devfreq_cooling_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline
+struct thermal_cooling_device *devfreq_cooling_register(void)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
+{
+}
+#endif
+#endif /* __DEVICE_THERMAL_H__ */
-- 
2.17.1

