Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE75F8711
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJHTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJHTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:24:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64A1929F;
        Sat,  8 Oct 2022 12:24:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so11615831wrb.13;
        Sat, 08 Oct 2022 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ug3lOc6jfgPHpJPdL4UNADTEvLPCskKFnlfe0HCOmbw=;
        b=nOUzwtYiCzHdMnAmTs+5UaATq86aPTUSRjjgcsSBh3RAI+R+hT40Yta2dNH6UogZw1
         rpO48kqndJN9EeQEtqZi7EIuYO6Us9jwec0lEU4PZS5Jfa0KwbQ5IwplUuIwaSvMSBfi
         XlHWgv8O5LXX2IKvB9Cm8SFA+m4Ytv0ye/mRWbAskJtWPIgVZFuFlqOJGYaeGwR4T183
         9DZ+lbWITQ8uEAgUdvKkJYRKJf9CKs4+PqPvQMLkWgK60CfjzK1G6bstaP53Rx/2aHdY
         WhTV4qPLsAJV61zUZGjuobt13i5P4p8ZKCBJWSLCg5nHbApq+RXB7zU4liE4YrsKVBPv
         4TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3lOc6jfgPHpJPdL4UNADTEvLPCskKFnlfe0HCOmbw=;
        b=wscSAs4OFbTxxZpB+5kWX0KMauBD8ojHShH2sKHWr/tkuhZQgA5E8FNyR1V9nJFSpS
         fUrzqeaa90cMO6icAdn2nTkRFqN8nkMP85V/XR96rGsGsc2egS9Anp5Ao+uaagS5mljQ
         7Bc6pJTpIoRxe+ZOP5XMf+tlj+tI3YQphOthpO+IBFJwm/uwcXnZd3uUZmNzOqF5xdcd
         dUw9fSTWbvgGO+5SyHS6GTlaLKjb6298XHvgGggyheErn8YhRivbDvNKb4tbwrgx1lNr
         W8jMOBHI0VWz9sRZ12Ix8NJ50E4sWn3PgFRQbSzzJl1YV2lTxmMAtwRDuVa4q0amEW8W
         S3Yw==
X-Gm-Message-State: ACrzQf2RJIcgZE5CB9ieuMX14eCu7fsgzpv5Wt16sAt705l1mn3UwHPx
        VeoknguNN6f0o/tIuwxnCA==
X-Google-Smtp-Source: AMsMyM4lCBxgUiaXnVH84Z93igGbHsYZNIcRTkdi2aMyBOcHIEkSGoCs/OWukXWdkKnWpAcR+2IaBg==
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id b12-20020adfd1cc000000b0022e637165admr6946730wrd.326.1665257092268;
        Sat, 08 Oct 2022 12:24:52 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id h17-20020a056000001100b00228d67db06esm5141209wrx.21.2022.10.08.12.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:24:51 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Sat, 8 Oct 2022 20:24:49 +0100
To:     erazor_de@users.sourceforge.net
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] HID: roccat: Convert snprintf() to sysfs_emit()
Message-ID: <Y0HOgd6DFkL8L3Oz@octinomon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf

Following the advice on kernel documentation
https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

For show(device *...) functions we should only use sysfs_emit() or sysfs_emit_at()
especially when formatting the value to be returned to user space.

Convert snprintf() to sysfs_emit()

Signed-off-by: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
---
 drivers/hid/hid-roccat-koneplus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1896c69ea512..1635ddc7c3cf 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -244,7 +244,7 @@ static ssize_t koneplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct koneplus_device *koneplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", koneplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", koneplus->actual_profile);
 }
 
 static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
@@ -311,7 +311,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KONEPLUS_SIZE_INFO);
 	mutex_unlock(&koneplus->koneplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   koneplus_sysfs_show_firmware_version, NULL);
-- 
2.37.3

