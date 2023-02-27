Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A86A3DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjB0JLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjB0JLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:11:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C84814E86
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:03:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso1913251wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AZKY/GO2HS2MSIrZDLlcV9UWjE1RlhG/yPrdAO/0wQ=;
        b=AifvS/Ca9K6/HsvByrVkTNjR9Gab39OpSeuJiduJDAdioHJ5ahMr2Bo10ZQO2MkOhs
         ud7z/l4f1KbquHrg3F/R1zZiJtZL/1OuBVBf3aUjVO9UOGhOMqOMZBY0Jqsa6uXj/Jjl
         l+mesMd+qKLKM3f69LW0bAaKXbl6m5fRIw08Qmz0wm3DVj6H8zVrB3yPPispIvcRD5mO
         /66AtLW2gXULNgncYsv89UzEGJ5NdCSkJiOCH2UDw/z0QJVuXtnweE21dvP+u4D4ceja
         FYTSbRBtZXCUE1Id+PXcGJidI7ls/8ZkCwsmNjjCyPIAVuH8T1X7Y42b0ASa8uK0Og4H
         K+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AZKY/GO2HS2MSIrZDLlcV9UWjE1RlhG/yPrdAO/0wQ=;
        b=CMVMN4zDNPWpJi9JpcqdRWu5bNKgXVEha2Viah0qMmQEIqtz3jaiTITfGjCD7SmDvJ
         SKachRlknJCM2359+zNllq4F95vdPEZg6k4Q3hUwkOhiOoLQ4SYm/erTQf7d/97UqXYS
         OLXh7JoMUlUzaxaigNj613Wd+1WWlQgfjodG9H1+QDgg5AKQ8rRX/2Q/mzRVh7DmJ7zG
         bYhbCeb8I6F8tYA3+lfkiemekNQNyl+3656E2o2XxeAx/DxlZqf4qdx3MFsVMRMXbJDx
         Py+BIsYHypAUZQaKXOnVUhOYq/PObstZTMdSWT6ezUSXARTQ6Xc0P8vTjUsGVY8xzboq
         NnrQ==
X-Gm-Message-State: AO0yUKXQoanJN0NQnTjMif+zBOAvxq6yoPD/uVy4N/MsLnYWp20NRUSI
        Vs1ClPRhbzIY+rmyqlFAlm+ojw==
X-Google-Smtp-Source: AK7set8XyeDVS9Xol9SEmBKnDMViHVeUkBqcPWhwa3zfIaJ1LciKmH9mu9BoCl8KM666fsCdc2CAuQ==
X-Received: by 2002:a05:600c:ccc:b0:3df:db20:b0ae with SMTP id fk12-20020a05600c0ccc00b003dfdb20b0aemr6064971wmb.17.1677488604522;
        Mon, 27 Feb 2023 01:03:24 -0800 (PST)
Received: from kerfuffle.. ([2a02:168:9619:0:b7be:fc14:9072:c69a])
        by smtp.gmail.com with ESMTPSA id w11-20020adff9cb000000b002c55de1c72bsm6505725wrr.62.2023.02.27.01.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 01:03:24 -0800 (PST)
From:   Erik Ekman <erik@kryo.se>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     pauk.denis@gmail.com, ahmad@khalifa.ws, Erik Ekman <erik@kryo.se>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) ASUS PRIME Z590 boards support
Date:   Mon, 27 Feb 2023 10:03:11 +0100
Message-Id: <20230227090312.91091-1-erik@kryo.se>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on Z590M-PLUS.

dmesg log:
nct6775: Found NCT6798D or compatible chip at 0x2e:0x290

sensors output:
nct6798-isa-0290
Adapter: ISA adapter
in0:                      672.00 mV (min =  +0.00 V, max =  +1.74 V)
in1:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                        3.28 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                        1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                      808.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                      1000.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                        3.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                      528.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                     672.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                     528.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                       1.21 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                     992.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                       1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                      971 RPM  (min =    0 RPM)
fan2:                     1525 RPM  (min =    0 RPM)
fan3:                        0 RPM  (min =    0 RPM)
fan4:                     1094 RPM  (min =    0 RPM)
fan5:                        0 RPM  (min =    0 RPM)
fan6:                        0 RPM  (min =    0 RPM)
fan7:                        0 RPM  (min =    0 RPM)
SYSTIN:                    +36.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
CPUTIN:                    +40.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                   +26.0°C    sensor = thermistor
AUXTIN1:                    +8.0°C    sensor = thermistor
AUXTIN2:                   +22.0°C    sensor = thermistor
AUXTIN3:                   +25.0°C    sensor = thermistor
PECI Agent 0 Calibration:  +40.0°C
PCH_CHIP_CPU_MAX_TEMP:      +0.0°C
PCH_CHIP_TEMP:             +55.0°C
PCH_CPU_TEMP:               +0.0°C
intrusion0:               OK
intrusion1:               ALARM
beep_enable:              disabled

Signed-off-by: Erik Ekman <erik@kryo.se>
---
 drivers/hwmon/nct6775-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 76c6b564d7fc..1a00f4a542fe 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1122,6 +1122,9 @@ static const char * const asus_msi_boards[] = {
 	"PRIME X670-P",
 	"PRIME X670-P WIFI",
 	"PRIME X670E-PRO WIFI",
+	"PRIME Z590-A",
+	"PRIME Z590-P",
+	"PRIME Z590M-PLUS",
 	"Pro B660M-C-D4",
 	"ProArt B660-CREATOR D4",
 	"ProArt X670E-CREATOR WIFI",
-- 
2.39.2

