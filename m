Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D263711F20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjEZFQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZFQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:16:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19750187
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:06 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKnsG8003860
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:05 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9b0nga2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:05 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 22:16:04 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id CC8761E38AFF2; Thu, 25 May 2023 22:15:55 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <mcgrof@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <rppt@kernel.org>,
        <kent.overstreet@linux.dev>, Song Liu <song@kernel.org>
Subject: [PATCH 2/3] ftrace: Add swap_func to ftrace_process_locs()
Date:   Thu, 25 May 2023 22:15:28 -0700
Message-ID: <20230526051529.3387103-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526051529.3387103-1-song@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DFU50NVx-2vtlt-d7KwQUtP8fL1aCIvi
X-Proofpoint-GUID: DFU50NVx-2vtlt-d7KwQUtP8fL1aCIvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_process_locs sorts module mcount, which is inside RO memory. Add a
ftrace_swap_func so that archs can use RO-memory-poke function to do the
sorting.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/ftrace.c  | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b23bdd414394..fe443b8ed32c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1166,4 +1166,6 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+void ftrace_swap_func(void *a, void *b, int n);
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 764668467155..f5ddc9d4cfb6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6430,6 +6430,17 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+void __weak ftrace_swap_func(void *a, void *b, int n)
+{
+	unsigned long t;
+
+	WARN_ON_ONCE(n != sizeof(t));
+
+	t = *((unsigned long *)a);
+	*(unsigned long *)a = *(unsigned long *)b;
+	*(unsigned long *)b = t;
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6455,7 +6466,7 @@ static int ftrace_process_locs(struct module *mod,
 	 */
 	if (!IS_ENABLED(CONFIG_BUILDTIME_MCOUNT_SORT) || mod) {
 		sort(start, count, sizeof(*start),
-		     ftrace_cmp_ips, NULL);
+		     ftrace_cmp_ips, ftrace_swap_func);
 	} else {
 		test_is_sorted(start, count);
 	}
-- 
2.34.1

