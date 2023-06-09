Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF5728DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbjFICXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbjFICW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:22:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0272D52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b026657a6fso3661305ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277378; x=1688869378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wsq4vyLCQ78cbT52QEssPn3hTsohPnCqXULhgza1F5o=;
        b=r/aT+JTdcg6U2SJ15bsZSU1aaTesZMypDzlMc7FudyPsr61Y7mH0EyKAg2GUGKOW6K
         EZ1t82xBTMqYrwW5udk3T+e3LvnKXY9STVBnpeW0O5l6TrPUj2eCbdIUs5SbUhCHwQfj
         xHVOZNnPjitny9J6XOx4AxfRGSlKhuRGG1EraddMKFJPanZ8+brWK/ZltgncpI5xeOAb
         rkxKixVCXUlYa04c3fbmczbh5o1UNcnKLc9MP9NcpEjTe8vOhjTFEO5bImAmWhIrxX4x
         GhTyUJOmElphSIrVyphzebRQA3ACshV/eTx/t1wNZclmmWMppVSVBvZ8q3295/qhDWEf
         +m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277378; x=1688869378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsq4vyLCQ78cbT52QEssPn3hTsohPnCqXULhgza1F5o=;
        b=ACD/JGh6GyK3ty1hCWifb/3FCctsiN67fjIS/UfrRp7VCWuPPJWYvOTAs8KfCxj/gl
         FhBuJlncR4Cp0FrI5zLALM/yek0134UuqMf0pUvKZnUGvLScR8ubVoOtGeBJPDMPZbXQ
         0xIXkb/37UGlYMGWHMJNSECTewoVcqj1LUZ/a2DZwErEeagESXrHIupnte4vKITliDXl
         djWMiCGuZHvxaDvTD6jO4AABnfsuOOUekAndz2xmDCGHKRwMXToYKpaFzREd77LspySf
         i7l+/BzuLGDSK9IcKEh/IiTulvaw9rQNJx23H9HD8pPW6VZUlPuId0PZ95/7wLcJ50py
         dZJg==
X-Gm-Message-State: AC+VfDxyQcJJbMILw/4hvIdUD78JfjzCNqSYYR8F3NVzmD9nZkdEpPhe
        r0giVPvmkbwYJTRXEFnDWzfm3hypYCw=
X-Google-Smtp-Source: ACHHUZ6jQGs1L8FVzz1znL+Fa1YXrWzTJaRbvDGUgk2UHGYp1JGZRe0xA6L7k9JhPFeZuPyeN405Ug==
X-Received: by 2002:a17:903:2350:b0:1ad:f138:b2f6 with SMTP id c16-20020a170903235000b001adf138b2f6mr196154plh.16.1686277377931;
        Thu, 08 Jun 2023 19:22:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:57 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/5] xtensa: drop platform_halt and platform_power_off
Date:   Thu,  8 Jun 2023 19:22:39 -0700
Message-Id: <20230609022240.1694244-5-jcmvbkbc@gmail.com>
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

Instead of using xtensa-specific platform_halt and platform_power_off
callbacks use do_kernel_power_off in the machine_halt and
machine_power_off and reimplement existing platform_halt and
platform_power_off users with register_sys_off_handler.

Drop platform_halt and platform_power_off declarations and default
implementations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/platform.h   | 10 ----------
 arch/xtensa/kernel/platform.c        |  2 --
 arch/xtensa/kernel/setup.c           | 14 ++++++++++----
 arch/xtensa/platforms/iss/setup.c    | 12 +++++-------
 arch/xtensa/platforms/xt2000/setup.c | 13 +++++--------
 arch/xtensa/platforms/xtfpga/setup.c | 14 +++++---------
 6 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/arch/xtensa/include/asm/platform.h b/arch/xtensa/include/asm/platform.h
index 5b3c1f96f7b5..94f13fabf7cd 100644
--- a/arch/xtensa/include/asm/platform.h
+++ b/arch/xtensa/include/asm/platform.h
@@ -27,16 +27,6 @@ extern void platform_init(bp_tag_t*);
  */
 extern void platform_setup (char **);
 
-/*
- * platform_halt is called to stop the system and halt.
- */
-extern void platform_halt (void);
-
-/*
- * platform_power_off is called to stop the system and power it off.
- */
-extern void platform_power_off (void);
-
 /*
  * platform_idle is called from the idle function.
  */
diff --git a/arch/xtensa/kernel/platform.c b/arch/xtensa/kernel/platform.c
index 526ab744271f..29fa5d659274 100644
--- a/arch/xtensa/kernel/platform.c
+++ b/arch/xtensa/kernel/platform.c
@@ -28,8 +28,6 @@
 
 _F(void, init, (bp_tag_t *first), { });
 _F(void, setup, (char** cmd), { });
-_F(void, halt, (void), { while(1); });
-_F(void, power_off, (void), { while(1); });
 _F(void, idle, (void), { __asm__ __volatile__ ("waiti 0" ::: "memory"); });
 
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 8f72039335c2..5680391d7e35 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -533,14 +533,20 @@ void machine_restart(char * cmd)
 
 void machine_halt(void)
 {
-	platform_halt();
-	while (1);
+	local_irq_disable();
+	smp_send_stop();
+	do_kernel_power_off();
+	while (1)
+		cpu_relax();
 }
 
 void machine_power_off(void)
 {
-	platform_power_off();
-	while (1);
+	local_irq_disable();
+	smp_send_stop();
+	do_kernel_power_off();
+	while (1)
+		cpu_relax();
 }
 #ifdef CONFIG_PROC_FS
 
diff --git a/arch/xtensa/platforms/iss/setup.c b/arch/xtensa/platforms/iss/setup.c
index a7009f223ef2..0f1fe132691e 100644
--- a/arch/xtensa/platforms/iss/setup.c
+++ b/arch/xtensa/platforms/iss/setup.c
@@ -25,16 +25,11 @@
 #include <platform/simcall.h>
 
 
-void platform_halt(void)
-{
-	pr_info(" ** Called platform_halt() **\n");
-	simc_exit(0);
-}
-
-void platform_power_off(void)
+static int iss_power_off(struct sys_off_data *unused)
 {
 	pr_info(" ** Called platform_power_off() **\n");
 	simc_exit(0);
+	return NOTIFY_DONE;
 }
 
 static int iss_restart(struct notifier_block *this,
@@ -90,4 +85,7 @@ void __init platform_setup(char **p_cmdline)
 
 	atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block);
 	register_restart_handler(&iss_restart_block);
+	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_PLATFORM,
+				 iss_power_off, NULL);
 }
diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 71b57ab50599..258e01a51fd8 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -42,18 +42,12 @@ static void led_print (int f, char *s)
 		    break;
 }
 
-void platform_halt(void)
-{
-	led_print (0, "  HALT  ");
-	local_irq_disable();
-	while (1);
-}
-
-void platform_power_off(void)
+static int xt2000_power_off(struct sys_off_data *unused)
 {
 	led_print (0, "POWEROFF");
 	local_irq_disable();
 	while (1);
+	return NOTIFY_DONE;
 }
 
 static int xt2000_restart(struct notifier_block *this,
@@ -147,6 +141,9 @@ static int __init xt2000_setup_devinit(void)
 	platform_device_register(&xt2000_sonic_device);
 	mod_timer(&heartbeat_timer, jiffies + HZ / 2);
 	register_restart_handler(&xt2000_restart_block);
+	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_DEFAULT,
+				 xt2000_power_off, NULL);
 	return 0;
 }
 
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 1690232c003e..a2432f081710 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -33,20 +33,13 @@
 #include <platform/lcd.h>
 #include <platform/hardware.h>
 
-void platform_halt(void)
-{
-	lcd_disp_at_pos(" HALT ", 0);
-	local_irq_disable();
-	while (1)
-		cpu_relax();
-}
-
-void platform_power_off(void)
+static int xtfpga_power_off(struct sys_off_data *unused)
 {
 	lcd_disp_at_pos("POWEROFF", 0);
 	local_irq_disable();
 	while (1)
 		cpu_relax();
+	return NOTIFY_DONE;
 }
 
 static int xtfpga_restart(struct notifier_block *this,
@@ -79,6 +72,9 @@ void __init platform_calibrate_ccount(void)
 static void __init xtfpga_register_handlers(void)
 {
 	register_restart_handler(&xtfpga_restart_block);
+	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_DEFAULT,
+				 xtfpga_power_off, NULL);
 }
 
 #ifdef CONFIG_USE_OF
-- 
2.30.2

