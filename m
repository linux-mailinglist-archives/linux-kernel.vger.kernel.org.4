Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6769705B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjBNWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8933830B2E;
        Tue, 14 Feb 2023 14:01:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a2so17243159wrd.6;
        Tue, 14 Feb 2023 14:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa51H3f4eapSWiBabLmEx5vtaOrCOecKwtW5XZydamw=;
        b=TGC1OtiGHfVN5n4B9ebL14p5ELUTAPaQDqPR7LAkkGfm6Gjxe6+OIVaUMVBCfiRuAZ
         txO/voM/BY+W1Q0VhXKq0YdsIdt3lr6kpIZE2B7SbhcOMjC9QRLlBnzN5La8GxTV5JJO
         MZIm7hTJyeRu8EFYBdTbTvdKwW48FrA8QogNPFq3yZb2ef79FLekKR06XNAH/1dRnNV+
         4Ee9uQRCL3VdmDGIWQ726UZWfL5TVgl+QV51jzbtIqctJP3xRHW/7EiXz1HGnOtH1Qrb
         xomSJlUyinYeusQ01Idyjx/s1Ws2qoVvyyWIan9hUlYUAmq0h4jK8D2fWzPZu1S4bzQ/
         3vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa51H3f4eapSWiBabLmEx5vtaOrCOecKwtW5XZydamw=;
        b=WxEBeDgAR/YgbYBKXtJ8595hMupFzJRC1kOpmNGtexk9vtUV/qqteyzUXipPIFrZC6
         OdMsJQBV7f54vz8EIKMscy7mckMuqnGes4eDIB//PKasJQUjQGs0V6EQWf7S2mE+F0+Y
         6OUtbHiZi9zsRi2MOXwXDETF0KOcW0H+nPcQWX0ZNi051qB8a8cgozB299gwgZqsdUWp
         1JbXoUpsA/IypTp9vNGiwUXmb2Zj5rSVXoKQbIGMg9/DDSeTVhM0rIIOO+AW8xuQ4368
         0OgDTHVruqBlLSu+18G982kMmVMVgr0FddhAT/8z9lHzwBgj3yPH9Wish10nr4n2EeEz
         zR+Q==
X-Gm-Message-State: AO0yUKXm1SuDSsZe7/Y8lzPPgNIT3Sevq762WrhghvhNSu4ZGYKivlQA
        gumATih83w3+bB5jpwkORu2iou6tNezYIA==
X-Google-Smtp-Source: AK7set+hzVw8XX9Hzz6FT1XbLaH91lQbIJJEwutR3UKx/ebEWryobUwQpgZZclJH1g6Jjn2ZCTdVeg==
X-Received: by 2002:adf:e78b:0:b0:2c5:53a1:eeb with SMTP id n11-20020adfe78b000000b002c553a10eebmr3685304wrm.54.1676412113006;
        Tue, 14 Feb 2023 14:01:53 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 3/6] hwmon: (aquacomputer_d5next) Device dependent control report settings
Date:   Tue, 14 Feb 2023 23:02:18 +0100
Message-Id: <20230214220221.15003-4-leonard.anderweit@gmail.com>
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

Add device dependent control report id, secondary control report id, secondary
control report size and secondary control report for devices which need
different control report settings. All currently supported devices use the same
values.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index f0c036d38e91..535d2fc0e55c 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -441,6 +441,10 @@ struct aqc_data {
 	const char *name;
 
 	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
+	int ctrl_report_id;
+	int secondary_ctrl_report_id;
+	int secondary_ctrl_report_size;
+	u8 *secondary_ctrl_report;
 
 	int buffer_size;
 	u8 *buffer;
@@ -513,7 +517,7 @@ static int aqc_get_ctrl_data(struct aqc_data *priv)
 	int ret;
 
 	memset(priv->buffer, 0x00, priv->buffer_size);
-	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		ret = -ENODATA;
@@ -535,15 +539,15 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
 
 	/* Send the patched up report back to the device */
-	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	if (ret < 0)
 		return ret;
 
 	/* The official software sends this report after every change, so do it here as well */
-	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
-				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
-				 HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
+				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	return ret;
 }
 
@@ -1447,6 +1451,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->serial_number_start_offset = AQC_SERIAL_START;
 		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
 
+		priv->ctrl_report_id = CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_id = SECONDARY_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_size = SECONDARY_CTRL_REPORT_SIZE;
+		priv->secondary_ctrl_report = secondary_ctrl_report;
+
 		if (priv->kind == aquastreamult)
 			priv->fan_structure = &aqc_aquastreamult_fan_structure;
 		else
-- 
2.39.1

