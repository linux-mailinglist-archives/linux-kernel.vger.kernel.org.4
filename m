Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3306ED13D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDXPYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:24:41 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272261B1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:24:38 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-32a7770f7baso12205995ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682349877; x=1684941877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQQ0l1rf0aXXyplq/mgF2Rjc0pUjLq2PlqK5LzTpLjw=;
        b=ZOHDrxCWSTD3Ev+Yjo00DTdfoFeaLvem8pOVb2HVba/XWjjEtNRItIcHEbNehcSb6H
         bw+q2E+3WneHy+fEggR8KA2P85b2YEDALeLWPUqfe+PyLwyukW+3VqiTWnVJZi4pqIqN
         dbQnuj0CoZ7JN+njC+4g4gtTh/uu5kMx3xsCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349877; x=1684941877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQQ0l1rf0aXXyplq/mgF2Rjc0pUjLq2PlqK5LzTpLjw=;
        b=kgz9Ptw0MN6V19yOV85pD4Xx20HFw1oN/iNKx+Zlhqhn98Glbpt/7c7Hw1Ij1BXWUu
         HNbrzdn+RS/zU8plrPLxt1PqLLbt/SqNBdVhfrMxuHbCbroMcQ1bxUCGdGNkmBjVHKBb
         Eeo6cWAQybElh9DPS0X5nUbQar/ZvEIpcSxG9xlySBC2JWu1BhrfHDNdz/Wy0FzMVCnV
         FR3CyhlPTBpvoTgjNke1e+/q3upOGL6PRtwn7usFDzVicz+czo2k21A2rob02nKomZhN
         sQbquiFVDqtyIzq5K2hqKMANSAJjypMTrqhv2EJdY1ImYTs5eRw/PmQgyW3Wg7LKBziw
         ZGaA==
X-Gm-Message-State: AAQBX9dtxusKCeBDvlJZ9Z0N2XiPOtleUsAZ5jO7XUQKFLA2hPa6nXGq
        ubauvHudfjB25MOxkmOldmcJNtykvr/xprGG0Nc=
X-Google-Smtp-Source: AKy350ZH/6vFcB2/xGFk6J8RX93M3DuDN2oBMUZauFTHESsIDjo8i5yw7kynNzOaJvQnXVI/L4Az+w==
X-Received: by 2002:a92:d344:0:b0:324:7d63:8622 with SMTP id a4-20020a92d344000000b003247d638622mr5493833ilh.2.1682349877217;
        Mon, 24 Apr 2023 08:24:37 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id i28-20020a023b5c000000b003acde48bdc3sm3286716jaf.111.2023.04.24.08.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:24:34 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-316d901b2ecso1073025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:24:34 -0700 (PDT)
X-Received: by 2002:a92:ca0a:0:b0:32a:7910:6ea6 with SMTP id
 j10-20020a92ca0a000000b0032a79106ea6mr527671ils.5.1682349853334; Mon, 24 Apr
 2023 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CAP-5=fUB1e=bJk-w0i8+MEo4sLOZtb_Eb7FMy4u7ky7D2AZm6A@mail.gmail.com>
In-Reply-To: <CAP-5=fUB1e=bJk-w0i8+MEo4sLOZtb_Eb7FMy4u7ky7D2AZm6A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 08:23:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
Message-ID: <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Ian Rogers <irogers@google.com>
Cc:     ravi.v.shankar@intel.com, Andi Kleen <ak@linux.intel.com>,
        ricardo.neri@intel.com, Stephane Eranian <eranian@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Will Deacon <will@kernel.org>, ito-yuichi@fujitsu.com,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Marco Elver <elver@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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

On Fri, Apr 21, 2023 at 6:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Apr 21, 2023 at 3:54=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that can be enabled on SMP systems
> > that don't have an arch provided one or one implemented atop perf by
> > using interrupts on other cpus. Each cpu will use its softlockup
> > hrtimer to check that the next cpu is processing hrtimer interrupts by
> > verifying that a counter is increasing.
> >
> > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > easily provide a backtrace on the CPU that locked up. It relies on
> > some other mechanism in the system to get information about the locked
> > up CPUs. This could be support for NMI backtraces like [1], it could
> > be a mechanism for printing the PC of locked CPUs like [2], or it
> > could be something else.
> >
> > This style of hardlockup detector originated in some downstream
> > Android trees and has been rebased on / carried in ChromeOS trees for
> > quite a long time for use on arm and arm64 boards. Historically on
> > these boards we've leveraged mechanism [2] to get information about
> > hung CPUs, but we could move to [1].
> >
> > NOTE: the buddy system is not really useful to enable on any
> > architectures that have a better mechanism. On arm64 folks have been
> > trying to get a better mechanism for years and there has even been
> > recent posts of patches adding support [3]. However, nothing about the
> > buddy system is tied to arm64 and several archs (even arm32, where it
> > was originally developed) could find it useful.
> >
> > [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.=
org
> > [2] https://issuetracker.google.com/172213129
> > [3] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lec=
opzer.chen@mediatek.com/
>
> There is another proposal to use timers for lockup detection but not
> the buddy system:
> https://lore.kernel.org/lkml/20230413035844.GA31620@ranerica-svr.sc.intel=
.com/
> It'd be very good to free up the counter used by the current NMI watchdog=
.

Thanks for the link!

Looks like that series is x86 only, so I think that ${SUBJECT} patch
should still move forward since it provides a solution that is generic
across any platform. I guess the question is: if the buddy system gets
landed then is the HPET series still worthwhile? I guess the answer to
that would depend on whether the HPET-based watchdog has any
advantages over the buddy system.

I'd imagine that there could be some cases where the HPET system could
detect lockups that the buddy system can't. If _all_ CPUs in the
system have interrupts disabled then the buddy system won't be able to
run, but the HPET system could run. That's a win for the HPET system.
That being said, I guess I could imagine that there could be lockups
that the buddy system could detect that the HPET system couldn't. The
HPET system seems to have a single CPU in charge of processing the
main NMI and then that single CPU is in charge of checking all the
others. If that single CPU goes out to lunch then the system couldn't
detect hard lockups.

In any case, I'm happy to let others debate about the HPET system. For
now, I'll take my action items to be:

1. Modify the patch description and KConfig to include some of the
same advantages that the HPET patch series talks about (freeing up
resources).

2. Increase my CC list for the next version even more to include the
people you added to this thread who have been working on the HPET
patch series.

-Doug
