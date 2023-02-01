Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED0686A21
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjBAPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjBAPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:22:21 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464617164A;
        Wed,  1 Feb 2023 07:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOCvVi5aI1kL/nu1j/9Y1kH+v8dlQVwd7TGnkpd97oZ/5V9OsnCyZQw0Fbh3QD4JuuZJCA66g8VJ+Z8RWZiPVS0oEuNwjnCg6vEzJF6pIKOW2Ph2z108vUU/0JpFcZ4Wr/8t3xuX6ZIYXgS5TufAu47U4Fr84VIsoRIiXKZJ6UmjCfPeAKXSGG5aMMVJPhWnpxjhqaql1W+MCghtzQi1A1swncmJotuTEkCTxELyO++IFHDO+t4GhypX4Max9va32q5J3LtbUJ2HIuQ4giS4rvD24/FykoeaaOmwiY1Zj9lgKd+A441ihWB4SbUwCxBVt3ya8iJLRRfuHQBeuNRSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crUJHiJokFpnPaMI1nKp4vlD+6cLp1Ih68n/v7APZVA=;
 b=ChoPf5yj7kN0k5j98rRyl43zMloFWIERVgk2w9fdh+aIUfR/0omg4w4C7iQ7ZJgRd6r8VYvNWpHKzEK4eF0acnPvRFxcyMSDZOwp1ZTxrwDb94OoOBkFqiA7krz+1rxzJRJfteDuvJQyblLC9R9pr8W0qlCko1qvb9mxy73/bv1MzGdM0cEK6YU297eVDBcLoNlomR8Q6x0cir2XykYyTDYyfNy4fbsr6GZf0STBhrYBt87sbWSFW9K2vAkl+Zp33b+ZDrkowb9k/gL+V4cSOFlLBGdMC7e0NBHgJqr7ZBUycMrudnGOykzq2gkDQpTtYqB0Zp/NFt7FYUVQ4NyU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crUJHiJokFpnPaMI1nKp4vlD+6cLp1Ih68n/v7APZVA=;
 b=S/Yj2KhhK6U6JQM9AZvDEqzkGD7oT0klXZqhg1ZBhxni7Ys2t2CotFTCIZvl2r/EupUdptB+P6G+wIZcXVKMCyCwoUY3hX+tE8B970plIiir3rb/YXKlGmo10xiXoUBOghuQCI+xurkpeRfJFmbsf1DhscgH5tm71hZpMo8RTTACVsbirMJ02kVKU4FgXFG8Z+6rZFUoFCS2KmWttypK7nrh3Or90zPQ2MshlkgyaH67YLHLbGN7vgK+MCOCzhD5d5alH05TNdwwhy6+5zgB2PVsTLhze50uvfrbw97MG3sZrh3joLGROUGBKZIgJBba+ZnTWfSw32LFjjPhgg0MYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7380.eurprd03.prod.outlook.com (2603:10a6:20b:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:21:33 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:21:33 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 2/4] input: pwm-beeper: add feature to set volume via sysfs
Date:   Wed,  1 Feb 2023 16:21:26 +0100
Message-Id: <20230201152128.614439-3-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201152128.614439-1-manuel.traut@mt.com>
References: <20230201152128.614439-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: c3eb1c62-dc54-40b1-f8ab-08db04680074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xz/y03TaTf4ZbiOXJafkQNZMh6UjPDWiLudTLthr2+jSAHjyswtFFQTFjHvr93ZDfHOXnQEBjztIOE1w8l3WFVyPJdYpcoQMoDuj4Hso2y/zMw8YlXs5CjYir2zXGQWQxIZTOeoK/wkDTS/q55HKfrd6NSLrBQYUGLlV5RaIH2+daKJbo7mt/KMorHVqIFdM+Wd2FrYHGBxnahdXRAb2fUBCA/grWsUXXLzmmW+EQXag2CpRb3ri65zspdkr9SDZQoq/E2NnQa5AcDTMz4I+s6oROooKu0Se0vnfhLc3vS0C5PaErv5XLUz9lCAlzwxkbsGauPPQ7kKpmr4noDKaWUuqK9LZJ6CK1fC8NROwRK0hHL+G/B6kOgBctzC0B0RbCd4+Rheh00zsyD56e1WYObb+ik1Y1dFPvGXD/PAfQkbp4fdW58De4HKa7SnPq7mtKZ1sfw1+GYGmxI7l58IlKEw/RTwuFQsRXQ52HYPX1geFukY7J9AwJYPZs/S+nyYl6ojB7UO3igxS3btOGJHUH11bnAY+Zg98+3ZJfq8ESc+twfkjneGqXbEV4Hb5sgyC4xddb37AcSRpqsJK97I/D5zNub/NYtttzLmYVz6mOZ8HZBqQFXOjPWxUDFNLEz8qr2cVSOQfoxi9/JtBHbPJquiSR8hM33lWP3F7iNHiFQQ3dpS7eT4XJtORgOuwB75J3rbjJzYiL3l7j2v4/PLxww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38350700002)(38100700002)(54906003)(36756003)(86362001)(5660300002)(4326008)(6916009)(8676002)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(44832011)(2616005)(83380400001)(2906002)(6486002)(52116002)(478600001)(186003)(26005)(6512007)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNIJARCy5G0zUNH2hTz4Dp+Sb7QmP8lxEEu6Kfbr8BTjPDRKdg7+l+nuee8f?=
 =?us-ascii?Q?adcY1YhtmRkb2Z9hl2rcS04xzdHr5iPb90XKPOYGf1p4gDTabu8PQYKNjVkZ?=
 =?us-ascii?Q?Og99d8t2h3vQYLrXUTXLE3nzhz02kEu6RU2Rh/S8UzGLqr0rnJ6efz8QhuUY?=
 =?us-ascii?Q?d7QGjhkm87TjNltnZPUVa+HqJMuWNE755PLf62TJus4wXlVvZ0W5Yo2ruGNj?=
 =?us-ascii?Q?0xf/EioKJEgHYp6hhQyM2AhCUrgEtpVYAW4na/jUZfOGKfQLrGvCOCVAiYpD?=
 =?us-ascii?Q?+S4DuY4HSzDIs1C1IvImhRHJGkiAWeOvbv52mpmHE+kPbLQZiZ9YnroLJOsC?=
 =?us-ascii?Q?M8boAHje0aUoMkW7ryFw1EcUNIx+psB/b+R/b7XiTSReyo62IvxB6IMz0zuM?=
 =?us-ascii?Q?ONDKGphQzfQXe5fM79pHJwacYGdaGvXtwsP7VgDnGnmw1o7JB4/x1sUwgTUE?=
 =?us-ascii?Q?WqOw/CXAUjFhJobjEBle5ILSDLIAabmA2kuHMHV2gt7/iba5AM7fnDnmMmHe?=
 =?us-ascii?Q?y85zAfzRC7lR81Gee09TkiYz+LtGuxP/YmPJ2sDQj3QXvJurH1CQ5Rkon4b3?=
 =?us-ascii?Q?3kWkjVijW5P/ShwfUbKpmKjwm5ecqdwyob7bEf8mkzE8t5xZAWJ2bcfo4ecA?=
 =?us-ascii?Q?yg/p70XPLs+LJUFGHxwBgS1rGQ5dwqTT+UTHxds1gSuW3y4pWJTtAAt7ALM5?=
 =?us-ascii?Q?INNJnNXL0YOnmsYvG1s7e+QA4YPNdQIyxfG39bZTG7Wyz7Tr72d7wh7tXKIn?=
 =?us-ascii?Q?E0ZCwVxyYT38jQblQuZuIpj2NMyCiFx2E8PttkCT38vKdG5DTPuVcgBco/Ok?=
 =?us-ascii?Q?9Mjo7T5kws7DcOhLQ7cAacsfN1fCRFgomTO74aDZ85igYcR9evKiiHxYnaj6?=
 =?us-ascii?Q?b6twk/hhZMOV1kICTc/w+xLbKtt6c0PMW/K2wLYgon0Gd1PQyH10NsqcCo2O?=
 =?us-ascii?Q?2jyecbcywpEVYjm1/nve3RpQXsNBk0cnkSSaQ8HQE4G5fWt+plh+4pdpRpSA?=
 =?us-ascii?Q?wol7hB5POyQAMsnJO2N4+7JUeaRV6zF171YmY+nonkFUx0erlFFAtho0yFWk?=
 =?us-ascii?Q?OrXZQ2/JWQjfdo1S3zC1YDlypFMccajc7w0wWquha4RFXaiDH1w8N7XpWfAP?=
 =?us-ascii?Q?YFk7pxQqkH7yOiyh+vPz5R7YggSSWku3+PT/8RcrO6zci3eTv+a8fPt/seCt?=
 =?us-ascii?Q?TFZqUT1K35doho0/pUlXnK7s/chR1Q1QR03GImCezo6jQCbdStDuW9c/AwyX?=
 =?us-ascii?Q?WGW0QGuHZqoPMuPk9PLz2g7ZOO6lbERN3FnAynOmDHtDcMk4Vi7dWIwNcSQk?=
 =?us-ascii?Q?GLC5brJzXLE/noFI0jTgOFf3X7j4x7pZT5Kq948ADedXeSq599GXRqkzZlyq?=
 =?us-ascii?Q?3uO9cqVhecCVf+cLHzDrNXz4iY5qa+MDS4cMvV8P6iSsnnD7WtgRO0PIhBur?=
 =?us-ascii?Q?gnGuxPVZ4CGRkqpisiiQk+UyinIhHVu5NqoG5/5LZwrxsnIWDJnoiiLlXZgq?=
 =?us-ascii?Q?CJIDmG8uRUkx0d5CWdEqTpXDDPWMacQozEgjxkxoDvgg+8zIbWTLZtvvuAfQ?=
 =?us-ascii?Q?EkVoCVISuM3mckGGwpKsWBbOxbDs1sLvh8eIeCR+?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb1c62-dc54-40b1-f8ab-08db04680074
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:21:33.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmLXvO5HeiEwnOd4MnTDkI+Recg/UMKEO+u2f8CYh/gbSTEZkz4EByRkb0bmB/AKFvywWGWlKxoEzL8COLvLDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7380
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
2.39.1

