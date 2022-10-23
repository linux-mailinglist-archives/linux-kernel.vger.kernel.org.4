Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538D860968D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJWVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJWVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:32:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322F66A69;
        Sun, 23 Oct 2022 14:32:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a67so24768033edf.12;
        Sun, 23 Oct 2022 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbxBj4cHR0O9Tm6ny2CUATl3dmKfE6mD40zGUFRdT3M=;
        b=g0Wv389vZYexEiBB6x0bUbiAzEL6HZEryQ0TfOe5RZI7qvXro8T5rWuOWXhzdhQUlS
         6M2/aKbg0cjF6lmT9+wVytNsuZ21GDzemSsvCAj9raKHIdtOftwkQ4PBQ/MnFmlDLmYm
         uxG06CSENL8gKhT41aoXAlmeO0KfQWJj2OKv/l0xBjkp9oqlhuOpaE+W2lEFpEiiRgn+
         XNPEmdm8PWQXuaV4rTcMtR5zvoXOCmc/5WLZI8COxhnUN2rW4NRqpQovD4WilaYQ/MCm
         1oe/xXIbZUaAJYylvOuk/NFWKgFqQdkKQgSZ3vH2TdFVuYRf2rec0+kwypswu1PXaGRS
         4vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbxBj4cHR0O9Tm6ny2CUATl3dmKfE6mD40zGUFRdT3M=;
        b=pW8eeTANYX9h+q4lfewC3pc97HRXRhaW6sfxx6ywJIPyZpL1wVYlgF4k74K6xPbJOR
         bYkqf/NSpnGuBGh/YKGaXnotsMSV0ZEk2V9wh0Ep/RLcPXFoEwCeo927Pock/2iobGSs
         TZhuaxfRUEavH3Ai9vLnLsai0fdweRNl1+UXPsoCKO2HpEC16YAzYEC5xnCxqx/9RvF9
         3tDvrgbhIDedLyGZ9MAjQaiYmuYgnGrGVO4YDkaYum56efmbYv3xJA+DNYphfB35tl8e
         2B5FKw/cG1l99mToDFrKSToLHoXS+vaekkZSsI0vCWSdaHHrhVrCBfFXKRscpatswYnL
         37tw==
X-Gm-Message-State: ACrzQf2jkN4ANqoHvPQt9kPqUDee/3lVNnOwUHMv49aabUyeMPyIGeDV
        E7/0GPd6Ydsfvqd0yQCQrk4=
X-Google-Smtp-Source: AMsMyM5W9+MO9IuRjniRiUEW49IEKOGggkRPB2VW0P/+OJcd/E05rQHUbRqfQtlb9kud+SlAXTdz2Q==
X-Received: by 2002:a05:6402:2486:b0:460:8f86:1fca with SMTP id q6-20020a056402248600b004608f861fcamr17824549eda.70.1666560745723;
        Sun, 23 Oct 2022 14:32:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c10a-8500-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c10a:8500:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id p22-20020a056402045600b0044e01e2533asm17287454edw.43.2022.10.23.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 14:32:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 2/2] hwmon: (jc42) Restore the min/max/critical temperatures on resume
Date:   Sun, 23 Oct 2022 23:31:57 +0200
Message-Id: <20221023213157.11078-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023213157.11078-1-martin.blumenstingl@googlemail.com>
References: <20221023213157.11078-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The JC42 compatible thermal sensor on Kingston KSM32ES8/16ME DIMMs
(using Micron E-Die) is an ST Microelectronics STTS2004 (manufacturer
0x104a, device 0x2201). It does not keep the previously programmed
minimum, maximum and critical temperatures after system suspend and
resume (which is a shutdown / startup cycle for the JC42 temperature
sensor). This results in an alarm on system resume because the hardware
default for these values is 0°C (so any environment temperature greater
than 0°C will trigger the alarm).

Example before system suspend:
  jc42-i2c-0-1a
  Adapter: SMBus PIIX4 adapter port 0 at 0b00
  temp1:        +34.8°C  (low  =  +0.0°C)
                         (high = +85.0°C, hyst = +85.0°C)
                         (crit = +95.0°C, hyst = +95.0°C)

Example after system resume (without this change):
  jc42-i2c-0-1a
  Adapter: SMBus PIIX4 adapter port 0 at 0b00
  temp1:        +34.8°C  (low  =  +0.0°C)             ALARM (HIGH, CRIT)
                         (high =  +0.0°C, hyst =  +0.0°C)
                         (crit =  +0.0°C, hyst =  +0.0°C)

Apply the cached values from the JC42_REG_TEMP_UPPER,
JC42_REG_TEMP_LOWER, JC42_REG_TEMP_CRITICAL and JC42_REG_SMBUS (where
the SMBUS register is not related to this issue but a side-effect of
using regcache_sync() during system resume with the previously
cached/programmed values. This fixes the alarm due to the hardware
defaults of 0°C because the previously applied limits (set by userspace)
are re-applied on system resume.

Fixes: 175c490c9e7f ("hwmon: (jc42) Add support for STTS2004 and AT30TSE004")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/hwmon/jc42.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 355639d208d0..0554b41c32bc 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -578,6 +578,10 @@ static int jc42_suspend(struct device *dev)
 
 	data->config |= JC42_CFG_SHUTDOWN;
 	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
+
+	regcache_cache_only(data->regmap, true);
+	regcache_mark_dirty(data->regmap);
+
 	return 0;
 }
 
@@ -585,9 +589,13 @@ static int jc42_resume(struct device *dev)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
 
+	regcache_cache_only(data->regmap, false);
+
 	data->config &= ~JC42_CFG_SHUTDOWN;
 	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
-	return 0;
+
+	/* Restore cached register values to hardware */
+	return regcache_sync(data->regmap);
 }
 
 static const struct dev_pm_ops jc42_dev_pm_ops = {
-- 
2.38.1

