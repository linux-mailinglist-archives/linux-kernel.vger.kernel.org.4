Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5076E1E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjDNIXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDNIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF95B9F;
        Fri, 14 Apr 2023 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460602; x=1712996602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IR3enTULW+0dSiranrN8ej6IJa0hU4y3yttWFJiFMng=;
  b=N4IhTVO/7jObHl/8HIZGX3wzi4lDwHtiMS/oRc5UGtvUX6Vrep1abd17
   ryLnFdzGo7dJNyYJCeVCaJ2lvq7Fbqs5N8ukTaaCRId1gJHsG2Ms83/ig
   1+ivbjD4wnF+lKyth1yasmasvuCfRNwdzqyj1ZNkqB5/Pkv/kCU7WEyte
   I8EDuq4Zr+1Cf/peSm+x3Pg/L9so6Ot1VhfIMIGrKrJbCANRD0HZUWuTA
   dUluisUxj5byJaeOuOAeID5MEHNVlqq18RiFPNuQfQgF5256eckxYYoFv
   QKmv+tBqLBzJUOhXK/R8qGJeqqZh3lFzdlHLluG3G7AvgO31OOr+I8SYk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708078"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708078"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267437"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267437"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:16 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
Date:   Fri, 14 Apr 2023 11:22:55 +0300
Message-Id: <20230414082300.34798-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a stab at adding an ioctl for sideband events.

This is to overcome races when reading the same information
from /proc.

To keep it simple, the ioctl is limited to emitting existing
sideband events (fork, namespaces, comm, mmap) to an already
active context.

There are not yet any perf tools patches at this stage.


Adrian Hunter (5):
      perf: Add ioctl to emit sideband events
      perf: Add fork to the sideband ioctl
      perf: Add namespaces to the sideband ioctl
      perf: Add comm to the sideband ioctl
      perf: Add mmap to the sideband ioctl

 include/uapi/linux/perf_event.h |  19 ++-
 kernel/events/core.c            | 315 +++++++++++++++++++++++++++++++++-------
 2 files changed, 280 insertions(+), 54 deletions(-)


Regards
Adrian
