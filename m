Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091264FBDD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiLQS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLQSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43310FC9;
        Sat, 17 Dec 2022 10:55:36 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QgGIxxjXPXX5AByY57u1zqywk8dbUi7+e1GgB7Rkt0Y=;
        b=pM+NwnzDN7Jtp0hFFriAUZibIiv0Hf2d8PSVhq0kxwEvJ2DiZ4bsGPNyW9A8XAY2snA/mW
        H5jC7JBeiOUEqjk7QmvFbbnHgs5eXxuistcc0YGvyOfQSQKtIl62gAjagJ+7++mLSF+EfL
        GVV9AKl4lA9FH/K+RZNyAq9+dDHGTmxLmNOQRQsto4vzMvi1Qdzi0SE5o2sGGEGJ/+HKfd
        oezdprsu0nObIeb+/YrIhAroe3jTNdjsDkuDPirwkC8R2+PqesMLeo8cC+qODGxfbeJsve
        FGxjpLmhP7esdQQmkUUdNnTiPCIW4Ci/KNBgIceH3vBI8q8Oq0UIlkPb0kxP0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QgGIxxjXPXX5AByY57u1zqywk8dbUi7+e1GgB7Rkt0Y=;
        b=NYXUx1hoQKOjyQpksuBJr0IE29LpapmWP21Udbkj3IC7HYzXUL79nL2Cat9qJxsOoZn6Wx
        IG+PX1F+hIuxHKCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Remove pointless barrier() after pmdp_get_lockless()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333179.4906.5607292265365831847.tip-bot2@tip-bot2>
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

Commit-ID:     eb780dcae02d5a71e6979aa7b8c708dea8597adf
Gitweb:        https://git.kernel.org/tip/eb780dcae02d5a71e6979aa7b8c708dea8597adf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 13:47:29 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

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
