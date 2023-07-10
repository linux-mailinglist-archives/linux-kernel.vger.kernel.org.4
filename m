Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3D74CFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGJIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjGJIN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70345E7;
        Mon, 10 Jul 2023 01:13:55 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wa1Pqv6ON1E3f9DZX0FEtBPB2++oZTfb1AAWTXrvaI=;
        b=MnnGWf+L6oy9R45dvuPpUJzW3OeVtcegnJgOSR2CcwTsSvVtxr95rKXYv1dCiEr4CPPJsB
        qilgsz9NtaJJOc0vC/hBeAhZaQQTr8xOz149Dtg7/0x0Y8N3E0UzdPWmY6jnUi3R+zwSR+
        NQWOZUJI7Gt2FL6cnNn0QuS6cPe7laz1LYdxmvKf3xkzLlTE9q7EPI6unxJ1ZlIsUUxjpH
        dz/4xxo3jDs8C3aUudYpZak08XrI7EXwQGTk6jhGL6dvigcvMQ6PWjVOZnl41eCYSi70KZ
        L2QyO5B2JXbyQYx7mbJ7kEua2i5UesW+vOz6SVaXzTcrv+EGTUk3FbIgerWHcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wa1Pqv6ON1E3f9DZX0FEtBPB2++oZTfb1AAWTXrvaI=;
        b=aL/ha04ZOl8SxxmUdcYHfdKT/kL4m8WIfr8rR9XqhlG/eEPRDg5LdmkBIk7icUZi1xRVq+
        Ge+NAJGjmBnU4FBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] iov_iter: Mark copy_iovec_from_user() noclone
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230616124354.GD4253@hirez.programming.kicks-ass.net>
References: <20230616124354.GD4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168897683354.404.11598434533900577662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     719a937b7003933de1298ffa4b881dd6a234e244
Gitweb:        https://git.kernel.org/tip/719a937b7003933de1298ffa4b881dd6a234e244
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 16 Jun 2023 14:43:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:28 +02:00

iov_iter: Mark copy_iovec_from_user() noclone

Extend commit 50f9a76ef127 ("iov_iter: Mark
copy_compat_iovec_from_user() noinline") to also cover
copy_iovec_from_user(). Different compiler versions cause the same
problem on different functions.

lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x1f: redundant UACCESS disable
lib/iov_iter.o: warning: objtool: iovec_from_user+0x84: call to copy_iovec_from_user.part.0() with UACCESS enabled
lib/iov_iter.o: warning: objtool: __import_iovec+0x143: call to copy_iovec_from_user.part.0() with UACCESS enabled

Fixes: 50f9a76ef127 ("iov_iter: Mark copy_compat_iovec_from_user() noinline")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lkml.kernel.org/r/20230616124354.GD4253@hirez.programming.kicks-ass.net
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e..e4dc809 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1349,7 +1349,7 @@ uaccess_end:
 	return ret;
 }
 
-static int copy_iovec_from_user(struct iovec *iov,
+static __noclone int copy_iovec_from_user(struct iovec *iov,
 		const struct iovec __user *uiov, unsigned long nr_segs)
 {
 	int ret = -EFAULT;
