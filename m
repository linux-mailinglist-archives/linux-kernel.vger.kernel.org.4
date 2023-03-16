Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBC6BDD14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCPXlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCPXlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:41:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95257279BF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k17so1569607iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679010024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPnAbSUYrfOqUmAJwubwpWwUyzbpKs6qqyzqjDOXSnw=;
        b=E5UOXyB39VYYfDuF3dUrIE2gTHAynEebWdGce9dYR083SL+bag91Q8JO2txTqc3f1a
         pKTfi1+TxiRIw9KV8gT/yZRFdy9WLLTYm0pK3r8UquQBeHYNk80KVPxQrCmVGyUshIeD
         guqb17S06d2bReBIIPTjhJNcwOHqaJGT7g3CSgioaMtd3fb4tkSHb4faOu/vfKAA5Yi6
         +AHYB2CXugTUA3wT/eUOiPjPk24KUMOWEbmygF4hDIYI4qeBW4GeYNXaXOqVFEhQ3h/U
         fMwqP2tneNbwuPDu/V/jg5ASwIJuoh7RexnP6ELs49SatkCPVUNWmgMInprdWdqZkgdI
         PNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPnAbSUYrfOqUmAJwubwpWwUyzbpKs6qqyzqjDOXSnw=;
        b=WdsvIlBOP3ulPrZtynB3Ontj5sW8zN0teZ2gr0r5txpKEeC0Tm12NjUWb/xjd+KN/i
         zikm6rYPmb+UX0m7WQttcqGL1L2tncXJLHXC61r99clE/KjZhk668CKkoKHhCAGU/a8z
         AQ8qobCQMzDt+2nWevnAJeHZCruLfDznOo9qKcHfxY8gNb10IrlToOAMjkeN5I7Fhw0m
         QIJaM+41a/Vr97ObLh6ZjWPoR+mZGXqbpmhWFOETK2UmbWoSuodIpwYsrYgf1sKa6V+F
         3K1Kovad6tp2EXG1Dsxi83gFBW8QhzHuWiOgyX3phR/yZI7WYZcgN0qnjAU6nfNeIFHk
         Ggtg==
X-Gm-Message-State: AO0yUKXaMUY0kvIR8R+ZL2VfXNWwEqvHUr62DtL4Txz16mu2et5clsSt
        7rRRPmKvsLwB/aeUTk2XET5a/8BXDtA3E5RrKRM=
X-Google-Smtp-Source: AK7set9BYT0ZNpv2sEaU/tR/9ojvtd58rFut/AvgN9EY9ieVHUukx8aOi5Pq2tuHSeh67sAmU7ikvw==
X-Received: by 2002:a6b:fd05:0:b0:752:2f97:80bb with SMTP id c5-20020a6bfd05000000b007522f9780bbmr476957ioi.19.1679010024257;
        Thu, 16 Mar 2023 16:40:24 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id w29-20020a056638379d00b0040630f8625asm210642jal.13.2023.03.16.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:40:23 -0700 (PDT)
From:   1000001101000 <systemalerts@jeremypeper.com>
X-Google-Original-From: 1000001101000 <1000001101000@earth>
Received: by earth (Postfix, from userid 1000)
        id D26991060192; Thu, 16 Mar 2023 18:40:22 -0500 (CDT)
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>
Subject: [PATCH 2/3] add code to enable XOR and CRYPTO engines on mv78xx0 devices enable XOR and CRYTO engines in ts-wxl
Date:   Thu, 16 Mar 2023 18:40:08 -0500
Message-Id: <20230316234009.2115005-2-user@earth>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230316234009.2115005-1-user@earth>
References: <20230316234009.2115005-1-user@earth>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy J. Peper <jeremy@jeremypeper.com>

Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>
---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c |  2 ++
 arch/arm/mach-mv78xx0/common.c            | 23 +++++++++++++++++++++++
 arch/arm/mach-mv78xx0/common.h            |  2 ++
 arch/arm/mach-mv78xx0/mv78xx0.h           | 10 ++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index c3f6dc351..31359f586 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -119,6 +119,8 @@ static void __init wxl_init(void)
 	mv78xx0_uart1_init();
 	mv78xx0_uart2_init();
 	mv78xx0_uart3_init();
+	mv78xx0_xor_init();
+	mv78xx0_crypto_init();
 	mv78xx0_i2c_init();
 	i2c_register_board_info(0, &db78x00_i2c_rtc, 1);
 }
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 461a68945..679753fcc 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -342,6 +342,29 @@ void __ref mv78xx0_timer_init(void)
 			IRQ_MV78XX0_TIMER_1, get_tclk());
 }
 
+/****************************************************************************
+ * XOR engine
+ ****************************************************************************/
+void __init mv78xx0_xor_init(void)
+{
+	orion_xor0_init(XOR_PHYS_BASE,
+		XOR_PHYS_BASE + 0x200,
+		IRQ_MV78XX0_XOR_0, IRQ_MV78XX0_XOR_1);
+}
+
+/****************************************************************************
+ * Cryptographic Engines and Security Accelerator (CESA)
+ ****************************************************************************/
+void __init mv78xx0_crypto_init(void)
+{
+	mvebu_mbus_add_window_by_id(MV78XX0_MBUS_SRAM_TARGET,
+				MV78XX0_MBUS_SRAM_ATTR,
+				MV78XX0_SRAM_PHYS_BASE,
+			MV78XX0_SRAM_SIZE);
+	orion_crypto_init(CRYPTO_PHYS_BASE, MV78XX0_SRAM_PHYS_BASE,
+		SZ_8K, IRQ_MV78XX0_CRYPTO);
+}
+
 
 /*****************************************************************************
  * General
diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
index d8c6c2400..9f1dfd595 100644
--- a/arch/arm/mach-mv78xx0/common.h
+++ b/arch/arm/mach-mv78xx0/common.h
@@ -43,6 +43,8 @@ void mv78xx0_uart0_init(void);
 void mv78xx0_uart1_init(void);
 void mv78xx0_uart2_init(void);
 void mv78xx0_uart3_init(void);
+void mv78xx0_xor_init(void);
+void mv78xx0_crypto_init(void);
 void mv78xx0_i2c_init(void);
 void mv78xx0_restart(enum reboot_mode, const char *);
 
diff --git a/arch/arm/mach-mv78xx0/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78xx0.h
index 3f19bef7d..88efb1e44 100644
--- a/arch/arm/mach-mv78xx0/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/mv78xx0.h
@@ -49,9 +49,15 @@
 #define MV78XX0_REGS_VIRT_BASE		IOMEM(0xfec00000)
 #define MV78XX0_REGS_SIZE		SZ_1M
 
+#define MV78XX0_SRAM_PHYS_BASE          (0xf2200000)
+#define MV78XX0_SRAM_SIZE               SZ_8K
+
 #define MV78XX0_PCIE_MEM_PHYS_BASE	0xc0000000
 #define MV78XX0_PCIE_MEM_SIZE		0x30000000
 
+#define MV78XX0_MBUS_SRAM_TARGET       0x09
+#define MV78XX0_MBUS_SRAM_ATTR         0x00
+
 /*
  * Core-specific peripheral registers.
  */
@@ -98,6 +104,8 @@
 #define USB1_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x51000)
 #define USB2_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x52000)
 
+#define XOR_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x60900)
+
 #define GE00_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x70000)
 #define GE01_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x74000)
 
@@ -106,6 +114,8 @@
 #define PCIE12_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x88000)
 #define PCIE13_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x8c000)
 
+#define CRYPTO_PHYS_BASE	(MV78XX0_REGS_PHYS_BASE + 0x90000)
+
 #define SATA_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0xa0000)
 
 /*
-- 
2.30.2

