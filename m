Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6836070A6F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjETJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjETJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:55:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D6E5D;
        Sat, 20 May 2023 02:55:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f0678de80so761576466b.3;
        Sat, 20 May 2023 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684576521; x=1687168521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOV4ikLHil+NmCoyv1115ovSQRMzJUspMmqIvjYUuKM=;
        b=FHcZ1k1g7sXLkHNpv6ic4+tkTVXUywEYJzle/yG0N/CMNC1eFCzljipnXyyimtssOu
         kNHH8XvLOQb2n8xyGTQykpYfi+/I0nlvKEiGQ9CshuXejlWiJjeKupjzQu8HJ5HJuR1J
         xz7jQadwrVf8MH6KZ4itnQ+Q2agYYTyaDmlJ8HajEWuAKL+mMH5qvK6lMuAp0qjz+hg1
         2nzvCVpJ1xLMl9lbt225ztlsl8b6T6btweSWuUEi3Q1U/ekpbw01mMW5T0jLQR4qb/xP
         oMs4VRKWa/LMdH5YSXdqeFldKM55hHHluz1Aoq1+1fkJolc9IoRWg7qGdqBMBAuEFa3a
         NdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684576521; x=1687168521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOV4ikLHil+NmCoyv1115ovSQRMzJUspMmqIvjYUuKM=;
        b=JStZd+d28UP+LwsNEBmvntl5HmfT7T7Oh9dbrB4ZhUj6fUmmIa/pAMTbpMRy6bP4M5
         +l417et8lo8TLG21y4ZpjDsNIJXu2K3bA8IzzwnpuOPUARYBoU6SNQDv4VOA3S8xlXKo
         vgZ16nmjs/FDmYLOZBOMD/DsOUPR3WYnvxvi9UOVe3yAVAzR5/mPlUYtDxxLFhG0QSOb
         rdIg1dIAJQVATRd07fgDA/0pfz6vUIwsurgy5mHdcGCQ6CdXyJwmRTLxl50EZIPj0/H2
         DdIrHk5Tfa1ayHqGOMwaQvVvvSdxYNuVV/pONc+WrhcXyRf4PNHKB3SSiyIOK3dCf8FQ
         7KrA==
X-Gm-Message-State: AC+VfDy3GvmV+QPNNUQBA52tSxGrm+qfZq4teI/nrFEQ9L4wSFPVnK4Z
        kNzabOPEPD7+44yxNpCUUatd8cN6lawtrQ==
X-Google-Smtp-Source: ACHHUZ7yk2TCpjeK6BxFnIwFPnKHixvR/QPXLEbX/S45x5idRf3H/SQCh/wieLMmuOCnNYfxPnclJg==
X-Received: by 2002:a17:906:4d8f:b0:94f:3bf7:dacf with SMTP id s15-20020a1709064d8f00b0094f3bf7dacfmr4341977eju.71.1684576521184;
        Sat, 20 May 2023 02:55:21 -0700 (PDT)
Received: from fedora.. ([87.116.164.240])
        by smtp.gmail.com with ESMTPSA id jy18-20020a170907763200b0094e1344ddfdsm628335ejc.34.2023.05.20.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 02:55:20 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     main@ehvag.de, Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_DISCONNECTED
Date:   Sat, 20 May 2023 11:54:46 +0200
Message-Id: <20230520095447.509287-2-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520095447.509287-1-savicaleksa83@gmail.com>
References: <20230520095447.509287-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the macro in question to AQC_SENSOR_NA because
more than just temperature sensors use this value to
indicate that they don't have a reading. Implemented by
Noah Bergbauer [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/41

Originally-from: Noah Bergbauer <main@ehvag.de>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Introduced this patch
---
 drivers/hwmon/aquacomputer_d5next.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a4fcd4ebf76c..834d011e220f 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -93,7 +93,7 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQC_FIRMWARE_VERSION		0xD
 
 #define AQC_SENSOR_SIZE			0x02
-#define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
+#define AQC_SENSOR_NA			0x7FFF
 #define AQC_FAN_PERCENT_OFFSET		0x00
 #define AQC_FAN_VOLTAGE_OFFSET		0x02
 #define AQC_FAN_CURRENT_OFFSET		0x04
@@ -1224,7 +1224,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		sensor_value = get_unaligned_be16(data +
 						  priv->temp_sensor_start_offset +
 						  i * AQC_SENSOR_SIZE);
-		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+		if (sensor_value == AQC_SENSOR_NA)
 			priv->temp_input[i] = -ENODATA;
 		else
 			priv->temp_input[i] = sensor_value * 10;
@@ -1235,7 +1235,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		sensor_value = get_unaligned_be16(data +
 						  priv->virtual_temp_sensor_start_offset +
 						  j * AQC_SENSOR_SIZE);
-		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+		if (sensor_value == AQC_SENSOR_NA)
 			priv->temp_input[i] = -ENODATA;
 		else
 			priv->temp_input[i] = sensor_value * 10;
@@ -1277,7 +1277,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 			sensor_value = get_unaligned_be16(data +
 					priv->calc_virt_temp_sensor_start_offset +
 					j * AQC_SENSOR_SIZE);
-			if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+			if (sensor_value == AQC_SENSOR_NA)
 				priv->temp_input[i] = -ENODATA;
 			else
 				priv->temp_input[i] = sensor_value * 10;
-- 
2.40.1

