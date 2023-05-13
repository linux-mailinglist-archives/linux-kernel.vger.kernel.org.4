Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7F7019BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEMUpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEMUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6330DD;
        Sat, 13 May 2023 13:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5064C6152F;
        Sat, 13 May 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05515C4339E;
        Sat, 13 May 2023 20:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684010716;
        bh=2aCCAYUy59MXOZb6fuub05KBE88TJEBAi9SnqqDDSg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+EVxj9X9s9nlyOtjhobf5/PplVJxigiB4B89jDArYcU3xTFURWkTU8COMPubF/Cy
         9IlYosFNEsyPbR09MQ4Jd9GSFuTKB1utrgR90nHy9p5YEPIIMzaf6CEoDC6i+DL/bO
         JEC1zkWt6OEorp0VhMkkL41fPHDG8MTWavV1kvRqoOyK5hC5cXzN04LbLlEU431kab
         SALWI4gDDOk6JTwP523pzAIkZO/k4Jtc7sqoYrZioWmnDizD6dO5gTqE9vqY5NMgaC
         Mwt7w8kKXHA6B+5MV2mYkWQGOwLzZvYFJtHUdGSbm9tvWAEzaC82bSuFpahX4Sjlpt
         XodRQtdEqJr0g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 02/21] modpost: remove fromsym info in __ex_table section mismatch warning
Date:   Sun, 14 May 2023 05:44:43 +0900
Message-Id: <20230513204502.1593923-3-masahiroy@kernel.org>
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

report_extable_warnings() prints "from" in a pretty form, but we know
it is always located in the __ex_table section, i.e. a collection of
struct exception_table_entry.

It is very likely to fail to get the symbol name and ends up with
meaningless message:

  ... in reference from the (unknown reference) (unknown) to ...

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ba4577aa4f1d..bbe066f7adbc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1297,23 +1297,16 @@ static void report_extable_warnings(const char* modname, struct elf_info* elf,
 				    Elf_Rela* r, Elf_Sym* sym,
 				    const char* fromsec, const char* tosec)
 {
-	Elf_Sym* fromsym = find_elf_symbol2(elf, r->r_offset, fromsec);
-	const char* fromsym_name = sym_name(elf, fromsym);
 	Elf_Sym* tosym = find_elf_symbol(elf, r->r_addend, sym);
 	const char* tosym_name = sym_name(elf, tosym);
-	const char* from_pretty_name;
-	const char* from_pretty_name_p;
 	const char* to_pretty_name;
 	const char* to_pretty_name_p;
 
-	get_pretty_name(is_function(fromsym),
-			&from_pretty_name, &from_pretty_name_p);
 	get_pretty_name(is_function(tosym),
 			&to_pretty_name, &to_pretty_name_p);
 
-	warn("%s(%s+0x%lx): Section mismatch in reference from the %s %s%s to the %s %s:%s%s\n",
-	     modname, fromsec, (long)r->r_offset, from_pretty_name,
-	     fromsym_name, from_pretty_name_p,
+	warn("%s(%s+0x%lx): Section mismatch in reference to the %s %s:%s%s\n",
+	     modname, fromsec, (long)r->r_offset,
 	     to_pretty_name, tosec, tosym_name, to_pretty_name_p);
 
 	if (!match(tosec, mismatch->bad_tosec) &&
-- 
2.39.2

