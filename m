Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145BD682D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAaNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAaNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35440F4;
        Tue, 31 Jan 2023 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171000; x=1706707000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zaxyd+z/I9AM+7RzYwsdqmttiRt1yiJDKbXP9RraI94=;
  b=PDnxGEQn0JT1PcJehFaqzOhW22NBbquuXSaeIXcgGW/Dc0pCK9+PBH/M
   RPYr4jjfsEJSgo9f5WwsYsNPKAfh/okJt4JgbNpYbNk4oVKtuTOHtUqJ4
   ZbJCDgdyGNmOV0o54GBbXwIgK1v0r1DIc6Mc0jW2Ix8VtJVeUYTO+9BmF
   dsx34106EBpKhFX4rjFDAZy0hVrgZbI1d2SlTrULIZ3uCw+0KTdpcbgcI
   Dc+T1kyOngTVI7fonuiAHmHKGnjOOQdhKvErqwdkCkBW5B/dmSZy2DAhl
   qc/9DLL27Q/eyxE3FbDrqBNOQNy+OiU4npWvRU3YlWngUVzrToaagoQdp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534132"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534132"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864786"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864786"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:35 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 0/9] perf symbols: Improve dso__synthesize_plt_symbols() for x86
Date:   Tue, 31 Jan 2023 15:16:16 +0200
Message-Id: <20230131131625.6964-1-adrian.hunter@intel.com>
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

This is version 2 of the second of 2 patchsets to improve
dso__synthesize_plt_symbols().
This patchset focuses on getting rid of unknown symbols that show up in
Intel PT traces.

x86 has 2 more plt's, namely .plt.sec and .plt.got, so support is added for
synthesizing symbols for them.  Special handing is needed for IFUNC symbols,
and it is also possible to have a .plt for static executables, so support is
added for that.


Changes in V2:

    perf symbols: Add support for x86 .plt.sec
        Amend commit message and example about -z plt

    perf symbols: Get symbols for .plt.got for x86-64
        Fix get_plt_got_name() not to segfault with EM_386


Adrian Hunter (9):
      perf symbols: Correct plt entry sizes for x86
      perf symbols: Add support for x86 .plt.sec
      perf symbols: Sort plt relocations for x86
      perf symbols: Record whether a symbol is an alias for an IFUNC symbol
      perf symbols: Add support for IFUNC symbols for x86_64
      perf symbols: Allow for .plt without header
      perf symbols: Allow for static executables with .plt
      perf symbols: Start adding support for .plt.got for x86
      perf symbols: Get symbols for .plt.got for x86-64

 tools/perf/util/symbol-elf.c | 365 ++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/symbol.c     |   4 +
 tools/perf/util/symbol.h     |   2 +
 tools/perf/util/symsrc.h     |   1 +
 4 files changed, 350 insertions(+), 22 deletions(-)


Regards
Adrian
