Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4940363C7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiK2TKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbiK2TKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:10:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C730556
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669749044; x=1701285044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CRC1QpMRvg+SgNUKD7+JhmJV8K8WczePzSImvqnWffY=;
  b=nMh3EGNX/o1z6IUKF1Pep7qL98kqFlMnXp+S2ahYYPPc2ReT8PnDgR1x
   AFo+GQRTaLDBLJtfIMFyfORF3+NmBuFHSOYLnvml6D1t957zJEPwESfXc
   FNK3tmANC9iJTgkIWhjR2Zh/nOhL+RpZxLtDOtJQ+MjC6DE62gp2Pxtus
   EDk4c950p+WetYMH8v100qxzTHkk/obJtCgII0EFtDr1wASRua+DPFCN3
   ck2e1PE2mzqVv16OrLliRBpJrcFqDI65VNXTRAMPPBMKWvpgbynKXfzs2
   ovKW3xfzeNZBhqvfXYiu/sIGISNp/2s4rl4ho4lNCdBg752Oa06L8fpAw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379490757"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379490757"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749991987"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="749991987"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 11:10:32 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/5] Fix UPI uncore issue on SPR
Date:   Tue, 29 Nov 2022 11:10:18 -0800
Message-Id: <20221129191023.936738-1-kan.liang@linux.intel.com>
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

