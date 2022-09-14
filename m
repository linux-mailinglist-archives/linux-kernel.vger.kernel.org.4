Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450F05B8829
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiINMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:24:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1446461;
        Wed, 14 Sep 2022 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663158283; x=1694694283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q+9dbMUMn5Gtzb8375/dbn8RO/Ru0bbyWDSY78Ma/lU=;
  b=KIzi0VJQM+XJ8c4tC8NK4eax6PrPxlNi8kndFQNPDY3+2nKK0HEuBKLM
   J6AkcdUDc0eDpnpqIJPh4YUas7ZrWt1mdqwqoUin+m7urkstn2XBGx0qd
   aSf9U82Ap3J4Qc/SdHUaj+auWGool8X3jew1M+cwow+m9dLYtzgSKbakm
   ed3TTh6pstGBRkL/lQ8U3m0ZkwcQn7eDaIrTM8CpZi4IaMCdRTGH3v30H
   8Kh+TVgt06VDMVtcZgDdSPaBYzz+KQFH9TS1Edd+PdGEx0YPzMTDFC4ec
   tM2Q0zCVNVoURVTrq4AFGDufUuuEh23TWqipHBV3ddQijioXlwyFeHIvP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324666316"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324666316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:24:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="612489606"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.32.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:24:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Daniel Dao <dqminh@cloudflare.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf kcore_copy: Do not check /proc/modules is unchanged
Date:   Wed, 14 Sep 2022 15:24:29 +0300
Message-Id: <20220914122429.8770-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/kallsyms and /proc/modules are compared before and after the copy
in order to ensure no changes during the copy. However /proc/modules
also might change due to reference counts changing even though that
does not make any difference. Any modules loaded or unloaded should be
visible in changes to kallsyms, so it is not necessary to check
/proc/modules also anyway.

Remove the comparison checking that /proc/modules is unchanged.

Reported-by: Daniel Dao <dqminh@cloudflare.com>
Fixes: fc1b691d7651 ("perf buildid-cache: Add ability to add kcore to the cache")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 75bec32d4f57..647b7dff8ef3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -2102,8 +2102,8 @@ static int kcore_copy__compare_file(const char *from_dir, const char *to_dir,
  * unusual.  One significant peculiarity is that the mapping (start -> pgoff)
  * is not the same for the kernel map and the modules map.  That happens because
  * the data is copied adjacently whereas the original kcore has gaps.  Finally,
- * kallsyms and modules files are compared with their copies to check that
- * modules have not been loaded or unloaded while the copies were taking place.
+ * kallsyms file is compared with its copy to check that modules have not been
+ * loaded or unloaded while the copies were taking place.
  *
  * Return: %0 on success, %-1 on failure.
  */
@@ -2166,9 +2166,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 			goto out_extract_close;
 	}
 
-	if (kcore_copy__compare_file(from_dir, to_dir, "modules"))
-		goto out_extract_close;
-
 	if (kcore_copy__compare_file(from_dir, to_dir, "kallsyms"))
 		goto out_extract_close;
 
-- 
2.25.1

