Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3745BE7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiITN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiITNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:55:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2803686F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:54:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z2so3985593edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DLUl+3DSxpghb+4XVDEdCI4TXeLI6nIF01m7+R/dTes=;
        b=I03TMuUOg4ZdeMC99+46z4AfULcPnl4IXNk6St0H/OKqsWPQvEg0sNSTPnFK6EVnGW
         WGq/s2WMelHwnhwaPR+Ua9DCI+Qq+MM7r3lbbA+55ln63ju/jgAKkISyQHxnr7EQaBjm
         528ryRJ+b7y9tYmOGNbKgXB9xC71hNBVCiRyWb9BXk2DOnIy0dmNuUuskKLpxp2BdZe0
         W8giLV38QuUgRcofNnkpf42Dw8r/AIIECpxoOoNgrRNK7u0ozVbITGYe2sgY+/2VUP5E
         HyPfezqZlwFh9nnsPL594U+aEwHaQ6xz38/mxiVbdvummsNAni2pfuoNkc2GIK12gEK6
         5F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DLUl+3DSxpghb+4XVDEdCI4TXeLI6nIF01m7+R/dTes=;
        b=GC8oBszxLCX/cv7FtIbT7nNIFsS51QCT2xe39Uqc73l4pV56ANSTQrZZ52ARDsOX6E
         DsKGIkHFvYipTkgp0L8rGKAzVxlExxhCXAwbygNJHHktLZ7RmVliicKRTbP8FrF+vzRj
         R5w3fLntr5dRr1Q0T1s2WxAU2AidSbEyalFRTvjzUV5RIcrMqu/TXMELj2zJHqhwwkMN
         IBWI/dM7KIj2Jc8e1405rmDFepHUyaT7rBxsh8CG51znq3OslkfCu0WvWfXhnq8PxmLV
         53+VfPTMhU9y750Z6/Sz0ayxAFxoD5OogLxRjVxN3WsVeLbjG6oQ4X1nkouOPRBGDzFG
         DSlg==
X-Gm-Message-State: ACrzQf3S2wXoq3JVK1zlkYewr36bqYur5YnYOPV3FQARIuy18r7qGBLo
        6p4ewrDFr126ntD+ZllpWPLINA==
X-Google-Smtp-Source: AMsMyM7CtiJE1Ez0ADzDOiMGkV/6ZNzyWNnYrCEosRVgLIdloLixcmJXoaOoWiAFgtSzL9yBSbudLA==
X-Received: by 2002:a05:6402:1f0e:b0:453:a419:b3a0 with SMTP id b14-20020a0564021f0e00b00453a419b3a0mr14412561edb.124.1663682077666;
        Tue, 20 Sep 2022 06:54:37 -0700 (PDT)
Received: from brgl-uxlite.. ([77.241.232.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b0044f21c69608sm100503eda.10.2022.09.20.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:54:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpiolib: cdev: add fdinfo output for line request file descriptors
Date:   Tue, 20 Sep 2022 15:54:35 +0200
Message-Id: <20220920135435.15593-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fdinfo output for file descriptors created for user-space line
requests in GPIO uAPI v2. The fdinfo file now contains the name of the
GPIO device that is the "parent" of the request as well as offsets of
the lines requested. This allows user-space to parse the /proc/$PID/fdinfo
entries and deduct the PID of the process that requested a specific line.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib-cdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f8041d4898d1..0f7b5562c410 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1497,6 +1497,21 @@ static int linereq_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
+static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
+{
+	struct linereq *lr = file->private_data;
+	struct device *dev = &lr->gdev->dev;
+	u16 i;
+
+	seq_printf(out, "gpio-device:\t%s\n", dev_name(dev));
+
+	for (i = 0; i < lr->num_lines; i++)
+		seq_printf(out, "gpio-line:\t%d\n",
+			   gpio_chip_hwgpio(lr->lines[i].desc));
+}
+#endif
+
 static const struct file_operations line_fileops = {
 	.release = linereq_release,
 	.read = linereq_read,
@@ -1507,6 +1522,9 @@ static const struct file_operations line_fileops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = linereq_ioctl_compat,
 #endif
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = linereq_show_fdinfo,
+#endif
 };
 
 static int linereq_create(struct gpio_device *gdev, void __user *ip)
-- 
2.34.1

