Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320263DB01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiK3QwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiK3QwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:52:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0945B2654C;
        Wed, 30 Nov 2022 08:52:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06D15D6E;
        Wed, 30 Nov 2022 08:52:16 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6A2F3F73B;
        Wed, 30 Nov 2022 08:52:07 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        sandipan.das@amd.com, Anshuman.Khandual@arm.com
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: Fix interpretation of branch records
Date:   Wed, 30 Nov 2022 16:51:58 +0000
Message-Id: <20221130165158.517385-1-james.clark@arm.com>
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

Commit 93315e46b000 ("perf/core: Add speculation info to branch
entries") added a new field in between type and new_type. Perf has
its own copy of this struct so update it to match the kernel side.

This doesn't currently cause any issues because new_type is only used
by the Arm BRBE driver which isn't merged yet.

Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/branch.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index d6017c9b1872..3ed792db1125 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -22,9 +22,10 @@ struct branch_flags {
 			u64 abort:1;
 			u64 cycles:16;
 			u64 type:4;
+			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:33;
+			u64 reserved:31;
 		};
 	};
 };
-- 
2.25.1

