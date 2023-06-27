Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D444873F377
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjF0Ef6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjF0Efb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648C1726
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942442eb0so52808987b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=GGhHei1HXQ2/eDuwm+x2TRZUoV9KBsZ+Y1XPf//HboZJ0pXVaXRqoxpqXkT4G2FLd4
         LaNiwn4Da8qGrPbQJ1SsadtrnJPqutB3BWihU34E3qtpBswwOq72yejdwQwXoWzMtPwt
         +y5uRhYhPOw4jHxwVvqqQuUT639J2WhZpb91636YlufXm9IF8Nl6uRQgVEhtSqBLlPRE
         dwCL25Cikuvdfs4zaLso7TKsY/bxhm/5gWCtqE7vN1Zzz/R07iXPDz8OV6DBJ++Y7LVz
         XXs2BcP9ujeoVCc34lFY+GmgRn8oIAVxueOaIiXXCf768u2txj0KvJkegEH5ngzuzd91
         yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840529; x=1690432529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0MHDI7A/36EtneRiQenQbjO4j0vMg3AtMW+Ct7r1E=;
        b=X8Z1bICoPlVDQr0ryE/H8G8q+ezZEqW0KZliCsrPgkitcu7zTpAdgiLp83pSGQZTnr
         KiuQWCxBkQzNj+v5jvA20oTOdOdtNlXcyKFObOt507r8JMz2Xq9TJulJoE1z4eN8Wwuq
         AoJwX/+ysjiXL7h3cXGrQ6//sfwRmtYdkbpJPKyIAl0GGFTFHxIkDalaopNNh+U2cA2/
         U+VATedJHTeRQKXmaPu/cdMX7ff6gn+NGwEDOsnBSyWh1NmYx8GoeF3WPp8y1WA29Oz/
         E+HzGlu4Tfo2PFE5se6xNtucS4O5mvARF5wdUAqtCFSBERSZWhLNThvOG5jG6vLtE0TM
         metg==
X-Gm-Message-State: AC+VfDxGVzE5cf4nVfJAHv6w5/q6ENOlGmbi3+XRjAXDv56GKvSRXtjn
        G6TP9ifuEieuXUALg8S940wf7b50ZYgo
X-Google-Smtp-Source: ACHHUZ6vOZIoR5CLG0J9dOgf3ZrdWfNkMBb9GwaJMfM09LU8pQxeBDqYATdE7/ljR1d1snX1nwvtdZ7/2vqK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ca0b:0:b0:bcd:5dd5:848b with SMTP id
 a11-20020a25ca0b000000b00bcd5dd5848bmr6656602ybg.3.1687840529090; Mon, 26 Jun
 2023 21:35:29 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:50 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-6-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 05/13] perf parse-events: Avoid regrouped warning for wild
 card events
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

There is logic to avoid printing the regrouping warning for wild card
PMUs, this logic also needs to apply for wild card events.

Before:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

          2,979.16 MiB  data_read
            410.26 MiB  data_write

       1.001541923 seconds time elapsed
```
After:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1

 Performance counter stats for 'system wide':

          2,975.94 MiB  data_read
            432.05 MiB  data_write

       1.001119499 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..0aa4308edb6c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1722,6 +1722,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 							  auto_merge_stats)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
+					parse_state->wild_card_pmus = true;
 					ok++;
 				}
 				parse_events_terms__delete(orig_head);
-- 
2.41.0.162.gfafddb0af9-goog

