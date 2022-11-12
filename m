Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD9626695
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiKLDXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiKLDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F536BDEF;
        Fri, 11 Nov 2022 19:22:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9259941pjg.5;
        Fri, 11 Nov 2022 19:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQLHI1VILRgMSu/jKiHmF9iPDf4ibjWi9PVbqPg9gSo=;
        b=UsCcGGDGGhfTo+D44aLiaSYlWe2328dlot3oI5NEGpGnSb++qvwFNLDtlB+UVBqMML
         hhuFPLzTUf0ejOG1uhfd2GVH2OW1/J/haXHpDOh2z5HFmTZ5Y1lkWietE5VrqNlYgvdn
         Cece/NY/SjugMB6Adrg6ZqsR3YZJltAOybC5zSAZSmSK2VsOIQqMH1C58NHJXyGzOIGm
         pjd456XTbMWqTL9IH6g9+fmcEQV409Q+VyFaVePZq71r4R3hfGvzyBGU+xLVY7J7QLy9
         bYI/LLd8uHPO1arOSrNvreagsxk2gBTsfBWt2vYa7kuHHitCl749LNwWCov+5EnC9MV9
         KQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQLHI1VILRgMSu/jKiHmF9iPDf4ibjWi9PVbqPg9gSo=;
        b=I8K9Mh3/56fWmHSV6vaKPfoyuSEydBYsEYb5uFu7Q6DBUSHVJAX1+0bqjtHoQJiPqd
         E1HlVBvdL2p37tdtouNR/mFlwa+7QVtB2iW+eTuefYOlSLc5SzXdtlII+j+vxOQVCWTC
         /w/jodvh07feuSO9ZOgrymwJABri9UmViInNOmSyd+Jobf4UwEorvyEIYPX4WaXt78Ff
         8imMll0G3N9W0hs979tnTDCOJdYAjDX3N7qjKJdHwpQClP60Etpi58wKjkIe090gAuc3
         T9ujCggjIoKEXDUytJPzwD03gUcoPp+btrATy+AA/BsxpkbYxxqPQE+e5rLbN+piwXgu
         CF6A==
X-Gm-Message-State: ANoB5pk45tgBXJDKVJJ60qHnN0YvIuwycJWSXiwwCqJIgs2ySrZuYi1q
        Gt98HK5Olv7JzbPqmCPEirU=
X-Google-Smtp-Source: AA0mqf4d2B9NIg7YT8D6UyzsqIvD7Y0hIy+p6nFTjTI3gS+QU4u6gt7QMEIJzaRVAeoLJ2hV1m9f+Q==
X-Received: by 2002:a17:902:c651:b0:187:3bc8:fc56 with SMTP id s17-20020a170902c65100b001873bc8fc56mr4956125pls.83.1668223374900;
        Fri, 11 Nov 2022 19:22:54 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:54 -0800 (PST)
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
Subject: [PATCH 04/11] perf stat: Increase metric length to align outputs
Date:   Fri, 11 Nov 2022 19:22:37 -0800
Message-Id: <20221112032244.1077370-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221112032244.1077370-1-namhyung@kernel.org>
References: <20221112032244.1077370-1-namhyung@kernel.org>
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

  $ sudo ./perf stat -a -ddd true

   Performance counter stats for 'system wide':

              233.70 msec cpu-clock                        #   11.714 CPUs utilized
                 320      context-switches                 #    1.369 K/sec
                  31      cpu-migrations                   #  132.648 /sec
                 482      page-faults                      #    2.062 K/sec
          38,414,140      cycles                           #    0.164 GHz                         (6.65%)
          13,656,335      instructions                     #    0.36  insn per cycle              (20.31%)
           3,594,871      branches                         #   15.382 M/sec                       (34.06%)
             124,071      branch-misses                    #    3.45% of all branches             (47.74%)
          14,016,847      L1-dcache-loads                  #   59.977 M/sec                       (61.42%)
             789,534      L1-dcache-load-misses            #    5.63% of all L1-dcache accesses   (65.98%)
             315,353      LLC-loads                        #    1.349 M/sec                       (47.13%)
             171,244      LLC-load-misses                  #   54.30% of all LL-cache accesses    (41.98%)
     <not supported>      L1-icache-loads
           2,591,299      L1-icache-load-misses            #    0.00% of all L1-icache accesses   (36.10%)
          60,421,987      dTLB-loads                       #  258.543 M/sec                       (27.47%)
             123,843      dTLB-load-misses                 #    0.20% of all dTLB cache accesses  (18.88%)
              38,289      iTLB-loads                       #  163.837 K/sec                       (10.34%)
              21,631      iTLB-load-misses                 #   56.49% of all iTLB cache accesses  (2.53%)
     <not supported>      L1-dcache-prefetches
     <not supported>      L1-dcache-prefetch-misses

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 96ad0c71adc2..3ddc159df4b2 100644
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
2.38.1.493.g58b659f92b-goog

