Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CE57019C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEMUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjEMUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D54204;
        Sat, 13 May 2023 13:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC9161559;
        Sat, 13 May 2023 20:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151CCC4339B;
        Sat, 13 May 2023 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010729;
        bh=bvvrkTjspthXJHxYVNhJuEFtW7e3lRn7rVeZEbWKtEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUGk/AP+DGsbDs0QAVJYCFCuABN0umJPr1ml+9gjHy1dp4obTUHtkbCqvqdfcGtUz
         +BzzdmQKQ10F6oYk/VqfvRDRec5HOlx9JOiEW3gQxCJaioxXFRTpYI42+1EIK8SLe7
         SxmqE2rH2D8YPhgrh+cx3cE5arQsW2d+iaq6cNHNevgiuRs0FDXYeKcEhitk0LZ9vW
         ArZ/YrjZLjMmq+jDozDkEbpWr3yoDiUp3GWETrhJ+TeIVqrOyjWBA8rub/V3l1TA5s
         oAmFrjsbfE/1reOPfys/pcdJMve3jTc5D+FvrTavba+hZKAL5L5Xm9oAaPerdR638c
         9gG2MM/Xhfdtg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 08/21] modpost: pass 'tosec' down to default_mismatch_handler()
Date:   Sun, 14 May 2023 05:44:49 +0900
Message-Id: <20230513204502.1593923-9-masahiroy@kernel.org>
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

default_mismatch_handler() does not need to compute 'tosec' because
it is calculated by the caller.

Pass it down to default_mismatch_handler() instead of calling
sec_name() twice.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 49357a716519..2cc9c2a4aadc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1203,9 +1203,9 @@ static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 				     const struct sectioncheck* const mismatch,
-				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
+				     Elf_Rela *r, Elf_Sym *sym, const char *fromsec,
+				     const char *tosec)
 {
-	const char *tosec;
 	Elf_Sym *to;
 	Elf_Sym *from;
 	const char *tosym;
@@ -1214,7 +1214,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_elf_symbol2(elf, r->r_offset, fromsec);
 	fromsym = sym_name(elf, from);
 
-	tosec = sec_name(elf, get_secindex(elf, sym));
 	to = find_elf_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
 
@@ -1276,7 +1275,7 @@ static void check_section_mismatch(const char *modname, struct elf_info *elf,
 	if (!mismatch)
 		return;
 
-	default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec);
+	default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec, tosec);
 }
 
 static unsigned int *reloc_location(struct elf_info *elf,
-- 
2.39.2

