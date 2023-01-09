Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFA662C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAIRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjAIRCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6003FA20;
        Mon,  9 Jan 2023 09:02:09 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcsZptQTs5VwiDsbZ745ZsTCdkX4w52AsCFh5mNONZM=;
        b=0+XTt980qFzWlCPoNEacvu/hCN2QhSareULuA4rxTKxS/kKWIV+m0UzmFKPlR7K/K5TRTo
        iBNTTz7qKk3kF5C4ia66xltiapVl15cFQ/H/M7yInV/4IwDIvD04Zf0FpOeAilMof1uJwq
        ENcHr/jJ8sRl8JyLv9j/39P5pOyCGdn5LxAUn3o81vJleHR8KrD/b9s73Qy6rIJR/pMmB6
        Yt3LIP1mORJvvmNiDQFugyl34eRT0Og9bD7xAbJv3H+4VMUBuEPzzK2CV+l6qCSgEELpoF
        32rsg81BGSTSIA5NQJc9NXa3X4+A4CEz7ZgxEdSBXBjtlhDjon3zllYpxieskg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcsZptQTs5VwiDsbZ745ZsTCdkX4w52AsCFh5mNONZM=;
        b=/74jUWanmel4sAFNue7jqNpvXKQ7+NhUykBvBKHF8VPVJSTm+GLAfFisO+pJo4mGVfzDV1
        WVK+/VQ4ef5EMHDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Meteor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-7-kan.liang@linux.intel.com>
References: <20230104201349.1451191-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167328372805.4906.10978207496989851098.tip-bot2@tip-bot2>
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

Commit-ID:     b0bd3336d87f3403094fbadc7803c1d5bf3df4f7
Gitweb:        https://git.kernel.org/tip/b0bd3336d87f3403094fbadc7803c1d5bf3df4f7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:47 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:09 +01:00

perf/x86/msr: Add Meteor Lake support

Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
are also supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230104201349.1451191-7-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ecced3a..074150d 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
