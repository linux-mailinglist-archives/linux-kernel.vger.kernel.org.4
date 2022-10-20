Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE04606A04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJTVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJTVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC3CABC0;
        Thu, 20 Oct 2022 14:03:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g27so1374018edf.11;
        Thu, 20 Oct 2022 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcGsClt3EeHDOcwNreFbmj7M3tyyEYsggkdvW5UHGGM=;
        b=oLpOq5hMgEz8wPlei0nKhKh1Xpou/ksdbhusfa3NMyvCI+C68vxtrpTI3riwbsjvlY
         Qle2gY108r3XtwAq8ZMxr0pFoh2T0KANSzSE+E46ZQJ9WzE0qznHwSI47NAJ8n4diFjJ
         7Mbn61S6+dLcsKHBhLkyWAPq6kjruhblVmQqXCueZsTBp1WU1dLT8n07EyyLejdsz78v
         CIznAV8C0b5gW3xtPT/fduziMZK6MxewF+sHN4jTqPbhARuwsiuO0wnE9YgoU+zhDLke
         4Xxm6RFVoddWhPQiRdmsxGTBq7zek+LIl7kCWuEixLji89BK1eZJGgYe849e+t2F9Sz4
         78IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcGsClt3EeHDOcwNreFbmj7M3tyyEYsggkdvW5UHGGM=;
        b=vZzY93TsHc302d2Rgl/GU2pJnNNjmrYpcqboBKatEi9q+i/bVKkTwfnFNxN1+aOQ5I
         fuTB7xAsA9mvKwA2G07zNz1kc3vy9EGxZrTXfiHMpZcmaFc0OtJx2833cWDvZFubl2rG
         xzvdJhtgKpotUZmwHgab+z6r90H9c4THs91Mmyip/aIbuztVNcI+XGWNBg7YO/tWd/03
         kYKLmDikmvvF0HsT5Wf4y3pVyhbZ1i5c/tRikLy+8XYVO6MIIm3+fjsHWJiWX4GJNrS9
         ++QUSkTqlJUatzRCg6FKGm4xKCC3COkuitB1stt1nJBMWx9ke9S+tsZFHiwxf4hXObKZ
         5DCA==
X-Gm-Message-State: ACrzQf1r/s4xDS9cJcnPnxQXQOiSD6Rcc8TRwfTqs5HBQW50TM4jPcjj
        ssQcyWsMtWTARQaLl+wKbxY=
X-Google-Smtp-Source: AMsMyM53hf5WFVTFQ/0Etgg2GbkKIWsfEPAwVjQ8peO0OvmUyC9OYc9QlAIQHgybBr3PzknZ6m7aZw==
X-Received: by 2002:a05:6402:26d2:b0:45d:280b:5878 with SMTP id x18-20020a05640226d200b0045d280b5878mr14204625edd.385.1666299824877;
        Thu, 20 Oct 2022 14:03:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c046-3500-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c046:3500::e63])
        by smtp.googlemail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm10748721ejt.62.2022.10.20.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:03:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 3/4] hwmon: (jc42) Restore the min/max/critical temperatures on resume
Date:   Thu, 20 Oct 2022 23:03:19 +0200
Message-Id: <20221020210320.1624617-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/hwmon/jc42.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 3f524ab5451c..61311483a5c6 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -582,6 +582,10 @@ static int jc42_suspend(struct device *dev)
 
 	data->config |= JC42_CFG_SHUTDOWN;
 	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
+
+	regcache_cache_only(data->regmap, true);
+	regcache_mark_dirty(data->regmap);
+
 	return 0;
 }
 
@@ -589,9 +593,13 @@ static int jc42_resume(struct device *dev)
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

