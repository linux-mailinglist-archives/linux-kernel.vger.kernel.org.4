Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C556623F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjAILPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjAILPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:15:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A0140C2;
        Mon,  9 Jan 2023 03:15:07 -0800 (PST)
Date:   Mon, 09 Jan 2023 11:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673262905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9fTW9B0wERVhpnyognubAv9e+deWUJ2VIWSkVDrCKw=;
        b=ii2PbY8/2r6vAPLmWYKxWLGLfhkB7GgWRDjV6Dht8Z9BqBFvrFQmmIJlx/55VxhRgocNgp
        xVkLpZ5rCAGlj1JuPBgOi3A7qH3FGLMO0SbDxy3qo6YY2Y2+6mBtlBaCtyS31zuItgHKny
        m2HjbT1yJ04CeLFDOtbCwHKMKeK8RFxDfUvNRz6GwyeUZHLXmDgMSxfssMIm/qiZ4hUv6m
        z4KEWib0DjWM8A8NsSu3QhexFSamGdYWWLWilXYWhn6YQ/2So1+3SLwOLlZt1GBF2AHMX2
        sduv8itzwJlNx145MmPrtQVtQRYiEGtOxTLDOIlAwJbaVslkQPWLIAmiwHPYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673262905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9fTW9B0wERVhpnyognubAv9e+deWUJ2VIWSkVDrCKw=;
        b=HJe4Pa6IUJ7cy7II6VGSVfOQKGXm430Q5iNdL1LB44oP8FKG+FtpK+gNndX8lEmfhTdiTQ
        lqdfJaPrNDnva3Bg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Meteor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230104201349.1451191-7-kan.liang@linux.intel.com>
References: <20230104201349.1451191-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167326290537.4906.9869005395608335131.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6887a4d3aede084bf08b70fbc9736c69fce05d7f
Gitweb:        https://git.kernel.org/tip/6887a4d3aede084bf08b70fbc9736c69fce05d7f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 Jan 2023 12:13:47 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:00:52 +01:00

perf/x86/msr: Add Meteor Lake support

Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
are also supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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
