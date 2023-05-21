Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02F170AED5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEUQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjEUQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20248118;
        Sun, 21 May 2023 09:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F7E60FAC;
        Sun, 21 May 2023 16:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D51C433EF;
        Sun, 21 May 2023 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685138;
        bh=Irn8s+5UgFMeFebwkxke8zqHLikSaF4AyAgWT+2aYBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICceVZTSu3z1ir8GvjVJApiD7PzYwHGmFkdrP3xw09UR2BaYM/a7LEpWIbLe77eJu
         CWePIZBTSUFLEftBlphUFf0dM+h4pVQwgxQB8fKjva4Z01zyFcJmfVzbVv9Hni2LrN
         JSBRR6cAgbEawSyRab65dt05G4F/Y1L/uPldOeo6PIeJQ7BhsSldm1U/JPmdg06J6k
         xUImyjm7tmBjAAydWlh/gwCtW0Y7l/9R1/JMjjFC+jda/UVdaOoNwAybEslC3+y8O9
         rahLv5afZUy2nIJ8DoYolXGrJBvskFiPdBCTUcvgZZFEwRyVSZlNJy68PByKwPpCJ2
         7et/6ExVxDJmg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 13/20] modpost: squash sym_update_namespace() into sym_add_exported()
Date:   Mon, 22 May 2023 01:04:18 +0900
Message-Id: <20230521160426.1881124-14-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

Pass a set of the name, license, and namespace to sym_add_exported().

sym_update_namespace() is unneeded.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dd1d066f1214..8fe2aa7bf71b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -353,26 +353,8 @@ static const char *sec_name(const struct elf_info *info, unsigned int secindex)
 
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
 
@@ -385,6 +367,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -1248,8 +1231,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
-	s = sym_add_exported(name, mod, is_gpl);
-	sym_update_namespace(name, sym_get_data(elf, label));
+	s = sym_add_exported(name, mod, is_gpl, sym_get_data(elf, label));
 
 	/*
 	 * We need to be aware whether we are exporting a function or
@@ -2126,9 +2108,8 @@ static void read_dump(const char *fname)
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

