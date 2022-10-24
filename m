Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0260B8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiJXT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiJXT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7F1D2B64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j12-20020a63594c000000b004468ff8fc78so5038411pgm.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JoX+rXrU6K8JU7iZ2f6KugPkmXCVMdf9ZXNzq+WXZng=;
        b=PfDJLEVQTdoSZljLCftkKuXa4vHopLYHW+Zs+nAdnw9TlLOLf0h8zJ4UAoR/va/HTR
         sHI5mvAdv8WI9Esx2Hjez50/j5mBeOzp1EIRDJljrTzVizQiItYexTMX21rnSWlM11lQ
         z0ASHmhiCbvWXv+tdJ/n8B/rCosqMKyI+ttlXWe54G0sQsvhwzvMffRPFfuukJXfiSEW
         EF64a1r4+3KyRVosZ80wWMwumtN1UytVZRSLR8sB9lzHxQaMtG5msBH27OC97WnwY6vl
         jmojGGz0FWrjFDgGqxYlqab+Iigjjw1wJkiKE31bCXFqLRU3r7rx59vEFgTvD/vxguQ9
         qzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoX+rXrU6K8JU7iZ2f6KugPkmXCVMdf9ZXNzq+WXZng=;
        b=I5djfFlTWO5/PgVepa6gUfNaA8qz9eH1cT1mGjO2DmFuDear4LXeuo31VFpQkkxq2f
         u+hsNYh0BgO+QxGKwgAxeIzZfJBSw8/V6Y3fPO5s/GAiD2HmVFlBs2dn/nzCNV7Oixc2
         pIL5rNC7VoJvmVRAkcpoWKSjdSl2iF+ltJQ1+iCxq8diP3aNv88YnS5hbH996aXCQJKV
         lgOwTYEeb3rV5p6ZV6OZg9ysHThbFfaj+LFBDarvA1XnIS24ab+d+a5nrV0l7PFcXMAY
         qpblZWkLeDErvT6La+WoY6KcefGV+u1fbJcZgoJakqrw+0hG+4P6Is2oG9Y61HQ81X0+
         Zp0g==
X-Gm-Message-State: ACrzQf3Q83fADW5FImnqheAkUIKRJoC8eOiwJDscnDjlgBxSDZgRrHFm
        HBHxMzmqEPaBkZ0rd88o4p6sC0aTgybr
X-Google-Smtp-Source: AMsMyM5rcWqWlK0OCIxzqrI1ljMyKEHeEueoBjrUw/oTrsAAhxhIPmRXnVUrh/WArpGokhdgHKMqS+NJSdm/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:5892:b0:20a:9cf5:c13c with SMTP id
 j18-20020a17090a589200b0020a9cf5c13cmr75024424pji.63.1666635598568; Mon, 24
 Oct 2022 11:19:58 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:08 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-4-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 3/8] perf daemon: Use sig_atomic_t to avoid UB
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sig_atomic_t for a variable written to in a signal handler and
read elsewhere. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..aaa47d721ae7 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -105,7 +105,7 @@ static const char * const daemon_usage[] = {
 	NULL
 };
 
-static bool done;
+static volatile sig_atomic_t done;
 
 static void sig_handler(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

