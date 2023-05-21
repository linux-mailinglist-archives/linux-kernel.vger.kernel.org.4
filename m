Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB470ADF7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjEULu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEULt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:49:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47A10E6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:47:20 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q0hWv-0008T6-1T; Sun, 21 May 2023 13:47:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, christoph.muellner@vrull.eu,
        David.Laight@ACULAB.COM, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 1/2] riscv: don't include kernel.h into alternative.h
Date:   Sun, 21 May 2023 13:47:14 +0200
Message-Id: <20230521114715.955823-2-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

This include is not currently needed for alternatives and creates
possible issues when we want to add alternatives to deeper kernel
infrastructure.

The issue in question came from trying to introduce Zawrs alternatives,
which resulted in a somewhat circular dependency like:

In file included from ../include/linux/bitops.h:34,
                 from ../include/linux/kernel.h:22,
                 from ../arch/riscv/include/asm/alternative.h:16,
                 from ../arch/riscv/include/asm/errata_list.h:8,
                 from ../arch/riscv/include/asm/barrier.h:15,
                 from ../include/linux/list.h:11,
                 from ../include/linux/preempt.h:11,
                 from ../include/linux/spinlock.h:56,
                 from ../include/linux/mmzone.h:8,
                 from ../include/linux/gfp.h:7,
                 from ../include/linux/mm.h:7,
                 from ../arch/riscv/kernel/asm-offsets.c:10:
../include/asm-generic/bitops/generic-non-atomic.h: In function ‘generic_test_bit_acquire’:
../include/asm-generic/bitops/generic-non-atomic.h:140:23: error: implicit declaration of function ‘smp_load_acquire’ [-Werror=implicit-function-declaration]
  140 |         return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
      |                       ^~~~~~~~~~~~~~~~

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/alternative.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 6a41537826a7..05885de6048c 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -13,7 +13,6 @@
 #ifdef CONFIG_RISCV_ALTERNATIVE
 
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <asm/hwcap.h>
-- 
2.39.0

