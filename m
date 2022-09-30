Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91525F0CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiI3OCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiI3OB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:01:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3A21824;
        Fri, 30 Sep 2022 07:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2764B82779;
        Fri, 30 Sep 2022 14:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ACCC433C1;
        Fri, 30 Sep 2022 14:01:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QrmDnNcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664546510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6UOOg5IHINhdAb/kc7hzr49OF4tFMMPyJOm2kJXSQ58=;
        b=QrmDnNcdtDElPz1tbbdwJoacxSO7nehxXO4EwFFB6/EQ/MV/xmYnI+q06JHP6eicqWgJqf
        XDBgdweyUjgNqvTdecRz+UAcdsdkX7WTh6xey56Ot+mYwizpUvR4FAAXp/LJCkxhPpuMmU
        h52RizHs7XmEC33Q9oRO3z6xfUMOwuw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79a49daa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Sep 2022 14:01:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] mips: allow firmware to pass RNG seed to kernel
Date:   Fri, 30 Sep 2022 16:01:38 +0200
Message-Id: <20220930140138.575751-1-Jason@zx2c4.com>
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

Nearly all other firmware environments have some way of passing a RNG
seed to initialize the RNG: DTB's rng-seed, EFI's RNG protocol, m68k's
bootinfo block, x86's setup_data, and so forth. This adds something
similar for MIPS, which will allow various firmware environments,
bootloaders, and hypervisors to pass an RNG seed to initialize the
kernel's RNG.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/mips/kernel/setup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2ca156a5b231..39c79f67c7a3 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
 #include <asm/prom.h>
+#include <asm/fw/fw.h>
 
 #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
 char __section(".appended_dtb") __appended_dtb[0x100000];
@@ -756,6 +757,24 @@ static void __init prefill_possible_map(void)
 static inline void prefill_possible_map(void) {}
 #endif
 
+static void __init setup_rng_seed(void)
+{
+	char *rng_seed_hex = fw_getenv("rngseed");
+	u8 rng_seed[512];
+	size_t len;
+
+	if (!rng_seed_hex)
+		return;
+
+	len = min(sizeof(rng_seed), strlen(rng_seed_hex) / 2);
+	if (hex2bin(rng_seed, rng_seed_hex, len))
+		return;
+
+	add_bootloader_randomness(rng_seed, len);
+	memzero_explicit(rng_seed, len);
+	memzero_explicit(rng_seed_hex, len * 2);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -786,6 +805,8 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 
 	memblock_dump_all();
+
+	setup_rng_seed();
 }
 
 unsigned long kernelsp[NR_CPUS];
-- 
2.37.3

