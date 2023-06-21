Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6A739309
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFUXhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFUXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:37:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E23E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:37:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eb03457cso3070801b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687390631; x=1689982631;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LviLme9+lgOUUr9nBLWzIIut7py+TszGrdRA5x2MLw4=;
        b=SRyBK+yXuStGTaQoKiMa6SdpdRAjVO1vzCexqILiXgxFArocs7JGb6OIEP2oHHgwGp
         Wtj+XBft+r/OgiawqDMfDaFciwhGd6hWCLd5mBR7xdjVuuY0bs/dDZ/zP0YiSsEv2qyg
         JDJerwkTSFfeolNwA50bpeajGz/5aYYcBuMvNEdLeV1SiiCn1lvzLV8Qbhqcr9jfQvbU
         yclePpz6cSpAfInKAjGUUQLzAc5qigx0DoMHjhZ8eN/ykgTxGoj4fc+C4um9NeWgMlHf
         SBa8PnaExaa0KtKJB/Mn3uJA6kCjw9WZJqSgmC383N9phI5yqplFC56ZMJE20a5OkYNV
         vRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687390631; x=1689982631;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LviLme9+lgOUUr9nBLWzIIut7py+TszGrdRA5x2MLw4=;
        b=akRhFoJNok4BgWByUMBUUHDrAscZ2KTDGIFiuEb8bZtBNg5FYTNyaeP6F92iftfRNu
         v8h5QdXem+6/j1GkmKz2kqLOAyV/O19NaJGZVsEOk4nHDEaBPd1WQROugZQpDYy3szGi
         XT2IOWBaMvR7UrFStabtSkZZ5njQNSJ4n6uP8OVGKpEI4nAC8zP310aBFQPTav6qbxHX
         wJFUAF2lnV43IK5/QPnmqlArYbGIk62KUNXdm11L2b4Lhp7vr8L2NHOmE3IIxY+QYjqR
         vqnC8fcR19R4+Xc2zUhVVxIVaT+ggZkI2zkWZ19LlWUBanGIVxL3AsSMNpBaVHMOVJ/b
         /lgA==
X-Gm-Message-State: AC+VfDxKVre0EUT5acOe86t7vnrbu4SR9Jb37oD1ypkHqcAhJXLWZrjJ
        s4G0SOuIFvx2Nh/YP6xXdQGbNA==
X-Google-Smtp-Source: ACHHUZ7CM2aeTFo7hwLz+bGNEMYFQlMCEfUHBJMJQWjk2y2P70n0MdfO1gwLnC0WcHlGXINZ9OQvgQ==
X-Received: by 2002:a05:6a20:1596:b0:10b:e54f:1c00 with SMTP id h22-20020a056a20159600b0010be54f1c00mr13663409pzj.57.1687390630512;
        Wed, 21 Jun 2023 16:37:10 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b061dcdb6bsm4020245plf.28.2023.06.21.16.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:37:09 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:37:09 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jun 2023 16:36:18 PDT (-0700)
Subject:     Re: [PATCH v2 00/10] riscv: Allow userspace to directly access perf counters
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
CC:     corbet@lwn.net, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, robh@kernel.org,
        ajones@ventanamicro.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-5074ab93-a879-4b1c-8f39-0f59b7e0f4f4@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
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

On Fri, 12 May 2023 01:53:11 PDT (-0700), alexghiti@rivosinc.com wrote:
> riscv used to allow direct access to cycle/time/instret counters,
> bypassing the perf framework, this patchset intends to allow the user to
> mmap any counter when accessed through perf. But we can't break the
> existing behaviour so we introduce a sysctl perf_user_access like arm64
> does, which defaults to the legacy mode described above.
>
> *Note* that there are still ongoing discussions around which mode should
> be the default mode with distro people.
>
> base-commit-tag: v6.3
>
> Changes in v2:
> - Split into smaller patches, way better!
> - Add RB from Conor
> - Simplify the way we checked riscv architecture
> - Fix race mmap and other thread running on other cpus
> - Use hwc when available
> - Set all userspace access flags in event_init, too cumbersome to handle sysctl changes
> - Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming pmu driver
> - Fixed kernel test robot build error
> - Fixed documentation (Andrew and Bagas)
> - perf testsuite passes mmap tests in all 3 modes
>
> Alexandre Ghiti (10):
>   perf: Fix wrong comment about default event_idx
>   include: riscv: Fix wrong include guard in riscv_pmu.h
>   riscv: Make legacy counter enum match the HW numbering
>   drivers: perf: Rename riscv pmu driver
>   riscv: Prepare for user-space perf event mmap support
>   drivers: perf: Implement perf event mmap support in the legacy backend
>   drivers: perf: Implement perf event mmap support in the SBI backend
>   Documentation: admin-guide: Add riscv sysctl_perf_user_access
>   tools: lib: perf: Implement riscv mmap support
>   perf: tests: Adapt mmap-basic.c for riscv
>
>  Documentation/admin-guide/sysctl/kernel.rst |  24 ++-
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/riscv/kernel/perf_event.c              |  74 ++++++++
>  drivers/perf/riscv_pmu.c                    |  41 ++++
>  drivers/perf/riscv_pmu_legacy.c             |  37 +++-
>  drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
>  include/linux/perf/riscv_pmu.h              |  10 +-
>  include/linux/perf_event.h                  |   3 +-
>  tools/lib/perf/mmap.c                       |  65 +++++++
>  tools/perf/tests/mmap-basic.c               |   4 +-
>  10 files changed, 435 insertions(+), 21 deletions(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c

It looks like there's a handful of outstanding review comments, so I'm 
going to mark this as changes requested in patchwork -- sorry if I 
missed a v3.
