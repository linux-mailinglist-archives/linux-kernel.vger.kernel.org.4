Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33B5F07AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiI3JcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiI3Jb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8037E31A6;
        Fri, 30 Sep 2022 02:31:18 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSpm2s7WGKvYXZJaDPn3a6Ssd+PKxi/GcC1kEQmTiDQ=;
        b=Kh94D65Iur/tyZUnbDsFGyjZsAFzArdbMQ/Xs4IzNHmqiXlAZP4ivAThZ1Q9+nq3M9ipQ+
        wKdlJSMWN1c+nupUzENwUqJsZLJFExmE5CIW59meqfsNPeJ9hR4N+8tW2o1K/pmHRWStqF
        GLpZGD6xa18PFtO76qnJaSnxWmwuaZpGlkiIORFyhJFCWN9TmPlf9nd353LvXLqCsxZByf
        qpJ1XGTPL7CQlQqDkOwxenYlyy5XM+V5RCcl+I1/AuCKbcSqR7YepTX3qQFoBdIUkEeelM
        Dt18FP4AEZSI28eAbueNiDMpCeMr3G+OOiXirVCOgr3PdereTyxboacCdjCIYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSpm2s7WGKvYXZJaDPn3a6Ssd+PKxi/GcC1kEQmTiDQ=;
        b=Ny8fEtv3h/8QBcZqgFJG5fd8BMWHdsrx3A8DaS5Z+I0IQZfPpxKjKOqKy0dffZcH00Pr4K
        C4reyGxx6OxRN7Dg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add new Raptor Lake S support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928153331.3757388-1-kan.liang@linux.intel.com>
References: <20220928153331.3757388-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166453027576.401.2381843474694222633.tip-bot2@tip-bot2>
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

Commit-ID:     50b0c97bf00e4815aee09cace28b940ebb060e69
Gitweb:        https://git.kernel.org/tip/50b0c97bf00e4815aee09cace28b940ebb060e69
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 28 Sep 2022 08:33:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:52 +02:00

perf/x86: Add new Raptor Lake S support

>From PMU's perspective, the new Raptor Lake S is the same as the other
of hybrid {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220928153331.3757388-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b2d8def..3939deb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6344,6 +6344,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
