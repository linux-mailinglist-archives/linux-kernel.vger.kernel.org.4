Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2245C680FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjA3N5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbjA3N5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:57:07 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2098.outbound.protection.outlook.com [40.107.6.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DF39CC7;
        Mon, 30 Jan 2023 05:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m24Q1O0NX7EnSIGpXQz/BNVm5QR+z/lrQxVsadUAwKPETIUfMNwzCp0LpFa/7YLe5aBKygKibp+rc+99mrUN+n2K9ku1HTUnawJ4lwiV3nI3533vN2EGHTOGYa0QNoBgcVFVPnYsXgdsIgs3GY/EhVVVmQa2atBjo0eOsYVo6p+adoOhBXGZ2YgxTJzQ3rg1/T6jTUBsKuMVXHWmTLknUXtbdtYkBUSSyPYPltQrVBycaa7ZxNNeiuDjwdof8Tjlu3DM/1X+YbI2tyvZ3uKcnpI1XvKXkR/HIb5iG8ujULWdyf/jYt8axu8bDN7N9IG0cQ/VYnzPhw6O7+a28RhfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0MP0lesqO9QJLuNZuqJ+lowPa1MRxTtgGDfKxG+tTg=;
 b=nqmE+oDrrp6DkDiri+vq5GwoiGqBJHbBOeMk5r6VTYtFJlGRvKiFbXsjtT8k2U75Ia2wA51MVoKvN/ChS/PF5SciTo1Yky93p86tKIu6PA4n68ZpFIe37ydG9vZ9El8VI3k/Yvuy4CFEt+C4xDhKYiZOQzwiuqZ9lJXwpOGh9+KCB982+Cu02EskmN9D1FKX5MYl0qwT/ipcdgHc2/+/xh3b+KdFgjWb9kCYcjJY6IDPyV1GKJzIGjiYdIq0jSmY82Wgf+Ouxjtjsb13Y9Q1Oc6+K95gVHLilZ5vzmlscoDJQRxkmGNMmV0ZKVs56Dm9NS7FxJyfmO6Iwg6HQmT59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0MP0lesqO9QJLuNZuqJ+lowPa1MRxTtgGDfKxG+tTg=;
 b=QeCfnO5DeHmp0/nd9tmxtSMOvLsZV04B7Bjq6xmoxyhhRkgyCla4XZDipXJeoKsvxanHJbs90BsgvA9xXuPqYEeAeFhsg2ZpSJxWWwMAIsk8WGi83dmlLIOMJ2+OUy5o3kDcnB+ClxOFQgE6SsA6PuHlIUKn3MhUS288c5VTxiEahyoSSstERbLyAOwYJKtF7USKlJNmkKJZdcnKg+FLR3kdk+rbh8xIKQLEr7DijodfiR3MawIaL+ElzdHyU/xOWaeqsHFBLaQGByIimshHydDTB7pQcxMf111WnO0tvjqENiraG7NRta3IeyvtRQWIbJzEGnf38Z2BTAr/lixamA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAWPR03MB9081.eurprd03.prod.outlook.com (2603:10a6:102:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 13:57:03 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:57:03 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 2/4] input: pwm-beeper: add feature to set volume via sysfs
Date:   Mon, 30 Jan 2023 14:56:48 +0100
Message-Id: <20230130135650.1407156-3-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130135650.1407156-1-manuel.traut@mt.com>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAWPR03MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aef2ab4-723f-4c09-1fb6-08db02c9ddc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJpQOWVSOnrUOGYzqVrBxsJfDjeeTPdW+MmPVu0/deaNp1FA1du205iRJYldTIVr6w+9t8yF4PKRLVDwEykH5TksxrWHsa1T4Ic3R5sdEI28mVS9/3cvxV4OsjFsTrsQrl5gfzHaCQT1b2Hhf3ZpZ2gIWbRpfZmujpzWtYFv8faVzXNP+odDocvNiPhCi9VqoPvol9x5ZY6xCzj6N5NX7bUTYktEbFNm3MJqu0x/z3ML7KUjQucdZ1G5insinS38dcnvyg3VGfZUQtC+CIOkepcU36YGryV4YbL7mDspPN0v/MIqCqf/OEMLEsjSSDD8W5xSVLTRz24of23RMweXkQrGhNCL3rlUhoXRXal1IyxmNnbxS3954LqFWdYLNRbDN0xz321WZ55PTwMu/NMzseAYPBG/k/zFO8+f7YJa4DuRnUHpL765JGkF/3o3KVGwdqsv+PQNssjxPYDEzqqcXsNQxpnoJKVQVcUzS3EqqqflxlUOHmxOo57K6IHsLyDQaqLsodrbPGOHSGGuLoELizQ6FUH5kc2aOx9WcoBJam5zMZ6qSo9tApmfeDYjBTPBYvzC2QoC9/SxM9LOf+vfoGqfUU97ijKIwNuf5vv2CJG+dh+0Uw5ZF54q28lUcaBDxmtwF72Dn2UArlnXPp5RjSh07sCpVKFb6SLfPtjWjPsrt49q2vWdjjVYjko42EBR5d3R91s2kZcZdqHK/U5dGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(36756003)(86362001)(44832011)(38100700002)(38350700002)(2906002)(2616005)(52116002)(6486002)(6512007)(186003)(478600001)(1076003)(26005)(6506007)(83380400001)(54906003)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6916009)(316002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHlaaruGEepZHTVI/QIIxzvC9gUbPBT4EC8SDtZsv9HP7RRH8aepD7U9+KQp?=
 =?us-ascii?Q?fTGUQNWVPUx9fDxFKtzJCoHYRNSOvk7WIoTMjJjOiMbn3lZUvWfd3Fjn2GvI?=
 =?us-ascii?Q?LNmX6vxadQ6WW6WGLKjNoqzTPLTceV1kexZrvPEjlMHP00WZ/9j7mf0cLIZS?=
 =?us-ascii?Q?T3YpC4+++QaEyhAdvMpNImyu8jOZJxHanXY/ngUWZ0e63iyHaRyTaxVVvaYP?=
 =?us-ascii?Q?U497klK0EWqgBOMF+PHhmP5iVHcWYWHpW4+i0/VBNoKxpSxuv+CKzbz0AItS?=
 =?us-ascii?Q?welSR0CRNyRwc4Ac0Tl+mQqrG8KfyObSn+JFK3vUcfOoUKnc8c5Wkvv1KuCk?=
 =?us-ascii?Q?UQv9HgvTreAe07Nbp2Q2ViMOZAwH60XKiXHnt5tRAFJxRwxmGq2pMvZw5N+n?=
 =?us-ascii?Q?MiQv2X+oNosoi0JyJ6bEvNMPd148K0Y0XDqn98eHVUp2cq2JocJEum0pzDqE?=
 =?us-ascii?Q?kPE798YA9sM/BGkiWIbV+lj9+oUbEOO8JaoYsDcaDIRxdMuFAPQ63aWuZrjF?=
 =?us-ascii?Q?QXyZ03hnGtJ3WZnpwJgYJNl0bnIYzaWyNAO07Cxsrsx5JbH+wLEbJdcljlsn?=
 =?us-ascii?Q?6K5K8xY2XeNRxF7uM9/ORvUGlZPMTizEQ0iaTWyKnA6x3Ya30yJttpO0gGH+?=
 =?us-ascii?Q?0nW7Q44Dz4aKouchmfxIqjSKX6WdcxGcQr4wVUzMYR9KkTD2dtmdSYQK64Fh?=
 =?us-ascii?Q?aM1gChShR8XawCKIOVFE119MKcUTiOgxOIosP6OeUx7yy5uyJE1ritudo/Z4?=
 =?us-ascii?Q?70RXFcu0Oza04L/D2wM3fbhIil2xVTO9FFslJu2toCVw7vdePV2dtEye2z9Y?=
 =?us-ascii?Q?9CATnS5chtuKxLNWoj96Df9wEscO9awoDbvRqjeQ8l+hzhzKIkcLmwr3w9t0?=
 =?us-ascii?Q?XW9ByOeOn4kWVW3TCHCr6T7J3Z6ANysrrZkF4vNkzlm/U8GNZ5XU7VWb2eFC?=
 =?us-ascii?Q?sflscM1TbAopXR+H3QdwJMtmbvqHnZLpdvmE3CF7lE3Pe2uMJVyOcsv+m+Uq?=
 =?us-ascii?Q?oWgAG/PGN6ABi94kKpSNATn+tapWDHSBuF3KILH3KXAL+hKa9R1wQ9QijWHt?=
 =?us-ascii?Q?dDi0izC/xadpXqBCyPxG2Uo5OhCtwaU4goDGxbHwV00rKy+s7y4rWOQhnIDc?=
 =?us-ascii?Q?3bl2DxXFJ1icnDH72fTy7iyBko6VedtuKPL3JPAHZxc6wXXgDjszc/vNzh6x?=
 =?us-ascii?Q?qpszn9BG2Xpmo1HIQZ5gzjQD0RuIsNsqOaV+HD1NQFFGKGe9Jm0vSYsASEKd?=
 =?us-ascii?Q?DK0Uxb5+9Pi1gX1OZtOhhFOb5oxZg7VKwyp2WvQXabVoxcEkujLEg51pwkZK?=
 =?us-ascii?Q?ARe1yOj35ZRWW6k/wrGPMFKUTENRUbyN/CjuhFPrJ/du2FD8EF1aHkNX350Q?=
 =?us-ascii?Q?PdOm4BdM2h6FzVm5Z1FjVzfttcpruxHsTgazMzF/zxw48BOMZe6EyxRr0mjK?=
 =?us-ascii?Q?/dJxEpgQlDLsjVYqavS8MyZ2Ld9VY9qovqd5K4Kc2EmwK1zSbr3jGXvV7ymG?=
 =?us-ascii?Q?+HnkwiwWJLi8a8gJZFGm/YvdtNw+EcyAJDjDQDISZzo/zfq1unas4d9H9gqE?=
 =?us-ascii?Q?Dfhm4W8HVdmvsyMjodGzfHww+79ahausMLDCDpGR?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aef2ab4-723f-4c09-1fb6-08db02c9ddc3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:57:03.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Yiz15/qbilAQgPMBOo6b41FcYW5nKy2MBVW9VtYPuQb5nuS3Fh2XLRELLlCuE9u3P21aAHkwylO+Xk0noLelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The volume adjustment is done by changing the duty cycle of
the pwm signal.

Add a sysfs interface with 5 default volume levels:
  0 - mute
  ..
  4 - max. volume

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>
---
 .../ABI/testing/sysfs-devices-pwm-beeper      | 17 ++++
 drivers/input/misc/pwm-beeper.c               | 96 ++++++++++++++++++-
 2 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-devices-pwm-beeper b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
new file mode 100644
index 000000000000..d2a22516f31d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../pwm-beeper/volume
+Date:		January 2023
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@kontron.de>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/devices/.../pwm-beeper/max_volume
+Date:		February 2023
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@kontron.de>
+Description:
+		This file shows the maximum volume level that can be
+		assigned to volume.
+
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index d6b12477748a..214d3fa0a06d 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf@kontron.de>
+ *  (volume support)
+ *
  *  PWM beeper driver
  */
 
+#include <linux/device.h>
 #include <linux/input.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
@@ -24,10 +29,61 @@ struct pwm_beeper {
 	unsigned int bell_frequency;
 	bool suspended;
 	bool amplifier_on;
+	unsigned int volume;
+	unsigned int *volume_levels;
+	unsigned int max_volume;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
 
+static ssize_t volume_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", beeper->volume);
+}
+
+static ssize_t max_volume_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", beeper->max_volume);
+}
+
+static ssize_t volume_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc;
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+	unsigned int volume;
+
+	rc = kstrtouint(buf, 0, &volume);
+	if (rc)
+		return rc;
+
+	if (volume > beeper->max_volume)
+		return -EINVAL;
+	pr_debug("set volume to %u\n", volume);
+	beeper->volume = volume;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(volume);
+static DEVICE_ATTR_RO(max_volume);
+
+static struct attribute *pwm_beeper_attributes[] = {
+	&dev_attr_volume.attr,
+	&dev_attr_max_volume.attr,
+	NULL,
+};
+
+static struct attribute_group pwm_beeper_attribute_group = {
+	.attrs = pwm_beeper_attributes,
+};
+
 static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 {
 	struct pwm_state state;
@@ -37,7 +93,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 
 	state.enabled = true;
 	state.period = period;
-	pwm_set_relative_duty_cycle(&state, 50, 100);
+	pwm_set_relative_duty_cycle(&state, beeper->volume_levels[beeper->volume], 1000);
 
 	error = pwm_apply_state(beeper->pwm, &state);
 	if (error)
@@ -126,6 +182,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_state state;
 	u32 bell_frequency;
 	int error;
+	size_t size;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -171,6 +228,24 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	beeper->bell_frequency = bell_frequency;
 
+	beeper->max_volume = 4;
+
+	size = sizeof(*beeper->volume_levels) *
+		(beeper->max_volume + 1);
+
+	beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+		GFP_KERNEL);
+	if (!beeper->volume_levels)
+		return -ENOMEM;
+
+	beeper->volume_levels[0] = 0;
+	beeper->volume_levels[1] = 80;
+	beeper->volume_levels[2] = 200;
+	beeper->volume_levels[3] = 400;
+	beeper->volume_levels[4] = 5000;
+
+	beeper->volume = beeper->max_volume;
+
 	beeper->input = devm_input_allocate_device(dev);
 	if (!beeper->input) {
 		dev_err(dev, "Failed to allocate input device\n");
@@ -192,8 +267,15 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	error = sysfs_create_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", error);
+		return error;
+	}
+
 	error = input_register_device(beeper->input);
 	if (error) {
+		sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
 		dev_err(dev, "Failed to register input device: %d\n", error);
 		return error;
 	}
@@ -203,6 +285,17 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int pwm_beeper_remove(struct platform_device *pdev)
+{
+	struct pwm_beeper *beeper;
+
+	beeper = platform_get_drvdata(pdev);
+	input_unregister_device(beeper->input);
+	sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+
+	return 0;
+}
+
 static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
@@ -248,6 +341,7 @@ MODULE_DEVICE_TABLE(of, pwm_beeper_match);
 
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
+	.remove	= pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
 		.pm	= &pwm_beeper_pm_ops,
-- 
2.39.0

