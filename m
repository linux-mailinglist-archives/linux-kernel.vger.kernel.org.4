Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796AE628D06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiKNXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiKNXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F91C40F;
        Mon, 14 Nov 2022 15:02:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o7so11723882pjj.1;
        Mon, 14 Nov 2022 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spAtbl47EygOQnxJUoTDwXbnzuvEBdxdVrBu6CoUdfg=;
        b=GBNSrINHaYt7YJXAN4zG7nVOyn8d1arFdcIDDx14UM/9uLeOWaKTrmFNQDu+yACf8F
         fb3luK2ENRMhRIo7wRpHx4gA7eEJ21RF1aJVOSJmvQOUmIWb2f4cqzPb71s8bgmP9ZsF
         AnFWjzeVeHk9PYl4i0wk+la+pRHQDLt7sGrNKaN9QRoYNXviGiZCtoDF4UCiA/XvW/NU
         M7KY4SnN6O5nMRowCre/OK5v1CN4LFLwEmHvovme6aJG5v8KR4FexPc2tSlvPbxvekAv
         HsDTEOAyzC3s+pwqvRQMtlEIy7xDlkPYHPUBMwQGCp60C+bsd2fKJhLF9zc5q3p9hx7t
         I8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spAtbl47EygOQnxJUoTDwXbnzuvEBdxdVrBu6CoUdfg=;
        b=gjcvQTwf7Ff5fvI8tstf+dP+mIAUCsIT95GZ9msnq4AHFzLE48aEFxDWM2TZs+VynG
         /Rkjn3h08qQ6JhSaCaySSNHUkTJ25MbfU/AU5NyBUEFTAOs8ghoOWnSzoxuWL4o9ZQz6
         EDF3odJzDrgMLaKL7iONFdFy/LokgAOcGGkSX8jIyScQJ5srpxXspnMD6/1n1Nk2Y/GN
         zkv7k83ygj9MTS8ke8+7nNTqL9HuhrvmVXyWYnT28XJ/LyibhFKuXzWhmcnYU83+XL81
         UJ+ORwLhUfraalP5Y0EwmG0Zt6BXtS6SO/8+ybXIid1CRhQtd4dZS70zgEjaojQQICpn
         FEjQ==
X-Gm-Message-State: ANoB5pnpg89UI+eNrfI/9WrR5RWrk/gagtRktYhvmQVA+bMNHjR6Yk6a
        +Bx3wb7GC22vFAjMWEFzTN0=
X-Google-Smtp-Source: AA0mqf4zJw81epsfXlPYpMayfqaR81tLdkVga3ijGfPj/PA486n3mAYSnbKsWDveoSOo7lHxXgAQAw==
X-Received: by 2002:a17:902:f10c:b0:186:cbf1:27e3 with SMTP id e12-20020a170902f10c00b00186cbf127e3mr1216130plb.143.1668466963791;
        Mon, 14 Nov 2022 15:02:43 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:43 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 09/19] perf stat: Align cgroup names
Date:   Mon, 14 Nov 2022 15:02:17 -0800
Message-Id: <20221114230227.1255976-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't know how long cgroup name is, but at least we can align short
ones like below.

  $ perf stat -a --for-each-cgroup system.slice,user.slice true

   Performance counter stats for 'system wide':

                0.13 msec cpu-clock                        system.slice     #    0.010 CPUs utilized
                   4      context-switches                 system.slice     #   31.989 K/sec
                   1      cpu-migrations                   system.slice     #    7.997 K/sec
                   0      page-faults                      system.slice     #    0.000 /sec
             450,673      cycles                           system.slice     #    3.604 GHz                         (92.41%)
             161,216      instructions                     system.slice     #    0.36  insn per cycle              (92.41%)
              32,678      branches                         system.slice     #  261.332 M/sec                       (92.41%)
               2,628      branch-misses                    system.slice     #    8.04% of all branches             (92.41%)
               14.29 msec cpu-clock                        user.slice       #    1.163 CPUs utilized
                  35      context-switches                 user.slice       #    2.449 K/sec
                  12      cpu-migrations                   user.slice       #  839.691 /sec
                  57      page-faults                      user.slice       #    3.989 K/sec
          49,683,026      cycles                           user.slice       #    3.477 GHz                         (99.38%)
         110,790,266      instructions                     user.slice       #    2.23  insn per cycle              (99.38%)
          24,552,255      branches                         user.slice       #    1.718 G/sec                       (99.38%)
             127,779      branch-misses                    user.slice       #    0.52% of all branches             (99.38%)

         0.012289431 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bf3f2f9d5dee..e66f766a3d78 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -116,7 +116,7 @@ static void print_noise(struct perf_stat_config *config,
 
 static void print_cgroup_std(struct perf_stat_config *config, const char *cgrp_name)
 {
-	fprintf(config->output, " %s", cgrp_name);
+	fprintf(config->output, " %-16s", cgrp_name);
 }
 
 static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_name)
-- 
2.38.1.493.g58b659f92b-goog

