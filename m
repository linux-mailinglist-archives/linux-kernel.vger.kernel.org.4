Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E16B5893
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCKFSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCKFRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA72140504;
        Fri, 10 Mar 2023 21:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZY//fx8IeJdbSxcbOUOAnU2iye6f3fGZL3terh5yTNM=; b=kQ0AiR8Rpv7J2YhZneYg7LT6AC
        Q6NR6JU6hUmVKCsYc7b9PwJsrGYO9wnUBolBzYLbcVwXqXD/zOK58BudkyytWw1anwsYJTXnXpHRw
        36xom8gyxgnuHkZcvYIjT9+CqSVM17zeT/OGov9K+6IIhdCDg6g/nWwoiuC2qzoZ27oBNddkDtgHh
        Y6gztygIaSBYd+50ligy7bN0eiaj30VPO+7Z7IGRRJA/nFsdZbnJQEwBCs+BgVYR+Ga0CE9qNJzFE
        mkb8RXBq/I/FpZ0rUW5owMarB7kPG6rmnl2vlV/w5IORVpu4uVLCe98ZeQp6JOgU2wOQU9K03YNqc
        awL0iiig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBMy-7A; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 05/12] module: add debugging alias parsing support
Date:   Fri, 10 Mar 2023 21:17:05 -0800
Message-Id: <20230311051712.4095040-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230311051712.4095040-1-mcgrof@kernel.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have in-kernel alias parsing support as aliases are all
dealt with in userspace. There has simply been no need to have
support for processing them in kernel. We have done this under
the assumption that userspace just Does The Right Thing (TM) about
aliases and loading modules and that there is no real gain of
processing aliases in-kernel.

Obviously userspace can be buggy though, and it can lie to us. We
currently have no easy way to determine this. Parsing aliases is
an example debugging facility we can use to help with these sorts
of problems.

But there are some possible optimizations that may also be possible
and enabling support let's folks experiment with these posibilities.

We disable this by default but folks can also enable this to
experiment with features which may use aliases in-kernel. Folks
should not enable this on production kernels. It'll bloat your
loaded kernel modules a tiny bit by the size of the aliases that
exist for them once loaded.

You can debug aliase by adding to your dynamic debug:

GRUB_CMDLINE_LINUX_DEFAULT="dyndbg=\"func module_process_aliases +p;\" "

Upon boot for example here a few entries:

module ext4 num_aliases: 5
alias[0] = fs-ext4
alias[1] = ext3
alias[2] = fs-ext3
alias[3] = ext2
alias[4] = fs-ext2

module xfs num_aliases: 1
alias[0] = fs-xfs

module floppy num_aliases: 3
alias[0] = block-major-2-*
alias[1] = acpi*:PNP0700:*
alias[2] = pnp:dPNP0700*

module ata_piix num_aliases: 89
alias[0] = pci:v00008086d00008C81sv*sd*bc*sc*i*
alias[1] = pci:v00008086d00008C80sv*sd*bc*sc*i*
alias[2] = pci:v00008086d00008C89sv*sd*bc*sc*i*
alias[3] = pci:v00008086d00008C88sv*sd*bc*sc*i*
... etc ...

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/module.h   |  4 ++
 kernel/module/Kconfig    | 19 +++++++++
 kernel/module/Makefile   |  1 +
 kernel/module/aliases.c  | 92 ++++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h | 15 +++++++
 kernel/module/main.c     | 17 ++++++--
 6 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 kernel/module/aliases.c

diff --git a/include/linux/module.h b/include/linux/module.h
index c3b357196470..aed1b43edb55 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -420,6 +420,10 @@ struct module {
 	const char *srcversion;
 	struct kobject *holders_dir;
 
+#ifdef CONFIG_MODULE_KERNEL_ALIAS
+	unsigned int num_aliases;
+	const char **aliases;
+#endif
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
 	const s32 *crcs;
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 424b3bc58f3f..e4ba335fa279 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -22,6 +22,25 @@ menuconfig MODULES
 
 if MODULES
 
+config MODULE_DEBUG
+	bool "Enable debugging information for modules"
+	default n
+	help
+	  Enables debugging of the module infrastructure. Say no unless you
+	  are debugging the module framework. Don't enable this on production.
+	  This is only for experimentation and debugging.
+
+config MODULE_KERNEL_ALIAS
+	bool "Enable in-kernel alias processing for modules"
+	default n
+	depends on MODULE_DEBUG
+	help
+	  The kernel has historically not processed aliases in-kernel since
+	  we expect userspace can do all the proper work for us. Enable this
+	  if you want to experiment processing aliases in-kernel. This will
+	  bloat your kernel modules's memory by the number of aliases each
+	  module has once loaded into the kernel.
+
 config MODULE_FORCE_LOAD
 	bool "Forced module loading"
 	default n
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 948efea81e85..34f0db0a016b 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
+obj-$(CONFIG_MODULE_KERNEL_ALIAS) += aliases.o
diff --git a/kernel/module/aliases.c b/kernel/module/aliases.c
new file mode 100644
index 000000000000..2f30c9d4c765
--- /dev/null
+++ b/kernel/module/aliases.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Optional module in-kernel alias processing support.
+ *
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ */
+
+#include <linux/module.h>
+#include "internal.h"
+
+void free_mod_aliases(struct module *mod)
+{
+	unsigned int i;
+
+	if (!mod->num_aliases)
+		return;
+
+	for (i=0; i < mod->num_aliases; i++) {
+		kfree(mod->aliases[i]);
+		mod->aliases[i] = NULL;
+	}
+
+	kfree(mod->aliases);
+	mod->aliases = NULL;
+}
+
+static int get_modinfo_tags(struct load_info *info,
+			    const char *tag,
+			    unsigned int *num_entries)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+	Elf_Shdr *infosec = &info->sechdrs[info->index.info];
+	unsigned long size = infosec->sh_size;
+	const char *value;
+	unsigned int len, tags_size = 0;
+
+	for (p = (char *)infosec->sh_addr; p; p = module_next_tag_pair(p, &size)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=') {
+			value = p + taglen + 1;
+			len = strlen(value);
+			if (len >=0 && len <= PAGE_SIZE) {
+				(*num_entries)++;
+				tags_size+=len;
+			}
+		}
+	}
+
+	return tags_size;
+}
+
+int module_process_aliases(struct module *mod, struct load_info *info)
+{
+	unsigned int size, i = 0, num_entries = 0;
+	char *alias;
+
+	size = get_modinfo_tags(info, "alias", &num_entries);
+	if (WARN_ON(!size))
+		return 0;
+
+	mod->aliases = kzalloc(num_entries * sizeof(char *), GFP_KERNEL);
+	if (!mod->aliases)
+		return -ENOMEM;
+
+	pr_debug("module %s num_aliases: %u\n", mod->name, num_entries);
+
+	for_each_modinfo_entry(alias, info, "alias") {
+		pr_debug("alias[%u] = %s\n", i, alias);
+		mod->aliases[i] = kasprintf(GFP_KERNEL, "%s", alias);
+		if (!mod->aliases[i])
+			goto err_free;
+		i++;
+	}
+
+	WARN_ON(i != num_entries);
+
+	mod->num_aliases = num_entries;
+
+	return 0;
+
+err_free:
+	while (i!=0) {
+		i--;
+		kfree(mod->aliases[i]);
+		mod->aliases[i] = NULL;
+	}
+
+	kfree(mod->aliases);
+	mod->aliases = NULL;
+
+	return -ENOMEM;
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 6ae29bb8836f..40bb80ed21e2 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -96,6 +96,8 @@ long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
 char *module_flags(struct module *mod, char *buf, bool show_state);
 size_t module_flags_taint(unsigned long taints, char *buf);
 
+char *get_modinfo(const struct load_info *info, const char *tag);
+char *get_next_modinfo(const struct load_info *info, const char *tag, char *prev);
 char *module_next_tag_pair(char *string, unsigned long *secsize);
 
 #define for_each_modinfo_entry(entry, info, name) \
@@ -300,3 +302,16 @@ static inline int same_magic(const char *amagic, const char *bmagic, bool has_cr
 	return strcmp(amagic, bmagic) == 0;
 }
 #endif /* CONFIG_MODVERSIONS */
+
+#ifdef CONFIG_MODULE_KERNEL_ALIAS
+void free_mod_aliases(struct module *mod);
+int module_process_aliases(struct module *mod, struct load_info *info);
+#else
+static void free_mod_aliases(struct module *mod)
+{
+}
+static int module_process_aliases(struct module *mod, struct load_info *info)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULE_KERNEL_ALIAS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 3f7c8634cf06..16770942f33a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2002 Richard Henderson
  * Copyright (C) 2001 Rusty Russell, 2002, 2010 Rusty Russell IBM.
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
  */
 
 #define INCLUDE_VERMAGIC
@@ -1035,8 +1036,7 @@ char *module_next_tag_pair(char *string, unsigned long *secsize)
 	return string;
 }
 
-static char *get_next_modinfo(const struct load_info *info, const char *tag,
-			      char *prev)
+char *get_next_modinfo(const struct load_info *info, const char *tag, char *prev)
 {
 	char *p;
 	unsigned int taglen = strlen(tag);
@@ -1061,7 +1061,7 @@ static char *get_next_modinfo(const struct load_info *info, const char *tag,
 	return NULL;
 }
 
-static char *get_modinfo(const struct load_info *info, const char *tag)
+char *get_modinfo(const struct load_info *info, const char *tag)
 {
 	return get_next_modinfo(info, tag, NULL);
 }
@@ -1289,6 +1289,7 @@ static void free_module(struct module *mod)
 	module_arch_freeing_init(mod);
 	kfree(mod->args);
 	percpu_modfree(mod);
+	free_mod_aliases(mod);
 
 	free_mod_mem(mod);
 }
@@ -1989,6 +1990,12 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 			"is unknown, you have been warned.\n", mod->name);
 	}
 
+	if (get_modinfo(info, "alias")) {
+		err = module_process_aliases(mod, info);
+		if (err)
+			goto err_out_skip_alloc;
+	}
+
 	err = check_modinfo_livepatch(mod, info);
 	if (err)
 		goto err_out;
@@ -2005,6 +2012,8 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 
 	return 0;
 err_out:
+	free_mod_aliases(mod);
+err_out_skip_alloc:
 	return err;
 }
 
@@ -2329,6 +2338,7 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	kmemleak_load_module(mod, info);
 	return mod;
 err_out:
+	free_mod_aliases(mod);
 	return ERR_PTR(err);
 }
 
@@ -2890,6 +2900,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	synchronize_rcu();
 	mutex_unlock(&module_mutex);
  free_module:
+	free_mod_aliases(mod);
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	for_class_mod_mem_type(type, core_data) {
 		lockdep_free_key_range(mod->mem[type].base,
-- 
2.39.1

