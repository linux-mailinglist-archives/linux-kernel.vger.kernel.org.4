Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679C656ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiL0MP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiL0MOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2BE97;
        Tue, 27 Dec 2022 04:13:54 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEI2h/BRCO33DzPTWoOw6K+Y/WyQpvpk6lfZm4s29SM=;
        b=i6adXOC4ZtiVB3QhOIhGRnX+ByYG1Jbcqb7fjAv/PfdCFLfCo7qhctq5gNedQqwvwv+CMT
        f4fCpdW5DA/HCpBGOfXnzf5589b2n/aX2O5ayPFPXVl+8jbrGYvgKdI1ET6PmVHd2Izmzt
        9LTBXkUG98IS2ODmA9cDy+Qki3p2biP8alpw+dXcom2VIXq5T68ngckPzKHbOX1m95g4T5
        dgrYJHbLpZOYuFAuhHOJ3mHLkY4O7EYhsM+2ioLBC+kajC26O32ZuCepjHiKJevjbmQlYO
        bFifKe3yGZOSKmfMxeeIYH7su8X8PvalXELaZwa67QIx22vGqpAaaQZ9BARa4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEI2h/BRCO33DzPTWoOw6K+Y/WyQpvpk6lfZm4s29SM=;
        b=Qsy1piDnaPlM8pgZD0aPZFycWaL9hdPaIi/pASnHXUt5t/DKkOaqJ10k+xAcyjUzceCmS4
        1Y4+ZAFTuFDs+mBA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Implement rseq mm_cid field support
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-11-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-11-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323114.4906.1139384318093660637.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     18c2355838e76788f61849f4d83513b103d68b95
Gitweb:        https://git.kernel.org/tip/18c2355838e76788f61849f4d83513b103d68b95
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:12 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:12 +01:00

selftests/rseq: Implement rseq mm_cid field support

Add support for the mm_cid field (per-memory-map concurrency ID) of
struct rseq to rseq selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-11-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-abi.h |  9 +++++++++
 tools/testing/selftests/rseq/rseq.h     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a1faa91..fb4ec8a 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -156,6 +156,15 @@ struct rseq_abi {
 	__u32 node_id;
 
 	/*
+	 * Restartable sequences mm_cid field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's concurrency ID
+	 * (allocated uniquely within a memory map).
+	 */
+	__u32 mm_cid;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index fd17d0e..10ebf13 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -191,6 +191,16 @@ static inline uint32_t rseq_current_node_id(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
 }
 
+static inline bool rseq_mm_cid_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, mm_cid);
+}
+
+static inline uint32_t rseq_current_mm_cid(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->mm_cid);
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
