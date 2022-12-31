Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227BA65A28E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 04:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiLaD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 22:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiLaD2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 22:28:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D3167CC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 19:28:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d15so23664508pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTh4/VPoY0Y+tcQiq17QyW1yR5LQfa4ihly8Ebe6C0g=;
        b=DR6VSTHgseHJY8A6zGjLo2veIL1kfyYqgdS5tlocHEV/PzzNhR7FqnfTCKRWTFgKa6
         qVCWMC7V3rwMOiNZ+OXLcdgvlIjsvdV9vwU0N69eTLM+zx74M//mxcj8ifLrI6C6f8O8
         hFCL4zejYMVxZKpJst3fPpOLiL01tqgby304mbxkDYsIJV5Nj0o/BzGFI/rrXn9uP+sz
         Z0OnRkdGqL95Wfw0/fMoRIJru9jgPI6i8yL3zDVTPB5Pc8eMB+IHEEDj4EYcpp+1AhPl
         4p64Og2Pii2tzTgcnUYWa4ahlejK3t3VAooafOPRuoDbYX3IqcnkL0rxabSmeUVMKeJv
         7COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTh4/VPoY0Y+tcQiq17QyW1yR5LQfa4ihly8Ebe6C0g=;
        b=wAFPVAUFsGdMhpqOBnVHCjlUnY6lNaeCr7zagUvlSREccEC5GqVUmL01O7VwmDJ68J
         /nVPqyitrsx54aFvlSlhAAvenw4hwtgHO+ELzafQzOaf4vdYBqfp3JSQnmvOl35pjPXM
         fN3q8awuey7tLfhNBlQ19hIhKsp2q/lhP05YntY8XYzMAA4qf+Exb7zkU/LRi6U7826V
         1mh3LM5p7en25/7J176eD/gQx7mu6jifXN0AQheVk1HD2F/aWsHNy7nhQQZPwzvietpV
         J0BtjC55yebOkmQKD5esc0JVpwqaOMFV18966iwsKj66TRVydmmwusoqLgq+sFijxzRw
         0d/w==
X-Gm-Message-State: AFqh2koe16FNS9kjyigbZPxyIbNrB7HJ9oG0QalajuMnJLseztREY84S
        D5LcVhfbAzV1j5AE1PNU/8I=
X-Google-Smtp-Source: AMrXdXvBlrh8HET1Kivz9ZfOXEsbkdmp8jvFw5uJDJ2AETLeDF+MaHJxjFoPhthrhmXIQxB5y1iQyA==
X-Received: by 2002:a17:903:3111:b0:192:5c3e:894e with SMTP id w17-20020a170903311100b001925c3e894emr24359844plc.16.1672457311084;
        Fri, 30 Dec 2022 19:28:31 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b0016f196209c9sm15627207plg.123.2022.12.30.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 19:28:30 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] char: xilinx_hwicap: xilinx_hwicap: Fix use-after-free in hwicap_open
Date:   Sat, 31 Dec 2022 12:28:26 +0900
Message-Id: <20221231032826.2034288-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
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

A race condition may occur if the user physically removes the
xilinx_hwicap device while calling open().

This is a race condition between hwicap_open() function and
the hwicap_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to hwicap_remove() to free the
"hwicap_drvdata" structure after the device is closed.

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 27 +++++++++++++++-------
 drivers/char/xilinx_hwicap/xilinx_hwicap.h |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 74a4928aea1d..d93abd99bd37 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -553,6 +553,7 @@ static int hwicap_open(struct inode *inode, struct file *file)
 	drvdata->write_buffer_in_use = 0;
 	drvdata->read_buffer_in_use = 0;
 	drvdata->is_open = 1;
+	kref_get(&drvdata->refcnt);
 
  error:
 	mutex_unlock(&drvdata->sem);
@@ -583,6 +584,7 @@ static int hwicap_release(struct inode *inode, struct file *file)
 	status = hwicap_command_desync(drvdata);
 	if (status)
 		goto error;
+	kref_put(&drvdata->refcnt, hwicap_delete);
 
  error:
 	drvdata->is_open = 0;
@@ -672,6 +674,7 @@ static int hwicap_setup(struct device *dev, int id,
 	drvdata->config_regs = config_regs;
 
 	mutex_init(&drvdata->sem);
+	kref_init(&drvdata->refcnt);
 	drvdata->is_open = 0;
 
 	dev_info(dev, "ioremap %llx to %p with size %llx\n",
@@ -730,15 +733,8 @@ static int hwicap_remove(struct device *dev)
 	if (!drvdata)
 		return 0;
 
-	device_destroy(icap_class, drvdata->devt);
-	cdev_del(&drvdata->cdev);
-	iounmap(drvdata->base_address);
-	release_mem_region(drvdata->mem_start, drvdata->mem_size);
-	kfree(drvdata);
+	kref_put(&drvdata->refcnt, hwicap_delete);
 
-	mutex_lock(&icap_sem);
-	probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] = 0;
-	mutex_unlock(&icap_sem);
 	return 0;		/* success */
 }
 
@@ -830,6 +826,21 @@ static int hwicap_drv_remove(struct platform_device *pdev)
 	return hwicap_remove(&pdev->dev);
 }
 
+static void hwicap_delete(struct kref *kref)
+{
+	struct hwicap_drvdata *drvdata = container_of(kref, struct hwicap_drvdata, refcnt);
+
+	device_destroy(icap_class, drvdata->devt);
+	cdev_del(&drvdata->cdev);
+	iounmap(drvdata->base_address);
+	release_mem_region(drvdata->mem_start, drvdata->mem_size);
+	kfree(drvdata);
+
+	mutex_lock(&icap_sem);
+	probed_devices[MINOR(dev->devt)-XHWICAP_MINOR] = 0;
+	mutex_unlock(&icap_sem);
+}
+
 #ifdef CONFIG_OF
 /* Match table for device tree binding */
 static const struct of_device_id hwicap_of_match[] = {
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
index 6b963d1c8ba3..9ea3a98ea600 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.h
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
@@ -58,6 +58,7 @@ struct hwicap_drvdata {
 	void *private_data;
 	bool is_open;
 	struct mutex sem;
+	struct kref refcnt;
 };
 
 struct hwicap_driver_config {
-- 
2.39.0

