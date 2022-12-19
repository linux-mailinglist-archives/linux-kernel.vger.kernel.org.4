Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1C6512C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiLSTTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiLSTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:06 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989812D29
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:05 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso7082766ilj.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPz4DVz3tZDZwOVeqeTus3Hhdj8ABoJzZwaMAiF7Nxg=;
        b=HmQ2kiymwOL9kUhLxZJM5G/ssb7viDDO+nKpbR8v8lfSPSJVTzx9nWNNUPPmk32ot4
         AYAQGLqdfd2uQnxuJeTBLLzf9JIUunUmXYjXMZVs5D4iEcx0gZ3qiZuPD68M8OmMfX1D
         P25V4wPBj0wABkx5DUwHuZHIeo8TuT+lW/YpcHxZa2FbT4yAra6jb7zi784dg0mGYxxz
         dZzJRLxKZAVI9t9aVegiOumN+hBaZLIEEn0DtpTYJVec+5fYEaRFt1C0qlB4Ere3GNiO
         T4FDM93EieTv4NNVjwjxXEfgriNZTNAPXWacGUOFzKucVaFUUv2EgcDK8276jLq9SkjG
         Mjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPz4DVz3tZDZwOVeqeTus3Hhdj8ABoJzZwaMAiF7Nxg=;
        b=nubUZOhmvcTqBoX+j/T0ymwX/W0hJB8cKHw6+jBAm76QiBeG2XvEEvwd0KqhpxvCMC
         YXC6cQVxwiZiYJCnBOg68HhLlgEV6B1jdnM7VOwJbzoxBmPH5idoU4xFTnOmwLq1PXvf
         KYewZ9HaOHpPwJ3BorCkT7LnMnAQUoDkv6aKH/ePa5RkDRPWUsWPYOkz1ojnb0yTKR+d
         x/BxTWmKd/KgHO3QIkpWT079h4WYFlQatl/hWX6rofJ4Ff5Hh9slW4w8Qkrtd4d8leJh
         rg1T0YRDictz+Dz7H0sIMhWE+pm1EJQh9BoNY1TlgQSBNrYJ8KtM+c0MuUnM/hyitFKQ
         c4hA==
X-Gm-Message-State: ANoB5pnXBzV08L/YAHAfuDIJBIqR5IZ+kpYKS5bClCTK2VA0GxgnNEr3
        roYCemiYn8jk/Mod1ozQ3aK4yYO6RzF9nJo=
X-Google-Smtp-Source: AA0mqf6t5nkMBwgRaVv39PyR4Pntw8jUtKj60DAOxmDGxiaFq1PK1JoSJo+d+K7MDtRnJa5HBj0/t3YUMlD6fbY=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:fb06:0:b0:6e0:c4d:65e2 with SMTP id
 h6-20020a6bfb06000000b006e00c4d65e2mr10765676iog.30.1671477545287; Mon, 19
 Dec 2022 11:19:05 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:52 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-7-allenwebb@google.com>
Subject: [PATCH v8 6/9] modpost: Track module name for built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
index 80d973144fded..e41ff8de7a876 100644
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
index 1178f40a73f3d..34fe5fc0b02cb 100644
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
2.37.3

