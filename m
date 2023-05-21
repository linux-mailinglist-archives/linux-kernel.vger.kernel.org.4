Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC870AEC5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEUQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjEUQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:05:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3732D2;
        Sun, 21 May 2023 09:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6924660ECB;
        Sun, 21 May 2023 16:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB41C4339E;
        Sun, 21 May 2023 16:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685124;
        bh=621Nlo8JQEog+0qRcxqr1Gngu/9Y6pP2Btj4yQo7BvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssgjpQhP0UJdm8/pwcjsks+/LxMRn5wXE4R/AeWLExIo/RZ6mTxYxtzspxWR2TnEW
         hmzOW4v+2SmLKxfa34EHvdfZ0HdweiUaUww2KQbKQb+oRe3WZWAomiFnck9agvZ3bg
         HvByDO9lHsdXxXvWr0KYThNIg7w3o2SsmCNH6McQyerajs37JwuYj/cXFhVoolloMv
         cxI9Gq9dB/HXlNIXpswMskOjPfDnx5/35oOtWxUw39mbsebFuGD4fRcXoRzZn5SajK
         QQOks0X30wswEE+yjn6GN4h7Up6m4VxAvLViID0ntOOyPcmbB3bgeMZzUEV1Bynuw+
         02oVvGI+SbPiA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 06/20] modpost: unify 'sym' and 'to' in default_mismatch_handler()
Date:   Mon, 22 May 2023 01:04:11 +0900
Message-Id: <20230521160426.1881124-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521160426.1881124-1-masahiroy@kernel.org>
References: <20230521160426.1881124-1-masahiroy@kernel.org>
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

find_tosym() takes 'sym' and stores the return value to another
variable 'to'. You can use the same variable because we want to
replace the original one when appropriate.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6ac0d571542c..7848bacd4b42 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1166,11 +1166,10 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym,
+				     Elf_Rela *r, Elf_Sym *tsym,
 				     unsigned int fsecndx, const char *fromsec,
 				     const char *tosec)
 {
-	Elf_Sym *to;
 	Elf_Sym *from;
 	const char *tosym;
 	const char *fromsym;
@@ -1178,8 +1177,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_fromsym(elf, r->r_offset, fsecndx);
 	fromsym = sym_name(elf, from);
 
-	to = find_tosym(elf, r->r_addend, sym);
-	tosym = sym_name(elf, to);
+	tsym = find_tosym(elf, r->r_addend, tsym);
+	tosym = sym_name(elf, tsym);
 
 	/* check whitelist - we may ignore it */
 	if (!secref_whitelist(fromsec, fromsym, tosec, tosym))
@@ -1214,7 +1213,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 			      "You might get more information about where this is\n"
 			      "coming from by using scripts/check_extable.sh %s\n",
 			      fromsec, (long)r->r_offset, tosec, modname);
-		else if (is_executable_section(elf, get_secindex(elf, sym)))
+		else if (is_executable_section(elf, get_secindex(elf, tsym)))
 			warn("The relocation at %s+0x%lx references\n"
 			     "section \"%s\" which is not in the list of\n"
 			     "authorized sections.  If you're adding a new section\n"
-- 
2.39.2

