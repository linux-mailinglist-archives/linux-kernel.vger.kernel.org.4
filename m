Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B356B9C68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCNRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCNRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:00:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7CA6BCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678813247; x=1710349247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4Veho/yd3aXlAmFcEMi+eBZxYh7bKd6lV0oR1Ua++4=;
  b=n0kfPQaf9nxMIr0Gy18JA62ZJKGD+CynI71GJ3GwtxJuEdEBwOf9e/A/
   v9Q2tOsKFtus+ayLY9EsWOieTLfCKsNSvKkN0If0Rwe2DOtJivcJelRja
   HRXqGJbP2syJx3DZSi0awgntA5IO+N7+9hXQkwLjapdnkTSJVsQtAzgVg
   5FCBKnBtQ3J2/iuFPBDFHe8aIZG9Ngycerbst3D2IEshChxgqaemZHBFL
   irmEjxqza2PBbG6ZrKqiFy4Me77y1xvSLVD+d6yM0zSzV4hB1TvaY3V9i
   NizSb11rNW+lmilsL/meJraqLdHwyJ7dqHIw5BxlZZik+fPWXNcfKJbEA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334971173"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334971173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743379732"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="743379732"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2023 10:00:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/cstate: Add Granite Rapids support
Date:   Tue, 14 Mar 2023 10:00:41 -0700
Message-Id: <20230314170041.2967712-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230314170041.2967712-1-kan.liang@linux.intel.com>
References: <20230314170041.2967712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Granite Rapids Xeon is successor or Emerald Rapids Xeon, and it will use
the same C-state residency counters as Emerald Rapids (and previous
Xeons, all the way back to Ice Lake Xeon).

Add Granite Rapids Xeon support.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 551741e79e03..835862c548cc 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -678,6 +678,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&icx_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
-- 
2.35.1

