Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195F6C45F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCVJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCVJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:14:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD21CBCE;
        Wed, 22 Mar 2023 02:14:37 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:14:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679476476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADBEJQ1UIhbbzAuhB/SNURwn3m8ctpsiRxMmt7Y4k/U=;
        b=BKRhHvxo6MlD4mXLmyP+6Z8N23t994tIp4FrXUaWlNRXv6q83wFv5+A5xXRpPOdlnfiZPz
        g/aQD8OocW6a8HrM7+83vTPrytPtaZPzdKPo0pV/45VOBJaYAWDjQmKlXLuRN1p6+PgLzc
        uFQAeVJoZs3JaQFbsRh1G7nQPTYxxRSJmTOfhtLWSr/adv3AXLDUtUTt7rq4JySsxhZRXI
        zUyunWVlpBUEmxCwEqzfdbWYCICgykd41qP65qwc4eOW1+HL4JcFL9iMuyvhllx4+MAy16
        DQ6vvc6MVbTVHs+6UX/Z3/UIbDoaIEEjTQ5U/mG4IUp60hhHfo+TF/Ha5+MZEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679476476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADBEJQ1UIhbbzAuhB/SNURwn3m8ctpsiRxMmt7Y4k/U=;
        b=JJBV/L5Hblj4IlTDbXeWbWbuOdAgCsbz5x42zX47cdRXBFllthGAjY+35PZ35b2yWRAz3B
        FrjBnE8ECrYL7TBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Granite Rapids
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230314170041.2967712-1-kan.liang@linux.intel.com>
References: <20230314170041.2967712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167947647560.5837.12482609518310888733.tip-bot2@tip-bot2>
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

Commit-ID:     bc4000fdb009a531fc5b94339f8531eee64bc232
Gitweb:        https://git.kernel.org/tip/bc4000fdb009a531fc5b94339f8531eee64bc232
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 14 Mar 2023 10:00:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Mar 2023 14:43:08 +01:00

perf/x86/intel: Add Granite Rapids

>From core PMU's perspective, Granite Rapids is similar to the Sapphire
Rapids. The key differences include:

 - Doesn't need the AUX event workaround for the mem load event.
   (Implement in this patch).

 - Support Retire Latency (Has been implemented in the commit
   c87a31093c70 ("perf/x86: Support Retire Latency"))

 - The event list, which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230314170041.2967712-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a3fb996..070cc4e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5470,6 +5470,15 @@ pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 }
 
 static umode_t
+mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &event_attr_mem_ld_aux.attr.attr)
+		return x86_pmu.flags & PMU_FL_MEM_LOADS_AUX ? attr->mode : 0;
+
+	return pebs_is_visible(kobj, attr, i);
+}
+
+static umode_t
 lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return x86_pmu.lbr_nr ? attr->mode : 0;
@@ -5496,7 +5505,7 @@ static struct attribute_group group_events_td  = {
 
 static struct attribute_group group_events_mem = {
 	.name       = "events",
-	.is_visible = pebs_is_visible,
+	.is_visible = mem_is_visible,
 };
 
 static struct attribute_group group_events_tsx = {
@@ -6486,6 +6495,10 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		fallthrough;
+	case INTEL_FAM6_GRANITERAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_D:
 		pmem = true;
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -6502,7 +6515,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = spr_get_event_constraints;
