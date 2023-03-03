Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084166A9C61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCCQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjCCQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:50 -0500
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9382183C8;
        Fri,  3 Mar 2023 08:51:28 -0800 (PST)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 323GI3sL020378;
        Fri, 3 Mar 2023 16:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=jan2016.eng;
 bh=KEFs7Fk0Kw2ubyBISXhKMRHTGHS2W4tBetXrMtrsYrs=;
 b=XrQ2Cj1GuUiZK4+44sGj5S++N78nkCR3bOyNB7NBeryaZ7Z7nh8soP+4UmDqbBFkyP0R
 4HNnVukAIzyitMB+ogouF6yx+jZ14IB9boDoEA/2uihbReLn/AiXJZvN7jk80m4fXrc1
 Oc0foYw6rnslIIikjZITQ9jLpPedI21FNoMnwSfVOrLmMlF79itM2xSfgj0Oh1ZdTZ3+
 Cb3dXUuUjSmt0H6X1kEx+7b2/q7IJAXQzv8pkNDgme493Km6A/pAGNTXboTSfRo3Ni2+
 rTsuMFwuKXt02+8hCNQQ6TyEq0q/YURBSii06D3xmjEaOkB2zjZKS4WhxbOsl4mLJvhV 0g== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3ny89sh7jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 16:51:14 +0000
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 323FR81b030874;
        Fri, 3 Mar 2023 11:51:13 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3nyej459am-1;
        Fri, 03 Mar 2023 11:51:13 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 428C33095C;
        Fri,  3 Mar 2023 16:51:13 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     mcgrof@kernel.org
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 2/2] dyndbg: use the module notifier callbacks
Date:   Fri,  3 Mar 2023 11:50:56 -0500
Message-Id: <5884c688d10c9703fb0457f8839d6becc8657f8f.1677861177.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1677861177.git.jbaron@akamai.com>
References: <cover.1677861177.git.jbaron@akamai.com>
In-Reply-To: <cover.1677861177.git.jbaron@akamai.com>
References: <cover.1677861177.git.jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=676 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030146
X-Proofpoint-GUID: vqrfJrNj83GwFmnpiA_wFHaZgdDKNJtY
X-Proofpoint-ORIG-GUID: vqrfJrNj83GwFmnpiA_wFHaZgdDKNJtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=645 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030145
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring dynamic debug in line with other subsystems by using the module
notifier callbacks. This results in a net decrease in core module
code.

Additionally, Jim Cromie has a new dynamic debug classmap feature,
which requires that jump labels be initialized prior to dynamic debug.
Specifically, the new feature toggles a jump label from the existing
dynamic_debug_setup() function. However, this does not currently work
properly, because jump labels are initialized via the
'module_notify_list' notifier chain, which is invoked after the
current call to dynamic_debug_setup(). Thus, this patch ensures that
jump labels are initialized prior to dynamic debug by setting the
dynamic debug notifier priority to 0, while jump labels have the
higher priority of 1.

Tested by Jim using his new test case, and I've verfied the correct
printing via: # modprobe test_dynamic_debug dyndbg.

Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gmail.com/
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/
Tested-by: Jim Cromie <jim.cromie@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
CC: Jim Cromie <jim.cromie@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 include/linux/dynamic_debug.h | 13 ---------
 include/linux/module.h        |  4 +++
 kernel/module/internal.h      |  2 --
 kernel/module/main.c          | 30 ++++++---------------
 lib/dynamic_debug.c           | 50 ++++++++++++++++++++++++++++-------
 5 files changed, 53 insertions(+), 46 deletions(-)

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
index 5475ec30c331..3ae8a567ed5f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,6 +27,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
+#include <linux/dynamic_debug.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -579,6 +580,9 @@ struct module {
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
index c6c44ceca07a..e3883b7d4840 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -45,7 +45,6 @@ extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const s32 __start___kcrctab[];
 extern const s32 __start___kcrctab_gpl[];
 
-#include <linux/dynamic_debug.h>
 struct load_info {
 	const char *name;
 	/* pointer to module in temporary copy, freed at end of load_module() */
@@ -55,7 +54,6 @@ struct load_info {
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
-	struct _ddebug_info dyndbg;
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fa529668a45..b4759f1695b7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1216,9 +1216,6 @@ static void free_module(struct module *mod)
 	mod->state = MODULE_STATE_UNFORMED;
 	mutex_unlock(&module_mutex);
 
-	/* Remove dynamic debug info */
-	ddebug_remove_module(mod->name);
-
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -1619,19 +1616,6 @@ static void free_modinfo(struct module *mod)
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
@@ -2137,10 +2121,14 @@ static int find_module_sections(struct module *mod, struct load_info *info)
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
index 8136e5236b7b..fdd6d9800a70 100644
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
@@ -1313,11 +1308,13 @@ static void ddebug_table_free(struct ddebug_table *dt)
 	kfree(dt);
 }
 
+#ifdef CONFIG_MODULES
+
 /*
  * Called in response to a module being unloaded.  Removes
  * any ddebug_table's which point at the module.
  */
-int ddebug_remove_module(const char *mod_name)
+static int ddebug_remove_module(const char *mod_name)
 {
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
@@ -1336,6 +1333,33 @@ int ddebug_remove_module(const char *mod_name)
 	return ret;
 }
 
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

