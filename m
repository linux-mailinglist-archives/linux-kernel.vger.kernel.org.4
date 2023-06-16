Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99172733557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbjFPQB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbjFPQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:01:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2035.outbound.protection.outlook.com [40.92.91.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE03AA0;
        Fri, 16 Jun 2023 09:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMVrcMYitCj3nn6p9P1MVBToUIyy+C1tQFJ5s8Qtpe321QtVf9fI+bUlkHb17aCjrKCGZCRkZMXEdjbBoT8s98t/t3FOhQvfGWnb7/74fonIlzXGPyJ7XMzPDQO4aKXKnGVfxK18TBpqgVzXzKtCiUAyjntp3K66JSV6c2g3bOuLkbFSSyVqtqmEV/HOyJM9BC4Byo0a/1SFCO4YXoMqvZFbMVJ/nOTkGesuM0xPbHHp1Ekav0CsgkdM27Xb4QKyTPa8cgmUCdLXAxtyhpsCjjPzUjjRBq+uM/ZtpqKigM9tnZp7lQWKtYz7c8QMJ4b+HcFwmE+UGjEMZ8KxEt5BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7sBpx5tYuT0INxyfCCXPqD+jWkrHq7KTnXrwob1zec=;
 b=WcrzRVJ3Y6p+VhZ1x0hCMunudiXA0WXqeYXh+I55TNgZi6lscsZnCgQgRecEZ7xY1Q/MT+UgfDy09CYM8U6y3IepcVGaKEaFM2ww0Y9HPOpu8RH5ebSOXzjb+baFrooXf7EkoPIsED95hqjaxQUNvY3WbJPGYGj61PSLzgmhcd8iPJUCEcSsMS7rVkvEmz9RNaMAnTRNm5Ikp+g98Sk2wstwo/ijgF0K/U8RjjBeAN7/s7Cj1DSY4tLb28vTLYzmW8b048JFuJys6465Qhuc5my/hwrfVTgBzxfHEzT7mgpiS1DnYBziudFMleocZcr1ltmaxui1r1Vwm7jVHVRAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7sBpx5tYuT0INxyfCCXPqD+jWkrHq7KTnXrwob1zec=;
 b=dKEa4NyPg+STdU5mnFrqhrLOR9P2UbcxTYBOaF9ERcAiwvYQmOxQYL0RjBGLWh7vsBwsb9D95iaT0rFfFxXw9cvpIWTah+O9UbRlLxb3bwyZdEyht1k2TdIF3Q5hEdeI4nbc8bU2G7wo7mi3LGlOoEjk9Ud/DuessEB+Hv9T/AR6d0O5MHT8WAfcNjQ7z+0bJvBqpObdSdYnpfXlG82ZMMpR6I1kQ7fEu0Uz4raGcvKjkRbq5D8IkukuL9SnRA2mvj29P1sT8avD1T1HNUAyKdAvkb1ZJOqvDuKUni0pOEeXutxfoZvfrCHW97EogIqglrw9/yPHKwYFkg7H9zCIhQ==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:01:14 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:01:14 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 5/6] hwmon: (sht3x)add new non-stardard sysfs interface
Date:   Sat, 17 Jun 2023 00:00:16 +0800
Message-ID: <DB4PR10MB6261B507C7656E3568DA33E39258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [z/G2p0/A69biVilpR2wJTb8ppR4aRMK8]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-5-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a9fd9e-1f5c-4943-6170-08db6e82e8ff
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKzwu8YPsqYDy7f7AA4ui0PNvtRVyhPRaRc/9Qmr9vjak4tg6NAu7gvKwMMl3IvHP2COaxamSxVc2ekY51DHYYvcksiTc0RZyZ0NjUMGGTRZcvxOdopICyDNMese3x3LfbzfaZnLApsZ7NHFRMpQbb75kqqWXINL/urCqXu6J27spChhDY7HhWwykYInWplNgUqbAB+2OfCfyCJa3NYGRBz3MBHqJDAt7qPsFmXCIMM2/s0ER+0YDINvMqVqoO7ffc1RsEdLlUPFziI3Iar/4UNynyJSJjrh3eZONSPLe6ujUTSWfEdv9RwXtPjN4Q7CXpRMa7MrrCKaFVEwyLFsDX4aY/iW1I9+1WINTxFsGzfK32jrBqkH2aZQRi/t79CtRfmRLlIEXPaOUzt8fajpzj19Gp+CcqUH45rOQM5Uv7jUCpiOsaRhXJGCWY9MDyiPcg9/G8tiWRN4V6b6h/G8qC2eTaNXmwYhn4z/h4c0PVXaCV41vq8WIsMZakBgZzOcKbmKBv1ODzbym1NCa5O9RmFLMChmQ0rGpYFxWLzgSE28fZxcdgkbpvzVQ044ykwU6Vl9oI52HZPCl9Fu9zZdjVKDw0RqBcctv9OJzfem4GbT7wCdCccfVQ03PNhZ1uL7zRod3bmFKIMmCP4+UwHPYWG6xVrU/M/A2fgOOMQqoUbmjIyRtc+f0GobhAFbBUKPZxTQLqieSV22rwrGPylIE86Vi8SFzusz5h0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kr9BF7Owm5+2J8/1s/QueeOwB45+5WlGrrH53jLhIlVo7Hkj9hWv/5zOjA84CbnV/sO1mCs/OiCo84AVPFHgbihu+b0ySZMjKZEXXWVSqONexF0eJ9LUtkzx9Pf+6W+MSjhBXFj8sQMO6FUYHKiIP7kvOfcPeHCvpWjKbiCWmorw/XD13sqUyg3NcpFKQ8XpmCvVPMJoyAsuvYVD0R7LcfrZ/QJHilKMvApzgw2MwV9ouT+IPTaF/HF0Y0k9kZCIQf0CbAgonUSXJh6z+CAA56GwO+RjQTcgcTDEYP6jIsFCss2BJW4B1hciqtdMb6BeDgiXsJKRBsjRx5PhtifPKcjq+FskpaOU4svHWccpgXNfjwYJONkIOIn+5PP3+EqwUYmt8GLU8VdQjvAAFqJFoognNJ0SjITv7+ykxhdh5hIgCsi6QzGQ+XYL5teRia23J/xh/BQaU0KXQzlAVlsGWnd8lgavoFwEL3O/NiHYqSclpYAKyvRebfIgfvNPpf7OGy2Aah69aIX+4lZWF/nFImBpfPjpebW7HXiEOxcCZejsbKVQJ/FptJtXuYfTSS1LAj36FwWw72OR0pQd47Iq2+X1Vx7MpUraIObYom28T5I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+1bOR69oBx+BHevVske1ZyPtv7AfA/N13AmA3JVDeccL9fBRrpuKcqj8fgn?=
 =?us-ascii?Q?nNriH7sCqKYVUjgC80MDUhWhoIn6ijKqDX8tHLUJsB8pO5nVGDHk4Z8SlkBt?=
 =?us-ascii?Q?m2jrsUtvTMzblKoGIm6xZZVboBUH+TcJGm2dwntMqIz/AT7YxqaAdRZP7SBu?=
 =?us-ascii?Q?ZoYS1x61w0k3b4B2+nMkMEODGMhkF8u+MX2tsPBGlbikRHTmuaZzrj+1ZMjw?=
 =?us-ascii?Q?OTnixJVeHzAdcp5n0JnmVnZoat812ykHkVZCqW3CewDzYg59UUmSokXfrCca?=
 =?us-ascii?Q?TKJ+0i1y1Ym4dLvXQVjz56NzHv+p5vKW3MyS1wNUX5M4dNiYkPTZB+z46Qd6?=
 =?us-ascii?Q?kQCrB4CyPeTToBSlq66aHwT97ArTIHeWP4fqD3Ff6K24oOQq/KX1dfxbakdG?=
 =?us-ascii?Q?BlqiKlcBY+BN9V1zAJcqqLyrSSBsFj7d+f+OQYOPmODxf1WU3NRXUnq7fevL?=
 =?us-ascii?Q?ieRsgb7reHxmydtcOVCexeqZfQwZw6uJJGXsQ5Fn5r8fR7YpnT+axhi8xqBS?=
 =?us-ascii?Q?x6RXJ6StNhw2sOBJbNFPvnI5KgH2+lf3o5NJdnh8cnPUGf9XZYgu6LsqP6IC?=
 =?us-ascii?Q?z/2XpBYHAWdKbDzOQDY/ZIqNbrLqcHiovIZStiSgIqUG8do/IzOewOIsZ8dp?=
 =?us-ascii?Q?oIktG8cPA8xgqpxCJWC6wjZ1Jdn308UEK6EGOGAneKO9slcZato/H90jUo2z?=
 =?us-ascii?Q?K8H/CAc1SY9oBpKulvrbMzzkRClgXIOhSY5+kxWWSHnmVyX7yyXYRektfek5?=
 =?us-ascii?Q?cJaJRq7yNkqhCvejFH1jrQK/xZHlAeBR1HqhpM/xpyZiKB3UUzjOc7EFtiVS?=
 =?us-ascii?Q?99jG4wVKyG5wP/UWHd33+CDT0meucc7lxE5df0xF0FNlr8olTKnSvJL/2DvF?=
 =?us-ascii?Q?L9bNUBAdQchWwMoAScE66ZT+QIynthw5Xct6h8YsihVJWPgmKjxiD4fupQiF?=
 =?us-ascii?Q?QHzMBsJDVw926nLR6NyzTctx0azDoj+TcOMfxSm/zlUpPqYm+3ak9b1rYGPd?=
 =?us-ascii?Q?Bkuw9TKzepaRneUEVEi1Yl0uI0INFtbWtGVrhlZvLwd71xA/GNavEO6sip1M?=
 =?us-ascii?Q?mfdHkfy/FKoU2ntl1Z9lRa7MXiSk0nBeSp6HQSUmW3FdZ9Vrk6gR8SvDhPe8?=
 =?us-ascii?Q?nSc3Aj545BbCC8cUj/FauRPynS/ZYcfgeFm+E9pMyYSUKcxscr6Gl7KVwqGF?=
 =?us-ascii?Q?2ZbFFjQmIDmg/4X4Q/AMtQ119kCKwgFyaNEm9b1UDTZrZO+LlEIHc4yNZwY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a9fd9e-1f5c-4943-6170-08db6e82e8ff
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:01:13.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add "repeatability" interface to sysfs, it could be
read or written to control the sensor.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst | 12 +++++++-----
 drivers/hwmon/sht3x.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index b4aa561f0..87864ffd1 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -28,11 +28,6 @@ The device communicates with the I2C protocol. Sensors can have the I2C
 addresses 0x44 or 0x45, depending on the wiring. See
 Documentation/i2c/instantiating-devices.rst for methods to instantiate the device.
 
-There is only one option configurable by means of sht3x_data:
-
-   repeatability: high repeatability is used by default and using it is
-   strongly recommended.
-
 Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
 (non-blocking mode) in single-shot mode, this driver only supports the latter.
 
@@ -83,4 +78,11 @@ heater_enable:      heater enable, heating element removes excess humidity from
 update_interval:    update interval, 0 for single shot, interval in msec
 		    for periodic measurement. If the interval is not supported
 		    by the sensor, the next faster interval is chosen
+repeatability:      write or read repeatability, higher repeatability means
+                    longer measurement duration, lower noise level and
+                    larger energy consumption:
+
+                        - 0: low repeatability
+                        - 1: medium repeatability
+                        - 2: high repeatability
 =================== ============================================================
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 6174b8fa7..adfc11c12 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -637,6 +637,37 @@ static ssize_t update_interval_store(struct device *dev,
 	return count;
 }
 
+static ssize_t repeatability_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sht3x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->repeatability);
+}
+
+static ssize_t repeatability_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	u8 val;
+	int ret;
+
+	struct sht3x_data *data = dev_get_drvdata(dev);
+
+	ret = kstrtou8(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 2)
+		return -EINVAL;
+
+	data->repeatability = val;
+
+	return count;
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
 static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
 static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
@@ -653,6 +684,7 @@ static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
 static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
 
 static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -669,6 +701,7 @@ static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
 	&sensor_dev_attr_heater_enable.dev_attr.attr,
 	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
-- 
2.30.2

