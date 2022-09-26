Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBA5EA6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiIZNKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiIZNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FB27FDD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C8D8B8076E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A486C433D6;
        Mon, 26 Sep 2022 11:38:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KX3c5Kbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664192285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnDWWCZn0mHAsuzag2TKKQsyvb93fB4Y/heIJb8hWAQ=;
        b=KX3c5KbkBujPPeXBA5NskqqOc/TD05pgirmCe515IamirnPF9btNZdKSEsOT5rbtysAGws
        bGKuTGzQ85MBt0bRIkansJWkfsc5Nj8D2RxyG8ABreO7z7apES4ghm1UOkT95wPz4IzOp1
        0eNkdb3GdEK5Bi+CGxrq95Z+zb9Q6VA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a43b9dc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 11:38:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 3/3] m68k: generate new RNG seed on reboot
Date:   Mon, 26 Sep 2022 13:37:54 +0200
Message-Id: <20220926113754.1256358-3-Jason@zx2c4.com>
In-Reply-To: <20220926113754.1256358-1-Jason@zx2c4.com>
References: <20220926113754.1256358-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than rebooting into a system with no entropy, regenerate the RNG
seed before rebooting, so that the new system has a fresh seed.

Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/asm/bootinfo.h |  2 ++
 arch/m68k/kernel/process.c       | 11 +++++++++++
 arch/m68k/kernel/setup_mm.c      |  2 ++
 3 files changed, 15 insertions(+)

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
 
 
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2cb4a61bcfac..c2b20d5d51e2 100644
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
@@ -51,8 +53,17 @@ void arch_cpu_idle(void)
 #endif
 }
 
+const struct bi_record *rng_seed_record;
+
 void machine_restart(char * __unused)
 {
+	if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
+		u16 len = rounddown_pow_of_two(rng_seed_record->size -
+					       sizeof(*rng_seed_record) - 2);
+		get_random_bytes((u8 *)rng_seed_record->data + 2, len);
+		*(u16 *)rng_seed_record->data = cpu_to_be16(len);
+	}
+
 	if (mach_reset)
 		mach_reset();
 	for (;;);
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index e45cc9923703..eacf734bea0e 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -160,6 +160,8 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 			 * length to prevent kexec from using it.
 			 */
 			memzero_explicit((void *)data, len + 2);
+			/* Store a reference to be filled in on reboot. */
+			rng_seed_record = record;
 			break;
 		}
 
-- 
2.37.3

