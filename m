Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9695706CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjEQP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjEQP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:20 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE6E8;
        Wed, 17 May 2023 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684337224;
        bh=cGY+UUiS0WxsYW24i8f6zUJg+b2UGm/oIzYRyqAGABQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJVyQm7GdpTCkFgl5YFT51SZEn4RQShO5JKmoP4KqC6BkFLube50vwhpFwOY/n/s2
         DO7VeKFwt9vnBWPd2OjzuULKWw0xMd3AdrBR1R4ts2sGCjsEYEnVgurvrvZvLHHHPZ
         gCaMCjEFGlI3+lLXub5gTl9TAqIEe4NIT3OAuWjzmXBMZV0t7tLiHW18Ai+jIwUV/i
         w5wbQqzRrKevyVI8TyZgcTq4vIXWS85zvCR7AEywByqoJ/OL9qe9ZaCkTJJWLO8hAi
         um0Nw0ZLy0DpWzOAZYKjBDH/vRGmO6eWQxAANn9/74b+NtfaGEadt5DYLjmg/OSdqx
         YR32xMs+jOIEw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLxmS1S00z12Mc;
        Wed, 17 May 2023 11:27:04 -0400 (EDT)
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
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 2/4] selftests/rseq: Add sched_state rseq field and getter
Date:   Wed, 17 May 2023 11:26:52 -0400
Message-Id: <20230517152654.7193-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend struct rseq in the rseq selftests to include the sched_state
field. Implement a getter function for this field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h | 17 +++++++++++++++++
 tools/testing/selftests/rseq/rseq.h     |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index fb4ec8a75dd4..15ec333e9eec 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -37,6 +37,13 @@ enum rseq_abi_cs_flags {
 		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_sched_state {
+	/*
+	 * Task is currently running on a CPU if bit is set.
+	 */
+	RSEQ_SCHED_STATE_ON_CPU		= (1U << 0),
+};
+
 /*
  * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -164,6 +171,16 @@ struct rseq_abi {
 	 */
 	__u32 mm_cid;
 
+	/*
+	 * Restartable sequences sched_state field. Updated by the kernel. Read
+	 * by user-space with single-copy atomicity semantics. This fields can
+	 * be read by any userspace thread. Aligned on 32-bit. Contains a
+	 * bitmask of enum rseq_sched_state. This field is provided as a hint
+	 * by the scheduler, and requires that the page holding struct rseq is
+	 * faulted-in for the state update to be performed by the scheduler.
+	 */
+	__u32 sched_state;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d7364ea4d201..348e9385cb2b 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -236,6 +236,11 @@ static inline void rseq_prepare_unload(void)
 	rseq_clear_rseq_cs();
 }
 
+static inline uint32_t rseq_current_sched_state(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->sched_state);
+}
+
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
 		       intptr_t *v, intptr_t expect,
-- 
2.25.1

