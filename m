Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4204268877E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjBBTWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjBBTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:22:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865D6CC81
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675365748; x=1706901748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPyKGu2uUaNniUnGihB+wDhMHYuNOTEsrZFp5sO3W68=;
  b=ZoiXQgG78h1udkZcJWv1tRYFXRrLCXVPu3AeOUpu3SW5LVulgxZBvdgn
   20xkrDcpjb8uI0hpXZ0dyNbmzGrYIq2RqddsqqywXcAAbWsGCpkMmFJ8K
   5yERQB7QW0W4hAUXGT20kbL0ZTyGYs9pQ8clbU0+UAqd5YfxiF2NKF9Ma
   6LFXDcKO/4JRrvVla7bz0Dbcm+yNXeJNIwnXm8Ohz6ByrPBqKnuSrOB77
   m9LTHGtjAwOqjMFvLzOZMRzmoMAqj16bUjk/zawDQU83MntLnjqQ4SIDp
   iips7ZVzTkhW3aUfiS+ZZxxW3/DmaHNNv+ixmW17wPx3zPrS4Eot1RKrZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312194503"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="312194503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 11:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697793110"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="697793110"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2023 11:22:13 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, irogers@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/3] perf test: Support the retire_lat check
Date:   Thu,  2 Feb 2023 11:22:09 -0800
Message-Id: <20230202192209.1795329-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230202192209.1795329-1-kan.liang@linux.intel.com>
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add test for the new field for Retire Latency in the X86 specific test.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch since V2

 tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
index 690c7c07e90d..a061e8619267 100644
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ b/tools/perf/arch/x86/tests/sample-parsing.c
@@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
 			 const struct perf_sample *s2,
 			 u64 type)
 {
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		COMP(ins_lat);
+		COMP(retire_lat);
+	}
 
 	return true;
 }
@@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
 	struct perf_sample sample = {
 		.weight		= 101,
 		.ins_lat        = 102,
+		.retire_lat     = 103,
 	};
 	struct perf_sample sample_out;
 	size_t i, sz, bufsz;
-- 
2.35.1

