Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2860B8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiJXT6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiJXT5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:57:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D21799B1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36b7cfda276so50539717b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=VRBpSdHVTZnE+YXvFegVopepFbQ4rBU/QUHcsshpgXkjl8MaSdIQyGG6rx5fBbADpN
         xMvXZyLIQ9EeU5rKOW3YQugY1FE1YvVJL3Aam8IsGX43Us52UyYNk0qsy0Gzgvy3b42r
         i00PdJSbsUpUiyeZdfsD1Tu0dqaUQGkI24CTo+6c9/PvhAmHZRHZdd6Ihbc5pKj7gC6I
         zt8b4JNH31YlusjfnXVQj9XLJbc5x8ZZPPXRcudD3sO9JBxMfP38PJaqmAChSU3Bi30k
         MNh0Qc1AL/nplEstpRJc4gHksFuwYc33HHJbGp7zBCtWV1hPDPD164mlrKu1LZ3lKP52
         2eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=m+ZjsIC6SyydfRZFsf7gpCvPygeTIeFpKORXWmCj+atA8vkZTHCmSlSd5VYgyve9py
         lD94RdhoaKHRyIw4Mk9V18idtGrD+xZb4V083EsZMGCqE1YF6P6l5wxyVUnzsbpJuR4D
         u3EusaVwrUOMr13+p+qSv0O+zMHcWN6Ap41hB5i8mQ7gwDa+n4Tvh58N3PZmedWFoVSO
         LXDq9Gbp1Z6WhFKxBRbpajz1rv4cgDostMcm9Lowc3++zQZD8VP2TjTwtsGDs9Bn0dUt
         DsveeYesTK+LnXkzufL1N+EgqkyEzF/uyf4nkZz/ENqUgaOnwRx8BbF3nK8jF93hJMV+
         niGw==
X-Gm-Message-State: ACrzQf02aIcKnJzOrk96oEMTVch0wWMcObhgb+oQnNa46V4COIA51Yio
        G2Q87SsliTbiBqBaiZ7ZIi+VvCi7ntgB
X-Google-Smtp-Source: AMsMyM4ftlJbQC5kXUpk84+mlsdvadwXGidOSZUitz+A5zvltHJN1xBUP8bVYVwr15+jb75wIFuEUJj+6OeI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a25:504a:0:b0:6c9:8926:9048 with SMTP id
 e71-20020a25504a000000b006c989269048mr26969653ybb.38.1666635582786; Mon, 24
 Oct 2022 11:19:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:06 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-2-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 1/8] perf build: Update to C standard to gnu11
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

