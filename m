Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D3610A69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJ1GmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJ1Glj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8DB1DCD;
        Thu, 27 Oct 2022 23:41:35 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=418PeG1m3KiESUjrABGHYXcYvntC5lkqgItingIMeP8=;
        b=m4blkYTVRISE9h01oLV9GZUua+GHJSmoj6X8r/1p1W+1fbMc9IKf3uAtgW3I4Bno4/kJNS
        MV/vaB2Cc/6LU+6/q/+Nn7am/k6Sz/du4Y8Le+i9t8dr9vwueyRPYkf5pgnvABnYfPGXYy
        x8fo+Jpo6xNUtJJhwqgxF8WS+mwJ2Plb0Hq8o1lfijpRXqJ0TpIgD4ypqtqxQJ7HJfhcQn
        xlTK8sFn/uZqStU01ycqfdmgzTSJ/Pp3+YTDYg9Z5iacuNLGrC8UbaUNK2/IrULUcEXHDd
        6RQ8tEAIkkPHCh0X7g1lmqeG5sdOy4BggHNNZEnImM+ZMo94xvknM9aY3KDrlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=418PeG1m3KiESUjrABGHYXcYvntC5lkqgItingIMeP8=;
        b=QIBf+Z9PgrlliPNlwsv+LK5jWP/olRmOyprkpIRaJhXg9HRsgMmmS2/b82RNhds8adi44m
        nn3I74QEhvCXm8Dw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Use atomic_try_cmpxchg() in
 static_key_slow_inc_cpuslocked()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221019140850.3395-1-ubizjak@gmail.com>
References: <20221019140850.3395-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <166693929232.29415.8209039784382977219.tip-bot2@tip-bot2>
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

Commit-ID:     d0c006402e7941558e5283ae434e2847c7999378
Gitweb:        https://git.kernel.org/tip/d0c006402e7941558e5283ae434e2847c7999378
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 19 Oct 2022 16:08:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 10:35:41 +02:00

jump_label: Use atomic_try_cmpxchg() in static_key_slow_inc_cpuslocked()

Use atomic_try_cmpxchg() instead of atomic_cmpxchg (*ptr, old, new) ==
old in static_key_slow_inc_cpuslocked().  x86 CMPXCHG instruction
returns success in ZF flag, so this change saves a compare after
cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_try_cmpxchg() implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221019140850.3395-1-ubizjak@gmail.com
---
 kernel/jump_label.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 714ac4c..4d6c6f5 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -115,8 +115,6 @@ EXPORT_SYMBOL_GPL(static_key_count);
 
 void static_key_slow_inc_cpuslocked(struct static_key *key)
 {
-	int v, v1;
-
 	STATIC_KEY_CHECK_USE(key);
 	lockdep_assert_cpus_held();
 
@@ -132,11 +130,9 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
 	 * so it counts as "enabled" in jump_label_update().  Note that
 	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
 	 */
-	for (v = atomic_read(&key->enabled); v > 0; v = v1) {
-		v1 = atomic_cmpxchg(&key->enabled, v, v + 1);
-		if (likely(v1 == v))
+	for (int v = atomic_read(&key->enabled); v > 0; )
+		if (likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)))
 			return;
-	}
 
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
