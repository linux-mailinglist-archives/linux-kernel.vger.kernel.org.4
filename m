Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5260B66B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiJXS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiJXS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:56:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005ACBFDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:36:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q62-20020a25d941000000b006cac1a4000cso4360820ybg.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=bkFsx7xRDT4SOzYnBWia39BL6PfxRv41NyEx8ZpXPvEJYtzo9fD7KHXUZq7dZ0kSp+
         Cb52tElChTP5b28SYmcB5d9ym6Xy42R3VF0Ln930bKL9ke9DhtRKIIj95iTOkT7ehVgJ
         hSggoy02P/39UXt24GxVtWyl2QObBaYL2BAmTtIolM+YJ++faLGH2iBBfPtYnK7ZtOUm
         0CH2aOJb0eXXsFA0urZ42cb0ZzLHirPS5E5WFPYWibD3/LMGxhPsBWW3gHfyZJl9Fcuu
         ou2vxzk0+j+CYMcIiAA/4ZOc/qL+YRdYHKuvBaoUeBWquw8scpTG1PNaCPz9/VIf1/+K
         l6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=38zy9mWLFXqkXDPXboj3I441nYchHUu6LjfvDSaTiGAkP88xmdF9K8+FFRBzFl5Pra
         FShNfoZvliZXHrNHHwQjwOL0GFHfqx2/AAZEWZ9zG8uT0KjyQ//S14sN2DyrR6AnrbGE
         x0qcZfsnBmD2+aSO3UwXNCgyqQ/N/p1nAc6UnZggS/M45+VBO+472lqUX6SRUnT8zK+G
         M/NibXyHI8xzMZkW02Vqr1a1jogrT2XeJ7ZjXMRoujGFElmQYh4F0nJhnx9pX2my9jym
         bDAo2291Fe3VbJv4EsRwIddGUdthalJEK55VkJ9VAi754T1x8v7esizoMyf0zG5wQzGI
         KFuQ==
X-Gm-Message-State: ACrzQf1elBXh+1t31O0DaElhfQbbSFtvr2ALF4+O3z4SRoeNN8nLKz4K
        acImnMUmHFeWJBr1c7Dh51uuBzzsjxT/
X-Google-Smtp-Source: AMsMyM6Wr8wyOuCzkrlfckTajnVv3nw2ax6iWqt2oiTLtFpq7+Hk7ri7Cu+yvY0A4Ah9bvi0LsEH9lFR6zy7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a25:bd8b:0:b0:6cb:d10:a5b6 with SMTP id
 f11-20020a25bd8b000000b006cb0d10a5b6mr5711316ybh.173.1666632951410; Mon, 24
 Oct 2022 10:35:51 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:16 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-2-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 1/8] perf build: Update to C standard to gnu11
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C11 has become the standard for mainstream kernel development [1],
allowing it in the perf build enables libraries like stdatomic.h to be
assumed to be present. This came up in the context of [2].

[1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6fd4b1384b97..29c49e6e76a1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -307,7 +307,7 @@ CORE_CFLAGS += -ggdb3
 CORE_CFLAGS += -funwind-tables
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
-CORE_CFLAGS += -std=gnu99
+CORE_CFLAGS += -std=gnu11
 
 CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
-- 
2.38.0.135.g90850a2211-goog

