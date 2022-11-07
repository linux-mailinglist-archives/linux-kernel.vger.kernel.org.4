Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA41B620136
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiKGVda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiKGVdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8372129;
        Mon,  7 Nov 2022 13:33:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gw22so11860952pjb.3;
        Mon, 07 Nov 2022 13:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv3hf1ICDXb7Hn+sXBgVCZ+pZTQGoTEBZluThFFWAXw=;
        b=kE7vmIC0fkdEnNFfXn/JmPMCk/jZwZAJ6eYmSAC8mz5l/evGA37v3qWxC93WNPk1jy
         7ofPD7Di5xAfJ5Ijg7llqyLpaCaGx80X0RQC3pEooX8V8F6u05/7CW6Ir25lwiiGjxBj
         Pd7QeBQsGrkpIfs0HO0Rt09XlchaC3p9XDIcwMWt9xPYORlsA756Sxs3S0OUShd/nrDb
         DfCrnzUQaLAtZREo+D5NPT9T0tOd235pwhvEzXJ1mq+exXCyyVS2H2jDLcAsO90m7jx8
         Fsxpin/f+NLxS10ZEi5SPi/un+LGGAzEeADUq8rcUi/5NLVyQoUy7Xo2VLrVoAZrTkp6
         9G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qv3hf1ICDXb7Hn+sXBgVCZ+pZTQGoTEBZluThFFWAXw=;
        b=ZTPplWGM4aN+EbEw/4IE6c5Pl4JMSYS2QT78mPTOLRbm4EJdRI4mhf0eZlu/BGmCD+
         yvNzpeSVF0hxnD5w4PpNq3MV2FuqXE4R4mXFlYdJhIwnHJUcqeizG3kTw32JirtZGjgY
         UoFyvCDpm3aRySWwiOqRpdXrbRhLioNlzki52juHR4p6FV0n97FMpEcgn3lNSYPENBax
         pFV80pJVqCpNszqIa70nQb7reBiE7/O4yK280mp4KlAi0nh5YY1NsDGcNP3ZmCqJ+WmE
         4zTHIKloPciWrlpxOMVNV5PmADmEywvgoYkiYr9eurkvNGa05H50XN60EeSzqmp4L+Zl
         Wung==
X-Gm-Message-State: ACrzQf0u9eBlPwE9CytADiWGrLPbkDYE+pZBl9ekRbYr6K96uI7zG9GD
        LdRqDuTw1so98G8M+cnTygk=
X-Google-Smtp-Source: AMsMyM5b+kXSahQnt+NHp0RhIwOQmjbsO+cwH3vdxHPABBxOBC/mMZ4NI4AMs6aLQqqdjOSfOEJSIg==
X-Received: by 2002:a17:90a:9dc5:b0:213:c885:bc06 with SMTP id x5-20020a17090a9dc500b00213c885bc06mr48829260pjv.223.1667856801287;
        Mon, 07 Nov 2022 13:33:21 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:20 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 2/9] perf stat: Increase metric length to align outputs
Date:   Mon,  7 Nov 2022 13:33:07 -0800
Message-Id: <20221107213314.3239159-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221107213314.3239159-1-namhyung@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
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

When perf stat is called with very detailed events, the output doesn't
align well like below:

  $ sudo perf stat -a -ddd sleep 1

   Performance counter stats for 'system wide':

          8,020.23 msec cpu-clock                        #    7.997 CPUs utilized
             3,970      context-switches                 #  494.998 /sec
               169      cpu-migrations                   #   21.072 /sec
               586      page-faults                      #   73.065 /sec
       649,568,060      cycles                           #    0.081 GHz                      (30.42%)
       304,044,345      instructions                     #    0.47  insn per cycle           (38.40%)
        60,313,022      branches                         #    7.520 M/sec                    (38.89%)
         2,766,919      branch-misses                    #    4.59% of all branches          (39.26%)
        74,422,951      L1-dcache-loads                  #    9.279 M/sec                    (39.39%)
         8,025,568      L1-dcache-load-misses            #   10.78% of all L1-dcache accesses  (39.22%)
         3,314,995      LLC-loads                        #  413.329 K/sec                    (30.83%)
         1,225,619      LLC-load-misses                  #   36.97% of all LL-cache accesses  (30.45%)
   <not supported>      L1-icache-loads
        20,420,493      L1-icache-load-misses            #    0.00% of all L1-icache accesses  (30.29%)
        58,017,947      dTLB-loads                       #    7.234 M/sec                    (30.37%)
           704,677      dTLB-load-misses                 #    1.21% of all dTLB cache accesses  (30.27%)
           234,225      iTLB-loads                       #   29.204 K/sec                    (30.29%)
           417,166      iTLB-load-misses                 #  178.10% of all iTLB cache accesses  (30.32%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       1.002947355 seconds time elapsed

Increase the METRIC_LEN by 3 so that it can align properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea41e6308c50..17d656566cd9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -218,7 +218,7 @@ struct outstate {
 	struct evsel *evsel;
 };
 
-#define METRIC_LEN  35
+#define METRIC_LEN  38
 
 static void new_line_std(struct perf_stat_config *config __maybe_unused,
 			 void *ctx)
-- 
2.38.1.431.g37b22c650d-goog

