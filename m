Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE786662753
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjAINjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjAINir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:38:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C533AB09;
        Mon,  9 Jan 2023 05:36:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v10so11288682edi.8;
        Mon, 09 Jan 2023 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mu9hDSbTzRMUgvFYdQZZOFApJrrdYnBaeGTuNYeU5c=;
        b=Mi/nEJIfVqoxaA2Fvj3l8Z9FQxKpYg0BswYPQdjDG3BvBZQOSOL3XYJzXRgOWRyhPQ
         2bvmaT2KDd+5ldvoWVFcqDb+CvNe5QXIQGNcwseNBK+bw9rk9tI0YNBXQqigq+s9xaz5
         AblefvhwNMOV8DhqC2lqZDiCmpLDn1jsEAF/ZG2N3tnzC3vTjjNc/qGHGdJSNKgmSqdy
         dq63IU2+pSv803Fy1HBYDEZ/I6o9HGYq4ytG/YktgTYiEeQssKetF0j7qpfzLk0GOYgK
         Yl8xfVDoALC6nYAoCZzSTvCb8NJjV4k0dN6EsWCKLRchhnJx+UvyjvQlEh7cm2W6nls5
         S2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mu9hDSbTzRMUgvFYdQZZOFApJrrdYnBaeGTuNYeU5c=;
        b=KDsWmsIGqthPmAOVMZ6VAjrXjjfAb43kFZSEsBG6NembqsGJeVjQ/3BdjdkwFe+BJX
         2naoc1EUHxp/ZO7I2D9dpxgZCKb+wGSAMViv3zgXoROki/W0irt7unvRtwAyDeReoMdi
         hjCiu7a+FYbiL59raio+6HSmJt813ESu/ZOxGnjSPliqAu+bj4UTGoKia0yChvZcVBJY
         ohaXZiRBRKM4t2BL7ea+l0zmaVcz7ZWaFM2AUDN5VtYohyzCxG1HGOaMF1V6EqOaR37t
         w0IdcMqc7X9WR1ijiyvmiN7Dqp8pIpS+21oJbe8h8GxGSz7yTv5qJKgutWSKSk+i8wjx
         6dSw==
X-Gm-Message-State: AFqh2kqXfxCL9aYnSMZL4Nn/eMRLsNs4P3vssBc3xEEKciDPUXMD8mU/
        wj8aeT6PAL6tsSAz+GBI8gI=
X-Google-Smtp-Source: AMrXdXttmCWEOFKEA0hFZ6yOTeNBJe7R16TYp2V5BLxwRYi6zkxpyQPqfZmGz7EpvZU32SNj4bAlcw==
X-Received: by 2002:a05:6402:f05:b0:45c:834b:f28c with SMTP id i5-20020a0564020f0500b0045c834bf28cmr57783370eda.9.1673271392633;
        Mon, 09 Jan 2023 05:36:32 -0800 (PST)
Received: from localhost.localdomain ([46.211.15.47])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm812918ejb.99.2023.01.09.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:36:32 -0800 (PST)
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
Subject: [PATCH 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards support
Date:   Mon,  9 Jan 2023 15:35:36 +0200
Message-Id: <20230109133536.5720-2-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109133536.5720-1-pauk.denis@gmail.com>
References: <20230109133536.5720-1-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

B650/B660/X670 boards use NCT6799D and code is checked with 

https://patchwork.kernel.org/project/linux-hwmon/patch/20221228135744.281752-1-linux@roeck-us.net/  

Feedback form Jeroen Beerstra https://bugzilla.kernel.org/show_bug.cgi?id=204807#c282

nct6799-isa-0290
Adapter: ISA adapter
in0:                        1.37 V  (min =  +0.00 V, max =  +1.74 V)
in1:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                        3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                        3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                        1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                      752.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                        3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                        3.30 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                        1.67 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                     560.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                     560.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                       1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                     496.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                     424.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                      755 RPM  (min =    0 RPM)
fan2:                      819 RPM  (min =    0 RPM)
fan3:                      712 RPM  (min =    0 RPM)
fan4:                        0 RPM  (min =    0 RPM)
fan5:                      674 RPM  (min =    0 RPM)
fan7:                        0 RPM  (min =    0 RPM)
SYSTIN:                    +31.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
CPUTIN:                    +36.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                   +39.5°C    sensor = thermistor
AUXTIN1:                   +19.0°C    sensor = thermistor
AUXTIN2:                   +20.0°C    sensor = thermistor
AUXTIN3:                   +73.0°C    sensor = thermistor
PECI Agent 0 Calibration:  +54.0°C  
PCH_CHIP_CPU_MAX_TEMP:      +0.0°C  
PCH_CHIP_TEMP:              +0.0°C  
PCH_CPU_TEMP:               +0.0°C  
TSI0_TEMP:                 +64.5°C  
intrusion0:               ALARM
intrusion1:               ALARM
beep_enable:              disabled


---
 drivers/hwmon/nct6775-platform.c | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 7f5b430e1e2c..b0c6958809b9 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -114,6 +114,7 @@ struct nct6775_sio_data {
 #define ASUSWMI_UNSUPPORTED_METHOD	0xFFFFFFFE
 #define ASUSWMI_DEVICE_HID		"PNP0C14"
 #define ASUSWMI_DEVICE_UID		"ASUSWMI"
+#define ASUSMSI_DEVICE_UID		"AsusMbSwInterface"
 
 struct acpi_device *asus_acpi_dev;
 
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
 struct each_port_arg {
 	struct acpi_device *adev;
 	const char *match;
@@ -1173,6 +1220,11 @@ static int __init sensors_nct6775_platform_init(void)
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

