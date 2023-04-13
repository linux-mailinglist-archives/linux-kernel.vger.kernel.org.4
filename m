Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AF6E1516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDMTSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDMTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:18:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3D93F6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:18:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-244acf4a2f5so739906a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1681413487; x=1684005487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8W8ucWRVnyg0FZIx99vKIcNt/oJO/XN1VRJ9eKQAS0=;
        b=ZxYcvj4mgxHEh2k4eyG7rDgq81XaIFxIPZwF1CNwFKsnRNpSJZw+7kJwHzSw5Rerxg
         CssT5oqe+UjzgcEwZvXxNyKQn0/GZ4F58sSMiEoWUuegeBhMohMF3Un9Q7ojGWs+cDtR
         w822ZznJii3RTd7ULjAmuDpwhubxc1//sSz5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413487; x=1684005487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8W8ucWRVnyg0FZIx99vKIcNt/oJO/XN1VRJ9eKQAS0=;
        b=BUHRxfyaC0BbNdCgPF8f8kiVbrpej9WcmVWcNL4Lhc3SOs3Y0P/l+qt7loWnLSr/fS
         bmYMNCcipImL+q/bXbuvWJaSlyOKpZylbeUWSsz0CqQD8OaXRAAoOGM3G7PESCoQBY53
         XdYxUvwvIXnS3CIK9ssqRauB4pEjUZynFyJiMV0QsbkjWg9YYKAjscXG72sWaPYei8FT
         ULL3/yL+cVipqT1bnrjxyfRCaqYEjBBUAErRHebv4fNBgrxah33pB9940PCQsyHh3ejh
         1U4NXO8KvL/S7Egep2fo1LyqckTvS2np7nCOYtXzOc8p2fmbSv6NlT/hS8VUklYiDtVd
         jodA==
X-Gm-Message-State: AAQBX9c4i3B+Boom/wu5nEBZUn9Jd6cHAbJY78wgMzVr0fDzITgrh79L
        ycSblJXNae6pfDSo6TphETYkQhFUzwjMrGYFBPdO
X-Google-Smtp-Source: AKy350bfGkRro00QQY4rqb+45vxFoI70kxyGbgpxd+11xoM2ikmW0Dhiadp9GZxwnHzh96oxN11shsrGP1raJr0DPsM=
X-Received: by 2002:a05:6a00:140b:b0:63b:1a20:5ea2 with SMTP id
 l11-20020a056a00140b00b0063b1a205ea2mr1782885pfu.1.1681413486955; Thu, 13 Apr
 2023 12:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
In-Reply-To: <20230413161725.195417-1-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Apr 2023 00:47:55 +0530
Message-ID: <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> riscv used to allow direct access to cycle/time/instret counters,
> bypassing the perf framework, this patchset intends to allow the user to
> mmap any counter when accessed through perf. But we can't break the
> existing behaviour so we introduce a sysctl perf_user_access like arm64
> does, which defaults to the legacy mode described above.
>

It would be good provide additional direction for user space packages:

The legacy behavior is supported for now in order to avoid breaking
existing software.
However, reading counters directly without perf interaction may
provide incorrect values which
the userspace software must avoid. We are hoping that the user space
packages which
read the cycle/instret directly, will move to the proper interface
eventually if they actually need it.
Most of the users are supposed to read "time" instead of "cycle" if
they intend to read timestamps.

The legacy sysctl option will be removed in the future. The plan is
that the distros will
set the default option to SYSCTL_USER_ACCESS which enables user
counters only through perf
sooner (as soon as they make sure the packages built for that distro
don't read cycle/instret) directly.

> The core of this patchset lies in patch 4, the first 3 patches are
> simple fixes.
>
> base-commit-tag: v6.3-rc1
>
> Alexandre Ghiti (4):
>   perf: Fix wrong comment about default event_idx
>   include: riscv: Fix wrong include guard in riscv_pmu.h
>   riscv: Make legacy counter enum match the HW numbering
>   riscv: Enable perf counters user access only through perf
>
>  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
>  arch/riscv/include/asm/perf_event.h         |   3 +
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
>  drivers/perf/riscv_pmu.c                    |  42 ++++++++
>  drivers/perf/riscv_pmu_legacy.c             |  24 ++++-
>  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++++--
>  include/linux/perf/riscv_pmu.h              |   9 +-
>  include/linux/perf_event.h                  |   3 +-
>  tools/lib/perf/mmap.c                       |  65 +++++++++++
>  10 files changed, 332 insertions(+), 17 deletions(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c
>
> --
> 2.37.2
>


--=20
Regards,
Atish
