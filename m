Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF045F07A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiI3Jbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiI3JbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42575C9032;
        Fri, 30 Sep 2022 02:31:07 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wgRvyNSSaB/GpqbjwsHk42+TYDJv7JF4ZxzHVMXsc8=;
        b=otkkVqYDKOe3zANqa6WM3DjkpDgXLUqUwd3StecjOl++MXnRB66zrZF2B7ECb+C5XmIMjt
        ErOkWS8NpGQa9ECQMI9UyJYWtmC6zdwJ7MbmNlyQo5tmBHO5C9+Hl5K9XXEZkCnf6mOxPF
        LDsezIQ8VTyoWXWiOSrdhoA2VsXa5CwHVqWGV7GV0nL+Qw54uNnJG0PdHyXLhwLsZV1v9d
        iFLfyLU5MbWMCGOa2BeNXOiwqi0Q31tUpm66kFIMTJqEE4t8hICuvnrSjmzqMy7UZC6G+Z
        6q72VPvtKWLfssgNSfN1qgyluidM+CxERY3A+Y7FoQ9ToJjwlK8RPcML3ewRXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wgRvyNSSaB/GpqbjwsHk42+TYDJv7JF4ZxzHVMXsc8=;
        b=P439BV8RVTZSYpGtyYSmPbozZmioKhU/LpNAAGUhZgekhQ2E7Qo+wQ4VcgIZtScqxfYVRD
        NtsHS6QMerno/7AQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-7-ravi.bangoria@amd.com>
References: <20220928095805.596-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026433.401.11506650862081530260.tip-bot2@tip-bot2>
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

Commit-ID:     5b26af6d2b7854639ddf893366bbca7e74fa7c54
Gitweb:        https://git.kernel.org/tip/5b26af6d2b7854639ddf893366bbca7e74fa7c54
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:56 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:56 +02:00

perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR

IBS_DC_PHYSADDR provides the physical data address for the tagged load/
store operation. Populate perf sample physical address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-7-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 8 +++++++-
 kernel/events/core.c      | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0ad4910..3271735 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -989,6 +989,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
 		data->sample_flags |= PERF_SAMPLE_ADDR;
 	}
+
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR && op_data3.dc_phy_addr_valid) {
+		data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
+		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -998,7 +1003,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	    (perf_ibs == &perf_ibs_op &&
 	     (sample_type & PERF_SAMPLE_DATA_SRC ||
 	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
-	      sample_type & PERF_SAMPLE_ADDR)))
+	      sample_type & PERF_SAMPLE_ADDR ||
+	      sample_type & PERF_SAMPLE_PHYS_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1ffdb8..49bc3b5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7435,7 +7435,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
+	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
 #ifdef CONFIG_CGROUP_PERF
