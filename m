Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084BD69505F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBMTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMTH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:07:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE49ECD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315276; x=1707851276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3vsl9GQ18WhZgc6bFqjD99vkWc88ut3blq2u7WktKeY=;
  b=e9LvnYAtXbJ5wubkd31PdmHfFYha11286Wb91aKuqC24Ic9Ga+lU61eh
   Bd/xmxiCV0iP5ebyOQ9w5hPNVhTroLiPUkMJsQzQYeVSW5n+HECl5vjDe
   j5YBdgKR90fw4WX+Pd8CVEPXZH1bxXnReUO+4StjWNWmQCKO5jB6VzpSg
   8/TGA3y4tyPul8K3sp+CqqHXVDw05RpWY1EAZxjRowK+4yP8TTb45bfup
   NgElJF4t28dMP61cdjwcUTB/zXdqL5y6nyP642YGr11igxBieydzT5ZhT
   7hTYh/9Hm0oQs8OSFMXPFxFZQjvmt44yNlRVuSGfxg5rkr5S4Kav6mP6A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108667"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108667"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901905"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901905"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:07:55 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 0/9] Convert TSC to monotonic raw clock for PEBS
Date:   Mon, 13 Feb 2023 11:07:45 -0800
Message-Id: <20230213190754.1836051-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Compared with V1, this patch series provides a different solution to
address the conversion issue according to the feedback from Thomas and
John.
- Support the monotonic raw clock rather than the monotonic clock.
  The monotonic raw clock is not affected by NTP/PTP correction.
  The conversion information can be used to calculate the time for
  large PEBS and do post-processing in perf tool.
- Support post-processing. Move the conversion to the user space
  perf tool.
Link to V1:
https://lore.kernel.org/lkml/20230123182728.825519-1-kan.liang@linux.intel.com/

Motivation:
A Processor Event Based Sampling (PEBS) record includes a field that
provide the time stamp counter value when the counter was overflowed
and the PEBS record was generated. The accurate time stamp can be used
to reconcile user samples. However, the current PEBS codes only can
convert the time stamp to sched_clock, which is not available from user
space. A solution to convert a given TSC to user visible monotonic raw
clock is required.

Solution:
Currently, the conversion of any clock id is done in the kernel. The
patch series extends the existing ABI to dump both the raw HW time
and the conversion information into the user space. The conversion will
be done in the perf tool.

The extended ABI is shared among different ARCHs. But the patch series
only implements the post-processing conversion on X86 platforms. For the
other ARCHs, there is nothing changed. The post-processing conversion
can be added later separately.

Only support the post-processing conversion for monotonic raw clock,
since it is not affected by NTP/PTP correction.

With the patch series, on X86, the post-processing conversion is the
default setting of perf tool for monotonic raw clock.

The patch series is on top of Peter's perf/core branch.

Kan Liang (9):
  timekeeping: Expose the conversion information of monotonic raw
  perf: Extend ABI to support post-processing monotonic raw conversion
  perf/x86: Factor out x86_pmu_sample_preload()
  perf/x86: Enable post-processing monotonic raw conversion
  perf/x86/intel: Enable large PEBS for monotonic raw
  tools headers UAPI: Sync linux/perf_event.h with the kernel sources
  perf session: Support the monotonic raw clock conversion information
  perf evsel, tsc: Support the monotonic raw clock conversion
  perf evsel: Enable post-processing monotonic raw conversion by default

 arch/x86/events/amd/core.c                |  3 +-
 arch/x86/events/core.c                    | 15 +++++++---
 arch/x86/events/intel/core.c              |  6 ++--
 arch/x86/events/intel/ds.c                | 15 +++++++---
 arch/x86/events/perf_event.h              | 20 +++++++++++++
 include/linux/timekeeping.h               | 18 ++++++++++++
 include/uapi/linux/perf_event.h           | 21 ++++++++++++--
 kernel/events/core.c                      |  7 +++++
 kernel/time/timekeeping.c                 | 24 ++++++++++++++++
 tools/include/uapi/linux/perf_event.h     | 21 ++++++++++++--
 tools/lib/perf/include/perf/event.h       |  8 +++++-
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/evsel.c                   | 28 +++++++++++++++++--
 tools/perf/util/evsel.h                   |  8 ++++++
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/session.c                 |  9 ++++++
 tools/perf/util/tsc.c                     | 34 ++++++++++++++++++++++-
 tools/perf/util/tsc.h                     |  8 ++++++
 18 files changed, 223 insertions(+), 24 deletions(-)

-- 
2.35.1

