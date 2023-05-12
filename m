Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93567002FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjELIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbjELIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:53:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360BF8A4D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:53:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f315735514so312533045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881632; x=1686473632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUKnEzldAU5lVuG/jDXiwAN3hvqenQj1jlly6nl0Ii8=;
        b=MSFrF7b5hiO1ul3GJrXQGuAvBJZJjaxiZFm1B1nXYPy8Es1boj6Hg/UQTy0zngEWOf
         Hb6LMVmocFr2ebzFjeyGNAcGUgjlX/5LylebVGWKHj7CQcp6H32YRmIgUls62+6VFvdj
         0u/qcXaZ4FxgdRpeFM9PDSawxPeUenA5ZbKsI5axxJdnK4G023jROUWI6yJPz5r66sVd
         uUVQBgdQTf7bQHZRM1233MUCbAqwD8tnKjFwWiYXwEXLXTaIkPMARsPAOkXrBxWv29U9
         lBW8XXEZBgeJEMZFp341SW2ij8IB5Ln5tZwk1SsXjMSALbX1Ie4lPdLt5RX4d6UD9/84
         d9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881632; x=1686473632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUKnEzldAU5lVuG/jDXiwAN3hvqenQj1jlly6nl0Ii8=;
        b=gf6a1V+rAD5RzmuH6AwUrZ/6tI/9NaQvimGrh4pQ4Qx29snjsHVn+5uQTK3uL7Vjoi
         0AR1sIDZPsKKD0FFDOJggiF03QsQBlACfSpQY0FpJZPs01RZDzcLWrfFx20u99VvLeng
         ym4khSAb8HOr9AovMh9AZHOsHCvP6HKUjINDlBpNNSrPXT6nD7TX1w8Umjw20oNCOqBM
         ynePjt2Ya8GAoPpHtk/+gv/OhDKbVRmzHH8xlzCX/Bb2lH+d4Cna9b7lQ8zmTFw6nJGF
         8ThkvlIK1fI6VNhFU3t3ZI41G28ROKB8IWukAGBi8r3FLExLaK3L4IYimauU1lXwmGeS
         51gA==
X-Gm-Message-State: AC+VfDyAM0rYY9OvwgzQUoSvITZceowhrTuH+NKnNH1COj3NTPy7GGYV
        xxM3fh8GpCHVioENkiHCJ0TXMA==
X-Google-Smtp-Source: ACHHUZ6W5V7VU85NsIxu7FyCdJpo6FpNmv3LzOAktwEO7Ge0/BrFJAB/8b/RIFvFh0YGBU1HKaD2lw==
X-Received: by 2002:adf:e904:0:b0:306:2d81:341d with SMTP id f4-20020adfe904000000b003062d81341dmr21035750wrm.24.1683881632684;
        Fri, 12 May 2023 01:53:52 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003f42461ac75sm15015618wml.12.2023.05.12.01.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:53:52 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 00/10] riscv: Allow userspace to directly access perf counters
Date:   Fri, 12 May 2023 10:53:11 +0200
Message-Id: <20230512085321.13259-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv used to allow direct access to cycle/time/instret counters,
bypassing the perf framework, this patchset intends to allow the user to
mmap any counter when accessed through perf. But we can't break the
existing behaviour so we introduce a sysctl perf_user_access like arm64
does, which defaults to the legacy mode described above.

*Note* that there are still ongoing discussions around which mode should
be the default mode with distro people.

base-commit-tag: v6.3

Changes in v2:
- Split into smaller patches, way better!
- Add RB from Conor
- Simplify the way we checked riscv architecture
- Fix race mmap and other thread running on other cpus
- Use hwc when available
- Set all userspace access flags in event_init, too cumbersome to handle sysctl changes
- Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming pmu driver
- Fixed kernel test robot build error
- Fixed documentation (Andrew and Bagas)
- perf testsuite passes mmap tests in all 3 modes

Alexandre Ghiti (10):
  perf: Fix wrong comment about default event_idx
  include: riscv: Fix wrong include guard in riscv_pmu.h
  riscv: Make legacy counter enum match the HW numbering
  drivers: perf: Rename riscv pmu driver
  riscv: Prepare for user-space perf event mmap support
  drivers: perf: Implement perf event mmap support in the legacy backend
  drivers: perf: Implement perf event mmap support in the SBI backend
  Documentation: admin-guide: Add riscv sysctl_perf_user_access
  tools: lib: perf: Implement riscv mmap support
  perf: tests: Adapt mmap-basic.c for riscv

 Documentation/admin-guide/sysctl/kernel.rst |  24 ++-
 arch/riscv/kernel/Makefile                  |   2 +-
 arch/riscv/kernel/perf_event.c              |  74 ++++++++
 drivers/perf/riscv_pmu.c                    |  41 ++++
 drivers/perf/riscv_pmu_legacy.c             |  37 +++-
 drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
 include/linux/perf/riscv_pmu.h              |  10 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  65 +++++++
 tools/perf/tests/mmap-basic.c               |   4 +-
 10 files changed, 435 insertions(+), 21 deletions(-)
 create mode 100644 arch/riscv/kernel/perf_event.c

-- 
2.37.2

