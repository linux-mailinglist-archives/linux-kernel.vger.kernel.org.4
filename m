Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDF6B5892
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCKFS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCKFRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:17:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836114050B;
        Fri, 10 Mar 2023 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pxTUOVx9i1JFOyCPATR0il1cHRcDZ89gN6jPm1YO3X8=; b=1KBw30U8YggjwHFTZnlXveoHDd
        GHJ64T+dUK7GtsvB5Dhia8zLF/jfDFwlRiLp+6PdSDaNqL3UFUTQR7u6gcYa4F+8LfXZjmD7Ulzr8
        g6+S+A0gCudBGun8jhkiKPTyR5Tk4dr3G0WXRF7ecWP459aKYrZt48opPxV52Y5p7744catjlqhom
        d8O4k7pfZau8Q2dolG+oPgU38RF+RfkFOcedICrOivuPfNbAQ8LQ/nZeELimz6nxUbQMHgobvTO/V
        tPjs9Eum+aCYa+t7ti/qhZYwJaFuxOaB+k4rOkRXNDz1dE0MP0n2ijgLpk/L3iisEIl1miJmvHIl0
        AXbqfwAQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1parbj-00HBNG-JB; Sat, 11 Mar 2023 05:17:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org,
        torvalds@linux-foundation.org
Subject: [RFC 12/12] module: use aliases to find module on find_module_all()
Date:   Fri, 10 Mar 2023 21:17:12 -0800
Message-Id: <20230311051712.4095040-13-mcgrof@kernel.org>
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

Modules can have a series of aliases, but we don't currently use
them to check if a module is already loaded. Part of this is because
load_module() will stick to checking for already loaded modules using
the actual module name, not an alias. Its however desriable to also
check for aliases on find_module_all() for existing callers and future
callers. The curent gain to using aliases on find_module_all() will
simply be to be able to support unloading modules using the alias using
the delete_module() syscall.

You can debug this with dynamic debug:

GRUB_CMDLINE_LINUX_DEFAULT="dyndbg=\"func module_process_aliases +p; func module_name_match +p; \" "

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/aliases.c  | 17 +++++++++++++++++
 kernel/module/internal.h |  5 +++++
 kernel/module/main.c     | 24 +++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/kernel/module/aliases.c b/kernel/module/aliases.c
index 2f30c9d4c765..69518bc5169a 100644
--- a/kernel/module/aliases.c
+++ b/kernel/module/aliases.c
@@ -90,3 +90,20 @@ int module_process_aliases(struct module *mod, struct load_info *info)
 
 	return -ENOMEM;
 }
+
+bool module_name_match_aliases(struct module *mod, const char *name, size_t len)
+{
+	unsigned int i;
+	const char *alias;
+
+	for (i=0; i < mod->num_aliases; i++) {
+		alias = mod->aliases[i];
+		if (strlen(alias) == len && !memcmp(alias, name, len)) {
+			pr_debug("module %s alias matched: alias[%u] = %s\n",
+				 mod->name, i, alias);
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 40bb80ed21e2..78aaad74f4ca 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -306,6 +306,7 @@ static inline int same_magic(const char *amagic, const char *bmagic, bool has_cr
 #ifdef CONFIG_MODULE_KERNEL_ALIAS
 void free_mod_aliases(struct module *mod);
 int module_process_aliases(struct module *mod, struct load_info *info);
+bool module_name_match_aliases(struct module *mod, const char *name, size_t len);
 #else
 static void free_mod_aliases(struct module *mod)
 {
@@ -314,4 +315,8 @@ static int module_process_aliases(struct module *mod, struct load_info *info)
 {
 	return 0;
 }
+static bool module_name_match_aliases(struct module *mod, const char *name, size_t len)
+{
+	return false;
+}
 #endif /* CONFIG_MODULE_KERNEL_ALIAS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bc9202b60d55..cf044329da3c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -338,6 +338,28 @@ bool find_symbol(struct find_symbol_arg *fsa)
 	return false;
 }
 
+static bool module_name_match(struct module *mod, const char *name, size_t len)
+{
+	unsigned int i;
+	const char *alias;
+
+	if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
+		return true;
+
+	return module_name_match_aliases(mod, name, len);
+
+	for (i=0; i < mod->num_aliases; i++) {
+		alias = mod->aliases[i];
+		if (strlen(alias) == len && !memcmp(alias, name, len)) {
+			pr_debug("module %s alias matched: alias[%u] = %s\n",
+				 mod->name, i, alias);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Search for module by name: must hold module_mutex (or preempt disabled
  * for read-only access).
@@ -353,7 +375,7 @@ struct module *find_module_all(const char *name, size_t len,
 				lockdep_is_held(&module_mutex)) {
 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
+		if (module_name_match(mod, name, len))
 			return mod;
 	}
 	return NULL;
-- 
2.39.1

