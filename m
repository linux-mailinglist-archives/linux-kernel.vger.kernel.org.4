Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63435EEF53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiI2HkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiI2HkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:40:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34EB05A2D5;
        Thu, 29 Sep 2022 00:40:08 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWvOSzVjdKwjAA--.5668S4;
        Thu, 29 Sep 2022 15:40:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Simplify __bswapdi2() and __bswapsi2()
Date:   Thu, 29 Sep 2022 15:39:58 +0800
Message-Id: <1664437198-31260-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664437198-31260-1-git-send-email-yangtiezhu@loongson.cn>
References: <1664437198-31260-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxTWvOSzVjdKwjAA--.5668S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43JryfWFyUKF1fCFy3Jwb_yoW8CF1Up3
        Wq9anrKFWvq3WxKFnxAry0qr15tFs0yFyUtFWUCr1YvryDXan8Jr4xArZ3tryUJr9YvFyx
        CF9xXry5KF4Utw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4xMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8KhF7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro definitions ___constant_swab64 and ___constant_swab32
to simplify __bswapdi2() and __bswapsi2().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/lib/bswapdi.c | 10 ++--------
 arch/mips/lib/bswapsi.c |  6 ++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/mips/lib/bswapdi.c b/arch/mips/lib/bswapdi.c
index 1d020e1..88242dc 100644
--- a/arch/mips/lib/bswapdi.c
+++ b/arch/mips/lib/bswapdi.c
@@ -1,19 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/compiler.h>
+#include <uapi/linux/swab.h>
 
 /* To silence -Wmissing-prototypes. */
 unsigned long long __bswapdi2(unsigned long long u);
 
 unsigned long long notrace __bswapdi2(unsigned long long u)
 {
-	return (((u) & 0xff00000000000000ull) >> 56) |
-	       (((u) & 0x00ff000000000000ull) >> 40) |
-	       (((u) & 0x0000ff0000000000ull) >> 24) |
-	       (((u) & 0x000000ff00000000ull) >>  8) |
-	       (((u) & 0x00000000ff000000ull) <<  8) |
-	       (((u) & 0x0000000000ff0000ull) << 24) |
-	       (((u) & 0x000000000000ff00ull) << 40) |
-	       (((u) & 0x00000000000000ffull) << 56);
+	return ___constant_swab64(u);
 }
 EXPORT_SYMBOL(__bswapdi2);
diff --git a/arch/mips/lib/bswapsi.c b/arch/mips/lib/bswapsi.c
index 02d9df4..2ed6554 100644
--- a/arch/mips/lib/bswapsi.c
+++ b/arch/mips/lib/bswapsi.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/compiler.h>
+#include <uapi/linux/swab.h>
 
 /* To silence -Wmissing-prototypes. */
 unsigned int __bswapsi2(unsigned int u);
 
 unsigned int notrace __bswapsi2(unsigned int u)
 {
-	return (((u) & 0xff000000) >> 24) |
-	       (((u) & 0x00ff0000) >>  8) |
-	       (((u) & 0x0000ff00) <<  8) |
-	       (((u) & 0x000000ff) << 24);
+	return ___constant_swab32(u);
 }
 EXPORT_SYMBOL(__bswapsi2);
-- 
2.1.0

