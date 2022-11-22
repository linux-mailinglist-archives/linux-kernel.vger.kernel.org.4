Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB96633EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiKVO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiKVO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:27:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A52AE5C;
        Tue, 22 Nov 2022 06:27:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669127254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG/st4G6W4vPzDUzOjmBSilspPfXfLK8NNMPkNliKwk=;
        b=ZN04isOGDj2N9eSI34qr0LJjPEgDBNd1f8vA48y1SKm/ZXzyxAI1tdoqkw93DApLoGkAlk
        LTgem6tOwrAJSIymrzBmZhT2rIt8DGvlV6+kqgnvbYK2ZaNOMRROVtJRzlMyMxIX7bTrNy
        fR238PNVwSujeuwlKMpD8gsHzUf0IF2y6MY9khcUTcOXOHfO4a6cH6HcwACWm9wo9f6XIJ
        Eax5xYPxn9jp6OekrxMYIXovHOSKNWi+txVu0UGnDjWOz9F16HlsIVEBkQfz3OYrX7xHWd
        ix3hqzy+cBc6iIOWTLaKV6FnZA82a3c8+Y4qpTTMQ83OkvlQvGVqbkPOxY6DVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669127254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG/st4G6W4vPzDUzOjmBSilspPfXfLK8NNMPkNliKwk=;
        b=3XWhBM6kB1Jp3kTF5jkzy0dBkU/apgnY1dRl1c2Vi7Nv22eQ6/CFDzT+IaOaOsSInHDT7n
        gU1dVTZeMQrRYpCQ==
From:   "tip-bot2 for Julian Pidancet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Consistently patch SMP locks
 in vmlinux and modules
Cc:     Julian Pidancet <julian.pidancet@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221027204906.511277-1-julian.pidancet@oracle.com>
References: <20221027204906.511277-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Message-ID: <166912725270.4906.15781123390853216184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     be84d8ed3f04e9154a3a55e29a27dcd416f05b31
Gitweb:        https://git.kernel.org/tip/be84d8ed3f04e9154a3a55e29a27dcd416f05b31
Author:        Julian Pidancet <julian.pidancet@oracle.com>
AuthorDate:    Thu, 27 Oct 2022 22:49:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 15:16:16 +01:00

x86/alternative: Consistently patch SMP locks in vmlinux and modules

alternatives_smp_module_add() restricts patching of SMP lock prefixes to
the text address range passed as an argument.

For vmlinux, patching all the instructions located between the _text and
_etext symbols is allowed. That includes the .text section but also
other sections such as .text.hot and .text.unlikely.

As per the comment inside the 'struct smp_alt_module' definition, the
original purpose of this restriction is to avoid patching the init code
because in the case when one boots with a single CPU, the LOCK prefixes
to the locking primitives are removed.

Later on, when other CPUs are onlined, those LOCK prefixes get added
back in but by that time the .init code is very likely removed so
patching that would be a bad idea.

For modules, the current code only allows patching instructions located
inside the .text segment, excluding other sections such as .text.hot or
.text.unlikely, which may need patching.

Make patching of the kernel core and modules more consistent by
allowing all text sections of modules except .init.text to be patched in
module_finalize().

For that, use mod->core_layout.base/mod->core_layout.text_size as the
address range allowed to be patched, which include all the code sections
except the init code.

  [ bp: Massage and expand commit message. ]

Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221027204906.511277-1-julian.pidancet@oracle.com
---
 arch/x86/kernel/module.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index c032edc..c8a25ae 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,14 +251,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
+	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-		if (!strcmp(".text", secstrings + s->sh_name))
-			text = s;
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
@@ -302,12 +300,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
-	if (locks && text) {
+	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
-		void *tseg = (void *)text->sh_addr;
+		void *text = me->core_layout.base;
+		void *text_end = text + me->core_layout.text_size;
 		alternatives_smp_module_add(me, me->name,
 					    lseg, lseg + locks->sh_size,
-					    tseg, tseg + text->sh_size);
+					    text, text_end);
 	}
 
 	if (orc && orc_ip)
