Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3324873F378
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjF0Efo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF0Ef0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2BB1729
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so5216290276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840524; x=1690432524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=4d3w3RvalUiNW3Mlb4z7HeI5eBjdXXDanREtvLdEKO0zQi97uPJqEAka6AkjE86nHr
         8XB9/kEFUBJi8AJsTHf+Le/uRRo4F8PlxgFfJ/QhHtx7RE1YA19aVI5CB6rteNYWMxzE
         6n6OGPHdPePP7cMhoRbGT+p3rmFQF+q1HJ/OOV86BQSDSr7Twmk6ZxkwKauuZj0TndZH
         TQKbHM17RL+GTOXnsmyZA/8cpIHv6l6wrAnczusUqxDxlMiVldoxXYrU57qaSOmxg6Fg
         /s+2yJNgYjpZZGOI1BVuzzUs54DDKCmy3GkSEGRjSZ290zx1wq0ulPCtK/hQ6mcu/Zh/
         VwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840524; x=1690432524;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=WxWS5JOkUcbsZSK3uhBB1SVomEr00yijdHJdeoU7GeYhILXjv74J03Pwhy+T9g2dBd
         rOj2hJNU3wU0uxKLNqJ3X0ENEWJTeVaEyXTc5kZIqf41F1Aja/ssks1KNIcXXxSUCxGx
         EeBOfpXznLWgzuvU4Hww4XN1JjXKrIp0trloebP2cRVxgWY/mU9niwUyjLt6rlehxq8G
         56t4U4Urm+OoiBlcImNRdsIYHXvzn3Q+6s4Njr3QgUN/X2ShcM9CzU3TB7moKObNFkPd
         LLiJhPGa6L++j+hIpH6ouZVwMgUslLCNDrhDOeJCvoI/XoPTW7bofvV+xzrNH2cKPf+c
         OmNQ==
X-Gm-Message-State: AC+VfDwNzO7MAP9B1JDrk445DXp0frJLkxzNt9z4N1j6tR0NZmxobkjF
        7O6lAQzXvUME0J8SihLT8Mu8KaFjrg1E
X-Google-Smtp-Source: ACHHUZ6g1UtttxcfnGpIgZXisAiPfloJoRAyLGmtDUzPqS7qoDZxsCECTY17v1QG6FMB/7F3Ug7qZRC3lipr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a05:6902:b13:b0:c17:4115:620a with SMTP id
 ch19-20020a0569020b1300b00c174115620amr2426866ybb.11.1687840524751; Mon, 26
 Jun 2023 21:35:24 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:48 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-4-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 03/13] perf parse-events: Remove two unused tokens
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tokens PE_PREFIX_RAW and PE_PREFIX_GROUP are unused so remove them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4ee6c6865655..b09a5fa92144 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -61,7 +61,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_BPF_OBJECT PE_BPF_SOURCE
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
 %token PE_LEGACY_CACHE
-%token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
+%token PE_PREFIX_MEM
 %token PE_ERROR
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
-- 
2.41.0.162.gfafddb0af9-goog

