Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56757701E01
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbjENP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjENP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB43C12;
        Sun, 14 May 2023 08:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4C860B77;
        Sun, 14 May 2023 15:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CB9C433EF;
        Sun, 14 May 2023 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684078073;
        bh=EkENQxBTRXmNLefaXpEZoKKE9XDY5Mk/Sp9CRBIt9Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWa5Wdc0qwBVcqQm63iNnH/Vh6IFxNT6WFGNs3FgSFoyByArb8b/CmX3VaWr74HqG
         MNr5I2ulp+sJbH+Xv19XLlQYjkzwlMzPmyqWCgpnUWvzhtWyGjIxURjr8Vp5TrFy3B
         QKm70u9KxG4SllTAcUsiDSKjS/hNQcabcZkuJQCPCYM29TRW52IodSWcgfAFDCmL1w
         lLIPn+DNF8cOb3ydb3AW4ru0oy9pzs7JZFn5c/xh9avqlk4D1u0Hb9NwTlWEXem6uS
         uMl80vZyJJTcnp2l0nYWBIWltmj+FlRHe2DvbDKaamanFKpqG3odp0JrZlVKgGRhlH
         m6YMLIwFKH7Qg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 03/21] modpost: remove get_prettyname()
Date:   Mon, 15 May 2023 00:27:21 +0900
Message-Id: <20230514152739.962109-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514152739.962109-1-masahiroy@kernel.org>
References: <20230514152739.962109-1-masahiroy@kernel.org>
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

