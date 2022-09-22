Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA25E6095
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIVLKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIVLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:24 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EC86896;
        Thu, 22 Sep 2022 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844386;
        bh=fkx/2owExzHUCN4g/xHByxaw+klP4dt2rTfC0R62Avo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrpStuUxUEEsuKoYv95U4+foz6w5Q+fzHAI7tCbmJCB9lmF/98JXWAvP6JQu4RN43
         gFvggQalBe1FXqGP/hTKE9/7iWG4RpY42SUaOsqFoR1gHqHIlnJv6W3rODvpkdz3Lb
         WnepOpoqwSUK3WcK0gfnGM2XBqUKKNF7nVBGu95elmlk7WRCnl3b1UpRhC6XAPeILW
         tnSxrwtFDBReYc797vI5DLZ0DCRsG1NhI/7bLrt9CyudrnXWWNLzGRr7c//igooiG9
         un71yWeanrVp5bKUNK0tWTSmu9hVXsq8d6e8GVl+qqB4MVmIAS/EqAJ6PHSSUPwHGl
         RU6DFcQO4Calg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3Q1JkvzNbw;
        Thu, 22 Sep 2022 06:59:46 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 12/25] selftests/rseq: Implement rseq vm_vcpu_id field support
Date:   Thu, 22 Sep 2022 06:59:27 -0400
Message-Id: <20220922105941.237830-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
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

