Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B775F57A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJEPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJEPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:34:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE441A078;
        Wed,  5 Oct 2022 08:34:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so21151740wrr.3;
        Wed, 05 Oct 2022 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OVjZbIf3Mp+GOHIGoOYCGgXAfUIt0XSmtAjlxqfb9Aw=;
        b=Iv+S92b8kXmVh6LQOeBspA+kWuuAOLNCSZMTcLFvdNwC3W9IzYzfguhbxlUdnFg2dc
         znB9B4MRckpRW8U2fi+5KPZOjK/eJCwGmA+ZuadhiatUfMPthuZyimMVJzydQoZgpJhz
         6wBr+tXu95QhUnPwUBMKRnLuC6q3i57hzDnYhzl3FAozpg6ueoIJY9vc8WmIw1bGoyV8
         q/oUjDm5Lw3+wx7K6kW4WVnTZa7iVSOrWEn6KXnNwhtI50xuWRdoJmhvzyDH79xnLPGY
         aCdhZLqeanlDE/SfwR+fY6Y0RiVXc4nuMQnnGaFAqJLHlLHG1Ged/zMknA93dGzXYO1Y
         XeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OVjZbIf3Mp+GOHIGoOYCGgXAfUIt0XSmtAjlxqfb9Aw=;
        b=PWSkmr4Vun8i80TsYvTW78GOlxENTsQ1g2uBxm70dAYUZeuyRbI8VG5tA7ULEc3xzg
         cxYkJ0nWmg1LuBldF0Nw8dJ1BmocPACwIH3oufjYQNIZ7/p8TESgZ4Zozd9MeVQHHU+8
         vOqA3JbCwJoUXmq+Y4kp8TJbjQvCVmgnJsUsG9RXdcG6Z3xlD3CxNGxQUeSHVtTi/NZy
         r14YAWpd0kEAoM2bZZSbr8y4CMgHWn30Oc3LSuDKs9OcCV1gI48mlIuUiFxS5k0riD2L
         whWWON46XQX/9GYtaGNiZob9QggLW7IsmCQtczgazC/5dGbYT0O4C7fEvxmkAMWDYf6Q
         MClQ==
X-Gm-Message-State: ACrzQf0cAsLY1UscsuMmGtxwsptgNnN3j+OgPGl3t78H+URpsl5mWqav
        xETFUwjSPOB+tEAtJ2kfLyMozUJySgxfbaya
X-Google-Smtp-Source: AMsMyM5+cpjtpkWkPVBAo6t/HoKn0NeJkpqnivHRNu1f2aQCJPeb0WQNMbReOUqC9BQxIsqHFEgFDw==
X-Received: by 2002:a05:6000:1acd:b0:22a:a047:2533 with SMTP id i13-20020a0560001acd00b0022aa0472533mr212051wry.69.1664984071276;
        Wed, 05 Oct 2022 08:34:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003c00203fb81sm1094996wmi.7.2022.10.05.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:34:30 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: lenovo: Make array tp10ubkbd_led static const
Date:   Wed,  5 Oct 2022 16:34:30 +0100
Message-Id: <20221005153430.319148-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-onlyAtp10ubkbd_led on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 9dabd6323234..44763c0da444 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -985,7 +985,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 	struct device *dev = led_cdev->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
-	u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
+	static const u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
 	int led_nr = 0;
 	int ret = 0;
 
-- 
2.37.3

