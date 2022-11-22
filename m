Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167E634883
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiKVUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiKVUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:52 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD189697E8;
        Tue, 22 Nov 2022 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149588;
        bh=Ittf5/h2eFHZsvkRxlERVQgY2E4qLD49CL1ob0scu/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB29dn3YuH5o+c6C31/1e3b2Qv5Zd357TgCdWqBctDiK0bT0DofRffW1hU0ho+/lF
         tQy6uhTXy/dfVXEJx7SSmFzzi9NW2K2jG+6BhpO1MCWqHsJz0d+ht5b3eMsVALHY1u
         AcVelrcrHog+ucXcj0FucEJKVcDQvS+zhZ7zj1iKI6QuDuZfBw+rTl9QN1iytiGcp9
         G3amSCVSd/OaWU7PpiZJ074mPAyqEysg532AQr79Vn1/TLEDYKjx2Z3yqLqDWwqL5F
         XCdS05wtOBDZ6ymztvEVTET/ASRO3PH6ZygVxtc81w9++NE7d1KqbK6taxApFw/mb0
         D7XyqlGgBwsZw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2X1RYPzXLR;
        Tue, 22 Nov 2022 15:39:48 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 10/30] selftests/rseq: Implement rseq mm_cid field support
Date:   Tue, 22 Nov 2022 15:39:12 -0500
Message-Id: <20221122203932.231377-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the mm_cid field (per-memory-map concurrency ID) of
struct rseq to rseq selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h |  9 +++++++++
 tools/testing/selftests/rseq/rseq.h     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a1faa9162d52..fb4ec8a75dd4 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -155,6 +155,15 @@ struct rseq_abi {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences mm_cid field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's concurrency ID
+	 * (allocated uniquely within a memory map).
+	 */
+	__u32 mm_cid;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index fd17d0e54a1b..10ebf13644fa 100644
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
-- 
2.25.1

