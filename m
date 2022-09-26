Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6204B5EA6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiIZNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiIZNIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFE1C056A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB0C601D2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D5DC43140;
        Mon, 26 Sep 2022 11:38:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P1bCvfZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664192282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fe4akEYhBM/2Bu4YmMN7wSpP8cjz6zgjKU1u9J3cJnk=;
        b=P1bCvfZVwSr9IHjD1Li4/WMLwfMG4XW35vNJuvk/DI2R7XKixKRQUFobDMe8D2VRTPyiHS
        yIQjMUGrVKG3ZfAMPLux99x+0HBtL5cfKDx7djfLQUqvdsDZiVKeielVottd8UVbmRiyXG
        O4H+jWxorfW7g91ldN33y9EzJicl9sY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1ce3af6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 11:38:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v4 2/3] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
Date:   Mon, 26 Sep 2022 13:37:53 +0200
Message-Id: <20220926113754.1256358-2-Jason@zx2c4.com>
In-Reply-To: <20220926113754.1256358-1-Jason@zx2c4.com>
References: <20220926113754.1256358-1-Jason@zx2c4.com>
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
removed, so that ID isn't reused. In addition, we previously documented
2-byte alignment, but 4-byte alignment is actually necessary, so update
that comment.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <laurent@vivier.eu>
Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/uapi/asm/bootinfo-virt.h |  9 ++-------
 arch/m68k/include/uapi/asm/bootinfo.h      |  8 +++++++-
 arch/m68k/kernel/setup_mm.c                | 12 ++++++++++++
 arch/m68k/virt/config.c                    | 11 -----------
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
index b091ee9b06e0..7dbcd7bec103 100644
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
+ * #define BI_VIRT_RNG_SEED	0x8006 */
 
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 
diff --git a/arch/m68k/include/uapi/asm/bootinfo.h b/arch/m68k/include/uapi/asm/bootinfo.h
index 95ecf3ae4c49..6ce7644ab3d6 100644
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
+ *   - seed data    [ `length` bytes, padded to preserve 4-byte struct alignment ]
+ */
+#define BI_RNG_SEED		0x0008
 
     /*
      *  Linux/m68k Architectures (BI_MACHTYPE)
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 7e7ef67cff8b..e45cc9923703 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nvram.h>
 #include <linux/initrd.h>
+#include <linux/random.h>
 
 #include <asm/bootinfo.h>
 #include <asm/byteorder.h>
@@ -151,6 +152,17 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
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
+			break;
+		}
+
 		default:
 			if (MACH_IS_AMIGA)
 				unknown = amiga_parse_bootinfo(record);
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 4ab22946ff68..632ba200ad42 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -2,7 +2,6 @@
 
 #include <linux/reboot.h>
 #include <linux/serial_core.h>
-#include <linux/random.h>
 #include <clocksource/timer-goldfish.h>
 
 #include <asm/bootinfo.h>
@@ -93,16 +92,6 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
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
-		break;
-	}
 	default:
 		unknown = 1;
 		break;
-- 
2.37.3

