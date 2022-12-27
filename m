Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D66570F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiL0XW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0XWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1011DEAB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672183324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2YB886vj/0RSjOsIoihr40sWcL59EYyEGWlzpKCiQ5E=;
        b=hiS08cs7K8jYCKWGeZqy3iL+iKH/clc78lEzLHS2MtBMU2ei0ajwf8PxoXH/bzf4IIK9HS
        TePav/mAeQEbfTMpC1yF0gDiQJAbdwbVy6nP9e2ufPB7VyiTqbqwhYqFQGQxhtuZ+DcOVt
        EAuE/EW+/vlX9LZ5bWDaxf/T4TF8fZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-qGCQ9mRyMbWVcm4Erl1-Ow-1; Tue, 27 Dec 2022 18:22:03 -0500
X-MC-Unique: qGCQ9mRyMbWVcm4Erl1-Ow-1
Received: by mail-wr1-f72.google.com with SMTP id g18-20020adfa492000000b0027174820fdbso1747423wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YB886vj/0RSjOsIoihr40sWcL59EYyEGWlzpKCiQ5E=;
        b=vN5xHspQLnxrU++NfJ5gj4hyaIZmFXqNb2P+doEg2IF0UdpBsviCUntye4ckuOziZk
         avMewiNfu999KVh2KIUNUJMqhcmxUmYsW8fe0Ubrp98FD6fPQ2DavVLrd6zXYz93Ulb+
         p4dxhXh3/mKKRYGBkqwi8Q2Fy37ZHNZ73ryAuAE5lv/1io8PdYKsPnkd1s9dgHQnhmvh
         1fRRBy1CaDuiUqhIlTRLjkU3cgofdvlMpl4PFpIJUGVC7J++dgCsRyEp5hjqyZ4wJysR
         1oqqQIl1UZgc5s0MBqoryqLrZNwVs83oMh7E+5WtvDAbe644CHnuHg/FOe+oPoYpeSLB
         kjXA==
X-Gm-Message-State: AFqh2ko68iQEumVEJRebLPbmaRNU/CHuaf87jYSik8lrXARWoRjF/cBH
        HOO+Y87cgYGqiyBFda6Gi2bBrHgnqbuZRGirdiViSrk+tVjzfe12ib0Sez7UXxF7mglc1OI8Wsc
        xE6b/zkKsnx60cHdFOXqE6bpuPzoeLLMVOA/9WXQyUG71a/F5Epo5vxv4x2Jm1tJbzuodkBamfm
        U=
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr16574070wmp.23.1672183321944;
        Tue, 27 Dec 2022 15:22:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCYRXb4UZodGTLw+Jf5tYDL8TPhCO3xrK1e1Unx+PCglPdun+aYKCHvmdRTcE2L7Wp5xiC4A==
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr16574058wmp.23.1672183321678;
        Tue, 27 Dec 2022 15:22:01 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c161600b003cfa622a18asm22204084wmn.3.2022.12.27.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:22:01 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        John Stultz <jstultz@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [RESEND PATCH] driver core: Make driver_deferred_probe_timeout a static variable
Date:   Wed, 28 Dec 2022 00:21:52 +0100
Message-Id: <20221227232152.3094584-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used outside of its compilation unit, so there's no need to
export this variable.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Acked-by: John Stultz <jstultz@google.com>
---

 drivers/base/dd.c             | 6 ++----
 include/linux/device/driver.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e9b2f9c25efe..69daf9d414eb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -257,13 +257,11 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
 #ifdef CONFIG_MODULES
-int driver_deferred_probe_timeout = 10;
+static int driver_deferred_probe_timeout = 10;
 #else
-int driver_deferred_probe_timeout;
+static int driver_deferred_probe_timeout;
 #endif
 
-EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
-
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 2114d65b862f..50d0a416a5e7 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -240,7 +240,6 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
 }
 #endif
 
-extern int driver_deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
-- 
2.38.1

