Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10D5EBB26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiI0HJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiI0HJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:09:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013415720D;
        Tue, 27 Sep 2022 00:09:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v1so8283409plo.9;
        Tue, 27 Sep 2022 00:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=q4/UCAdrgH5/GRrTWwXDpUGYGeL5LkfX+ixNfTJb3Lg=;
        b=qC+QP3RPbFkZzcLbuapJk0gP4hBzcd47bB69ZQXPN7qNC8TaR92z+cT6p/RiFhJA0m
         eQACuVf9Kj1XYyLdyKSEOHcBV6Nd4evipSuYSlMT1u7WZCqaCT5EF+K7QLoO+RS6VPDH
         yCI8vUIQI3xYa6QQkGdWRxKBPKAj36/1ukrzMFyyywYsfElc5VAp4LECuuNRCMYehW0j
         XrYdNbsGOOWtiPH15Hi5ILuSaClm4y8GllnBh2LxBCaS7ffbWom67YW7bDka05Vv7xik
         q/NcSuXta7wlXvNsNFLQ8BoHW7tp346/Zf7ZpX/seopmrqL6pD0Au06XgRWi7sVBE+Rs
         Z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=q4/UCAdrgH5/GRrTWwXDpUGYGeL5LkfX+ixNfTJb3Lg=;
        b=n1hwBlhAR0xdg4IkwpQbNKi0wg9mUlTHq8BNCFzlD2+ROX5FME3DKIodVr+vmIIomt
         Wzo9P/aVbzVM6UiLr0UzhZ49fRIzbTuf3/eKzIGD/fjzUnxPd3mjvuFJbkAXKGjFcZL8
         XN/S4BgBTQ0Y0VEVbPN5kXP9bUWftIbQz/5dTwQta3iekTbsJwbGkpSNyhewYWHFzFsQ
         htwo3NucwGNWR6gbDYxEkRux7eWM05bkLzrAah2cHDqs1yHEjROqS3S0dW5+tQU7ugW+
         zh00ozq2II9idwUyg2l+YEWbC3jeg3AWmwJxF/ZiZcHW4xzC/+UKC8v308SFYCtfNxdL
         GJRA==
X-Gm-Message-State: ACrzQf0PKc1DOZetAQks8YxloKmlzoPcnMT9qbSc3IskTjAR3sGWrSm8
        cTxdpr14QNGHQ0UBiq8QHtxa2BUQDDSX3HvxpPI=
X-Google-Smtp-Source: AMsMyM7SUlyyqHrx8cD7Fo5L27ptsyCu9syK4mNvecV0u3XZxbPawvEy0jMTHKgxEiegttlfDQf3fQ==
X-Received: by 2002:a17:902:ea11:b0:178:f0a:7472 with SMTP id s17-20020a170902ea1100b001780f0a7472mr25592484plg.46.1664262583225;
        Tue, 27 Sep 2022 00:09:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j5-20020a62c505000000b005499599ed30sm820554pfg.10.2022.09.27.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:09:43 -0700 (PDT)
From:   zhangsongyi.cgel@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     zhang.songyi@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] Input: synaptics-rmi4 - Convert to use sysfs_emit() APIs
Date:   Tue, 27 Sep 2022 07:09:36 +0000
Message-Id: <20220927070936.258300-1-zhang.songyi@zte.com.cn>
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
 drivers/input/rmi4/rmi_f34.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index e5dca9868f87..e6e7dde76c5b 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -321,11 +321,11 @@ static ssize_t rmi_driver_bootloader_id_show(struct device *dev,
 		f34 = dev_get_drvdata(&fn->dev);
 
 		if (f34->bl_version == 5)
-			return scnprintf(buf, PAGE_SIZE, "%c%c\n",
+			return sysfs_emit(buf, "%c%c\n",
 					 f34->bootloader_id[0],
 					 f34->bootloader_id[1]);
 		else
-			return scnprintf(buf, PAGE_SIZE, "V%d.%d\n",
+			return sysfs_emit(buf, "V%d.%d\n",
 					 f34->bootloader_id[1],
 					 f34->bootloader_id[0]);
 	}
@@ -346,7 +346,7 @@ static ssize_t rmi_driver_configuration_id_show(struct device *dev,
 	if (fn) {
 		f34 = dev_get_drvdata(&fn->dev);
 
-		return scnprintf(buf, PAGE_SIZE, "%s\n", f34->configuration_id);
+		return sysfs_emit(buf, "%s\n", f34->configuration_id);
 	}
 
 	return 0;
@@ -499,7 +499,7 @@ static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
 	if (data->f34_container)
 		update_status = rmi_f34_status(data->f34_container);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", update_status);
+	return sysfs_emit(buf, "%d\n", update_status);
 }
 
 static DEVICE_ATTR(update_fw_status, 0444,
-- 
2.25.1


