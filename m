Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E505FF554
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJNVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJNVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:24:53 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA51DE3E8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:24:26 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 15 Oct
 2022 00:23:11 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Oleg Nesterov <oleg@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 13/13] regset: make user_regset_copyin_ignore() *void*
Date:   Sat, 15 Oct 2022 00:22:35 +0300
Message-ID: <20221014212235.10770-14-s.shtylyov@omp.ru>
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
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 173137 [Oct 14 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 500 500 6cc86d8f5638d79810308830d98d6b6279998c49
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;178.176.75.138:7.7.3;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
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

user_regset_copyin_ignore() apparently cannot fail and so always returns 0.
Let's make this function return *void* instead of *int*...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 include/linux/regset.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/regset.h b/include/linux/regset.h
index a00765f0e8cf..9061266dd8de 100644
--- a/include/linux/regset.h
+++ b/include/linux/regset.h
@@ -275,15 +275,15 @@ static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
 	return 0;
 }
 
-static inline int user_regset_copyin_ignore(unsigned int *pos,
-					    unsigned int *count,
-					    const void **kbuf,
-					    const void __user **ubuf,
-					    const int start_pos,
-					    const int end_pos)
+static inline void user_regset_copyin_ignore(unsigned int *pos,
+					     unsigned int *count,
+					     const void **kbuf,
+					     const void __user **ubuf,
+					     const int start_pos,
+					     const int end_pos)
 {
 	if (*count == 0)
-		return 0;
+		return;
 	BUG_ON(*pos < start_pos);
 	if (end_pos < 0 || *pos < end_pos) {
 		unsigned int copy = (end_pos < 0 ? *count
@@ -295,7 +295,6 @@ static inline int user_regset_copyin_ignore(unsigned int *pos,
 		*pos += copy;
 		*count -= copy;
 	}
-	return 0;
 }
 
 extern int regset_get(struct task_struct *target,
-- 
2.26.3

