Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC56827E5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjAaJAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjAaJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:00:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F149004;
        Tue, 31 Jan 2023 00:56:20 -0800 (PST)
Date:   Tue, 31 Jan 2023 08:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675155285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZQY3RtqjK9a2IAMKpkMeMf05+WkZxJr/HipNV9bHQY=;
        b=MiS+3wsqD+cwa5rN3ZgoGqCll17buIeXk7KLBtfiVTr2L8EsRM+EU7wGq4n3SCuGUjMKT7
        OcYMEAFQeCPZ8+W9EQlTpvWjbfOWS9oPWCxFcJitCcpcgnbFKtjAsR+vugucOytAe6AgUZ
        n2VWYnFr2LsIgnLVfBP44YTUr6mEpk6wsXOE4+Ehj+E3fW/Y8VXgdu2tw+/W/4q8j5rqHE
        pAXZ9057hCfCJyetQ70uAjUVyNE4vvXqQJYthCohmYfyUxWvcITkqTChweSbb+bKNWiERJ
        ctLjuMXd2CEnX77t0NfpS//vOvmj/3wk/urZib/yt2Jmn+w7VAddA4sUJtmLaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675155285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZQY3RtqjK9a2IAMKpkMeMf05+WkZxJr/HipNV9bHQY=;
        b=2oDZxPs//aum9nk5OHgHASQ59E32k6tr00X1RA+BFDFj8/+z8XvVXNBgSqKiBSsPshgf6P
        vkfuTALQigQRUiCQ==
From:   "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] KVM: selftests: Fix build of rseq test
Cc:     Mark Brown <broonie@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
References: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
MIME-Version: 1.0
Message-ID: <167515528478.4906.3305294093555684853.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     68efe8f7a1c5168be2228bfb806ddc05475b7205
Gitweb:        https://git.kernel.org/tip/68efe8f7a1c5168be2228bfb806ddc05475b7205
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Fri, 06 Jan 2023 19:24:19 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 30 Jan 2023 16:29:45 +01:00

KVM: selftests: Fix build of rseq test

The KVM rseq test is failing to build in -next due to a commit merged
from the tip tree which adds a wrapper for sys_getcpu() to the rseq
kselftests, conflicting with the wrapper already included in the KVM
selftest:

rseq_test.c:48:13: error: conflicting types for 'sys_getcpu'
   48 | static void sys_getcpu(unsigned *cpu)
          |             ^~~~~~~~~~
In file included from rseq_test.c:23:
../rseq/rseq.c:82:12: note: previous definition of 'sys_getcpu' was here
   82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
          |            ^~~~~~~~~~

Fix this by removing the local wrapper and moving the result check up to
the caller.

Fixes: 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org
---
 tools/testing/selftests/kvm/rseq_test.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 3045fdf..f74e76d 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -41,18 +41,6 @@ static void guest_code(void)
 		GUEST_SYNC(0);
 }
 
-/*
- * We have to perform direct system call for getcpu() because it's
- * not available until glic 2.29.
- */
-static void sys_getcpu(unsigned *cpu)
-{
-	int r;
-
-	r = syscall(__NR_getcpu, cpu, NULL, NULL);
-	TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
-}
-
 static int next_cpu(int cpu)
 {
 	/*
@@ -249,7 +237,9 @@ int main(int argc, char *argv[])
 			 * across the seq_cnt reads.
 			 */
 			smp_rmb();
-			sys_getcpu(&cpu);
+			r = sys_getcpu(&cpu, NULL);
+			TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)",
+				    errno, strerror(errno));
 			rseq_cpu = rseq_current_cpu_raw();
 			smp_rmb();
 		} while (snapshot != atomic_read(&seq_cnt));
