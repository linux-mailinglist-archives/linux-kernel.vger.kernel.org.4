Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB6732A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjFPIxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjFPIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D630C1;
        Fri, 16 Jun 2023 01:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58478627FC;
        Fri, 16 Jun 2023 08:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BDBC433B7;
        Fri, 16 Jun 2023 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686905576;
        bh=SlBOw3U7lsp9qLHlWO7lhIx8iQG/0zpTGMZK7G5/it8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYgQUzoC3B593p/Dgn3+TPdeozzDLlm25AwOJLKar+VYJDrbbr1SdOshPlvaqnZ8s
         oK4MqcxpbnUG6MN7D2/qW05fsNi7mGmQ8dkORzT35xnDbj/W36F4FOLgzNY6M4PcNO
         R3dJCpZ2E2H3cOtS1aHqXGRpmTKYKqXX++q6sKyIgoNy1Dep39n7ShkhJ3lsnlw8th
         aR1/N9N5ytcJ2bDrtfUkFPDUA8Szf79x0wrzFCuYoJoIX5C0i1dhO9TiZnBW1OemBT
         RXhSF4tkazIA43z1geCwwCrTDTs/h4A7kL6naX8kmJ5EqzOEA8QYfISw3S41ve05F0
         LFf/ib3wO4hbg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 12/12] kprobes: remove dependcy on CONFIG_MODULES
Date:   Fri, 16 Jun 2023 11:50:38 +0300
Message-Id: <20230616085038.4121892-13-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230616085038.4121892-1-rppt@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

kprobes depended on CONFIG_MODULES because it has to allocate memory for
code.

Since code allocations are now implemented with execmem, kprobes can be
enabled in non-modular kernels.

Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
dependency of CONFIG_KPROBES on CONFIG_MODULES.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/Kconfig                |  2 +-
 kernel/kprobes.c            | 43 +++++++++++++++++++++----------------
 kernel/trace/trace_kprobe.c | 11 ++++++++++
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..f2e9f82c7d0d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -39,9 +39,9 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
+	select EXECMEM
 	select TASKS_RCU if PREEMPTION
 	help
 	  Kprobes allows you to trap at almost any kernel address and
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 37c928d5deaf..2c2ba29d3f9a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1568,6 +1568,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
+#ifdef CONFIG_MODULES
 	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
@@ -1591,6 +1592,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			ret = -ENOENT;
 		}
 	}
+#endif
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2484,24 +2487,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
-/* Remove all symbols in given area from kprobe blacklist */
-static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
-{
-	struct kprobe_blacklist_entry *ent, *n;
-
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
-		if (ent->start_addr < start || ent->start_addr >= end)
-			continue;
-		list_del(&ent->list);
-		kfree(ent);
-	}
-}
-
-static void kprobe_remove_ksym_blacklist(unsigned long entry)
-{
-	kprobe_remove_area_blacklist(entry, entry + 1);
-}
-
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
 {
@@ -2566,6 +2551,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
+/* Remove all symbols in given area from kprobe blacklist */
+static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
+{
+	struct kprobe_blacklist_entry *ent, *n;
+
+	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+		if (ent->start_addr < start || ent->start_addr >= end)
+			continue;
+		list_del(&ent->list);
+		kfree(ent);
+	}
+}
+
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2667,6 +2671,7 @@ static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
 	.priority = 0
 };
+#endif
 
 void kprobe_free_init_mem(void)
 {
@@ -2726,8 +2731,10 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
+#ifdef CONFIG_MODULES
 	if (!err)
 		err = register_module_notifier(&kprobe_module_nb);
+#endif
 
 	kprobes_initialized = (err == 0);
 	kprobe_sysctls_init();
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..cf804e372554 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
 	char *p;
@@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+static inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
+{
+	return false;
+}
+#endif
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
 	.priority = 1	/* Invoked after kprobe module callback */
 };
+#endif
 
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
@@ -1797,8 +1806,10 @@ static __init int init_kprobe_trace_early(void)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_MODULES
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
+#endif
 
 	return 0;
 }
-- 
2.35.1

