Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232805EC1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiI0LrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiI0Lq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:46:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB985598;
        Tue, 27 Sep 2022 04:46:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w10so8824880pll.11;
        Tue, 27 Sep 2022 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WFlHcpmADaeVFRga6QIOkEQFzzQOVOfs68MwYN9b1ls=;
        b=ayIlePrjS+2MeXqtdus1PhO/xN+9nfzcJodPirR6FSf3ped0v42KNuoP+LD1wu5VuU
         cmSptPdX0i6jFBd7AbXvHvvjGlFlZ+6eFnT09c0ftwyXXICUbeD6ZkAEb1ErfULLDdVn
         w9jXrgSWZLWKeF4wJv/kfdNcsVh5LbONBOQ2aA4xhgIC9aLe7x/bYW9hhXspJ98AjSBT
         fAruwKRAwZgPkz99Ga2SMiLPDOnaoBafhw3kY6+H4rQ6xQ88DaAmdBqicHIOQmykBC5k
         fY3f7YoqOyW33akh02XWhvXwdblLY7doCQITnTwq4gbX7FVRqnec3fGraSGIH0uMcfec
         C0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WFlHcpmADaeVFRga6QIOkEQFzzQOVOfs68MwYN9b1ls=;
        b=2clWR4cXWVqTIM7LN8Rlz2TmbzyNeyeYdSan6fITSmlF/96S4Nrd7PLNEZItaTAjTq
         VPKouwA3uNE/QZfAl/+sxgxlGdaFFiRy+DUos3Nzjn0BlfL11mHowki+e1EFH6ywoUgo
         9w1UNHuyM0nfC8cDmmxcNofljuBGLeYw5SohvbsGWqdRKxJzvS3NlcnXEzb1MtU9TUzb
         a/RFZnWr5BI8u/X9aZ3vTND5PhiSJzsKf8x7koJgtA3HvBWFvC9LWSO0EGq6C8Y2QRuE
         VdaS/6RQze2UstcUeYP8Jkylc9NdKDcHm1K/zOAxtvgFs+4KJLBgFFMvuyuv6uWT/XeV
         mnKw==
X-Gm-Message-State: ACrzQf2AXkf+1Wg6d4NvZtkVQxR3MKRQUxdSA5NO/EEUpoo9H/xqcbIl
        JioO7fdv16N6uhj4p/nOjktjKGQGaLhCGmr2
X-Google-Smtp-Source: AMsMyM4Oxs5ivjUFezi/26JG48kfq5bNlW2dDUnE5U23UX8/5f8O/qNsz7nAaMHGTTJZy7lOTu5Nfg==
X-Received: by 2002:a17:90b:4a03:b0:202:8495:627a with SMTP id kk3-20020a17090b4a0300b002028495627amr4223009pjb.186.1664279217854;
        Tue, 27 Sep 2022 04:46:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1534726pfj.119.2022.09.27.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:46:57 -0700 (PDT)
From:   zhangsongyi.cgel@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] leds: leds-lm3533: Convert to use sysfs_emit() APIs
Date:   Tue, 27 Sep 2022 11:46:50 +0000
Message-Id: <20220927114650.259860-1-zhang.songyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/leds/leds-lm3533.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 43d5970d96aa..bcd414eb4724 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -314,7 +314,7 @@ static ssize_t show_id(struct device *dev,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3533_led *led = to_lm3533_led(led_cdev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", led->id);
+	return sysfs_emit(buf, "%d\n", led->id);
 }
 
 /*
@@ -344,7 +344,7 @@ static ssize_t show_risefalltime(struct device *dev,
 	if (ret)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%x\n", val);
+	return sysfs_emit(buf, "%x\n", val);
 }
 
 static ssize_t show_risetime(struct device *dev,
@@ -415,7 +415,7 @@ static ssize_t show_als_channel(struct device *dev,
 
 	channel = (val & LM3533_REG_CTRLBANK_BCONF_ALS_CHANNEL_MASK) + 1;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
+	return sysfs_emit(buf, "%u\n", channel);
 }
 
 static ssize_t store_als_channel(struct device *dev,
@@ -465,7 +465,7 @@ static ssize_t show_als_en(struct device *dev,
 
 	enable = val & LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return sysfs_emit(buf, "%d\n", enable);
 }
 
 static ssize_t store_als_en(struct device *dev,
@@ -518,7 +518,7 @@ static ssize_t show_linear(struct device *dev,
 	else
 		linear = 0;
 
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return sysfs_emit(buf, "%x\n", linear);
 }
 
 static ssize_t store_linear(struct device *dev,
@@ -564,7 +564,7 @@ static ssize_t show_pwm(struct device *dev,
 	if (ret)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t store_pwm(struct device *dev,
-- 
2.25.1


