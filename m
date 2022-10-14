Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15C5FF549
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJNVXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJNVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:23:34 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB351DD8BC;
        Fri, 14 Oct 2022 14:23:23 -0700 (PDT)
Received: from localhost.localdomain (178.176.75.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 15 Oct
 2022 00:23:06 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 06/13] mips: ptrace: user_regset_copyin_ignore() always returns 0
Date:   Sat, 15 Oct 2022 00:22:28 +0300
Message-ID: <20221014212235.10770-7-s.shtylyov@omp.ru>
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
 arch/mips/kernel/ptrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 567aec4abac0..d9df543f7e2c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -531,10 +531,11 @@ static int fpr_set(struct task_struct *target,
 		ptrace_setfcr31(target, fcr31);
 	}
 
-	if (count > 0)
-		err = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-						fir_pos,
-						fir_pos + sizeof(u32));
+	if (count > 0) {
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					  fir_pos, fir_pos + sizeof(u32));
+		return 0;
+	}
 
 	return err;
 }
-- 
2.26.3

