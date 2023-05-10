Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121136FDE76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjEJN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjEJNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:25:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C65BAC;
        Wed, 10 May 2023 06:25:55 -0700 (PDT)
Date:   Wed, 10 May 2023 13:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1ya3nX+Ys2msmlSi+coH03InJp1/N7yftwS6LeddTI=;
        b=py/sAHplJfeVTfLjX9TXYO19hcL9n6EyafFGXUvmRBETral5GHvtiu/E2gTmkbxe1xFKL8
        9A5r2pqKEp0+QdpBDWpEIKPLfJqQNlaq1kqqJGbSZlw9iPft0C/Pk6rXR2Asd5lFQeJ1CT
        OmBiOFsX+yekua0YcwJUYkMdpdy39gOBeqDYIojbo0B+l2Y1T7YCdUJo9SvSeIiCj29Neh
        rZwe5mMcaY+fo465H6DdqKsBdhD9dzfZ7+tVXZQhBWLoPa7HbKdbGHPLoZ4gkHkgW9lDPf
        ctGRxbZnLALJYsBZXx8obCvbUjfox0+2VgFBaRhyFQtte5OpttXSwLmMk4aZug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725153;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1ya3nX+Ys2msmlSi+coH03InJp1/N7yftwS6LeddTI=;
        b=3DANIp1beaGSrudp+8Ir0VTCfRhm7AOcspqne0on4AMPwRCAbwRjEXWyXSGkOdTKmjnHWY
        MCac9ArqjuBI5YDg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix missing sample size update on AMD BRS
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230427030527.580841-1-namhyung@kernel.org>
References: <20230427030527.580841-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <168372515291.404.10094366236022202082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     90befef5a9e820ccccc33181ec14c015980300cc
Gitweb:        https://git.kernel.org/tip/90befef5a9e820ccccc33181ec14c015980300cc
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 26 Apr 2023 20:05:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:26 +02:00

perf/x86: Fix missing sample size update on AMD BRS

It missed to convert a PERF_SAMPLE_BRANCH_STACK user to call the new
perf_sample_save_brstack() helper in order to update the dyn_size.
This affects AMD Zen3 machines with the branch-brs event.

Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230427030527.580841-1-namhyung@kernel.org
---
 arch/x86/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04..9d24870 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1703,10 +1703,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		if (has_branch_stack(event))
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
