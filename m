Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE916BD972
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCPTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCPTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:42:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6536974B1;
        Thu, 16 Mar 2023 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678995737; x=1710531737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNjn4+Xoz1pdCG0Q0z/t1kpbDRFkSjxY3sgAwJC83HU=;
  b=ji6AjRdV9ev5qZdK66A+pYsvKUyE0ftSEVE05t67icFF/ywOe0zE+/MT
   k/+f7t5WskF9y79XbnjxYvdpZPyYhLazD0WMQw+yUhOmmbwIk2v+2rHXl
   34ZyDy3ZMeuMePEDRaDiXldInKTxMq/x0YhypvuB1Qo5F3yIK9ugNOX84
   4qK23KT5GD3EphAEmILmtKPJtRYngVhd8zdtV360/xZ6CVuUJL440jEQm
   PbS1tUxFiO/ZHqpOXgi+A3cSL7YynvPqJkB1kl3VmRcFB0Kds/mHXfOZP
   RrZjEkit1Pz3qa4KiNW7Su8czPAEtZge8qmT3yiMFtR70cl9V06yNC26J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326465414"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326465414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823392397"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823392397"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.221.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf symbols: Fix unaligned access in get_x86_64_plt_disp()
Date:   Thu, 16 Mar 2023 21:41:55 +0200
Message-Id: <20230316194156.8320-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316194156.8320-1-adrian.hunter@intel.com>
References: <20230316194156.8320-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memcpy() to avoid unaligned access.

Discovered using EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address".

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
Fixes: ce4c8e7966f3 ("perf symbols: Get symbols for .plt.got for x86-64")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7ef5f6d7d415..ae810d4cf3cd 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -542,9 +542,12 @@ static u32 get_x86_64_plt_disp(const u8 *p)
 		n += 1;
 	/* jmp with 4-byte displacement */
 	if (p[n] == 0xff && p[n + 1] == 0x25) {
+		u32 disp;
+
 		n += 2;
 		/* Also add offset from start of entry to end of instruction */
-		return n + 4 + le32toh(*(const u32 *)(p + n));
+		memcpy(&disp, p + n, sizeof(disp));
+		return n + 4 + le32toh(disp);
 	}
 	return 0;
 }
-- 
2.34.1

