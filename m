Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87060733079
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjFPLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjFPLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:53:23 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74B30CF;
        Fri, 16 Jun 2023 04:53:20 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-311153ec442so507936f8f.1;
        Fri, 16 Jun 2023 04:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916399; x=1689508399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7xAAjbq425WmYDF4eeJ0EL9NFPdHLP90wUaRqnBZNg=;
        b=VVKAefyzUkhucd2zTeHlApagVyGIzoaYmHllvLtwtLKqhsQdGadoO6/n/a3KL0XMJ3
         O40hvTcKLHyGCuiljhOd/P+7q5A6n9XyzREKNwl4V0A8ph2ryGdFFmMtjhdjdBcW8TRg
         w+OhCNxrlruv8K8GoqhG/zxhpkJzLGl+d+akHhUBDMGkwN6nVpldTeHQZcohEr488oGD
         SBiA78KIMqTMe9bfFxzfzsyZUy78NnBryk7XrQ+oOgAzEtQWH7MXjB34r1MDyx1QMw+w
         uAUQH4bzKYmyevKeYLxSa3ZT3qe8WOMi1260ruPbyAOX5Qy/AuHCTyOqHSICEDXeiFbi
         Fysg==
X-Gm-Message-State: AC+VfDy1gHNULGgDFRX+OLDobNKPap93wwe/W3aUqkgm2Y85wJ8chFnp
        YyQ3lmaWitGDohIFecK9KlI=
X-Google-Smtp-Source: ACHHUZ4C/WnNCIQ/pEnyVUy8SsHLNOVG9gCLKC/TtXe77N0MNds+3hMpNKMB/fTZ31cAn5v5Awd4Fw==
X-Received: by 2002:adf:e4c1:0:b0:30f:c71a:1b28 with SMTP id v1-20020adfe4c1000000b0030fc71a1b28mr6558770wrm.28.1686916398618;
        Fri, 16 Jun 2023 04:53:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-111.fbsv.net. [2a03:2880:31ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id u24-20020a05600c00d800b003f7ead9be7fsm1954267wmm.38.2023.06.16.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:53:17 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>
Cc:     leit@fb.com, dcostantino@meta.com,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Date:   Fri, 16 Jun 2023 04:53:15 -0700
Message-Id: <20230616115316.3652155-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems, the Performance Counter Global Status Register is
coming with reserved bits set, which causes the system to be unusable
if a simple `perf top` runs. The system hits the WARN() thousands times
while perf runs.

WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0

This happens because the "Performance Counter Global Status Register"
(PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
Manual, Volume 2: System Programming, 24593"[1]

WARN_ONCE if any reserved bit is set, and sanitize the value to what the
code is handling, so the overflow events continue to be handled for the
number of events that are known to be sane.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")

[1] Link: https://www.amd.com/system/files/TechDocs/24593.pdf
---
 arch/x86/events/amd/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bccea57dee81..809ddb15c122 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -909,6 +909,10 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
+	amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+	WARN_ON_ONCE(status & ~amd_pmu_global_cntr_mask);
+	status &= amd_pmu_global_cntr_mask;
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-- 
2.34.1

