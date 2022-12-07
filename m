Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AFE645905
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLGL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLGL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:29:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8547304
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:29:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i19-20020a253b13000000b0070358cca7f7so4902765yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=io7txIjxWH6pJVXEI7Hxrn83i6WbHyJAQOFZka8ddgg=;
        b=Au1I/GqNOl4lybF3LIlQtIcU2l9cxCRe1QfmEW4fw92Ey/0wqzuku7b+yTlT7mOjuF
         AFsJypsJppZG8+tKZ+8l+NUfWopF3nR7Vfc03Yg4DE+ZwSSz9pDLZGhYKpzayV+DQUgL
         31kKadJ/OffOKwwPGK0avlB0pahEHypEg5Cc5Jxbt5nJPp6TWVy5Du0G7gSxaJ1X2DVY
         uOUq9JgOBAIQoGL8Dn5ffesmHkO1z6qrxItgjpZpdp9DNZQKHdAcjlx/1pJCzhVUpLX4
         lpsK88Pb9zgheJPp/U/PRH/b3tcuCJGmCPo/AGHb3NTStKx2/fpw9tLn8ni5MmlV8tSg
         yyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io7txIjxWH6pJVXEI7Hxrn83i6WbHyJAQOFZka8ddgg=;
        b=GKJDKTb/HHqSlasHWfVWgR2oXxmvMKmpPt8Qf7gSuiGOyqSOwG1KEdlv66oFEoeANL
         zbPdTRAZf1HESUqReUsJzTaYf/AlTCOn7RHwiCc4pI8UH9WvXoyAj9gk/03kyq3ghGBd
         AI49moaZknMlHELoDa0QpNtcgrzD3xqGaLtKyuM0K0N1xl/zopJ0VpNZDUJktanPeVlG
         hprAmAEdH2bgQwoVTOrLS7+rHoOhQwtxMUDEjLS7pdyHXYor43nQxH6Rq6ZYse/VdF1x
         5SuCA3oES3NITykha+ROvdMOgNMP+zbK1FkS8PbWtNnOBNLyPKWlnyRKWFfxIhBToLPu
         ujEQ==
X-Gm-Message-State: ANoB5pk9deHDos4QQRyzj+J2HDDf4nQ+N/Aob9ITarX/fv6drWWb4YKF
        FIA4rO/aKJtKYA15ecDMWIPjGAzPQc1rr5ufeQ==
X-Google-Smtp-Source: AA0mqf4OEiSIHezAUsM2xUHu6RfGjAOI4hyDSXkl7rNwOK3p6hyEDw40rm3mH8UonKFrBi7/dRF2cJ7ZgMmf+HNIrw==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:d6fd:f294:ba46:7a93])
 (user=peternewman job=sendgmr) by 2002:a81:110f:0:b0:3c3:ed97:3ea3 with SMTP
 id 15-20020a81110f000000b003c3ed973ea3mr45636117ywr.198.1670412572260; Wed,
 07 Dec 2022 03:29:32 -0800 (PST)
Date:   Wed,  7 Dec 2022 12:29:24 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207112924.3602960-1-peternewman@google.com>
Subject: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, eranian@google.com,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a new monitoring group, the RMID allocated for it may have
been used by a group which was previously removed. In this case, the
hardware counters will have non-zero values which should be deducted
from what is reported in the new group's counts.

resctrl_arch_reset_rmid() initializes the prev_msr value for counters to
0, causing the initial count to be charged to the new group. Resurrect
__rmid_read() and use it to initialize prev_msr correctly.

Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()")
Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 39 ++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index efe0c30d3a12..404dd9c472c7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -146,6 +146,24 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 	return entry;
 }

+static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
+{
+	u64 val;
+
+	/*
+	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
+	 * with a valid event code for supported resource type and the bits
+	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
+	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
+	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
+	 * are error bits.
+	 */
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	rdmsrl(MSR_IA32_QM_CTR, val);
+
+	return val;
+}
+
 static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
@@ -170,10 +188,17 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
+	uint64_t val;

 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
-	if (am)
+	if (am) {
 		memset(am, 0, sizeof(*am));
+
+		/* Record any initial, non-zero count value. */
+		val = __rmid_read(rmid, eventid);
+		if (!(val & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)))
+			am->prev_msr = val;
+	}
 }

 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
@@ -195,17 +220,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;

-	/*
-	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
-	 * with a valid event code for supported resource type and the bits
-	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
-	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
-	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
-	 * are error bits.
-	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, msr_val);
-
+	msr_val = __rmid_read(rmid, eventid);
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
 	if (msr_val & RMID_VAL_UNAVAIL)

base-commit: 76dcd734eca23168cb008912c0f69ff408905235
--
2.39.0.rc0.267.gcb52ba06e7-goog

