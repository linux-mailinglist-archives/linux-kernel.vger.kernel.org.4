Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C2634896
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiKVUlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiKVUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:57 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF46E551;
        Tue, 22 Nov 2022 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149593;
        bh=Uj7UFmczknLn8GfrObDVcaH2jaTFCQ4AqsX1N3NtBH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUmSBoT8tcKMOuWgSgeJlbZyKXSL6WYuJsCyq0mob5gkZYLPkqga7KP05RMkBb/EU
         Pr/yK2o5o2GWfSBGTLPKuH0VpMs4K/v4iaLcv0k+NU+8+rO2N6Z1EjlhErFDARGktJ
         /02CPk3WU0i3PO9K/dSrVTBgOpNHwS6d/8cR+ZwbLmdA5lVTzULBeFctPVSMVajgtb
         DMPc4qppNgz70XCwv4SLmyhpvUdiqhmoEri+b7r8xz1PW2pMzuPFB7gemSqJtEk3gB
         L0tZFg9wGj+fAR8vll18nPCLK6l+2x3hnE1hJs+QeftxoOK/W51+qBafbMh80bHkA7
         uDqNkTCrD5Zxw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2c5hmtzWgn;
        Tue, 22 Nov 2022 15:39:52 -0500 (EST)
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
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 20/30] selftests/rseq: parametrized test: Report/abort on negative concurrency ID
Date:   Tue, 22 Nov 2022 15:39:22 -0500
Message-Id: <20221122203932.231377-21-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report and abort when a negative concurrency ID value is observed by the
spinlock test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index cadb9d884811..bf951a490bb4 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -410,6 +410,11 @@ static int rseq_this_cpu_lock(struct percpu_lock *lock)
 		int ret;
 
 		cpu = get_current_cpu_id();
+		if (cpu < 0) {
+			fprintf(stderr, "pid: %d: tid: %d, cpu: %d: cid: %d\n",
+					getpid(), (int) rseq_gettid(), rseq_current_cpu_raw(), cpu);
+			abort();
+		}
 		ret = rseq_cmpeqv_storev(RSEQ_MO_RELAXED, RSEQ_PERCPU,
 					 &lock->c[cpu].v,
 					 0, 1, cpu);
-- 
2.25.1

