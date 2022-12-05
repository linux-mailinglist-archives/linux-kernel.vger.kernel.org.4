Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81B2642310
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiLEGo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEGo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:44:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4904C12095;
        Sun,  4 Dec 2022 22:44:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF8A23A;
        Sun,  4 Dec 2022 22:45:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA92F3F73D;
        Sun,  4 Dec 2022 22:44:52 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/tool: Add remaining branch filters to perf record
Date:   Mon,  5 Dec 2022 12:14:43 +0530
Message-Id: <20221205064443.533587-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds all remaining branch filters i.e no_cycles, no_flags and hw_index
to perf record tool. While here, also updates the documentation.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/Documentation/perf-record.txt | 5 +++++
 tools/perf/util/parse-branch-options.c   | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e41ae950fdc3..7803c0c4c8f9 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -388,6 +388,7 @@ following filters are defined:
         - any_call: any function call or system call
         - any_ret: any function return or system call return
         - ind_call: any indirect branch
+        - ind_jmp: any indirect jump
         - call: direct calls, including far (to/from kernel) calls
         - u:  only when the branch target is at the user level
         - k: only when the branch target is in the kernel
@@ -396,6 +397,10 @@ following filters are defined:
 	- no_tx: only when the target is not in a hardware transaction
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
+	- call_stack: save call stack
+	- no_flags: don't save branch flags e.g prediction, misprediction etc
+	- no_cycles: don't save branch cycles
+	- hw_index: save branch hardware index
 	- save_type: save branch type during sampling in case binary is not available later
 		     For the platforms with Intel Arch LBR support (12th-Gen+ client or
 		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 31faf2bb49ff..fd67d204d720 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -30,8 +30,11 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("cond", PERF_SAMPLE_BRANCH_COND),
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
+	BRANCH_OPT("no_flags", PERF_SAMPLE_BRANCH_NO_FLAGS),
+	BRANCH_OPT("no_cycles", PERF_SAMPLE_BRANCH_NO_CYCLES),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
+	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
 	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
 	BRANCH_END
 };
-- 
2.25.1

