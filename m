Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E737402E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF0SK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF0SKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5C297D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:48 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53fc6e58dabso2093938a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889448; x=1690481448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=mDO2RZPnw3ueZUEgv1txbCfJHsBa5ZLGazmnDmvs1Rka9T1sryG8ukUK81nej5lSNu
         ORauHXjoy1ZWTbiDpbmxh/Ik0yEX7nG/6Kexgltr82+VRMVArq9QsoYWy6GTx+sXEhB3
         urulGJs2wXbd8LaN7yG5ZJqtHm+FAftrzBsdkM2+8018xoe9DHQG72o2CvaG1m85vGlz
         5IEf668Pba9cgBJXVY9EVU3x9C/nLzyHwbwQ9aRW7k03A7HvDUY/BXQN3+h7C74R5BUU
         hnFpuLkVqktQKdKBdU8mQoYsp4xWyf4aNgy7FU5a/VIu3RjDzRNmIU//UnIc4IDcJBDk
         CsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889448; x=1690481448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3xFrkPN2+sT/sY0g+uTpgnQ+XoDit6j6d+F4zxTHTs=;
        b=FWoRxPUm3O5EZm+0VZBTXia8N+YgXuN/VfO9R7bO+dQzjfoVyFtlZwZ6y0/V2eVqZ2
         9NmMN4y2+2cwcPUq9KS92sF6eXMz/WtJMtLEXeqnwpXk4WLo2OXm3TTqbNraN2T5px+Y
         woIru/YtN9Nor0Fmp18X1wMRwsvI9ay3asNQqoklIOZNHAbUu6SzXQ9VXfALg6HksmiJ
         4J3HOt7mYU43GQ6TyNtZfKBooJMWO9pNYbqPf+oYZ36D0Caz/sBKC3Y9SOAsTQvFPvMP
         1kBMH4uJa1nYmNUK1BI/NXyhHmLv2fTsHElUyMWqW2wVMLuoGX42JGq8EdWJtrjjjaXw
         cYtg==
X-Gm-Message-State: AC+VfDynC5/ImZa/NKnrHSWUvsYgQVApcXZ4QQqF4mKQpfcYnJrRXwWp
        Rc5zXzy/WCVK9VPo1FgwrM9rMUNiWb17
X-Google-Smtp-Source: ACHHUZ5mB+sRufre0MS10vvaUmW/lZoKm7KiOFOjWsJZZ/Z0hFb1Aj5m0AyV+IoElXQMnCvyrcjdO2AbKUr/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a17:90a:c695:b0:262:dc49:3bff with SMTP id
 n21-20020a17090ac69500b00262dc493bffmr1357157pjt.5.1687889448289; Tue, 27 Jun
 2023 11:10:48 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:20 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-4-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 03/13] perf parse-events: Remove two unused tokens
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

