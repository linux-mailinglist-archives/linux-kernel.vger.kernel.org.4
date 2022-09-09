Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC35B326C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIIIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiIIIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C9120A5;
        Fri,  9 Sep 2022 01:52:46 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UjciCxnwDFe5HfT2KxABHvlfHJGvifckudNFh3Asr0=;
        b=qSqy+iRt7ndyLyoNWDKEMmAX9Y1LAgwpq2doMiyi5nnn+F3sQCwZhiPAVE1EhCxzVDkI5S
        GFFHBT6o+yQ56pL6rDetk4x3D/zQOrT1R6XiuG1oCxQzF3QryBP4pivt5FS9XYdKlRK3E3
        ru/WRvRRlKn8Ke1hO1M4HjHdgyf004tlRQk3amQIOw9AKZEna+84qVvRCHHXtiQ+jgtOCu
        LDmxXs9G/BKaD0XqKp0QU1Pk9v/KoHRqEQroMllwleCzOQgo4YwRz/VPDABUhqscAm0FAG
        7n/YyLyeDl/9nCRJMAuOt8iaX3L7yzh10j0TX6eGSU8PfkpAQ6RGoIjZb7llUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UjciCxnwDFe5HfT2KxABHvlfHJGvifckudNFh3Asr0=;
        b=vMfGvmOUvsEqjsy7OfBr0pBCdU2klESAvDBeAlZ92mkMvs+a1sDu6i3KZ49VQT4VTwTijf
        VWbLV32+7YOF0EDg==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/perf: Assert all platform event flags are within
 PERF_EVENT_FLAG_ARCH
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907091924.439193-5-anshuman.khandual@arm.com>
References: <20220907091924.439193-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166271356383.401.6859119036807311988.tip-bot2@tip-bot2>
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

Commit-ID:     88081cfb699ce2568e5309c145eb9f9e9497b53f
Gitweb:        https://git.kernel.org/tip/88081cfb699ce2568e5309c145eb9f9e9497b53f
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 07 Sep 2022 14:49:24 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:01 +02:00

x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH

Ensure all platform specific event flags are within PERF_EVENT_FLAG_ARCH.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220907091924.439193-5-anshuman.khandual@arm.com
---
 arch/x86/events/perf_event.h       | 34 +++++++++++++----------------
 arch/x86/events/perf_event_flags.h | 22 +++++++++++++++++++-
 2 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/events/perf_event_flags.h

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 93263b9..4a3dde2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -64,27 +64,25 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
 }
 
+#define PERF_ARCH(name, val)	\
+	PERF_X86_EVENT_##name = val,
+
 /*
  * struct hw_perf_event.flags flags
  */
-#define PERF_X86_EVENT_PEBS_LDLAT	0x00001 /* ld+ldlat data address sampling */
-#define PERF_X86_EVENT_PEBS_ST		0x00002 /* st data address sampling */
-#define PERF_X86_EVENT_PEBS_ST_HSW	0x00004 /* haswell style datala, store */
-#define PERF_X86_EVENT_PEBS_LD_HSW	0x00008 /* haswell style datala, load */
-#define PERF_X86_EVENT_PEBS_NA_HSW	0x00010 /* haswell style datala, unknown */
-#define PERF_X86_EVENT_EXCL		0x00020 /* HT exclusivity on counter */
-#define PERF_X86_EVENT_DYNAMIC		0x00040 /* dynamic alloc'd constraint */
-
-#define PERF_X86_EVENT_EXCL_ACCT	0x00100 /* accounted EXCL event */
-#define PERF_X86_EVENT_AUTO_RELOAD	0x00200 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_LARGE_PEBS	0x00400 /* use large PEBS */
-#define PERF_X86_EVENT_PEBS_VIA_PT	0x00800 /* use PT buffer for PEBS */
-#define PERF_X86_EVENT_PAIR		0x01000 /* Large Increment per Cycle */
-#define PERF_X86_EVENT_LBR_SELECT	0x02000 /* Save/Restore MSR_LBR_SELECT */
-#define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
-#define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
-#define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
-#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
+enum {
+#include "perf_event_flags.h"
+};
+
+#undef PERF_ARCH
+
+#define PERF_ARCH(name, val)						\
+	static_assert((PERF_X86_EVENT_##name & PERF_EVENT_FLAG_ARCH) ==	\
+		      PERF_X86_EVENT_##name);
+
+#include "perf_event_flags.h"
+
+#undef PERF_ARCH
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
new file mode 100644
index 0000000..1dc19b9
--- /dev/null
+++ b/arch/x86/events/perf_event_flags.h
@@ -0,0 +1,22 @@
+
+/*
+ * struct hw_perf_event.flags flags
+ */
+PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
+PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
+PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
+PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
+PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
+PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
+PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
+			/*	0x00080	*/
+PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
+PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
+PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
+PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
+PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
+PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
+PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
+PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
+PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
+PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
