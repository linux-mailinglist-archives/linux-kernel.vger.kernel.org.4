Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743D5F8736
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJHTrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJHTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:46:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A99326DE;
        Sat,  8 Oct 2022 12:46:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j16so11699104wrh.5;
        Sat, 08 Oct 2022 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ug3lOc6jfgPHpJPdL4UNADTEvLPCskKFnlfe0HCOmbw=;
        b=n0tI/K/Z7QZYmn1JsfkgpNVg6VscSyMimstyBK/nL8weDKMf56DUqs5z98GR9R6l5f
         TUw0aMsDkzGqOwoS12y4GI2dXLv2vlzqU4FudQz+ntgGnjOyoja+QMFmYj/seDjI9Xb0
         +d9aNHS5QWbeBLe/EupmqE+NsCcHvA01YPRvbJaLATdlW6Je8M/Sz7MKpHD9xylE3LH8
         QbM/VVAAGHORkCuLA4y2ZLWytZVkW7hvyQXnzwrhPkoje+JUbzcawbIIf3eLOOBJ2oxm
         UvGVvbtCej2VOaLl1kRas+ETQ/X2A1fhpaZbwUfhdmlzePrndmNQ6XlZ2owoBYkVTYFD
         PO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3lOc6jfgPHpJPdL4UNADTEvLPCskKFnlfe0HCOmbw=;
        b=AkNrECdGuLIfkLpmbkkToa3zDJ2i16TMBZLvw/QBjURkb2PRxV+VCNE1zumGcimB/c
         2GZtGr4Nbugnb0M/5nf/uEsxjZXFWUE/aQx1oy73jxg39ovTpYebRVHaproPXjyQhqwr
         esI1JI0OJovIE6j3SThZaBcjBBgtP3M2RM97tFFqWq01b7X8uQ2+jkBaJ0E+Az/d2ptu
         gCKbb+BBR0X8KgOllcaJNz8vNwBtD7YjL7XfBRmd0cT3gE8voAin0fdmqBna1e9sNUO8
         EUHfX+pvLcKIlt+ySYYSiJOxzkktmxpnXplaa49HrIH1QYZMNSf+Im2nlZSpGWU7srdg
         RIgg==
X-Gm-Message-State: ACrzQf2PDr/wutkQx+SSwQfekpDg9bmhRq3Og7iJlWPXwfp3XVPpdGmP
        FO31k1f1ZYu1qnJUUOjk1w5n4npauQ==
X-Google-Smtp-Source: AMsMyM4ZQVOmT+WW0nvOmRqYLse5zaWyiRiDBLMoBNS9Q5QfykkWHl66eY+4fgW8C/vvPTxoNHLn1w==
X-Received: by 2002:adf:f9c9:0:b0:22e:3581:2422 with SMTP id w9-20020adff9c9000000b0022e35812422mr7006215wrr.592.1665258414357;
        Sat, 08 Oct 2022 12:46:54 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id i129-20020a1c3b87000000b003b50428cf66sm2291828wma.33.2022.10.08.12.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:46:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Sat, 8 Oct 2022 20:46:52 +0100
To:     erazor_de@users.sourceforge.net
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: roccat: Convert snprintf() to sysfs_emit()
Message-ID: <Y0HTrCgAQ+wc4yGj@octinomon>
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

