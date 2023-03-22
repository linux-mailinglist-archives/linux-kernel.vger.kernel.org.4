Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429356C45EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCVJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCVJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:14:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A59392AF;
        Wed, 22 Mar 2023 02:14:36 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oM6jvbA/7FQGZsoKw09a6c1Ph4Bvpe/HywQbI/yLxY=;
        b=jg+xzCnWNV3OswgNGskfvRhkK3ENbt+Kpr1pdQYUOSLOTB7m3Znz3SZNlPx5sDmi2Xuxjt
        M8YkoD1p0/sXwxHvQQh+gUvC9bgN8BOyQGX3atId0Kx/aLbFXOGMoMiT9jq/9s4NpAWATe
        a4K4hWTDpEpA9NewgVarkXgacd/DOLCSgYwUYE021LpYrq2192wDQWmBOeT3pQN1R0nA/y
        KZlySyq/tGy2/Xsax5H9KfM1TcPlpITftRnYcSQLgrUtvLfWFt3shEao9t+BxvAy69f+k4
        kPOsZw6icakDeTuKrZSrSo0P13vTKTlVgi/lhaxKyp9Oya1iw9HH8tUgY3LcSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oM6jvbA/7FQGZsoKw09a6c1Ph4Bvpe/HywQbI/yLxY=;
        b=fMVLlvxAZJ+9ShPpXEeUlcU8cNCJsxB4OVUxKkpgWIanZLD/SmHlVWyXSDZZ1h8IccM8En
        mUB8XF/YtPOvDgDg==
From:   "tip-bot2 for Artem Bityutskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Add Granite Rapids support
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230314170041.2967712-3-kan.liang@linux.intel.com>
References: <20230314170041.2967712-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167947647470.5837.7657640616469915792.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     872d28001be56b205bd9b3f97cea1571a1bde317
Gitweb:        https://git.kernel.org/tip/872d28001be56b205bd9b3f97cea1571a1bde317
Author:        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
AuthorDate:    Tue, 14 Mar 2023 10:00:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Mar 2023 14:43:08 +01:00

perf/x86/cstate: Add Granite Rapids support

Granite Rapids Xeon is successor or Emerald Rapids Xeon, and it will use
the same C-state residency counters as Emerald Rapids (and previous
Xeons, all the way back to Ice Lake Xeon).

Add Granite Rapids Xeon support.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230314170041.2967712-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 551741e..835862c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -678,6 +678,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	&icx_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
