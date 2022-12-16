Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23E64ED27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLPOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLPOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:53:46 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4304A583;
        Fri, 16 Dec 2022 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671202421;
        bh=jZDXR8e62xNvD/8p2kavm0Ey/5UImO2+MAK5HacDaNk=;
        h=From:To:Cc:Subject:Date:From;
        b=OvR3iewGUvOqa/KjBCiGuK78vahB0Zihnn1ivyQbNgcOv11YN6U/+TPzZqESC6df5
         cXhqwodTgZ22uPVvVyRjiQTaIOatgFqk2saMV5/RG+/jo4+08+NG41gGdhQ1Fs7/s/
         viKJVwJ8HdUCJsiIjPT39JHB75o3T8l6U1n6YbW/hfxvYSa6e0lTs8kIljdqWaGJew
         phZMn9w7FGK9guqsGIosv2N6snxqQ0nMoETlZK+zGDvr58ieYlX20pKyQkv6/MUzGd
         FNoRagaj5aBMimTeU5AVp6Xdj6NTtEOyhHEQUaL4uosbdOCRHAmYWrkl48rkCRcRL4
         vB6dVl9ZDLj/g==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NYXD54TMszbSc;
        Fri, 16 Dec 2022 09:53:41 -0500 (EST)
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
Subject: [PATCH for tip queue/sched/core] selftests/rseq: Add mm_numa_cid to test script
Date:   Fri, 16 Dec 2022 09:53:32 -0500
Message-Id: <20221216145332.205095-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
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

Add mm_numa_cid tests to the run_param_test.sh test script.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/run_param_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 8d31426ab41f..603b3b69d20c 100755
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
-- 
2.25.1

