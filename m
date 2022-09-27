Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60B5EB995
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiI0FWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiI0FWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:22:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE1A4B81;
        Mon, 26 Sep 2022 22:22:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so14535096pjm.1;
        Mon, 26 Sep 2022 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DWLcmxYZAMnsjUrS5Hc3Zpy4nyMx50XhflQVbGXc3l0=;
        b=oFZVZ+g2rsEHFvkvdA2sPQOUqqZq+CeGH030rpJSR+POfHh0l15FBWEsPerg4IddEJ
         Z34LXiZPgwHoJYPNz5osqrXTRTSnBJUHDCqwZL50FPNofXt6gBU5M1W3AsU/cvRv6rdl
         zTLg6TdBW0vr7/9RR8IZ9sJeCkyfXBAHc3uceBwR29yZCQmnyeA9CHnxqRqHHQQDLKEY
         Nxy4E8xSZCjpXDjJwn4fOVMCpJmGfd0TKLmu3RQp05yEdqzLVVZT5A/BUdQzGDjoGTqB
         nTOsHYj9prhlQyR+efRT7t1ldgbAHzjUrCjfNsVNADsqLQmJGa4T9t8rAXpyWVNkTJIa
         BCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DWLcmxYZAMnsjUrS5Hc3Zpy4nyMx50XhflQVbGXc3l0=;
        b=0rPBfxNCwcYGiX/T32MSN3jtYnCp7nx0B19DqQG4z1LGCHr0DuPdRkk+BQ+x/1XFjk
         Qy+9T1hkRFdTxs++cxp02FxzZMQARxOEEgjOXDeNcWHAXwrFIiDiwv2gDA5VIXotRg1z
         gK0EzePggXVzZhxPZSmcXcrlrwWZrl9qPMC5Hf01Z8T7OsenlbFRY+18OdoGATBTFop4
         0w7TntPcJQacvv/tDJWUi4BqpmwWU8jpm7zi0l/qnvuYDN2lvzBSfvpO653X9+HGEjLr
         8QRGdsiZwbCl32YhhMlneC1Hxb5UQ8mGTUlFswyDgLuQ820Hlj1AWVDhhgpT9y8AAoYY
         FJKw==
X-Gm-Message-State: ACrzQf2KtuoYmca4Nh+2F+Jzdq/R8YhxCRWQWpMkAY3EMeAqQbEvB2Mn
        jDyA+VRoOjjZsYJ6dHAOY5k=
X-Google-Smtp-Source: AMsMyM54NATFHbpjB/2Q3lbYCrnaGeUHQQrGwY9TavzqnnL+ZpFqzBee8DRAic8WLFpvQgzDEIkjAg==
X-Received: by 2002:a17:90a:e7c3:b0:203:bbbb:e589 with SMTP id kb3-20020a17090ae7c300b00203bbbbe589mr2533107pjb.175.1664256143590;
        Mon, 26 Sep 2022 22:22:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id z187-20020a6265c4000000b005367c28fd32sm504811pfb.185.2022.09.26.22.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 22:22:22 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mfd: twl4030-irq: add missing device.h include
Date:   Mon, 26 Sep 2022 22:22:15 -0700
Message-Id: <20220927052217.2784593-3-dmitry.torokhov@gmail.com>
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

The driver is using "struct device" and therefore needs to include
device.h header. We used to get this definition indirectly via inclusion
of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
from unnecessary includes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/twl4030-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 4f576f0160a9..87496c1cb8bc 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -14,6 +14,7 @@
  * by syed khasim <x0khasim@ti.com>
  */
 
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

