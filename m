Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128B766658D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjAKVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjAKVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:23:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DB3F12F;
        Wed, 11 Jan 2023 13:23:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i9so24295093edj.4;
        Wed, 11 Jan 2023 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aauxthsqpHaoa/2D2bGaXqvcV3u8Km9yd6EUTM6Cz64=;
        b=B0pxx2kq/jRxxCSzYcGo4a2s2oknrtp2PsYHbB00BoY94D1SXP4+/l61vr7EnzTFUa
         CH5LBNA2TfsCTfydNKlz6nzbHobtqpK2jPxOvMKCmEC8Y7o4DA/s2K0GPbjcWQEIBQ8D
         UA1h9PJYyb1k6ax8wPETEgNeKxluXuB2nSuo7V5dQTEqWvgF7yIHqN0cthSdRcWroDbh
         nlI22WO5Pz0ATQUy8qbL5Jma27a9J8sJOJ1CEZEdV73yle2ncf1LdApgnfpaCNdj+7od
         IsfaJxuIzrPzuThQcGWHSn0B2uOmHi3oyzEf3VfDwIiFYKTdmNVwaVgJZNrlI7uQaThp
         L+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aauxthsqpHaoa/2D2bGaXqvcV3u8Km9yd6EUTM6Cz64=;
        b=7+h4MEVgHK2+LUiyxPLSMxvhWgKnbJSg8xMgymTW6xIk8NPJd06YWAaiMxhxNiDp60
         GZBIYuFz/eiD6K5tSJxzD8UbUFxScxMuZyLIc8JOv7X0X/2nini5LhLRUYeVC/jT+rAH
         lbsVPUY9v0UBpXfuzumIz+GgTZr5An9pQk15W+ER1oQQU5rYk2T0oaXzS38UcnqcgqKw
         Ne4OzFwaBT7U16N6+Cad/TYBtkrEX0xT7C4upAziPqbkL4OBYRN94+aVt49o5qzHR5CC
         p3wDSh44/tycOp89/U6CWznXYIH8FrKgzC1uvM419cfGM3XbbPkOuuaafmHRX7ag95cs
         7g/Q==
X-Gm-Message-State: AFqh2koQ3Xl47iEPijdhA1aKNEbwnFoTe+3ofKZ+66gnLn3ishwEXQf/
        jO8/Geb2oYTUP68yCb7/OZI=
X-Google-Smtp-Source: AMrXdXuGxfYjY8Su9Gu034o8h1dI0UaDFB5e3m7ItCLi/4naqrIEz11VUHrNXRRJJ1/N+v0i2iq0iw==
X-Received: by 2002:a05:6402:5505:b0:499:c332:3b50 with SMTP id fi5-20020a056402550500b00499c3323b50mr7446347edb.39.1673472192766;
        Wed, 11 Jan 2023 13:23:12 -0800 (PST)
Received: from localhost.localdomain ([46.211.95.50])
        by smtp.googlemail.com with ESMTPSA id s1-20020aa7cb01000000b00463b9d47e1fsm6477588edt.71.2023.01.11.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:23:12 -0800 (PST)
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
        sebastian.arnhold@posteo.de, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
Subject: [PATCH v4 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards support
Date:   Wed, 11 Jan 2023 23:22:41 +0200
Message-Id: <20230111212241.7456-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111212241.7456-1-pauk.denis@gmail.com>
References: <20230111212241.7456-1-pauk.denis@gmail.com>
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
have got a NCT6799D chip, but by default there's no use of it
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
v2: no changes
v3: no changes
v4: no changes

 drivers/hwmon/nct6775-platform.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index e3c3b35c8138..baac0d569a4d 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -114,6 +114,7 @@ struct nct6775_sio_data {
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
 #define ASUSWMI_DEVICE_HID		"PNP0C14"
 #define ASUSWMI_DEVICE_UID		"ASUSWMI"
+#define ASUSMSI_DEVICE_UID		"AsusMbSwInterface"
 
 #if IS_ENABLED(CONFIG_ACPI)
 /*
@@ -1108,6 +1109,52 @@ static const char * const asus_wmi_boards[] = {
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
 #if IS_ENABLED(CONFIG_ACPI)
 /*
  * Callback for acpi_bus_for_each_dev() to find the right device
@@ -1172,6 +1219,11 @@ static int __init sensors_nct6775_platform_init(void)
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

