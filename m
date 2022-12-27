Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD4656AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiL0MPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiL0MOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57FDDF;
        Tue, 27 Dec 2022 04:13:52 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2LwpMAxz7fIjAUYU/1ZDDqNt6zkBjyLjIDrEjC1mBo=;
        b=UGRVrp7M8EbopmqnwNVd2k0x0chl5PTKVLQrgMEVo6mCWsSjE5NB2OIjwW3dVJJUtj5L5W
        2qX4BRBvJfBaeGKC2h8BLahsKzR+AkyZ0kWgeuEyB/JNLkQ5uc0xc1HHD3pFoXF9RNvaUu
        BoUAL3MODC7L+JkkAbUkEp9WiL84f9mtTahMPas4D1hW5gZCZiAcaJVUkuQHxAUWNQ3RmE
        ene+bqjyyvUXMgSE6cYJPHCKaJxP3uUmvE5SClTOyO5m6w0H6HeMioAQr2ZK5w0WYwoDjg
        Tk22eSjFfLlPBuy4A+LhgP4zrLswxs+etxsTPUmaPYYHXkTXziDq/I5M0KJjMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2LwpMAxz7fIjAUYU/1ZDDqNt6zkBjyLjIDrEjC1mBo=;
        b=kUi8Zlb3Ljk5W63MvIZguAhaQjmPOfVprNtnbN6xgPIrf+KuOaxrSrvh1mef2Qt6Ri4Yj9
        xDZ9KzP9EyWDBVBA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: parametrized test: Report/abort on
 negative concurrency ID
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-21-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-21-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322927.4906.10221180100625310863.tip-bot2@tip-bot2>
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

Commit-ID:     a3798e6ffb37481c47773dd1d785c395c0785af8
Gitweb:        https://git.kernel.org/tip/a3798e6ffb37481c47773dd1d785c395c0785af8
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:22 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:15 +01:00

selftests/rseq: parametrized test: Report/abort on negative concurrency ID

Report and abort when a negative concurrency ID value is observed by the
spinlock test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-21-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/param_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index cadb9d8..bf951a4 100644
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
