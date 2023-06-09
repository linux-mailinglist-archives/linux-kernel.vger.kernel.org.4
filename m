Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C59728DC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbjFICXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbjFICW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:22:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4062722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b0201d9a9eso2624475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277377; x=1688869377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCtYwAZA3V/mmKNvKuucQTbNEzv8gSVajwtWxzirv6E=;
        b=XSfUX99qrk64VZR9SPQM0V4bTRmc6dyG6OrJMZ1LJbVCt4UlAalzVlY6G6Dvo+WEme
         HJGwIRe3wQ9HCRzzhaanhNgI5aqOGa+1Eblt6Vdv8AqROmG6WWwgr4KKzPViLeY7Rlwb
         4cak8//B0AqPF6Fz00TrpYj42kZWk2BDL+9CejDRaQ2rGDEYLPocRJ3sgFK1Vxn6heNF
         2VZusDDvR00WsgJx5+p5dCIkR62b4+x+olCcSOjdK7iM2nZ5W+RH0X/u/dHNy2kCQvOa
         XFo1rja69FSOKGZWJ47yNhoDS2zuUr3MetXJgMlE+t8rl1WomAVytrWPZjcOb5fsZsss
         bTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277377; x=1688869377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCtYwAZA3V/mmKNvKuucQTbNEzv8gSVajwtWxzirv6E=;
        b=IEaWzGxbrrnOr6iIoCKVbL+d0Ggvk2L13dWXK61iq2oJYp7MEDErLHoim+0VNPLMDW
         fIU6cIRuHrLyf2NpKeGkV+JrM+TKZDhzEBK4YIRrNg3gZ8OFXpb4YzW1QmygvWp6/HPK
         LC8kiNqLX6jqjjjPP8gSoNSv7owpRVkZNLd1OWaiJujozWe7z309qJJUr6paF+/857sp
         Zz8+QRvBiCnWW/nryGaM5mykNOySBvIdQu1tBsuhUHbsCBmmKuqnTovHEYsgbz8RDyWv
         SJmKdCH4roQckW+66G+aIhLT7cG7sVnHh2oUN0/bSxXXVMWx1sgQLQlGlFNmRa91TYEy
         0v/Q==
X-Gm-Message-State: AC+VfDyyPW0lZIHSTlJT20m1ZRLriRaPRq/Qbw0DdwZGQuOj8qDaMYDi
        jsraTvzaO9hXvzOoaeKm8sljUc3Skt4=
X-Google-Smtp-Source: ACHHUZ5h5CkVrX+TUvOKHsLHsjR+XHhn0FWlL1eg7VmGUEQZ8dE07qE9IK2HOyb7vO0Lwmo18JXg1w==
X-Received: by 2002:a17:902:d2c9:b0:1b2:3e9f:69d1 with SMTP id n9-20020a170902d2c900b001b23e9f69d1mr4632603plc.18.1686277376822;
        Thu, 08 Jun 2023 19:22:56 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:56 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/5] xtensa: drop platform_restart
Date:   Thu,  8 Jun 2023 19:22:38 -0700
Message-Id: <20230609022240.1694244-4-jcmvbkbc@gmail.com>
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

Instead of using xtensa-specific platform_restart callback use
do_kernel_restart in the machine_restart implementation and reimplement
existing platform_restart users with register_restart_handler.
Drop platform_restart declaration and default implementation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/platform.h   |  5 -----
 arch/xtensa/kernel/platform.c        |  1 -
 arch/xtensa/kernel/setup.c           |  8 +++++++-
 arch/xtensa/platforms/iss/setup.c    | 12 ++++++++++--
 arch/xtensa/platforms/xt2000/setup.c | 11 +++++++++--
 arch/xtensa/platforms/xtfpga/setup.c | 20 ++++++++++++++++++--
 6 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/xtensa/include/asm/platform.h b/arch/xtensa/include/asm/platform.h
index 3be6b4bf9763..5b3c1f96f7b5 100644
--- a/arch/xtensa/include/asm/platform.h
+++ b/arch/xtensa/include/asm/platform.h
@@ -27,11 +27,6 @@ extern void platform_init(bp_tag_t*);
  */
 extern void platform_setup (char **);
 
-/*
- * platform_restart is called to restart the system.
- */
-extern void platform_restart (void);
-
 /*
  * platform_halt is called to stop the system and halt.
  */
diff --git a/arch/xtensa/kernel/platform.c b/arch/xtensa/kernel/platform.c
index bb4d426ebb44..526ab744271f 100644
--- a/arch/xtensa/kernel/platform.c
+++ b/arch/xtensa/kernel/platform.c
@@ -28,7 +28,6 @@
 
 _F(void, init, (bp_tag_t *first), { });
 _F(void, setup, (char** cmd), { });
-_F(void, restart, (void), { while(1); });
 _F(void, halt, (void), { while(1); });
 _F(void, power_off, (void), { while(1); });
 _F(void, idle, (void), { __asm__ __volatile__ ("waiti 0" ::: "memory"); });
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 9191738f9941..8f72039335c2 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/screen_info.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
+#include <linux/reboot.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -522,7 +523,12 @@ void cpu_reset(void)
 
 void machine_restart(char * cmd)
 {
-	platform_restart();
+	local_irq_disable();
+	smp_send_stop();
+	do_kernel_restart(cmd);
+	pr_err("Reboot failed -- System halted\n");
+	while (1)
+		cpu_relax();
 }
 
 void machine_halt(void)
diff --git a/arch/xtensa/platforms/iss/setup.c b/arch/xtensa/platforms/iss/setup.c
index d3433e1bb94e..a7009f223ef2 100644
--- a/arch/xtensa/platforms/iss/setup.c
+++ b/arch/xtensa/platforms/iss/setup.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/printk.h>
+#include <linux/reboot.h>
 #include <linux/string.h>
 
 #include <asm/platform.h>
@@ -36,14 +37,20 @@ void platform_power_off(void)
 	simc_exit(0);
 }
 
-void platform_restart(void)
+static int iss_restart(struct notifier_block *this,
+		       unsigned long event, void *ptr)
 {
 	/* Flush and reset the mmu, simulate a processor reset, and
 	 * jump to the reset vector. */
 	cpu_reset();
-	/* control never gets here */
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block iss_restart_block = {
+	.notifier_call = iss_restart,
+};
+
 static int
 iss_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
@@ -82,4 +89,5 @@ void __init platform_setup(char **p_cmdline)
 	}
 
 	atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block);
+	register_restart_handler(&iss_restart_block);
 }
diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index dc187684203b..71b57ab50599 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -56,14 +56,20 @@ void platform_power_off(void)
 	while (1);
 }
 
-void platform_restart(void)
+static int xt2000_restart(struct notifier_block *this,
+			  unsigned long event, void *ptr)
 {
 	/* Flush and reset the mmu, simulate a processor reset, and
 	 * jump to the reset vector. */
 	cpu_reset();
-	/* control never gets here */
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xt2000_restart_block = {
+	.notifier_call = xt2000_restart,
+};
+
 void __init platform_setup(char** cmdline)
 {
 	led_print (0, "LINUX   ");
@@ -140,6 +146,7 @@ static int __init xt2000_setup_devinit(void)
 	platform_device_register(&xt2000_serial8250_device);
 	platform_device_register(&xt2000_sonic_device);
 	mod_timer(&heartbeat_timer, jiffies + HZ / 2);
+	register_restart_handler(&xt2000_restart_block);
 	return 0;
 }
 
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index c79c1d09ea86..1690232c003e 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -49,7 +49,8 @@ void platform_power_off(void)
 		cpu_relax();
 }
 
-void platform_restart(void)
+static int xtfpga_restart(struct notifier_block *this,
+			  unsigned long event, void *ptr)
 {
 	/* Try software reset first. */
 	WRITE_ONCE(*(u32 *)XTFPGA_SWRST_VADDR, 0xdead);
@@ -58,9 +59,14 @@ void platform_restart(void)
 	 * simulate a processor reset, and jump to the reset vector.
 	 */
 	cpu_reset();
-	/* control never gets here */
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xtfpga_restart_block = {
+	.notifier_call = xtfpga_restart,
+};
+
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 
 void __init platform_calibrate_ccount(void)
@@ -70,6 +76,11 @@ void __init platform_calibrate_ccount(void)
 
 #endif
 
+static void __init xtfpga_register_handlers(void)
+{
+	register_restart_handler(&xtfpga_restart_block);
+}
+
 #ifdef CONFIG_USE_OF
 
 static void __init xtfpga_clk_setup(struct device_node *np)
@@ -134,6 +145,9 @@ static int __init machine_setup(void)
 	if ((eth = of_find_compatible_node(eth, NULL, "opencores,ethoc")))
 		update_local_mac(eth);
 	of_node_put(eth);
+
+	xtfpga_register_handlers();
+
 	return 0;
 }
 arch_initcall(machine_setup);
@@ -281,6 +295,8 @@ static int __init xtavnet_init(void)
 	pr_info("XTFPGA: Ethernet MAC %pM\n", ethoc_pdata.hwaddr);
 	ethoc_pdata.eth_clkfreq = *(long *)XTFPGA_CLKFRQ_VADDR;
 
+	xtfpga_register_handlers();
+
 	return 0;
 }
 
-- 
2.30.2

