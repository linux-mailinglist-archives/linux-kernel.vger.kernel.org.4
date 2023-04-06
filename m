Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AD6DA087
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbjDFTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbjDFTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:08 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8712459F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:03 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id w14-20020a056e0213ee00b0032827955ae6so1096699ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEZbsR+WTyUtWxubualsRcS33WiF75x8OXTLlDIM76E=;
        b=D81pJQDCQ+OdL291Z2IZ2aoLcZ9JSdF//vAX5266oVAnQZPAsb2ROsi95KVjKK3wKl
         XbpTpcSS49IV425LJMR5r61TCIqtP2EcrXEcJYbsOu8cFWo+BVrf6iH+dJ58GpAVEbGn
         Ob0KC9VY5azkYE4xJEOA4ueXQijtPJP+hpJhW/YwaW4aQyUwR3vMc7NqkaFbDsODU7Nw
         /7C7nADEmWmY3+IZXHXTYCeVpPUBnR7rp5s6E1NNNGgXR1+Bt8XYVSPcNp7Zl8/rSVHw
         Qsi4OfLOzlOEZEGuq+ld/NjtkVhfX4p3akpLLAcW1NwdJOuSYjjL4pHgWvhxnmu7Be9V
         Pzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEZbsR+WTyUtWxubualsRcS33WiF75x8OXTLlDIM76E=;
        b=ReQxv6iDvJBVrcEvXr3968+QCk+SMPvfxvZIOQJdlYHMw0t/2IZdsYnR/xFTrbCbaV
         HE73Tzm+8Ac37Pha1paWkuMJ/rl83qKdvk+ZMjLCtkM6wsfh87lt7UkIMHsgyiPI1v6p
         LAbRzj36FPk7X5XqY/fRLpwaOTNQgrUXNacWDKt6Zv7AQUh0i4crm+stoaPuk1Q9TjN0
         G658feq/+dkIhS5yu3yGv7wFmVIlKb4RLqVbgoA5cf2vYRFHbVI9SIIMvlzs3R+q+yoJ
         TWgJGtdhcBNIiZf8kadjmfCU126yEl36kw6n0pmCEJXCxcKTV/C76nK2/X9BxpTwoWyQ
         gR4w==
X-Gm-Message-State: AAQBX9crTph0HvITb2PdcoA7VH0rLXdGHCchhYSumop+qybkZwudS1WG
        3hhdWP8vGe1gFyfrmIk8dr20tO8mRqIW5Hs=
X-Google-Smtp-Source: AKy350bmElFuE1Xid/gxRe2zw6r7kNsu5GgybFoCIrVluA8w6qJgsdQVeebMx1wlwhideMS0TE7hnev66x532k0=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:2a45:0:b0:406:c43f:6320 with SMTP id
 w66-20020a022a45000000b00406c43f6320mr4089761jaw.0.1680807662877; Thu, 06 Apr
 2023 12:01:02 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:24 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-6-allenwebb@google.com>
Subject: [PATCH v10 05/11] modpost: Track module name for built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of the module name when processing match table symbols.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/file2alias.c | 39 +++++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h    |  1 +
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 91c2e7ba5e52..b392d51c3b06 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -28,6 +28,7 @@ typedef Elf64_Addr	kernel_ulong_t;
 #include <stdint.h>
 #endif
 
+#include <assert.h>
 #include <ctype.h>
 #include <stdbool.h>
 
@@ -1540,9 +1541,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname)
 {
 	void *symval;
-	char *zeros = NULL;
-	const char *name, *identifier;
-	unsigned int namelen;
+	char *zeros = NULL, *modname_str = NULL;
+	const char *name, *identifier, *modname;
+	unsigned int namelen, modnamelen;
 
 	/* We're looking for a section relative symbol */
 	if (!sym->st_shndx || get_secindex(info, sym) >= info->num_sections)
@@ -1552,7 +1553,12 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 		return;
 
-	/* All our symbols are of form __mod_<name>__<identifier>_device_table. */
+	/*
+	 * All our symbols are either of form
+	 *   __mod_<name>__<identifier>_device_table
+	 * or
+	 *   __mod_<name>__<identifier>__kmod_<builtin-name>_device_table
+	 */
 	if (strncmp(symname, "__mod_", strlen("__mod_")))
 		return;
 	name = symname + strlen("__mod_");
@@ -1564,8 +1570,30 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	identifier = strstr(name, "__");
 	if (!identifier)
 		return;
+	modnamelen = namelen;
 	namelen = identifier - name;
 
+	/*
+	 * In the vmlinuz.o case we want to handle __kmod_ so aliases from
+	 * builtin modules are attributed correctly.
+	 */
+	modname = strstr(identifier + 2, "__kmod_");
+	if (modname) {
+		modname += strlen("__kmod_");
+		modnamelen -= (modname - name) + strlen("_device_table");
+		modname_str = malloc(modnamelen + 1);
+		/* We don't want to continue if the allocation fails. */
+		assert(modname_str);
+		memcpy(modname_str, modname, modnamelen);
+		modname_str[modnamelen] = '\0';
+	}
+
+	if (modname_str)
+		modname = modname_str;
+	else
+		modname = mod->name;
+	mod->builtin_name = modname;
+
 	/* Handle all-NULL symbols allocated into .bss */
 	if (info->sechdrs[get_secindex(info, sym)].sh_type & SHT_NOBITS) {
 		zeros = calloc(1, sym->st_size);
@@ -1597,6 +1625,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		}
 	}
 	free(zeros);
+	mod->builtin_name = NULL;
+	if (modname_str)
+		free(modname_str);
 }
 
 /* Now add out buffered information to the generated C source */
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1178f40a73f3..34fe5fc0b02c 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -128,6 +128,7 @@ struct module {
 	struct list_head missing_namespaces;
 	// Actual imported namespaces
 	struct list_head imported_namespaces;
+	const char *builtin_name;
 	char name[];
 };
 
-- 
2.39.2

