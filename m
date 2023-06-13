Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4972E5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbjFMOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbjFMOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:39:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BF1B0;
        Tue, 13 Jun 2023 07:39:57 -0700 (PDT)
Date:   Tue, 13 Jun 2023 14:39:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686667196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPzI8Q9eUu7vsb6S1eYJHz9UhpwhGLDi/dn+9ToRNIk=;
        b=r5CpKxH6b63N9aDfYtUBhoAu0NN8oUdJ4LCQwIHVNEYmYipKDEfTpRJ8V0JHXSTGjrUFtv
        FWGfC+Nv0/Mlf2d45x6QQvXIzb7U8AxENE+kJFZQTC+pJp0i6tsGxxBow7x+bOCzuzhpB7
        HfQN+beF+R9vbTRARo1oHZrdJ3XGiXu2MTHU+RwqMH80XQLAJ/+6+2XTX6v12z1znf0exn
        /ieu7bQLqj9jICxsgJCirHn6jcgkSEWCklO1Cas6nDhgavozeehG4hCC9MY79M7HjpLqdS
        kwG8SgbwBlRIUysZ4zI9Ytw6DX3pXKjkOtt3VhrnyimVHYLKG7HJ0MxBsQZTcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686667196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPzI8Q9eUu7vsb6S1eYJHz9UhpwhGLDi/dn+9ToRNIk=;
        b=sUhk4MH0dSEqEDyTKIE+BXtSWHKtHpshI/qi6pCtVZT5l4zHOQY0Xh3CA80Xm1Aj9Ndtbq
        GaDwgrPHTlDCjiCQ==
From:   "tip-bot2 for Jakob Koschel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
Cc:     Jakob Koschel <jkl820.git@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com>
References: <20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com>
MIME-Version: 1.0
Message-ID: <168666719541.404.14580547563993446392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     1e327963cfab0e02eeeb0331178d6c353c959cd6
Gitweb:        https://git.kernel.org/tip/1e327963cfab0e02eeeb0331178d6c353c959cd6
Author:        Jakob Koschel <jkl820.git@gmail.com>
AuthorDate:    Wed, 01 Mar 2023 12:17:29 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jun 2023 16:21:01 +02:00

x86/sgx: Avoid using iterator after loop in sgx_mmu_notifier_release()

If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
'tmp' will not point to a valid sgx_encl_mm struct.

Linus proposed to avoid any use of the list iterator variable after the
loop, in the attempt to move the list iterator variable declaration into
the macro to avoid any potential misuse after the loop. Using it in
a pointer comparison after the loop is undefined behavior and should be
omitted if possible, see Link tag.

Instead, just use a 'found' boolean to indicate if an element was found.

  [ bp: Massage, fix typos. ]

Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Link: https://lore.kernel.org/r/20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2a0e90f..91fa70e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -755,6 +755,7 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
 {
 	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
 	struct sgx_encl_mm *tmp = NULL;
+	bool found = false;
 
 	/*
 	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
@@ -764,12 +765,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
 	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
 		if (tmp == encl_mm) {
 			list_del_rcu(&encl_mm->list);
+			found = true;
 			break;
 		}
 	}
 	spin_unlock(&encl_mm->encl->mm_lock);
 
-	if (tmp == encl_mm) {
+	if (found) {
 		synchronize_srcu(&encl_mm->encl->srcu);
 		mmu_notifier_put(mn);
 	}
