Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAD70A4B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjETCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjETCzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:55:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899EE4C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:55:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so2879842b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684551351; x=1687143351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdSvKOAXL7sdlLkGjTnnuwOA/VbKrzGOIijIH+Tf82k=;
        b=xE8Cw7jDANx3AqisU3EyAG8VrY1HFl5eTc84ib3IPvWx968QS3Aqj/Ee18o/QUglQP
         UszG3vCgAkfxlpn24AYf27GDUNEpDUU405dBM4CRA3h8+FitTO/SBDzvJWZohdd9WMLY
         LlB5bRSYIqKKW99Sh5peZrcLWc7wdoMhBI73p1LoJD0GczzjXTxjHq7j43K/Ucc7J07N
         /T8M7u9SSX2dC1wxkylvNVAaEV21EFnFFUg9hVEp2dPyi2C4gmII2Na3uJhIeOhcvik+
         suQheC48KkYjXO9ht32iBrWY5zMNStb7YZh7p6/TO3FsUr0JII5JTkg8mgpaglK/b+Av
         Hpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684551351; x=1687143351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdSvKOAXL7sdlLkGjTnnuwOA/VbKrzGOIijIH+Tf82k=;
        b=e5dxbJu5R6yOl24TzXLYiPwYtdyRcNE8uQYX78tOL2oQnfOeqiMYL5emzGSCZPBU/2
         0z6O55XQgc8jbcgGgJW7SNJZxo7bgHIsYaXrO/2+zI0AeSJEuxv9zHONpNwCREuCVNdO
         Jm6HWxJs9CCHKQg0jbdk2UXU0o82HIl8q0hmM5EPjSP/xrJZHQbz4eZ7XDFKZ6bLOyjs
         BXQaRttrhE9syU986VsDYl5q363o3C7wmEDL2m2pFNISL5iZ6Fk02fQC84FzfQV1DKxQ
         GKnJ/ieFkQimW2//UMLsHaGhCBGW0OyjKW3TVcveRnZCtYBiPkQgfUs0V7Deu6e4rF6a
         16bg==
X-Gm-Message-State: AC+VfDxlRBNMBEWP+VSGHuB4YQztw5eCEAA+LGdIOQf5+xbrfRimPoER
        PYioZlUglcwSAaKp31w145PK7w==
X-Google-Smtp-Source: ACHHUZ6RpF/8FxxuZkieXS5msDgwv84HNNcHwRibxyaBrbA0VudSU3lWns+f544SUGcVsGNFXYsn6Q==
X-Received: by 2002:a17:903:18b:b0:1ac:8be5:8787 with SMTP id z11-20020a170903018b00b001ac8be58787mr4699376plg.21.1684551351025;
        Fri, 19 May 2023 19:55:51 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001a95aef9728sm346100plg.19.2023.05.19.19.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:55:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qi Liu <liuqi115@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/5] perf parse-regs: Refactor arch related functions
Date:   Sat, 20 May 2023 10:55:32 +0800
Message-Id: <20230520025537.1811986-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register parsing have two levels: one level is under 'arch' folder,
another level is under 'util' folder.  A good design is 'arch' folder
handles architecture specific operations and provides APIs for upper
layer, on the other hand, 'util' folder should be general and simply
calls APIs to talk to arch layer.

The current code mixes these two layers, e.g. util/perf_regs.h includes
architecture's perf_regs.h, so it implicitly couples with specific
architecture during building time.  Furthermore, util/perf_regs.c
includes all architectures' perf_regs.h, this is easily to cause conflict
due to duplicated definitions from any two different archs.

So this patch series is to refactor arch related functions for register
parsing:

Firstly, it creates a new folder util/perf-regs-arch and uses dedicated
source file for every arch, note, all of these source files will be
built in tool to support cross analysis (e.g. we can run perf on x86
machine for parsing aarch64's perf data file).

Secondly, rather than directly referring macros, we introduce new
functions, these functions are provided by architecture and then will be
invoked by perf common code.  At the end, we can generalize the register
parsing in 'util' folder.

This patch series has been compiled successfully on my Arm64 and x86
machine.


Leo Yan (5):
  perf parse-regs: Refactor arch register parsing functions
  perf parse-regs: Introduce functions arch__reg_{ip|sp}()
  perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
  perf parse-regs: Remove PERF_REGS_{MAX|MASK} from common code
  perf parse-regs: Move out arch specific header from util/perf_regs.h

 tools/perf/arch/arm/include/perf_regs.h       |   3 -
 tools/perf/arch/arm/util/perf_regs.c          |  21 +
 tools/perf/arch/arm/util/unwind-libdw.c       |   1 +
 tools/perf/arch/arm64/include/perf_regs.h     |   3 -
 tools/perf/arch/arm64/util/machine.c          |   1 +
 tools/perf/arch/arm64/util/perf_regs.c        |  16 +
 tools/perf/arch/arm64/util/unwind-libdw.c     |   1 +
 tools/perf/arch/csky/include/perf_regs.h      |   3 -
 tools/perf/arch/csky/util/perf_regs.c         |  21 +
 tools/perf/arch/csky/util/unwind-libdw.c      |   1 +
 tools/perf/arch/mips/include/perf_regs.h      |   2 -
 tools/perf/arch/mips/util/perf_regs.c         |  21 +
 tools/perf/arch/powerpc/include/perf_regs.h   |   3 -
 tools/perf/arch/powerpc/util/perf_regs.c      |  16 +
 tools/perf/arch/powerpc/util/unwind-libdw.c   |   1 +
 tools/perf/arch/riscv/include/perf_regs.h     |   3 -
 tools/perf/arch/riscv/util/perf_regs.c        |  21 +
 tools/perf/arch/riscv/util/unwind-libdw.c     |   1 +
 tools/perf/arch/s390/include/perf_regs.h      |   3 -
 tools/perf/arch/s390/util/perf_regs.c         |  21 +
 tools/perf/arch/s390/util/unwind-libdw.c      |   1 +
 tools/perf/arch/x86/include/perf_regs.h       |   2 -
 tools/perf/arch/x86/util/perf_regs.c          |  16 +
 tools/perf/arch/x86/util/unwind-libdw.c       |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |   2 +-
 tools/perf/util/perf-regs-arch/Build          |   8 +
 .../util/perf-regs-arch/perf_regs_aarch64.c   |  86 +++
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  50 ++
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  90 +++
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  77 +++
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 135 ++++
 .../util/perf-regs-arch/perf_regs_riscv.c     |  82 +++
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  86 +++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  88 +++
 tools/perf/util/perf_regs.c                   | 646 +-----------------
 tools/perf/util/perf_regs.h                   |  18 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind.h                      |   4 +-
 39 files changed, 887 insertions(+), 671 deletions(-)
 create mode 100644 tools/perf/util/perf-regs-arch/Build
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_arm.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_csky.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_mips.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_riscv.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_s390.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_x86.c

-- 
2.39.2

