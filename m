Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586566784E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjAWS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAWS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422693E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674498521; x=1706034521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/X2gvIvDqA6WX8ie2w6TrNTNcAhu/c5ClftEGylgFg=;
  b=YlaBFmw9Qq8MG2acxi1bYQz7UTH2fRoLcT9cExCuxjAESn8eAr0aO5Kf
   Gz93WvRmaXlRITHZNH1ZNbtACbnLY0eDh4wWFsVjAU/ARan2rq1zyMSqI
   1T618yxq6vHDEejTnvtJv8wipd7mCt6QRN2cq4OBED6FaaM6nfjKaRo7X
   3V1rJ1nilRdDSRokAmLiHxbWt3m7gyJCjrxbvPVKgwLujZ0ThJZVTB3SM
   +GFrlcTnsy6oUmHpDU9DKE7JtgM9AO2h8YqdKwXr9NE67CD0R1lWuUMgV
   k1iQVHcwXeZT6WOk6hf86zYTGsA3ZvWZ1aQqwvqSbvq5PwLLfCklSR0Zc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328201775"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328201775"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661812072"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661812072"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2023 10:27:42 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/3] Convert TSC to monotonic clock for PEBS
Date:   Mon, 23 Jan 2023 10:27:25 -0800
Message-Id: <20230123182728.825519-1-kan.liang@linux.intel.com>
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

A Processor Event Based Sampling (PEBS) record includes a field that
provide the time stamp counter value when the counter was overflowed
and the PEBS record was generated. The accurate time stamp can be used
to reconcile user samples. However, the current PEBS codes only can
convert the time stamp to sched_clock, which is not available from user
space. A solution to convert a given TSC to user visible monotonic
clock is required.

The perf_event subsystem only converts the TSC in a NMI handler. The
converter function must be fast and NMI safe.

Considered the below two existing functions, but none of them fulfill
the above requirements.
- The ktime_get_mono_fast_ns() is NMI safe, but it can only return the
  current clock monotonic rather than a given time's monotonic.
- The get_device_system_crosststamp() can calculate the system time from
  a given device time. But it's not fast and NMI safe.

Introduce a new generic interface, get_mono_fast_from_given_time, to
convert a given timestamp to clock monotonic.

Kan Liang (3):
  timekeeping: NMI safe converter from a given time to monotonic
  x86/tsc: Add set_tsc_system_counterval
  perf/x86/intel/ds: Support monotonic clock for PEBS

 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 30 +++++++++++++---
 arch/x86/include/asm/tsc.h   |  1 +
 arch/x86/kernel/tsc.c        |  6 ++++
 include/linux/timekeeping.h  |  9 +++++
 kernel/time/timekeeping.c    | 68 ++++++++++++++++++++++++++++++++++--
 6 files changed, 108 insertions(+), 8 deletions(-)

-- 
2.35.1

