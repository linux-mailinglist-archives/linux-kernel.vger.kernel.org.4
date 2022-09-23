Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66FA5E8050
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiIWREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIWRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FE1497AE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974B161255
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765EFC433C1;
        Fri, 23 Sep 2022 17:03:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dm53qBVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663952631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQrWhckICffwDFTmUv0mshNquiiM57TSKQlQI55dl6E=;
        b=Dm53qBVVCaQiRu0vguuJDGbwQSdwks6RSiVhAXn0d0TEH+LMSGuoYmrGL9RqoJIN+xoa2i
        sLX//Sn02lhbZKsgJvPUDZG8b8pmV2c9+VEUdHq342lWHAVLosyzSVsnsXpsa7mR41yITv
        fLsRA6JADXpg/cKvPh6qJfgg7JXaTmY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 800fab4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Sep 2022 17:03:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 3/3] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
Date:   Fri, 23 Sep 2022 19:03:40 +0200
Message-Id: <20220923170340.4099226-3-Jason@zx2c4.com>
In-Reply-To: <20220923170340.4099226-1-Jason@zx2c4.com>
References: <20220923170340.4099226-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful on !virt platforms for kexec, so change things from
BI_VIRT_RNG_SEED to be BI_RNG_SEED, and simply remove BI_VIRT_RNG_SEED
because it only ever lasted one release, and nothing is broken by not
having it. At the same time, keep a comment noting that it's been
removed, so that ID isn't reused.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/asm/bootinfo.h           |  2 ++
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  9 ++-------
 arch/m68k/include/uapi/asm/bootinfo.h      |  8 +++++++-
 arch/m68k/kernel/process.c                 | 10 ++++++++++
 arch/m68k/kernel/setup_mm.c                | 14 ++++++++++++++
 arch/m68k/virt/config.c                    | 21 ---------------------
 6 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/m68k/include/asm/bootinfo.h b/arch/m68k/include/asm/bootinfo.h
index 81c91af8ec6c..71103530839a 100644
--- a/arch/m68k/include/asm/bootinfo.h
+++ b/arch/m68k/include/asm/bootinfo.h
@@ -28,6 +28,8 @@ void process_uboot_commandline(char *commandp, int size);
 static inline void process_uboot_commandline(char *commandp, int size) {}
 #endif
 
+extern const struct bi_record *rng_seed_record;
+
 #endif /* __ASSEMBLY__ */
 
 
diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
index b091ee9b06e0..4032a14cc5c2 100644
--- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
+++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
@@ -13,13 +13,8 @@
 #define BI_VIRT_VIRTIO_BASE	0x8004
 #define BI_VIRT_CTRL_BASE	0x8005
 
-/*
- * A random seed used to initialize the RNG. Record format:
- *
- *   - length       [ 2 bytes, 16-bit big endian ]
- *   - seed data    [ `length` bytes, padded to preserve 2-byte alignment ]
- */
-#define BI_VIRT_RNG_SEED	0x8006
+/* No longer used -- replaced with BI_RNG_SEED -- but don't reuse this index:
+ * 	#define BI_VIRT_RNG_SEED	0x8006 */
 
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 
diff --git a/arch/m68k/include/uapi/asm/bootinfo.h b/arch/m68k/include/uapi/asm/bootinfo.h
index 95ecf3ae4c49..387f2a61e908 100644
--- a/arch/m68k/include/uapi/asm/bootinfo.h
+++ b/arch/m68k/include/uapi/asm/bootinfo.h
@@ -64,7 +64,13 @@ struct mem_info {
 					/* (struct mem_info) */
 #define BI_COMMAND_LINE		0x0007	/* kernel command line parameters */
 					/* (string) */
-
+/*
+ * A random seed used to initialize the RNG. Record format:
+ *
+ *   - length       [ 2 bytes, 16-bit big endian ]
+ *   - seed data    [ `length` bytes, padded to preserve 2-byte alignment ]
+ */
+#define BI_RNG_SEED		0x0008
 
     /*
      *  Linux/m68k Architectures (BI_MACHTYPE)
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2cb4a61bcfac..f40cc6f47f09 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/reboot.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
+#include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -36,6 +37,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>
+#include <asm/bootinfo.h>
 
 
 asmlinkage void ret_from_fork(void);
@@ -51,8 +53,16 @@ void arch_cpu_idle(void)
 #endif
 }
 
+const struct bi_record *rng_seed_record;
+
 void machine_restart(char * __unused)
 {
+	if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
+		u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
+		get_random_bytes((u8 *)rng_seed_record->data + 2, len);
+		*(u16 *)rng_seed_record->data = cpu_to_be16(len);
+	}
+
 	if (mach_reset)
 		mach_reset();
 	for (;;);
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 7e7ef67cff8b..eacf734bea0e 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nvram.h>
 #include <linux/initrd.h>
+#include <linux/random.h>
 
 #include <asm/bootinfo.h>
 #include <asm/byteorder.h>
@@ -151,6 +152,19 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 				sizeof(m68k_command_line));
 			break;
 
+		case BI_RNG_SEED: {
+			u16 len = be16_to_cpup(data);
+			add_bootloader_randomness(data + 2, len);
+			/*
+			 * Zero the data to preserve forward secrecy, and zero the
+			 * length to prevent kexec from using it.
+			 */
+			memzero_explicit((void *)data, len + 2);
+			/* Store a reference to be filled in on reboot. */
+			rng_seed_record = record;
+			break;
+		}
+
 		default:
 			if (MACH_IS_AMIGA)
 				unknown = amiga_parse_bootinfo(record);
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index d4627840e35b..632ba200ad42 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -2,7 +2,6 @@
 
 #include <linux/reboot.h>
 #include <linux/serial_core.h>
-#include <linux/random.h>
 #include <clocksource/timer-goldfish.h>
 
 #include <asm/bootinfo.h>
@@ -45,18 +44,10 @@ static void virt_halt(void)
 		;
 }
 
-static const struct bi_record *rng_seed_record;
-
 static void virt_reset(void)
 {
 	void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
 
-	if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
-		u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
-		get_random_bytes((u8 *)rng_seed_record->data + 2, len);
-		*(u16 *)rng_seed_record->data = cpu_to_be16(len);
-	}
-
 	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
 	local_irq_disable();
 	while (1)
@@ -101,18 +92,6 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
 		data += 4;
 		virt_bi_data.virtio.irq = be32_to_cpup(data);
 		break;
-	case BI_VIRT_RNG_SEED: {
-		u16 len = be16_to_cpup(data);
-		add_bootloader_randomness(data + 2, len);
-		/*
-		 * Zero the data to preserve forward secrecy, and zero the
-		 * length to prevent kexec from using it.
-		 */
-		memzero_explicit((void *)data, len + 2);
-		/* Store a reference to be filled in on reboot. */
-		rng_seed_record = record;
-		break;
-	}
 	default:
 		unknown = 1;
 		break;
-- 
2.37.3

