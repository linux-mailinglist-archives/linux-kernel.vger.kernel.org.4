Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9D5F07A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiI3Jbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiI3JbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C30CE6C5;
        Fri, 30 Sep 2022 02:31:09 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jIGh7YSgfdc33ecaC81i9SGZJgkQUh80yOWSyaSx2c=;
        b=UkmZb++GjiemXm5anjGS/VDASJ85St7bsNf4afxZQ2dftIY2YY2+qGRb4XkXhffcGf4DLw
        E+w1BFRTLLHqi6nCXWaNmy5x1q9dJkqksR6Iwq29gU5E4jnAE+ujGlG3hOgomG4ddRn+j1
        O+0sUcd20gtkojUsLdrPJVqT1Jzoavwuk0vGNX/UTgk92OVMLI+4dD5T5JvKmjp4aH9YNp
        fHvlwBzGAUz2HV95T2kXoYDuBvCd27Qptz1FyeiWmz/fGFsacytt3/9Ty+6axcEOkBEtnk
        9MaJWhwGJg0mDrd4qRoUCLtTDWWCg/RZPaCcflQ5NWe4pmOJdCuVbzveYtIhxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jIGh7YSgfdc33ecaC81i9SGZJgkQUh80yOWSyaSx2c=;
        b=Em9ntirRuZHpaGPvrcrlhwYD3McmD4Iqq/oml/i2u/rn4KNEwuSJ0+eJI6ey9g2jGn7sm0
        LzGK6g25LFdUoFDQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Support PERF_SAMPLE_ADDR
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-6-ravi.bangoria@amd.com>
References: <20220928095805.596-6-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026546.401.14456632335130963390.tip-bot2@tip-bot2>
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

Commit-ID:     cb2bb85f7ed8740ab5fc06bbec386faa39ba44ef
Gitweb:        https://git.kernel.org/tip/cb2bb85f7ed8740ab5fc06bbec386faa39ba44ef
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:55 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:55 +02:00

perf/x86/amd: Support PERF_SAMPLE_ADDR

IBS_DC_LINADDR provides the linear data address for the tagged load/
store operation. Populate perf sample address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-6-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d883694..0ad4910 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -984,6 +984,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		}
 		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
+
+	if (sample_type & PERF_SAMPLE_ADDR && op_data3.dc_lin_addr_valid) {
+		data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -992,7 +997,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
 	     (sample_type & PERF_SAMPLE_DATA_SRC ||
-	      sample_type & PERF_SAMPLE_WEIGHT_TYPE)))
+	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
+	      sample_type & PERF_SAMPLE_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
