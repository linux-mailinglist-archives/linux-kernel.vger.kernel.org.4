Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EE737237
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFTRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjFTRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:00:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3791728;
        Tue, 20 Jun 2023 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687280433; x=1718816433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OBAerPf67KJbNEHvyQM2OXQEr7NY+xfC/oeSx78gcuk=;
  b=BV6gw48xtQLDByDJQvesnMXYcss3oJZll9TSoejfFWMZhx7RfphWxTq8
   meQzhHYaUQsOKf8MKhaSh3K3YzSEf9xplkL50ECQOTcLrFU96po+s7hoI
   G0YuXkgG0o28uyAwwGHrrYhr/wJzlNqoCVv9rPmdgyacq4TZEmkhmMlBq
   ZSZ8lbk3Co6CBbUY4RP9EUz8GgjOhxv9KnWLQmnfyE/XO2BveOlPexZ4N
   y2QoF/qOf7LWI7DZEASYjoc5VHDd5Uwlpzhzo76rXm4L28PwPRxg/InBC
   /HLoCiKSV/yECMmth2B6WIDaIP0ZaS/ccJZMgbSdTwiKM9me/gvfBTyPE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="359929599"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="359929599"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888314320"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="888314320"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 10:00:32 -0700
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
Subject: [PATCH v5 0/3] Add metric value validation test
Date:   Tue, 20 Jun 2023 10:00:24 -0700
Message-Id: <20230620170027.1861012-1-weilin.wang@intel.com>
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

This is the fifth version of metric value validation tests.

We made the following changes from v4 to v5:
 - Update "()" to "{}" to avoid creating sub shell and successfully skip test on non-Intel
 platform. [Ravi]

v4: https://lore.kernel.org/lkml/20230618172820.751560-1-weilin.wang@intel.com/

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

