Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C06F1881
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjD1MyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1Mx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:53:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BB2701;
        Fri, 28 Apr 2023 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682686437; x=1714222437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SwlO+zJZX2Fwd239/8Bsb6WY1dKLW4hVckNBRRJnpxw=;
  b=d6AG87Zrhd2760Hq9liET/o5X9dKVhlctXB3wYSgiJAX/qXVAurIdi6C
   n8Z79Cp68heqEh46g1SQrgILtFU9L65ebE2gpg2n8KbP4ZOYK1jcdSTff
   xZ9qLF1AJK6UhGTzSmvAG2jr6udI2jtuwvSvhAFtNZ8Bqn3F9Ug6yf+oT
   NG3hB4n5YiJljVsGtQ5kjL5W4BDcDvMWt9s0byVDeSdEBzc4TEZ/MiuCS
   OblI9lF9F4PHFgamy/utlDu/Wf2417ZdADKA4TFE51068iIW7+FV3IJ3q
   tVNCYpxXv3j1+4q/bpMRka0Mz7vUAqVcsKbho19yIt2kiAhN5Ekov5Klf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="413127709"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="413127709"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 05:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="759646721"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="759646721"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.36.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 05:53:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 0/1] perf tools: Allow config terms with breakpoints
Date:   Fri, 28 Apr 2023 15:53:44 +0300
Message-Id: <20230428125345.8924-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch (V2) to the event parser for breakpoint events.
I am not that familiar with flex / bison, but it seemed to
need trailing context to stop the mem event colon and slash
delimiters from getting mixed up with delimiters for config
terms or event modifiers.  Please look closely at that.


Change in V2:

      Add comments to tools/perf/util/parse-events.l
      Add a test for 2 mem events back to back with config terms


Adrian Hunter (1):
      perf tools: Allow config terms with breakpoints

 tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.c  |  23 +++++-
 tools/perf/util/parse-events.h  |   6 +-
 tools/perf/util/parse-events.l  |  23 +++++-
 tools/perf/util/parse-events.y  |  42 ++++++-----
 5 files changed, 224 insertions(+), 27 deletions(-)


Regards
Adrian
