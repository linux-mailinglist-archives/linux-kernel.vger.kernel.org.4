Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B715B9AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIOM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIOM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:26:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D46E2F3;
        Thu, 15 Sep 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663244788; x=1694780788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+KtjU2CP8U+hVFoWtFMf8B47NSi4qDCoTPM79iN+fk=;
  b=WusZTeRIuruHMH6wLvixcwifw9LqOJl/C6nB/m3jwfEYax4/8cO2MVeJ
   45oQK7yxAxAhY8AL9Ac0IPumg+0mk1O8O0Cz0B2lEOsk1b8M3fJG5+GYN
   dQ6rtO2QIXMAjo+Mwvw2WIV7ubd5EPjxWNSj+nflcIiRmmOtiX5poujFX
   ngC/Om6BgxRXA4QdFQrdRruks9tr26GArar050ug2bb3hI1XeKMSXasL6
   pckg8ISofY71NmeAAboQrClWUu5/JlyPxrTJe7yG+1dMosEMT2LYhoqJo
   kF6RzkbMR7gCAEbZqQ9Yo2EcyRyD8tXVOseM1La3WA84ItJo8hfChHL40
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298693706"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="298693706"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="685705661"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:26:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf record: Fix cpu mask bit setting for mixed mmaps
Date:   Thu, 15 Sep 2022 15:26:11 +0300
Message-Id: <20220915122612.81738-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915122612.81738-1-adrian.hunter@intel.com>
References: <20220915122612.81738-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With mixed per-thread and (system-wide) per-cpu maps, the "any cpu" value
 -1 must be skipped when setting CPU mask bits.

Prior to commit cbd7bfc7fd99 ("tools/perf: Fix out of bound access to cpu
mask array") the invalid setting went unnoticed, but since then it causes
perf record to fail with an error.

Example:

 Before:

   $ perf record -e intel_pt// --per-thread uname
   Failed to initialize parallel data streaming masks

 After:

   $ perf record -e intel_pt// --per-thread uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.068 MB perf.data ]

Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5b808ac7a281..b76637ed2462 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3535,6 +3535,8 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cp
 		return 0;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		if (cpu.cpu == -1)
+			continue;
 		/* Return ENODEV is input cpu is greater than max cpu */
 		if ((unsigned long)cpu.cpu > mask->nbits)
 			return -ENODEV;
-- 
2.25.1

