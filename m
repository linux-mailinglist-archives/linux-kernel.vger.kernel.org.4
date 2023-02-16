Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10101699B13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBPRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBPRQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:16:55 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29484AFD2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:16:53 -0800 (PST)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 31GBjOPv016951;
        Thu, 16 Feb 2023 17:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=jan2016.eng;
 bh=2fig0jqcoh6eh1wbpJH9nWftw+MtZ+Zq0rdqCN+wjqk=;
 b=OD5w4De1t+R2dvlw+IEWGsUXJTnmWY6Iw6wIxB+Y5p3spF51082HHTKWBuXg2Gnq62Ov
 Ggo/Ox0XNdzKdmqkPZ26QHCAEGz6ZgSCSA9itKNaGiZSpoJ1oAx4WNImb1DhgSjEYIC0
 ceSftvMI8ITIV71SeBV0NWaZPU2ZMrrstIkNVbZ8xUwnUdtiM2u/lHe89eVn/Wk88XFV
 aPCw5LCaGkO5yvqLDMnIJDQa+BU3IoTKjvp9osA/po4FEKCe9hWjC+z++sxNYQmuiLOr
 JXIa6DKq+ND8H98rxfzNX4K81F0avaDOspSfXvBoTCWgnF3XVS5NS1DCkzVDaW8aKMTi 0w== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 3np3efm0qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:16:15 +0000
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31GGUQJO023971;
        Thu, 16 Feb 2023 12:16:13 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 3np783eu9q-1;
        Thu, 16 Feb 2023 12:16:13 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 260C86024D;
        Thu, 16 Feb 2023 17:16:13 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jim.cromie@gmail.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] dyndbg: use the module notifier callbacks
Date:   Thu, 16 Feb 2023 12:15:51 -0500
Message-Id: <1881b5dc29fc7a0862e2d0b3b598b2365157e56f.1676566871.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1676566871.git.jbaron@akamai.com>
References: <cover.1676566871.git.jbaron@akamai.com>
In-Reply-To: <cover.1676566871.git.jbaron@akamai.com>
References: <cover.1676566871.git.jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=813 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160148
X-Proofpoint-ORIG-GUID: S-uuvlVsBUO6jgvpgZ79VIoB9lCkStsx
X-Proofpoint-GUID: S-uuvlVsBUO6jgvpgZ79VIoB9lCkStsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=735 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of Jim Cromie's new dynamic debug classmap feature, the new code
tries to toggle a jump label from dynamic_debug_setup(). However,
dynamic_debug_setup() is called before the 'module_notify_list' notifier
chain is invoked. And jump labels are initialized via the module notifier
chain. Note this is an issue for a new feature not yet merged and doesn't
affect any existing codepaths.

We could just move dynamic_debug_setup() earlier in load_module(). But
let's instead ensure the ordering via the 'priority' in the module list
notifier. This brings dynamic debug more in line with other subsystems and
pulls code out of the core module code.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
CC: Jim Cromie <jim.cromie@gmail.com>
Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gmail.com/
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 include/linux/dynamic_debug.h | 13 ----------
 include/linux/module.h        |  3 +++
 kernel/module/internal.h      |  1 -
 kernel/module/main.c          | 30 ++++++----------------
 lib/dynamic_debug.c           | 48 +++++++++++++++++++++++++++++------
 5 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 41682278d2e8..f401414341fb 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -130,9 +130,6 @@ struct ddebug_class_param {
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-int ddebug_add_module(struct _ddebug_info *dyndbg, const char *modname);
-
-extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -304,16 +301,6 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp);
 #include <linux/errno.h>
 #include <linux/printk.h>
 
-static inline int ddebug_add_module(struct _ddebug_info *dinfo, const char *modname)
-{
-	return 0;
-}
-
-static inline int ddebug_remove_module(const char *mod)
-{
-	return 0;
-}
-
 static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 						const char *modname)
 {
diff --git a/include/linux/module.h b/include/linux/module.h
index 8c5909c0076c..b122d6a2621a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -546,6 +546,9 @@ struct module {
 	struct error_injection_entry *ei_funcs;
 	unsigned int num_ei_funcs;
 #endif
+#ifdef CONFIG_DYNAMIC_DEBUG_CORE
+	struct _ddebug_info dyndbg_info;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f558..e6866cc7c448 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -63,7 +63,6 @@ struct load_info {
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
-	struct _ddebug_info dyndbg;
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4ac3fe43e6c8..cd5e401e4dc3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1157,9 +1157,6 @@ static void free_module(struct module *mod)
 	mod->state = MODULE_STATE_UNFORMED;
 	mutex_unlock(&module_mutex);
 
-	/* Remove dynamic debug info */
-	ddebug_remove_module(mod->name);
-
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1591,19 +1588,6 @@ static void free_modinfo(struct module *mod)
 	}
 }
 
-static void dynamic_debug_setup(struct module *mod, struct _ddebug_info *dyndbg)
-{
-	if (!dyndbg->num_descs)
-		return;
-	ddebug_add_module(dyndbg, mod->name);
-}
-
-static void dynamic_debug_remove(struct module *mod, struct _ddebug_info *dyndbg)
-{
-	if (dyndbg->num_descs)
-		ddebug_remove_module(mod->name);
-}
-
 void * __weak module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
@@ -2109,10 +2093,14 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->dyndbg.descs = section_objs(info, "__dyndbg",
-					sizeof(*info->dyndbg.descs), &info->dyndbg.num_descs);
-	info->dyndbg.classes = section_objs(info, "__dyndbg_classes",
-					sizeof(*info->dyndbg.classes), &info->dyndbg.num_classes);
+#ifdef CONFIG_DYNAMIC_DEBUG_CORE
+	mod->dyndbg_info.descs = section_objs(info, "__dyndbg",
+					      sizeof(*mod->dyndbg_info.descs),
+					      &mod->dyndbg_info.num_descs);
+	mod->dyndbg_info.classes = section_objs(info, "__dyndbg_classes",
+						sizeof(*mod->dyndbg_info.classes),
+						&mod->dyndbg_info.num_classes);
+#endif
 
 	return 0;
 }
@@ -2824,7 +2812,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	init_build_id(mod, info);
-	dynamic_debug_setup(mod, &info->dyndbg);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
 	ftrace_module_init(mod);
@@ -2888,7 +2875,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
  ddebug_cleanup:
 	ftrace_release_mod(mod);
-	dynamic_debug_remove(mod, &info->dyndbg);
 	synchronize_rcu();
 	kfree(mod->args);
  free_arch_cleanup:
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8136e5236b7b..6f60a5485be5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1223,7 +1223,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int __ddebug_add_module(struct _ddebug_info *di, const char *modname)
+static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
@@ -1262,11 +1262,6 @@ static int __ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	return 0;
 }
 
-int ddebug_add_module(struct _ddebug_info *di, const char *modname)
-{
-	return __ddebug_add_module(di, modname);
-}
-
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
 				const char *modname, int on_err)
@@ -1336,6 +1331,35 @@ int ddebug_remove_module(const char *mod_name)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
+
+static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
+				void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		if (ret)
+			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
+		break;
+	case MODULE_STATE_GOING:
+		ddebug_remove_module(mod->name);
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block ddebug_module_nb = {
+	.notifier_call = ddebug_module_notify,
+	.priority = 0, /* dynamic debug depends on jump label */
+};
+
+#endif /* CONFIG_MODULES */
+
 static void ddebug_remove_all_tables(void)
 {
 	mutex_lock(&ddebug_lock);
@@ -1387,6 +1411,14 @@ static int __init dynamic_debug_init(void)
 		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
 	};
 
+#ifdef CONFIG_MODULES
+	ret = register_module_notifier(&ddebug_module_nb);
+	if (ret) {
+		pr_warn("Failed to register dynamic debug module notifier\n");
+		return ret;
+	}
+#endif /* CONFIG_MODULES */
+
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1407,7 +1439,7 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
-			ret = __ddebug_add_module(&di, modname);
+			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
 
@@ -1418,7 +1450,7 @@ static int __init dynamic_debug_init(void)
 	}
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
-	ret = __ddebug_add_module(&di, modname);
+	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.17.1

