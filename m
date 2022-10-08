Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FDD5F870B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJHTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJHTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:15:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501C3D586;
        Sat,  8 Oct 2022 12:15:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w18so11643185wro.7;
        Sat, 08 Oct 2022 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8CtB6fqznYD0X3GM2ZD+I8J1/eW4GPOSbOmwiNyM2k=;
        b=lZTAkxRffPM5QjfDjXQM+C1+UP0fUwK4X+y/BpBEzPfew0S1p4cOJfRXOJ6ItKbkHS
         w8xapv1rNRHLNq1sLGT4iJ6dy7Lx61Qvh07sZPpcT5Yr8VUxywjobf2h1I529EJ0yAfJ
         yNnAb92epVMtpUwY0QLbDohsg+6/Etr3bDYizpjXqtNyla/aI6tKrlG1IZ0iw231fVjT
         F2FlF8BXYvFZT4aSknkR8QQAGV9OodB7yymuAPSsjSm7cHediB+w6z8qPSAicAEUIypl
         Mn2yDJovv3yw7y+Dq7g5l+AC9avcrT2TuO9u0MKEZR3hqQ0accfntwcyAhkO2EQu14pS
         BZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8CtB6fqznYD0X3GM2ZD+I8J1/eW4GPOSbOmwiNyM2k=;
        b=YfrXVAzNYSVhY/EI6+mxbCl9b45Z4hqaZVNXGhm/WJ152lVZdLlHdkd9E8m2dX66Rg
         lKPRE0b4Dni1plczDu1VYM3Xw9gl95ZEnQtjmYCHxRbBv/QiYF5LPOp12AU09TWePS7j
         3ykEej+O0RUUdLVw7SwLS1RqY3dMf9R8wcolLwzeCD4KSqdoj7gXcahW8cXllUlMeC7G
         C+kmFdcV21xj4cmq5Bx+wAgYbn8aVhmwvSXt++Z1wZTMdKuXgCGCltjgjjKxtj+A/Sl3
         ps+A859fAIU08ert52S9H1h9F0ZU4dLcZU4cLMPF73ewCIUaneWPunKTNqiPI4/cRdmE
         DUDg==
X-Gm-Message-State: ACrzQf2WQxagXPjr8w3w/b4bGhK0WqNNUcbVkLUpVHdyIZGV+nUYfEiC
        OrVcBRdjkp4T71AwjDUF6A==
X-Google-Smtp-Source: AMsMyM4Lhzoa5C90JWM+3UAe9iWhpBc2Jd4hYV15FZMv+wOPd9nZ4VS5ZHSI0qymsgRvOs7J2W0lPw==
X-Received: by 2002:a05:6000:184e:b0:22e:4649:b3c9 with SMTP id c14-20020a056000184e00b0022e4649b3c9mr7312119wri.671.1665256543399;
        Sat, 08 Oct 2022 12:15:43 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id f62-20020a1c3841000000b003b31fc77407sm12514143wma.30.2022.10.08.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:15:42 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Sat, 8 Oct 2022 20:15:41 +0100
To:     erazor_de@users.sourceforge.net
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] HID: roccat: Convert snprintf() to sysfs_emit()
Message-ID: <Y0HMXeYw8bwRSubz@octinomon>
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
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 6fb9b9563769..7f6238a19739 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -274,7 +274,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
 }
 
 static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
 }
 static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
 
@@ -336,7 +336,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_x, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
@@ -346,7 +346,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
 {
 	struct kovaplus_device *kovaplus =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
+	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
 }
 static DEVICE_ATTR(actual_sensitivity_y, 0440,
 		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
@@ -367,7 +367,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
 			&info, KOVAPLUS_SIZE_INFO);
 	mutex_unlock(&kovaplus->kovaplus_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
+	return sysfs_emit(buf, "%d\n", info.firmware_version);
 }
 static DEVICE_ATTR(firmware_version, 0440,
 		   kovaplus_sysfs_show_firmware_version, NULL);
-- 
2.37.3

