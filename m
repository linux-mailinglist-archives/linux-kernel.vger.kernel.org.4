Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92240615F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKBJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKBJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FB7286E4;
        Wed,  2 Nov 2022 02:12:37 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KRprBJxpWWF4vJhuz+AXEAq0eTkLDsVJbi3ANVWEyBA=;
        b=FUlg9kH+jVQvECTV8wNQD08ERj7o8oq0qTHwXT/fVvjmKZ+MM0NfNuIdQV6MzlNJ7b16zF
        3Sv+Aafj8l/9J8ai9vtVY1ssxcysfeM+Z2sgF9rBjXXoW8Ii8D2zctwDjb7f634uEwo8Yx
        R6USifFoDOmAjKno52SF1hr7pEWB0fY9wzb7wYnwCXcwV/4jiBNnc2Z8nXnLSvRj/VJj7P
        UTLVJNn/9Bahn+FgBHplqAQk3/CSZ3oHGStai6BPwa0/aF9z+IzXzyOaCiNrty11zqQ8p2
        U/QadX00z3DE6ebVyKWv7ttBzhKE04rLWrmhiTlMZO0Iqk312aviYw9Ic8ZpHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KRprBJxpWWF4vJhuz+AXEAq0eTkLDsVJbi3ANVWEyBA=;
        b=vEzti0jCBKQbkJxdGJ3a3fiY46RhS5KfcXjtkpmgGteTYT1wvQ0ReEocEU+WitPJXgzX2z
        CzKHrmS+XMGakyBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Remove pointless barrier() after pmdp_get_lockless()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035298.7716.13942934814030999868.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0aa82c4e78ca59a2246a28112adbee7d0a692f27
Gitweb:        https://git.kernel.org/tip/0aa82c4e78ca59a2246a28112adbee7d0a692f27
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 13:47:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:05 +01:00

mm: Remove pointless barrier() after pmdp_get_lockless()

pmdp_get_lockless() should itself imply any ordering required.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114425.298833095%40infradead.org
---
 mm/hmm.c    | 1 -
 mm/vmscan.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 39cf50d..601a99c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -362,7 +362,6 @@ again:
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		barrier();
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 88ef873..4936a88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4041,9 +4041,6 @@ restart:
 	for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
 		pmd_t val = pmdp_get_lockless(pmd + i);
 
-		/* for pmdp_get_lockless() */
-		barrier();
-
 		next = pmd_addr_end(addr, end);
 
 		if (!pmd_present(val) || is_huge_zero_pmd(val)) {
