Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02FE675496
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjATMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjATMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2F2C656;
        Fri, 20 Jan 2023 04:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218114; x=1705754114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ylfnLKm49NlcEfamuoPXekX6Ok4LJGtizaJMBCvgD3E=;
  b=NFzk/2/r+qwJJyAnODlWm39f8ALYQmjaeEhQY7RnW1Se4vALu8m05wzm
   Nr4CT+yRzq5ngLEjq1YwCST5Fqz5zVBaL9cxnTPc8ZJzRjC5hA59PGxr+
   LXuXor6N+XVnoPti2w1ZolsQ7AQ2TnLCHInf79W2PlOdaQC+7eo+NFfoS
   aeIev1/gTOokcXPQ1KqJ40HjhR3EignjJquFfyDlkOtTFdLIDB/oGC3jf
   zCtX+ktRpRX4jZTI8YPpQGVIuOXXZ64p0CuU5XzfCxDanRjlqg1hN6VVs
   ae8WdRKcXXrQcK6i1WP5yxc0hbTMe/hk9/KN8Q0Xh3s9nqjA6SShuIqLa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935132"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935132"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847411"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847411"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 00/10] perf symbols: Improve dso__synthesize_plt_symbols()
Date:   Fri, 20 Jan 2023 14:34:46 +0200
Message-Id: <20230120123456.12449-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is the first of 2 patchsets to improve dso__synthesize_plt_symbols().
This patchset is really preparation for the 2nd patchset, which focuses
on getting rid of unknown symbols that show up in Intel PT traces.
The 2nd patchset is still under development.

These patches are small and staightforward. Only the new Symbols test is
slightly interesting because it provides a way to see what symbols
perf discovers for any given dso. The test fails initially, but
should pass after patch 7 "perf symbols: Add symbol for .plt header".


Adrian Hunter (10):
      perf test: Add Symbols test
      perf symbols: Factor out get_plt_sizes()
      perf symbols: Check plt_entry_size is not zero
      perf symbols: Add dso__find_symbol_nocache()
      perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
      perf symbols: Do not check ss->dynsym twice
      perf symbols: Add symbol for .plt header
      perf symbols: Allow for .plt entries with no symbol
      perf symbols: Combine handling for SHT_RELA and SHT_REL
      perf symbols: Check SHT_RELA and SHT_REL type earlier

 tools/perf/Documentation/perf-test.txt |   3 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   3 +
 tools/perf/tests/symbols.c             | 150 ++++++++++++++++++++++++++
 tools/perf/tests/tests.h               |   3 +
 tools/perf/util/symbol-elf.c           | 190 +++++++++++++++++----------------
 tools/perf/util/symbol.c               |   5 +
 tools/perf/util/symbol.h               |   1 +
 8 files changed, 262 insertions(+), 94 deletions(-)
 create mode 100644 tools/perf/tests/symbols.c


Regards
Adrian
