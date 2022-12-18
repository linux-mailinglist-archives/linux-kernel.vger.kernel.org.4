Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CDF64FEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLRLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiLRLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968EC5FCD;
        Sun, 18 Dec 2022 03:32:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6979734wme.5;
        Sun, 18 Dec 2022 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLjJfom/Djky4gJzOObWXZRGBYjZpEjW1f7nmI91XpI=;
        b=RYFhvq3UuA1RlSEtXy76MNft8qV3J3SYjxceU6+W/2yaQ5XjS35UK6Xx4nkY+6Q3nH
         AVtfbyCcrFcUDa9qUdEKAN06yySkNyEoPefRksOH6iT+M178KlbjroWFWXlHToExXOL5
         1RWB5hKHNVVVv4muz6KDbn423Lis+18ixeMkzZT2FdjXwPBF4877bdBZ1PViRsnVqucH
         WSLZfx2smHC+rCVs4XGDZ+DwU5t4kg+Tnp5+RPnYFBBrPU0cb9Ib+42FsSyfoMLS687u
         6NQPqAMNfKrQnj4xjfLLUY2MGaQyBTyw0hIDQd2Bm58fAo52E0ZX32kHmyA1pTz+F/CI
         DIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLjJfom/Djky4gJzOObWXZRGBYjZpEjW1f7nmI91XpI=;
        b=Z36attyEOynvCy6FCw1Lz27t9iNn46inblryVGZJq22ZUWmPttrweRh5cBHdvN9McM
         X8b+v+ocYvJuvzKlk0IILLe4+y3hN3r6CvlPz1Djn5FAsXnrBxxHXcImY+GgblsCzKrW
         1duQ7UNPP9TYMj8fzWLR3P2Nuov0szuiHIwVBh6NZ4Q/R6mWT0L6SEgh+QGWiw+KUkHn
         wPrJGSGjraXQvsYLc2/OqiU5q860hhMs7xP+BTz9rEmYqp/d1qOZbbqqN67BcfG9OWZO
         tZbhRofix1I/JD72YQCIyJ66H6EwEG99prKhiDbXRdJmDvv2DYlmp2p7DE6XLlc3mNyM
         4hzQ==
X-Gm-Message-State: ANoB5pm5jSv95UjRK8iMSK+V2TlxkgMJu8NqVYtkQ2ns86pVxZpcEuXZ
        FwPIY+jO7TF9osaTzeRXrlFxFVTtFBME7EoB
X-Google-Smtp-Source: AA0mqf5J2dKxLGdrSUWQsEJ4+4N8P2+k9DxXVA1Q0iGylxqEwxcHn0DgJtE4fznDovotRigng/hIFw==
X-Received: by 2002:a05:600c:3511:b0:3cf:7b8b:6521 with SMTP id h17-20020a05600c351100b003cf7b8b6521mr30384391wmq.32.1671363124085;
        Sun, 18 Dec 2022 03:32:04 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:03 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 4/6] hwmon: (aquacomputer_d5next) Device dependent serial number and firmware offsets
Date:   Sun, 18 Dec 2022 12:31:29 +0100
Message-Id: <20221218113131.3752-5-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218113131.3752-1-leonard.anderweit@gmail.com>
References: <20221218113131.3752-1-leonard.anderweit@gmail.com>
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

Add device dependent serial number and firmware offsets to support
devices with different offsets. All currently supported devices share
the same offsets. Implemented by Aleksa Savic [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/31/commits/14c3acf78b17397edb5dd356e6f5943a9996a1f9

Originally-from: Aleksa Savic <savicaleksa83@gmail.com>
Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 1ea866fcd3ec..cc53231067f4 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -43,9 +43,7 @@ static const char *const aqc_device_names[] = {
 
 #define STATUS_REPORT_ID		0x01
 #define STATUS_UPDATE_INTERVAL		(2 * HZ)	/* In seconds */
-#define SERIAL_FIRST_PART		3
-#define SERIAL_SECOND_PART		5
-#define FIRMWARE_VERSION		13
+#define SERIAL_PART_OFFSET		2
 
 #define CTRL_REPORT_ID			0x03
 
@@ -59,7 +57,10 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
-/* Sensor sizes and offsets for all Aquacomputer devices */
+/* Info, sensor sizes and offsets for all Aquacomputer devices */
+#define AQC_SERIAL_START		0x3
+#define AQC_FIRMWARE_VERSION		0xD
+
 #define AQC_SENSOR_SIZE			0x02
 #define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
 #define AQC_FAN_PERCENT_OFFSET		0x00
@@ -326,7 +327,9 @@ struct aqc_data {
 	struct aqc_fan_structure_offsets *fan_structure;
 
 	/* General info, same across all devices */
+	u8 serial_number_start_offset;
 	u32 serial_number[2];
+	u8 firmware_version_offset;
 	u16 firmware_version;
 
 	/* How many times the device was powered on, if available */
@@ -808,9 +811,10 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	priv = hid_get_drvdata(hdev);
 
 	/* Info provided with every report */
-	priv->serial_number[0] = get_unaligned_be16(data + SERIAL_FIRST_PART);
-	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
-	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
+	priv->serial_number[0] = get_unaligned_be16(data + priv->serial_number_start_offset);
+	priv->serial_number[1] = get_unaligned_be16(data + priv->serial_number_start_offset +
+						    SERIAL_PART_OFFSET);
+	priv->firmware_version = get_unaligned_be16(data + priv->firmware_version_offset);
 
 	/* Physical temperature sensor readings */
 	for (i = 0; i < priv->num_temp_sensors; i++) {
@@ -1096,6 +1100,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	}
 
+	priv->serial_number_start_offset = AQC_SERIAL_START;
+	priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
+
 	priv->fan_structure = &aqc_general_fan_structure;
 
 	if (priv->buffer_size != 0) {
-- 
2.38.1

