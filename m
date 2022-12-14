Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068464CDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiLNQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiLNQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:09:19 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D7F57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:09:18 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id r17-20020adfb1d1000000b002421ae7fd46so39026wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7oQvbAJgsoOmtULmkMdeiEDs6Dmo2nAnuZLG7TfGBQ=;
        b=QW6ivnixs8SD8vSnGu+DMuMjtIS7ZkExXQk539lwR4AMJNJHfYG9V14bXHHRE4BM2x
         IMFtpP8XdWZw6ORRVL4yOc01HJ9DQiobnNl5roxjCFv2p5K6LB5MB1LTmTpTg+dzUTBV
         fNSc6beGhwYN9tsX4WUs7Ve+5sNq4BlbH07KAPyl0ImelUqXnF6/FjUs229HMBv7KPs/
         IANBlGz1vBDFB83lvgQdAohKVSFH1N3lC/gB8oqf5EcMW2MNe6Lzd6tz5SX76hDOdjHp
         CA1UihAbnMDBCgSazwFa08vByCZc+JhgEI2XYATBGJTGiNYEZiYq9fhYfH+6Jm/c9nvq
         O+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7oQvbAJgsoOmtULmkMdeiEDs6Dmo2nAnuZLG7TfGBQ=;
        b=Im1PKDgFbgBoSBl4ZOFoRBjF+Xvn5JyqyeBEuLganrGDnvbLjASm9+MX/MbOsr1sng
         4orGEuk+nuTLSYvU/DWDFX9ICqCN2jAt5nq5YB49aSdWGQNJFrYStdmeb1etc995lTNr
         aiYoDrQpgHkJuh+oVoLcA8ijdHDmQIQ7G7vCP9FIj6pWsAXO5rbwxF2Y/72Bjsxf4Dl/
         9BSaMtxLTisNfKwSay8X4P8vRCcE/10Jrga9VPJ3fTkGMdv9CTHuEHy3I+/8Y6Xl6Dpn
         eSPyp8VqCP2ee/fbsJ4WRVzUDYq0ywUmBUrH6TNpyGjSFTHtRQ/FVKaKovOdEdHH9ZWl
         zluA==
X-Gm-Message-State: ANoB5pnuNEpHx9zMeSwPFSv071l6+R4Q93q0uauE/M26GTs8h3VTtU4p
        LeG/ph5NaN9mcTugZauyJIUmorjXL9kfxg0fPw==
X-Google-Smtp-Source: AA0mqf43qeFw+3iEb4uhwvQLKYNs1BD3vSG++gWcPlhWszLGKl2mVI6Nncj7tdfgMdko/oDbEidyknZ/V4o1vPw6+A==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a7b:ce85:0:b0:3d1:f143:c062 with SMTP
 id q5-20020a7bce85000000b003d1f143c062mr225183wmj.128.1671034157185; Wed, 14
 Dec 2022 08:09:17 -0800 (PST)
Date:   Wed, 14 Dec 2022 17:08:55 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221214160856.2164207-1-peternewman@google.com>
Subject: [PATCH v2 1/2] x86/resctrl: Fix event counts regression in reused RMIDs
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        quic_jiles@quicinc.com, tan.shaopeng@fujitsu.com,
        tglx@linutronix.de, x86@kernel.org,
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

Unlike before, __rmid_read() checks for error bits in the MSR read so
that callers don't need to.

Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()")
Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 49 ++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index efe0c30d3a12..77538abeb72a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -146,6 +146,30 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 	return entry;
 }
 
+static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+{
+	u64 msr_val;
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
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+	return 0;
+}
+
 static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
@@ -172,8 +196,12 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 	struct arch_mbm_state *am;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
-	if (am)
+	if (am) {
 		memset(am, 0, sizeof(*am));
+
+		/* Record any initial, non-zero count value. */
+		__rmid_read(rmid, eventid, &am->prev_msr);
+	}
 }
 
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
@@ -191,25 +219,14 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
 	u64 msr_val, chunks;
+	int ret;
 
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
-	if (msr_val & RMID_VAL_ERROR)
-		return -EIO;
-	if (msr_val & RMID_VAL_UNAVAIL)
-		return -EINVAL;
+	ret = __rmid_read(rmid, eventid, &msr_val);
+	if (ret)
+		return ret;
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {

base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.39.0.rc1.256.g54fd8350bd-goog

