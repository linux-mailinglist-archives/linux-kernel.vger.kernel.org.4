Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C45E606D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIVLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIVLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:05:19 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A34D5776;
        Thu, 22 Sep 2022 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844385;
        bh=G7nQnVsC34L6BXYJjaOh5p1rpxLyYjvhnfFLcfQJn88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISZ0aV5qeyurF0urqswF6ZFx16t+H93xj50z/loLEUQc+3IhphL/hqwCXQAhjBwxk
         r75IXDyCMhDBGHOFBgmDRIVzkgf7QkEmFVxRyKOHbBRAF2sJs3bYVQAhmBq0LY6nWs
         FwwB85+qNxoJ5Woyt3llWPoAfxCu/gBlmCYbF8O468ghAs+/x4MX2zGBDvJ6vPzebq
         hAYd7FedMGCKqGx7EjtrRibSEqFqrG/kL02Qb6G3n3tuOyzE7KnWIKZ8BmXMIHiKZm
         EjzoThOlnRL5LVB9zzL0awElYCAJFuDbbRIT3RV2hNZkk6fk3W13LAAcRrmJGXMBwl
         xJzjRSGOdDzNw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3N5pr4zNnd;
        Thu, 22 Sep 2022 06:59:44 -0400 (EDT)
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
Subject: [PATCH v4 08/25] cpumask: Implement cpumask_{first,next}_{zero,one}_and_zero
Date:   Thu, 22 Sep 2022 06:59:23 -0400
Message-Id: <20220922105941.237830-9-mathieu.desnoyers@efficios.com>
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

Allow finding the first or next bit within two input cpumasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/cpumask.h | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..0f5c3e47423f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -134,6 +134,18 @@ static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
 	return 0;
 }
 
+static inline unsigned int cpumask_first_one_and_zero(const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return 0;
+}
+
+static inline unsigned int cpumask_first_zero_and_zero(const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return 0;
+}
+
 static inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return 0;
@@ -157,6 +169,20 @@ static inline unsigned int cpumask_next_and(int n,
 	return n+1;
 }
 
+static inline unsigned int cpumask_next_one_and_zero(int n,
+					     const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return n+1;
+}
+
+static inline unsigned int cpumask_next_zero_and_zero(int n,
+					     const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return n+1;
+}
+
 static inline unsigned int cpumask_next_wrap(int n, const struct cpumask *mask,
 					     int start, bool wrap)
 {
@@ -230,6 +256,32 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_first_one_and_zero - return the first cpu from *srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_one_and_zero(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
+/**
+ * cpumask_first_zero_and_zero - return the first cpu from ~*srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_zero_and_zero(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -258,6 +310,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
+/**
+ * cpumask_next_one_and_zero - return the next cpu from *srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_one_and_zero(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_one_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
+/**
+ * cpumask_next_zero_and_zero - return the next cpu from ~*srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_zero_and_zero(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_zero_and_zero_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
 int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
-- 
2.25.1

