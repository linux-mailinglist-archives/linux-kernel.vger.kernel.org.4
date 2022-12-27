Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE21656AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiL0MQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiL0MOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F5272D;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YHleamizsjcxSTKmwNgxXpWw4wPScZashrcfCs99co=;
        b=SCslnUXkYfexq0UHIhkMHYcEPmIVv1GdRuPOAuaNJBZuB2a3MOMYdAMbLG5tAY+xa6T+nA
        iBnuhz2L5eCdY2RNAi+70y7xMLLnzKGzJI5HBeR5YQfali73KF+zzzu8+CJx8LyyNeW52V
        Vpe/LU3DS0oZJ+VFCjYGjAD0JJNM9g7eR3MyN0NYFrMsj2xn8oKmsAJZH3tHWp8tG9tWD1
        bqiht+mPhyUw0Fuy52C94tpTfksz0uikbkb1t8G7QUDQpkVwELZUOblgmhhVGx6CAG1Zt4
        +t0UtYMJhbYUS4as98A/Unek3OR4AChWMm69hrvJgvVFMVh14rckcsYKQZmVhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YHleamizsjcxSTKmwNgxXpWw4wPScZashrcfCs99co=;
        b=8e9WYj7NxFLkQtxfOsrtg3qWHtUMmBcedsN6xEv92xHQThboLbkt8gnHfUEi4guoSrEfMc
        9EzicD1g9U3PiEAg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-3-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323264.4906.3609141535442160200.tip-bot2@tip-bot2>
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

Commit-ID:     317c8194e6aeb8b3b573ad139fc2a0635856498e
Gitweb:        https://git.kernel.org/tip/317c8194e6aeb8b3b573ad139fc2a0635856498e
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:04 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:10 +01:00

rseq: Introduce feature size and alignment ELF auxiliary vector entries

Export the rseq feature size supported by the kernel as well as the
required allocation alignment for the rseq per-thread area to user-space
through ELF auxiliary vector entries.

This is part of the extensible rseq ABI.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-3-mathieu.desnoyers@efficios.com
---
 fs/binfmt_elf.c             | 5 +++++
 include/uapi/linux/auxvec.h | 2 ++
 include/uapi/linux/rseq.h   | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index de63572..0ba86f0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -46,6 +46,7 @@
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
+#include <linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -288,6 +289,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	if (bprm->have_execfd) {
 		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
 	}
+#ifdef CONFIG_RSEQ
+	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
+	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
+#endif
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
 	memset(elf_info, 0, (char *)mm->saved_auxv +
diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index c7e502b..6991c4b 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -30,6 +30,8 @@
 				 * differ from AT_PLATFORM. */
 #define AT_RANDOM 25	/* address of 16 random bytes */
 #define AT_HWCAP2 26	/* extension of AT_HWCAP */
+#define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
+#define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
 
 #define AT_EXECFN  31	/* filename of program */
 
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 77ee207..05d3c4c 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -130,6 +130,11 @@ struct rseq {
 	 *     this thread.
 	 */
 	__u32 flags;
+
+	/*
+	 * Flexible array member at end of structure, after last feature field.
+	 */
+	char end[];
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _UAPI_LINUX_RSEQ_H */
