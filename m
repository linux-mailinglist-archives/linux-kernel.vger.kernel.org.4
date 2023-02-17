Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18369A329
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBQAxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQAxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:53:01 -0500
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA27DAB;
        Thu, 16 Feb 2023 16:52:49 -0800 (PST)
X-QQ-mid: bizesmtp76t1676594981tzj20bxn
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Feb 2023 08:49:37 +0800 (CST)
X-QQ-SSF: 01200000000000C0T000000A0000000
X-QQ-FEAT: HH6/KuQOBEYape0K7eNPpGClNte1p9KwHz5G63svXw4+DTBNwFMoPpE5XUhx6
        05cCvEABd10oan5cv3LUnUMcUAHqyNqZq4+jTSCoUmilAXTQ9duURc8/ruw7SY6oor0tBev
        RoFEB3fWfD1W8TD67x5MtiQ+DjwwcYO78oT04ndKAyzBOChBjxfUcAYeQ4FX5k0S5OoK8Ox
        gFEhgXjlsxlrY99cZIG/3rP3A79PqE/96cPTSu6w0R+hXn7r4u9vMv+S2yzV/ofwTvSCq12
        zwDKb63xgVmxw+JXjn9VgOf31CWsu7Tgnd7untYTG8+Nkyy+99r1iatC9zrXPQh7OdEa1UY
        DB2saWPTsE8kVbMerbuqMOpDMVViphDIwHBwBVQOPZPg8P/98pX6ELE5xO/vKjwq+wBju5K
        sOzMCFPNoHQ=
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmer@rivosinc.com>, Willy Tarreau <w@1wt.eu>,
        Paul Burton <paulburton@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [RFC PATCH 2/5] MIPS: Add dead syscalls elimination support
Date:   Fri, 17 Feb 2023 08:49:22 +0800
Message-Id: <29e5a037ac439c40970b40692286feb6f010f8f3.1676594211.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1676594211.git.falcon@tinylab.org>
References: <cover.1676594211.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By enabling CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION and setting
CONFIG_SYSCALLS_USED, It is able to remove the left 'dead' syscalls.

For example, if setting CONFIG_SYSCALLS_USED="write exit reboot", a
'used' variant of the *.tbl will be generated, accordingly, the kernel
api unistd_nr_*.h and syscall_table_*.h will be generated from the
'used' *tbl variant. the user api version of unistd_*.h is reserved
as-is.

Here is a test result on qemu with a minimal malta config.

                    | mipsel malta    | config
    ----------------|-----------------|-------------------
            vmlinux | 5041628         | https://pastebin.com/0bE2ibLD
      + gc-sections | 4474060 (-11.2%)| CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
    + syscalls_used | 4265280 (-4.67%)| CONFIG_SYSCALLS_USED="_newselect"
    + syscalls_used | 4274364 (-4.46%)| CONFIG_SYSCALLS_USED="write exit reboot"

notes:

- The shrink ratios of the syscalls_used lines are based on the
  gc-sections line.

- "write exit reboot" are used by a hello.c to simply print "Hello,
   World!", exit and shutdown qemu.

- "_newselect" is used by rcutorture to do a long-time sleep.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/mips/Kconfig                  |  1 +
 arch/mips/kernel/syscalls/Makefile | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 15cb692b0a09..868d9a871b3e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -102,6 +102,7 @@ config MIPS
 	select TRACE_IRQFLAGS_SUPPORT
 	select ARCH_HAS_ELFCORE_COMPAT
 	select HAVE_ARCH_KCSAN if 64BIT
+	select HAVE_SYSCALLS_USED
 
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index e6b21de65cca..8ffba5301cf0 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -26,10 +26,30 @@ sysnr_pfx_unistd_nr_n32 := N32
 sysnr_pfx_unistd_nr_n64 := 64
 sysnr_pfx_unistd_nr_o32 := O32
 
-$(kapi)/unistd_nr_%.h: $(src)/syscall_%.tbl $(sysnr) FORCE
+ifdef CONFIG_SYSCALLS_USED
+syscalls_used := $(shell echo $(CONFIG_SYSCALLS_USED) | tr -s ' ' | tr ' ' '|')
+endif
+
+ifneq ($(syscalls_used),)
+utbl := arch/$(SRCARCH)/include/generated/tbl
+_tbl := $(src)/syscall_%.tbl
+ tbl := $(utbl)/syscall_used_%.tbl
+
+$(shell mkdir -p $(utbl))
+
+quiet_cmd_used = USED    $@
+      cmd_used = sed -E -e "/^[0-9]*[[:space:]]/{/(^($(syscalls_used))[[:space:]]|[[:space:]]($(syscalls_used))[[:space:]]|[[:space:]]($(syscalls_used))$$)/!{s/^/\#/g}}" $< > $@;
+
+$(tbl): $(_tbl) $(objtree)/.config
+	$(call cmd,used)
+else
+tbl := $(src)/syscall_%.tbl
+endif
+
+$(kapi)/unistd_nr_%.h: $(tbl) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(tbl) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
-- 
2.25.1

