Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD67234B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjFFBq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjFFBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:46:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645210F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:46:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-543a6cc5f15so1839307a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686015985; x=1688607985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PndMKVa+Er1qdCOJiafxXClL6d1Yt+58ItU6tFuigm0=;
        b=Hh64hU1z+qXcJKy0p3CJpPMRxoO4gff0IpJVXMTII+Hqst8/7/Hj+tN4ff3SNGPMWJ
         nT3Lh6BuKSHhe7CAAlH4XFMJDJh9sHp4seEA7HPgApSFVVhplkAIpg9u7Zp8pnk4ci0V
         Vj4ffA3Twz2FgLgoRmz7kAF51Bul23/4EA9/UUCGv5LVkFEDOsCUbB25+CjBWwaFgA+S
         or+82PZ2XQjX8gz+XrtRnYLHeju1Se8ZCbwd8tpa3RBQefL78+IqoMl6GuKicT5H75cd
         ima2n6KE3iSqdyxMeI4Fjigz/vF9bIyocKGQTGr+tOh3YpggnUaj5TT2xaTdx8nEBuLv
         AZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686015985; x=1688607985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PndMKVa+Er1qdCOJiafxXClL6d1Yt+58ItU6tFuigm0=;
        b=fX+NXoNCanuR5qmO+NfkmZrQT+v8y8CBeg5NmH0amJRSIhsNzv3tkiLaBPea2SXXsL
         tcut2Yc8HgpNqXeZp1wW+qGA3viUTEWn8f/D1fe2wrIFaTNQfTzDXUQpqOzdjQtR1R/P
         6xuCj6J//MvDYsSX33cYafrElmytlnWcUyvVjLHYhXrnTBWzIFIrvhvABmM2jGpozSP/
         CqZxFLs3Ha/LRAcXP++14xGJxYgp0XpmjvKfHcolPZJvqxZxEyyEdaQcUSn8v7xw/AgM
         8Yx6kgsBQ0u+/jze6MTmU/zr36kvz7BPKm/pz+QKp48WH6P/TtKSG6+ugOemqHZTrpuW
         moOQ==
X-Gm-Message-State: AC+VfDwk/c/S/ynUdwejYx1KDp5IseyPjGHArIDOM1OgFqsKXWJf/V/M
        xpAorQllCGik+5Nhjfd5sPvnOg==
X-Google-Smtp-Source: ACHHUZ4wpMb9zmn0oxmXwR0j3PDi+Kimi9DJ1y8WGup9FRsXEKDHRsM3AuBwTtE0VRxEQZaVWZmQIQ==
X-Received: by 2002:a17:903:1111:b0:1af:c1a7:3bb5 with SMTP id n17-20020a170903111100b001afc1a73bb5mr925280plh.4.1686015984705;
        Mon, 05 Jun 2023 18:46:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([240e:389:8603:ad00:6600:a29f:6ab:1788])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001a64851087bsm7197805plq.272.2023.06.05.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:46:24 -0700 (PDT)
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
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Date:   Tue,  6 Jun 2023 09:45:53 +0800
Message-Id: <20230606014559.21783-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to refactor arch related functions for register
parsing, which follows up the discussion for v1:
https://lore.kernel.org/lkml/20230520025537.1811986-1-leo.yan@linaro.org/

Compared to patch series v1, this patch series introduces new functions
perf_arch_reg_{ip|sp}(), so this can allow the tool to support cross
analysis.

To verify the cross analysis, I used below steps:

- Firstly, I captured perf data on Arm64 machine:

  $ perf record --call-graph fp -- ./test_program

  Or ...

  $ perf record --call-graph dwarf -- ./test_program

  Then, I also archived associated debug data:

  $ perf archive

- Secondly, I copied the perf data file and debug tar file on my x86
  machine:

  $ scp perf.data perf.data.tar.bz2 leoy@IP_ADDRESS:/target/path/

- On x86 machine, I need to build perf for support multi-arch unwinding:

  $ git clone http://git.savannah.gnu.org/r/libunwind.git
  $ cd libunwind
  $ autoreconf -i

  # Build and install libunwind aarch64:
  $ ./configure prefix=/home/leoy/Work/tools/libunwind/install/ \
	--target=aarch64-linux-gnu CC=x86_64-linux-gnu-gcc
  $ make && make install

  # Build and install libunwind x86:
  $ ./configure prefix=/home/leoy/Work/tools/libunwind/install/ \
	--target=x86_64-linux-gnu CC=x86_64-linux-gnu-gcc
  $ make && make install

- Build perf tool for support multi-archs:

  $ cd $LINUX/tools/perf
  $ make VF=1 DEBUG=1 LIBUNWIND_DIR=/home/leoy/Work/tools/libunwind/install

At the end, I verified the x86 perf tool can do cross analysis for aarch64's
perf data file.

Note, I still see x86 perf tool cannot display the complete callgraph
for aarch64, but it should not the issue caused by this series, which
will be addressed by separate patches.

I also built this patch series on my Arm64 and x86 machines, both can
compile perf tool successfully; but I have no chance to build other
archs natively.

Changes from v1:
- For support cross analysis for IP/SP registers, introduced patch 0002
  (James Clark, Ian Rogers).


Leo Yan (6):
  perf parse-regs: Refactor arch register parsing functions
  perf parse-regs: Introduce functions perf_arch_reg_{ip|sp}()
  perf unwind: Use perf_arch_reg_{ip|sp}() to substitute macros
  perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
  perf parse-regs: Remove PERF_REGS_{MAX|MASK} from common code
  perf parse-regs: Move out arch specific header from util/perf_regs.h

 tools/perf/arch/arm/include/perf_regs.h       |   3 -
 tools/perf/arch/arm/util/perf_regs.c          |  11 +
 tools/perf/arch/arm/util/unwind-libdw.c       |   1 +
 tools/perf/arch/arm64/include/perf_regs.h     |   3 -
 tools/perf/arch/arm64/util/machine.c          |   1 +
 tools/perf/arch/arm64/util/perf_regs.c        |   6 +
 tools/perf/arch/arm64/util/unwind-libdw.c     |   1 +
 tools/perf/arch/csky/include/perf_regs.h      |   3 -
 tools/perf/arch/csky/util/perf_regs.c         |  11 +
 tools/perf/arch/csky/util/unwind-libdw.c      |   1 +
 tools/perf/arch/loongarch/include/perf_regs.h |   2 -
 tools/perf/arch/loongarch/util/perf_regs.c    |  11 +
 tools/perf/arch/loongarch/util/unwind-libdw.c |   1 +
 tools/perf/arch/mips/include/perf_regs.h      |   2 -
 tools/perf/arch/mips/util/perf_regs.c         |  11 +
 tools/perf/arch/powerpc/include/perf_regs.h   |   3 -
 tools/perf/arch/powerpc/util/perf_regs.c      |   6 +
 tools/perf/arch/powerpc/util/unwind-libdw.c   |   1 +
 tools/perf/arch/riscv/include/perf_regs.h     |   3 -
 tools/perf/arch/riscv/util/perf_regs.c        |  11 +
 tools/perf/arch/riscv/util/unwind-libdw.c     |   1 +
 tools/perf/arch/s390/include/perf_regs.h      |   3 -
 tools/perf/arch/s390/util/perf_regs.c         |  11 +
 tools/perf/arch/s390/util/unwind-libdw.c      |   1 +
 tools/perf/arch/x86/include/perf_regs.h       |   2 -
 tools/perf/arch/x86/util/perf_regs.c          |   6 +
 tools/perf/arch/x86/util/unwind-libdw.c       |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.c                       |   6 +-
 tools/perf/util/libunwind/arm64.c             |   2 -
 tools/perf/util/libunwind/x86_32.c            |   2 -
 tools/perf/util/perf-regs-arch/Build          |   9 +
 .../util/perf-regs-arch/perf_regs_aarch64.c   |  96 +++
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  60 ++
 .../perf/util/perf-regs-arch/perf_regs_csky.c | 100 +++
 .../util/perf-regs-arch/perf_regs_loongarch.c |  91 +++
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  87 ++
 .../util/perf-regs-arch/perf_regs_powerpc.c   | 145 ++++
 .../util/perf-regs-arch/perf_regs_riscv.c     |  92 +++
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  96 +++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  98 +++
 tools/perf/util/perf_regs.c                   | 772 ++----------------
 tools/perf/util/perf_regs.h                   |  49 +-
 tools/perf/util/unwind-libdw.c                |   7 +-
 tools/perf/util/unwind-libunwind-local.c      |   6 +-
 tools/perf/util/unwind.h                      |   8 -
 46 files changed, 1078 insertions(+), 766 deletions(-)
 create mode 100644 tools/perf/util/perf-regs-arch/Build
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_arm.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_csky.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_loongarch.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_mips.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_riscv.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_s390.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_x86.c

-- 
2.34.1

