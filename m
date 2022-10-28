Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F8610A79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJ1Gmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ1GmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F754C8C;
        Thu, 27 Oct 2022 23:41:58 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAvqYP0TCdz/Bz6UkmQLxlYDhfOaAfeZWA3cDb66y0U=;
        b=dM2u31vZFm2ca1CcmkOoPPFJ66Ez4oDarwAieT+FkLR25axxkpurtnHuOopgG1bgaoKUoj
        71ewee/nLAlCDZ/z8Tdw9mOCVmhntjUvtykh7l2WnfaeiBg26ACK7AN4pz9bvxBXrlN98E
        itk30DkR6YHt9u/FTxbI0NtjIYrtOCe1vuI/o/+PFjbMXn8VxR5Bv45MaWDKGKXwtuMTD1
        lMgY5Okjz2jAtRQkBrE92FVPRU0jbIadCJ31fSmnRC26voviutWb4oeM2HUFP2siTkwpnC
        o3as4OwiZ2GshMUJja8PJ+yFXSaEVk/wLZ5+PFb/Hpc2MJR2AqAr9aaO+W/DcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAvqYP0TCdz/Bz6UkmQLxlYDhfOaAfeZWA3cDb66y0U=;
        b=ovWRS4KyHSQ9J81LiYibBV6fbOKelRKVbvRDW3AIzQNwy+NmMlDouF2OWc8va/q6wgaaaB
        odqcSicAVzuj06AQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel Raptor Lake
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wang Wendy <wendy.wang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221023125120.2727-2-rui.zhang@intel.com>
References: <20221023125120.2727-2-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <166693931539.29415.9211825739101668046.tip-bot2@tip-bot2>
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

Commit-ID:     eff98a7421b3ee73d62268115ffa5bfc0ba94544
Gitweb:        https://git.kernel.org/tip/eff98a7421b3ee73d62268115ffa5bfc0ba94544
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Sun, 23 Oct 2022 20:51:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 10:27:31 +02:00

perf/x86/rapl: Add support for Intel Raptor Lake

Raptor Lake RAPL support is the same as previous Sky Lake.
Add Raptor Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Link: https://lkml.kernel.org/r/20221023125120.2727-2-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 165c506..fea544e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -808,6 +808,9 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
