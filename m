Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E26BED31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCQPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCQPoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:44:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8018AA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r4so2948811ilt.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679067868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a1d1fr4N+C7PXc0LKPdjmMfmc5jaU/X7nUeZTlUew8=;
        b=edGXQnYQ0HkrrfNv5IFT0omboD051eEzLkdnJoYWlPCXCzdTicYA+TvfAWJ2HCvjlK
         YMYjGF4i3TSmqtjAbeAZywtA78oi5HH3jJ4kdLtBxoSNi4ea95M/OVyH0SDj2wlvK/O5
         acsWYpeaacOUNCsBoUI5wHCrbP7vaN8+2QIBXFFzmZxzDMYTM4FyDHXIMF4Wqbuwnt1y
         6XTtD6aCVhui1tGJGE3qWURPoAarEHGzWIgSnvVbD8i2yG46lYCVC4EvN99ZepY+0F3O
         WLdIfo2urVg+jPsGvSxfgLEf1z+BQk3F4cfHp2X3nDYa7+iSkXpBbgHQcS3tytwe+TdK
         uL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a1d1fr4N+C7PXc0LKPdjmMfmc5jaU/X7nUeZTlUew8=;
        b=aQcpM6Sr27ZQbus5lbx3b4KwmKtrxCjxskp45EDo9Nn8uxfupmjoUIn/pEicv83U4u
         QS/Gn0ovfi4nNdMnw8mHt8EuKC42uOs6tzxhgk83++34dzpr6mmTHjgbJSq6QJdQ7Q9c
         d0QJvrBI+MihlcmvI8k6BdFbOSrJ5KqiWslWAuCGANEq9fTgcN4S82kS8dM8RMzx4Jr2
         Mtt2s+6Uce1Ud9FmSEMldrRIuJNHi8p8hcyPe6MHrWpuD6g6oEBGldUJfoZMvciCgoGL
         wtfVu7TAAIsOtjLrsg9C6P6kc8sGJxGRNhATl67awya9V3Yr5+w1kD/HCSkmgK4dFBg3
         EL7A==
X-Gm-Message-State: AO0yUKWZM6/2uvHEAtY/gyvAPOK0na9gT2er1YeoYX3pJiHa214vW4Br
        zYPpChCNMaVbNENRNUbkDmxf4dnse+vN4SvjKs/8xA==
X-Google-Smtp-Source: AK7set92iqvgzgwYkPXpincX1m8KuRtSgbfX7vb/ZFPT7R8L5BBCXtUXM/PLNFqyzMUwNe/kQH9AoA==
X-Received: by 2002:a92:d4c9:0:b0:316:ef6e:7219 with SMTP id o9-20020a92d4c9000000b00316ef6e7219mr109458ilm.13.1679067868542;
        Fri, 17 Mar 2023 08:44:28 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id 185-20020a021dc2000000b0038a06a14b37sm780983jaj.103.2023.03.17.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:44:28 -0700 (PDT)
Received: by earth (Postfix, from userid 1000)
        id 90DFC1060082; Fri, 17 Mar 2023 10:44:27 -0500 (CDT)
From:   "Jeremy J. Peper" <jeremy@jeremypeper.com>
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] add code to enable XOR and CRYPTO engines on mv78xx0
Date:   Fri, 17 Mar 2023 10:43:46 -0500
Message-Id: <20230317154411.3727514-3-jeremy@jeremypeper.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317154411.3727514-1-jeremy@jeremypeper.com>
References: <20230317154411.3727514-1-jeremy@jeremypeper.com>
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

Adding missing code/values required to enable the XOR and CESA engines for this SoC

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
+* XOR engine
+****************************************************************************/
+void __init mv78xx0_xor_init(void)
+{
+	orion_xor0_init(XOR_PHYS_BASE,
+		XOR_PHYS_BASE + 0x200,
+		IRQ_MV78XX0_XOR_0, IRQ_MV78XX0_XOR_1);
+}
+
+/****************************************************************************
+ * Cryptographic Engines and Security Accelerator (CESA)
+****************************************************************************/
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

