Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E585EB973
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiI0FNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiI0FNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:13:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F4895CC;
        Mon, 26 Sep 2022 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664255614; x=1695791614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCSzslw9U/mYhVAHLXe921e3DDc5EmNjta+XRNlKj9Y=;
  b=Rr/L1ZAFFTZzzzZCodRslskRQbII/mChjTVrOS8rAPNEozLG1TX3m/pm
   oV0ySs/KaMF7OJ1MDixMLWLTSR2UB9SJUqol4cad9eAsRNewHiO8TkBzy
   cmn5m0gBpgkRwchEdLTNXhtHda5qSxc7VDx6aQzBMSHruQTLRnREkulgH
   3SsXUBhV1WjMLu7lKXm0m1nwKLPmPkYZFBnCQ2TvZWZp+4OkasNNSWkNf
   fUheYKN0yQvCruONrBG1gLBRKJL+0cVmpEsL5VeddUmJ3JNS22C0MiI4o
   PDe4XAegX95k2+nsAcKDOO4sj1dIisX7LaoCPG06xquplk2/6eBGIZGhN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="363058550"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="363058550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 22:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="616701201"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="616701201"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2022 22:13:31 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH] perf test: Fix test case 87 ("perf record tests") for hybrid systems
Date:   Tue, 27 Sep 2022 13:15:13 +0800
Message-Id: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The test case 87 ("perf record tests") failed on hybrid systems,the event
"cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
the test event to support both non-hybrid and hybrid systems.

Before:
 # ./perf test 87
 87: perf record tests                                   : FAILED!

After:
 # ./perf test 87
 87: perf record tests                                   : Ok

Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 00c7285ce1ac..301f95427159 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -61,7 +61,7 @@ test_register_capture() {
     echo "Register capture test [Skipped missing registers]"
     return
   fi
-  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
+  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
     -c 1000 --per-thread true 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
     | egrep -q "DI:"
-- 
2.25.1

