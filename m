Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE66B6F3282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjEAPJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjEAPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:09:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CA10DC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:08:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4eff50911bfso3219333e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682953731; x=1685545731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQb1XVaufUW5DJA/7lHcfBPSDH2dGqwat0C76pMtYrg=;
        b=n8qbTlIkwqGGVXj0DBubnkDOtkzAzTmoHXrVyLPqUTPzr5wF7odECkDNqXURmmzZVM
         GUF9GITZOncqMJBxY1FCjy5lqOlU+gUFlUjn50ZnNHsaNCGbL6qR52mOSkaqLSQ8qn2t
         v/sAigofdmbxrV1myc4Vj2UzY+bGcmN3YnJBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682953731; x=1685545731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQb1XVaufUW5DJA/7lHcfBPSDH2dGqwat0C76pMtYrg=;
        b=dKgzL+WcJ1ZqgN0KgYzhzOtmOMaXT+wkI1KUX+SbKtCbsIXwsH/vi/YAwJB51G7VZi
         W3TTv5qACGpD69GroZWPkDbZEDF6S9AdlQqHYRbIOUAbIX0nI1eKtiEivIGbNnQRRS5N
         4fUo/2Slg9G74yXuyhB2NpzgiK3vg/LrZR0iS8ECbvqkhAShEewTNyYBhk02bottLjMF
         rqP3CPcjI7n+LW2hhEZGOEZGut+1d+VW8o2HunFAHb74lQxp0ptmSkB5TPKgDii83jLT
         XlmhvhaQ0yi6Z061ZtXqoHbzNGJ+D/HL/VLoHl1szkXw3Jl5JN3ZcbwtZ9HVlnh+IP3o
         ilzg==
X-Gm-Message-State: AC+VfDyKjJqBgxVV9eU2vGe91pAEphmk4vVU8RH4tOXS8BGBY4jUQu8D
        NzZ43vTfFORegeD39WzTEb8QRVfnuZGx2aZDBq+alsNt
X-Google-Smtp-Source: ACHHUZ4jA3f+Edqz64hwoTIgiyGRl8yI1LmG4qbJgcOig/6MSN9usqXi+ubREW2Gq5yfikbxQp/0sA==
X-Received: by 2002:ac2:5099:0:b0:4ed:c639:54cd with SMTP id f25-20020ac25099000000b004edc63954cdmr3799556lfm.35.1682953730874;
        Mon, 01 May 2023 08:08:50 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t14-20020ac2548e000000b004cb14fa604csm4786776lfk.262.2023.05.01.08.08.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 08:08:49 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4edc63e066fso22440e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:08:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:3f1:74cf:8563 with SMTP id
 bi7-20020a05600c3d8700b003f174cf8563mr484739wmb.5.1682953706729; Mon, 01 May
 2023 08:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CAP-5=fUJJ-JBxWuHm573jRDcrLCp4kRUhvOSw3jjsMAc5VbdMg@mail.gmail.com>
In-Reply-To: <CAP-5=fUJJ-JBxWuHm573jRDcrLCp4kRUhvOSw3jjsMAc5VbdMg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 May 2023 08:08:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xpmkju4g8fWnh3AahgqtMRkCfkUtfEsgm_z23W+7BY+A@mail.gmail.com>
Message-ID: <CAD=FV=Xpmkju4g8fWnh3AahgqtMRkCfkUtfEsgm_z23W+7BY+A@mail.gmail.com>
Subject: Re: [PATCH v2] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
To:     Ian Rogers <irogers@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-perf-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        ravi.v.shankar@intel.com, Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Stephen Boyd <swboyd@chromium.org>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Gow <davidgow@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 29, 2023 at 2:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Apr 28, 2023 at 4:41=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
> >
> > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > easily show what's happening on the CPU that locked up just by doing a
> > simple backtrace. It relies on some other mechanism in the system to
> > get information about the locked up CPUs. This could be support for
> > NMI backtraces like [1], it could be a mechanism for printing the PC
> > of locked CPUs at panic time like [2] / [3], or it could be something
> > else. Even though that means we still rely on arch-specific code, this
> > arch-specific code seems to often be implemented even on architectures
> > that don't have a hardlockup detector.
> >
> > This style of hardlockup detector originated in some downstream
> > Android trees and has been rebased on / carried in ChromeOS trees for
> > quite a long time for use on arm and arm64 boards. Historically on
> > these boards we've leveraged mechanism [2] / [3] to get information
> > about hung CPUs, but we could move to [1].
> >
> > Although the original motivation for the buddy system was for use on
> > systems without an arch-specific hardlockup detector, it can still be
> > useful to use even on systems that _do_ have an arch-specific
> > hardlockup detector. On x86, for instance, there is a 24-part patch
> > series [4] in progress switching the arch-specific hard lockup
> > detector from a scarce perf counter to a less-scarce hardware
> > resource. Potentially the buddy system could be a simpler alternative
> > to free up the perf counter but still get hard lockup detection.
> >
> > Overall, pros (+) and cons (-) of the buddy system compared to an
> > arch-specific hardlockup detector:
> > + Usable on systems that don't have an arch-specific hardlockup
> >   detector, like arm32 and arm64 (though it's being worked on for
> >   arm64 [5]).
> > + May free up scarce hardware resources.
> > + If a CPU totally goes out to lunch (can't process NMIs) the buddy
> >   system could still detect the problem (though it would be unlikely
> >   to be able to get a stack trace).
> > - If all CPUs are hard locked up at the same time the buddy system
> >   can't detect it.
> > - If we don't have SMP we can't use the buddy system.
> > - The buddy system needs an arch-specific mechanism (possibly NMI
> >   backtrace) to get info about the locked up CPU.
>
> Thanks for this list, it is really useful! Is it worth mentioning the
> behavior around idle? Could this approach potentially use more power?

Sure, I'll add some text in there. If I'm analyzing the code properly,
my belief is that, if anything, the buddy detector should be better
for idle/power than some other detectors.

Specifically, note that the main "worker" of the buddy detector is
called from watchdog_timer_fn(). The timer function is the same one
that runs for other hard lockup detectors, but in those cases it
_only_ pets the watchdog of the running CPU. With the buddy detector
it pets the running CPU's watchdog and then checks on the buddy's
watchdog. There is no separate wakeup / interrupt that needs to run
periodically to look for hard lockups.

I'm about to send a v3 to fix the cpu=3D>CPU that I missed on v2. I'll
add text similar to the above to the commit message.

-Doug
