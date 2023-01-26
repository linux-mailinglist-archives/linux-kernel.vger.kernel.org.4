Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D367C6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjAZJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjAZJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80E6DB14;
        Thu, 26 Jan 2023 01:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts1j73u6yCokLSghILYKzhv2CbswEGE6sAy25iCtcFKIZuW2tGlIVIAkrv6FJR1Q49O6qCZRbRTxGfn55uGHu9xgGI2TvQzmJRw/XoOnL0I98DwxR4mQDdzrtiIZEwaZfIjSRhW8RqGXtDewnwBxR5TXNV96HfCuUAQX0yKrfMMJ4PU9joVndM2wsvnlkeh3kUUVFy6G95VzsRPaDHu4BsFR9BrTS6UuSKd5VEuVRzQcBZpAIaVcWk4V1qCvF/Wf8fKle1vwxUQmsHIydjLGMH8xjytyV8x80EE5sTOKcSs+TP1Q5jj16Kjdd5rigFQ8sKov2+3nsAWkLFkFApT5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qZ+QAPBkkp6i4N/ZgKEFvHq4ipLNJJbcuwCaeCLOdk=;
 b=dAR+BmahHX63Y3xmRwvnu8wq+zhRf7SZpqx5BwQu0fV1jNy6AzVrD1g0HnGTXIP8MvzLKhOVDA23zpgadNWbLTwBjsdSsQ6CBxDcPGTa9z8JACnjQQ8KoioRdcvqQ0ZBwPp4wgxcDK71BW/6z38zHt7Gcp92jfZEd+VggX5ICEghEO8u3YkuFP3Yf/u8/EvZUpWVThHWbPLmN8qU7LtAd+r5NpY80VBQnzfHcIxf2Nqc+uI2W7Kk8WVdwydSU7T1XXRZaE0xkgR5kkR0mhTKxGIuhp6AsvkZoU3Cg9L5gSmza+RAW7lqp8lA+fE8r+RBHnaaq0jIx0JH/1/jU+fkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qZ+QAPBkkp6i4N/ZgKEFvHq4ipLNJJbcuwCaeCLOdk=;
 b=H+hNOrhAdyHFoLTE6NEm0IlUKrGhPKvL3InOHiCjYogQpj+vgIVaEveJbi1pOPTifS3is4iHYaiW1vdvIOGXphLo4N17grGOifNCa7Zh/oBa9e1DMEtupbNoheC0krtmY5xuHSOd5Un2ZNsrSw+FfhmsMhotdBOBPaOAxBBlqB8HLrIG2lQc/4ulKisiRKsXV2OgeSCBXFuy60eJpPGd6W/qtqU+Z/gG9emy4h/PbAVYG7v0oz6aKroEtQH/Rp3S06dMqW0PZeKLFnYTDmjhgy5+2zdQMwddWB4WTJ1q3lUcFjAbrHZ0DCdDujL/vtaTKFqG2yaSHCgI7DFQ7aNDvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:50 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:50 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 2/5] input: pwm-beeper: add feature to set volume via sysfs
Date:   Thu, 26 Jan 2023 10:18:22 +0100
Message-Id: <20230126091825.220646-3-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126091825.220646-1-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdc028c-31d6-4b42-9b71-08daff7e55be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWhvEMT4c2QiWAg6e6BKS5E9eCyeL+NL0LHA5I7JMzSu1rQ4jiuQBlR23z4wKO7QU36jolttbsfESC5WSmQdKkZnbZtdH0UhnhWcgei8ZRlQdrnpPQb6AU/BpSHwcytWI0um/uCEDaq4BQhZcSICk/nmJNWJqFnrJ8Fr5GNlY4z0BK2VjMW2j9TDmJPnX+vRcJq/JEWoENiOpMvCC28CK9UjFczMOHI2j4jqw9uS88PoZ/Thc1NtKXHXl+bbs2bQM6n9dYV5P7VA5jhi5XKsdJnHrlBfKLylQVWntExUzqjNOdDNB9QDCsKzaUaDGF4BR5vMaRPnf0oZkoJkZO7s0CNJ3hFjuCDtS10abslUdW/Q40OvOFEzewK7tE+kHUAwowECuSdZrOpCHUVRBSpKL8xhskQT4xoBksS46ZJkuXSFwOPvXrwv2r9pN9CH4KU7EhtxzPeS+HDdtz9nWiVGQt3OlRlNTgDxHfXu8dU7VAKGHABVJgUSyDH7hWLvzi9x9qBlneqVR4o8i9oHdUE1MhdojzfYcZFFA+8DFqtan73LnlZ0wA4vh/YxACE7oOmZ5AB+ahBBhZFJCGAHi0ndOqkX1k7orddnrKWucbjo14218HBP+4WWXoCj7BXG5GT0BYxE33IMreZrFQU12rT3GAMIluy8Tvs6SXLDLObO8SGeLyxBi0Ve6lzzYMI7u6JGg55lDFqVIFEWaptGlGPzKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(83380400001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LRejyvnxgnm5Whf0ZFrR6kzok95QMxbHsPuh95Pw0XcNcPKKI6LQyU8NI36l?=
 =?us-ascii?Q?lyx6jKa1vpUpWbt0GI2ltX5knT4dB5W+LCJc73GMPzBkx69Y9IE7Ks2YCjKG?=
 =?us-ascii?Q?/e61kkoNW28qEGWcRhAjvHttRobAwdviPVS1/8Zd6W+Gd3ef3IvAjoj/IQWW?=
 =?us-ascii?Q?v92JKZVRRh9VP9JdUCDgQefPTXg/uLml7gE2cGGmymW8w915Uh/W7mu8w1OV?=
 =?us-ascii?Q?EzTbw+6fFsuMStfmlL373MxRu0NK7JYAgm4Jtaedz2Nes+899oQG8yqwnYRf?=
 =?us-ascii?Q?k+UQo/VVhBubZuF7yxNkuGyFu2FmfVEx8junYe+Io9mgcfr2gExA0QUUgU+U?=
 =?us-ascii?Q?WgtakdH6wAVUM496ZM72fUnadrJirEuQvsWoVdp4bmUGyOIe7jDwhRs6rjKy?=
 =?us-ascii?Q?PLz6guYd8eogK+KPhd3hHBRj5MfznWNo89wLbNJYkaDLcv9gWpum/T8+UOyi?=
 =?us-ascii?Q?eV2TRR9nBtOYuA24mZklavhPRzIDRwxIov549igyx6G7wa4MA4b9cfP9VVXH?=
 =?us-ascii?Q?0rx1lYpS9VUD8VNeIHIorNjw+3/s7XlpcvA4bV+T2ue63R/0aM4CjKFJF4oX?=
 =?us-ascii?Q?hsPNN3LEfcswqYCllUuv20bMGn2Vjf/MbvVT91jqYPb0XcNuxOH6VXKxtWGW?=
 =?us-ascii?Q?HwXjwbcBj2y3QHAS1UJJLbT+QWFSNAm1rjalzSEXWMyJG0SDnaxcENEqgebx?=
 =?us-ascii?Q?1Kfj/Rnbh2c3GBqmUA+OFEPeHNnOD33OFk2kF76xLN4hJlznZr9wamIka0qa?=
 =?us-ascii?Q?+IFbEm/iti3TNKF2xZ+K3F9jk4vMwrm1bb2TN9MHYFso4wK0LTMv4iIhMBn2?=
 =?us-ascii?Q?xGd5x1fjeicG65gn4AV/1doCCW0eckr6l/LsYLdiIv7fD7vK2SETW/B/zKM5?=
 =?us-ascii?Q?RI7T8TeR2peh0kaeNjPPOCEJLDL40i5atXVenpBNQDdaXg1ey5TGLFBkEu+X?=
 =?us-ascii?Q?caMzwjTtAxsdgIl9XgXeg6og5ScIPSTlRZt6k0EG1LK9T0CxmZzdD+o9aukG?=
 =?us-ascii?Q?Z+nGsh/m1VaFhUPGOsglksqu8MllNoUhiCyg+utf+frGxk6tOLGpzzTLLLB/?=
 =?us-ascii?Q?Wn5yMZ8QLqIpAYYqTRtvZIB+Z+P7iaCze4pC7M9IR79g7d4PMv/M+f7L+y8s?=
 =?us-ascii?Q?1d/CkEZZxVAvDMPnh8pLFStrkPTWyBQP2KSlz3Y6l81l6AgD08qPRlKhTqGM?=
 =?us-ascii?Q?ld7jdKWHsr5yhi0+A5L2bLFt/lWl6i3jW6BV0bc+6BeWhwFcfc+mYPTYGerK?=
 =?us-ascii?Q?ZWaMMN5zkjfG9q67/s2TB9cA4jK5f+mC1euxL5KlPADv1nWhyCYGjvC8Wc+R?=
 =?us-ascii?Q?i5eaSDaw2NmRPsZROF+hid5v885vAy/ukvwqX1KRKdGq5Adk6tqX5GTTDttT?=
 =?us-ascii?Q?gOkwK7co02WnuLY5gU5+wpsSWElkPTrl/PfIuQOFw/oPTnPayL0zAN69VcR+?=
 =?us-ascii?Q?R+4b2rNkd4FupICf+SA66p3GhkK00BwWc/kNmMABVcqOG+ofkE2nDS5dXwYN?=
 =?us-ascii?Q?X/W/qd1OrdE/2wct6Ya+of4ccgXOZJ0BUsQEuVzQ32iTHkXuF4xVbWx2OfuU?=
 =?us-ascii?Q?WHaiwKmc325MehoNfSobznB7/jaExY2WeYKxcr7c?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdc028c-31d6-4b42-9b71-08daff7e55be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:49.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZEFnC/eATQoNK1o6TjC9fFW1ZhVjHj+tZL5CcNFGF+x2i+UtZxZlnEkYSH/zHHxtVH5Go6/gJcy0aEIg1M6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9516
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
 drivers/input/misc/pwm-beeper.c               | 83 ++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)
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
index d6b12477748a..865e1ec5c39d 100644
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
+	beeper->volume_levels[1] = 8;
+	beeper->volume_levels[2] = 20;
+	beeper->volume_levels[3] = 40;
+	beeper->volume_levels[4] = 500;
+
+	beeper->volume = beeper->max_volume;
+
 	beeper->input = devm_input_allocate_device(dev);
 	if (!beeper->input) {
 		dev_err(dev, "Failed to allocate input device\n");
@@ -192,6 +267,12 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	error = sysfs_create_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", error);
+		return error;
+	}
+
 	error = input_register_device(beeper->input);
 	if (error) {
 		dev_err(dev, "Failed to register input device: %d\n", error);
-- 
2.39.0

