Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1909733551
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbjFPQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbjFPQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:01:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2035.outbound.protection.outlook.com [40.92.91.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B483AA3;
        Fri, 16 Jun 2023 09:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luQ01OMzrUkPqfGR8WOhVbon0RFD4aA6rRQSB8IvkUHuy2K70gVS/fBUxR6DR3V0XEeGUmWnlPpqe94tl4m2mB+MEEyRtMxc9VZxMkKOf0s3FelZZ4wHhZRmS7nQzr+80/XFCGbHlENCMbp1bWdh/SvnCjVGUMl2HWxg0eYT4A4HJ8N4O5aOX1ZW0xw3Tb8dmzYG9TmYCsC9oWYNWo2jBRr4QcN0+myjXxkttYVLqR8U+LBkqEIMYHsJDyFGA7K0LXLwJlGXCUu6mhVAJ0UFoBPJ3KC48bTx/VmrYYiSgtBoKYEBFwr389XtdXaX1HpeZppGxCEET99kB0TEyYg+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of3MSRoZQsE4iQhpOZGiEcdvt3oFHJp0hiZHk4tIwPA=;
 b=B0MFOn093sJkn/1BvrcJCPTgeLc1CIs0WJh30Ld/IjiAJJbyiRRgaW8VI2y5N98qRdoatWyOWqfkwRRv4qnFbUOXkyFU6u1qd3hmevkmoFiHwF/vWWZRRZLEF+WxFOx/wN7kwaHa682pnoJPEDI/1PAmWJZ6YEw4Uxyqn60SBFrEP9YJWm1L9Q+IzLUdjZNqVcGygijp5Yb3B6kVlS1g0F5dHbWsClHx4w6Rxv6GitaOQ/OtpVVHqtWcAX2/8glr/f8FD24CFWz+i88JFjGNEMAZrU5YXaTPwB6hoa4IdtPTwFovNE3wprYgMkF/gymAOQW+pqgyHS7p1d/OPo+Xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of3MSRoZQsE4iQhpOZGiEcdvt3oFHJp0hiZHk4tIwPA=;
 b=ZyGCElTQ8QzbWz6DjbeYrG58sVz7IY/d2tcCsIIJ+FkG1zHReaTOwe5m6qOwkQAaYebIRZcxFzl8QJUG7thZjqhcL98TDZr4hJDeKGsCeL6JA1AJFym+2ajIebm5M1E2cVAvzRFwEK5fOyApxSndnZEuyNCayczA5EaHJlmLH+GlvSZKGZ7ljSrszpi1oEDulPHqS+zWien8vczsyih+U0aSNQlFqZGu6sho9UbenDaTcG182tXnTiUgdTEyI7hRe73AxFqgzQP7LJVbDO++LQxTvM14Fpv5NbSDw76LRLeG0Kv+kEjAEDWAUh85FfB+EmFcFwkHBf8B8RF/YzjISA==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:01:04 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:01:04 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 3/6] hwmon: (sht3x)replace "high-precision" property to "repeatability"
Date:   Sat, 17 Jun 2023 00:00:14 +0800
Message-ID: <DB4PR10MB626113BFFA66DE32C3479D229258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [7yZHOyOLKKKM+A8Y6kXBSA496cuFisWz]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-3-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: d39db6f2-4a1b-42d4-9508-08db6e82e35f
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrST/aUJU0/QQB6BlKfxJxwIUDlqYXA3VDxPZ0UqcuxpJun1s8ED3wRvwfzqA/OCz4lJZXt4vRmC40V3YOkqpxBhq1REbaH/S28u5ZSAiWND2n2acPUecUx2n7c/11ouaLXJ6BLvPUNXIkyYDin/x6Pj1ljiqUsuYSLBUk2yC7i1mlxJDUK2WcBATw+rPbaYvY35/NJEnUlaL5Mha5dUMNpV2l264qxc7zFseqi8MiNLfKLTXAJkPDZ4qIvfl8l42y2JO5jC0xfvq+fy1TqyMVB535yXfNY411I8+RSxCCBfHVGuRr1Zs3LbhWtyC61onvP4V6iXuRq3rIkbPLWXONwJvXtLFr8mHz4dLScsyAx1CWYA/tiib3g61fmw5HSVm6h9PZO0ZyLMw0q4Qz1uDw+7uvQaRG0B1nj6FsUg3nljERmxRNjE8vbeFC8qJU8JoivV8P8XUpHAF9rwqMAID68GSEkBjw5Dx0lMlhi/H+E/UvvmjE/YPSRzkUZMjRtJ3hGClYIC2UZPtvlqlrnAWDSmQ8n50r1igvwfyBML+rN8/4wEgF2E+M+GZMbDja+wmF/vFe/wSN3m7xaOAFSqkeMcT6wI6Npp8R6j66Y5Py6inVOGuXWjqLplrF4MpnmVwV8GCFD8FAaYbumNVTD/w8VC4SBbPSLNmJyH+GpaY7mWJHwa22Uo9/zhwYxNe75rv5PcEfWchQ14/L68GkNVLxxczfPRa1MajyalqziDfs5wp15shKP68xrYc8dntFpjqU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kmmp4z8Q2NptD+ZmKUCp7Q2+EI1RHAtynwntCOM4cW3bFhFDBLuy3Mfa1M4nrdI9O2q/+nHqSTqCiHGAgg4O7tyYgrQuqyTy6FBJtPGOKDBpMxcUjzHsmhGeWkHh6GQ2pyFD6rguzDv5WIjP0xCGa3pcp0sxZn1pIAosJVEEh89py97f3082Z6z5SKGgNYVI75/9H4j3wo/oN4H/WSwAUbKQoDZx89YouIA/4S6BqQiMQggVLGZo0AFdn1RVTS68+cDynvrO0/TLwbAt7d2jKbjkCKlz3h0BMOUFeHwak5FIkEwes2AY+ws2utmPZXpnGGGv4m80qzjqzgy/+5gP2Xs3TkKoqoL/FgOE0fOmP8abm6NNIjPbJ/XBiIQddAajCniWm+4x2wzeLgo+ccu9czHektGuM+p/QUporWHFlPuG5tjClubnG5+ZtpGU7U89vYn9cHGNGHA0mziWXGpSP/8VrY1HKmjMX7w7C7xqi0uJ82j0xxc3pBFijVp9B4ADMKQQfcX8XepmYnLVB7MSCzCpuO1S5l+/OSTHPTKWaFbhmuYMc+66pP/Nvt3hFcCSdlvP+yB6VF2lLmo++RRBlfMXiGkKRBEv0nD6U95B4Zc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+WmCzDgpRGdXqZ+EMTcpI0LwjK/OYuBBX/QMEq9dpTLIg6JsjKsRt9vgN0x?=
 =?us-ascii?Q?Wt3ccC4g29IdBbggAbbIOrcCvwEN+0rh7yM83b5G6wvXou0cad54b8L4N+/N?=
 =?us-ascii?Q?KVgfmhtfM9De4rg4E+eh+Hp9uiyc1v3mlVOQWoCEuLaE8l+ao0tkTu+b051o?=
 =?us-ascii?Q?hhpSU55vQ4282yPJXKa8m3LEO45K93/+dPY6tdMpIlWKoXO7LEeBSI0+p6hW?=
 =?us-ascii?Q?WG4DHJqp+jnjSuYnRfT9vTYM9MVjP5tNncqFmQIsWxRgoPu5oOJNagoXAl0f?=
 =?us-ascii?Q?XgokUv59dth+yyExCiWzBI5mc9SJyH6YnB+zn2V/CaMfepHyuHkVkYCNPMry?=
 =?us-ascii?Q?WsiPJESytFNj7KK8UbwxAdIqMaf/bJgHAQB6DB0NVvl4k6eEtvohi65r63s7?=
 =?us-ascii?Q?MMVyvVYqCy6PM5+dmPJuFuZqy3QULtCnxzrXjC2jkJq5luSfjcu/MZYCJRxF?=
 =?us-ascii?Q?62JcYrDXFFLRYml+Xg7KRYDIwGzqAf4UvdJbqXOhqePbyJJC6aqvqZxEk8oN?=
 =?us-ascii?Q?X4gENV/8n9gPH6Jrg+hNXr2QAT09dkpyHqIvo4jVyqBvSFgb2RvRsiOKT6IS?=
 =?us-ascii?Q?zILbKXKunAkBMbgJ8L50aSd9jAUc2biOKpqswSUBq21SCmY++yipZtOovMLc?=
 =?us-ascii?Q?XJ6AbhTXXlG/axwsy+GrR+6SG2bSnt64aLrhYNQWgcFaRhwZenFCHjkTaRZv?=
 =?us-ascii?Q?Xt4Nt/8mn92eF5/eMjaQpRNMRMYZgWrWJQqhk4MI1dJ2qE/HrawN0CJ2b8tA?=
 =?us-ascii?Q?7yXSimHWjuLah1Mi6ZashdZr+AUI7efRmISSD6rVPyh8Cn4b1gKl6ag2/wFC?=
 =?us-ascii?Q?JWiB4rGcmc2O0BUYSj5N9kA2lEHdPdClQQcP3HnLWktNWsaCnWiquVjx+n8+?=
 =?us-ascii?Q?IAeAVMo9vNXrjrSxvMrv83qW5eFn51uzWmlbD2h3SjgPb8aQjOFXeFZuMUOd?=
 =?us-ascii?Q?1VnYo6T9PAxWEAMnLw+cZH/b6y3RsUDXgpvdtEOFX+FNaM2jqAjlqZM0/QKh?=
 =?us-ascii?Q?CqQTghO88LoWxXCqzsJtTcJUASrMbuGru7E4NP7W3WZX6f3383jPQRyGLJHv?=
 =?us-ascii?Q?EikclUlmE8kOV0dOF6qK7tszSvNdePQsDJL/tZuiDv2zrLnP45ridZVl9Kqr?=
 =?us-ascii?Q?6QpvbMfh5zG6WrtT/RZE3tn3BIc2caC9aVGncpsk5KGLc/VYUVNtB9aQRAc3?=
 =?us-ascii?Q?BJ797EcsE5qgHJPkQEJY6ioOjV91wdxVfMIL5dPy8CB3wvcg0i3FsWSL7PU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d39db6f2-4a1b-42d4-9508-08db6e82e35f
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:01:04.6662
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

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst |  2 +-
 drivers/hwmon/sht3x.c         | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index be70e2543..b4aa561f0 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -30,7 +30,7 @@ Documentation/i2c/instantiating-devices.rst for methods to instantiate the devic
 
 There is only one option configurable by means of sht3x_data:
 
-   high or low accuracy. High accuracy is used by default and using it is
+   repeatability: high repeatability is used by default and using it is
    strongly recommended.
 
 Even if sht3x sensor supports clock-strech(blocking mode) and non-strench
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index bbe556f44..ecc64febc 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -21,10 +21,10 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 
-/* commands (high precision mode) */
+/* commands (high repeatability mode) */
 static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
 
-/* commands (low power mode) */
+/* commands (low repeatability mode) */
 static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
 
 /* commands for periodic mode */
@@ -66,9 +66,14 @@ enum sht3x_limits {
 	limit_min_hyst,
 };
 
+enum sht3x_repeatability {
+	low_repeatability,
+	high_repeatability,
+};
+
 DECLARE_CRC8_TABLE(sht3x_crc8_table);
 
-/* periodic measure commands (high precision mode) */
+/* periodic measure commands (high repeatability mode) */
 static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
 	{0x20, 0x32},
@@ -82,7 +87,7 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	{0x27, 0x37},
 };
 
-/* periodic measure commands (low power mode) */
+/* periodic measure commands (low repeatability mode) */
 static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
 	{0x20, 0x2f},
@@ -132,7 +137,7 @@ struct sht3x_data {
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
-	bool high_precision;
+	enum sht3x_repeatability repeatability;
 
 	/*
 	 * cached values for temperature and humidity and limits
@@ -436,7 +441,7 @@ static void sht3x_select_command(struct sht3x_data *data)
 		data->command = sht3x_cmd_measure_periodic_mode;
 		data->wait_time = 0;
 	} else {
-		if (data->high_precision) {
+		if (data->repeatability == high_repeatability) {
 			data->command = sht3x_cmd_measure_single_hpm;
 			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
 		} else {
@@ -584,7 +589,7 @@ static ssize_t update_interval_store(struct device *dev,
 	}
 
 	if (mode > 0) {
-		if (data->high_precision)
+		if (data->repeatability == high_repeatability)
 			command = periodic_measure_commands_hpm[mode - 1];
 		else
 			command = periodic_measure_commands_lpm[mode - 1];
@@ -679,7 +684,7 @@ static int sht3x_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->high_precision = true;
+	data->repeatability = high_repeatability;
 	data->mode = 0;
 	data->last_update = jiffies - msecs_to_jiffies(3000);
 	data->client = client;
-- 
2.30.2

