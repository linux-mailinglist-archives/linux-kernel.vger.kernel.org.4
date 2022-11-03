Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269B618949
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiKCUFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKCUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:05:00 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32320362;
        Thu,  3 Nov 2022 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505899;
        bh=fkx/2owExzHUCN4g/xHByxaw+klP4dt2rTfC0R62Avo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5i7poKYqZ5elj2LTCnnwveYuSn5ZrTHELnjzsWSLvubAUlozPEaDblMqxefhKnQe
         E5CrovNy6klwz3GyHg08/BrHeYUItialMcBXtoU1ns9D9pRUxfcndQSmbfWHdgTbby
         /6npPr4NqWI8TNkYV2vQTE28WIt88YrXsnaW3Dm12W02OB7EGHGDh0rN8K69i4BDfP
         cSpehhdTiaotQuBIaYAGvTfy36STLJKgQfyDrwRhpwRK2wD4AsybWxibZ3Se9FiexO
         iHqm5Oi4xP5a9ASKp9ZDikxC5fqMNQNObVULOhEo76OyVLOpXUZmCSbiiKk7bxEKz4
         arj96J19m1/eA==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F966x8fzg2l;
        Thu,  3 Nov 2022 16:04:58 -0400 (EDT)
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
Subject: [PATCH v5 11/24] selftests/rseq: Implement rseq vm_vcpu_id field support
Date:   Thu,  3 Nov 2022 16:03:46 -0400
Message-Id: <20221103200359.328736-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h |  9 +++++++++
 tools/testing/selftests/rseq/rseq.h     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a1faa9162d52..1ee4740ebe94 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -155,6 +155,15 @@ struct rseq_abi {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences vm_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within a memory space).
+	 */
+	__u32 vm_vcpu_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index fd17d0e54a1b..003e0e3750ce 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -191,6 +191,16 @@ static inline uint32_t rseq_current_node_id(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
 }
 
+static inline bool rseq_vm_vcpu_id_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, vm_vcpu_id);
+}
+
+static inline uint32_t rseq_current_vm_vcpu_id(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->vm_vcpu_id);
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.25.1

