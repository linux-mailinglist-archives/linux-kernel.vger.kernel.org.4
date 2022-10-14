Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB75FF552
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJNVYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJNVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:24:27 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD591DDDEE;
        Fri, 14 Oct 2022 14:24:09 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 15 Oct
 2022 00:23:10 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Oleg Nesterov <oleg@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/13] sparc: ptrace: user_regset_copyin_ignore() always returns 0
Date:   Sat, 15 Oct 2022 00:22:34 +0300
Message-ID: <20221014212235.10770-13-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221014212235.10770-1-s.shtylyov@omp.ru>
References: <20221014212235.10770-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.75.138]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/14/2022 21:00:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 173137 [Oct 14 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 500 500 6cc86d8f5638d79810308830d98d6b6279998c49
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;178.176.75.138:7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/14/2022 21:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/14/2022 3:23:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_regset_copyin_ignore() always returns 0, so checking its result seems
pointless -- don't do this anymore...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 arch/sparc/kernel/ptrace_32.c |  9 +++++----
 arch/sparc/kernel/ptrace_64.c | 23 +++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index e7db48acb838..c273ccebea46 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -158,8 +158,9 @@ static int genregs32_set(struct task_struct *target,
 				 35 * sizeof(u32), 36 * sizeof(u32));
 	if (ret || !count)
 		return ret;
-	return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					 36 * sizeof(u32), 38 * sizeof(u32));
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 36 * sizeof(u32),
+				  38 * sizeof(u32));
+	return 0;
 }
 
 static int fpregs32_get(struct task_struct *target,
@@ -203,8 +204,8 @@ static int fpregs32_set(struct task_struct *target,
 					 33 * sizeof(u32),
 					 34 * sizeof(u32));
 	if (!ret)
-		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-						34 * sizeof(u32), -1);
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  34 * sizeof(u32), -1);
 	return ret;
 }
 
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 86a7eb5c27ba..4deba5b6eddb 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -332,8 +332,8 @@ static int genregs64_set(struct task_struct *target,
 	}
 
 	if (!ret)
-		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-						36 * sizeof(u64), -1);
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  36 * sizeof(u64), -1);
 
 	return ret;
 }
@@ -406,8 +406,8 @@ static int fpregs64_set(struct task_struct *target,
 	task_thread_info(target)->fpsaved[0] = fprs;
 
 	if (!ret)
-		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-						35 * sizeof(u64), -1);
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  35 * sizeof(u64), -1);
 	return ret;
 }
 
@@ -473,10 +473,8 @@ static int setregs64_set(struct task_struct *target,
 				 15 * sizeof(u64));
 	if (ret)
 		return ret;
-	ret =user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-				 15 * sizeof(u64), 16 * sizeof(u64));
-	if (ret)
-		return ret;
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+				  15 * sizeof(u64), 16 * sizeof(u64));
 	/* TSTATE */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 &tstate,
@@ -670,8 +668,9 @@ static int genregs32_set(struct task_struct *target,
 	pos *= sizeof(reg);
 	count *= sizeof(reg);
 
-	return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					 38 * sizeof(reg), -1);
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+				  38 * sizeof(reg), -1);
+	return 0;
 }
 
 static int fpregs32_get(struct task_struct *target,
@@ -737,8 +736,8 @@ static int fpregs32_set(struct task_struct *target,
 	task_thread_info(target)->fpsaved[0] = fprs;
 
 	if (!ret)
-		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-						34 * sizeof(u32), -1);
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  34 * sizeof(u32), -1);
 	return ret;
 }
 
-- 
2.26.3

