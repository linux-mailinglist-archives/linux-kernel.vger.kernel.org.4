Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D089C656A42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiL0L7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiL0L64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:58:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5769B7E6;
        Tue, 27 Dec 2022 03:58:55 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672142334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TZqt83Scy1dn6mE5MEfELkLQ3zO2SAdanIc2JfFnxw=;
        b=qhk9vEUlzTUL6qHkKrQO9QFUF2NXJE3xVPJEdAdFY08IU5JnYQHZd55sFJ419dC6EPijC1
        mjVpDTKrjMx9HAYgstMpmhHifMTBNcFmp5WW80H4FwOLhQnWZdJO0dSMWcRTgNsUSNo8sH
        dn02wnJwqiAqEOhomq8QE1VM6MHDhI6cIj9myyADld1sbGZn6+kyLYnBuKkPUFFzO/5EJ3
        LHV2BMBYFctRSZzZf6RqGl11KEYVc5ygwbixuasfMZ8IqDWuOZtUTFbTWlyS/2HOLs+U4s
        YHoxymZh3ej3bUrti4bZi7gtcVgb0q8oNK/XytllpB/3zpQ0xqg7HDaJEFyxdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672142334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TZqt83Scy1dn6mE5MEfELkLQ3zO2SAdanIc2JfFnxw=;
        b=D2nnJJTYpmrpxMq+3A5RuX2SAAzcvNVd5Efl1e3xTOx5CaAApzcyYPK+S0rl7Zrzj0RLHr
        twk7hgKJIkfLMwDQ==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/lbr: Simplify the exposure check for the
 LBR_INFO registers
Cc:     Like Xu <like.xu@linux.intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125040604.5051-2-weijiang.yang@intel.com>
References: <20221125040604.5051-2-weijiang.yang@intel.com>
MIME-Version: 1.0
Message-ID: <167214233418.4906.13269799714918773894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     03c4c7f88709fac0e20b6a48357c73d6fc50e544
Gitweb:        https://git.kernel.org/tip/03c4c7f88709fac0e20b6a48357c73d6fc50e544
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Thu, 24 Nov 2022 23:05:50 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:07 +01:00

perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers

The x86_pmu.lbr_info is 0 unless explicitly initialized, so there's
no point checking x86_pmu.intel_cap.lbr_format.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20221125040604.5051-2-weijiang.yang@intel.com
---
 arch/x86/events/intel/lbr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1f21f57..c3b0d15 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1606,12 +1606,10 @@ clear_arch_lbr:
  */
 void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
-	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
-
 	lbr->nr = x86_pmu.lbr_nr;
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
-	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
+	lbr->info = x86_pmu.lbr_info;
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
