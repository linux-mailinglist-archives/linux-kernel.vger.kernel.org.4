Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525B61166B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ1Pzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:55:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614B7695F;
        Fri, 28 Oct 2022 08:55:29 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13be3ef361dso6701999fac.12;
        Fri, 28 Oct 2022 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Szxxr+qfaXpGQuF2CmkZ3hvRQy5GRhL2g4OW24nDsmQ=;
        b=o+yDDs/H92eNLAMm/fHQS6lY9Ha+3H9XZqJ1VEUj5BnuxtdjcoPc1f2t7fy+3Ya7xK
         3MI6LBvqaQV19s3f6bt3s8cGHRxpgR2oYQZlfoeu2lKQsJeolcevfwvplyEfJ8GnRKry
         0W0LzmfaGKv8Sh6OYj6gCqSN2rBMCrmpqpeAfI0cVwYd1LVW9yZKoeLwT/QfFDwM8syZ
         L6IabJtpV6oKD8zu8ARHqdAAQbNNkrcEZ4Uf7KVotKHfQ4I6E6avWBF7Gkvp4gWpYy+E
         HdqDRWK8PEFV6VaTvU8RenG1PQfbZDWP+/8Hsnl57F8yj2mfaDpPvNz5R1dW8yZJi0JK
         Jecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szxxr+qfaXpGQuF2CmkZ3hvRQy5GRhL2g4OW24nDsmQ=;
        b=sS1zucPfq5YnaWlLwXCxfxWET7ov02eOsnIz7zYfZ92n1VmCmCmH2G1/CGnLcLv/rV
         prD9plabBr44LiS2aTosFvWz94xDdudAGl7eaErHtXF/stG/yf9nZ27w+V3+ohY8faV1
         ZCtHAbAxHYZHr9VD3MQov/NDAzuTFYdyzmel6LAgplKxOAhGJ35sIC7p9aJI7aQ++vmq
         iuTq1bGRb1G1nV0nYcdHB4KCXGl8Kq4dhniNuUT1gqDMX9JQ1NYj5pSE6Q9b1uE3hDpa
         ou4O5B63Bca28Jl2AhGdSxhUe2eW8oV3Ag7P6CArbqvjg0gvMQZeDEc6wbswf8OhLhAU
         e9Eg==
X-Gm-Message-State: ACrzQf0UjVwQmZvxfp512yc7YdTlgvN1Ep/N0r+jiA3v5zOVf6FEKu6j
        +ItV3T4N1ejFFIAw4bTyVD09aNJzRfk=
X-Google-Smtp-Source: AMsMyM6f6q0iaRA9rBp5xdUcVvsD7pIWzH95B6UoEDKDp3o/ck7hEUj2K9Jyij174sLM7BMhdfrIXw==
X-Received: by 2002:a05:6870:9625:b0:13b:65ff:2ff8 with SMTP id d37-20020a056870962500b0013b65ff2ff8mr9966685oaq.292.1666972528870;
        Fri, 28 Oct 2022 08:55:28 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:c120:b306:638c:958])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1483000000b0047f8ceca22bsm1689807ood.15.2022.10.28.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:55:28 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
Subject: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
Date:   Fri, 28 Oct 2022 10:55:27 -0500
Message-Id: <20221028155527.7724-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
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

After upgrading BIOS to U82 01.02.01 Rev.A, the console is flooded
strange char "^@" which printed out every second and makes login
nearly impossible. Also the below messages were shown both in console
and journal/dmesg every second:

usb 1-3: Device not responding to setup address.
usb 1-3: device not accepting address 4, error -71
usb 1-3: device descriptor read/all, error -71
usb usb1-port3: unable to enumerate USB device

Wifi is soft blocked by checking rfkill. When unblocked manually,
after few seconds it would be soft blocked again. So I was suspecting
something triggered rfkill to soft block wifi.  At the end it was
fixed by removing hp_wmi module.

The root cause is the way hp-wmi driver handles command 1B on
post-2009 BIOS.  In pre-2009 BIOS, command 1Bh return 0x4 to indicate
that BIOS no longer controls the power for the wireless devices.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp-wmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 627a6d0eaf83..29cd4e437d97 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -1300,8 +1300,15 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	wwan_rfkill = NULL;
 	rfkill2_count = 0;
 
-	if (hp_wmi_rfkill_setup(device))
-		hp_wmi_rfkill2_setup(device);
+	/*
+	 * In pre-2009 BIOS, command 1Bh return 0x4 to indicate that
+	 * BIOS no longer controls the power for the wireless
+	 * devices. All features supported by this command will no
+	 * longer be supported.
+	 */
+	if (!hp_wmi_bios_2009_later())
+		if (hp_wmi_rfkill_setup(device))
+			hp_wmi_rfkill2_setup(device);
 
 	err = hp_wmi_hwmon_init();
 
-- 
2.34.1

