Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956E656AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiL0MPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiL0MOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8ED91;
        Tue, 27 Dec 2022 04:13:50 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMPuSiumnJ8BL2tZkVkB7dEReIHDfZei81xDTcWCTxc=;
        b=UtK44A18uWxtUfWt3bhy4HsPLA1+7Hrx83Eop/cZRN1ydfF0A2jzSau8JR+Gpbqn/OanPM
        ex/6qOponxA1fgZaZqLB1audm6hxM7sDB6JkIw6PtuB88tQ/L7Z9XTuM6Y0BCMTU9+rI/6
        H/1oz1PISNJllxtv8MnRH9pq6npVZPG469dJgy4E1xnR6KrP4c1ntFh4LwACi8DfUd08pN
        XABoT2oWq6GZ+iOu5wXZ58DVq8DuYpQWYXDkmXJtdrmTOWTXzUCcrzsGO8x2NFh/HP3jOA
        HeEWNrU0QZvu1rCaukaJgn+ASnRlftLDbDk8+H3x/G07H6hPIJ+k1/fZSV6+AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMPuSiumnJ8BL2tZkVkB7dEReIHDfZei81xDTcWCTxc=;
        b=uiPwBlIzy9kr1wMXDhnYG7KmMqFxr3sFYuUMjApJk2LfCjRKi2DsOQTzd9m563o7jwYOoz
        U1PD6ziQXzzJ1GBw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Add mm_numa_cid to test script
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221216145332.205095-1-mathieu.desnoyers@efficios.com>
References: <20221216145332.205095-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214322901.4906.6973828345276268649.tip-bot2@tip-bot2>
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

Commit-ID:     b344b8f2d88dbf095caf97ac57fd3645843fa70f
Gitweb:        https://git.kernel.org/tip/b344b8f2d88dbf095caf97ac57fd3645843fa70f
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Fri, 16 Dec 2022 09:53:32 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:16 +01:00

selftests/rseq: Add mm_numa_cid to test script

Add mm_numa_cid tests to the run_param_test.sh test script.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221216145332.205095-1-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/run_param_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 8d31426..603b3b6 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -47,6 +47,11 @@ function do_tests()
 		./param_test_mm_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running mm_cid compare-twice test ${TEST_NAME[$i]}"
 		./param_test_mm_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+
+		echo "Running mm_numa_cid test ${TEST_NAME[$i]}"
+		./param_test_mm_numa_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+		echo "Running mm_numa_cid compare-twice test ${TEST_NAME[$i]}"
+		./param_test_mm_numa_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
