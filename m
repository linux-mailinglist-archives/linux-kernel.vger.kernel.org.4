Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118DE67CA20
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjAZLit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjAZLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:38:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14012F3E;
        Thu, 26 Jan 2023 03:38:46 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674733124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPz9swyqZgOYPLbSHH2/c/M8L2Y4Ct7oaZFQAiHlevs=;
        b=mtLlOIjOnVSyM0JhlMa1bU5KDiA0DcJlaeR69tZHxtl8f8bqV/dANNauSQRiA0jH0Y5rRs
        o9FU2+aypa4ozLxMbQcOzlKzB09SoiT0mTszQcoebzFEYqp1/gRFtVcRn2dcY75hwTGBfU
        pb6XunMkLrX+7zNWwm25plWDovGOhC9I8e0Jkr4SnwRsjRyN3QyMm7i5LHAsRhTcqOxSa4
        WZi60vL1xT5+TjjEdpcig9WCYPbdBHcM++vKD2vI8hKxux8PkyWCrQic9QVe2B9pVmWZnq
        mgp0bsr9IvA2UvovWq00ffC+MZWWPqlmn/ANGHgPMQUWVb1ZTjh3uM90qN9MBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674733124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPz9swyqZgOYPLbSHH2/c/M8L2Y4Ct7oaZFQAiHlevs=;
        b=FXpZcnzTHJ1PHLmj7cVEfSiuav08BB5hhMFJXsoOtE9DTB5RqG65NIJTHtdHqDiwmmsVXq
        3bipYeWKbaogPYAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/PAT: Use try_cmpxchg() in set_page_memtype()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230116163446.4734-1-ubizjak@gmail.com>
References: <20230116163446.4734-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <167473312377.4906.2715991801418807356.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     50fd4d5e6914b60ea6f89c2cbff7a07799414c62
Gitweb:        https://git.kernel.org/tip/50fd4d5e6914b60ea6f89c2cbff7a07799414c62
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jan 2023 17:34:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jan 2023 11:49:39 +01:00

x86/PAT: Use try_cmpxchg() in set_page_memtype()

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
set_page_memtype.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230116163446.4734-1-ubizjak@gmail.com
---
 arch/x86/mm/pat/memtype.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5..6d1ba2d 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -159,10 +159,10 @@ static inline void set_page_memtype(struct page *pg,
 		break;
 	}
 
+	old_flags = READ_ONCE(pg->flags);
 	do {
-		old_flags = pg->flags;
 		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
-	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
+	} while (!try_cmpxchg(&pg->flags, &old_flags, new_flags));
 }
 #else
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
