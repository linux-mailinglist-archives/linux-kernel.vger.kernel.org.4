Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7E734730
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFRR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFRR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:28:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A78319C;
        Sun, 18 Jun 2023 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687109302; x=1718645302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e8avxImRtZ2qy1cW4EqONzycWNXCvxmsepn/lHqg8vQ=;
  b=QD1LaiNQTYJGez6zUm9+0N+EOwyT2e83Ocjvl07qS8ECU/o3rRL1n6fs
   Mf3mPLHczmeifpzJTXLRDn5EQ74FB/dOUyCcOeOMhiuA09NHhNcLvf3aX
   +vmxW0tTIATVfVxtDpCihkqXJZmz1Sxdf80vCAGcPRoNJaIFmU9MnpVn8
   4I0jpDubJIPVnTGXa2A3jPVeCnFJwnuSqYEMg9CLH5IDUf16GOxQ2CLdt
   m/5uLxSzQo47x5r9rf4TPN7PDNPFatR0W1YyhYXJtvRrL8zynQzkc9UG9
   AWWSgvUeIyEoszY+tevaeESiTc4PVAztmsrNxMAYF4ZPMNk3rPxzS5lXu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="445877677"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="445877677"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 10:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="826354021"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="826354021"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2023 10:28:21 -0700
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
        Caleb Biggers <caleb.biggers@intel.com>, ravi.bangoria@amd.com
Subject: [PATCH v4 0/3] Add metric value validation test
Date:   Sun, 18 Jun 2023 10:28:17 -0700
Message-Id: <20230618172820.751560-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth version of metric value validation tests.

We made the following changes from v3 to v4:
 - Update search string from "Intel" to "GenuineIntel" to skip test on non-Intel
 platform.

v3: https://lore.kernel.org/lkml/20230614203824.2895333-1-weilin.wang@intel.com/ 

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

