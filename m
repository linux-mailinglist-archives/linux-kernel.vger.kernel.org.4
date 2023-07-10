Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7274CFAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGJIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjGJIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23771E1;
        Mon, 10 Jul 2023 01:13:56 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Aa8ViPN2c8hO3w2Nhk0VmIBYhoiv9WTo6E6nOQzuJ4=;
        b=lVrBwyQmImYHl4E85lTfmTWMjKokLQ9qhPkfcVzi8/4XBQqIzGtmkUZSPB7F7qglgPv9+j
        Uo2pE4DmnXFZhxkkeSOmxp97bfdYCBHwTU5LuWJds6Ox4AtHCHa2aVLkZc+CbOHJk4+HGb
        u0q1C0mMdvVK4FXqa6PNdlvd8qaVwjnmPNdv1SfWcmiTKbN/nPXkUt7ssWyKYqZiHX0zh0
        iLVFqpOqYPRAhnrK3sdwhatvKSzVdhbGf+beFpDgVJfOv2NSGl+EUoFOHnRpqf9R1EdVVB
        +wuhQKQfeTB3IhqQZ5l2HMfdgbokaQskF4H/oZ12GqsOqo5eKL1q5a1ulGTzZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Aa8ViPN2c8hO3w2Nhk0VmIBYhoiv9WTo6E6nOQzuJ4=;
        b=MxglSJcjZYJq1Sr7syHndkCEwcKRMR1SgGkX5WWe+tDb0YgLo25ZdCnuV4KjPKqvY//gPr
        uYjMUz1k784Vx3AA==
From:   "tip-bot2 for Michal Kubecek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: initialize all of struct elf
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230629102051.42E8360467@lion.mk-sys.cz>
References: <20230629102051.42E8360467@lion.mk-sys.cz>
MIME-Version: 1.0
Message-ID: <168897683429.404.6801969953192508868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     9f71fbcde2820f2af4658313e808cf1e579190a4
Gitweb:        https://git.kernel.org/tip/9f71fbcde2820f2af4658313e808cf1e579190a4
Author:        Michal Kubecek <mkubecek@suse.cz>
AuthorDate:    Thu, 29 Jun 2023 12:05:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:28 +02:00

objtool: initialize all of struct elf

Function elf_open_read() only zero initializes the initial part of
allocated struct elf; num_relocs member was recently added outside the
zeroed part so that it was left uninitialized, resulting in build failures
on some systems.

The partial initialization is a relic of times when struct elf had large
hash tables embedded. This is no longer the case so remove the trap and
initialize the whole structure instead.

Fixes: eb0481bbc4ce ("objtool: Fix reloc_hash size")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20230629102051.42E8360467@lion.mk-sys.cz
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d420b5d..081befa 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1005,7 +1005,7 @@ struct elf *elf_open_read(const char *name, int flags)
 		perror("malloc");
 		return NULL;
 	}
-	memset(elf, 0, offsetof(struct elf, sections));
+	memset(elf, 0, sizeof(*elf));
 
 	INIT_LIST_HEAD(&elf->sections);
 
