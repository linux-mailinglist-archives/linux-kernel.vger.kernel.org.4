Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8EC5ED2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiI1Bl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiI1BlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:41:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9451BB6C0;
        Tue, 27 Sep 2022 18:41:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 9so11191277pfz.12;
        Tue, 27 Sep 2022 18:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eAwgA8BGMVVMxNp7JTXLjpsmeLFwCAL7NP0XLkLYUBE=;
        b=kNzBXFh17EpTe4Zm/ykApJYQG1VxxzwJhYHGO2Q7jLKFkEmSQNED69jo+lGj6MsB/i
         JWn9VNX8ZgzEfXwbHmxTs1PxHZ7SBp7w/WDc6DjmteAEORlcatEdAqoOK3HvQptCy/fT
         61ZrQxTzq0lHt5lMIPqgGTuecVT+r/BuBw/ifkRLgFDoTy3l4sQ7fpZgIodAS0c8KjNJ
         dCHSIkQFF82Wd/gKighQpP3aBKrC7hymDevYMe/n5HpkBPMYwlqL0QrPsDwsOhTex7TC
         W5E+sNcugFEEZB+50Txc6Y4MBQdhIGJcrVvqzG3rFMBYmMX1i44gzCYHoLByO0LSlr1C
         qosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eAwgA8BGMVVMxNp7JTXLjpsmeLFwCAL7NP0XLkLYUBE=;
        b=GzsgEOczpiQV0i19paP3KH8D56wrYrDPV6JkULmm4mFXV6pVG4qQ8AiV+fAN4+LnKD
         OVGwZ1iWeBxabGGsrcC69vEWaGcoQT8CEUM1mphuXBcD9Jm5Et1x0F5qoBJljrMwJf52
         wLo8yql2Sbh8YLLxriC4Lc4WMa/u0pbYJ2W5a9wn4O+PHAQDybTvPgAr5xhnhTwKKhd+
         R5YxajJw+IaIfiZpFJxYteqWi23zJY19t8o4A0f3go4b8AN9hEq4FmumARWNROK4dGBM
         5BFTBa4B6PqtrRc5O1HLTwe3G6dQICjlQe8h5048g64S1viqhFY/OQ6gCpcyKRXroHGM
         MsFw==
X-Gm-Message-State: ACrzQf3C48qlq94ihJZUuZLJaCVVE1pCOR01E0VHNUc9+ZdVbspUrANQ
        2/i7fBUcHbDwDDwWyz9b3zU=
X-Google-Smtp-Source: AMsMyM6KFgNRR2OZXGm1nYTwzsxxG1ueDqktGrPUjgpkdhgBtOMApvbIh2x6bSImTsuWTbLiAZ/Qqg==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr32313608pfl.61.1664329283732;
        Tue, 27 Sep 2022 18:41:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902c40d00b00176d218889esm2272516plk.228.2022.09.27.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 18:41:23 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     jingoohan1@gmail.com
Cc:     lee@kernel.org, daniel.thompson@linaro.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next v2] backlight: use sysfs_emit() to instead of scnprintf()
Date:   Wed, 28 Sep 2022 01:41:15 +0000
Message-Id: <20220928014115.261470-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Add the rest of this fixes for this pattern in the 'drivers/video/backlight' directory.
 drivers/video/backlight/lm3533_bl.c | 10 +++++-----
 drivers/video/backlight/lp855x_bl.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 1df1b6643c0b..5e2ce9285245 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -66,7 +66,7 @@ static ssize_t show_id(struct device *dev,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", bl->id);
+	return sysfs_emit(buf, "%d\n", bl->id);
 }
 
 static ssize_t show_als_channel(struct device *dev,
@@ -75,7 +75,7 @@ static ssize_t show_als_channel(struct device *dev,
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	unsigned channel = lm3533_bl_get_ctrlbank_id(bl);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
+	return sysfs_emit(buf, "%u\n", channel);
 }
 
 static ssize_t show_als_en(struct device *dev,
@@ -95,7 +95,7 @@ static ssize_t show_als_en(struct device *dev,
 	mask = 1 << (2 * ctrlbank);
 	enable = val & mask;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return sysfs_emit(buf, "%d\n", enable);
 }
 
 static ssize_t store_als_en(struct device *dev,
@@ -147,7 +147,7 @@ static ssize_t show_linear(struct device *dev,
 	else
 		linear = 0;
 
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return sysfs_emit(buf, "%x\n", linear);
 }
 
 static ssize_t store_linear(struct device *dev,
@@ -190,7 +190,7 @@ static ssize_t show_pwm(struct device *dev,
 	if (ret)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t store_pwm(struct device *dev,
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index bd0bdeae23a4..fafc1a9e76ef 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -293,7 +293,7 @@ static ssize_t lp855x_get_chip_id(struct device *dev,
 {
 	struct lp855x *lp = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", lp->chipname);
+	return sysfs_emit(buf, "%s\n", lp->chipname);
 }
 
 static ssize_t lp855x_get_bl_ctl_mode(struct device *dev,
@@ -307,7 +307,7 @@ static ssize_t lp855x_get_bl_ctl_mode(struct device *dev,
 	else if (lp->mode == REGISTER_BASED)
 		strmode = "register based";
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", strmode);
+	return sysfs_emit(buf, "%s\n", strmode);
 }
 
 static DEVICE_ATTR(chip_id, S_IRUGO, lp855x_get_chip_id, NULL);
-- 
2.25.1


