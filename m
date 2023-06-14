Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4D7174BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjEaEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjEaEFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:05:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81175E44;
        Tue, 30 May 2023 21:05:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6939015BF;
        Tue, 30 May 2023 21:06:05 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.73.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDE783F6C4;
        Tue, 30 May 2023 21:05:14 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V11 04/10] arm64/perf: Add branch stack support in struct pmu_hw_events
Date:   Wed, 31 May 2023 09:34:22 +0530
Message-Id: <20230531040428.501523-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531040428.501523-1-anshuman.khandual@arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds branch records buffer pointer in 'struct pmu_hw_events' which can
be used to capture branch records during PMU interrupt. This percpu pointer
here needs to be allocated first before usage.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf/arm_pmu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0da745eaf426..694b241e456c 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -44,6 +44,13 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
 	},								\
 }
 
+#define MAX_BRANCH_RECORDS 64
+
+struct branch_records {
+	struct perf_branch_stack	branch_stack;
+	struct perf_branch_entry	branch_entries[MAX_BRANCH_RECORDS];
+};
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
@@ -70,6 +77,8 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 
 	int irq;
+
+	struct branch_records	*branches;
 };
 
 enum armpmu_attr_groups {
-- 
2.25.1

