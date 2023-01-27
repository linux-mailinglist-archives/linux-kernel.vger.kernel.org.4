Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130F67EBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjA0RDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjA0RCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:02:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227EF17CD3;
        Fri, 27 Jan 2023 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838956; x=1706374956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wCtzZPSP7T2Ma+5uTMhlXVsVgYdIxPIxHp/22fDmBJE=;
  b=EJBZ3+hR0Ex0Um13kMigzczO0RvGRbROGHPJcmBNIBq8NukwFO5jW0NS
   zJI5P24OadivzkTjDRAoTXvlP9Wk3AT6OHqVMTHNOKZMJufMdzbgJf54G
   myJ0HtppTaECUXf5tpOUd1tCeitgpBHlpJyokwr39CR6uJ6v2/ResKuiU
   DUEnq1DOajmVf/t3Vj11S4pX3TEt0dzB2tEGHKLfNy2UlCwa3zrxV1KRi
   zuesBlRSIRegFNyTtx2Q7V+rZN4FxxMp2/Q7SNCTHDe9pDJFswScW2CYY
   iTt6W+Isba2lisgGe3zXn2Stt8XwZRMtT5LFHY4XQemadlzotbwn+pNxT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754097"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739141"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739141"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:32 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/9] perf symbols: Improve dso__synthesize_plt_symbols() for x86
Date:   Fri, 27 Jan 2023 19:02:13 +0200
Message-Id: <20230127170222.9895-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is the second of 2 patchsets to improve dso__synthesize_plt_symbols().
This patchset focuses on getting rid of unknown symbols that show up in
Intel PT traces.

x86 has 2 more plt's, namely .plt.sec and .plt.got, so support is added for
synthesizing symbols for them.  Special handing is needed for IFUNC symbols,
and it is also possible to have a .plt for static executables, so support is
added for that.


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

 tools/perf/util/symbol-elf.c | 362 ++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/symbol.c     |   4 +
 tools/perf/util/symbol.h     |   2 +
 tools/perf/util/symsrc.h     |   1 +
 4 files changed, 347 insertions(+), 22 deletions(-)


Regards
Adrian
