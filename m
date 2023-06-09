Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3E72917B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbjFIHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjFIHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:46:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985F1FDA;
        Fri,  9 Jun 2023 00:46:39 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALkFxJwcKxaKkbysMd3CGHSOn9xdIigfWesyaC2/HgY=;
        b=QFYPpxgfBCFvWRAX9TonzR+WIvkeqYQaHkGF/4IsTvD5dz/SmRIjpkKPRPyfQcaojnulgL
        hXtJWj/zFrYg68YKhdKaxYYWgBSTxokKYY8tvxlEN/0g+aJq5mbg6pzQlHNoSCDYJRBP29
        SqvMXPiBQOL4LITNJ7rCH1/TTxt9jK3Y+f/tahbM7MqP4CjQZb+oski4G4D1BpVwYnjr4w
        6Grc9BGNa1oJhbuqoRDtHIryvAeZ7M4278F+lGzoI9+Uh6FtgaldJDZJo/mKbXxfbu7uRH
        am2g3V9N8vFkb7fhmAy6aCwR68xxBUPn+oxrGDt/k6fZncdO5eay/mXxCLaekw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALkFxJwcKxaKkbysMd3CGHSOn9xdIigfWesyaC2/HgY=;
        b=YDrMYPQc0/286j/g1Bs08E38WZkb1PhERTvHZG3xC0TJuXcTuPNB0JMbD2n8m0VMypSish
        vR27UKJs/B6lNcAg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] percpu: Fix self-assignment of __old in
 raw_cpu_generic_try_cmpxchg()
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230607-fix-shadowing-in-raw=5Fcpu=5Fgeneric=5F?=
 =?utf-8?q?try=5Fcmpxchg-v1-1-8f0a3d930d43=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20230607-fix-shadowing-in-raw=5Fcpu=5Fgeneric=5Ft?=
 =?utf-8?q?ry=5Fcmpxchg-v1-1-8f0a3d930d43=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <168629679641.404.10468324915005302564.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     093d9b240a1fa261ff8aeb7c7cc484dedacfda53
Gitweb:        https://git.kernel.org/tip/093d9b240a1fa261ff8aeb7c7cc484dedacfda53
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 07 Jun 2023 14:20:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jun 2023 10:28:39 +02:00

percpu: Fix self-assignment of __old in raw_cpu_generic_try_cmpxchg()

After commit c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()"),
clang built ARCH=arm and ARCH=arm64 kernels with CONFIG_INIT_STACK_NONE
started panicking on boot in alloc_vmap_area():

  [    0.000000] kernel BUG at mm/vmalloc.c:1638!
  [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  [    0.000000] Modules linked in:
  [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc2-ARCH+ #1
  [    0.000000] Hardware name: linux,dummy-virt (DT)
  [    0.000000] pstate: 200000c9 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [    0.000000] pc : alloc_vmap_area+0x7ec/0x7f8
  [    0.000000] lr : alloc_vmap_area+0x7e8/0x7f8

Compiling mm/vmalloc.c with W=2 reveals an instance of -Wshadow, which
helps uncover that through macro expansion, '__old = *(ovalp)' in
raw_cpu_generic_try_cmpxchg() can become '__old = *(&__old)' through
raw_cpu_generic_cmpxchg(), which results in garbage being assigned to
the inner __old and the cmpxchg not working properly.

Add an extra underscore to __old in raw_cpu_generic_try_cmpxchg() so
that there is no more self-assignment, which resolves the panics.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1868
Fixes: c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()")
Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230607-fix-shadowing-in-raw_cpu_generic_try_cmpxchg-v1-1-8f0a3d930d43@kernel.org
---
 include/asm-generic/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 68c410e..94cbd50 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -101,9 +101,9 @@ do {									\
 #define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
 ({									\
 	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __val = *__p, __old = *(ovalp);			\
+	typeof(pcp) __val = *__p, ___old = *(ovalp);			\
 	bool __ret;							\
-	if (__val == __old) {						\
+	if (__val == ___old) {						\
 		*__p = nval;						\
 		__ret = true;						\
 	} else {							\
