Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815965B3268
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiIIIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9912D1A3;
        Fri,  9 Sep 2022 01:52:47 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOZq4BqeraHwOmXiy4lDTJCRNB6Ut0FDu75s/fPevQk=;
        b=NFxWpzNgFzCLROf1cx1Uvv1HP+oua8TM8YIgmVoT4YcOIKelwfTgePzimzKdMxFNu0XwPB
        lu1mMn819BBhJGq1AsKdaddVdYSR0vJ9z90glJkzKU+SwzlnDQPgMhuGqiVEIYL/w2235w
        EsBzobKOf40FXOaIlGwd1IIQTUeivWYpqEoZyDN3JIFNrDhgl864RLHRxa6sJfzv4XtqT5
        9C1V57pLD0oXXURFFPiGo/lhlriW3TjPJW01qMbyXIXhBzK+87wnHtcAAUfNcY//dqyq2N
        LFn8q7iMPin8OnhqmECWsiYtQf1LiqDmWbLhOzh15FrF/BR9D0BLaS7I9LycZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOZq4BqeraHwOmXiy4lDTJCRNB6Ut0FDu75s/fPevQk=;
        b=JctSBAu4EUgF+j8GV+9tHkToTIP//HgO7Xh31Z3ReJ11KM+bF2eqV+MIEonRUcsnnieLTP
        WhoiS4JHIgGcj/Dg==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm64/perf: Assert all platform event flags are
 within PERF_EVENT_FLAG_ARCH
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907091924.439193-4-anshuman.khandual@arm.com>
References: <20220907091924.439193-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166271356485.401.5518967906571539201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     91207f62616f9f51b52436364e6d064f002e9112
Gitweb:        https://git.kernel.org/tip/91207f62616f9f51b52436364e6d064f002e9112
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 07 Sep 2022 14:49:23 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:01 +02:00

arm64/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220907091924.439193-4-anshuman.khandual@arm.com
---
 drivers/perf/arm_spe_pmu.c   |  4 +++-
 include/linux/perf/arm_pmu.h |  9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b65a7d9..db8a0a8 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -44,7 +44,9 @@
  * This allows us to perform the check, i.e, perfmon_capable(),
  * in the context of the event owner, once, during the event_init().
  */
-#define SPE_PMU_HW_FLAGS_CX			BIT(0)
+#define SPE_PMU_HW_FLAGS_CX			0x00001
+
+static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_CX);
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0407a38..0356cb6 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -24,10 +24,11 @@
 /*
  * ARM PMU hw_event flags
  */
-/* Event uses a 64bit counter */
-#define ARMPMU_EVT_64BIT		1
-/* Event uses a 47bit counter */
-#define ARMPMU_EVT_47BIT		2
+#define ARMPMU_EVT_64BIT		0x00001 /* Event uses a 64bit counter */
+#define ARMPMU_EVT_47BIT		0x00002 /* Event uses a 47bit counter */
+
+static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_64BIT) == ARMPMU_EVT_64BIT);
+static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_47BIT) == ARMPMU_EVT_47BIT);
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
