Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B327019BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEMUp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjEMUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6F2D48;
        Sat, 13 May 2023 13:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D17861555;
        Sat, 13 May 2023 20:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70088C433D2;
        Sat, 13 May 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010718;
        bh=EkENQxBTRXmNLefaXpEZoKKE9XDY5Mk/Sp9CRBIt9Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtZ4Q300WElTkmHZXxJDejKVJGlYKAlyTNbLHRXQhyrfW+GFXkZywBJ+z965vl+RF
         u8BdaSzwTaYaGzlsqSng/6wtRmmlXDTiiz9PQf5elvwwzgGD5NCUQvd/pwnOZmA9fQ
         sUyoLy6uRXSuTb7W3bOulouCbS26eLJw8+p7tm5Tu/OeYiNGVGJ5z5UYOXjUMXFT5R
         1bb5TZ8oMekgPLrdXZySq6pGAPnETkjh3QlT6qtDMjlaLu0wsxQl0lWDVYp30/xmU+
         tCvcqGVhAIGX3OCnrpP3rYMDG3HDwAp24KawB4+7qVp3mEoamv7OGUbZh86DCjezw7
         ZmKUm1R83XAYQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 03/21] modpost: remove get_prettyname()
Date:   Sun, 14 May 2023 05:44:44 +0900
Message-Id: <20230513204502.1593923-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
References: <20230513204502.1593923-1-masahiroy@kernel.org>
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

This is the last user of get_pretty_name() - it is just used to
distinguish whether the symbol is a function or not. It is not
valuable information.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bbe066f7adbc..371891d67175 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1207,23 +1207,6 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
-static int is_function(Elf_Sym *sym)
-{
-	if (sym)
-		return ELF_ST_TYPE(sym->st_info) == STT_FUNC;
-	else
-		return -1;
-}
-
-static inline void get_pretty_name(int is_func, const char** name, const char** name_p)
-{
-	switch (is_func) {
-	case 0:	*name = "variable"; *name_p = ""; break;
-	case 1:	*name = "function"; *name_p = "()"; break;
-	default: *name = "(unknown reference)"; *name_p = ""; break;
-	}
-}
-
 /*
  * Print a warning about a section mismatch.
  * Try to find symbols near it so user can find it.
@@ -1299,15 +1282,9 @@ static void report_extable_warnings(const char* modname, struct elf_info* elf,
 {
 	Elf_Sym* tosym = find_elf_symbol(elf, r->r_addend, sym);
 	const char* tosym_name = sym_name(elf, tosym);
-	const char* to_pretty_name;
-	const char* to_pretty_name_p;
 
-	get_pretty_name(is_function(tosym),
-			&to_pretty_name, &to_pretty_name_p);
-
-	warn("%s(%s+0x%lx): Section mismatch in reference to the %s %s:%s%s\n",
-	     modname, fromsec, (long)r->r_offset,
-	     to_pretty_name, tosec, tosym_name, to_pretty_name_p);
+	warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
+	     modname, fromsec, (long)r->r_offset, tosec, tosym_name);
 
 	if (!match(tosec, mismatch->bad_tosec) &&
 	    is_executable_section(elf, get_secindex(elf, sym)))
-- 
2.39.2

