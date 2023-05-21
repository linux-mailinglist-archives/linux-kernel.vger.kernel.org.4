Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD270AED8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEUQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjEUQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 12:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAB0E78;
        Sun, 21 May 2023 09:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E23BC6179A;
        Sun, 21 May 2023 16:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1114CC4339E;
        Sun, 21 May 2023 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684685148;
        bh=OsDQm9j1PsDhPRuAGeNz8Ube9RFsdeDF2EBPrRh3R00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSSCKgO/pgmJMYhG5PbEkacPkJY9fJzSjVvsy7mQ6g5XQ01mmRjzRWa0l5QGox1zj
         Ehse+zJR2r2fCka79ORaDKzj6yVqM5mxK7nXB4Kv/aOXj3iuPLmiBVlzi3wQnkvh/K
         gl7fj2T9p82yk3Ae/afrvt+jPkYL4dORCwGu1sQa6VhK6y2wsrh5ynhBLLselJ3+Hg
         jjvrrEfABBLm2CwQ3RWulT3jXzttTWAZ0621MtACF9jyf36m5f6j1yw+WT6t0JU0hl
         kFHtBhfwGzWb6VLUk9dRfAQCYUN+ISXdzTa2HcU74FcvIx0wsCB04D+sGcjAF+lh0S
         n+VHiBIAn+Y0w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 19/20] modpost: merge two similar section mismatch warnings
Date:   Mon, 22 May 2023 01:04:24 +0900
Message-Id: <20230521160426.1881124-20-masahiroy@kernel.org>
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

In case of section mismatch, modpost shows slightly different messages.

For extable section mismatch:

 "%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"

For the other cases:

 "%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n"

They are similar. Merge them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 852cc164c77e..e7561fa57478 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1135,21 +1135,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	switch (mismatch->mismatch) {
-	case TEXT_TO_ANY_INIT:
-	case DATA_TO_ANY_INIT:
-	case TEXTDATA_TO_ANY_EXIT:
-	case XXXINIT_TO_SOME_INIT:
-	case XXXEXIT_TO_SOME_EXIT:
-	case ANY_INIT_TO_ANY_EXIT:
-	case ANY_EXIT_TO_ANY_INIT:
-		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-		     modname, fromsym, fromsec, tosym, tosec);
-		break;
-	case EXTABLE_TO_NON_TEXT:
-		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-		     modname, fromsec, (long)faddr, tosec, tosym);
+	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, fromsec, tosym, tosec);
 
+	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
 			fatal("The relocation at %s+0x%lx references\n"
 			      "section \"%s\" which is black-listed.\n"
@@ -1169,7 +1158,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		else
 			error("%s+0x%lx references non-executable section '%s'\n",
 			      fromsec, (long)faddr, tosec);
-		break;
 	}
 }
 
-- 
2.39.2

