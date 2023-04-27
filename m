Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22B6F05B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbjD0M1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbjD0M1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:27:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245930E8;
        Thu, 27 Apr 2023 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682598431; x=1714134431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xj/XyP4DzYKwdDIGUXz+Qi03vajUdx0rou1hGVsMx7o=;
  b=SXUv+NTRzJkaNOreY1gA5g88XLUu6S90VcY9z295MtAL6sOioK3kcIxj
   5+PcwRP7j8Q9SaeuvkC16HNmc2RJvZuW+8cvnTD1oEADV4Qo7UrPG5Da/
   wcwufYaqU+orh1ycYaooXKQjCL8W7BJJKmBNFe9gVR7o0YIXuMC7O1CSH
   mEhkUMef7DKnzEYsev+S04x3Tf7jrP6Aa5Br4EB5E8goMYKdxmCLcet9F
   WTdYywdxmrn+n5fc6KlIEJohklWXJNbj5H/3LCMvyXY6r4rOAV/DjNdof
   rmblSaAoMD3gH2/nR3lcMFWaukpP8wF8/dgB0YDc2a9736kXBK/gPj/M7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344869604"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="344869604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 05:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="644677899"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644677899"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 05:27:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/1] perf tools: Allow config terms with breakpoints
Date:   Thu, 27 Apr 2023 15:26:55 +0300
Message-Id: <20230427122656.42473-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch to the event parser for breakpoint events.
I am not that familiar with flex / bison, but it seemed to
need trailing context to stop the mem event colon and slash
delimiters from getting mixed up with delimiters for config
terms or event modifiers.  Please look closely at that.


Adrian Hunter (1):
      perf tools: Allow config terms with breakpoints

 tools/perf/tests/parse-events.c | 135 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c  |  23 +++++--
 tools/perf/util/parse-events.h  |   6 +-
 tools/perf/util/parse-events.l  |   7 ++-
 tools/perf/util/parse-events.y  |  42 +++++++------
 5 files changed, 187 insertions(+), 26 deletions(-)


Regards
Adrian
