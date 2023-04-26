Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D86EF575
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjDZNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjDZNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:25:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FAA211D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:25:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f95231618aso4526402f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682515525; x=1685107525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZR9L391ZZ1i3CUI64HooJraQbWqG1Z0kiKXyYBnLV8=;
        b=IgScv77IOmeBuDg7MO27c+W89ZsJjG2/mQdRspcZALfMHkzKgctDWDadfZGRCOAykh
         v0jw3z8VIZ0Gqe3sPz2uEz5lt5+XltjpPT5eLnqCvpKBTzmtCRSQIfXSvUc9D45aMvR/
         VHieQzz+Oso2FLbDsXtSaSNZN30YL11XQZff6eJc1AgFeVQLGKs2xS65VvYSMpeTRurr
         ecMgRF8OqngVkMDctVMx6acqgrCU/tsRajLc4GrK5aa5tSfIiESlesWdH+Nq1UCChOHJ
         Ly62ZLm/8HzwzvMirHA13DDn2TySBF0ZZa4C1Ir3C3BROkv8CQZu6ev+ncl38fXEJ5tY
         0QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515525; x=1685107525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZR9L391ZZ1i3CUI64HooJraQbWqG1Z0kiKXyYBnLV8=;
        b=Sa0lcFTOkk6JICye9E99ZgkeC3ph6X4mqJNeqM7DzeSNz9Nr0ZKzSmts5L7JPzUEpQ
         wq3VJJ1cFbtRatlZjXd/vf2eg/Tlwkd8Rcft8WdtBbMHpVYcacs6k4T6iXZh1Gj1/zZ2
         aOiDae5KxxNX361IiaVFGuJuxkWCj5jtjoxYu9p6obG7n2p8GdOEVno9RwKN0CdhAxQ7
         86XdyRdFr1nTnlYzUV+qWbP1wML0t4kL2m2K/9+S0lHUY8y4td5E7XxPgfTniH0eMbB4
         wi2Bpfi043o89lZQTUGW3jxjcqGp5mUcCYp4x7h+iYgiusTIlzs7O3i9MP8+2M09tRVo
         VGYQ==
X-Gm-Message-State: AAQBX9ccykrV4zTJh4sra5l95MN7djgzrlUQ+m1jEavbPlE2xIxHta7F
        wpi1i7qTQk2SJXS6WorP93LH1Q==
X-Google-Smtp-Source: AKy350YJruuYODuL8/CSU4Snpl13Z+MCt0qt3NCZ+fLdsBBbjWujOtb6atCud55m6xhicVClJBlw/g==
X-Received: by 2002:adf:e268:0:b0:2f5:9aa2:e5fc with SMTP id bl40-20020adfe268000000b002f59aa2e5fcmr14126507wrb.28.1682515524755;
        Wed, 26 Apr 2023 06:25:24 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id k24-20020a7bc318000000b003f16fc33fbesm18078994wmj.17.2023.04.26.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:25:24 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:25:23 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
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
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through
 perf
Message-ID: <3bwxedsrovutzhlmlnozeuvz4zqnr32kuef2mdzmnbniajh6vb@we6jzlwkfuof>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com>
 <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
 <CAHVXubh_y9Uw2xsgsQrVZEcb9bCLBLUCo74GOm-czsSawHxk4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubh_y9Uw2xsgsQrVZEcb9bCLBLUCo74GOm-czsSawHxk4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 03:17:01PM +0200, Alexandre Ghiti wrote:
> On Wed, Apr 26, 2023 at 2:57 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 06:17:25PM +0200, Alexandre Ghiti wrote:
> > > We used to unconditionnally expose the cycle and instret csrs to
> > > userspace, which gives rise to security concerns.
> > >
> > > So only allow access to hw counters from userspace through the perf
> > > framework which will handle context switchs, per-task events...etc. But
> > > as we cannot break userspace, we give the user the choice to go back to
> > > the previous behaviour by setting the sysctl perf_user_access.
> > >
> > > We also introduce a means to directly map the hardware counters to
> > > userspace, thus avoiding the need for syscalls whenever an application
> > > wants to access counters values.
> > >
> > > Note that arch_perf_update_userpage is a copy of arm64 code.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
> > >  arch/riscv/include/asm/perf_event.h         |   3 +
> > >  arch/riscv/kernel/Makefile                  |   2 +-
> > >  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
> > >  drivers/perf/riscv_pmu.c                    |  42 ++++++++
> > >  drivers/perf/riscv_pmu_legacy.c             |  17 +++
> > >  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++++--
> > >  include/linux/perf/riscv_pmu.h              |   3 +
> > >  tools/lib/perf/mmap.c                       |  65 +++++++++++
> > >  9 files changed, 322 insertions(+), 11 deletions(-)
> > >  create mode 100644 arch/riscv/kernel/perf_event.c
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > > index 4b7bfea28cd7..02b2a40a3647 100644
> > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > @@ -941,16 +941,31 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
> > >  The default value is 8.
> > >
> > >
> > > -perf_user_access (arm64 only)
> > > -=================================
> > > +perf_user_access (arm64 and riscv only)
> > > +=======================================
> > > +
> > > +Controls user space access for reading perf event counters.
> > >
> > > -Controls user space access for reading perf event counters. When set to 1,
> > > -user space can read performance monitor counter registers directly.
> > > +arm64
> > > +=====
> > >
> > >  The default value is 0 (access disabled).
> > > +When set to 1, user space can read performance monitor counter registers
> > > +directly.
> > >
> > >  See Documentation/arm64/perf.rst for more information.
> > >
> > > +riscv
> > > +=====
> > > +
> > > +When set to 0, user access is disabled.
> > > +
> > > +When set to 1, user space can read performance monitor counter registers
> > > +directly only through perf, any direct access without perf intervention will
> > > +trigger an illegal instruction.
> > > +
> > > +The default value is 2, it enables the legacy mode, that is user space has
> > > +direct access to cycle, time and insret CSRs only.
> >
> > I think this default value should be a Kconfig symbol, allowing kernels to
> > be built with a secure default.
> 
> Actually I was more in favor of having the default to 1 (ie the secure
> option) and let the distros deal with the legacy mode (via a sysctl
> parameter on the command line) as long as user-space has not been
> fixed: does that make sense?

Yes, I'd prefer that too. I assumed the default was 2 in this patch
because we couldn't set it to 1 for some reason.

Thanks,
drew
