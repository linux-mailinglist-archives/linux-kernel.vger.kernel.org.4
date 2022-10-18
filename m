Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06566020C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJRCCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJRCCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A062844CE;
        Mon, 17 Oct 2022 19:02:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e129so12044819pgc.9;
        Mon, 17 Oct 2022 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcP4GbdpRTg6spV/HxyzwMSNL9MGijUUA6+sUlnFP30=;
        b=CY2n7t9KmgGwYwl5tgxWrVZcJdY2PTnNC0T7rRdSFzweDWqb/OfgiAQT+k4dJxc2Ly
         sXZnR5NuEDL5dKzc9j0lnphgZRYyjTuYJOVk0Lolt/TDGjGpXLgBkMikfA02+KR1AcmB
         879/iHDqNhznOND8LUpWWFAIcrBv5Dbq8LADiq8AVk1Q6TLeKL85mGRkPWQaJ4Laeg6g
         orpTnJGYGeJunVHDmEpZnHg9skRzwVX5JRvXVNBodOdAYqfwQW34kH28oR1yCNiWkkOC
         4Z6nH88d3U0gKzSeVcncm6TAafwqf59yS0DlJDxyRXJWDlkK6mMhelt4JX4/Ranu6gHN
         MRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mcP4GbdpRTg6spV/HxyzwMSNL9MGijUUA6+sUlnFP30=;
        b=j8lQxA09yFOwORI7A/6xNKOx0cOLk+lCqGA1nKOWzMpuEfxfpDz5ObVwCyGOxe+TzK
         5r5Y5nWihqKKvD0KGPnmEScJEOJMhfzFEWyBZV28QxqGSUGdZj3qar4JEd6pwQSkXrGx
         PmyuI9Zkt6Dt3mRKwNm36jnv63U+y8iFyOBH5DRAm9GcpgFb99Aw13f1pt7qlUZGAasf
         LfUxzcouUk85XcXGg7mDsw6g1zmbdz5+JapcSQl5mwvJ679QIlBwXoLQfttCDjGmwhEW
         ixNVqjOjKUFFaS6rEprV4jhUIesbpNIaYOU1QHauSsjGXp8yRjT8UBbf/oD1JrooIOEP
         GuAQ==
X-Gm-Message-State: ACrzQf2l0046Ek7HbVx/0ga+6HIIxRtQVJLrAceNZtfdTN5T7T9YTHIc
        BKXyd0G0qJ8c6C/AcOAl8p0=
X-Google-Smtp-Source: AMsMyM5+71VRFfXBVu3CBN2pS/EFGXVqP6G5VNVhNJLjhLWFZ84UvmlIM8wzFV9TS6xuYRXHxqn+fQ==
X-Received: by 2002:a63:8643:0:b0:462:9b02:a0c1 with SMTP id x64-20020a638643000000b004629b02a0c1mr665747pgd.536.1666058553748;
        Mon, 17 Oct 2022 19:02:33 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 02/20] perf tools: Use pmu info in evsel__is_hybrid()
Date:   Mon, 17 Oct 2022 19:02:09 -0700
Message-Id: <20221018020227.85905-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If evsel has pmu, it can use pmu->is_hybrid directly.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b7140beca970..c9fef26d0702 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3131,6 +3131,9 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 
 bool evsel__is_hybrid(struct evsel *evsel)
 {
+	if (evsel->pmu)
+		return evsel->pmu->is_hybrid;
+
 	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
 }
 
-- 
2.38.0.413.g74048e4d9e-goog

