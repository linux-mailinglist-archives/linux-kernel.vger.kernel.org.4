Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68E2701E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjENP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjENP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936684EEA;
        Sun, 14 May 2023 08:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228C361138;
        Sun, 14 May 2023 15:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4755C433D2;
        Sun, 14 May 2023 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078110;
        bh=bRIrCHjbdkZMIq4/mCKkZCOfrF0gDAT9QeEo9NeR8YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlMRQMZD/zkU3pocW4viuecVfsF1DnEGbO1puEEtfxuzd7aZFsNmbtOVLD2ygt2rC
         atMtQqm5CBSaVzF3i4jhf1PX57ZwlvpNV3Maxn1/hOGHEEyo4+PYM6b2PDzaiJLX1/
         hUYWXNDp/qofUeGXS4kOKstlSKN4g9hYL+uxkcnZDnXUbVcnnuVZLJmFLoynKZfIvC
         Am7+qnkvbSd7NAwZABnSb/HcNb++EZJ6uary++6YjGaXLr1LXPqHdaNz0HoXqZmr8Z
         ckHvivtA72OtvVw+ZdJTCUR9CJe2RSoXz5j5Vb9fJPA3moAQuPH+m5VPNRh7ZlAIQa
         TcfQz1fGxbvMg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 20/21] modpost: use null string instead of NULL pointer for default namespace
Date:   Mon, 15 May 2023 00:27:38 +0900
Message-Id: <20230514152739.962109-21-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514152739.962109-1-masahiroy@kernel.org>
References: <20230514152739.962109-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default namespace is the null string, "".

When set, the null string "" is converted to NULL:

  s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;

When printed, the NULL pointer is get back to the null string:

  sym->namespace ?: ""

This saves 1 byte memory allocated for "", but loses the readability.

In kernel-space, we strive to save memory, but modpost is a userspace
tool used to build the kernel. On modern systems, such small piece of
memory is not a big deal.

Handle the namespace string as is.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7edb9a843ead..010c4f88d77b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -298,6 +298,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
 {
 	struct namespace_list *list;
 
+	/*
+	 * The default namespace is null string "", which is always implicitly
+	 * contained.
+	 */
+	if (!namespace[0])
+		return true;
+
 	list_for_each_entry(list, head, list) {
 		if (!strcmp(list->namespace, namespace))
 			return true;
@@ -367,7 +374,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	s->namespace = NOFAIL(strdup(namespace));
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1784,8 +1791,7 @@ static void check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace &&
-		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
+		if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -1871,8 +1877,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	list_for_each_entry(sym, &mod->exported_symbols, list)
 		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "",
-			   sym->namespace ?: "");
+			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
 
 	if (!modversions)
 		return;
@@ -2140,7 +2145,7 @@ static void write_dump(const char *fname)
 			buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
 				   sym->crc, sym->name, mod->name,
 				   sym->is_gpl_only ? "_GPL" : "",
-				   sym->namespace ?: "");
+				   sym->namespace);
 		}
 	}
 	write_buf(&buf, fname);
-- 
2.39.2

