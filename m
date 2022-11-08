Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4862094B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKHGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKHGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:02:48 -0500
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBCCB317CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 22:02:45 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.48:45518.1913755082
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 01E5B28009C;
        Tue,  8 Nov 2022 14:02:21 +0800 (CST)
X-189-SAVE-TO-SEND: +guoj17@chinatelecom.cn
Received: from  ([10.133.8.199])
        by app0024 with ESMTP id 014bcb9567d94db7a99521152a8399a7 for peterz@infradead.org;
        Tue, 08 Nov 2022 14:02:41 CST
X-Transaction-ID: 014bcb9567d94db7a99521152a8399a7
X-Real-From: guoj17@chinatelecom.cn
X-Receive-IP: 10.133.8.199
X-MEDUSA-Status: 0
Sender: guoj17@chinatelecom.cn
From:   guoj17@chinatelecom.cn
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org
Cc:     longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, llvm@lists.linux.dev,
        huyd12@chinatelecom.cn, Guo Jin <guoj17@chinatelecom.cn>
Subject: [PATCH] locking: fix kernel/locking/ inline asm error
Date:   Tue,  8 Nov 2022 14:01:26 +0800
Message-Id: <20221108060126.2505-1-guoj17@chinatelecom.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Jin <guoj17@chinatelecom.cn>

When compiling linux 6.1.0-rc3 configured with CONFIG_64BIT=y
and CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0,
an error: "<inline asm> error: changed section flags for
.spinlock.text, expected:: 0x6" occurred.

The reason is the .spinlock.text in kernel/locking/qspinlock.o
is used many times, but its flags are omitted in subsequent use.

LLVM 11.0 assembler didn't permit to
leave out flags in subsequent uses of the same sections.

So this patch adds the corresponding flags to avoid above error.

Signed-off-by: Guo Jin <guoj17@chinatelecom.cn>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 60ece592b220..dbb38a6b4dfb 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -37,7 +37,7 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .spinlock.text;"
+asm    (".pushsection .spinlock.text, \"ax\";"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
-- 
2.25.1

