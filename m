Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB845F07B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiI3JcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiI3Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E633D693B;
        Fri, 30 Sep 2022 02:31:17 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVYNcffgw/kna8r/yyAJknSN3Vhnp2+g4dzFeCZmFyI=;
        b=ZrnV9IgTueAEzYzm2Yn5VkGFPApiuBs4FxwmiOsZZuW8wSvMA6p7/WR2LIutvRKbhl+B7l
        JppRlX3EBwLKmE15VonZARdpUejKOggevq5R9224k7odaje0OF42J8KsZ2SxrmyPHKQxxY
        X+VVvWrjBRkqCFdWrtvUeBB9oLuA7NUGhpySRMO6/as+jGrxBffaG645PRl5FxBp0JGvT+
        ZcOyJ6nJDwDj4sB8GniMK17x1knhPMYUn0n3DfA6SGV2uGSjeOzMlxt9pCj+6fkLoSzzYn
        sgTkHwdpF5hf7PUeRHuz6QOz6lS+oy52OI0PNcJKDVzNqLmfy0zIkGEvDdRZNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530275;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVYNcffgw/kna8r/yyAJknSN3Vhnp2+g4dzFeCZmFyI=;
        b=NN/HWq3zhcRt00/OjnrUyi749PVXvq/E67YGfECL7ETI58cwplyMmhfLjbIT33jcvs5Fsq
        FqsLf3V0E5NQXVDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add new Raptor Lake S support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928153331.3757388-2-kan.liang@linux.intel.com>
References: <20220928153331.3757388-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166453027451.401.5003385723379236816.tip-bot2@tip-bot2>
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

Commit-ID:     193c888b7ffe4da97346950c0e98dd77cc629f24
Gitweb:        https://git.kernel.org/tip/193c888b7ffe4da97346950c0e98dd77cc629f24
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 28 Sep 2022 08:33:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:53 +02:00

perf/x86/msr: Add new Raptor Lake S support

The same as the other hybrid {ALDER,RAPTOP}LAKE, the new Raptor Lake S
also support PPERF and SMI_COUNT MSRs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220928153331.3757388-2-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ac542f9..ecced3a 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -106,6 +106,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
