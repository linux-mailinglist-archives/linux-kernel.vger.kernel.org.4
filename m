Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946C76C058D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCSV2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCSV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:27:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488011B2D3;
        Sun, 19 Mar 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J5+PTL3UiSHXzOIaCcjJ/nf03t7Vym4klhpDlvyr5mo=; b=eYLW42ks3Vsi848lIP3xFkc82R
        j3TW7LIFItJXnL2NWT83irEvyaPAj63MucP2yOCIcFKeYOBQfS1TC33HV0yyd5IsdleHESkLioCfD
        FF47ywU8VND3qODu96jtuv9JrrJVsuqpz3gFpN73LfEXKY0ebHKiiLLo+NeGIR8pOmSMUvUO7g3aD
        xdNQz5DTR1p7U1lQHirv+GbzdW1tcmiyyT0OOhFOqjgSgXNI5ft5LvjBV7OB/W95HHJqHO1jaaCbL
        sRnr+gFquGE0mZTtQPyY3zhAMWV72aQqmGG0ZCzxw3J+zxyOZH2WDclPrP191GGfxojk62NMnsnDn
        oeujcASQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0Z9-007TrD-2y;
        Sun, 19 Mar 2023 21:27:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH 08/12] module: split taint adding with info checking
Date:   Sun, 19 Mar 2023 14:27:42 -0700
Message-Id: <20230319212746.1783033-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_modinfo() actually does two things:

 a) sanity checks, some of which are fatal, and so we
    prevent the user from completing trying to load a module
 b) taints the kernel

The taints are pretty heavy handed because we're tainting the kernel
*before* we ever even get to load the module into the modules linked
list. That is, it it can fail for other reasons later as we review the
module's structure.

But this commit makes no functional changes, it just makes the intent
clearer and splits the code up where needed to make that happen.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index cfb2ff5185fe..a3953ca18090 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1951,25 +1951,10 @@ static int setup_load_info(struct load_info *info, int flags)
 	return 0;
 }
 
-static int check_modinfo(struct module *mod, struct load_info *info, int flags)
+/*
+ * These calls taint the kernel depending certain module circumstances */
+static void module_augment_kernel_taints(struct module *mod, struct load_info *info)
 {
-	const char *modmagic = get_modinfo(info, "vermagic");
-	int err;
-
-	if (flags & MODULE_INIT_IGNORE_VERMAGIC)
-		modmagic = NULL;
-
-	/* This is allowed: modprobe --force will invalidate it. */
-	if (!modmagic) {
-		err = try_to_force_load(mod, "bad vermagic");
-		if (err)
-			return err;
-	} else if (!same_magic(modmagic, vermagic, info->index.vers)) {
-		pr_err("%s: version magic '%s' should be '%s'\n",
-		       info->name, modmagic, vermagic);
-		return -ENOEXEC;
-	}
-
 	if (!get_modinfo(info, "intree")) {
 		if (!test_taint(TAINT_OOT_MODULE))
 			pr_warn("%s: loading out-of-tree module taints kernel.\n",
@@ -1985,15 +1970,12 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 			"is unknown, you have been warned.\n", mod->name);
 	}
 
-	err = check_modinfo_livepatch(mod, info);
-	if (err)
-		return err;
-
 	if (is_livepatch_module(mod)) {
 		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
 		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
 				mod->name);
 	}
+
 	module_license_taint_check(mod, get_modinfo(info, "license"));
 
 	if (get_modinfo(info, "test")) {
@@ -2002,6 +1984,42 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 				mod->name);
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
+}
+
+static int check_modinfo(struct module *mod, struct load_info *info, int flags)
+{
+	const char *modmagic = get_modinfo(info, "vermagic");
+	int err;
+
+	if (flags & MODULE_INIT_IGNORE_VERMAGIC)
+		modmagic = NULL;
+
+	/* This is allowed: modprobe --force will invalidate it. */
+	if (!modmagic) {
+		err = try_to_force_load(mod, "bad vermagic");
+		if (err)
+			return err;
+	} else if (!same_magic(modmagic, vermagic, info->index.vers)) {
+		pr_err("%s: version magic '%s' should be '%s'\n",
+		       info->name, modmagic, vermagic);
+		return -ENOEXEC;
+	}
+
+	err = check_modinfo_livepatch(mod, info);
+	if (err)
+		return err;
+
+	/*
+	 * We are tainting your kernel *even* if you try to load
+	 * modules with possible taints and we fail to load these
+	 * modules for other reasons.
+	 *
+	 * We have a descrepancy though, see the other taints for
+	 * signature and those in check_module_license_and_versions().
+	 *
+	 * We should compromise and converge.
+	 */
+	module_augment_kernel_taints(mod, info);
 
 	return 0;
 }
-- 
2.39.1

