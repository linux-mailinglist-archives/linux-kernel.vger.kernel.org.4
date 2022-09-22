Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7635E6098
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiIVLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIVLK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:10:27 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FE9CCC4;
        Thu, 22 Sep 2022 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844391;
        bh=ghI6w5m/fBuPawbc/R5A+f4FNxklkEyjIEUh4Xg9S2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeNNG0+c965RQbK9u1D1aNoPqc2b8MiqVflVLt4SPijocc/RBd5etYGT2cFRdKVmm
         pStqOBWB93+W9y76HuMLQKjk5I+W4loxSpVwqboqNRXgqfwgSZibFt674Wo/VRqWln
         74xkxCm8BiRWauX9OPj4Lm0SED3Wuef+lGT4UI8sSc26snYHr8ARyJyDrKRC9u+fF4
         DxtmWJQnhOGdj/26NyomtKe04YaNq64KiMZSF5OLoWTWqgrv+n9zDhVWJYKSQXY6bn
         xUKRO4JwYNgvKffEKQSfxClh2fKf9OI1G0Lx4I2AvBiPLVAN+NhjwcExeAdQhgRPPq
         PkH9djc7wcIXg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3V5VN7zNF9;
        Thu, 22 Sep 2022 06:59:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 24/25] selftests/rseq: parametrized test: Report/abort on negative cpu id
Date:   Thu, 22 Sep 2022 06:59:39 -0400
Message-Id: <20220922105941.237830-25-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report and abort when a negative cpu id value is observed by the
spinlock test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index f3687a90ec0c..1c86b45bd579 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -410,6 +410,11 @@ static int rseq_this_cpu_lock(struct percpu_lock *lock)
 		int ret;
 
 		cpu = get_current_cpu_id();
+		if (cpu < 0) {
+			fprintf(stderr, "pid: %d: tid: %d, cpu: %d: Observing vcpu id %d\n",
+					getpid(), (int) rseq_gettid(), rseq_current_cpu_raw(), cpu);
+			abort();
+		}
 		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
 					 &lock->c[cpu].v,
 					 0, 1, cpu);
-- 
2.25.1

