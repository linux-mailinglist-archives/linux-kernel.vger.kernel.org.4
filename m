Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5F7423FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF2K3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjF2K3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:29:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E5E131
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:29:39 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QsF736dJkz1HCTM;
        Thu, 29 Jun 2023 18:29:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:29:37 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] mm: remove arguments of show_mem()
Date:   Thu, 29 Jun 2023 18:43:56 +0800
Message-ID: <20230629104357.35455-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly call __show_mem(0, NULL, MAX_NR_ZONES - 1) in show_mem()
to remove the arguments of show_mem().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/xmon/xmon.c  | 2 +-
 drivers/tty/sysrq.c       | 2 +-
 drivers/tty/vt/keyboard.c | 2 +-
 include/linux/mm.h        | 4 ++--
 init/initramfs.c          | 2 +-
 kernel/panic.c            | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index fae747cc57d2..ee17270d35d0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1084,7 +1084,7 @@ cmds(struct pt_regs *excp)
 				memzcan();
 				break;
 			case 'i':
-				show_mem(0, NULL);
+				show_mem();
 				break;
 			default:
 				termch = cmd;
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b6e70c5cfa17..e1df63a88aac 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -342,7 +342,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 
 static void sysrq_handle_showmem(int key)
 {
-	show_mem(0, NULL);
+	show_mem();
 }
 static const struct sysrq_key_op sysrq_showmem_op = {
 	.handler	= sysrq_handle_showmem,
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index be8313cdbac3..358f216c6cd6 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -606,7 +606,7 @@ static void fn_scroll_back(struct vc_data *vc)
 
 static void fn_show_mem(struct vc_data *vc)
 {
-	show_mem(0, NULL);
+	show_mem();
 }
 
 static void fn_show_state(struct vc_data *vc)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eef34f6a0351..ddb140e14f3a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3047,9 +3047,9 @@ extern void mem_init(void);
 extern void __init mmap_init(void);
 
 extern void __show_mem(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
-static inline void show_mem(unsigned int flags, nodemask_t *nodemask)
+static inline void show_mem(void)
 {
-	__show_mem(flags, nodemask, MAX_NR_ZONES - 1);
+	__show_mem(0, NULL, MAX_NR_ZONES - 1);
 }
 extern long si_mem_available(void);
 extern void si_meminfo(struct sysinfo * val);
diff --git a/init/initramfs.c b/init/initramfs.c
index e7a01c2ccd1b..8d0fd946cdd2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -61,7 +61,7 @@ static void __init error(char *x)
 }
 
 #define panic_show_mem(fmt, ...) \
-	({ show_mem(0, NULL); panic(fmt, ##__VA_ARGS__); })
+	({ show_mem(); panic(fmt, ##__VA_ARGS__); })
 
 /* link hash */
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 10effe40a3fa..07239d4ad81e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -216,7 +216,7 @@ static void panic_print_sys_info(bool console_flush)
 		show_state();
 
 	if (panic_print & PANIC_PRINT_MEM_INFO)
-		show_mem(0, NULL);
+		show_mem();
 
 	if (panic_print & PANIC_PRINT_TIMER_INFO)
 		sysrq_timer_list_show();
-- 
2.41.0

