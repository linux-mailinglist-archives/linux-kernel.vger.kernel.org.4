Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051E72A027
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbjFIQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjFIQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:26:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939543A97;
        Fri,  9 Jun 2023 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686327993; x=1717863993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GtBv/al6+wYc44j7F60+PSlt5v4CWvv4McB3U6J07gk=;
  b=Qiu0aR19QB+op7RuuskSxSsccqLUgqotPsLpTS5KFjKRl3M8jMjEVvRA
   UuPNkgUvXYk+TC+2LsY/r0+hw+rkhk1bq+Bdy5rRyy0N82RbjlQOGQdxY
   70r8jl1wGqummqD93MIvftm1EW1VE8PeUqEpBY47s5bmB33JDTgMBkHvI
   5VsMyXphWmUZjLGqAfHYYs/tTow2Eg4XzHdc4+rQbQ6mKSZTos10bPRCc
   QTqxKxymtqt3uC7c3ljLkDSqoSzoql8SeGmU82qK89qw3dYdromH7bsYn
   p0a24Vk8D7NIRK4DoWFdrsrAfIMKS9fnAtcYSLXv6+NH9QBachzYPQwi+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355123847"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="355123847"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 09:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800269655"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="800269655"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 09:26:32 -0700
From:   Weilin Wang <weilin.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: [PATCH v2 0/3] Add metric value validation test
Date:   Fri,  9 Jun 2023 09:26:22 -0700
Message-Id: <20230609162625.100897-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of metric value validation tests.

We made the following changes from v1 to v2:
 - Add python setting check [Ian]
 - Skip non-Intel architectures [Ian]
 - Rename allowlist to skiplist [Ian]

v1: https://lore.kernel.org/lkml/20230606202421.2628401-1-weilin.wang@intel.com/

Weilin Wang (3):
  perf test: Add metric value validation test
  perf test: Add skip list for metrics known would fail
  perf test: Rerun failed metrics with longer workload

 .../tests/shell/lib/perf_metric_validation.py | 574 ++++++++++++++++++
 .../lib/perf_metric_validation_rules.json     | 398 ++++++++++++
 tools/perf/tests/shell/stat_metrics_values.sh |  30 +
 3 files changed, 1002 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation.py
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation_rules.json
 create mode 100755 tools/perf/tests/shell/stat_metrics_values.sh


base-commit: 7cdda6998ee55140e64894e25048df7157344fc9
-- 
2.39.1

