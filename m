Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBA6CB2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjC1BEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjC1BEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:04:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF621A5;
        Mon, 27 Mar 2023 18:04:01 -0700 (PDT)
Date:   Tue, 28 Mar 2023 01:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679965439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=67MctZIWISax8lWg/O1BUzadU9+7vRWPYiN1MT2xET4=;
        b=c0pmAtjJQX4yOSfxD0H4QkzTWoJCAOhHpmEyMZiBPiAEMbVwmgEzIzQYipoq2vGF7ZLxGm
        w+07+v7Wcf31m6vT5QQgXyPQGx/p6pX3eQj1rrOLER9b7/gZl5B1rlXo7Y6f64mAYUFt5C
        WRN+5lHCzv9cad7aVgx3ZAHykUBu0yF425G6Qbse6Gk9yWsggY5IIYqJvk4DIsod9mcBp3
        QNtNyufJasIgYttJNTYL/QIEWvFua6BwpRFDUBPKK0u8FYC8HJ/7+ZUpF/HuQ+Bdvn5rLd
        9mAY2hFlxxQ1a2HWKBxgRgo168rHm1t2aFIvRgE6T5V0IWbvIf2QYgMk1K2Pow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679965439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=67MctZIWISax8lWg/O1BUzadU9+7vRWPYiN1MT2xET4=;
        b=dSMnQ/psMnohljrtpotyYNblxfvkBIgTme3m9btGomqyUeHjAqx4N5WXxJLBxtzU5o1a37
        22c4QbhcU6Vnj3Dg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Enforce only whole copies for ssp_set()
Cc:     Dan Carpenter <error27@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167996543824.5837.9196113102924582471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     11c95c77eef6d56c1ef9f55d8afd83ceb6d99996
Gitweb:        https://git.kernel.org/tip/11c95c77eef6d56c1ef9f55d8afd83ceb6d99996
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 25 Mar 2023 12:33:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 27 Mar 2023 17:55:51 -07:00

x86/shstk: Enforce only whole copies for ssp_set()

The regset set interface takes pos and count arguments to allow for
partial copies. No callers use a non-zero pos, but ptrace allows for the
count to be specified. It limits count to be a multiple of regset size, so
this still allows for a zero size to be passed to ssp_set().

In ssp_set(), user_regset_copyin() returns success for copying zero bytes,
which means user_ssp can later be accessed uninitialized. So add
enforcement for this case. The other regset's also enforce pos == 0, so do
that as well even though there is no caller today.

In the case of partial copies, some regsets return -EINVAL and some
return -EFAULT. -EINVAL seems more appropriate, so use that error code.

Fixes: d84e6ee122e5 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/90af27cc-6c9d-4fb9-be3b-fc4ef378766d@kili.mountain/
Link: https://lore.kernel.org/all/20230325193349.31893-1-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/fpu/regset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index f0a8eaf..6bc1eb2 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -223,6 +223,9 @@ int ssp_set(struct task_struct *target, const struct user_regset *regset,
 	    !ssp_active(target, regset))
 		return -ENODEV;
 
+	if (pos != 0 || count != sizeof(user_ssp))
+		return -EINVAL;
+
 	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_ssp, 0, -1);
 	if (r)
 		return r;
