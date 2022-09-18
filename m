Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9A5BBB35
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIRDIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIRDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383F27159
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q11so15400302qkc.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SBOziEHkuH3w7/25l1oW2hkJ2TfdUUpVoIxYlWXHHvA=;
        b=Eips4MEH0hXW7hGRgRT+q3D1fUYpQ4rU/J2zk97cwSqUd4+CX8dXiYWZZjqiUwE7RP
         omcBLor5ov3jJk63zBPOzt7rJFsC6A3uux6r9H2ub+40Ia3YUvoHomcgKI21Oz4CxWHZ
         gJy3zVrH1+CMKYYwwUWYZbcosKS1hNVSEF2JIz6FkqEoWqCj20uNb9EAJhEuVayKAkmb
         Zao49cv2ZJUVWWLlnJbeXTQk4s7m8TXrcecbM4m5T5mM6WYL0aZGaNbzT0gUrfCAff0v
         AJWmACo4uIgAz0mhr1kCzWIOSRHSf4xudMBR43hA2/iphGUqL4zwqlRIAERYeM6WO48/
         ErBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SBOziEHkuH3w7/25l1oW2hkJ2TfdUUpVoIxYlWXHHvA=;
        b=1LXOcyf0C/haRP5xhEoaRtHQJwVrXbYiJnuPysVyJ92D1UpIdDPz0h0BAX3LyvejFB
         jvNqrOHN0La/DxhE7OavOEeyVdTgULBxMrWPQ3bFffWSbczRqFduru1bUBcO8eGeML8P
         quIG/vztCwnihUmPv0Y8Md3+Hk/NKT0wwv5h4c9A/MYWsP98yQ2UoNq0LzbtUd237UhR
         +zH97cZD94XwZcBIX+KvY7aInOQnb4DU/qBV/BUMieeCkOJI3bSKFdrzD+Hh2ppAoGBz
         m4PgT072m1gWnPfTe4e61RzjfFOX8wN4sJBWIEfy+HXN7JVLTqwOLiRk645o1dfmSQe0
         qjvA==
X-Gm-Message-State: ACrzQf2KAxU8l9vI6LKnKgbjq/kESIyNrFBZ4JvsD3E6r7tru5zJ3yDI
        9jQy4sj6d/uBx3XHuRP/C5TGyw4Hw0A=
X-Google-Smtp-Source: AMsMyM6hCNQmI2r9Ld2t4MZN5RE5pkAfvZvt4nHfjynB+SEZVXifdBE9DznHwiaavnj6QBb52cyepA==
X-Received: by 2002:a05:620a:f8e:b0:6cc:1c3a:4f5d with SMTP id b14-20020a05620a0f8e00b006cc1c3a4f5dmr8833133qkn.425.1663470444652;
        Sat, 17 Sep 2022 20:07:24 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006bb49cfe147sm9319549qkb.84.2022.09.17.20.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:24 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 6/6] cpumask: add cpumask_nth_{,and,andnot}
Date:   Sat, 17 Sep 2022 20:07:16 -0700
Message-Id: <20220918030716.1252285-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918030716.1252285-1-yury.norov@gmail.com>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpumask_nth_{,and,andnot} as wrappers around corresponding
find functions, and use it in cpumask_local_spread().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 44 +++++++++++++++++++++++++++++++++++++++++
 lib/cpumask.c           | 28 ++++++++++++--------------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 31bf08c786e3..621b59820561 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -337,6 +337,50 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 	return i;
 }
 
+/**
+ * cpumask_nth - get the first cpu in a cpumask
+ * @srcp: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 0
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
+{
+	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, cpumask_check(cpu));
+}
+
+/**
+ * cpumask_nth_and - get the first cpu in 2 cpumasks
+ * @srcp1: the cpumask pointer
+ * @srcp2: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 0
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline
+unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
+							const struct cpumask *srcp2)
+{
+	return find_nth_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				nr_cpumask_bits, cpumask_check(cpu));
+}
+
+/**
+ * cpumask_nth_andnot - get the first cpu set in 1st cpumask, and clear in 2nd.
+ * @srcp1: the cpumask pointer
+ * @srcp2: the cpumask pointer
+ * @cpu: the N'th cpu to find, starting from 0
+ *
+ * Returns >= nr_cpu_ids if such cpu doesn't exist.
+ */
+static inline
+unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
+							const struct cpumask *srcp2)
+{
+	return find_nth_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2),
+				nr_cpumask_bits, cpumask_check(cpu));
+}
+
 #define CPU_BITS_NONE						\
 {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] = 0UL			\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index f0ae119be8c4..2c4a63b6f03f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -128,23 +128,21 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	i %= num_online_cpus();
 
 	if (node == NUMA_NO_NODE) {
-		for_each_cpu(cpu, cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
+		cpu = cpumask_nth(i, cpu_online_mask);
+		if (cpu < nr_cpu_ids)
+			return cpu;
 	} else {
 		/* NUMA first. */
-		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
-			if (i-- == 0)
-				return cpu;
-
-		for_each_cpu(cpu, cpu_online_mask) {
-			/* Skip NUMA nodes, done above. */
-			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
-				continue;
-
-			if (i-- == 0)
-				return cpu;
-		}
+		cpu = cpumask_nth_and(i, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
+
+		i -= cpumask_weight_and(cpu_online_mask, cpumask_of_node(node));
+
+		/* Skip NUMA nodes, done above. */
+		cpu = cpumask_nth_andnot(i, cpu_online_mask, cpumask_of_node(node));
+		if (cpu < nr_cpu_ids)
+			return cpu;
 	}
 	BUG();
 }
-- 
2.34.1

