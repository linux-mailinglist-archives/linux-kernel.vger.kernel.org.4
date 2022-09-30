Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362DF5F07AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiI3Jbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiI3JbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C5CE6E2;
        Fri, 30 Sep 2022 02:31:10 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlDFT3vqXSF0orFxZ3HHATNF9zZpR75GHFKi1/qAKm4=;
        b=sJZ6i9LFqkNZtpECpjRjmrFuYF81RBBxvf/BLswFwcUo+hF3+tWD2smKlEXBOBClve+3+B
        byS27rPitaM74P4UR1nrD0X6ZLRaVeSj6qbRIVTChCzjNMBcbt9cQMD2xhqHCMR1cpSysw
        jyEtVfFOCAAV+AYpXYi68aXsOZp5/v30kemkzpT6rBzHbZk6Ri2Z1PcS39r+E16vMhU1Rr
        n7HZMeFRsbFG2/lnVsmsNwJbHDUln2Z5i2oGdeipliksY+Y/1DTY/Bx05CSFIbNTZn0kbE
        mOmaEbpU6b1h+YkrnkoASg3LhoaKko/xKKomFdHC7lEqgccq8XIRHa34zcrtKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlDFT3vqXSF0orFxZ3HHATNF9zZpR75GHFKi1/qAKm4=;
        b=XqIBwNEV7tT9N6b0jewn+IRYpwqj5dBzX2RyI01FngRUr5YXqgGElxCke+tF7HzuOGu7Zp
        635gTVyEjOyyfRBA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-5-ravi.bangoria@amd.com>
References: <20220928095805.596-5-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026675.401.13716342823853063236.tip-bot2@tip-bot2>
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

Commit-ID:     6b2ae4952ef8ac23b467bc10776404092b581143
Gitweb:        https://git.kernel.org/tip/6b2ae4952ef8ac23b467bc10776404092b581143
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:54 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:55 +02:00

perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}

IbsDcMissLat indicates the number of clock cycles from when a miss is
detected in the data cache to when the data was delivered to the core.
Similarly, IbsTagToRetCtr provides number of cycles from when the op
was tagged to when the op was retired. Consider these fields for
sample->weight.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-5-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e20caa5..d883694 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -955,6 +955,7 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 {
 	union ibs_op_data3 op_data3;
 	union ibs_op_data2 op_data2;
+	union ibs_op_data op_data;
 
 	data->data_src.val = PERF_MEM_NA;
 	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
@@ -970,6 +971,19 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		perf_ibs_get_data_src(ibs_data, data, &op_data2, &op_data3);
 		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
 	}
+
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE && op_data3.dc_miss &&
+	    data->data_src.mem_op == PERF_MEM_OP_LOAD) {
+		op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+			data->weight.var1_dw = op_data3.dc_miss_lat;
+			data->weight.var2_w = op_data.tag_to_ret_ctr;
+		} else if (sample_type & PERF_SAMPLE_WEIGHT) {
+			data->weight.full = op_data3.dc_miss_lat;
+		}
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -977,7 +991,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 {
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
-	     sample_type & PERF_SAMPLE_DATA_SRC))
+	     (sample_type & PERF_SAMPLE_DATA_SRC ||
+	      sample_type & PERF_SAMPLE_WEIGHT_TYPE)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
