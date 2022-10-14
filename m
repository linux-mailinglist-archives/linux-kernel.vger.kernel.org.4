Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC85FECDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJNLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJNLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:06:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC5328E28;
        Fri, 14 Oct 2022 04:06:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so4415156plc.7;
        Fri, 14 Oct 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYOgGB3OBp7ooAPIp1xdI0GhJIuSMbuwgDPRPDT+2C8=;
        b=HzDmIZbvI+d5dTFWwb7fgn2izvFe1MotC1FrIv7PeIguF+ByOhkbb71y5N3y/w3VxV
         GrPil13ZA2katsSk3gzeUjOvoHP4kluAtTdyyfNr2vWD5tsJdJ2WOMzpPYzOmZ6iNco7
         JuVFYBwBPWj0qr7oBNh8AW4SsMOVobnKNshUK1dX/8N5DMEjMBCz0eBoYjYX0qo24qk4
         JkjuaIK1eQd20mn9I3teaLx81iKlY3IKNwIf6v7Q00x6Y/bZBGTwTfZgkkjrvj/G40mB
         2z6/GESdDK0+4QOiRYsjwKi6eCeAlnJt7gOyTD3rgokuBiK6DqGeZKSm0iKOPyE7XhRR
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYOgGB3OBp7ooAPIp1xdI0GhJIuSMbuwgDPRPDT+2C8=;
        b=c4lrE7sEsVm4e9t/xPRpLvlofnC7xOOMqtVyRHnsg/wj8T+W8L1EZZ78QkCBBch+dl
         2HxGBPWq5GeoG1B4Nl3ef9zcrIXiNxEiMHMUTGHYNd4e28VRyw9waY+kaKQOFLiOuWH0
         IWVpiyxKVjxiER/Wgqe8AB5Bu0/dFoefentf9NjTVwThrobQpAcRRRkQhkCYci4z2xEr
         QeDdxCF0Kb+NrL8wDfyAbBJVgtGcRA41JBM3z0O220in9m6+Te6tRyUHalJgGGMO/TG7
         eMz8BCdQ9YFb6F/Fcqae7NBlxo4N1F4pa1CkLA+IRgyol/3ubmx6pYWYZUnGy+6gJia6
         pJkA==
X-Gm-Message-State: ACrzQf1IW4YfDtJIJD70IrgxzeR3sgB+R9r9+Xh8QTnPAw4cHZ6S/eSQ
        ebYDO1f+JNV1V161g0HQKec=
X-Google-Smtp-Source: AMsMyM6hlPylFoFCCwcGs4q2i34CyApbuQnVHSxt0EBgDYwLerKDS3rWU+RBc8ckutZzfk4j4by3eA==
X-Received: by 2002:a17:902:8a88:b0:17f:8642:7c9a with SMTP id p8-20020a1709028a8800b0017f86427c9amr4675382plo.13.1665745571377;
        Fri, 14 Oct 2022 04:06:11 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0017300ec80b0sm1416564plk.308.2022.10.14.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:06:11 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] usbip: convert sysfs snprintf to sysfs_emit
Date:   Fri, 14 Oct 2022 19:06:06 +0800
Message-Id: <20221014110606.599352-1-zhangxuezhi3@gmail.com>
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

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/usb/usbip/stub_dev.c   | 2 +-
 drivers/usb/usbip/vudc_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 3c6d452e3bf4..f92047d860f0 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -30,7 +30,7 @@ static ssize_t usbip_status_show(struct device *dev,
 	status = sdev->ud.status;
 	spin_unlock_irq(&sdev->ud.lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buf, "%d\n", status);
 }
 static DEVICE_ATTR_RO(usbip_status);
 
diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index c95e6b2bfd32..907a43a00896 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -242,7 +242,7 @@ static ssize_t usbip_status_show(struct device *dev,
 	status = udc->ud.status;
 	spin_unlock_irq(&udc->ud.lock);
 
-	return snprintf(out, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(out, "%d\n", status);
 }
 static DEVICE_ATTR_RO(usbip_status);
 
-- 
2.25.1

