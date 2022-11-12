Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1A626691
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKLDWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLDWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920B6A747;
        Fri, 11 Nov 2022 19:22:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v17so5702585plo.1;
        Fri, 11 Nov 2022 19:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZWAGA3aNlOdnA5uwx0EBItPfceZKGAcWsdEstGFXow=;
        b=Q6GlUldhaY0Y+4SFlM9fV7vvSB5Pp/wVsNGhikyU1YkJTsTiby0bskW5woSeVEXnV4
         p8L2Y0SJwv9F9xAPMnveOuZ1qIKa1mafqZtqOufd46uDtrL5OhOHgX3wtuo8zW0VMngz
         bQIQvgMTG3vOV63KDHRnMwvUfLhUE6DVuj+E6Ra137XsVFpTi3kQj/GKbYYzwoYYpFCK
         0KpsvN32y9fmc1tNymX7Wyuow1whnSTBIfLU12JRjL9MZs+f3k0W7QjVSM4DLuvDC9uc
         S1UaFtLAlko7jipLO7Z4YYyKAqYIm1kmqTayZ9BL/C6tRMRBbPRFkI/DR7aYMSWi37Fu
         kKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZWAGA3aNlOdnA5uwx0EBItPfceZKGAcWsdEstGFXow=;
        b=lMbdhrOu571QstjWCPO+AEbJmAwccHl9CLplJxZfINxU8gYSVn9EJaQJ8mdFyqBy7q
         KY17jyITprL5bpZYfq/Jd2jQGVk3GKcs9EEI5HGVeOZQLd9wPDNkpiGQBZGOi4KrONA5
         LcfuOzXgNyBWxF3grIGUHn/Zvb3yJBDqOHiAaxNoFx6Gqqon+rp8vhmEPMCcmX5UMf4/
         MGBTCMy7/EGD20H275QiKTxL0nFHVbp4YwKsDaawpohnjPPfUhD4Oqzu9GHnDlJNZGy/
         MymATqTQPj4ta7PQIHXBHf8PL5iQuYxt7uC57S99P6nQ7HeulrVIYqB5ijKSpXug/Hjx
         mF4w==
X-Gm-Message-State: ANoB5pnOC4AJn/3jcgfi9iiT3BtzRaV4bVr6BvY86iIjJXXJespbzvTG
        U1vfJJV9Elbu0k9jr59uXGY=
X-Google-Smtp-Source: AA0mqf7DY7ZKlLB1HCorMiIx4lCw/RXIEXIiTQyinWqRO9IuJkeq/0rhJ9vi0We5SXvZiTdDyCzxMQ==
X-Received: by 2002:a17:90a:c205:b0:20b:590:46b1 with SMTP id e5-20020a17090ac20500b0020b059046b1mr4858039pjt.83.1668223367466;
        Fri, 11 Nov 2022 19:22:47 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:47 -0800 (PST)
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
Subject: [PATCHSET 00/11] perf stat: Cleanup perf stat output display (v2)
Date:   Fri, 11 Nov 2022 19:22:33 -0800
Message-Id: <20221112032244.1077370-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
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

I'm working on cleaning up the perf stat code and found a number of issues.
Before moving on to the real changes, I'd like to fix those first.  I'll
think about how to test this properly.

changes in v2)
 * move applied patches to the beginning  (Arnaldo)
 * make it error to use --interval-clear with other output  (Ian)
 * add two more patches for CSV output
 * add Acked-by from Ian

You can get it from 'perf/stat-cleanup-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (11):
  perf stat: Fix crash with --per-node --metric-only in CSV mode
  perf stat: Move common code in print_metric_headers()
  perf stat: Fix --metric-only --json output
  perf stat: Increase metric length to align outputs
  perf stat: Clear screen only if output file is a tty
  perf stat: Do not indent headers for JSON
  perf stat: Add header for interval in JSON output
  perf stat: Fix condition in print_interval()
  perf stat: Consolidate condition to print metrics
  perf stat: Fix summary output in CSV with --metric-only
  perf stat: Add missing separator in the CSV header

 tools/perf/builtin-stat.c      |  8 ++++
 tools/perf/util/stat-display.c | 68 ++++++++++++++++------------------
 2 files changed, 40 insertions(+), 36 deletions(-)


base-commit: 816815b852216f3aa3a43e2ce91c5510927cd61b
-- 
2.38.1.493.g58b659f92b-goog

