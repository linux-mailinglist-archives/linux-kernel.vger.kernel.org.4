Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55363489E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiKVUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiKVUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:40:12 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3023577203;
        Tue, 22 Nov 2022 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149594;
        bh=x9R+wwQH5rqLJeAi6RdxV1lJR8FdIA7e9hgUlPRECwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnGoELNan/vc9SvhKpw1Z2W9cReETv3HGMpfsFA5aAp8J5FyLHvjo5sSHjqsbjrqx
         TMZvZcr0iuRK4//JAiMJoaVVmOfcfinRJlewZhxgC57UYPeRntGI1BWuAGgkH0/sBm
         N9/Z/LQkfmZx47N4xR8Fo1mHO6WdSnRxRsJowv5uiDO4s6EhFmc6DHVs3Y9jrCIvD6
         rl2QxeP0Lx1MbSGLMEDuYESaUX1oKCJtyQZuHz9aNnRP+6UoalW0vs3xUWYQyw7nwE
         IjwMjtjV7AOxEZh1ylVy+Elatn2F+jR206j1coPcYEu7FRQzAjwIbFDsANCRxhHuXb
         OBuYG9HM/UlBg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2d70T8zWgq;
        Tue, 22 Nov 2022 15:39:53 -0500 (EST)
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
Subject: [PATCH 23/30] cpumask: Implement cpumask_{first,next}_{not,}andnot
Date:   Tue, 22 Nov 2022 15:39:25 -0500
Message-Id: <20221122203932.231377-24-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
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

Allow finding the first or next bit within two input cpumasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c2aa0aa26b45..271bccc0a6d7 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -153,6 +153,32 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
+/**
+ * cpumask_first_notandnot - return the first cpu from ~*srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_notandnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -195,6 +221,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
+/**
+ * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
+/**
+ * cpumask_next_notandnot - return the next cpu from ~*srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_notandnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
 static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-- 
2.25.1

