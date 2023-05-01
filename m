Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8A6F31DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEAONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:13:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE71BF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:13:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so39951471a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682950396; x=1685542396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz6FJXzkJkqPDcrEIjMfZPfzlnpS0r8oHDAuwuJCMM8=;
        b=eORTBgP41eLbyp6ar6PGWVKd07frqgEgHvfYIenm1zRz6YrAbveacuK5n9l6Up5bdQ
         aLI7mFzFlk/pZTBdqlKu43eBbRWaNr5B+qW+yh4SiuV0uTzsXAsazhmc10yKcB+QDs9s
         srQ1/ZGFvXtufGl1yuOJHkHjQgVQXmeS/M8Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682950396; x=1685542396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz6FJXzkJkqPDcrEIjMfZPfzlnpS0r8oHDAuwuJCMM8=;
        b=GcpguxJOj+BrdnsPcCErKvQbX/Ey6Q2VUBELli8YYBWLjlsIMIW56u8zTJq/IfmItA
         H8l+rTD+X+UvVa6iM2Jk0l/IzFNqPmyKuT7px5L0ujNTdob/DCFg3kbIEOYVEJj8NN9j
         iO/ONPuSFZqw/8Bn2r11ag07Eb5ldSI1io3Gla/5/Ewx9N7ORpkh+HwcKCX9QlST67fo
         04jspirA0c8Vji4wb22SvSfs5PSZvDLjsRUlFAVa0bGpm4A6Rk+SxchxfvHr6X9ZcA/+
         MHRFqY1elfMRyV3gYB8nrLH3/TPRAS4BO0/TQ+uSKas9w0yVlE3+Zg0nTR0UZjhF7JRy
         kfKw==
X-Gm-Message-State: AC+VfDxqHgVTJUtbK+ZEkphU+tuVRGI7kCnfqhPqGgLXkWQ7PlvwJeK7
        5VtagoKN975aV+KTxhT30NDm7t0K37oBrwAc5f+PN+47
X-Google-Smtp-Source: ACHHUZ7Fw8mzDXmPbYt4MShN0Suav40jB7MXITqjYRfWpgCong0CQK0z7EYF0N/ErKxdqM/wsbmPxQ==
X-Received: by 2002:a17:907:6d8c:b0:94e:bf3e:638 with SMTP id sb12-20020a1709076d8c00b0094ebf3e0638mr11687809ejc.11.1682950395887;
        Mon, 01 May 2023 07:13:15 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090648c500b008c16025b318sm14887073ejt.155.2023.05.01.07.13.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 07:13:15 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso35409a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:13:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3c84:b0:3f1:9396:6fbf with SMTP id
 bg4-20020a05600c3c8400b003f193966fbfmr531828wmb.4.1682949899295; Mon, 01 May
 2023 07:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <217e697c-ad13-96ca-3829-a046469fd86a@infradead.org>
In-Reply-To: <217e697c-ad13-96ca-3829-a046469fd86a@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 May 2023 07:04:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0tzeqCrFUrytbe0OByYkC23i61H+jdgZRXfMKbShMcA@mail.gmail.com>
Message-ID: <CAD=FV=V0tzeqCrFUrytbe0OByYkC23i61H+jdgZRXfMKbShMcA@mail.gmail.com>
Subject: Re: [PATCH v2] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-perf-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        ravi.v.shankar@intel.com, Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Ian Rogers <irogers@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
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


On Fri, Apr 28, 2023 at 5:36=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 4/28/23 16:37, Douglas Anderson wrote:
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
> >
> > [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.=
org
> > [2] https://issuetracker.google.com/172213129
> > [3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> > [4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-ca=
lderon@linux.intel.com/
> > [5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lec=
opzer.chen@mediatek.com/
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This patch has been rebased in ChromeOS kernel trees many times, and
> > each time someone had to do work on it they added their
> > Signed-off-by. I've included those here. I've also left the author as
> > Colin Cross since the core code is still his.
> >
> > I'll also note that the CC list is pretty giant, but that's what
> > get_maintainers came up with (plus a few other folks I thought would
> > be interested). As far as I can tell, there's no true MAINTAINER
> > listed for the existing watchdog code. Assuming people don't hate
> > this, maybe it would go through Andrew Morton's tree?
> >
> > Changes in v2:
> > - cpu =3D> CPU.
> > - Reworked description and Kconfig based on v1 discussion.
>
> or at least some of the comments from v1. :(

Oh no! My email program confused me and I thought all of your cpu=3D>CPU
stuff was in the patch description, not in the Kconfig. I'll whip up a
quick v3.

-Doug
