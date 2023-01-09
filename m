Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5D663297
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjAIVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbjAIVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:17:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8F15804;
        Mon,  9 Jan 2023 13:15:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i15so14574079edf.2;
        Mon, 09 Jan 2023 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5boNUO8wPWpy3o+MgKdh6wUcOP724f9MQl+BiJzFcxg=;
        b=l4LQLVbxa7LMDYQrOp5Vg8ZlaqlAzwr+5f/+pAmTV8N7w90wDY7Yvj5tGhpq6QYmqq
         wKspBE/OzEsXqJEHX0VLvV51NN9YVPNppmLatyZ9fhpKvhfCAozDknu/PC4yIrT0JZvN
         oetw+2H9YjlL5irC+cfdR0s2g2U7l//R4B1SxIm2uXsbhVs2ks5VtXZeUuh71bAHiVuM
         VEVFiWkPUdeqLp3ummcE7PaFjpI0dg5tFLvv7rJDHEHQdtDJBBWQZRZDLStw4FPt+HXR
         RnpN2Nhne1chUJoXNqS4uBteW5HpeNRY9b54twUneF6U7Rc2lHFYj9eNND4HowdUK6KC
         3+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5boNUO8wPWpy3o+MgKdh6wUcOP724f9MQl+BiJzFcxg=;
        b=l4mBVbv9kT1zD8ISs5XRT+3BxUlYhVuVpOWIpV0auooPzkPJFaDYQgSTIcZAjxMFA4
         rJvYyqfKR6nm22NZ0bn0g8muSWtvFoV368bUjL/HrTcIgPUKGYr/qpMBuK9Re6OzQ305
         DFhiDSR99Q90y8l4s1HrfX++kdo/93tNEe6xDtNu0op3tsawX4hrBKjwh+KIuMZGBKof
         wyXBCQT3r2vDnRpPOZolqr8fszaNedLmBGB6MwddJFtTWieC5T72aaOYBKBxU6jfTBHb
         t/xsN7hoymFt1NJasGPG65F5MyMKoN+geqgFmlSXCHTzLt1fm0c1OPzvJ/X9NDtsFWZv
         SNGw==
X-Gm-Message-State: AFqh2krwKDtB0VyY9IHUAMq2yYUQwm5KwbxW+Nlde5zQp5H4FpwxRto0
        nNnRZzqS2ZgM9ETAFJHw7is=
X-Google-Smtp-Source: AMrXdXvxUEZrcagSn8YsZwORT0VcBoetfbuxxX40tCNoQzCh6fpyOtUU8OBJ4xH1dIjlE5lpgOaFEA==
X-Received: by 2002:a05:6402:530d:b0:47e:f535:e9a0 with SMTP id eo13-20020a056402530d00b0047ef535e9a0mr55249701edb.24.1673298945121;
        Mon, 09 Jan 2023 13:15:45 -0800 (PST)
Received: from localhost.localdomain ([46.211.224.63])
        by smtp.googlemail.com with ESMTPSA id ba6-20020a0564021ac600b0045cf4f72b04sm4143824edb.94.2023.01.09.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:15:44 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name,
        pauk.denis@gmail.com, pehlm@pekholm.org, renedis@hotmail.com,
        robert@swiecki.net, sahan.h.fernando@gmail.com,
        sebastian.arnhold@posteo.de, sefoci9222@rerunway.com,
        sst@poczta.fm, to.eivind@gmail.com, torvic9@mailbox.org
Subject: [PATCH v2 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards support
Date:   Mon,  9 Jan 2023 23:15:08 +0200
Message-Id: <20230109211508.4969-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109211508.4969-1-pauk.denis@gmail.com>
References: <20230109211508.4969-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as:
  "EX-B660M-V5 PRO D4",
  "PRIME B650-PLUS",
  "PRIME B650M-A",
  "PRIME B650M-A AX",
  "PRIME B650M-A II",
  "PRIME B650M-A WIFI",
  "PRIME B650M-A WIFI II",
  "PRIME B660M-A D4",
  "PRIME B660M-A WIFI D4",
  "PRIME X670-P",
  "PRIME X670-P WIFI",
  "PRIME X670E-PRO WIFI",
  "Pro B660M-C-D4",
  "ProArt B660-CREATOR D4",
  "ProArt X670E-CREATOR WIFI",
  "ROG CROSSHAIR X670E EXTREME",
  "ROG CROSSHAIR X670E GENE",
  "ROG CROSSHAIR X670E HERO",
  "ROG MAXIMUS XIII EXTREME GLACIAL",
  "ROG MAXIMUS Z690 EXTREME",
  "ROG MAXIMUS Z690 EXTREME GLACIAL",
  "ROG STRIX B650-A GAMING WIFI",
  "ROG STRIX B650E-E GAMING WIFI",
  "ROG STRIX B650E-F GAMING WIFI",
  "ROG STRIX B650E-I GAMING WIFI",
  "ROG STRIX B660-A GAMING WIFI D4",
  "ROG STRIX B660-F GAMING WIFI",
  "ROG STRIX B660-G GAMING WIFI",
  "ROG STRIX B660-I GAMING WIFI",
  "ROG STRIX X670E-A GAMING WIFI",
  "ROG STRIX X670E-E GAMING WIFI",
  "ROG STRIX X670E-F GAMING WIFI",
  "ROG STRIX X670E-I GAMING WIFI",
  "ROG STRIX Z590-A GAMING WIFI II",
  "ROG STRIX Z690-A GAMING WIFI D4",
  "TUF GAMING B650-PLUS",
  "TUF GAMING B650-PLUS WIFI",
  "TUF GAMING B650M-PLUS",
  "TUF GAMING B650M-PLUS WIFI",
  "TUF GAMING B660M-PLUS WIFI",
  "TUF GAMING X670E-PLUS",
  "TUF GAMING X670E-PLUS WIFI",
  "TUF GAMING Z590-PLUS WIFI",
have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the monitoring list with new ACPI device
UID.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>
Tested-by: Jeroen Beerstra <jeroen@beerstra.org>
Tested-by: Slawomir Stepien <sst@poczta.fm>
---
Changes:
v1: no changes

 drivers/hwmon/nct6775-platform.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 1f7885af524e..784a3be38ee8 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -114,6 +114,7 @@ struct nct6775_sio_data {
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
 #define ASUSWMI_DEVICE_HID		"PNP0C14"
 #define ASUSWMI_DEVICE_UID		"ASUSWMI"
+#define ASUSMSI_DEVICE_UID		"AsusMbSwInterface"
 
 static struct acpi_device *asus_acpi_dev;
 
@@ -1102,6 +1103,52 @@ static const char * const asus_wmi_boards[] = {
 	"TUF GAMING Z490-PLUS (WI-FI)",
 };
 
+static const char * const asus_msi_boards[] = {
+	"EX-B660M-V5 PRO D4",
+	"PRIME B650-PLUS",
+	"PRIME B650M-A",
+	"PRIME B650M-A AX",
+	"PRIME B650M-A II",
+	"PRIME B650M-A WIFI",
+	"PRIME B650M-A WIFI II",
+	"PRIME B660M-A D4",
+	"PRIME B660M-A WIFI D4",
+	"PRIME X670-P",
+	"PRIME X670-P WIFI",
+	"PRIME X670E-PRO WIFI",
+	"Pro B660M-C-D4",
+	"ProArt B660-CREATOR D4",
+	"ProArt X670E-CREATOR WIFI",
+	"ROG CROSSHAIR X670E EXTREME",
+	"ROG CROSSHAIR X670E GENE",
+	"ROG CROSSHAIR X670E HERO",
+	"ROG MAXIMUS XIII EXTREME GLACIAL",
+	"ROG MAXIMUS Z690 EXTREME",
+	"ROG MAXIMUS Z690 EXTREME GLACIAL",
+	"ROG STRIX B650-A GAMING WIFI",
+	"ROG STRIX B650E-E GAMING WIFI",
+	"ROG STRIX B650E-F GAMING WIFI",
+	"ROG STRIX B650E-I GAMING WIFI",
+	"ROG STRIX B660-A GAMING WIFI D4",
+	"ROG STRIX B660-F GAMING WIFI",
+	"ROG STRIX B660-G GAMING WIFI",
+	"ROG STRIX B660-I GAMING WIFI",
+	"ROG STRIX X670E-A GAMING WIFI",
+	"ROG STRIX X670E-E GAMING WIFI",
+	"ROG STRIX X670E-F GAMING WIFI",
+	"ROG STRIX X670E-I GAMING WIFI",
+	"ROG STRIX Z590-A GAMING WIFI II",
+	"ROG STRIX Z690-A GAMING WIFI D4",
+	"TUF GAMING B650-PLUS",
+	"TUF GAMING B650-PLUS WIFI",
+	"TUF GAMING B650M-PLUS",
+	"TUF GAMING B650M-PLUS WIFI",
+	"TUF GAMING B660M-PLUS WIFI",
+	"TUF GAMING X670E-PLUS",
+	"TUF GAMING X670E-PLUS WIFI",
+	"TUF GAMING Z590-PLUS WIFI",
+};
+
 struct each_device_arg {
 	struct acpi_device *adev;
 	const char *match;
@@ -1170,6 +1217,11 @@ static int __init sensors_nct6775_platform_init(void)
 				   board_name);
 		if (err >= 0)
 			access = nct6775_determine_access(ASUSWMI_DEVICE_UID);
+
+		err = match_string(asus_msi_boards, ARRAY_SIZE(asus_msi_boards),
+				   board_name);
+		if (err >= 0)
+			access = nct6775_determine_access(ASUSMSI_DEVICE_UID);
 	}
 
 	/*
-- 
2.39.0

