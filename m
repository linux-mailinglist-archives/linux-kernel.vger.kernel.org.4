Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68474373D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjF3IcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjF3Ibs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:31:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665583588
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:31:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31114b46d62so1809963f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688113899; x=1690705899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7xu9e/8zpZngb/8IehgWdJUCcpoeDVm3vpzs3Qy7mo=;
        b=H865ZtJHjbuc6MuFVYa6SgB+ccoXiHGJQIfADr+zwMK/j+TvVpF9r811O5KdXbAu5+
         8rnETbuyrAMsXoADgBZsmqyWAJr2v0SEQYshs1SJYhCXKgyoO6o3PJr4ldpS8G81FyDD
         5pJH5cSvZ1+TDWcK6vDQAbBn+F15tFvNuOhYAQrzT4I29Y6oNdLKn4cLGQ+ogAC/S4FO
         VTT6g+Rr36ezXTugl0LhtdCY68hxlgD8P8RQc//MOZj5goxL8G/fFJl97Hi8BBomykLL
         ifR/3V7HCfdYcA93pumIwoaa/E8SI7eQ7OroZqiDb/jdJyXWhiTW+FiT0P9QtP8R7EOe
         vpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113899; x=1690705899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7xu9e/8zpZngb/8IehgWdJUCcpoeDVm3vpzs3Qy7mo=;
        b=fQndb3zgHTwMIT91NBlqeqrORrRdkq9zCgRE1j3Vdja+ElI2doZJl3JvVP7Yaglb+L
         eWD6kHKKlKpQtk3Vchh1j6POzcOe5bjEezQqg7g5jpAA4K707/WwYRpWegZfDuK+PNGt
         x68FbjKricUX2Ovdk2/8fGtbQGA4YYkKxZhVQdBWq/AzgXpMucrsNOPdeApMHx/pic+B
         N0UgEq5oBG4hWRkS1S0Q1mbNFgBRRTMUdK6T9Mes0KW5Hp/03pZQ96R67qd8gdGHHZJy
         Pj0bzNTxh4dnBoWkfpOz5jwb6zNjiiIkMVGMQNy1ekKN24uJEMwZlPdVPmG36iy7JBNi
         nXWQ==
X-Gm-Message-State: ABy/qLYCXmHdibgiKfomQPKuHEUNvKQxti2pp07a9sTtwye+uXD3W4bD
        CvU6KaZBlz99qUe50URmkWU6ig==
X-Google-Smtp-Source: APBJJlF2cVmZSXyEpZo5Wr+x3JPdjgQAG++Uz1dQG5lH+T/9n8SPtY5CQ+JHQXWfIJwLUbsOsOGQcg==
X-Received: by 2002:adf:f60c:0:b0:313:e741:1caa with SMTP id t12-20020adff60c000000b00313e7411caamr1823926wrp.25.1688113898731;
        Fri, 30 Jun 2023 01:31:38 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600004cf00b0030e52d4c1bcsm17976111wri.71.2023.06.30.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:31:38 -0700 (PDT)
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
Subject: [PATCH v3 00/10] riscv: Allow userspace to directly access perf counters
Date:   Fri, 30 Jun 2023 10:30:03 +0200
Message-Id: <20230630083013.102334-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This version needs openSBI v1.3 *and* a fix that went upstream lately
(https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/).

**Important**: In this version, the default mode is now user access, not
the legacy so some applications will break.

base-commit-tag: v6.4-rc6

Changes in v3:
v3:
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

 Documentation/admin-guide/sysctl/kernel.rst |  26 ++-
 drivers/perf/riscv_pmu.c                    | 113 +++++++++++
 drivers/perf/riscv_pmu_legacy.c             |  28 ++-
 drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
 include/linux/perf/riscv_pmu.h              |  12 +-
 include/linux/perf_event.h                  |   3 +-
 tools/lib/perf/mmap.c                       |  65 +++++++
 tools/perf/tests/mmap-basic.c               |   4 +-
 8 files changed, 427 insertions(+), 20 deletions(-)

-- 
2.39.2

