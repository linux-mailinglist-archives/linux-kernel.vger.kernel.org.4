Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7072B299
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjFKPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjFKPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B4910FB;
        Sun, 11 Jun 2023 08:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681D1611B6;
        Sun, 11 Jun 2023 15:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E852C4339E;
        Sun, 11 Jun 2023 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686498679;
        bh=VKxHtXFVlcWySintpspJtZKTq9sWsgdCdx/RGyDBDos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kanvkj7vc+JNf9L9dC/ml1Ei1imjS+iSRoPVPi3XaubAJZJPZQQ59FLNWawZHz7lU
         boBH/4xl0ydm+lO27FUbJv/6dFR25K4dEk8atubEvp4+3zR7EDb3GJSEoSLfdxq6mO
         uaL4Z1ZRnC0d4k+Wj4s2rspD03XMA3B+VvPPjQQI2E5WQ3QH0jjBH4wV4/fLbMRXFj
         19nFH9d3j/BG/s5HDKE6zwW4ICPM4oN7UXMLgkp7HgO+DZiZjb08/6az2CFuXvLua3
         oXxd7SwYWswZYcZNEVbNK03/WR6UC0XFRHscO+rqVNVOsqYd4ppgjk+mMMKFWJYyTt
         IN97rVMOevhdQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-snps-arc@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v9 06/11] modpost: squash sym_update_namespace() into sym_add_exported()
Date:   Mon, 12 Jun 2023 00:50:55 +0900
Message-Id: <20230611155100.2553804-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230611155100.2553804-1-masahiroy@kernel.org>
References: <20230611155100.2553804-1-masahiroy@kernel.org>
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

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 10da82ad5874..79ad0a346a5c 100644
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
 
@@ -1236,8 +1219,7 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 	}
 
 	data += strlen(data) + 1;	/* namespace */
-	s = sym_add_exported(name, mod, is_gpl);
-	sym_update_namespace(name, data);
+	s = sym_add_exported(name, mod, is_gpl, data);
 
 	/*
 	 * We need to be aware whether we are exporting a function or
@@ -2180,9 +2162,8 @@ static void read_dump(const char *fname)
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

