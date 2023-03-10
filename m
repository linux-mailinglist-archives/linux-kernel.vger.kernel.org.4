Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010B6B3EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCJMNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCJMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:13:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3C311D0;
        Fri, 10 Mar 2023 04:13:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso5879107wmb.0;
        Fri, 10 Mar 2023 04:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678450389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SA/Uf4V++NswwW9O2kSqPWP7Kc6Kc0XD4HdyXMjml3E=;
        b=LUIjiou6NjJw5SrfBboTkj0wMPrVhXtlGzJoObiukkb8ZbaQWxQlfj4UItxGuxouHK
         MvDVgyvUMIHrSfPzZZKcaG9Q81ksWTEjR73UoOcqVtVEzLXBbwPOMInjs2mdKmu3RX6S
         4I+tw9F/kr5HUKHZ1SufA6+MwSf+0038Ygy3u9aSfr33ugZhb1AQt7CTNBOSiwkxansZ
         GmvmPj5Im9tpWkpLT7i4kDPbD2LG5VhB920AqLgmlJMO583S94Oo7d8P6RWf8m65FPUS
         oYr54J9q7xIkGZLxs/hVEaVpHmzAAThfOup1kyHYHS5fIHtZu+gDTYGBjzrWDQkGGME5
         ONSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SA/Uf4V++NswwW9O2kSqPWP7Kc6Kc0XD4HdyXMjml3E=;
        b=18f5K0oKj2NiWl0mxsZczGVAfwrDuGmdYKhQOedJZ7KPjNduAQ2HdDZFWeC7senlxK
         Pf+0jfirslHyBrAIZ4ozVImzDHHMjAqwJtp7yFBsrPgvsPk35o+VE8POGayHF/F3F7U5
         TXSRQXIZrTk7QvovQDWiICFcTyD0M5/wWkxXxytjway+BSaFpZSM/rO1wHqU3ukDxNzH
         nvDoJYJBawQ75SnsjX3YXW4P372Zh7ME83RqNyiWyzm0Swgl6YE2iLTD9plQpIR7DtbG
         ktDqmOFROZeh1rH1GagKRkr6OsWHOdexC4ceBfS+mo+UjNefJUE8hk1xdsPpvLEKbcRF
         3GUQ==
X-Gm-Message-State: AO0yUKUYPtzZkzlvw07/TjFJrKDCZlAd98GEBnGMmW4P2lZlkt1OJCCX
        GLPJ7vmi69nB3Cp44N/WyVAR2Nlpb1xLFg==
X-Google-Smtp-Source: AK7set+Zqd5Vmfwt94sd7Ti0Ln0Pg1W6KJjGVFXdf5pNqcsyQLTKlXlBCbvUpYBJ/bkXdG190aQ4xQ==
X-Received: by 2002:a05:600c:548e:b0:3eb:2708:86ca with SMTP id iv14-20020a05600c548e00b003eb270886camr2435067wmb.28.1678450389227;
        Fri, 10 Mar 2023 04:13:09 -0800 (PST)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4c46000000b002c55de1c72bsm1975108wrt.62.2023.03.10.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:13:08 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
Date:   Fri, 10 Mar 2023 13:13:06 +0100
Message-Id: <20230310121306.4632-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_sync_dma_for_cpu_all() causes kernel panics on BCM6358 with EHCI/OHCI:
[    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    3.895011] Reserved instruction in kernel code[#1]:
[    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
[    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
[    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
[    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
[    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
[    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
[    3.932848] $20   : 00000000 00000000 55590000 77d70000
[    3.938251] $24   : 00000018 00000010
[    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
[    3.949058] Hi    : 00000000
[    3.952013] Lo    : 00000000
[    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
[    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
[    3.965913] Status: 10008703	KERNEL EXL IE
[    3.970216] Cause : 00800028 (ExcCode 0a)
[    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
[    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_common
[    3.992907] Process init (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=77e22ec8)
[    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 81431edc 7ff559b8 81428470
[    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 80015c70 806f0000 8063ae74
[    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 0000000a 77d6b418 00000003
[    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 00000001 00000000 04000000
[    4.035512]         77d54874 00000000 00000000 00000000 00000000 00000012 00000002 00000000
[    4.044196]         ...
[    4.046706] Call Trace:
[    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
[    4.054356] [<80015c70>] setup_frame+0xdc/0x124
[    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
[    4.064207] [<80011b50>] work_notifysig+0x10/0x18
[    4.069036]
[    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  3c048063  0c0228aa  24846a00  26240010
[    4.080686]
[    4.082517] ---[ end trace 22a8edb41f5f983b ]---
[    4.087374] Kernel panic - not syncing: Fatal exception
[    4.092753] Rebooting in 1 seconds..

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/dma.c   | 5 +++++
 arch/mips/bmips/setup.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 33788668cbdb..3769d5efdede 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -5,11 +5,16 @@
 #include <asm/bmips.h>
 #include <asm/io.h>
 
+int bmips_dma_sync_enabled = 1;
+
 void arch_sync_dma_for_cpu_all(void)
 {
 	void __iomem *cbr = BMIPS_GET_CBR();
 	u32 cfg;
 
+	if (!bmips_dma_sync_enabled)
+		return;
+
 	if (boot_cpu_type() != CPU_BMIPS3300 &&
 	    boot_cpu_type() != CPU_BMIPS4350 &&
 	    boot_cpu_type() != CPU_BMIPS4380)
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index e95b3f78e7cd..825e85e14010 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -35,6 +35,8 @@
 #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
 #define BCM6328_TP1_DISABLED	BIT(9)
 
+extern int bmips_dma_sync_enabled;
+
 static const unsigned long kbase = VMLINUX_LOAD_ADDRESS & 0xfff00000;
 
 struct bmips_quirk {
@@ -104,6 +106,9 @@ static void bcm6358_quirks(void)
 	 * disable SMP for now
 	 */
 	bmips_smp_enabled = 0;
+
+	/* ARCH_HAS_SYNC_DMA_FOR_CPU_ALL causes kernel panics on BCM6358 */
+	bmips_dma_sync_enabled = 0;
 }
 
 static void bcm6368_quirks(void)
-- 
2.30.2

