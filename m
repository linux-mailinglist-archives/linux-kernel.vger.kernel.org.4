Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64B6E8087
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjDSRnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDSRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:43:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397F72A0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:43:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso147985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681926195; x=1684518195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbIeXSReCQMbeb4ih3GQD4yHVI+ajegh0q6OiBbZIxg=;
        b=LHTaEdOyIBlJsLLfw3G2QpQk9naWCaRk8oWpTNM0nZZIFvxvmevcqE+gjM3vs8Z2K1
         W1/HmoG0GqrXpeu7HU4/kVSdSuIC/t20E0hmzPxn6WMRZZQJJT9iiCM2GtzumIUp4not
         A/dcKgPcYslPWtn2WW1dtqXLgWCYpMms6B975bbHGb5DeRjzAr2LuDtkz7HJxUomtpME
         VRvxUAxvB2QKGXpVagWuNojmw1PV2Ezvd6bvJp27ClTT1V9Leh50cY+ZYSQ+HQAEKD36
         kYK1SY8TPmFQuJ6BPtefi+ZeHkknOvp5/pFlQ6pW+AzeOfRl5c1IvxophtdEkpqrcV1I
         zR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681926195; x=1684518195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbIeXSReCQMbeb4ih3GQD4yHVI+ajegh0q6OiBbZIxg=;
        b=EFyhvKJP/1Gn0ubLvAw/WfRBwvRfa3Ry8TnkwiqpktuKm91AfEgbK7ADBJo3+iO6+V
         2jaqyeSr7di5qgiOv0OilqJQFjZ2JScf6A4S74t6dqjChY90WW+1hJn6E4KOmiQnYw13
         CmoRkT1M7OmNfA2h4ZAhtmPm/DXk+JWSCGDF9mQg9gNNUKl2uOSgyTt4BZgqEU5BNZTs
         mfLboGWjCYJp6DJjV3k+oeB8YynvKRVRVYRkFYsra8j7PRFnpICdq4azFWYvA1acXK1Z
         owo0b0gbUYReNtBaqVhS5fB0G6/Em0WDP5uAuxYOfVklXu2qS227fRFHxzQuwkMZCv1e
         hY4g==
X-Gm-Message-State: AAQBX9dUoHyW1DfU/1xSVB1tMkU8lOH5HglK0VPIhVhEYejKTAiqu551
        Iqep9VvuZsr+QE/OJzcoFjvd4weHP2hEY4awYYh5Yg==
X-Google-Smtp-Source: AKy350ZmpzQ1uY1BUEeMEpoys5h/UnF5v4KOvTi+J/OoxZA1ul+8Bb2MgOls4JOxVXqW2oCoz86I5D2zEW2FeB5MdWA=
X-Received: by 2002:a05:600c:4e8a:b0:3f1:73b8:b5fe with SMTP id
 f10-20020a05600c4e8a00b003f173b8b5femr4192wmq.3.1681926195026; Wed, 19 Apr
 2023 10:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
 <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
 <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com> <CAHVXubjhORBEDok_Zhq5p_Yv4Ty4Hct84dWJZXzo48+40N=CGg@mail.gmail.com>
In-Reply-To: <CAHVXubjhORBEDok_Zhq5p_Yv4Ty4Hct84dWJZXzo48+40N=CGg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Apr 2023 10:42:58 -0700
Message-ID: <CAP-5=fX6kaZt68UbMMZzW-zs0RyRWoOS-Tq5NwekWj8k9Shx6g@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        paranlee <p4ranlee@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 2:21=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Ian,
>
> On Tue, Apr 18, 2023 at 10:30=E2=80=AFPM Atish Patra <atishp@atishpatra.o=
rg> wrote:
> >
> > On Tue, Apr 18, 2023 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atishpatr=
a.org> wrote:
> > > >
> > > > On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Laight@=
aculab.com> wrote:
> > > > >
> > > > > From: Atish Patra
> > > > > > Sent: 13 April 2023 20:18
> > > > > >
> > > > > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alexgh=
iti@rivosinc.com> wrote:
> > > > > > >
> > > > > > > riscv used to allow direct access to cycle/time/instret count=
ers,
> > > > > > > bypassing the perf framework, this patchset intends to allow =
the user to
> > > > > > > mmap any counter when accessed through perf. But we can't bre=
ak the
> > > > > > > existing behaviour so we introduce a sysctl perf_user_access =
like arm64
> > > > > > > does, which defaults to the legacy mode described above.
> > > > > > >
> > > > > >
> > > > > > It would be good provide additional direction for user space pa=
ckages:
> > > > > >
> > > > > > The legacy behavior is supported for now in order to avoid brea=
king
> > > > > > existing software.
> > > > > > However, reading counters directly without perf interaction may
> > > > > > provide incorrect values which
> > > > > > the userspace software must avoid. We are hoping that the user =
space
> > > > > > packages which
> > > > > > read the cycle/instret directly, will move to the proper interf=
ace
> > > > > > eventually if they actually need it.
> > > > > > Most of the users are supposed to read "time" instead of "cycle=
" if
> > > > > > they intend to read timestamps.
> > > > >
> > > > > If you are trying to measure the performance of short code
> > > > > fragments then you need pretty much raw access directly to
> > > > > the cycle/clock count register.
> > > > >
> > > > > I've done this on x86 to compare the actual cycle times
> > > > > of different implementations of the IP checksum loop
> > > > > (and compare them to the theoretical limit).
> > > > > The perf framework just added far too much latency,
> > > > > only directly reading the cpu registers gave anything
> > > > > like reliable (and consistent) answers.
> > > > >
> > > >
> > > > This series allows direct access to the counters once configured
> > > > through the perf.
> > > > Earlier the cycle/instret counters are directly exposed to the
> > > > userspace without kernel/perf frameworking knowing
> > > > when/which user space application is reading it. That has security =
implications.
> > > >
> > > > With this series applied, the user space application just needs to
> > > > configure the event (cycle/instret) through perf syscall.
> > > > Once configured, the userspace application can find out the counter
> > > > information from the mmap & directly
> > > > read the counter. There is no latency while reading the counters.
> > > >
> > > > This mechanism allows stop/clear the counters when the requesting t=
ask
> > > > is not running. It also takes care of context switching
> > > > which may result in invalid values as you mentioned below. This is
> > > > nothing new and all other arch (x86, ARM64) allow user space
> > > > counter read through the same mechanism.
> > > >
> > > > Here is the relevant upstream discussion:
> > > > https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programming.k=
icks-ass.net/T/
> > > >
> > > > ARM64:
> > > > https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_acces=
s#perf-userspace-pmu-hardware-counter-access
> > > >
> > > > example usage in x86:
> > > > https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpmc.c
> > >
> > > The canonical implementation of this should be:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/lib/perf/mmap.c#n400
> >
> > Thanks for sharing the libperf implementation.
> >
> > > which is updated in these patches but the tests are not:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/tests/mmap-basic.c#n287
> > > Which appears to be an oversight. The tests display some differences
> >
> > Yes. It's an oversight. We should make sure that perf mmap tests pass
> > for RISC-V as well.
>
> Yes, that's an oversight, I had a local test adapted from this one but
> forgot to update it afterwards, I'll do that in the next version.
>
> Thanks for your quick feedbacks and sorry for being late,
>
> Alex

Thanks Alex, there was an equally likely chance that I wasn't
understanding things :-) Is there any information on RISC-V PMU
testing? I know ParanLee is interested. It'd be awesome to have
something say on:
https://perf.wiki.kernel.org/index.php/Main_Page
on how to run tests, perhaps on QEMU or known to work boards. We can
also just drop a link on there if there is information. We can also
add the RISC-V PMU information to the links here:
https://perf.wiki.kernel.org/index.php/Useful_Links

Thanks,
Ian

>
> >
> >
> > > between x86 and aarch64 that have assumed userspace hardware counter
> > > access, and everything else that it is assumed don't.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > > Clearly process switches (especially cpu migrations) cause
> > > > > problems, but they are obviously invalid values and can
> > > > > be ignored.
> > > > >
> > > > > So while a lot of uses may be 'happy' with the values the
> > > > > perf framework gives, sometimes you do need to directly
> > > > > read the relevant registers.
> > > > >
> > > > >         David
> > > > >
> > > > > -
> > > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Key=
nes, MK1 1PT, UK
> > > > > Registration No: 1397386 (Wales)
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Atish
> >
> >
> >
> > --
> > Regards,
> > Atish
