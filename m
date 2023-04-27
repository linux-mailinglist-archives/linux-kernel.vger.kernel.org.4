Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B76EFF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbjD0DFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0DFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:05:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3635B3;
        Wed, 26 Apr 2023 20:05:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so7931826a12.1;
        Wed, 26 Apr 2023 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682564730; x=1685156730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ove/sTJ8+x/q60am/+KMhPIYHnt+EFjkrJyhwIn48Nk=;
        b=raTJxDo6NHuN1i4W6/Vl6x/jV++XY9DomGczVyWxak/EnC5sunEIIoypQnfdLjlp+d
         5aSIfjwfILrNgKOrVO6x+ouEJdYq/+sH5GFzTf/25xH2Lelrq2ddHWX+tx6Rcvz4oGmR
         +YU5ahqcI51YXd0SugsrUxSkAyAomhKk748mTe+LgiCxkO0Wvcq/nc5ObiSQDR3eOD6m
         g3tFs2Sufh+im2umEEC8LqY4IdCRz0H8ZG9QxThAaWZI187ZE08VaxXozT0waT7iRumz
         ugc61A69a53XjCCVoyQyVXhaxHT82PMp5Lkw/WP72Oc6X/unmUsmI6PcqUxscrEtUUfr
         FAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682564730; x=1685156730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ove/sTJ8+x/q60am/+KMhPIYHnt+EFjkrJyhwIn48Nk=;
        b=TOZzqypjL8ykUstXct4D3iQuHxPWIQoZlrcAqWQW7k/gZm5mdtdh3kpMkbyI5nMYWy
         DVI1Vtuw1l7AVRfH4Q3U6YZd2jGa7p3pyY4aljp/vcUvoRS+AvojIAHw7+XWvnu4Je8T
         cFBd3JYYLTjQNWuHqFrY+AfswXVO9UlkiZfNlj2l/EuewoZShjsCO7MJdURS1pexX0ED
         J2bqhLbJNYhjxRGgAjzOGw0Lhx2DfVqcvirql0MeU+QZzbbUNQFzDHRIezT1NZqeSDc7
         /imFMofp/2ZSJ1+SD3HCZWWN5ULWUzorImWG6plTdg/AOTVEsZ56KTkn/O1/OYTnGFk5
         qWcw==
X-Gm-Message-State: AC+VfDy+u28AUmCORSShuBIiiRoyakQjNZEIQuEIBs3NX0XhZoZ1G/V9
        ccYRel9byAGIR5N/ZsWaSb4=
X-Google-Smtp-Source: ACHHUZ65kwaPer2wxQ9EcrHZ03Fe/dmOpR6twng8E0U+ezwpDAjF7cvN1RVn8B+v26FZAyJlptuKaQ==
X-Received: by 2002:a17:90b:3585:b0:247:1e13:90ef with SMTP id mm5-20020a17090b358500b002471e1390efmr348505pjb.20.1682564729636;
        Wed, 26 Apr 2023 20:05:29 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:6ebf:37fc:fc60:b353])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001a6d08eb054sm10575168pln.78.2023.04.26.20.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 20:05:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>, stable@vger.kernel.org
Subject: [PATCH] perf/x86: Fix missing sample size update on AMD BRS
Date:   Wed, 26 Apr 2023 20:05:27 -0700
Message-ID: <20230427030527.580841-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It missed to convert a PERF_SAMPLE_BRANCH_STACK user to call the new
perf_sample_save_brstack() helper in order to update the dyn_size.
This affects AMD Zen3 machines with the branch-brs event.

Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..9d248703cbdd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1703,10 +1703,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		if (has_branch_stack(event))
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
-- 
2.40.1.495.gc816e09b53d-goog

