Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF45EB1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiIZUIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIZUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B763F02;
        Mon, 26 Sep 2022 13:08:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d24so7236309pls.4;
        Mon, 26 Sep 2022 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=xcLNKADRqeZX1gPJ62SQBYBy+AG2Qgoe/TxJimAn0lM=;
        b=YbT2CUGn0c6XGd/eeoifQgCub7e/5eiCESX9snX7y4O4OkBVvhWR8KemYQCG3qYryf
         T8mICpADND8cLkH2j6D/IPlYEIZQ78p5ZRzAcpfOgr2O+du5rDGwTYBkSoRa1a+KTdzb
         9jeH7cx6KZSmURpCUf9EDaTBN3Ffhx9K4WTM1fzvtvDStS6JGV/QynWUfcOlR/gX+TPN
         fCUlLv8CTl6gNvQOqf6w5jc5Axy5jTn5E5my6EvwQLxIpNtgnIGPLxE+FNXxjrjgjVfz
         bCJtd/nfKcxwecxzKjiP9VVrnWcp32tPoHdsROQmLobjIhSgIOSSRn8XD5qbIzjGozTk
         znSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=xcLNKADRqeZX1gPJ62SQBYBy+AG2Qgoe/TxJimAn0lM=;
        b=VN3/hvsugvg0TIq6mFEt9YjAFIU7AGuxM/nrLBXfPHk7v4Urx1T/F0Fuqdspd/upgA
         0NSYTeS556yLS0Uc/Uh1X88O1hoiRX2YER+ARwXgfOrxwqHVS0PX1YAwXzFq0CNjAoku
         5OHneGWCrmSeZSlTAKafPgsanG2dzgtxR551U/usC3YeUXYGjdm8GplOqm/v3g7NlVp2
         Z1QJP+KBKxRyRp5wCbSMDpANjF4fKLyMGWP0BFkMGZlVBaKZLykf9SRPq+hZjKhWcf1T
         Rh+TtrEgDCAPQ8y/nQaUHOmdPkLykXtVoqkjeD7xIz0QrXchwAxk12xEOEfE2ZbvdTS+
         9zvA==
X-Gm-Message-State: ACrzQf0ylrpOY2xjDEUCleGbcEYFKqDe86KHsYd+npu0HaOOGguZQFUu
        r6YJdl6LAmFfJ+ph7cHYjaI=
X-Google-Smtp-Source: AMsMyM4od1sr6bHJV2kBrH8AMW4zdbU1jbZR5G0MgF+E4yd/oz8IkA6ch9dHkrnsqydYqTwaJzssrA==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr11322301plb.7.1664222880165;
        Mon, 26 Sep 2022 13:08:00 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:07:59 -0700 (PDT)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCHSET 0/6] perf stat: Small random cleanups (v1)
Date:   Mon, 26 Sep 2022 13:07:51 -0700
Message-Id: <20220926200757.1161448-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

The code is available at 'perf/stat-cleanup-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (6):
  perf stat: Convert perf_stat_evsel.res_stats array
  perf stat: Don't call perf_stat_evsel_id_init() repeatedly
  perf stat: Rename saved_value->cpu_map_idx
  perf stat: Use thread map index for shadow stat
  perf stat: Kill unused per-thread runtime stats
  perf stat: Don't compare runtime stat for shadow stats

 tools/perf/builtin-stat.c      |  54 ------
 tools/perf/util/stat-display.c |  22 ++-
 tools/perf/util/stat-shadow.c  | 320 ++++++++++++++++-----------------
 tools/perf/util/stat.c         |  20 +--
 tools/perf/util/stat.h         |   4 +-
 5 files changed, 171 insertions(+), 249 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.37.3.998.g577e59143f-goog

