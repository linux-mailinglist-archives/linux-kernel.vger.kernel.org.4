Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3406B5C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCKNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCKNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760599D48
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678542538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NcfgF3uxX783RG109c6BFmxXkTNUHbIUH8XfVEOGGVg=;
        b=OEfkvZIVGrqAH6E/KjVlQYju9NmTfyBOaPk+fSchFR7RM//ai3b/24DpO4bxokZ82AooJg
        AQTQXQz6lDtNcqnkIvSZUGDt2m1+2bWrJAiDTo5F76D1KnbeLD5zrT8HhBAHD9rLtQt3Ao
        tTWcLifidzKRRqE4Qz4sVDZns634T2E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203--58ARnCSPj-LnXl7A6vfzw-1; Sat, 11 Mar 2023 08:48:55 -0500
X-MC-Unique: -58ARnCSPj-LnXl7A6vfzw-1
Received: by mail-qk1-f197.google.com with SMTP id b22-20020ae9eb16000000b007427f9339c0so4599152qkg.17
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcfgF3uxX783RG109c6BFmxXkTNUHbIUH8XfVEOGGVg=;
        b=3Sve+ltDl6lokmNJsbnivokWcCeIpmjUjdbZDRxj4sxrEebYpeM+sjPKuJJqNmuCcU
         XkMzhbq0UaIz4V9Zu7LteAwLq7Ha9bL9GBQwECDQY/+gudM13KGipqIQCbO7SrVX2TSF
         gLpKVVWQFKP84bKewffsBSfxhOyBFhqxFc/WWQW2TMslWi7traFmuTegVctRNJN45v1o
         EXHt2e6iicX5fqgpDOqj+I4MpNF35ocsO2yI7+xkJJbchdRNVOxW3tIw3Fmp7G2oAOAj
         yEdI8nEUXqLwMjWK1w/AvCSrmshoyXeSE8BOIkB6+oubT4WgkjVt1TAtzGuUzvM0F1VJ
         jhjA==
X-Gm-Message-State: AO0yUKVlk0MANpqnFNlu0gWT8qulVdCykY1yapcFgMnWqswU0yycFOrg
        DEGN1lZmvLLINw8otBOrl2SFVouTJy6f9b6ivBOYY4YbCtmfKIAdinCOqiG0sJ5IG6Lh3L7tJAm
        Ugp4Khkk70DxO7Gmlp1NekMDp
X-Received: by 2002:a05:6214:202f:b0:56f:37a:4561 with SMTP id 15-20020a056214202f00b0056f037a4561mr3674078qvf.34.1678542534951;
        Sat, 11 Mar 2023 05:48:54 -0800 (PST)
X-Google-Smtp-Source: AK7set8xesAQjqL0qnNANgZe8UUdI4rz7/wrmwGJkQJnuQKaQ4KY5AhnrWWd4s+kwBtYf47QdZG45g==
X-Received: by 2002:a05:6214:202f:b0:56f:37a:4561 with SMTP id 15-20020a056214202f00b0056f037a4561mr3674066qvf.34.1678542534705;
        Sat, 11 Mar 2023 05:48:54 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a025d00b0071aacb2c76asm359026qkn.132.2023.03.11.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:48:54 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     isely@pobox.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: pvrusb2: VIDEO_PVRUSB2 depends on DVB_CORE to use dvb_* symbols
Date:   Sat, 11 Mar 2023 08:48:47 -0500
Message-Id: <20230311134847.624910-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rand config causes this link error
vmlinux.o: In function `pvr2_dvb_create':
(.text+0x8af1d2): undefined reference to `dvb_register_adapter'

The rand config has
CONFIG_VIDEO_PVRUSB2=y
CONFIG_VIDEO_DEV=y
CONFIG_DVB_CORE=m

VIDEO_PVRUSB2 should also depend on DVB_CORE.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/usb/pvrusb2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/Kconfig b/drivers/media/usb/pvrusb2/Kconfig
index f2b64e49c5a2..9501b10b31aa 100644
--- a/drivers/media/usb/pvrusb2/Kconfig
+++ b/drivers/media/usb/pvrusb2/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_PVRUSB2
 	tristate "Hauppauge WinTV-PVR USB2 support"
-	depends on VIDEO_DEV && I2C
+	depends on VIDEO_DEV && I2C && DVB_CORE
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
 	select VIDEO_CX2341X
-- 
2.27.0

