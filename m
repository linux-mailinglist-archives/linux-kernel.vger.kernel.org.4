Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429B710754
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjEYI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbjEYI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:29:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C3186;
        Thu, 25 May 2023 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685003356; x=1716539356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QHA0PUM2kozuFhevzuFcZbE8+0O6nv9jDPUSc6oHy+0=;
  b=Oa/X3pAI5cc/rRPJSSM1MKyWZ2WWWogCuk8mwtwS6mHLGtfyfb2cqvUh
   xOXZnEnjS/rx4AcOOD5yBnsSci8AWSHs7uHlyrgUrd9CweWYH8oc4zPjz
   yc4eKOUeXiKtq6OLcIyhwHfPGzu5v4GUG0j/HIRcO8EVooQjXzEV4VY53
   0AzQFZZMcGgm6P3fyqXITxCFLLeDky37/9v8bwmGhbt7E4q/lk1y16J6e
   d/osCyYRcpaNVnSsM3YxyxJ/xqu1SAYJKGE/Kh2dFhS6EN3xaFruyIt1j
   UBUQySyii+c8iQ0EXt35smTv/uVYN64+FmAulk3COfMFhL+Wr9YqOa71O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338400398"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338400398"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="707914632"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="707914632"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.63])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:29:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
Date:   Thu, 25 May 2023 11:29:01 +0300
Message-Id: <20230525082902.25332-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a patch (V3) to the event parser for breakpoint events.
I am not that familiar with flex / bison, but it seemed to
need trailing context to stop the mem event colon and slash
delimiters from getting mixed up with delimiters for config
terms or event modifiers.  Please look closely at that.


Changes in V3:

      Add Ian's Reviewed-by
      Re-base

Changes in V2:

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
