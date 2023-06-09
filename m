Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD066728DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjFICXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjFICW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:22:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3A2D4B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1008313b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277376; x=1688869376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eV2XvsxLQ0E9qrsqopG7ODwdkJbzczV5YNgpOsdmco=;
        b=DG7GdmfBqWct0Fj+1gBvLY2unB5NKJdFqCL67rIJb/Yp3nXPbYwQfT+Iu5j7dWK6qo
         DyWqXUZXEmLcScuEbSTjhJf02gnORCpcru1kYgMdNaZY6BYS978lYXCzlgerMzYJBDdh
         eGeXNP0CsIuGf5y9q/TjL6mCcseiXlhF6RGIumeLC82e/CiMcDlPsCPJtAC/U44oi+Hw
         BEMboGBo5VcFesVHponWoLh+XSPmKRUKqgHGBQ44hGHLBeeUeo7/JHAjd6OsULIggfwq
         Ds3EF+5dyTnwMCKudaz0fv0pebk3rveZCWCft0nbpcdBmZC3KsRriEa67+IFTnNXv7l4
         mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277376; x=1688869376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eV2XvsxLQ0E9qrsqopG7ODwdkJbzczV5YNgpOsdmco=;
        b=Yi9q6bUE8BnK7vKN1ULl3KDX88Kgq/wzA2YIGuTRaktlA8F/nsJmVeKK8iu3SZ2Mnu
         meXPQxUxdsus7FkELp/DlzQVMBaYPPF23yCg0arGmBZ5lCwyOdTtCObuB5V/Nn9EqCJC
         F6UnbdrJHQ5at2MkQh/LAg+FAtgnvBDKG6lmxj8AA3q9JKUI1yirp3oH3178wnSJ+2Gk
         had2WavGtuwBdC0VPZbxv7wcgTXjcYyhziEtfrQ+N/MznMwYpnEn6kGHbFbPB6YTI2tK
         yU/J6baA7rYfMUwYQ985vM3czDjeVZOqfzCMgf309Urg7WO5F6lzCNsgWm0B7LpDZzNm
         fFKQ==
X-Gm-Message-State: AC+VfDz/VA9yg1e73xIjQki3Z9AEgDPouba6ivEHvdeFxQR/Q+ii8ASB
        rRrutOJXxowlB8bM8rBWOobej9IJJPY=
X-Google-Smtp-Source: ACHHUZ6v1ZB2HtC7nRUGyzlhdPOvF4nd4Zc2Vqp29+vhJ6sTXpFOhznRDe0LuCrjbTrsvcUJhDAodg==
X-Received: by 2002:a05:6a20:c183:b0:10c:7c72:bdf9 with SMTP id bg3-20020a056a20c18300b0010c7c72bdf9mr12833pzb.29.1686277375755;
        Thu, 08 Jun 2023 19:22:55 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:54 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/5] xtensa: drop platform_heartbeat
Date:   Thu,  8 Jun 2023 19:22:37 -0700
Message-Id: <20230609022240.1694244-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
References: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_heartbeat is called from the timer interrupt handler, but
there may be no periodic timer interrupts on xtensa, so the frequency of
platform_heartbeat calls may be unrelated to HZ. Drop the callback and
reimplement its only user with a timer.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/platform.h   |  5 -----
 arch/xtensa/kernel/platform.c        |  1 -
 arch/xtensa/kernel/time.c            |  4 ----
 arch/xtensa/platforms/xt2000/setup.c | 20 +++++++++++---------
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/xtensa/include/asm/platform.h b/arch/xtensa/include/asm/platform.h
index 354ca942de40..3be6b4bf9763 100644
--- a/arch/xtensa/include/asm/platform.h
+++ b/arch/xtensa/include/asm/platform.h
@@ -47,11 +47,6 @@ extern void platform_power_off (void);
  */
 extern void platform_idle (void);
 
-/*
- * platform_heartbeat is called every HZ
- */
-extern void platform_heartbeat (void);
-
 /*
  * platform_calibrate_ccount calibrates cpu clock freq (CONFIG_XTENSA_CALIBRATE)
  */
diff --git a/arch/xtensa/kernel/platform.c b/arch/xtensa/kernel/platform.c
index ac1e0e566995..bb4d426ebb44 100644
--- a/arch/xtensa/kernel/platform.c
+++ b/arch/xtensa/kernel/platform.c
@@ -32,7 +32,6 @@ _F(void, restart, (void), { while(1); });
 _F(void, halt, (void), { while(1); });
 _F(void, power_off, (void), { while(1); });
 _F(void, idle, (void), { __asm__ __volatile__ ("waiti 0" ::: "memory"); });
-_F(void, heartbeat, (void), { });
 
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 _F(void, calibrate_ccount, (void),
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 16b8a6273772..1c3dfea843ec 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -121,10 +121,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 	set_linux_timer(get_linux_timer());
 	evt->event_handler(evt);
-
-	/* Allow platform to do something useful (Wdog). */
-	platform_heartbeat();
-
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 08bc9b0ede3e..dc187684203b 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/timer.h>
 
 #include <asm/processor.h>
 #include <asm/platform.h>
@@ -70,16 +71,17 @@ void __init platform_setup(char** cmdline)
 
 /* Heartbeat. Let the LED blink. */
 
-void platform_heartbeat(void)
+static void xt2000_heartbeat(struct timer_list *unused);
+
+static DEFINE_TIMER(heartbeat_timer, xt2000_heartbeat);
+
+static void xt2000_heartbeat(struct timer_list *unused)
 {
-	static int i, t;
+	static int i;
 
-	if (--t < 0)
-	{
-		t = 59;
-		led_print(7, i ? ".": " ");
-		i ^= 1;
-	}
+	led_print(7, i ? "." : " ");
+	i ^= 1;
+	mod_timer(&heartbeat_timer, jiffies + HZ / 2);
 }
 
 //#define RS_TABLE_SIZE 2
@@ -137,7 +139,7 @@ static int __init xt2000_setup_devinit(void)
 {
 	platform_device_register(&xt2000_serial8250_device);
 	platform_device_register(&xt2000_sonic_device);
-
+	mod_timer(&heartbeat_timer, jiffies + HZ / 2);
 	return 0;
 }
 
-- 
2.30.2

