Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF84C73093D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjFNUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFNUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:38:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B7268A;
        Wed, 14 Jun 2023 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686775125; x=1718311125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlc58NZmO+HCGma3munqWCePgPA+rLtK94q4D0e6VkI=;
  b=LmG+PbXnUjWbZNTnOlKoAXVxf+/ktFOStJUDzss7gxaoCURRqvd+KldO
   s+/OxL1//QtgKJtGQPGz+28Y57soTYxaLTDa1yZ3q/6CyCMkU5MXgLR9y
   VS/HMVqjsatzw1kOqHADPz8FkwDMh4q2/eCsZOKwdDqUPWqW+2B3JsDiV
   1sGmsCqng2okCpPXztAScwCQHbkaUAOuyQy3bXjJNThuENSQGdGKNWsw9
   E08wL4eVBP/JlnwC/Ush3HHj49TBGZAqC5pqrOYN2Ng67GnpfcKaPCGp9
   JsGXB4RJP/osOBI65fTcyBKwePOkhm5cNEx5lwNckcJdzbhm8HyYa8Pmd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361209016"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361209016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="741963182"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="741963182"
Received: from a0cec87da3f2.jf.intel.com (HELO worker-node-1.jf.intel.com) ([10.165.55.163])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 13:38:45 -0700
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
Subject: [PATCH v3 0/3] Add metric value validation test
Date:   Wed, 14 Jun 2023 13:38:21 -0700
Message-Id: <20230614203824.2895333-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
References: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of metric value validation tests.

We made the following changes from v2 to v3:
 - Add explicit data type casting to float when parsing perf json output [Ian]
 - Add an limit of rerun up to 20 failed metrics  

v2: https://lore.kernel.org/lkml/20230609162625.100897-1-weilin.wang@intel.com/ 

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

