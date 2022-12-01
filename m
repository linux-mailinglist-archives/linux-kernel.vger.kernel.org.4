Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071B963E97A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiLAFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLAFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:51:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23504A6B45;
        Wed, 30 Nov 2022 21:51:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070FBD6E;
        Wed, 30 Nov 2022 21:51:22 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 935B93F73D;
        Wed, 30 Nov 2022 21:51:11 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/core: Reset remaining bits in perf_clear_branch_entry_bitfields()
Date:   Thu,  1 Dec 2022 11:21:03 +0530
Message-Id: <20221201055103.302019-1-anshuman.khandual@arm.com>
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

perf_clear_branch_entry_bitfields() resets all struct perf_branch_entry bit
fields before capturing branch records. This resets remaining bit fields
except 'new_type', which is valid only when 'type' is PERF_BR_EXTEND_ABI.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6

'perf_branch_entry.new_type' can remain uninitialized as explained earlier.
Also there is no PERF_BR_NEW_UNKNOWN to spare, because 'perf_branch_entry.
new_type' enumeration starts at PERF_BR_NEW_FAULT_ALGN, to save a position
for the extended branch types instead.

 include/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0031f7b4d9ab..c97b5f6f77a4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1110,8 +1110,9 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->in_tx = 0;
 	br->abort = 0;
 	br->cycles = 0;
-	br->type = 0;
+	br->type = PERF_BR_UNKNOWN;
 	br->spec = PERF_BR_SPEC_NA;
+	br->priv = PERF_BR_PRIV_UNKNOWN;
 	br->reserved = 0;
 }
 
-- 
2.25.1

