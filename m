Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791EB69796D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjBOKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjBOKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:00:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D7367D2;
        Wed, 15 Feb 2023 02:00:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E7061AEC;
        Wed, 15 Feb 2023 10:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F6AC433D2;
        Wed, 15 Feb 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676455225;
        bh=43J0YXNjBb0jRxtz8vThlKhvDOdInf9zkQbt27M+QHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5m4bayXDWcNaGfj+KlsYW91nrNt0XyfqKbJsSapZKcihPDWU07jK9kFJ9jl4c0aL
         OXeFeFQwOokzSz5cbkPYNuxHJbS9S+3/lc/LxnNL6eYxhD7h0PG0YnbGfTJQnj/msL
         quq8myu4TLjDy3YVBOI8w4gPsC78+n6VZ4KaScIcxZAg3bgdwn8CvjTmYBLVI1OJfy
         lbfgS9kR5RSt+7fOqzukFgfaKVyUKuZqzL2DBqEV6gxEqzFpMEanlzmtS3pJ6vUeGt
         v97LcMSMCl3dS0VxjtMAYjoVToiCb9BrbjeEEtJF4yanD2WtPW7Q2dA43DXLSo3fsa
         +fwIlKcwA8Pzw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: [RFC PATCH 2/5] kernel: Drop IA64 support from sig_fault handlers
Date:   Wed, 15 Feb 2023 11:00:05 +0100
Message-Id: <20230215100008.2565237-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215100008.2565237-1-ardb@kernel.org>
References: <20230215100008.2565237-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273; i=ardb@kernel.org; h=from:subject; bh=43J0YXNjBb0jRxtz8vThlKhvDOdInf9zkQbt27M+QHU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj7K0TpTQjBcfOZcP32cK1/Uz0i9BerrtVwIY1k V4p5TfewjqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+ytEwAKCRDDTyI5ktmP JI17C/9BVjb63M4G2YtKEMbiajE+wbi0zUus/MBs9dX9NHtasw4I9yBfSM2v8jLBwY72h/vMuAQ h/a6Zi+//p+0sg7TxVhHUmat+Mk0cEklPj7Ngq/67bwtPuU6KnonOENiB7cl4xdXnQiZt0r4WcP NiRUGZf7wXJJ+c79LurhvWUgs8q5lJ5GmdP1pEF0CrStgChl9z70qWaAwo57+A765BHkB2qO/1O gzA5lPsxyzsWTzSXgwl8dJM2IjuqkHBHdW90OOXb1By8Emhz9OYs3q+bnNlwWPc4lnddjUeoWWO rPCXgMpzA/1II6vAqZ5gApHFvlPrSXZkc3ouipnumLdJE03WIBOQQTG7oew2wSiBI5oQX8MZMOV ZRXMjpu0NCYAk1N3Yg3e0isT6KrdZzNAAEuBNUusSPDD+t3fv3QtOqlR5WXSK10sEVw918jiV7z uIvc0G1L02/bqEb04zRAHLuxgsgF+8vJZ6M6xfkOiKSkOZDiB/8ScaSuB0eBgIZL5eRsI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/sched/signal.h | 17 ++++---------
 kernel/signal.c              | 25 ++++----------------
 2 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 20099268fa257f40..6aecfbf823656f6c 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -303,20 +303,11 @@ static inline void kernel_signal_stop(void)
 
 	schedule();
 }
-#ifdef __ia64__
-# define ___ARCH_SI_IA64(_a1, _a2, _a3) , _a1, _a2, _a3
-#else
-# define ___ARCH_SI_IA64(_a1, _a2, _a3)
-#endif
 
-int force_sig_fault_to_task(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t);
-int force_sig_fault(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr));
-int send_sig_fault(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t);
+int force_sig_fault_to_task(int sig, int code, void __user *addr,
+			    struct task_struct *t);
+int force_sig_fault(int sig, int code, void __user *addr);
+int send_sig_fault(int sig, int code, void __user *addr, struct task_struct *t);
 
 int force_sig_mceerr(int code, void __user *, short);
 int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
diff --git a/kernel/signal.c b/kernel/signal.c
index ae26da61c4d9fa6a..5b7f0bf2713901da 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1701,9 +1701,8 @@ void force_sigsegv(int sig)
 		force_sig(SIGSEGV);
 }
 
-int force_sig_fault_to_task(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t)
+int force_sig_fault_to_task(int sig, int code, void __user *addr,
+			    struct task_struct *t)
 {
 	struct kernel_siginfo info;
 
@@ -1712,24 +1711,15 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_errno = 0;
 	info.si_code  = code;
 	info.si_addr  = addr;
-#ifdef __ia64__
-	info.si_imm = imm;
-	info.si_flags = flags;
-	info.si_isr = isr;
-#endif
 	return force_sig_info_to_task(&info, t, HANDLER_CURRENT);
 }
 
-int force_sig_fault(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr))
+int force_sig_fault(int sig, int code, void __user *addr)
 {
-	return force_sig_fault_to_task(sig, code, addr
-				       ___ARCH_SI_IA64(imm, flags, isr), current);
+	return force_sig_fault_to_task(sig, code, addr, current);
 }
 
-int send_sig_fault(int sig, int code, void __user *addr
-	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-	, struct task_struct *t)
+int send_sig_fault(int sig, int code, void __user *addr, struct task_struct *t)
 {
 	struct kernel_siginfo info;
 
@@ -1738,11 +1728,6 @@ int send_sig_fault(int sig, int code, void __user *addr
 	info.si_errno = 0;
 	info.si_code  = code;
 	info.si_addr  = addr;
-#ifdef __ia64__
-	info.si_imm = imm;
-	info.si_flags = flags;
-	info.si_isr = isr;
-#endif
 	return send_sig_info(info.si_signo, &info, t);
 }
 
-- 
2.39.1

