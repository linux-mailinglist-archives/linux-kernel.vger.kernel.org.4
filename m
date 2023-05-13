Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F27019C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEMUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjEMUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ABE3AA6;
        Sat, 13 May 2023 13:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E233C6152F;
        Sat, 13 May 2023 20:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC139C433D2;
        Sat, 13 May 2023 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010723;
        bh=ldB1zuIjVJbUZHmq+luLZNk89A0RkfSMZ4+S70RhR7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4v1SJALynZVCAl/+U+H6tdigD4RZZMp3piTPvySM4JAS1F2gxt80rEVC2ZzMxDOK
         4EgfPqtRqfy5qeV344aZKazB6aF9y8yXGk71H2ciJ9o0KzOgkM+PGwUtRkm3mnM5ZB
         Q0nGZDUsJXKpkFOKR0/iXFduK22/yljkKit0eIGs8S1M5HjvTyYLtYgzFFVBgU6OAh
         kdtoUR+PKp3NKF+DUyeSnYlStMc8eMM9DISaKpNwK6pwqdAB3f+Gu6O4/w+iQG+ToJ
         u23jHRJUV0rGcTlgd3ooxJGcCUfESCPHIGbJfG2jfX5y5443jm19WEOnmFuRhNO2Ae
         O4T2Vn4HRiwQg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 05/21] modpost: squash report_sec_mismatch() into default_mismatch_handler()
Date:   Sun, 14 May 2023 05:44:46 +0900
Message-Id: <20230513204502.1593923-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
References: <20230513204502.1593923-1-masahiroy@kernel.org>
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

report_sec_mismatch() and default_mismatch_handler() are small enough
to be merged together.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 55 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7a9a3ef8ca0d..bb7d1d87bae7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1207,17 +1207,27 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
-/*
- * Print a warning about a section mismatch.
- * Try to find symbols near it so user can find it.
- * Check whitelist before warning - it may be a false positive.
- */
-static void report_sec_mismatch(const char *modname,
-				const struct sectioncheck *mismatch,
-				const char *fromsec,
-				const char *fromsym,
-				const char *tosec, const char *tosym)
+static void default_mismatch_handler(const char *modname, struct elf_info *elf,
+				     const struct sectioncheck* const mismatch,
+				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
 {
+	const char *tosec;
+	Elf_Sym *to;
+	Elf_Sym *from;
+	const char *tosym;
+	const char *fromsym;
+
+	from = find_elf_symbol2(elf, r->r_offset, fromsec);
+	fromsym = sym_name(elf, from);
+
+	tosec = sec_name(elf, get_secindex(elf, sym));
+	to = find_elf_symbol(elf, r->r_addend, sym);
+	tosym = sym_name(elf, to);
+
+	/* check whitelist - we may ignore it */
+	if (!secref_whitelist(mismatch, fromsec, fromsym, tosec, tosym))
+		return;
+
 	sec_mismatch_count++;
 
 	switch (mismatch->mismatch) {
@@ -1242,31 +1252,6 @@ static void report_sec_mismatch(const char *modname,
 	}
 }
 
-static void default_mismatch_handler(const char *modname, struct elf_info *elf,
-				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
-{
-	const char *tosec;
-	Elf_Sym *to;
-	Elf_Sym *from;
-	const char *tosym;
-	const char *fromsym;
-
-	from = find_elf_symbol2(elf, r->r_offset, fromsec);
-	fromsym = sym_name(elf, from);
-
-	tosec = sec_name(elf, get_secindex(elf, sym));
-	to = find_elf_symbol(elf, r->r_addend, sym);
-	tosym = sym_name(elf, to);
-
-	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
-			     fromsec, fromsym, tosec, tosym)) {
-		report_sec_mismatch(modname, mismatch,
-				    fromsec, fromsym, tosec, tosym);
-	}
-}
-
 static int is_executable_section(struct elf_info* elf, unsigned int section_index)
 {
 	if (section_index > elf->num_sections)
-- 
2.39.2

