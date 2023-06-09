Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881957291A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbjFIHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbjFIHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119491BE2;
        Fri,  9 Jun 2023 00:47:41 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZD/7cDb+c9jg0rA3MfW9PxAaWkqFMYDyabqKilSRHTA=;
        b=bvp2v0qIXVJvvKUDMTHyrRhWYmEefkF9kThsnfvBBg3TuPsS2kU8WMKY+y9y8zBUwB4hIK
        eN2zdcjio1MVbkxNQyygp8YXA6Xp2IVyZYJXdx0l0CX+JKzzEPkQXzeL2QHvrUB7WDelkw
        q9YcmzxfwXvUFQ4nGUfLKQq6JwfXw+AkxbQbk78cSFhuFtBfe0n3udT16oJIGFkKOX1ul6
        2r3wuvIMyWgaNcoPyvgreD+0/jpSNsMMLoary05WUuNGmQsb3+IiJQFd+zZNOYCmhkz/Dr
        aFFUr3HXSlgtyoKflhswFkjqT9BZtYE78YZCSvFFNMSENhjFiabDRCzKmS1tSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZD/7cDb+c9jg0rA3MfW9PxAaWkqFMYDyabqKilSRHTA=;
        b=RHTWk6M4Q/iZn00JVJPKziWG00SeunYhSOLUlwTymAKFFFQ5feNpiDM+kcJGVNKwfV8+VM
        AiurDe6yRVkl46DA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Don't free memory in elf_close()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <74bdb3058b8f029db8d5b3b5175f2a200804196d.1685464332.git.jpoimboe@kernel.org>
References: <74bdb3058b8f029db8d5b3b5175f2a200804196d.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685414.404.166550567183252024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5201a9bcb7d3f98ab99c17325b0aa925c2888ca3
Gitweb:        https://git.kernel.org/tip/5201a9bcb7d3f98ab99c17325b0aa925c2888ca3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:01 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:19 -07:00

objtool: Don't free memory in elf_close()

It's not necessary, objtool's about to exit anyway.

Link: https://lore.kernel.org/r/74bdb3058b8f029db8d5b3b5175f2a200804196d.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8d491b2..8d53f18 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1350,30 +1350,14 @@ int elf_write(struct elf *elf)
 
 void elf_close(struct elf *elf)
 {
-	struct section *sec, *tmpsec;
-	struct symbol *sym, *tmpsym;
-	struct reloc *reloc, *tmpreloc;
-
 	if (elf->elf)
 		elf_end(elf->elf);
 
 	if (elf->fd > 0)
 		close(elf->fd);
 
-	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
-		list_for_each_entry_safe(sym, tmpsym, &sec->symbol_list, list) {
-			list_del(&sym->list);
-			hash_del(&sym->hash);
-		}
-		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
-			list_del(&reloc->list);
-			hash_del(&reloc->hash);
-		}
-		list_del(&sec->list);
-		free(sec->reloc_data);
-	}
-
-	free(elf->symbol_data);
-	free(elf->section_data);
-	free(elf);
+	/*
+	 * NOTE: All remaining allocations are leaked on purpose.  Objtool is
+	 * about to exit anyway.
+	 */
 }
