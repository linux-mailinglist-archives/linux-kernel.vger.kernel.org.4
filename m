Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5C64A827
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiLLTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiLLTff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:35:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B577D62CD;
        Mon, 12 Dec 2022 11:35:34 -0800 (PST)
Date:   Mon, 12 Dec 2022 19:35:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670873733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DA5RYlw5nSZ0avjZnRiKLuF+wuJ2XipiUUQcXPMg/bc=;
        b=KVO1ndTbbVAgJjaL91xTgu4YqRyTglcJSuAi3zByPEmSfXWYkJ7KvGukeR8XbeQJL+oc7R
        2TnSH6tqUKxrHHpFVyAJlcqZYBjbJ9hiI/40u1Jg+ZoLDI3KFaJeOKFG2TGgPTuRJMirtq
        7x6WQY194fHBL5fyKeTai+AAs7QbE1clGYJBdv20oboWe7aNtOLhr8YO1SBZCh7xWx1pDq
        9drRspRGvJbE3LKWj3THSM62I1QzfFYn6DMqnFxlGDE2BaiI8rhtJ9djS2jZPU0CFuzVnw
        a7P5yWWey81ro3DbmtTx2aZCGBezCZjsgmP13Eb2rt960XaxopNj87An3TIS6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670873733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DA5RYlw5nSZ0avjZnRiKLuF+wuJ2XipiUUQcXPMg/bc=;
        b=jxt2UHGKTL0P/ntko87iyt3B4RG7ozFlA+buqdGq4phzjGpnoDyZuonSyPr7O6VowYkosa
        en3U4ZuQI848FxBw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix sparse warnings in untagged_ptr()
Cc:     kernel test robot <lkp@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167087373271.4906.10859226256145693970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ce66a02538f39f071443bac9bc6ff8f3a780ab92
Gitweb:        https://git.kernel.org/tip/ce66a02538f39f071443bac9bc6ff8f3a780ab92
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 16 Nov 2022 03:43:53 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 28 Nov 2022 15:12:25 -08:00

x86/mm: Fix sparse warnings in untagged_ptr()

Linear Address Masking patchset triggered a lot of sparse warnings.

The root cause is that casting pointer to '__typeof__(*(ptr)) *' will
strip all sparse tags. The type has to be defined based on the pointer
type, not based on what the pointer points to.

Fix cast in untagged_ptr() and avoid __typeof__() usage in
get/put_user().

Fixes: 5744534bdae4 ("x86/uaccess: Provide untagged_addr() and remove tags before address check")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221116004353.15052-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/uaccess.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1d2c792..bd92e1e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -43,7 +43,7 @@ DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
 #define untagged_ptr(mm, ptr)	({					\
 	u64 __ptrval = (__force u64)(ptr);				\
 	__ptrval = untagged_addr(mm, __ptrval);				\
-	(__force __typeof__(*(ptr)) *)__ptrval;				\
+	(__force __typeof__(ptr))__ptrval;				\
 })
 #else
 #define untagged_addr(mm, addr)	(addr)
@@ -158,10 +158,8 @@ extern int __get_user_bad(void);
  */
 #define get_user(x,ptr)							\
 ({									\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_get_user_call(get_user,x,__ptr_clean);			\
+	do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
@@ -263,10 +261,8 @@ extern void __put_user_nocheck_8(void);
  * Return: zero on success, or -EFAULT on error.
  */
 #define put_user(x, ptr) ({						\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_put_user_call(put_user,x,__ptr_clean);			\
+	do_put_user_call(put_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
