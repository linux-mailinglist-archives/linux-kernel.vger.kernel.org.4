Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8CE6A6EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCAPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCAPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:04:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708BB303E5;
        Wed,  1 Mar 2023 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677683068; x=1709219068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JnmA5Zi17bd6jWDVLbg86M4rw6XNBDHfhFxQM53Fmpw=;
  b=d/GJP07JcrCBqhy1GEhLfDLF26a1oJugufVquKVfyn3bZsu3bE67iYYv
   IqEJr0WBhbnkRI4HQw2u4U/68XJ+ONUMxhsGbgdYMOBwGOtNmAlWxQHSF
   ijzTiMTkhH8akGwJTi5noLajv59yJBjBoh8oX8TyPWLEnxrn4El6oTnDi
   Sz8MzqWDnlDlmSkwxVkgWO3oz8NjOoLjGqrY0ZI0GEX8yyFmdvMIQaK0f
   PoUzdkWNyJW4FAi79/A3VYOxP/xZ/LTm2TiFlcgO1u8U3yJA8i+tOurPM
   sz7CZ2dFh4irK59Bym9GPy3QfUTakq0vrjhZYN2g+cjlgdl8QNdk5SiD/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="331908111"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="331908111"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920273548"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="920273548"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2023 07:04:26 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org
Cc:     jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf record: Fix "read LOST count failed" msg with sample read
Date:   Wed,  1 Mar 2023 07:04:13 -0800
Message-Id: <20230301150413.27011-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Hundreds of "read LOST count failed" error messages may be displayed,
when the below command is launched.

perf record -e '{cpu/mem-loads-aux/,cpu/event=0xcd,umask=0x1/}:S' -a

According to the commit 89e3106fa25f ("libperf: Handle read format in
perf_evsel__read()"), the PERF_FORMAT_GROUP is only available for the
leader. However, the record__read_lost_samples() goes through every
entry of an evlist, which includes both leader and member. The member
event errors out and triggers the error message. Since there may be
hundreds of CPUs on a server, the message will be printed hundreds of
times, which is very annoying.

The message itself is correct, but the pr_err is a overkill. Other error
messages in the record__read_lost_samples() are all pr_debug. To make
the output format consistent, change the pr_err("read LOST count
failed\n"); to pr_debug("read LOST count failed\n");.
User can still get the message via -v option.

Fixes: e3a23261ad06 ("perf record: Read and inject LOST_SAMPLES events")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..be7c0c29d15b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1866,7 +1866,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	int id_hdr_size;
 
 	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
+		pr_debug("read LOST count failed\n");
 		return;
 	}
 
-- 
2.35.1

