Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5049072616B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjFGNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjFGNgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:36:47 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9681993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686145002;
        bh=BPguxngCcatQFXlBdF+cO4v4EYUu4CjSbAh+qgMu1hI=;
        h=From:To:Cc:Subject:Date;
        b=HGFYRNnynM4+R8XRpOzxNtHpcDgz1GbhTUPZEBWdoFMQeh8KaeXCZV/un7v3IHV+V
         kQCZGyUJzzPD6Z9oB498gMi1iaHkRRApALbELqlRKaGSLp8KGUab85m5NNsZAHdXn5
         yAxdBmAwem3H2MT5r8EvfLW4sVpm2Imdk5+nk5LY=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 928874E8; Wed, 07 Jun 2023 21:36:40 +0800
X-QQ-mid: xmsmtpt1686145000tb1eyu550
Message-ID: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
X-QQ-XMAILINFO: NioaTWkRhWwaYWTxZeEaVMvYT+6+8WBXxjru4PK5DK6okfUQA1P7v2En+zPoE5
         1z2hnrATIIcrCuuKw/AznibA2SzpN7O3IfFjLKOySd5ejj03Pxk8w1pZjsUaZnJrwbZ5AW/EbbcG
         a90pH9d6d6woHq6WHb24b77J0mciKoDab6wKeYEx/hyy7vMdmqhocNJGCMWaZfKUfhNq+o4FT7GC
         jYcT+QmzbY8XnyB2+g5RsKnVevJecvqymIQONDidDQPY7x62h8xgJp6JNyNB4iNISOsAGQ4lRGwn
         4zv6yH9Z71tLcLrrk9lBE6geVDESfMc+gyN+4iYiyVzRddH4AujsPKOFLZeKfhxiW3NR1nd2RWI4
         sJIjWvjtPLFCF0Xzk/ZuB7IjByv7ZWdGQN2osyyHnVcRzCBpgS9QpWHgvHBqlE72dQGybw8y4I4a
         2x4NfozxHwGMVjk8yCKxug4SVOp1OQiCzBDf4ujU11UQXhk3vHCeOiDb4HMYbmy5trXZAR0l5Ebl
         QpTjD6shVS3GgNgmHpmHCPAZW2mTsiQzWaYyYUkHySFrQ8nYOiuRN/YhOYwn/COs0tLwsVTEHcqs
         GCouN6JX+hopwcLkPi3kmY9qyATKAha4WFEcDj11X9ob87AuHlF8g1FhUGEBlO2jfHgw+Vw0cOie
         NxsY08ofqoVLiws8bDxLNYQeLNEGRbQHcOzK8SgIhJuQEXGpBr0M5p5TrZWlg+zK3W1gzg8f9YuQ
         9+fuOuw8FvLTILBeZB+SUbtJVkzF2l/+V33p2q/+ySyJ7FFCcQSwc+r39vRdtTf39lxhrhAfD0tK
         tsNheMtt+YMjKZS2i+7qIkGhfjFtZEijis50o0Hupr7hqqUXxBbyajaqsKRuCpeaYhUaFI5p0fom
         KrZXXKX0sEbADejJWLTbfpK3EvqfNouJvZqtPGQCI2Va5jPl6ZT5b7SUKkiOVM3Y+dsC/4FCN9V8
         5OOc4af7zAERcA1+hs/nVYu2XgQ6wEhhWEgL0Zpnw=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH] riscv: reserve DTB before possible memblock allocation
Date:   Wed,  7 Jun 2023 21:35:19 +0800
X-OQ-MSGID: <20230607133518.2472995-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that early_init_fdt_scan_reserved_mem() allocates memory
from memblock for dynamic reserved memory in `/reserved-memory` node.
Any fixed reservation must be done before that to avoid potential
conflicts.

Reserve the DTB in memblock just after early scanning it.

Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
 arch/riscv/kernel/setup.c | 10 ++++++++++
 arch/riscv/mm/init.c      |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..c147fa8da929 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/screen_info.h>
 #include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/sched/task.h>
 #include <linux/smp.h>
 #include <linux/efi.h>
@@ -256,6 +257,15 @@ static void __init parse_dtb(void)
 		pr_err("No DTB passed to the kernel\n");
 	}
 
+	/*
+	 * If DTB is built in, no need to reserve its memblock.
+	 * Otherwise, do reserve it but avoid using
+	 * early_init_fdt_reserve_self() since __pa() does
+	 * not work for DTB pointers that are fixmap addresses
+	 */
+	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+
 #ifdef CONFIG_CMDLINE_FORCE
 	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c6bb966e4123..f8c9a79acd94 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -254,15 +254,6 @@ static void __init setup_bootmem(void)
 	 */
 	early_init_fdt_scan_reserved_mem();
 
-	/*
-	 * If DTB is built in, no need to reserve its memblock.
-	 * Otherwise, do reserve it but avoid using
-	 * early_init_fdt_reserve_self() since __pa() does
-	 * not work for DTB pointers that are fixmap addresses
-	 */
-	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
-		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-- 
2.39.2

