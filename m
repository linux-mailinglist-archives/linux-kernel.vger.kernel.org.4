Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6C72AA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjFJJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjFJJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9973C28;
        Sat, 10 Jun 2023 02:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095BE61EFC;
        Sat, 10 Jun 2023 09:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F9EC433D2;
        Sat, 10 Jun 2023 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686388428;
        bh=WxsbZJQWaT5jCsrdDCJG6B1Ekj8QHp6BWQx+hm3BcWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiVRdteGCFlLKvr6PB4BCZgVXVjEWdD61C3XUb06yo/CsMmc4UWgAdOTV5m1U2nhB
         zWm617SOqSOTnqPDMiX2W7FX1GzhNVhTWvbKLleGHtqtftwS/Yl++6e7FhyL1r4d4Y
         eu+XqhXwGgPROTiKzc6lYC3ZK6idH6uEN5g0m68Gd4HqC4wh9FNJNU7/S/7TfXYYzF
         yL/Y/KQcDirTKqUUhGJLwR2NFl+yT36PPuaQlDjWjfD5VmUeX6vCtP9TSBXxwAWQyL
         8YTlhHv6426s6URkTD/oOmtFU4fN383j74r9PCZ0VS+9E0F7v4enw4Ble3k0LjncGh
         +7euzpAbwJkig==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 06/11] modpost: squash sym_update_namespace() into sym_add_exported()
Date:   Sat, 10 Jun 2023 18:13:15 +0900
Message-Id: <20230610091320.1054554-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
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

Pass a set of the name, license, and namespace to sym_add_exported().

sym_update_namespace() is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a3185ee6ec1a..4b0a009de0fb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -355,26 +355,8 @@ static const char *sec_name(const struct elf_info *info, unsigned int secindex)
 
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
-static void sym_update_namespace(const char *symname, const char *namespace)
-{
-	struct symbol *s = find_symbol(symname);
-
-	/*
-	 * That symbol should have been created earlier and thus this is
-	 * actually an assertion.
-	 */
-	if (!s) {
-		error("Could not update namespace(%s) for symbol %s\n",
-		      namespace, symname);
-		return;
-	}
-
-	free(s->namespace);
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
-}
-
 static struct symbol *sym_add_exported(const char *name, struct module *mod,
-				       bool gpl_only)
+				       bool gpl_only, const char *namespace)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -387,6 +369,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1230,8 +1213,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
-	s = sym_add_exported(name, mod, is_gpl);
-	sym_update_namespace(name, sym_get_data(elf, label));
+	s = sym_add_exported(name, mod, is_gpl, sym_get_data(elf, label));
 
 	/*
 	 * We need to be aware whether we are exporting a function or
@@ -2174,9 +2156,8 @@ static void read_dump(const char *fname)
 			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
-		s = sym_add_exported(symname, mod, gpl_only);
+		s = sym_add_exported(symname, mod, gpl_only, namespace);
 		sym_set_crc(s, crc);
-		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
 	return;
-- 
2.39.2

