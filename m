Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8F73EB39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:36:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDD10DA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687808185; x=1719344185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s2bBVzbs0mPzNnuPaqyoVSnWQrfPRKFxiCSlmw6qCH0=;
  b=N/cYv1Jl4LGlsxVLQs/5dL3FnWSVpJ/nTTO44q5xCQ9c1vwbLtxAr5V1
   jOJd3r092ap9Ej9Qx61rPfbxDXBmgvKrPUfxPerzYIBLCTrEBOQUW7z1a
   hwj86Usw89n/PEqa9czVy9nYmpaqeRG31ybIAPNKdzmk2ru+NhCkPvptO
   /nETlooSWsYfjjdHgo7Ui0Xz+4GDHQKRNqnPRTWiQdcxY/0+A+9OO4w7z
   nxZFEoXZFr0euj1ugqRKWQH2w+1hcKh9g5cxX/b+7HnTGuCMW4R94Kr0I
   BP/foYvASDX05YfbCU+4jrp5r5ci+q7ePOdz1JVBf9H1LEoItE7obYTeQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351148343"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208,223";a="351148343"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716270794"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208,223";a="716270794"
Received: from yjie-desk1.jf.intel.com ([10.24.96.120])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:36:23 -0700
From:   Keyon Jie <yang.jie@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH] x86/aperfmperf: Fix the fallback condition in arch_freq_get_on_cpu()
Date:   Mon, 26 Jun 2023 12:36:01 -0700
Message-Id: <20230626193601.9169-1-yang.jie@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the commit f3eca381bd49 on, the fallback condition about the 'the
last update was too long' have been comparing ticks and milliseconds by
mistake, which leads to that the condition is met and the fallback
method is used frequently.

The change to compare ticks here corrects that and fixes related issues
have been seen on x86 platforms since 5.18 kernel.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
CC: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f07448f..24e24e137226 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -432,7 +432,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * Bail on invalid count and when the last update was too long ago,
 	 * which covers idle and NOHZ full CPUs.
 	 */
-	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
+	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE * cpu_khz)
 		goto fallback;
 
 	return div64_u64((cpu_khz * acnt), mcnt);
-- 
2.34.1

