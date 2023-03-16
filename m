Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768736BD970
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCPTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCPTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:42:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45E26854;
        Thu, 16 Mar 2023 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678995733; x=1710531733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PEHbTAcG8Dy16DzIEQj/RKjzcN4aB46ybFS9r0LuhvU=;
  b=Ngc1AisAeqvMiU8XmvSl+Oss522X0SND3aJ8hrLv8udEuAENhaGPny1a
   8p00nMUmMWJOFdY7r0DpJFHM4nn0SoO0oyfwwNz4QVJw0ukR8nnNwwuU5
   yS8xh50+3IuqkCMSlk7B5DC+8XRCmo1JZA3KmfQu9e7VZOm1JuNcFH6bd
   A1QG88KSr4ubHJOZnxDbBlL2DvMui/I5rpdpDMUKRGjESTnIhxGeblFeG
   XPPbYcZIDjhHNh09YmRFrlYqjaillTYN67XJ+qsT2J4+VgLpjCFZO1c5a
   laAE1qAk7qNcFdP7BUTqtHjIGYSUzsf+2m33NNyaLJq8w15/WZl26d0/F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326465392"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326465392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823392384"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823392384"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.221.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Address fixes
Date:   Thu, 16 Mar 2023 21:41:53 +0200
Message-Id: <20230316194156.8320-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 3 small fixes resulting from a report from a
kernel test robot:

https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com

Issues were revealed due to the use of build
option:

	EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address"


Adrian Hunter (3):
      perf symbols: Fix use-after-free in get_plt_got_name()
      perf symbols: Fix unaligned access in get_x86_64_plt_disp()
      perf tools: Avoid warning in do_realloc_array_as_needed()

 tools/perf/util/symbol-elf.c | 10 ++++++++--
 tools/perf/util/util.c       |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)


Regards
Adrian
