Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33F616416
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKBNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:51:13 -0400
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 06:51:12 PDT
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22B9E2AE22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:51:11 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:41252.697894223
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-111.197.83.205 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 0A50B2800AF;
        Wed,  2 Nov 2022 21:41:59 +0800 (CST)
X-189-SAVE-TO-SEND: +guoj17@chinatelecom.cn
Received: from  ([111.197.83.205])
        by app0025 with ESMTP id 1d324c0c76e9441fbf918901a6aaf0b6 for tglx@linutronix.de;
        Wed, 02 Nov 2022 21:42:15 CST
X-Transaction-ID: 1d324c0c76e9441fbf918901a6aaf0b6
X-Real-From: guoj17@chinatelecom.cn
X-Receive-IP: 111.197.83.205
X-MEDUSA-Status: 0
Sender: guoj17@chinatelecom.cn
From:   guoj17@chinatelecom.cn
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        Guo Jin <guoj17@chinatelecom.cn>
Subject: [PATCH] locking: fix inline asm error
Date:   Wed,  2 Nov 2022 21:41:55 +0800
Message-Id: <20221102134155.2001-1-guoj17@chinatelecom.cn>
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

When compiling linux configured with CONFIG_64BIT=y
and CONFIG_PARAVIRT_SPINLOCKS=y on x86_64 using LLVM 11.0,
the .spinlock.text is used many times,
But its flags are omitted in subsequent use.

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

