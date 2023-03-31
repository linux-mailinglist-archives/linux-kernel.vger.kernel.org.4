Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9BD6D1BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjCaJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCaJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:16:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDAC812BCE;
        Fri, 31 Mar 2023 02:16:05 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxrtrUpCZkwuQUAA--.20587S3;
        Fri, 31 Mar 2023 17:16:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxC77OpCZkVfMRAA--.14538S5;
        Fri, 31 Mar 2023 17:16:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 3/3] module: Ignore L0 and rename is_arm_mapping_symbol()
Date:   Fri, 31 Mar 2023 17:15:53 +0800
Message-Id: <1680254153-14582-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn>
References: <1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxC77OpCZkVfMRAA--.14538S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4kWw48Ar4fXFWxZFyrWFg_yoW7JrW8pr
        y5Cr45GF48Ar1DGay7Wa4Dtr15W3s7uFs7Cry5K3s7Crn0qr1Ivw4DK3W3uwnrAr45Gay8
        uFsayFyakFy5JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L0 symbol is generated when build module on LoongArch, ignore it in
modpost and when looking at module symbols, otherwise we can not see the
expected call trace.

Now is_arm_mapping_symbol() is not only for ARM, in order to reflect the
reality, rename is_arm_mapping_symbol() to is_mapping_symbol().

This is related with commit c17a2538704f ("mksysmap: Fix the mismatch of
'L0' symbols in System.map").

(1) Simple test case

  [loongson@linux hello]$ cat hello.c
  #include <linux/init.h>
  #include <linux/module.h>
  #include <linux/printk.h>

  static void test_func(void)
  {
  	  pr_info("This is a test\n");
	  dump_stack();
  }

  static int __init hello_init(void)
  {
	  pr_warn("Hello, world\n");
	  test_func();

	  return 0;
  }

  static void __exit hello_exit(void)
  {
	  pr_warn("Goodbye\n");
  }

  module_init(hello_init);
  module_exit(hello_exit);
  MODULE_LICENSE("GPL");
  [loongson@linux hello]$ cat Makefile
  obj-m:=hello.o

  ccflags-y += -g -Og

  all:
	  make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
  clean:
	  make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean

(2) Test environment

system: LoongArch CLFS 5.5
https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/tag/5.0
It needs to update grub to avoid booting error "invalid magic number".

kernel: 6.3-rc1 with loongson3_defconfig + CONFIG_DYNAMIC_FTRACE=y

(3) Test result

Without this patch:

  [root@linux hello]# insmod hello.ko
  [root@linux hello]# dmesg
  ...
  Hello, world
  This is a test
  ...
  Call Trace:
  [<9000000000223728>] show_stack+0x68/0x18c
  [<90000000013374cc>] dump_stack_lvl+0x60/0x88
  [<ffff800002050028>] L0\x01+0x20/0x2c [hello]
  [<ffff800002058028>] L0\x01+0x20/0x30 [hello]
  [<900000000022097c>] do_one_initcall+0x88/0x288
  [<90000000002df890>] do_init_module+0x54/0x200
  [<90000000002e1e18>] __do_sys_finit_module+0xc4/0x114
  [<90000000013382e8>] do_syscall+0x7c/0x94
  [<9000000000221e3c>] handle_syscall+0xbc/0x158

With this patch:

  [root@linux hello]# insmod hello.ko
  [root@linux hello]# dmesg
  ...
  Hello, world
  This is a test
  ...
  Call Trace:
  [<9000000000223728>] show_stack+0x68/0x18c
  [<90000000013374cc>] dump_stack_lvl+0x60/0x88
  [<ffff800002050028>] test_func+0x28/0x34 [hello]
  [<ffff800002058028>] hello_init+0x28/0x38 [hello]
  [<900000000022097c>] do_one_initcall+0x88/0x288
  [<90000000002df890>] do_init_module+0x54/0x200
  [<90000000002e1e18>] __do_sys_finit_module+0xc4/0x114
  [<90000000013382e8>] do_syscall+0x7c/0x94
  [<9000000000221e3c>] handle_syscall+0xbc/0x158

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/module_symbol.h | 4 +++-
 kernel/module/kallsyms.c      | 2 +-
 scripts/mod/modpost.c         | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 9fa4173..7ace7ba 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -3,10 +3,12 @@
 #define _LINUX_MODULE_SYMBOL_H
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline int is_arm_mapping_symbol(const char *str)
+static inline int is_mapping_symbol(const char *str)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
+	if (str[0] == 'L' && str[1] == '0')
+		return true;
 	return str[0] == '$' &&
 	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
 	       && (str[2] == '\0' || str[2] == '.');
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 5de3207..d8e426a 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7241db8..5cddf76 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1115,7 +1115,7 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 
 /*
  * If there's no name there, ignore it; likewise, ignore it if it's
- * one of the magic symbols emitted used by current ARM tools.
+ * one of the magic symbols emitted used by current tools.
  *
  * Otherwise if find_symbols_between() returns those symbols, they'll
  * fail the whitelist tests and cause lots of false alarms ... fixable
@@ -1128,7 +1128,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return 0;
-	return !is_arm_mapping_symbol(name);
+	return !is_mapping_symbol(name);
 }
 
 /**
-- 
2.1.0

