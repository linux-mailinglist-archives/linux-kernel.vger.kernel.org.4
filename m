Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E7607CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJUQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:50:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EB251D7D;
        Fri, 21 Oct 2022 09:50:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l22so8101379edj.5;
        Fri, 21 Oct 2022 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3xihInAFJQTl2KRc26pyAdZJDLSBMJZBLTKuN0TfOY=;
        b=QfiA3SBfzLH/NwONgFFuq5Xl/WKmwFD/h9fyNaAK9tjQz4wcB4DEatJ/sTVQdx0ZMa
         fb1fpTBX/qEp04A0EeUYDnIxxdyNTe3xehPISLW/P05oYNfIo2CnTctZL+k3+le5ch5Q
         ZKlz0QmGWkBLdKxdPAcwMu6Uk64+UGYdUIyPwCz0tAlGiVE+nfu74tVstwFHHJdcpZxD
         zTTZFV2txeqsg3TOs9k7ijQg0pyyMGzgYm45c16rn4nSODqTdq92YPKkoQ3+dJWHBdE6
         8UOECdpJ5hv4wZ6wZg1crIRk7O6yK+S2zM2RDzuTxbUTd5AnWTOLAiRU/5/plvHdnFwP
         GQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3xihInAFJQTl2KRc26pyAdZJDLSBMJZBLTKuN0TfOY=;
        b=A4TRcvQS8kyJI8GUrEfqNVW1yK/cqIndw69C1dxHwxNCamoujVyQ34FkXI4pBXv0n2
         rqzySHtPIYuLVJwWs/tFRs+/rZVccSq1V5QtHaGGawOPFE2wxWplXWCLoh3J0XNJEiWl
         jQLZrJOlg3ag9E8U/dqA8he/e2nv40GlE0YcKgjs6v1/P3hFcIQUdRkDKfF5AAeD63sc
         F1bAes7ETtDrpVYAmEfGGCGiAWTj2JYj46gig6R2xMrhkRvGQhAoH1k3wM++D/ZfMues
         8WnJdBuPWqCASL1RKA2g+O6U2gliRVvd6ZMDeClZYaaH5tSelWt//nD8FA3QM4X2e2+j
         5JHg==
X-Gm-Message-State: ACrzQf2BfdGcb36ko4B+Da/l17zXOSetxQnvOWfBxeQghSnY2DAJuJwS
        5Lszo4plf/SdG0VGybHvy60=
X-Google-Smtp-Source: AMsMyM5xVwrvmZp/PxN0jnSnioT56JAfb3ZsP0d1S0jQUNTmi0mTIOSjXu6KD5nSrwWALbuKCJDV2w==
X-Received: by 2002:a17:906:58c6:b0:78d:b37f:5ce5 with SMTP id e6-20020a17090658c600b0078db37f5ce5mr16456644ejs.707.1666371015957;
        Fri, 21 Oct 2022 09:50:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b0b-4500-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b0b:4500::e63])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7d957000000b0044ef2ac2650sm13725331eds.90.2022.10.21.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:50:15 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/2] hwmon: (jc42) Restore the min/max/critical temperatures on resume
Date:   Fri, 21 Oct 2022 18:50:00 +0200
Message-Id: <20221021165000.1865615-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
References: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
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
index 8d70960d5444..52a60eb0791b 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -565,6 +565,10 @@ static int jc42_suspend(struct device *dev)
 
 	data->config |= JC42_CFG_SHUTDOWN;
 	regmap_write(data->regmap, JC42_REG_CONFIG, data->config);
+
+	regcache_cache_only(data->regmap, true);
+	regcache_mark_dirty(data->regmap);
+
 	return 0;
 }
 
@@ -572,9 +576,13 @@ static int jc42_resume(struct device *dev)
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

