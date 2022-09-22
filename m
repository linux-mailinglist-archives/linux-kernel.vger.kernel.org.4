Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CE5E6075
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiIVLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIVLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:05:23 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5960D5776;
        Thu, 22 Sep 2022 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844382;
        bh=3FQzak7NFQCeQ17sM6xyWBPLJooy+CEjUwRxboNNo2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+/AbbML2/P0quyAJOv6FkyBz9aZksNSvQzjsfyfY11DV7G6AO+/jMRcaoOAixu3h
         4Rvo2+dCvbyx47fwJNBoEz3xP7P+IYQn5qnKAFEF/5siZ0R7HOnhooLH6nTyP0Q4av
         P3E7FFGSfYZpcFqsUNpk26qX6awghy/8QS6LL4KetWWxZ7UjSO+ZG2yBsu8tsEToC/
         x+gTwrH1YE7j0k+t/Vbi7NZfxpEb9tN5VSJPyyUblxZUBn0D34EU9doL5YsjPpSj2C
         3PDNZgaJc2YHBhVft1bcFw8cBSzUBCQZn8D3/I+eLq/uGZmfxjPsI1DfRHO/gsk7fN
         fM6Joea+Ixd4w==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3L3KNkzNL5;
        Thu, 22 Sep 2022 06:59:42 -0400 (EDT)
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
Subject: [PATCH v4 01/25] rseq: Introduce feature size and alignment ELF auxiliary vector entries
Date:   Thu, 22 Sep 2022 06:59:16 -0400
Message-Id: <20220922105941.237830-2-mathieu.desnoyers@efficios.com>
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

Export the rseq feature size supported by the kernel as well as the
required allocation alignment for the rseq per-thread area to user-space
through ELF auxiliary vector entries.

This is part of the extensible rseq ABI.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 fs/binfmt_elf.c             | 5 +++++
 include/uapi/linux/auxvec.h | 2 ++
 include/uapi/linux/rseq.h   | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..04fca1e4cbd2 100644
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
index c7e502bf5a6f..6991c4b8ab18 100644
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
index 77ee207623a9..05d3c4cdeb40 100644
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
-- 
2.25.1

