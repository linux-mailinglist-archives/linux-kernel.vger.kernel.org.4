Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5364745C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGCMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGCMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:46:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BAAE55
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:46:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143493728dso1482437f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388409; x=1690980409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3esyTGxR5HzfntvVEnk0cHCSfI5jcE3Wdz4OJHbrixc=;
        b=eHdRCE7SKddx65rlZ6Z+z5xxWmjSzJ+3wYdtEfQhxeEekg0qTrO8ce+QfOdAT8bkmV
         jyvZeVnPEAKgew/05zKX7xv+iTyYZdsbqHFIt+mLCdCY/wQIxa3skpYy9sZ7MDrdOG6L
         eAtmj1tlZ14HBCDYUT8MlBSOv+Dw9i+eUi3gVe8yTfjXg1fmEpL2+NWkFvKNQVN/c6TM
         mCXWgO922hYAJ8XyWezmnyC8tCGV/t3D8TcCZGZ5aL0cvVWbKnuEJWANYgDN8dNphWrA
         NjkabDHZPl0dKqScouF09MLcgyN589MPRi1h+S0JOVUyBybA3fwZSVbMqU2reVjETyf+
         I5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388409; x=1690980409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3esyTGxR5HzfntvVEnk0cHCSfI5jcE3Wdz4OJHbrixc=;
        b=RSjBMExFSFs40eofUCzzZwwB1EMs11Gdj1JmxjJu8xCosqwIkcJWqiNopGEbPEASAo
         HMjAHdA1GvJKct3gRHqIAIVAmhHMrWxvHGrQu/WlotNa7NNENzaN3wzQR4lVOWMe7G3T
         GXo+5RP/NmLcPs9+BuDvTqxhyy0NzQzxL0E+20CpxmEgEUO85KmjLOxWhj1swoRMMRHj
         Uo+U5tVgILAoOevaO0W3VqLEcVi103DZNbyTlFbp6rnnMBH1v7tXXiHmIAXwTPcx2K+M
         q09HK3N21Fz1YcsH1yJ2G1RGSTPOQfIdMQohJLrkn1uGY1BK7xMx8CHN4vO0ub9CvBoR
         FTGA==
X-Gm-Message-State: ABy/qLbTf/ZX6P5iPsfbWwwzhzLkJJ83vVpoNoocCQVDGMQNfgbeIwyl
        9n5Ial0OisVha8uOalzaf1/Jqw==
X-Google-Smtp-Source: APBJJlFrFuBiZjNSe9zq9ulQrBBuUb7W+cGnwH9J6bQCFfypbOu454a/7WsKhHuf8T47XcRPHgisLw==
X-Received: by 2002:a5d:448c:0:b0:314:2735:dc13 with SMTP id j12-20020a5d448c000000b003142735dc13mr7066984wrq.47.1688388409379;
        Mon, 03 Jul 2023 05:46:49 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6504000000b003143bb5ecd5sm483474wru.69.2023.07.03.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:46:48 -0700 (PDT)
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
Subject: [PATCH v4 00/10] riscv: Allow userspace to directly access perf counters
Date:   Mon,  3 Jul 2023 14:46:37 +0200
Message-Id: <20230703124647.215952-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
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

This version needs openSBI v1.3 *and* a kernel fix that went upstream lately
(https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/).

**Important**: In this version, the default mode is now user access, not
the legacy so some applications will break.

base-commit-tag: v6.4-rc6

Changes in v4:
- Fixed some nits in riscv_pmu_sbi.c thanks to Andrew
- Fixed the documentation thanks to Andrew
- Added RB from Andrew \o/

Changes in v3:
- patch 1 now contains the ref to the faulty commit (no Fixes tag as it is only a comment), as Andrew suggested
- Removed RISCV_PMU_LEGACY_TIME from patch 3, as Andrew suggested
- Rename RISCV_PMU_PDEV_NAME to "riscv-pmu-sbi", patch4 is just cosmetic now, as Andrew suggested
- Removed a few useless (and wrong) comments, as Andrew suggested
- Simplify arch_perf_update_userpage code, as Andrew suggested
- Documentation now mentions that time CSR is *always* accessible, whatever the mode, as suggested by Andrew
- Removed CYCLEH reference and add TODO for rv32 support, as suggested by Atish
- Do not rename the pmu instance as Atish suggested
- Set pmc_width only if rdpmc is enabled and CONFIG_RISCV_PMU is set and the event is a hw event
- Move arch_perf_update_userpage https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/
- **Switch to user mode access by default**

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
  drivers: perf: Rename riscv pmu sbi driver
  riscv: Prepare for user-space perf event mmap support
  drivers: perf: Implement perf event mmap support in the legacy backend
  drivers: perf: Implement perf event mmap support in the SBI backend
  Documentation: admin-guide: Add riscv sysctl_perf_user_access
  tools: lib: perf: Implement riscv mmap support
  perf: tests: Adapt mmap-basic.c for riscv

 Documentation/admin-guide/sysctl/kernel.rst |  27 ++-
 drivers/perf/riscv_pmu.c                    | 113 +++++++++++
 drivers/perf/riscv_pmu_legacy.c             |  28 ++-
 drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
 include/linux/perf/riscv_pmu.h              |  12 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  65 +++++++
 tools/perf/tests/mmap-basic.c               |   4 +-
 8 files changed, 428 insertions(+), 20 deletions(-)

-- 
2.39.2

