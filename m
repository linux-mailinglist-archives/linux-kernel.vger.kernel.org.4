Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47271F99F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjFBFTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFBFT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:19:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA619A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:19:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f81396e435so15565391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 22:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685683164; x=1688275164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgn8PW+lCtxxCCTeMx5u+Sc8A20TKMpJWMc7H1tivLQ=;
        b=goyJbV+k8ZDKjx5UP87VtW2qDfzW2th2S9s3LONil/75+ZdNAefUeZzW/GeeLO/J6b
         djP+bt2+EwGXwubLGRlF2Eg9HaF1SAw705dSVETBr0UezW1Kp2O2plkx7zmlYf2eVB7o
         0UUYOIDCTEhOZi3E62zEgE1hG3Abzvzsna96nOyC1TmeIJ8+ZZNU3kGu3OrmO+lvYgKC
         tg7M53VUauyUBaxkusvEktOPY7kkxr6P66hLxK5DfVNv0iwdN7XEUW9/XVMvmcrewkYi
         hap84qFhpBWH2H3kTRYYGIkUdLe3JvxUu42zEVpONzXCCNvOM1HZI6AYFDGqD3UgC1Ur
         R9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685683164; x=1688275164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgn8PW+lCtxxCCTeMx5u+Sc8A20TKMpJWMc7H1tivLQ=;
        b=gpNmGhaAROJT6ZB00qsEtztKNZKDlWNLw7rMwBRykzbKlksQu3BD5zps5a294YTR3a
         wVz0EpepSGeZd7ta36wwbOY5oX3sxMPTQtZNKhOBOGDNORFf/eaSI6PtUKa4kTOmpN3a
         5dRlPotFxM1N3rsRQOAEitQNrv2v9xe/ZC1hsSz+AyUTs7F+5ATGNfgnyAZfVUCsYdhp
         f9EAsKjk9UlujMaMCfcDxtdS/8ng1mhJTVrSit5nVgaM6JMX+Eo5ZvwwdJRZr80ne6nu
         nZjKmZy41YHm/FMSBgeGET4cyVv40a9DZ2yJYYwsHBdwGG0lGy2zJYah9dN5jrLyq5a+
         oi3g==
X-Gm-Message-State: AC+VfDyFNcxel2doCtUxS7V+hbs6gTGztYW8Ndlt5EJKJMsamuQa4w13
        tdod3SiglX+P4GjRrPD62/p5WH9aEnSjf4xb4iVZYQ==
X-Google-Smtp-Source: ACHHUZ7hxeFd4p3Vb0f2BnoHsB8raEXkauuS5wAkuzImHWRJBMnDmk3UJTywWEbxRNWJlKcCLXh6nuh69+hsoHACs1g=
X-Received: by 2002:a05:622a:8e:b0:3f5:2582:65d9 with SMTP id
 o14-20020a05622a008e00b003f5258265d9mr14935822qtw.26.1685683163680; Thu, 01
 Jun 2023 22:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 2 Jun 2023 10:49:12 +0530
Message-ID: <CAFA6WYNEuZK9OCchj1Na-yZ08ahQe+B=iGCuytqXz5XhUie=gA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to
 use NMI for it
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Fri, 2 Jun 2023 at 03:07, Douglas Anderson <dianders@chromium.org> wrote:
>
> This is an attempt to resurrect Sumit's old patch series [1] that
> allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> could find was v7, so I started my series at v8. I haven't copied all
> of his old changelongs here, but you can find them from the link.
>
> I'm really looking for a way to land this patch series. In response to
> v8, Mark Rutland indicated [2] that he was worried about the soundness
> of pseudo NMI. Those definitely need to get fixed, but IMO this patch
> series could still land in the meantime. That would at least let
> people test with it.

+1

>
> Request for anyone reading this: please help indicate your support of
> this patch series landing by replying, even if you don't have the
> background for a full review. My suspicion is that there are a lot of
> people who agree that this would be super useful to get landed.
>

You can ofcourse count me in here. This will certainly bring NMI
debugging capabilities to arm64 and I have been advocating for that
since the advent of pseudo NMIs on arm64.

> Since v8, I have cleaned up this patch series by integrating the 10th
> patch from v8 [3] into the whole series. As part of this, I renamed
> the "NMI IPI" to the "debug IPI" since it could now be backed by a
> regular IPI in the case that pseudo NMIs weren't available. With the
> fallback, this allowed me to drop some extra patches from the
> series. This feels (to me) to be pretty clean and hopefully others
> agree. Any patch I touched significantly I removed Masayoshi and
> Chen-Yu's tags from.
>
> ...also in v8, I reorderd the patches a bit in a way that seemed a
> little cleaner to me.

This cleanup looks good to me.

-Sumit

>
> Since v7, I have:
> * Addressed the small amount of feedback that was there for v7.
> * Rebased.
> * Added a new patch that prevents us from spamming the logs with idle
>   tasks.
> * Added an extra patch to gracefully fall back to regular IPIs if
>   pseudo-NMIs aren't there.
>
> It can be noted that this patch series works very well with the recent
> "hardlockup" patches that have landed through Andrew Morton's tree and
> are currently in linuxnext. It works especially well with the "buddy"
> lockup detector.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
> [2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.cambridge.arm.com/
> [3] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/
>
> Changes in v9:
> - Add a warning if we don't have enough IPIs for the NMI IPI
> - Added comments that we might not be using NMI always.
> - Added missing "inline"
> - Added to commit message that this doesn't catch all cases.
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - Update commit description
> - arch_trigger_cpumask_backtrace() no longer returns bool
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> - "Tag the arm64 idle functions as __cpuidle" new for v8
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
>
> Douglas Anderson (2):
>   arm64: idle: Tag the arm64 idle functions as __cpuidle
>   kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
>
> Sumit Garg (5):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>   arm64: Add framework for a debug IPI
>   arm64: smp: Assign and setup the debug IPI
>   arm64: ipi_debug: Add support for backtrace using the debug IPI
>   arm64: kgdb: Roundup cpus using the debug IPI
>
>  arch/arm64/include/asm/irq.h  |   3 +
>  arch/arm64/kernel/Makefile    |   2 +-
>  arch/arm64/kernel/idle.c      |   4 +-
>  arch/arm64/kernel/ipi_debug.c | 102 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ipi_debug.h |  13 +++++
>  arch/arm64/kernel/kgdb.c      |  14 +++++
>  arch/arm64/kernel/smp.c       |  11 ++++
>  drivers/irqchip/irq-gic-v3.c  |  29 +++++++---
>  include/linux/kgdb.h          |   1 +
>  9 files changed, 168 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/kernel/ipi_debug.c
>  create mode 100644 arch/arm64/kernel/ipi_debug.h
>
> --
> 2.41.0.rc2.161.g9c6817b8e7-goog
>
