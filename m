Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF705F138A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiI3UVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiI3UVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3015D84A;
        Fri, 30 Sep 2022 13:21:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w20so4862772ply.12;
        Fri, 30 Sep 2022 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=DLzJdO10GSNCN5GIcELkwOMKfupcD8SqYGKC0DBtR7A=;
        b=bt/tNKSWMLXJATUiOE0ln9KGyEdTR/w3Uli3g+4nGlSbQE8wxvB/L/DTRcd1SqJevW
         wCMqaFb6WubgRPdIHEaYQUwoUmxkOc/2P68AjAYv+XC6wPk5CCNEIZU5mpFsUUPGIuO8
         /y6y83UAwZT96SJrGwJbMF1TRq4tlCmPJSJnoItpkGTI8WWKq3Yqwx2g+geE53HVGj5J
         hp3Rz1NdLjSQJfKpbbx+qf95WTfAFvFJSIiLtElLYzlcDRJJniqqjpdhhBgnDlV7YFrC
         pGHGnUoIdduyKPfOTW9Rb11IBl5FPTyEt3u424YfakH0g9rGhJvk/Kml246sQs+YDHQ1
         r6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=DLzJdO10GSNCN5GIcELkwOMKfupcD8SqYGKC0DBtR7A=;
        b=M2NEf5SvKb/HwuwQLc7orYtPkEtR5XTouO7ZWX6iqRtudiQp5LqOG8EvmkWQOnNEAl
         pVKGfc4iSy7lH19C4I+CTZAQlKaJzZEEgsJPXD0RbHHJV0hfkinI8dpjRGGe1E6cjrAg
         d6lu48Cwzj4v0K2X/xeSaDaGLn2ZRu9vf/7/jI3Qg+DbPT0TiJiKwp3Sm81IS8RjR+RF
         567Zr6sa1ChQS7FjkqknCppRaCxlEpomMHI9BoPYVCqyVy1HiJOzO7N908K2GghaHMix
         WZsjSru7f6BiCeRJhJvP1eVhiiTIjTqbhhd9pLwIi/jmn4hcJc+nbUx/AQ1nfZv4VdJ9
         Pp7g==
X-Gm-Message-State: ACrzQf0qAHLYHtm9LKbsJcI3VvZ2ieIk6oDi5jaeHMEyegbzmTwZdHKI
        m1DSAjIO6Pmpdv3wMwMNOwY=
X-Google-Smtp-Source: AMsMyM7ddcW184Xn4/AAOB1PeluvK0u8WzqtNN73mgPWlwUnLob79t4sBh1eMvx8wQZsE4TjlWl7ig==
X-Received: by 2002:a17:902:dac7:b0:179:ee21:22a8 with SMTP id q7-20020a170902dac700b00179ee2122a8mr10416543plx.70.1664569273910;
        Fri, 30 Sep 2022 13:21:13 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCHSET 0/7] perf stat: Small random cleanups (v2)
Date:   Fri, 30 Sep 2022 13:21:03 -0700
Message-Id: <20220930202110.845199-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

Hello,

I'm working on perf stat and I found some items to clean up.  This time
I removed runtime stats for per-thread aggregation mode which we can simply
use thread map index to compare the shadow stat values in the rt_stat.

Changes from v1)
 * renaming missing parts in headers  (James)
 * add a comment for map_idx  (Ian)
 * add Reviewed-by from James

The code is available at 'perf/stat-cleanup-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (7):
  perf stat: Convert perf_stat_evsel.res_stats array
  perf stat: Don't call perf_stat_evsel_id_init() repeatedly
  perf stat: Rename saved_value->cpu_map_idx
  perf stat: Use thread map index for shadow stat
  perf stat: Kill unused per-thread runtime stats
  perf stat: Don't compare runtime stat for shadow stats
  perf stat: Rename to aggr_cpu_id.thread_idx

 tools/perf/builtin-stat.c      |  54 ------
 tools/perf/tests/topology.c    |  10 +-
 tools/perf/util/cpumap.c       |   8 +-
 tools/perf/util/cpumap.h       |   2 +-
 tools/perf/util/stat-display.c |  32 ++--
 tools/perf/util/stat-shadow.c  | 320 ++++++++++++++++-----------------
 tools/perf/util/stat.c         |  20 +--
 tools/perf/util/stat.h         |  10 +-
 8 files changed, 189 insertions(+), 267 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.38.0.rc1.362.ged0d419d3c-goog

