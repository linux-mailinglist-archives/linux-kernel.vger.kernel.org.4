Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8046E5F07B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiI3JcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiI3Jb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC83CE6D3;
        Fri, 30 Sep 2022 02:31:15 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFxjqQ5l56dOh9WiuWq4IeWLi3cG2AocBAkamRClXNU=;
        b=N+Z+gKVCJAjuNtej/dSldIUy1TdJTTVbXBNrQu3JaayckTyy2Ex1kH7JwB4ZFPUxuVRHqy
        54cnjzB5lg/Z7XFB2DhXgkaXqu33BVqi/8wQ6J6khRnk4uWX7GcJgSv/i7r6f1rtLQT1xR
        ZkU6e4t2V084CWXBs3p+8Qhc6eG75+lob+eUVScGhTboD5LK9JH1oA3H0kWk5b2GMC3xvj
        TsXNB6lhUOJNw319JslGRFOW76vyBKxAQ2aKA+JZk31aaM4aOt0tXxMcIyBf0H1QRfr4Iv
        ULmiLZizjIx3cKZrwD6ihL7+ccEGws4P/G9wWvSrhwIZpMBTcrcQS2GJPf4Wdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFxjqQ5l56dOh9WiuWq4IeWLi3cG2AocBAkamRClXNU=;
        b=ZdKicu59MTHbLO9IILMgvtaMYsOkhqy27UWS79wkv4xYFo5AEqB9a0eLiMUiBsMu2ixC/h
        At41BbeLr4mHLBBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Add new Raptor Lake S support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928153331.3757388-4-kan.liang@linux.intel.com>
References: <20220928153331.3757388-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166453027203.401.8898105676491155342.tip-bot2@tip-bot2>
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

Commit-ID:     e04a1607c9c3c0e2dc48715aeb570f2581f514bc
Gitweb:        https://git.kernel.org/tip/e04a1607c9c3c0e2dc48715aeb570f2581f514bc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 28 Sep 2022 08:33:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:53 +02:00

perf/x86/uncore: Add new Raptor Lake S support

>From the perspective of the uncore PMU, the new Raptor Lake S is the
same as the other hybrid {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220928153331.3757388-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index db6c31b..6f1ccc5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1831,6 +1831,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
