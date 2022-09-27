Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70505EB994
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiI0FW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiI0FWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:22:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D4A4B07;
        Mon, 26 Sep 2022 22:22:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id go6so8225031pjb.2;
        Mon, 26 Sep 2022 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ikb+u+hcNEgSjT1UG2HdGjiof/wZmdaALLeEUmBnt2Q=;
        b=DeO6Uo76+XxzrGEW2XqDhD8UNWqaXCVCi7mx/T7CF/eUUWIYHHeMhgfmLByzpgM9s9
         jR8sSBBediVx/MVqJffnSbQtlvbz8wTyow3n8FjNGe3L659FHRhkUAEKno88d8kb0JIw
         ZJPTK12GWAHuNcYuMBwkQTsIXCcIGfO87QxSO32jA56Z2rfeAfqeCJ/RLSEiytha6wHa
         J9LNQfpg8f3NJZoswRlW5AtEajZCmlX8K+8SdSWoYxBU6txin4jFVSSv4dAONCYHC/n9
         ZUcyJU5YYh9oVtrrg+fKSZ9fwogiWn7oCCv6lRl+kZcsHokmmUYxv9g0ssqCBPy+tMvi
         TMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ikb+u+hcNEgSjT1UG2HdGjiof/wZmdaALLeEUmBnt2Q=;
        b=8J7QE3ekXyOi3psosCUK9n7GGrtacXPCjjeZM9dBbd1j9JmFogki+2P8oIvNLjtZwm
         TzGeWUsto/kpRIh1R+D6yGgB4N5TLgKzqV4uJePV9i8JA/GILpMvZpfmpPpyiLu+ylYT
         kb8aILdvKowIFnzwvc9zajTOYIVI84YMUgGAkoseP98p3Iuo4tmdJGyeL6kVmZ5jQ/tl
         kPrARisENWU8Rp8ODKOVrdx2mB9pHS0HvuLZ6GhY2sXMf+nIPuvLxJs1Kil/NVRjz6uT
         jJ47YH9ZqAGlziD3DpCn3wJwHRzsgdMUE0YxSLGmNGrr5dnpRt1nZSKw1LrRRh2/jStQ
         u8jQ==
X-Gm-Message-State: ACrzQf33c+XPzc6bWxINZr81qPC0Wwc222qrqC2ZQpDmhN/7FKBINtcx
        aAE9ma/QGFXpLAwiiZwLi9E=
X-Google-Smtp-Source: AMsMyM52PGyX+Z9dkOce1+DJ69CRfFK4uMH2Dwjn2IdNW9x03X69EKYAXyMro1HCA2kpRvBB4BiDPw==
X-Received: by 2002:a17:90b:3e87:b0:203:19a9:e534 with SMTP id rj7-20020a17090b3e8700b0020319a9e534mr2535111pjb.222.1664256142126;
        Mon, 26 Sep 2022 22:22:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id z187-20020a6265c4000000b005367c28fd32sm504811pfb.185.2022.09.26.22.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 22:22:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] watchdog: twl4030_wdt: add missing of.h include
Date:   Mon, 26 Sep 2022 22:22:14 -0700
Message-Id: <20220927052217.2784593-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
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

The driver is using of_device_id and therefore needs to include
of.h header. We used to get this definition indirectly via inclusion
of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
from unnecessary includes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/watchdog/twl4030_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 355e428c0b99..e715ac1369a0 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

