Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBD6B6740
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCLOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCLOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:41:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3604393B;
        Sun, 12 Mar 2023 07:41:19 -0700 (PDT)
Date:   Sun, 12 Mar 2023 14:41:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678632076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3578pmEp378IQxWSc72XQnWqdC6iEAWteZzAqX+ZxU=;
        b=mz/vk25NAYQnhC+MN88gOb60ehNle3T0o8El0GwRDE539kdPF1YC/oG8a12A04zrSNpb0V
        YH5qQlkZCTfefrGmMY34EJkD0HEaoNxvOFeMWuLLHAuIUDrd4V63KiaRgd5+CZ8O3wTtLd
        JS28TOPOyLgyB7zdyG2seo+8f/Y2OgnZwkZ939Yvww8j2z9wur+xX+B6pUlD2duHi3SwUV
        niSfQCuEdtwl/RNODN6W1ayqnqo2BYh8pVU/3blmtR0hvqg0W6wbTSbyKa6ZD+rfpKqGe7
        0gr3T8CmqyropewBaEZ+Je17JgIW2wQWNeYW7H6/ZfLlZc3iPAdM8DiJ87UWyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678632076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3578pmEp378IQxWSc72XQnWqdC6iEAWteZzAqX+ZxU=;
        b=x+z6JfEe4Hr2t4Ox2SfPQ/409kxN6CbiKnNUtzAL3om/PSIGrWEdZiEMC5RR2TeeWLzg76
        QjeX5u5EMiqLcNAA==
From:   "tip-bot2 for Andrzej Hajda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] linux/include: add non-atomic version of xchg
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118154450.73842-2-andrzej.hajda@intel.com>
References: <20230118154450.73842-2-andrzej.hajda@intel.com>
MIME-Version: 1.0
Message-ID: <167863207565.5837.13979748605991037374.tip-bot2@tip-bot2>
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

Commit-ID:     6e58fca8f12015d783df9d155bbb969a09a29e64
Gitweb:        https://git.kernel.org/tip/6e58fca8f12015d783df9d155bbb969a09a29e64
Author:        Andrzej Hajda <andrzej.hajda@intel.com>
AuthorDate:    Wed, 18 Jan 2023 16:44:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Mar 2023 14:03:58 +01:00

linux/include: add non-atomic version of xchg

The pattern of setting variable with new value and returning old
one is very common in kernel. Usually atomicity of the operation
is not required, so xchg seems to be suboptimal and confusing in
such cases.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20230118154450.73842-2-andrzej.hajda@intel.com
---
 include/linux/non-atomic/xchg.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/linux/non-atomic/xchg.h

diff --git a/include/linux/non-atomic/xchg.h b/include/linux/non-atomic/xchg.h
new file mode 100644
index 0000000..f7fa5dd
--- /dev/null
+++ b/include/linux/non-atomic/xchg.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NON_ATOMIC_XCHG_H
+#define _LINUX_NON_ATOMIC_XCHG_H
+
+/**
+ * __xchg - set variable pointed by @ptr to @val, return old value
+ * @ptr: pointer to affected variable
+ * @val: value to be written
+ *
+ * This is non-atomic variant of xchg.
+ */
+#define __xchg(ptr, val) ({		\
+	__auto_type __ptr = ptr;	\
+	__auto_type __t = *__ptr;	\
+	*__ptr = (val);			\
+	__t;				\
+})
+
+#endif
