Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F565D9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjADQgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjADQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:36:02 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D712DF41;
        Wed,  4 Jan 2023 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1672850156;
        bh=TFVyM2m/xyzX8+yA6smgHYIu+Z3FjYZKZtEo+/BxGyU=;
        h=From:To:Cc:Subject:Date:From;
        b=aSrHrh7s2/BiKlIyu77Rpv0YWtsCqp8BnME8PC0wGNv8FRgkFQzbXZGE1N+4y4FuG
         ZNkB33f9xc7gJ+MyejSuxBQpPp7ddnDXjE1KcDlFcHTGSMRdSv8gXJoWLoKEbTCupz
         oBnrBXc9dYicGFROYyO+xkzN10Cxw6pHEBk32OSLJv7pY60oe7dvk95MsIa17rX0Ak
         h0azNFAnd4B9LcQAtmT6M1m5+GxqmQfd1x6g+wE2bEvS0nCxPzKmzYhCsv14qzkaXo
         ESIB8eZNUy+ZoIV3GlEVoCKkwR7XvxRcveKcxI6pzAZyIHIqNasbIQP/mtMC0hpVjN
         yHpYLkQtbG9Fg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NnFbJ2WkXzdct;
        Wed,  4 Jan 2023 11:35:56 -0500 (EST)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH tip] selftests/rseq: Revert "selftests/rseq: Add mm_numa_cid to test script"
Date:   Wed,  4 Jan 2023 11:35:42 -0500
Message-Id: <20230104163542.10004-1-mathieu.desnoyers@efficios.com>
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

The mm_numa_cid related rseq patches from the series were not picked up
into the tip tree, so enabling the mm_numa_cid test needs to be
reverted.

This reverts commit b344b8f2d88dbf095caf97ac57fd3645843fa70f.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202301040903.2dd1e25b-oliver.sang@intel.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/run_param_test.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 603b3b69d20c..8d31426ab41f 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -47,11 +47,6 @@ function do_tests()
 		./param_test_mm_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running mm_cid compare-twice test ${TEST_NAME[$i]}"
 		./param_test_mm_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
-
-		echo "Running mm_numa_cid test ${TEST_NAME[$i]}"
-		./param_test_mm_numa_cid ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
-		echo "Running mm_numa_cid compare-twice test ${TEST_NAME[$i]}"
-		./param_test_mm_numa_cid_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
-- 
2.25.1

