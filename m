Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4B5F10C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiI3R1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiI3R11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458D1162F2;
        Fri, 30 Sep 2022 10:27:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b75so4814393pfb.7;
        Fri, 30 Sep 2022 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=uVtcCM8X47G6H6MM/dJAUW1ggO6ijtQ9TTyWaSWbBS8=;
        b=AtFihyt63SdOSQvjcYww0MuR1fPRAY8/ruyCNxo7e3gnroS98SFZsyqL6VwnjGO3lt
         Hehq6UCqMnpr3nNUiUpPV1g3HtA6E5abRE3zXjspxD2mk3A/axLKoyL2JoF0S6dAYdMu
         6N95/9XzDwRIRV9PqiYRto4T7PRZEq14f/gAqlobufFClV7cjl/jWK51sB92RJ7Jr2rh
         lkP0Kw+dEDpZvcaYCxbMTi+SLUTejVXDg3qDvy3/hMyAg79wxGQxOTPSGiJLrZdCPwef
         K4I34gEoFvvAQ2z/Cv1BIPAqmCMVTjudwGGYEEwitPgWDtrKPdROAl+jPoW1tc07EHu0
         J2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=uVtcCM8X47G6H6MM/dJAUW1ggO6ijtQ9TTyWaSWbBS8=;
        b=gCzzKFcV/4wlHo9GqR3ApHo8Ez5xz8kinWdGLYs3832aQVgylFJLlPZI4svGsZg8Xb
         oDZYRLKVfzzVJALZHPmHdancnR1Az/UTygGliToq5YA7oeCR3yYP/gyRcuRHfUnfmL3K
         k5dKyQm5nJ6lQSLEx7feiCxNN8vgsvcS/beRh0SIGo8xBrabg5Wky/ch+tE+kxeZ79ma
         IG0v3nCPVy547UmE/6u7tCW1jpeC02LcXcvj4AgivTOGxqa1cjQd8UoZJWWVw7Zz3VN0
         rwRznpX8+efl2zDRq7s68soZbZd3ucdxj3oSYQ8Um5y6of3GjDd+k7olqtP89eb7UmZ/
         jOcA==
X-Gm-Message-State: ACrzQf1F4uKp5wIUGJ5Ye8fBhenl9Llt4xi4se9Pwh/Au/FyYscqq12+
        FQN/k1VrRCrPwYC2D/2OygU=
X-Google-Smtp-Source: AMsMyM51yiS2VdUteYWEn+eP89GvXH2tnw9qlPoo/qqGWZU8uoXJmgNAyfrHMO7JLMakP3GI+FPOPA==
X-Received: by 2002:a05:6a00:180d:b0:540:ec09:293 with SMTP id y13-20020a056a00180d00b00540ec090293mr10382594pfa.3.1664558837514;
        Fri, 30 Sep 2022 10:27:17 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:16 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/5] perf tools: Clean up cpu map handling for system-wide evsel (v2)
Date:   Fri, 30 Sep 2022 10:27:09 -0700
Message-Id: <20220930172714.711616-1-namhyung@kernel.org>
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

The system-wide evsel has a cpu map for all (online) cpus regardless
of user requested cpus.  But the cpu map handling code has some
special case for it and I think we can cleanup the code by making sure
that such a evsel has a proper cpu/thread maps from the beginning.
This patches should not cause any change in the behavior.

Changes from v1:
 * use evlist->core.needs_map_propagation field
 * add Reviewed-by from Adrian

You can get the code from 'perf/cpumap-update-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (5):
  libperf: Populate system-wide evsel maps
  libperf: Propagate maps only if necessary
  perf tools: Get rid of evlist__add_on_all_cpus()
  perf tools: Add evlist__add_sched_switch()
  perf tools: Remove special handling of system-wide evsel

 tools/lib/perf/evlist.c                  | 23 ++++++------
 tools/lib/perf/evsel.c                   |  3 --
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/perf/arch/x86/util/intel-pt.c      | 15 +++-----
 tools/perf/builtin-script.c              |  3 --
 tools/perf/tests/switch-tracking.c       | 15 +++-----
 tools/perf/util/evlist.c                 | 46 ++++++++++--------------
 tools/perf/util/evlist.h                 |  1 +
 tools/perf/util/evsel.c                  | 12 ++-----
 tools/perf/util/stat.c                   |  3 --
 10 files changed, 46 insertions(+), 76 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.38.0.rc1.362.ged0d419d3c-goog

