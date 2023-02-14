Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EABE69705C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjBNWCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C4E2B0B3;
        Tue, 14 Feb 2023 14:01:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l2so608893wry.0;
        Tue, 14 Feb 2023 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrxmW2KQawIfFzS6qpWZdNTYLIimlBJFQO9rfVDksZ4=;
        b=RHDcbKAoZwGoa+xK9ukxAmbQJf9gJll9jpnm26D9HXdVSbGP7+OyIgEmkJoSl5kiDG
         Qnn+Og/4Z9EmirWHWZEyRKMVa9QiRNDvXeUMUcOYph5NYUM7Scj2xfX1M/rRrZAHmzz9
         1qeP52fhtEYBZBIE7JanxtqNop6Vnf4gYiwwGgMufMOkr/LwD2tXihFzThWOJH0H0ZY/
         m7+pqxISN4uUIANITBuYK3SveKlw9e3bfKxzseGwxHMLUKbF+5JkFC2p0REgErdn9bmo
         oYC1OxDqwUOEg1l06PzzDBlao+1tpQMWASgjALiLqOKebhHjhVd0hzw/iB4oSMPgGKv+
         CJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrxmW2KQawIfFzS6qpWZdNTYLIimlBJFQO9rfVDksZ4=;
        b=lLnfsgD1L+6zRZ0MikqGyVUDtvbaAXMy9sDLmyviqQ3PAj3D89USC+/wL2YTaNyqo5
         KKpQwEaxoBH34mtIJHZA/NqdlABlrK6sjHwhPIZ3CA6MwHVINamf1XYI+q4SxirUma2a
         Y/xgsWvhr4SKRrqEu48cAi3rl2FUnyr3dDF3v/KbRmiyy/wph2vLPrBxVOwFRtxk+sX2
         Cb1PH0mfMqwQqi+s/Pj+WSKivKy7RvhYQUSrvgN8i0GsN1QBfFUAENuW04tNcxXTd/tv
         b9AExTclLU1awFr6EdejomZHy6M+VxO9vgt4YzB3UCNB9hq2yMJNkI4r9oqU5Mp5fKUh
         61WQ==
X-Gm-Message-State: AO0yUKUmueQmWz5/y9xKsm4o98y6N2rd5kbMNMiaXTllc/fip/RXTjEQ
        rMYTRwM9wknZi8XnOJmwYAirBwy0ycXZUA==
X-Google-Smtp-Source: AK7set8z29MXIXlKOWSohYfEM9ibTud9wiQlpJMD3wnSS2vqmcBWLyB5AkGGsWQLFj5fHVQ1iY5eyg==
X-Received: by 2002:adf:f64f:0:b0:2bf:bf05:85ac with SMTP id x15-20020adff64f000000b002bfbf0585acmr299715wrp.23.1676412113811;
        Tue, 14 Feb 2023 14:01:53 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:53 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 4/6] hwmon: (aquacomputer_d5next) Add infrastructure for Aquaero control reports
Date:   Tue, 14 Feb 2023 23:02:19 +0100
Message-Id: <20230214220221.15003-5-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214220221.15003-1-leonard.anderweit@gmail.com>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information on the Aquacomputer Aquaero control report and disable the
control report checksum for Aquaero. The Aquaero does not use the checksum so
it must be disabled to avoid overwriting the last two bytes of the control
report.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 31 ++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 535d2fc0e55c..eb185318098a 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -56,6 +56,7 @@ static const char *const aqc_device_names[] = {
 #define SERIAL_PART_OFFSET		2
 
 #define CTRL_REPORT_ID			0x03
+#define AQUAERO_CTRL_REPORT_ID		0x0b
 
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
@@ -67,6 +68,14 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
+/* Secondary HID report values for Aquaero */
+#define AQUAERO_SECONDARY_CTRL_REPORT_ID	0x06
+#define AQUAERO_SECONDARY_CTRL_REPORT_SIZE	0x07
+
+static u8 aquaero_secondary_ctrl_report[] = {
+	0x06, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00
+};
+
 /* Report IDs for legacy devices */
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
@@ -94,6 +103,7 @@ static u8 secondary_ctrl_report[] = {
 #define AQUAERO_NUM_VIRTUAL_SENSORS		8
 #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
 #define AQUAERO_NUM_FLOW_SENSORS		2
+#define AQUAERO_CTRL_REPORT_SIZE		0xa93
 
 /* Sensor report offsets for Aquaero fan controllers */
 #define AQUAERO_SENSOR_START			0x65
@@ -531,12 +541,16 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	int ret;
 	u16 checksum;
 
-	/* Init and xorout value for CRC-16/USB is 0xffff */
-	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);
-	checksum ^= 0xffff;
+	/* Checksum is not needed for Aquaero */
+	if (priv->kind != aquaero) {
+		/* Init and xorout value for CRC-16/USB is 0xffff */
+		checksum = crc16(0xffff, priv->buffer + priv->checksum_start,
+				 priv->checksum_length);
+		checksum ^= 0xffff;
 
-	/* Place the new checksum at the end of the report */
-	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
+		/* Place the new checksum at the end of the report */
+		put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
+	}
 
 	/* Send the patched up report back to the device */
 	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
@@ -1280,6 +1294,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
 		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
 
+		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
+
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
@@ -1443,6 +1459,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
 
 		priv->fan_structure = &aqc_aquaero_fan_structure;
+
+		priv->ctrl_report_id = AQUAERO_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_id = AQUAERO_SECONDARY_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_size = AQUAERO_SECONDARY_CTRL_REPORT_SIZE;
+		priv->secondary_ctrl_report = aquaero_secondary_ctrl_report;
 		break;
 	case poweradjust3:
 		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
-- 
2.39.1

