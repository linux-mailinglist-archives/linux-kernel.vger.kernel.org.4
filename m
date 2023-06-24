Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6543973CBCB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFXQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:02:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2060.outbound.protection.outlook.com [40.92.89.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA028E5E;
        Sat, 24 Jun 2023 09:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLGnaWe1GNSbYS4Cxow7TzPHXUAeluJqsI+S5Ymdfq/OM0YI5hrpKCcRF0CAgEx/UGsfwLIgCNlczeVAKq4Zs8Jxf/1Gx8+kPJAvpt+Zudv634VrvKzOr4iXRc9mb4KZXNhuMEB9xwS5y4RFCuUwo2wYXIDHWpPCiz8cFAyy7Sy3TFgdtfcD41w0/XYs+R2cp3jBIXYvx7Lc3zQwXNf11Bo2Fmq5TfM4CepXRnUCrz6DXSYifioBYg9Mhytundv1vPD5kkfeKeAVVvzwURqDFtF5/XJ4Z2MGvjQjoJ9GetHAiUvYkOmSRJAQJYeK/4ew6Zlfe7rHzWtK8j126QgTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcVVkhcuKjhaiaMiThTgwB4GRp0DfqLQZ+QY5Pwaj4k=;
 b=Egn2xXOYO/nJank+dqMdsoyq07MCbH8nT3xB4BaoelptpkUJLmV1R0+D6/tvKFREjMXnmgBAKZQ8qbV7DOC/5TmxjrM764dAzKFjSgSVWn+Mi6ADZQurGhJYIvemd++aww75BSU6dsM7K3GkgQ3b8rXdq7tPydpfpaWCEu1sX37S5dKKK/6vHsehp4ooNBVTiyDAD9lnRIIWKz0UBcgJ4fTvVtoqCVUw0s9BiJdKCU/RPAg6BQhss2Q+b5y1H0Px1H1gCUGDfimixfgCCMUr8syO2vtGULDIpXb5+DyNELNH5TjW9h9eIQ06wVPWLfTUgiyQbg4d8UkTrdJnr2uSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcVVkhcuKjhaiaMiThTgwB4GRp0DfqLQZ+QY5Pwaj4k=;
 b=DLMLy5RPYrFvtzl6nnN85qaCyM3w1JKGV74nPEcIMBkXdNK4RRAGN1VHRWZ3v020K+JGiVG3EYwVwv06Bil5lZWkGC89CqFc14RDJGGWB5AUyouH9kX9F0XbZWmJCe2wazfCQf8IXPtTf4R87ejFiuPyfCuT+m9jkmAXIqaWLrFChvLNgxk15igjo2RURZmaCDDdMFVH2WGARYkLcAKsu2AQrIPvUZrIVlQKKsdHQNnGmjVv/0LTdMbzvcHWbNdtF5FmVtPeRUDpq1hdmfnBJam7b7QmJu73YpNJAQhB0D2/+IRbT6PlomPXHe0ShyBZ1w62Yj1WXsKfF3iLtGp94Q==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 16:02:15 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 16:02:15 +0000
From:   JuenKit_Yip@hotmail.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 1/3] hwmon: (sht3x) convert some of sysfs interface to hwmon
Date:   Sun, 25 Jun 2023 00:01:46 +0800
Message-ID: <DB4PR10MB6261BA825CB417ACA76772529220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wnxwB2Kuz8at2xr8v6YvIdNa3UlXiKJh]
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e393b24-b7fd-45ba-666d-08db74cc60c7
X-MS-Exchange-SLBlob-MailProps: wk1EIbWONa01dq3m3LJx8CKFpQlkHUC+ZI2ds9WfHXg6Z94xu6c/LQI3x2EMbWGFOe8vwhK0ud1q3d1YwNcCcQAIobycIAJAJufR7CUaxjPLmSpEWtt9aLkWaZXDNUODTPdCEiIO35utBEYJzE4k6djH5BAbctCWz08CoUzQQJYMHqZHQyAwX3MpNUeAfW4cEUTn8dFSVzkn8NWVed82+zyXcWUqbBAWXJTZ0yq9OZHbgAdYig82LqzQJtd6XpBUEOkqdpjYqv0NZErk+Yl5fDzZghGQxtpcLh/lxNrbJzyiyoy6GswNYOGuA+1DfvJlD0DnLeTCe88+SCGA46RLgaTmqXeuSxJjjVqbrEsgkK0xpRhXYVqPqdoBNAaLTbY3G81gPK9ChvL4E39CeQ79bRlvwwflbM1e5YGv7pD86GZS1ZwIpxGjB4tqU0XV4GLXLwYpJ3S2Px/la++otpXQE+fGci9pi89GUYOiTLXnDzQERtICrj6oT4d1PCXkxU5clEKYG1sSIrQkkM/iLERCtUU3hmMDaActPyNcgewMcWKKNZAphnszNSMKt25Pvpvh+ZjQDVPEKFgdWtONDlvUK/musHCPOLYwkpNhYbp/jR+ACKESHdrCqEgmZ1LnjH8EmgcOqhaVURJor0P+ZCCeNDJPEMqox9cxOqYZoQL6oVdsyZxYTp5oA39r+mIWm/QVD6UxehPzwaU4ZbyiROpfG4nOHygpH8oUXTJd8D+wBkZUAlIZ2m7bLg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2XUtzRLgAM43AqYrOYYeHzsFPYAO+4094Tfb3vJC5M55+prqi1J7mB092NG96ubxSO88aWovo2AYvjQmNZBMAlmvLlHGzSjZrWQT/++AROYBQ8l4T/VrdGd4hn3bp3251LLiVFLM835zo/TK9BccB/iTRoA9mOw1PXl/In5tQ0sXBD5Qq6wrNdsypa/WsV69bzLwTr6IedkLBFsVwE5AbUiHHTP5LEp6HjsKrayMJ3WGAApW/YxGiJwc807NJ1p8HU0QgmCyZNDK0fMJrm6emFtlzTr/VXxeHwozei2wb9VdCKTtZQ0dCixFdB3pr7QKrRiIOF9ggSzETRtdm/qf9IbsW+XwVcP3dsA+tTZRdWfIvBF63Z3moN38prF6M7jh7lDjXqIZTOeeGA2M0auYYoQZrG76eMT2JPnxIxTjd7v1kKB7aqTTuGPh57Wwpsd0hGin4/qAEdxnOnao9/nP4bhV26zuFGEuwq+zZ6FJv0BL+53JNwiOyChxDvoe29lTekmeDzPxFMx3UdQgSj5c6s15wN/krx/Xf6+sPW4ChIodqMiUqDHbo2yqgMlox3yr0xvMBD1fLQOCiZHgZuVOFdjMAnReyreuohG+gIL2B2ukEPBMuMs3fnRDzWbnvXj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1hT2GXqmeaLAz8m42q7xXB1nrGBQkXgFjwqjd68Z2zMRGRx6ogj5S72xyAs?=
 =?us-ascii?Q?4+eq4QBiiUL2nlI7/kx+Cqy1zLt/ByggfBpWRfHjpORBpY+Yz5kZUkTmvojG?=
 =?us-ascii?Q?JrcENa/9tb4/fKP4bYlDQ9klsOCzSkkmBx7padowoTS4xDNnvtSMYj/oE5Nw?=
 =?us-ascii?Q?2kLVKmGgcSV7PherzK4Ot1kIOCHvNZb2b/P/S+y1T2wJifBr5+8mGuMq2LK3?=
 =?us-ascii?Q?SfJ0D8vj2/wGD5qVw0BK4Hgk/hkscsB5pe4xKNhPRpw2LjMdIYEvL16fUzIS?=
 =?us-ascii?Q?2ICIysiNKpa6teTA2JIoN2HJXrF0+cuBHjFPgEfO+HHcmVgZWOyPXQAlH8Ra?=
 =?us-ascii?Q?qWEiNnsbmYNzQlvHDuajjt7Za8N3p9vuvmLeS1KjJaUgY9lRZEIQFzucZchv?=
 =?us-ascii?Q?Fjcu5V+r3hZFuHLJ6syWqlzgqzCsn59G8oBWosT8UlLKLaAYQy0qgH0Id8yO?=
 =?us-ascii?Q?BqOOMa40tOVlF+/Ke+KqgAjdOQucntb7xhiQS2/py8YuMkTPhSwwUMRXVere?=
 =?us-ascii?Q?JvkbAfvVYD4GnfGSxZZWFxMmZYiJjGgZUyBzKA2I8e8/10/c3vqodryxBirJ?=
 =?us-ascii?Q?UWjS/xDZ018Z9IkdNtUP1DkhO/Kf+XjJIoIwO6B2NLOkcmxhoPJqqCvoGqgl?=
 =?us-ascii?Q?swDD75IylerYOMw2UaYir6UzsKvsqChZoxRJ3KP2h9AwhsOrU+dgxDY50ryV?=
 =?us-ascii?Q?msV8J+YgH5amevO6b5mCmoK4qWQWLbeOVqopFpIEMsAyBLWKIqx+YdLUOOnO?=
 =?us-ascii?Q?pYslQgV7duU643+4Hlgt9z5Elt3lCN/3Qsx5nEHVWr9Q6IUtYPPgIgYAqgoE?=
 =?us-ascii?Q?xnCMPip+FXEN8EbYa7i9g+t0pNhp0hj1AnuKJ/r5AgTO1yBS/6OeW9NGbGiA?=
 =?us-ascii?Q?QcsmnqHrg6bneeoTPEgb/XX/I7kIEKambe0RB65j69kbVKblWs1BQ/2c0Zcl?=
 =?us-ascii?Q?MUFEO6+4tAQYxX+6IORRxQ5d26WhtE4uFUZ512orwOW9xXbJW+BsK+9wMN+8?=
 =?us-ascii?Q?8cJfRgHR699tP1LB7r8FXWOY74MpdUTkzOJ7Gg+dKRd9fhC/aEX1ns8O6t45?=
 =?us-ascii?Q?SK+JB7CjZoH7MriEE7R9hQVFBILhi/1qCLSAKCuwNo4EtN0OAAdmgEN34oc2?=
 =?us-ascii?Q?pnzhrlFz98H4zEN8GiQqbmYoFtXpYKDfxqq3JbgNdVPDHl1KyE7WYttaLvWP?=
 =?us-ascii?Q?WFYAYTOQr/uIN7CB075sxSmq10pdWvCRoCQqiHGtLux+ueBcOlji4HgvWq4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e393b24-b7fd-45ba-666d-08db74cc60c7
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 16:02:15.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JuenKit Yip <JuenKit_Yip@hotmail.com>

update_interval, temperature/humidity max/min and hyst
were moved to new hwmon interface, and only heater and
repeatability were reserved as non-stardard sysfs interface.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 359 ++++++++++++++++++++++++++++--------------
 1 file changed, 244 insertions(+), 115 deletions(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index bf18630619e0..9b2dadd11eeb 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -147,6 +147,19 @@ static const u16 mode_to_update_interval[] = {
 	 100,
 };
 
+static const struct hwmon_channel_info * const sht3x_channel_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MIN |
+				HWMON_T_MIN_HYST | HWMON_T_MAX |
+				HWMON_T_MAX_HYST | HWMON_T_ALARM),
+	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT | HWMON_H_MIN |
+				HWMON_H_MIN_HYST | HWMON_H_MAX |
+				HWMON_H_MAX_HYST | HWMON_H_ALARM),
+	NULL,
+};
+
+static const struct i2c_device_id sht3x_ids[];
+
 struct sht3x_data {
 	struct i2c_client *client;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
@@ -276,27 +289,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 	return data;
 }
 
-/* sysfs attributes */
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static int temp1_input_read(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", data->temperature);
+	return data->temperature;
 }
 
-static ssize_t humidity1_input_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static int humidity1_input_read(struct device *dev)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%u\n", data->humidity);
+	return data->humidity;
 }
 
 /*
@@ -332,33 +342,24 @@ static int limits_update(struct sht3x_data *data)
 	return ret;
 }
 
-static ssize_t temp1_limit_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_limit_read(struct device *dev, int index)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-	int temperature_limit = data->temperature_limits[index];
 
-	return sysfs_emit(buf, "%d\n", temperature_limit);
+	return data->temperature_limits[index];
 }
 
-static ssize_t humidity1_limit_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int humidity1_limit_read(struct device *dev, int index)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
-	u32 humidity_limit = data->humidity_limits[index];
 
-	return sysfs_emit(buf, "%u\n", humidity_limit);
+	return data->humidity_limits[index];
 }
 
 /*
- * limit_store must only be called with data_lock held
+ * limit_write must only be called with data_lock held
  */
-static size_t limit_store(struct device *dev,
-			  size_t count,
+static size_t limit_write(struct device *dev,
 			  u8 index,
 			  int temperature,
 			  u32 humidity)
@@ -379,7 +380,7 @@ static size_t limit_store(struct device *dev,
 	 * ST = (T + 45) / 175 * 2^16
 	 * SRH = RH / 100 * 2^16
 	 * adapted for fixed point arithmetic and packed the same as
-	 * in limit_show()
+	 * in limit_read()
 	 */
 	raw = ((u32)(temperature + 45000) * 24543) >> (16 + 7);
 	raw |= ((humidity * 42950) >> 16) & 0xfe00;
@@ -400,50 +401,43 @@ static size_t limit_store(struct device *dev,
 
 	data->temperature_limits[index] = temperature;
 	data->humidity_limits[index] = humidity;
-	return count;
+
+	return 0;
 }
 
-static ssize_t temp1_limit_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t count)
+static int temp1_limit_write(struct device *dev, int index, const char *val)
 {
 	int temperature;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
 
-	ret = kstrtoint(buf, 0, &temperature);
+	ret = kstrtoint(val, 0, &temperature);
 	if (ret)
 		return ret;
 
 	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
 				SHT3X_MAX_TEMPERATURE);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, temperature,
+	ret = limit_write(dev, index, temperature,
 			  data->humidity_limits[index]);
 	mutex_unlock(&data->data_lock);
 
 	return ret;
 }
 
-static ssize_t humidity1_limit_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static int humidity1_limit_write(struct device *dev, int index, const char *val)
 {
 	u32 humidity;
 	int ret;
 	struct sht3x_data *data = dev_get_drvdata(dev);
-	u8 index = to_sensor_dev_attr(attr)->index;
 
-	ret = kstrtou32(buf, 0, &humidity);
+	ret = kstrtou32(val, 0, &humidity);
 	if (ret)
 		return ret;
 
 	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
 	mutex_lock(&data->data_lock);
-	ret = limit_store(dev, count, index, data->temperature_limits[index],
+	ret = limit_write(dev, index, data->temperature_limits[index],
 			  humidity);
 	mutex_unlock(&data->data_lock);
 
@@ -474,7 +468,6 @@ static void sht3x_select_command(struct sht3x_data *data)
 }
 
 static int status_register_read(struct device *dev,
-				struct device_attribute *attr,
 				char *buffer, int length)
 {
 	int ret;
@@ -487,34 +480,30 @@ static int status_register_read(struct device *dev,
 	return ret;
 }
 
-static ssize_t temp1_alarm_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int temp1_alarm_read(struct device *dev)
 {
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
+	return !!(buffer[0] & 0x04);
 }
 
-static ssize_t humidity1_alarm_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int humidity1_alarm_read(struct device *dev)
 {
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
+	return !!(buffer[0] & 0x08);
 }
 
 static ssize_t heater_enable_show(struct device *dev,
@@ -524,7 +513,7 @@ static ssize_t heater_enable_show(struct device *dev,
 	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
 	int ret;
 
-	ret = status_register_read(dev, attr, buffer,
+	ret = status_register_read(dev, buffer,
 				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
 	if (ret)
 		return ret;
@@ -560,20 +549,14 @@ static ssize_t heater_enable_store(struct device *dev,
 	return ret;
 }
 
-static ssize_t update_interval_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static int update_interval_read(struct device *dev)
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%u\n",
-			 mode_to_update_interval[data->mode]);
+	return mode_to_update_interval[data->mode];
 }
 
-static ssize_t update_interval_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t count)
+static int update_interval_write(struct device *dev, const char *val)
 {
 	u16 update_interval;
 	u8 mode;
@@ -582,7 +565,7 @@ static ssize_t update_interval_store(struct device *dev,
 	struct sht3x_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 
-	ret = kstrtou16(buf, 0, &update_interval);
+	ret = kstrtou16(val, 0, &update_interval);
 	if (ret)
 		return ret;
 
@@ -592,7 +575,7 @@ static ssize_t update_interval_store(struct device *dev,
 	/* mode did not change */
 	if (mode == data->mode) {
 		mutex_unlock(&data->data_lock);
-		return count;
+		return 0;
 	}
 
 	mutex_lock(&data->i2c_lock);
@@ -634,7 +617,7 @@ static ssize_t update_interval_store(struct device *dev,
 	if (ret != SHT3X_CMD_LENGTH)
 		return ret < 0 ? ret : -EIO;
 
-	return count;
+	return 0;
 }
 
 static ssize_t repeatability_show(struct device *dev,
@@ -668,60 +651,211 @@ static ssize_t repeatability_store(struct device *dev,
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
-static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
-static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
-static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
-static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
-			     limit_max_hyst);
-static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
-static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
-static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
-static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
-			     limit_min_hyst);
-static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
-static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
-static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
 static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
 
 static struct attribute *sht3x_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_humidity1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_humidity1_max.dev_attr.attr,
-	&sensor_dev_attr_humidity1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_humidity1_min.dev_attr.attr,
-	&sensor_dev_attr_humidity1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
 	&sensor_dev_attr_heater_enable.dev_attr.attr,
-	&sensor_dev_attr_update_interval.dev_attr.attr,
-	&sensor_dev_attr_repeatability.dev_attr.attr,
-	NULL
-};
-
-static struct attribute *sts3x_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_heater_enable.dev_attr.attr,
-	&sensor_dev_attr_update_interval.dev_attr.attr,
 	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
 ATTRIBUTE_GROUPS(sht3x);
-ATTRIBUTE_GROUPS(sts3x);
 
-static const struct i2c_device_id sht3x_ids[];
+static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	const struct sht3x_data *chip_data = data;
+	struct i2c_client *client = chip_data->client;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_alarm:
+			return 0444;
+		case hwmon_temp_max:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_min:
+		case hwmon_temp_min_hyst:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_humidity:
+		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
+			return 0;
+		switch (attr) {
+		case hwmon_humidity_input:
+		case hwmon_humidity_alarm:
+			return 0444;
+		case hwmon_humidity_max:
+		case hwmon_humidity_max_hyst:
+		case hwmon_humidity_min:
+		case hwmon_humidity_min_hyst:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	enum sht3x_limits index;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			*val = update_interval_read(dev);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val = temp1_input_read(dev);
+			break;
+		case hwmon_temp_alarm:
+			*val = temp1_alarm_read(dev);
+			break;
+		case hwmon_temp_max:
+			index = limit_max;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_max_hyst:
+			index = limit_max_hyst;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_min:
+			index = limit_min;
+			*val = temp1_limit_read(dev, index);
+			break;
+		case hwmon_temp_min_hyst:
+			index = limit_min_hyst;
+			*val = temp1_limit_read(dev, index);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_input:
+			*val = humidity1_input_read(dev);
+			break;
+		case hwmon_humidity_alarm:
+			*val = humidity1_alarm_read(dev);
+			break;
+		case hwmon_humidity_max:
+			index = limit_max;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_max_hyst:
+			index = limit_max_hyst;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_min:
+			index = limit_min;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		case hwmon_humidity_min_hyst:
+			index = limit_min_hyst;
+			*val = humidity1_limit_read(dev, index);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
+{
+	enum sht3x_limits index;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return update_interval_write(dev, (const char *)&val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_max:
+			index = limit_max;
+			break;
+		case hwmon_temp_max_hyst:
+			index = limit_max_hyst;
+			break;
+		case hwmon_temp_min:
+			index = limit_min;
+			break;
+		case hwmon_temp_min_hyst:
+			index = limit_min_hyst;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return temp1_limit_write(dev, index, (const char *)&val);
+	case hwmon_humidity:
+		switch (attr) {
+		case hwmon_humidity_max:
+			index = limit_max;
+			break;
+		case hwmon_humidity_max_hyst:
+			index = limit_max_hyst;
+			break;
+		case hwmon_humidity_min:
+			index = limit_min;
+			break;
+		case hwmon_humidity_min_hyst:
+			index = limit_min_hyst;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return humidity1_limit_write(dev, index, (const char *)val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops sht3x_ops = {
+	.is_visible = sht3x_is_visible,
+	.read = sht3x_read,
+	.write = sht3x_write,
+};
+
+static const struct hwmon_chip_info sht3x_chip_info = {
+	.ops = &sht3x_ops,
+	.info = sht3x_channel_info,
+};
 
 static int sht3x_probe(struct i2c_client *client)
 {
@@ -730,7 +864,6 @@ static int sht3x_probe(struct i2c_client *client)
 	struct device *hwmon_dev;
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
-	const struct attribute_group **attribute_groups;
 
 	/*
 	 * we require full i2c support since the sht3x uses multi-byte read and
@@ -771,15 +904,11 @@ static int sht3x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
-		attribute_groups = sts3x_groups;
-	else
-		attribute_groups = sht3x_groups;
-
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
-							   client->name,
-							   data,
-							   attribute_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+							 client->name,
+							 data,
+							 &sht3x_chip_info,
+							 sht3x_groups);
 
 	if (IS_ERR(hwmon_dev))
 		dev_dbg(dev, "unable to register hwmon device\n");
-- 
2.30.2

