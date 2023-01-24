Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B9679653
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjAXLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjAXLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:12:57 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F512F0C;
        Tue, 24 Jan 2023 03:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haRov4IJm5Xlkmk1hTzh/6M2bVIURjZi+zLwNvNrzZvNCWefm6VVePR6yfZAFspWYyuqKGurkYln/nyL26+5wAsMK7YXJ79GKIIz796f/2UcmY1L8Dl2fwgHNPWQUUeru8a5dnmYwvCIuXE/rHizP9klqGL3LSYkYTc/agi3LmiWk1dbeg6jGWzF7sLvwRFmQNExpcujKtB8PpP9T0XjwTmpNdHhg8xP6Rz13kuz2DbRLXUXo+xeDoXaxMYFHHd370Rn3z8MCN0lnKSH1cQ7z013tUN0EC/ecnxI2/km+tV+F4eDnAy+eU0ERe/ZRi3KQ3MhX+FB9m6r4j07VUkdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PaccwS4l3/4bLgvse1Lno5JdofhRgcC2KeXYT9suzc=;
 b=ck5yN6K6L8t2r5CTGxGMx/pMJtbv5WuvWc3oGzNYBeJtJAvu4K0U+bAznUCkkiPQvslDPpOnZ61R4+GzacTS0fSYstPf/gvl0DRw+8mxjmW4t15q4Dy6w7vzNQ8x5oBu6WgjZEJsANhcjyKzg1pcmni59/bs0p/zN9C0NC6/nNSVeaFMVGLcIOHkza+5/aS5fMCOWhxOFhYzI4LEKBLOqMDBNwfuDqpzH2YPPd4IFnK9gNXVFlAYRkw64ZgjvBE8zFQ1T8E2LKH9QjULq2ximw/ZawLAg31u9m32luR5E4CK877d7Ud42uzmHkMZNZSK6wQFLWVA8LgUGJjUl+2DDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PaccwS4l3/4bLgvse1Lno5JdofhRgcC2KeXYT9suzc=;
 b=Pzqj8iryzKPBRyaTr8fAsV6jSr0UfGvZsVHfiCWRbgNCGK9uaBSvbd7i5RQnJvwiiDgB8Csa8n9Bbh6mYGzXNcoR7l/ELlDBXlneu6iuoc7ty3iETdeD0RYZnPzW1mfnW9ywpjKPd1zsQ5WsbuZeyHaT2iGKkNZ3+7ro3ZqorkUWTGJ6AuM2Z+L6uxgdKCgu0DprD4Cjs+38na+ajNrP5L+BwS5ZWJ7YNZWC/W10Op0e3/PLOcTjFeCTX2hlhAWWfxGAQ365lmXRlYiqEDbax6i+HQez43jLZnCVl0D8B1wdapF9kcv0DWWlMQiKdLX/ShCislX4ZKPZvNyf9c7cOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7995.eurprd03.prod.outlook.com (2603:10a6:20b:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:12:49 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:12:49 +0000
Date:   Tue, 24 Jan 2023 12:12:47 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: [PATCH 1/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <Y8+9L7UincSjIaD9@mt.com>
References: <Y8+8824hy/fWkpEk@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8+8824hy/fWkpEk@mt.com>
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: efd74538-dce9-4479-f93e-08dafdfbeddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ki+/FBkXpFzBQRdenp+1R7lPWALTrfLtIQPbldMEqMCcU4/RaAQWUheuR+rouZ8lzYhN1TAJpYxgcTgRhI4faPwkrbqOo/n6xie+ki3C2BTDexpXh75jeR3fEJSPRV1WHZohaQC3+AkPL5mz4VZN/+Rl93FYtY4p9MELcJ6f3FcS3XnDdQRqR15/Tb2ZA+GeZo6j6+kJxsF/PWhzg9Vnd1ct1bAscqjP76bomfdY7czNG6HSYpWn/GswbHeGvcvpcjeoeNeT6zsiKM8RXcHyzludqKqF5BNI2Ano71FRbX2kwgNqskHkPDDP/hKkZDerTmAIBg+hBDxv3yQA6PytW6ZmTd71h2WFSscFhUnhDvMGIJzhE9uFIVjgSkwdhjfbTzSNyuNY5GMGPCpbamUeMgmI2JceIS7/hlTJw63AFiGD1v+FJjPKWL7SNLkBkQLlejmksRx7PXH+3YNFVkU4BCwgbLRJIkCPzP2/o4ETFK4LKZhVPwkKz+cJahUXK4T+rsH9QJKvcoHQ8MQ/npUlFmSimV4MCPMGbl13/n4Z9Zxk5ar3KfM6rFtI5IvOrlIHj6IBHEBoloX0M4mNgR6jqVl6Ji/DgHX0Eek618UDWl+IKo4MFXtm3qLhJqoYcU50+IZL+XGL2JG6iDMU2zuQCW9JU1OLsSzxpdpdmgibAlnbyIab/cjlvMniOawXOF6p+MVU/Z4wgq5GWWYs3TSYDOAZ61GKYJPPPkD65R+ch7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(36756003)(41300700001)(86362001)(8936002)(5660300002)(4326008)(44832011)(2906002)(38100700002)(38350700002)(83380400001)(52116002)(478600001)(6486002)(66946007)(6916009)(6512007)(26005)(6506007)(186003)(8676002)(316002)(54906003)(2616005)(66476007)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXUvaGN3UVZ4WU9ocXpMdXdacmgxdEVYOVhoRENPcUE2R2NkemRQQWFabm9s?=
 =?utf-8?B?T3ZmMlJKRHYybXNTSXNXczE1bmQyOThFQlNPTmtJL3dPc0FtR1VMbDRiaWNS?=
 =?utf-8?B?djZaRTdVeDlMYmRWb2ViakxaVVEyQyt6d0oxbEp3dmczYzRFWmx3Rm9CeHZT?=
 =?utf-8?B?bGRnYXp2NEJKZmJybERmalNpaGVWdG9mTVpIbmF1clZGcjk3OVRKL2JCQWZj?=
 =?utf-8?B?UnlsWmFsVDF3dHhGOUpMbEorcEcxNkF5eU9UNjVSUStSamF5ZEp6SWErZ1hQ?=
 =?utf-8?B?dHFDYU9kL2RoejF2TFIwMWlzYWw3RHVsQ0VkdmxsMXBjQXJRaFhxb05Nek5Q?=
 =?utf-8?B?aDloNW0xcFVKTXowdnNhMW9WalJybnViak44ZVltQUZJVVI2MU1xMXQ5R0FE?=
 =?utf-8?B?ZTBvaHJHd1lMSTEyZ25SQ2xtUU8vckt6SzdldksxNFpHWnp4c1VkODJhT093?=
 =?utf-8?B?RVFIRHpnVWxPSm9hQ2ZCNXVoOXk0dEhnU09JUy9HRHQ0OW9LdWZLVzVZYzJC?=
 =?utf-8?B?dVZ4b0xGa3dFQWlFNzUyMExNTUVpcHREM21zTHUzYUZ1MVVITTBhSGQyMmtw?=
 =?utf-8?B?TDBMR25ONDlCYWJqdkxjYTV0TFoxSXN1RWZQSDBPdXR0ZlFNMFpUZy9nY0pt?=
 =?utf-8?B?cXNRZU5uUngrT3lTdEVtV1hGYXJBYUhPQ0RwNDhzY2Fvdnp5UnFlNGZ4bDZh?=
 =?utf-8?B?VmVpMllpRGQxaEVGZXFra01sOXNhU2ZiYmpLK1RQVHFmK1Erd1ZSbDRvNmFq?=
 =?utf-8?B?Z0Q1ZklESE9jejNEd2FUK1dKK3BIMS9hNzNRTm55RFBmcWxTN2EralphNkUw?=
 =?utf-8?B?L3Jsa1M2Z205NExMeHZmNzg1eDJhKzRKaUdnVldneXkyeVNDYmRzVTRtcTlk?=
 =?utf-8?B?WklabUR6UzljZU9Sek03T3lEZExFdFpjeDFEQXEycUZuS1JYWW1vVm5sNit4?=
 =?utf-8?B?ajAxM1dRVUtZOG96UjU3MEFmZFhBM0xERGNYdzhheklYVUhhOGRqclFSdnpZ?=
 =?utf-8?B?S2IyaFRrVTliTUpxem9wcEVoUTFPWFc0aEZaRENiUU1zanFNaHUvWFRNTUxm?=
 =?utf-8?B?TVdnejBrUWMvdEJjYjRvY2NyOHh0SExadkhIaVZESkh5Rnc5c1p3MGpvUnha?=
 =?utf-8?B?MmJYVHJMMjdHczN3WjVmTjE0SENhajdPbWJEZ1FTUGI3WFVzTTludlJGZmxj?=
 =?utf-8?B?akIzQ3RyVlJzOXpuRjNuZ0x3Z0hJdFNyemYzdHd3Q3QvY2NUam9JaTMzSk9v?=
 =?utf-8?B?YnZwdFB5OEZPeGxiYUJ4S2RhdTU4RnNrZkkyRzdUekN3R0FRcEVkOWkzVUU2?=
 =?utf-8?B?ZFJGMFFBMlJEYkN0aW55V1NEdXBQV2E5RDJJVnhqQmRsWVFkZWpFYXR1Qzlr?=
 =?utf-8?B?K2ZYOWEyYlh0QkUxR2dUa1hGWndmTlREdzBQdHZHN1d2Nk1jUyswNGpoUkFY?=
 =?utf-8?B?UTlRMExSbVB2WDhZNHpGSHRvbXlpenBienVTYUIyTjdHVlFlT1piZW12Rmpt?=
 =?utf-8?B?NTd5RkhoVWIvTFBEemNtdklLMUVtNmpsbkZvc3lweVU1UExKdFFGSHp3TnVo?=
 =?utf-8?B?dzY1RnU2SkRwTUlhSmcvU0IxYmhVZkdzWUVtcWxnL1NrS3hYSFY5TGcvK3ZU?=
 =?utf-8?B?THA5ZDQzSlJSdTlGcytMc1N3dFQydHFHd1dHYk5OMFN0SmRtQTFPVVBCVmh6?=
 =?utf-8?B?V3NlSGVxYlMybHlEL2dSczNacnlxVHVjcUJhUmJkRDRzSGJFcHFqTFpLWmZP?=
 =?utf-8?B?VnQ0L0FaWXQwSXkvT0s3eU1IOWJFQ3pKeVB3aDJlZE9wYzhNbks0Y0UreHBD?=
 =?utf-8?B?OGIrbzJwMWg0TGZlSGVGRnVaakhxdmVjbDUzRW5wTndQelZtMW0wbDFwanZa?=
 =?utf-8?B?bmdzbjU4anU4L3FHQWFnbzRLQ01sZ1V6RmVyenZqK2puR0NnZjZDaDhjRkdS?=
 =?utf-8?B?VzhCeVJCeStVcUI5S0FINWxTcjJScWNpRWtpRnNZNzRCdWI0ZUF2a1JEYWgx?=
 =?utf-8?B?aXYvNDV5a2h5VVJsRm1XTi8vdklVNDNrbittOTVDUTZaakt6VVc0UTFDNUlI?=
 =?utf-8?B?QlZNQ3pra2JWMkhiYXpLL1VMTWhvc3hyMVVROWFzM2VML0hFejc1VFVlbjU5?=
 =?utf-8?Q?mYzMgh0YI6j+I2tg0gyBS2dI1?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd74538-dce9-4479-f93e-08dafdfbeddf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:12:49.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8imOwNft2zyERwAoinCml2RtgIFOnzLeLNVZjRFF1e4JsouqHgUS9gCNqiL34QhzrXEUnZhloaiMloUSNXdsZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7995
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

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 .../ABI/testing/sysfs-devices-pwm-beeper      | 17 ++++
 drivers/input/misc/pwm-beeper.c               | 83 ++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-devices-pwm-beeper b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
new file mode 100644
index 000000000000..d068c5814f48
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../pwm-beeper/volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/devices/.../pwm-beeper/max_volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
+Description:
+		This file shows the maximum volume level that can be
+		assigned to volume.
+
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index d6b12477748a..fadc73e1c89a 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf@exceet.de>
+ *  (volume support)
+ *
  *  PWM beeper driver
  */
 
@@ -24,10 +28,61 @@ struct pwm_beeper {
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
+static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
+static DEVICE_ATTR(max_volume, 0644, max_volume_show, NULL);
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
@@ -37,7 +92,8 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 
 	state.enabled = true;
 	state.period = period;
-	pwm_set_relative_duty_cycle(&state, 50, 100);
+
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

