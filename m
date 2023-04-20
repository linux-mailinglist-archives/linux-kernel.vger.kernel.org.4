Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511A6E8696
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjDTAcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjDTAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:32:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C35FF7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:32:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso171385e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681950727; x=1684542727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpHsbQZOI2szya5getePPbZFizdtNLAvh8GmFlwAN1M=;
        b=ysPLUsQMbedXCyQYZr6Zc+fSt8NWoLdVDcqcVZDHhCrCDaB2sk6rhO14ftB7Jzggai
         cVizcqRRor6XZZATBcC+Q5hAviYJW6j84oNJYMS9tlWqa54/Pl+veZlWD37xLZk3abmk
         gpO4AFFVZuCznXvk946oY0x/ygmv4NsGux2cbs+vd0xuZ8EljM6IzQUd37HOvFZcJ2i0
         5S3EnekxS0JmeXrrTdh0WIw/79II6znLakNv9k9n/OvrhR9O18k2UGFvYZ4gT9wZDVhW
         StRsYpOeMeYj+Yv0Th1ngB3fz+qDAknM0kw1O7NtNRq99eyDTfj4vP12sDUbhJl+foEI
         ep0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950727; x=1684542727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpHsbQZOI2szya5getePPbZFizdtNLAvh8GmFlwAN1M=;
        b=klnaLU3bV1t5RgH4Q16oOFrLeuKWSyyU/qDa1thrLTvFsnZiNPJRIyaf4j3XQD57xH
         McxzHVUX7zVWpw7+5Nb7nFJinOLdXxtBwhXXq8VqkUN2PTn8OwPSpvoKWdlHBomKSR1W
         07jbT9eGUJywylIntEC3mfFztV5RvZAIHmnDIdMjx4GBJMQbXh2H4qpbYZk3oCgBfuHJ
         3twSc3nM6hzLK22UUU9jiwPW8IoSP3KlCOhTtEHIBTHvON0XhcwbM0HHf2arN63+CedE
         cXIRvrScljV9K0wLAySCzrgcqiWQcfssZzy3qBC3MtDZnYxSIXJnon6pSwkoJpAn31dl
         B2mw==
X-Gm-Message-State: AAQBX9fpRjXtC9bzvxq5LCA18ZfYM2Fmj6LkkURyLb0YY5yTeyppzI2a
        wKRO/pHuGM8fAQzP0qeYe41Gc9NiRDZl0bQXyvs3Jg==
X-Google-Smtp-Source: AKy350aBel/7MtmlYCMSjJPTLJNrhcBDWM1l1EErpsirii/9U3cgHvYfQURMqtj3yNFdf/eUjBr+4QIODnFlFBR70+I=
X-Received: by 2002:a05:600c:314c:b0:3f1:7490:e5a4 with SMTP id
 h12-20020a05600c314c00b003f17490e5a4mr90071wmo.6.1681950726866; Wed, 19 Apr
 2023 17:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
 <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
 <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com>
 <CAHVXubjhORBEDok_Zhq5p_Yv4Ty4Hct84dWJZXzo48+40N=CGg@mail.gmail.com>
 <CAP-5=fX6kaZt68UbMMZzW-zs0RyRWoOS-Tq5NwekWj8k9Shx6g@mail.gmail.com> <CAOnJCU+5EQp-AqrwJpBo6ZPWfybwaGyD3zcC0YrCAsSY4=fqdw@mail.gmail.com>
In-Reply-To: <CAOnJCU+5EQp-AqrwJpBo6ZPWfybwaGyD3zcC0YrCAsSY4=fqdw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Apr 2023 17:31:50 -0700
Message-ID: <CAP-5=fUrTSXZwR2rV34AXbNCYcV1wnFyfzhNuRgBLXofsjnE_g@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        paranlee <p4ranlee@gmail.com>,
        David Laight <David.Laight@aculab.com>,
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
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:22=E2=80=AFPM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Wed, Apr 19, 2023 at 11:13=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Apr 19, 2023 at 2:21=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Apr 18, 2023 at 10:30=E2=80=AFPM Atish Patra <atishp@atishpat=
ra.org> wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 11:46=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > >
> > > > > On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atish=
patra.org> wrote:
> > > > > >
> > > > > > On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Lai=
ght@aculab.com> wrote:
> > > > > > >
> > > > > > > From: Atish Patra
> > > > > > > > Sent: 13 April 2023 20:18
> > > > > > > >
> > > > > > > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <al=
exghiti@rivosinc.com> wrote:
> > > > > > > > >
> > > > > > > > > riscv used to allow direct access to cycle/time/instret c=
ounters,
> > > > > > > > > bypassing the perf framework, this patchset intends to al=
low the user to
> > > > > > > > > mmap any counter when accessed through perf. But we can't=
 break the
> > > > > > > > > existing behaviour so we introduce a sysctl perf_user_acc=
ess like arm64
> > > > > > > > > does, which defaults to the legacy mode described above.
> > > > > > > > >
> > > > > > > >
> > > > > > > > It would be good provide additional direction for user spac=
e packages:
> > > > > > > >
> > > > > > > > The legacy behavior is supported for now in order to avoid =
breaking
> > > > > > > > existing software.
> > > > > > > > However, reading counters directly without perf interaction=
 may
> > > > > > > > provide incorrect values which
> > > > > > > > the userspace software must avoid. We are hoping that the u=
ser space
> > > > > > > > packages which
> > > > > > > > read the cycle/instret directly, will move to the proper in=
terface
> > > > > > > > eventually if they actually need it.
> > > > > > > > Most of the users are supposed to read "time" instead of "c=
ycle" if
> > > > > > > > they intend to read timestamps.
> > > > > > >
> > > > > > > If you are trying to measure the performance of short code
> > > > > > > fragments then you need pretty much raw access directly to
> > > > > > > the cycle/clock count register.
> > > > > > >
> > > > > > > I've done this on x86 to compare the actual cycle times
> > > > > > > of different implementations of the IP checksum loop
> > > > > > > (and compare them to the theoretical limit).
> > > > > > > The perf framework just added far too much latency,
> > > > > > > only directly reading the cpu registers gave anything
> > > > > > > like reliable (and consistent) answers.
> > > > > > >
> > > > > >
> > > > > > This series allows direct access to the counters once configure=
d
> > > > > > through the perf.
> > > > > > Earlier the cycle/instret counters are directly exposed to the
> > > > > > userspace without kernel/perf frameworking knowing
> > > > > > when/which user space application is reading it. That has secur=
ity implications.
> > > > > >
> > > > > > With this series applied, the user space application just needs=
 to
> > > > > > configure the event (cycle/instret) through perf syscall.
> > > > > > Once configured, the userspace application can find out the cou=
nter
> > > > > > information from the mmap & directly
> > > > > > read the counter. There is no latency while reading the counter=
s.
> > > > > >
> > > > > > This mechanism allows stop/clear the counters when the requesti=
ng task
> > > > > > is not running. It also takes care of context switching
> > > > > > which may result in invalid values as you mentioned below. This=
 is
> > > > > > nothing new and all other arch (x86, ARM64) allow user space
> > > > > > counter read through the same mechanism.
> > > > > >
> > > > > > Here is the relevant upstream discussion:
> > > > > > https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programmi=
ng.kicks-ass.net/T/
> > > > > >
> > > > > > ARM64:
> > > > > > https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_a=
ccess#perf-userspace-pmu-hardware-counter-access
> > > > > >
> > > > > > example usage in x86:
> > > > > > https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpm=
c.c
> > > > >
> > > > > The canonical implementation of this should be:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/tools/lib/perf/mmap.c#n400
> > > >
> > > > Thanks for sharing the libperf implementation.
> > > >
> > > > > which is updated in these patches but the tests are not:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/tools/perf/tests/mmap-basic.c#n287
> > > > > Which appears to be an oversight. The tests display some differen=
ces
> > > >
> > > > Yes. It's an oversight. We should make sure that perf mmap tests pa=
ss
> > > > for RISC-V as well.
> > >
> > > Yes, that's an oversight, I had a local test adapted from this one bu=
t
> > > forgot to update it afterwards, I'll do that in the next version.
> > >
> > > Thanks for your quick feedbacks and sorry for being late,
> > >
> > > Alex
> >
> > Thanks Alex, there was an equally likely chance that I wasn't
> > understanding things :-) Is there any information on RISC-V PMU
> > testing? I know ParanLee is interested. It'd be awesome to have
>
> Are you looking for something specific to RISC-V general or perf on RISC-=
V?
> All the RISC-V PMU patches have been upstream for a while (both in the
> Qemu & Linux kernel).
> Perf should work out-of-the box when you boot the latest kernel in the
> latest version of the Qemu.
>
> Initial KVM[1] patches support got merged during the last merge
> window. It doesn't support
> event sampling yet. We are working on that.
>
> [1] https://lore.kernel.org/lkml/20230207095529.1787260-1-atishp@rivosinc=
.com/

Cool, it'd be nice to have a recipe for this from x86 Linux :-)

> > something say on:
> > https://perf.wiki.kernel.org/index.php/Main_Page
> > on how to run tests, perhaps on QEMU or known to work boards. We can
> > also just drop a link on there if there is information. We can also
> > add the RISC-V PMU information to the links here:
> > https://perf.wiki.kernel.org/index.php/Useful_Links
> >
>
> I did not see any arch specific information there. Let us know what
> would be good to
> add there and we would be happy to add.

I was specifically thinking under Manuals where the Intel, AMD and ARM
manuals are, links to the RISC-V documentation could be added.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> > >
> > > >
> > > >
> > > > > between x86 and aarch64 that have assumed userspace hardware coun=
ter
> > > > > access, and everything else that it is assumed don't.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > > Clearly process switches (especially cpu migrations) cause
> > > > > > > problems, but they are obviously invalid values and can
> > > > > > > be ignored.
> > > > > > >
> > > > > > > So while a lot of uses may be 'happy' with the values the
> > > > > > > perf framework gives, sometimes you do need to directly
> > > > > > > read the relevant registers.
> > > > > > >
> > > > > > >         David
> > > > > > >
> > > > > > > -
> > > > > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton=
 Keynes, MK1 1PT, UK
> > > > > > > Registration No: 1397386 (Wales)
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Regards,
> > > > > > Atish
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Atish
>
>
>
> --
> Regards,
> Atish
