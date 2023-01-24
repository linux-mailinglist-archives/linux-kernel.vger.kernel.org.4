Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F881679EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjAXQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjAXQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:41:09 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2122.outbound.protection.outlook.com [40.107.241.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F249020
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:41:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMm4Dl4UVIHfu+iZhufNxmzDeBcUGIf0GsWQyq2jdtpW/Ln2Gt2f6H6tImkF4egJh9w256jpFeWmt3GfNpM1LYorz+3xQk68mxDXP5LzXsWjjFHYd7bHPc9GNSg2SZXvuaJI72RjJiopPR9nassUbX/IRveJpdCVVLuUzKyD5XHtlnhg/UUFq+/OhwihPMz0Q4UFjYlpOLZF46HM1Dny9YX6BoFOcW3uAzcJxgIDT+almE3Wur+vsWr11GrDiLmyxdf7+nCVOqvGH/b2KR4TVk+JNjGxA58DfM6lTXy3fR2SzJdpADK4/+jPsSj7oDDfgIzBBUStQxF185mjU4jlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGGzLFLmfnBZaHGdccMyfAmnrSmSHgOf2zOPUT8XUpY=;
 b=hgCtvsgqvFb5Nz/9Z1lpByYsx6GzhQHRymykOCgHhfl5fXa7d5m+Rx3OkcqDOqVty5RMEbLWbaT5JY1ePaVpuHmRUcUggShnr8MAPCb5wLAJH5lAEcCbKF+buxp6YEKiwJQ/rqh+XAWe4GZr6dTHa3LnPyHtCEbG4nLcUTBL40V/nNUKRr3uemtKhgRLa+RUFtIQW6PSYIuB3YKHD/2KuzyDUW3s8pzXDVbx0sDYsMmJvt7OQCV6KHLbtkTiGsBXtoQC+iHMF7diihGYzDpNEVB++9SvzhbRXxnrwbB8FxHwvMliLv7jood/2rB1Vp2vLP+FZBnlhtbMTPmMo0FK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGGzLFLmfnBZaHGdccMyfAmnrSmSHgOf2zOPUT8XUpY=;
 b=RV/ZVv9Kb6UknLqjQKOZxl1YTgsgZrcnqOnjRC8AcPp6THzV/rvm9F8hk5DZac+123KboOtOxQx50URjT93NXEcX4cFNTZQSDx1ABEr+94LuPHLSnhv7zqo/t+kI+J7vTnJGg/wsnYEBauyfF3e1jOEGViMIKQ88dgtwK79DuU6jBEqG42fBWobcLSoXWxBFPWqysObXCB21X9ONOwwKBqVdFRxzFFJ1nQTMfxOsaodU6qB+uL0Uy/LHMwAcyKDP+wM5sV9HsqOJTUSub+ZoDka+aVmuN48qXFU1Hbd7sSMXlPsXqrn6cbkQ5PADqAW6kehOqt2dPQJlWoff96HT9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAVPR03MB9848.eurprd03.prod.outlook.com (2603:10a6:102:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:40:58 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:40:58 +0000
Date:   Tue, 24 Jan 2023 17:40:56 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5 v7] input: pwm-beeper: add feature to set volume via sysfs
Message-ID: <Y9AKGLELrPEnw1jd@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAVPR03MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c29732-d1ed-420a-0e23-08dafe29c556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Set//yFatKlcQRM7AkteKHBS6uuptFZhILhlAtc3WC2dxrlnc29F8+KA+4vZftPWPmFKXsT9dBNZ0QDeKMWHsvSOK4fEzDMwShd/Ccl4nTNSdfxA7A4w78bc3Ek0HepuKdQn2Q3/HwFm18XMVpchTSPs+blOdwO6qeClxjZ6uE7Yk0n3CKueGPJTuuUkem1d9m73dzotkt7YTamhL//xsvwMboSwpM07HERHG16n0c3yHQvZjrAr8yzz7O4UZOf4DQYOhpb7dt8eoEhNIefbl67TAxMMAI9sTms74/rvZrvSGv7/Wzk4e1DfWCAkbsgCtnFW9SCwERgtiSQjSRMTPwYWxDuLBF6VVbCXxjIrYXp2mzO/oIEBBa5xseOUi2KD9JWA1kNkLOk/tBtnlFaz6BlqcbpxuusfPEjVvmyQgZQbnl4V80AnVzYODK1r53RLz/+JG+MQxL3ypaiYD8xJxBhBUJVN3sVPxBPMcPhMWl8sopM8YkMVY+TcVQDjdOnlS4tfpLHb1cZS+hRaIoMzETvol5ryzj+3SXfdlnwEw09R3xREOJJofRZGm8p6LDCqNEOqyXZkV+GHX/C6GfATjqalfRP7uSnSbWZU+Kv2SINBsHY48cqrrUV7PpAlqzFCUJRH9hw03FpXB8ze8CQ5isHPgT6zTVElisqraLo68K7J1rRn0by9KuRoWSS1Qdr1pkiFWBXFraDmbtgwKmHKLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(38350700002)(38100700002)(83380400001)(41300700001)(86362001)(44832011)(2906002)(8936002)(5660300002)(316002)(6916009)(26005)(6512007)(6506007)(8676002)(186003)(66476007)(66556008)(2616005)(478600001)(52116002)(6486002)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRPTTE2WUdjQVlWcmQ5dVh1OUQrdnhNNmFTSFF5MFNSN2xlNysvWmVobE9j?=
 =?utf-8?B?S0lxcTI5cnpCOERRYkdvZnJoZlFxZDRFL3QrMUpXbEtoR0p1S3ZPb2luNU9w?=
 =?utf-8?B?Vk5tcGl3aDdIUHBWYjBSN2hDcDN1VzgwbTFCeGd5d0F4cGp0ZlBvRE9idUxC?=
 =?utf-8?B?U0ViU0JTMENyZ2RwemtVMS9tcnVSREdBM01KUkNKdlowY1p5TXFqend1SmM2?=
 =?utf-8?B?eHFFSjAxMmNSSW82Mkh4YktZNlJOTDcwZkNtSThMMFBoZGRwVWdDNlZRa2JF?=
 =?utf-8?B?Z0tYVk1INDFGcVBHaUxhdyt1R29WdmV3UHQ0djdmaXhaMmc0SFF4aVFVeXRY?=
 =?utf-8?B?Y254Q2c3bXBuR2RWbUt4NU5mSkw2WFVmN2FhWEtOcDBDVDlvY1cxNnNFMHF6?=
 =?utf-8?B?QjJLanBLS2xOSjZySXRJYXllN2lDUUFZUERTc1FGcmUyR1k4aE1DLzh2d2VI?=
 =?utf-8?B?TTVpYVp1a1lkbUk1enU1SlRTK3o2Q0JPU0ZwMFhLSmVRalJrZnhmeFJEVTN4?=
 =?utf-8?B?Z200Mys4Q0diWjBvaE5tczh4aHcvUGgzVEhOK2lSWXJOeWZPTVo2cHRqUXor?=
 =?utf-8?B?aWQ0S3lQV2ZZOWxuMDJ4TUlvL1RtUU5MSmgwcU9OTlJrWVN5YUJSZzNzYmZQ?=
 =?utf-8?B?MWJWb2llKzFid2p4K2F4VTdOWEV0UmhXUXVJWktvU2lJUlNNeW1RTVlWelRu?=
 =?utf-8?B?dnhtMWZJenFzUDExUy8xVHFnOGVDWmQ2KzMvM01EaEV3OHZURkpUOFNWWTg2?=
 =?utf-8?B?K1lQRCtnMlVhMzBSekI2anF1YjFFUFM5c3kvYTBuMWFSWFA1RHY5QU16NXNT?=
 =?utf-8?B?ODljanVqK3R0YlVqZ0VVUWpJSjhJekl5NlpLRDM0dXo4UjNNSnBjT1oxQmd1?=
 =?utf-8?B?Q0JZRG1QV01DZVEwbG1pdnlmOVdWV3ZKZStTMEZLNjl4K1VpcG1vYkc5b2sz?=
 =?utf-8?B?cTVocG1sNnlXSGIxQVJkZDNLWWFvM2hxK0YwLzl6dWJmdkUvNVUzNG8vMTJx?=
 =?utf-8?B?QWpUUzhjdWpmYzlnVWQ3czgvSnNNSUpYZDhkY3M2L0VkQzdXWERYL3pmaWkw?=
 =?utf-8?B?ZXVtNE0zclNQbGJnaHRFYllHYzdySjZXUUQySFJqWjRqdW5ZTUVlSTk3NUhQ?=
 =?utf-8?B?UHJQcEtFL29pZmZSSEFFLzVobGJ0REpueW45ckQ3OWI2aU9VUDJ1UEVwYnlk?=
 =?utf-8?B?dERocmx4SCtNRXVBUFBBa1c2MDZIRXhId2Y0MUx1NVNsQ2R5UHBMRE9WTHZE?=
 =?utf-8?B?eWl3RWY4Mzg0M1I4a1ZyTzBjeEMzUDVvaCtKN2Exc2R4czJ1TldaYW5URnJs?=
 =?utf-8?B?UC9CVjBYWmxGZ3owT2M5REM0UWtOSEhQZHVwek9QSytEaUhHSWcvTHljaW9w?=
 =?utf-8?B?dEhZN3lrZmNHUlVtaDVRVExyUlpRTEExdU1GSFp0RmRNZnhUSldETUpGUTVN?=
 =?utf-8?B?RHhMakJjYmkrUEFXYkZSb3ZUeXh4T0ZMZERRNFVDb1ladm1Wd1Q4M09QbkUz?=
 =?utf-8?B?RHRQUXYySGhHUXNGQ1JKbklBRWlSWHJKZkRZL016UVorRkJaTDQ2N2hoZytK?=
 =?utf-8?B?amhwS0hKRnVrc2szNnJQZERLYzltU1hvQTJPUk5ob2JYRHZEWW9RR0sxN0R4?=
 =?utf-8?B?QTdwbTR5dVlYbU1oNmZBNStsdjJZeGNxMDhCeGE4cXh4MGZ3R1g3M3B3NnlC?=
 =?utf-8?B?YUEwQytzS2pHZUJlN2dXRGZMQnVxTkhXaFB6TC9ScTdFeVduUndYRDh2NStE?=
 =?utf-8?B?WVB5d2lLUzRvUk5uSW10VVY0M2UyZmc1Rk02aU9qVW10czJjdXc3cnVOTXdT?=
 =?utf-8?B?ZHZmSjZaeHpsa0duTzVkbjNqUzBsVS90RkU1RGRIMWhBNk5zb1gwWFVQZkRM?=
 =?utf-8?B?U1ZTczcvTXJtMXZEQVZCRk1MNlh2SFBHelhSQ082VzdRZXVpbUNrbkVLNEd2?=
 =?utf-8?B?M0N2eWptMUNNMnRzYzlwU2JqQWJuWFg1S0MvVi9JamtXUnArRXg3d0dLTlQx?=
 =?utf-8?B?Z0tFVVo2bWJHdGg5bzl4UFpub3pXSGZ4S1NDVnljY0Z4emVvOStOOTNSYndv?=
 =?utf-8?B?ZHJyNVYxRXpMa3RtVTlMQjA5UTJ0L1gxR05wc3lPODNCM2R5YU54dStsUTJj?=
 =?utf-8?Q?4yqzx6NxqiCcJ8Id+crG4uXrP?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c29732-d1ed-420a-0e23-08dafe29c556
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:40:58.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX/88pO4yUnSUtVTBjJspqTZmq0XN0RULndfJ70ABazVBtpCeDZ+y/o713jz+voKXC3H+rY44D2SNSIzFfEeIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The volume adjustment is done by changing the duty cycle of
the pwm signal.

This patch adds the sysfs interface with 5 default volume
levels (0 - mute, 4 - max. volume).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>
---
 .../ABI/testing/sysfs-devices-pwm-beeper      | 17 ++++
 drivers/input/misc/pwm-beeper.c               | 84 ++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-devices-pwm-beeper b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
new file mode 100644
index 000000000000..8424b6776ca9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../pwm-beeper/volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@kontron.de>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/devices/.../pwm-beeper/max_volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@kontron.de>
+Description:
+		This file shows the maximum volume level that can be
+		assigned to volume.
+
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index d6b12477748a..fb7b377fee6a 100644
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
@@ -37,7 +93,8 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 
 	state.enabled = true;
 	state.period = period;
-	pwm_set_relative_duty_cycle(&state, 50, 100);
+
+	pwm_set_relative_duty_cycle(&state, beeper->volume_levels[beeper->volume], 1000);
 
 	error = pwm_apply_state(beeper->pwm, &state);
 	if (error)
@@ -126,6 +183,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_state state;
 	u32 bell_frequency;
 	int error;
+	size_t size;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -171,6 +229,24 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
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
@@ -192,6 +268,12 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
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
