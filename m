Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2A6E126A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDMQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDMQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:36:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C014697
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:36:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso104305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681403795; x=1683995795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Luz0Qw0w9ZqnvhFtzZjcXX6GzM1RqYDZy0O1Aw36Dho=;
        b=KJY7IATIbGi514kJ7FRgfvPH9tgEmqo9KPyiQPUGil2KvhdD62ffqRe6SWY/E8f+nR
         S9h5/DMAAqtdcMbcCeInOxViyL44v/SfjGY6qWFOHzFeQ/KkU+AtC+3VOuya8yMueOK9
         xZPJCTNC90XXxwGYH39hDdxdpNWd2Tnj2RPHh0Z6v55AXv5V54kc0pZeC0gRamAwz8EC
         hPjPXG1ofsaZd7/0LBlKWDFKWTAL0E852Y7mm9gmvneulSccFEuR4lR3/0PAFq7GHqQl
         5VdAaFoTnOFCtQ7EOYfeSlNF8bM2FS2qbo7GwRxiK1+KUN2v6u1R1rlEwUaOf38EV0D9
         3Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681403795; x=1683995795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Luz0Qw0w9ZqnvhFtzZjcXX6GzM1RqYDZy0O1Aw36Dho=;
        b=AxgvRCFrkM5vNtYKemyB8lJ9DxLfO2AeIzUQPKnTypWBNnVokICSm+uVPvWwLQxhHr
         lFzi5CwNDkx64moi0XyxB+3yV5CHnpN2/jNBrEYm5xFjyKaOljqaWLlZg2V0DNPmLIml
         Aq+ZwEFARP3JlLqYsJeP+9ejOpU1RfyzAIr37SqdrB1xTL3ijlCGlsVKO9I4gTetHdU7
         lNf5L3OnqjXMYez3Z2f5wKRvbo0jqWYAB65TDFyuAG4UbZF3GtXRMe1x2qfFJS1tynZl
         RbF+HjNCttd/x9hJHRFYeDcDGgftsqfiz8eNmM9EZ2NFme0GX1AXZef0A3gDgJ38/cvc
         iu+A==
X-Gm-Message-State: AAQBX9dm4z3R3NwJ100BxdtHJx9KiXBme1RV3IKtqYgrdLgwEb7lSJ35
        sYMN+CubaX7sZanJMd8ICSD/+Sd0BawVPlJhwz+mwA==
X-Google-Smtp-Source: AKy350ZSieiPnZr/0KXmH0IDRFEF/xE3INgqlezSfSLD/+T+SJfaTt5JUaP752jfm5RWRYGlsgxizNdw/mr0/RvNokw=
X-Received: by 2002:a05:600c:5405:b0:3df:f3cb:e8ce with SMTP id
 he5-20020a05600c540500b003dff3cbe8cemr709159wmb.7.1681403795029; Thu, 13 Apr
 2023 09:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
In-Reply-To: <20230413161725.195417-1-alexghiti@rivosinc.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 09:36:23 -0700
Message-ID: <CAP-5=fW3wf8wQ2DyQbKnbsKJhZSdjomxnEp6GGF4Ar7qykZTjQ@mail.gmail.com>
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, paranlee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 9:17=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> riscv used to allow direct access to cycle/time/instret counters,
> bypassing the perf framework, this patchset intends to allow the user to
> mmap any counter when accessed through perf. But we can't break the
> existing behaviour so we introduce a sysctl perf_user_access like arm64
> does, which defaults to the legacy mode described above.
>
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

Presumably the test also needs patching:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/tests/mmap-basic.c?h=3Dperf-tools-next#n287

Thanks,
Ian


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
