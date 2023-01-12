Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1C668357
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjALUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbjALUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:04:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FF519C29
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673553715; x=1705089715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CRC1QpMRvg+SgNUKD7+JhmJV8K8WczePzSImvqnWffY=;
  b=TYwqzNh5Qc+JbAbvYCeqFsW9H613MyoS+lYRHJsyB8hxTlHeF8pPbp1x
   WjLAHIpvhq9DMJXM1ozLdihakSBpPMuFQ6dIGMshD9EaEVXq9lyI3thWD
   kWNyiC0BtbbV9lUO4d+Sj1IkUjNREM53KB318FPOiFivhomWxcjXpj68B
   14/bHo3fdPnHAyGAhQ7Lo/T5dPChb9IPznGR40t6l4RlP4leXJCmcO35i
   NRV/VcWZX3LSslSVTsjFz4xax7e1FxP6mjMw7Ezc9JsHIhtF9JHDwlP3v
   yVw0Wpui87IXZ7FGgNsj9QdnKr7FB6Cd61Oul9hW/G6gWklqMz7pK2Ho6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325867090"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325867090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657959922"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657959922"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 12:01:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 0/5] Fix UPI uncore issue on SPR
Date:   Thu, 12 Jan 2023 12:01:00 -0800
Message-Id: <20230112200105.733466-1-kan.liang@linux.intel.com>
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

The discovery table of UPI on SPR MCC is broken. The patch series is
to mitigate the issue by providing a hardcode pre-defined table.

The broken discovery table can trigger a kernel warning message, which
is overkilled. The patch series also refine the error handling code.

Kan Liang (5):
  perf/x86/uncore: Factor out uncore_device_to_die()
  perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
  perf/x86/uncore: Ignore broken units in discovery table
  perf/x86/uncore: Add a quirk for UPI on SPR
  perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table

 arch/x86/events/intel/uncore.c           |  34 ++++-
 arch/x86/events/intel/uncore.h           |   4 +
 arch/x86/events/intel/uncore_discovery.c |  60 ++++++---
 arch/x86/events/intel/uncore_discovery.h |  14 +-
 arch/x86/events/intel/uncore_snbep.c     | 158 ++++++++++++++++++-----
 5 files changed, 210 insertions(+), 60 deletions(-)

-- 
2.35.1

