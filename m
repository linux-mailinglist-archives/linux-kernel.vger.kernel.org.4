Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1963C600AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJQJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiJQJgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:36:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294C13D0F;
        Mon, 17 Oct 2022 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999363; x=1697535363;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=VMNFgqKmBqsgVQWgZr1IC9W6qb5rfWYqPXuTWvYb+0Y=;
  b=mKGaBWLQpkCWQlfzQoK4KLTaKggiR5yx0O7l0VOYSSReKWT01kRx9Zp/
   nk96C9X5/Do1D5gR4lcbZPXP4fofkEhvo6Ov2V35rY3USUjD7E4mSWYSM
   XN2r8oRl9KJRIcM/H4a+gdKZ30YxYttfcQ/oQcRpLqIjAZ1bdlH/YS3jf
   /jB/xjYqNUBmnHFpcWlIDa4/yc4CU3DkrWuG+Lw5b3YfdjWLctuYXJ/kI
   k7/rCz6lKz7lUGTcxdE0h6IjY/AnAgVJbzwozF4talY7+Wh08T/zC0dBf
   uoNKcgmG0w2Ri1DZXL+a1D7czV0HraIgrousgpHRyiNsFxyfavd62w7cD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="285477567"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285477567"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:35:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="579312007"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="579312007"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:35:53 -0700
Message-ID: <a176a3e1-6ddc-bb63-e41c-15cda8c2d5d2@intel.com>
Date:   Mon, 17 Oct 2022 12:35:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Sven Schnelle <svens@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@foss.arm.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf tools: Fix man page build wrt perf-arm-coresight.txt
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf build assumes documentation files starting with "perf-" are man
pages but perf-arm-coresight.txt is not a man page:

asciidoc: ERROR: perf-arm-coresight.txt: line 2: malformed manpage title
asciidoc: ERROR: perf-arm-coresight.txt: line 3: name section expected
asciidoc: FAILED: perf-arm-coresight.txt: line 3: section title expected
make[3]: *** [Makefile:266: perf-arm-coresight.xml] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:895: man] Error 2

Fix by renaming it.

Reported-by: Sven Schnelle <svens@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: dc2e0fb00bb2 ("perf test coresight: Add relevant documentation about ARM64 CoreSight testing")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../Documentation/{perf-arm-coresight.txt => arm-coresight.txt}   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/Documentation/{perf-arm-coresight.txt => arm-coresight.txt} (100%)

diff --git a/tools/perf/Documentation/perf-arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
similarity index 100%
rename from tools/perf/Documentation/perf-arm-coresight.txt
rename to tools/perf/Documentation/arm-coresight.txt
-- 
2.25.1

