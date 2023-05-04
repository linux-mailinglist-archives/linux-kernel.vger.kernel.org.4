Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECE66F7934
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjEDWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDWjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:39:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04AA8A48
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:39:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76372a83c8eso23716339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683239957; x=1685831957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rN99MG5d6M+UabPVww+w9dMJG2WFhR6z4xfKsLbvtE=;
        b=U1S6OivI3z1i1T7iSMrQTuCKQMzWLj02EHrv7T/HreMQOZR7DywOIiGu56FUOYOdZ7
         BmMDNIdmLCkSDuJu4Af3d2XMCLv5qGA02WmLmGXt01711cT9iwc5exdcZN9SVB5tUXU5
         bGjtW9yYppMGAS+bYjHNpfB8nAirhucFNfoSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683239957; x=1685831957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rN99MG5d6M+UabPVww+w9dMJG2WFhR6z4xfKsLbvtE=;
        b=AufdvxFXzsKkzohpHvGW09Ff0oFEyiYfGialruy2xaYsf6ao7ZujehC/iKum9JXiVT
         chnwNGnMESxyGj+DslaNeXL+lHsRXRnqCqthRQg3U6keqs4T5rLzdcefCDH+K5Ucoq0V
         Axzl0sP65No+84xPWtMVgMSlpwX04QTTmRIdJRDSCqPyJ/60g/pGvYG44qn4YRm7THaX
         4rAA6YG1lufKX3ys018fVa9dlAROulsHrk1GIgw0XLaZKrYwHVcO5vSWx7GdwLvp07E2
         jI0A1MKFWDsm9cLwpyV0rAq7yQq/6znMy6FKbKb838R9NueYEaRzHEvr7G16Ng+Aw11/
         8C0w==
X-Gm-Message-State: AC+VfDzPTVnMSGZFzWBnfpLT3ShOOniWdQl1tM8pziJXKRvh3X5zabYl
        HfFFk5liHoGi4u9NeUN2HwG6rzEIML4RBFrGN/E=
X-Google-Smtp-Source: ACHHUZ4rCFeLExSZ6kt5V/MTFyf5OHETIBQx2dL1pcZYWReHjvO1yIl7AHQhiLQtO1xrvc9yCL5aRg==
X-Received: by 2002:a6b:d213:0:b0:769:a626:6e13 with SMTP id q19-20020a6bd213000000b00769a6266e13mr179030iob.19.1683239957489;
        Thu, 04 May 2023 15:39:17 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id w16-20020a6b4a10000000b007594fbab87fsm43121iob.1.2023.05.04.15.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:39:16 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so628325ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:39:14 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:3ef:3510:7c3a with SMTP id
 g5-20020ac85805000000b003ef35107c3amr17232qtg.3.1683239933101; Thu, 04 May
 2023 15:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
In-Reply-To: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:38:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wz8u0+WHqiLwcE-3BhbtdVVCnSQjs7bxp=-tisyYQwWw@mail.gmail.com>
Message-ID: <CAD=FV=Wz8u0+WHqiLwcE-3BhbtdVVCnSQjs7bxp=-tisyYQwWw@mail.gmail.com>
Subject: Re: [PATCH v3] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Borislav Petkov <bp@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 1, 2023 at 8:25=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> From: Colin Cross <ccross@android.com>
>
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.
>
> NOTE: unlike the other hard lockup detectors, the buddy one can't
> easily show what's happening on the CPU that locked up just by doing a
> simple backtrace. It relies on some other mechanism in the system to
> get information about the locked up CPUs. This could be support for
> NMI backtraces like [1], it could be a mechanism for printing the PC
> of locked CPUs at panic time like [2] / [3], or it could be something
> else. Even though that means we still rely on arch-specific code, this
> arch-specific code seems to often be implemented even on architectures
> that don't have a hardlockup detector.
>
> This style of hardlockup detector originated in some downstream
> Android trees and has been rebased on / carried in ChromeOS trees for
> quite a long time for use on arm and arm64 boards. Historically on
> these boards we've leveraged mechanism [2] / [3] to get information
> about hung CPUs, but we could move to [1].
>
> Although the original motivation for the buddy system was for use on
> systems without an arch-specific hardlockup detector, it can still be
> useful to use even on systems that _do_ have an arch-specific
> hardlockup detector. On x86, for instance, there is a 24-part patch
> series [4] in progress switching the arch-specific hard lockup
> detector from a scarce perf counter to a less-scarce hardware
> resource. Potentially the buddy system could be a simpler alternative
> to free up the perf counter but still get hard lockup detection.
>
> Overall, pros (+) and cons (-) of the buddy system compared to an
> arch-specific hardlockup detector:
> + The buddy system is usable on systems that don't have an
>   arch-specific hardlockup detector, like arm32 and arm64 (though it's
>   being worked on for arm64 [5]).
> + The buddy system may free up scarce hardware resources.
> + If a CPU totally goes out to lunch (can't process NMIs) the buddy
>   system could still detect the problem (though it would be unlikely
>   to be able to get a stack trace).
> + The buddy system uses the same timer function to pet the hardlockup
>   detector on the running CPU as it uses to detect hardlockups on
>   other CPUs. Compared to other hardlockup detectors, this means it
>   generates fewer interrupts and thus is likely better able to let
>   CPUs stay idle longer.
> - If all CPUs are hard locked up at the same time the buddy system
>   can't detect it.
> - If we don't have SMP we can't use the buddy system.
> - The buddy system needs an arch-specific mechanism (possibly NMI
>   backtrace) to get info about the locked up CPU.
>
> [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.or=
g
> [2] https://issuetracker.google.com/172213129
> [3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> [4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-cald=
eron@linux.intel.com/
> [5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecop=
zer.chen@mediatek.com/
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch has been rebased in ChromeOS kernel trees many times, and
> each time someone had to do work on it they added their
> Signed-off-by. I've included those here. I've also left the author as
> Colin Cross since the core code is still his.
>
> I'll also note that the CC list is pretty giant, but that's what
> get_maintainers came up with (plus a few other folks I thought would
> be interested). As far as I can tell, there's no true MAINTAINER
> listed for the existing watchdog code. Assuming people don't hate
> this, maybe it would go through Andrew Morton's tree?
>
> Changes in v3:
> - More cpu =3D> CPU (in Kconfig and comments).
> - Added a note in commit message about the effect on idle.
> - Cleaned up commit message pros/cons to be complete sentences.
> - No code changes other than comments.
>
> Changes in v2:
> - cpu =3D> CPU (in commit message).
> - Reworked description and Kconfig based on v1 discussion.
> - No code changes.
>
>  include/linux/nmi.h         |  18 ++++-
>  kernel/Makefile             |   1 +
>  kernel/watchdog.c           |  24 ++++--
>  kernel/watchdog_buddy_cpu.c | 141 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug           |  23 +++++-
>  5 files changed, 196 insertions(+), 11 deletions(-)

To leave breadcrumbs: I've posted v4 which is now a big series

https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.org

I took some people off the CC list that get_maintainers had added on
v3, mostly because it was getting unbearable. I tried to copy all
relevant mailing lists, so hopefully anyone who needs v4 can find it
somewhere where it's easy for them to reply to. If you got dropped off
the CC list and want back on for future versions, please yell and I'll
add you. Unless I messed up, I've CCed anyone who replied to previous
versions.

-Doug
