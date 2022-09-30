Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D853C5F07B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiI3Jc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiI3Jb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608BDD62DB;
        Fri, 30 Sep 2022 02:31:16 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZhqntP6MB845SzhQEu1UeplWFbWOTKiVOV4lqa5Qdc=;
        b=BDU2VIz0NktSG6ILfQ7BysUL1ShXZa7OVXS5fAqBjJrFiyEJWz+4PsEvqR1rSoA5mV01Wx
        xHxnJe+1ZImIoaMUjxGqLxrwNfMXt5BLSyameWSZGRaZM74RQExRnQiCHUrnB/BF9aR9sC
        WHZetky6zOAB9JtgN7WBBSpUhpXG1xUyAU8s0QWUHAI5JzDuh1VFmXJDiQLd0emihbW+hC
        m1zNa70pBuClpR0UrcP2/Vpy1yQaCtRPynnPr6IbscTgEIl2pclVrxx8V7NtkGmiyLOdy4
        pbe2L84zF5wFzF9fRdF6VtS+eRZ0rNdZzT+fNsdY0gnepLDd+9AEmO45mVOjFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZhqntP6MB845SzhQEu1UeplWFbWOTKiVOV4lqa5Qdc=;
        b=n5RF1j3WVOO0LlTJ7Z+25vFRkmpAnTbUCnohoR4PfOQ6L7p3Uhgdmb7CXzvMyxQ/iDl7sG
        8cxyLc5ZvlOFIkCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Add new Raptor Lake S support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928153331.3757388-3-kan.liang@linux.intel.com>
References: <20220928153331.3757388-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166453027328.401.8394558986563267964.tip-bot2@tip-bot2>
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

Commit-ID:     d12940d2ead51c6978e7d38b2abf12b833270b2a
Gitweb:        https://git.kernel.org/tip/d12940d2ead51c6978e7d38b2abf12b833270b2a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 28 Sep 2022 08:33:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:53 +02:00

perf/x86/cstate: Add new Raptor Lake S support

>From the perspective of Intel cstate residency counters, the new
Raptor Lake S is the same as the other hybrid {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220928153331.3757388-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 8ec23f4..a2834bc 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -685,6 +685,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
