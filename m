Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49366E6BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDRSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:16:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9C30E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:16:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso66865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681841771; x=1684433771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzk00VVwAMnUgl8nqdf7G+u1lGlONN9yY2/sgJWoENw=;
        b=nVANayyNWQEEcixXLqV58hlA44rj6vtMwQer5ALpXD+J7VO5ysQutiY7HHiuVoz8F+
         yORfLruneACibPMnxRaVgKWwcMZVcMD9oFIhFI67ivS4lcNI+4TRMk9rtITgyWkXMNNd
         PlCuhCVu8rfB3QxBCZQCgaDOC1FDvoVj1H5R5FnFIc1PqdCrK/uiOqLTVShiSQ7M170d
         VEdup8js/MK8j0kVW+RDn+EEyfkMLCIX7k1ylHxCZlM1YJnlk7+R1enDl3Iq+wHyzLDa
         deRchW644KPY6XyWgOy4AczDdGW3MUgxI3c4nJ7bH6UddtzrMLoK7+huqXWBBoG+hvlf
         zj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841771; x=1684433771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uzk00VVwAMnUgl8nqdf7G+u1lGlONN9yY2/sgJWoENw=;
        b=Er6w6ljT5N6clo76HEBlZJn2u6fMH3/mKxoZ936UkR4LBRPZnHaYgK/5+UJ4Ws4Rbw
         ii0Ljb8qGMPHDlqp8STZFGFlWC3KMXL0IVfldvAn+3EXJNVpNW1fqUERHRi9u/aeTnNZ
         n9miH/qCWaM99mlTPa9EAw2nFYmg6+3qB19Q1KxpFaX9YJHDFo45BsjUCQeGWsOP85fq
         RiOoZFd8c6t6/QFBd276NBfmlz35J3Wo+PykXq9+ERZrniqB2nwE88D9kB83w5CW9J01
         oCdHFhDbuv00KjuzHOcsSKB4eSxyVANinpPovg7g4Iiy5VN8B7cg5+MT/jy2YdiLc08l
         /GLw==
X-Gm-Message-State: AAQBX9ertWLCPnACm/y+hutkiEEBIuasPKoAWKXJTSWGlYWdvpTOliUj
        UlZUkquH8i+S4WjUrAPGhAaTfWWtiop9/uZU2aZM9g==
X-Google-Smtp-Source: AKy350YlrlOxmvzog0f3D5uEtE7OfRYpZXxq6H5LRCHAsI0piErrBw4HBLPgJ3F/vVAjjDRqNTs1wro+Od2+A+R7Nms=
X-Received: by 2002:a05:600c:22c8:b0:3f1:758c:dd23 with SMTP id
 8-20020a05600c22c800b003f1758cdd23mr10353wmg.7.1681841770657; Tue, 18 Apr
 2023 11:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
In-Reply-To: <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 11:15:56 -0700
Message-ID: <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Atish Patra <atishp@atishpatra.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        paranlee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Laight@aculab=
.com> wrote:
> >
> > From: Atish Patra
> > > Sent: 13 April 2023 20:18
> > >
> > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > > >
> > > > riscv used to allow direct access to cycle/time/instret counters,
> > > > bypassing the perf framework, this patchset intends to allow the us=
er to
> > > > mmap any counter when accessed through perf. But we can't break the
> > > > existing behaviour so we introduce a sysctl perf_user_access like a=
rm64
> > > > does, which defaults to the legacy mode described above.
> > > >
> > >
> > > It would be good provide additional direction for user space packages=
:
> > >
> > > The legacy behavior is supported for now in order to avoid breaking
> > > existing software.
> > > However, reading counters directly without perf interaction may
> > > provide incorrect values which
> > > the userspace software must avoid. We are hoping that the user space
> > > packages which
> > > read the cycle/instret directly, will move to the proper interface
> > > eventually if they actually need it.
> > > Most of the users are supposed to read "time" instead of "cycle" if
> > > they intend to read timestamps.
> >
> > If you are trying to measure the performance of short code
> > fragments then you need pretty much raw access directly to
> > the cycle/clock count register.
> >
> > I've done this on x86 to compare the actual cycle times
> > of different implementations of the IP checksum loop
> > (and compare them to the theoretical limit).
> > The perf framework just added far too much latency,
> > only directly reading the cpu registers gave anything
> > like reliable (and consistent) answers.
> >
>
> This series allows direct access to the counters once configured
> through the perf.
> Earlier the cycle/instret counters are directly exposed to the
> userspace without kernel/perf frameworking knowing
> when/which user space application is reading it. That has security implic=
ations.
>
> With this series applied, the user space application just needs to
> configure the event (cycle/instret) through perf syscall.
> Once configured, the userspace application can find out the counter
> information from the mmap & directly
> read the counter. There is no latency while reading the counters.
>
> This mechanism allows stop/clear the counters when the requesting task
> is not running. It also takes care of context switching
> which may result in invalid values as you mentioned below. This is
> nothing new and all other arch (x86, ARM64) allow user space
> counter read through the same mechanism.
>
> Here is the relevant upstream discussion:
> https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programming.kicks-a=
ss.net/T/
>
> ARM64:
> https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_access#perf=
-userspace-pmu-hardware-counter-access
>
> example usage in x86:
> https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpmc.c

The canonical implementation of this should be:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/perf/mmap.c#n400
which is updated in these patches but the tests are not:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/tests/mmap-basic.c#n287
Which appears to be an oversight. The tests display some differences
between x86 and aarch64 that have assumed userspace hardware counter
access, and everything else that it is assumed don't.

Thanks,
Ian

> > Clearly process switches (especially cpu migrations) cause
> > problems, but they are obviously invalid values and can
> > be ignored.
> >
> > So while a lot of uses may be 'happy' with the values the
> > perf framework gives, sometimes you do need to directly
> > read the relevant registers.
> >
> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
>
>
>
> --
> Regards,
> Atish
