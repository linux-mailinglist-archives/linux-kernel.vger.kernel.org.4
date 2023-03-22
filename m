Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022F46C45F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCVJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjCVJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:14:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656539CF0;
        Wed, 22 Mar 2023 02:14:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:14:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txn/sef3d+aaQF756K6wwuxg+ReBrrWMtqngcq4ZKUE=;
        b=SDQq5OIT47TVlv0jwhO16SAmHb7B6GONzm/sp+jALgyx5yqBoq0sU2kCXK+QL0/3u0tU9L
        ZNnnGwlEyDCOJKKgzAvrhd9DwLtOeUqmUBfGJDvlBDH8tNtWVrCQ/5aXrW5MtGLXhif2so
        3uc5KM+BJNro9oZjXAX6ZEtceNRPntJ1L2uaO3pxdgom5YSPOAXB/pNPpKWYdL8msHRLhW
        XMVW8hsY51Czggg9alV3bBYQbqVgvFpmqM1fAV1P/P/rM1Y4h6brNeJ6JAjbkfaVz8TSWU
        2o5CD8AXysZ9f30x36xgKOjtlEIhmSRcnTOQ5OAlL0Scl7fol/ucof08C3W3NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txn/sef3d+aaQF756K6wwuxg+ReBrrWMtqngcq4ZKUE=;
        b=3b6J+8YhaUpgabyXgzhC2KogYb46vp40CEemQ2sIw4oRuLrK4vCxxGShpO2+Twg6GULAcI
        QGan9zfo+Ub+/ECg==
From:   "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Always clear status for idx
Cc:     Breno Leitao <leitao@debian.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230321113338.1669660-1-leitao@debian.org>
References: <20230321113338.1669660-1-leitao@debian.org>
MIME-Version: 1.0
Message-ID: <167947647626.5837.12912753854693037433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     263f5ecaf7080513efc248ec739b6d9e00f4129f
Gitweb:        https://git.kernel.org/tip/263f5ecaf7080513efc248ec739b6d9e00f4129f
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Mar 2023 04:33:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Mar 2023 14:43:05 +01:00

perf/x86/amd/core: Always clear status for idx

The variable 'status' (which contains the unhandled overflow bits) is
not being properly masked in some cases, displaying the following
warning:

  WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270

This seems to be happening because the loop is being continued before
the status bit being unset, in case x86_perf_event_set_period()
returns 0. This is also causing an inconsistency because the "handled"
counter is incremented, but the status bit is not cleaned.

Move the bit cleaning together above, together when the "handled"
counter is incremented.

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20230321113338.1669660-1-leitao@debian.org
---
 arch/x86/events/amd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b19..bccea57 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -923,6 +923,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		/* Event overflow */
 		handled++;
+		status &= ~mask;
 		perf_sample_data_init(&data, 0, hwc->last_period);
 
 		if (!x86_perf_event_set_period(event))
@@ -933,8 +934,6 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
-
-		status &= ~mask;
 	}
 
 	/*
