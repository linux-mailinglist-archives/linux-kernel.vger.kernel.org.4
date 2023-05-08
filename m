Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494D6FA380
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjEHJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:40:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212781709;
        Mon,  8 May 2023 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683538832; x=1715074832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FbTuCrNfqpLm6qqrj0ilSsTazE+fOIbTBMkylLTw674=;
  b=WYTXgvU7hcioNF8wlQmwQdW3PK4wEMu3vMo0Y6H4XqR4VYYkGQWAbBG4
   PDCRRxHmfSAxPqzgg9MmIdzyX/S2P0o9IeanoAEih1sIvUYWn1uvTyS99
   GqK4fbcGLK1jBiquk+calFnb6kKVkjIvNYnssArI7XdQHlreXdaRz2mFz
   QG6LKSO3odUPqO8VaBJzQCnXPbUtv6zTZ767+bb2MM+GoWFg+K2E4MQ73
   zki1GMMhi6VkcRZ69LiyVJMbAWy5Xrti7+cVc6svUINL2NfBlW7Twy3Hg
   sELKw38TzdZ+y3nMH9rkrBY6DkTzlY44d0qZ8PcZuhwLhKVG1wu5v8M6/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329223670"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329223670"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028354984"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="1028354984"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.218.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 0/2] perf parse-events: Do not break up AUX event group
Date:   Mon,  8 May 2023 12:39:50 +0300
Message-Id: <20230508093952.27482-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a fix needed in v6.4, but dependent on Ian's patch
"perf evsel: Modify group pmu name for software events", refer:

https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/

There is also a test amendment to test the AUX event group fix for
Intel PT.


Changes in V2:

   Add an Intel PT test amendment for the AUX event group fix
   Change AUX event group fix as suggested by Ian


Adrian Hunter (2):
      perf test: test_intel_pt.sh: Test sample mode with named PMU
      perf parse-events: Do not break up AUX event group

 tools/perf/tests/shell/test_intel_pt.sh | 7 +++++++
 tools/perf/util/evsel.c                 | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)


Regards
Adrian
