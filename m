Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83C605220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJSVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:41:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECB3181498;
        Wed, 19 Oct 2022 14:41:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w18so43028029ejq.11;
        Wed, 19 Oct 2022 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8WVbpsQWkZ+HYgVPlUU83g3wBT8qpV9f8aRYDw+xB4=;
        b=cEAJKA5nEfBougL3fXUAt9mX80pl9ItCrTyQf0NNeiA7ezTU4GxFRZhw3G2SvBllro
         Bwh6LwOd9C51XI1+yp2pp0mmMxqPev6FXLM4ZATgURgBT3LnX4Ch4Nhg2Z4j4Jdw9J2E
         rhCM7G8dtYsuo4LyLYthS6h58fWXytnw1Zg6UcnQZSYkq56+grvg3ypRn2K+wMaqpQPv
         y6ZhJs7/RmVQ1VxJsegCpyCWBQSbCFG9IF050uEqfxtTi76OD70aueVwkqBXzwkaplDZ
         yy0EyP93EuAOyjRZEHT1njcmqE6aJktkWlfro0bKb2K9seTlPe/OieJksKObkyxhDdhq
         gO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8WVbpsQWkZ+HYgVPlUU83g3wBT8qpV9f8aRYDw+xB4=;
        b=IanfUWSp2hoVyDb23ppnW8mjmfft3GREeyjlA7CYhM/F/D4vPT3PJYB0w1s6Rs7/e4
         SCu2vgfW2wA0zhbfQIhgvkcjhJzSd3leZ4yTnrp0hVJoqdYcSCrAl06YZdM1JNoMJ4EL
         LOZ8pMQvNS8AkUF79m/3wWzjDILPIW8kBFohR0mzv4deHITsTwalWLO6h+aK7eNK+rMn
         t65/iVMR9a//sTYd/BIuDeFaEVepiNcoMG+NAjWVxeSie3WdLAfHcfsEpW5fTlogTH4S
         k1v9KL8Yy7CqloRPgPKxvAcwC9xdj8BMFU2JJ3l5/UeMDM2YFHEYhE6UUFPQKGMhLus+
         E5Sw==
X-Gm-Message-State: ACrzQf00gZOl/5nb2055jPoesp1ONH1U2hXmfsdoCKrQr2PdBppd4Cq+
        s+R4LHxtrfOX34rul/3tbTQ=
X-Google-Smtp-Source: AMsMyM521Kei8HIdzVZzd3OEThiCKzGL8MBEhWFCpwxvMSm87WT2KiZ2UT2HH2Fsr0/aQsS+t1M7/A==
X-Received: by 2002:a17:906:ee88:b0:78d:1a9a:b2db with SMTP id wt8-20020a170906ee8800b0078d1a9ab2dbmr8237604ejb.225.1666215698897;
        Wed, 19 Oct 2022 14:41:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c17e-7100-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c17e:7100::e63])
        by smtp.googlemail.com with ESMTPSA id g2-20020a1709064e4200b0077016f4c6d4sm9457735ejw.55.2022.10.19.14.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:41:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] hwmon: (jc42) Restore the min/max/critical temperatures on resume
Date:   Wed, 19 Oct 2022 23:41:08 +0200
Message-Id: <20221019214108.220319-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
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

Apply the previously read or previously programmed temperature limits on
system resume. This fixes the alarm due to the hardware defaults of 0°C
because the previously applied limits (from a userspace setting) are
re-applied on system resume.

Fixes: 175c490c9e7f ("hwmon: (jc42) Add support for STTS2004 and AT30TSE004")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This is my first change to jc42. I tried to be defensive with applying
the previous values by only configuring them if they are known valid. I
only have this one set of JC42 compatible sensors but I can adapt the
code here based on your suggestions.


 drivers/hwmon/jc42.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 30888feaf589..f98b28ff10ad 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -558,6 +558,19 @@ static int jc42_resume(struct device *dev)
 	data->config &= ~JC42_CFG_SHUTDOWN;
 	i2c_smbus_write_word_swapped(data->client, JC42_REG_CONFIG,
 				     data->config);
+
+	if (data->valid || data->temp[t_min])
+		i2c_smbus_write_word_swapped(data->client, temp_regs[t_min],
+					     data->temp[t_min]);
+
+	if (data->valid || data->temp[t_max])
+		i2c_smbus_write_word_swapped(data->client, temp_regs[t_max],
+					     data->temp[t_max]);
+
+	if (data->valid || data->temp[t_crit])
+		i2c_smbus_write_word_swapped(data->client, temp_regs[t_crit],
+					     data->temp[t_crit]);
+
 	return 0;
 }
 
-- 
2.38.1

