Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D76ED1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjDXPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjDXPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:48:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD7183E6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:48:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-760ed95b9e6so100295639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682351314; x=1684943314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxcjgeLi5mR/+Rnc6mrQlDv9TmBqIx7WXWMzAgilAKE=;
        b=GrilttQIBtixqe5NQCftFI28cpKq89pHISF0NLxKcDgwY0XBw99bzQjkJW49DzkUrJ
         5fShbW47Ce7KY5A9oJvbnITjc6ZfCiLOGCzC2rlrHkzxDqC2XyWzxEWGnYuISNkM2XES
         RpfeY1AnW+ysoweFBeek5JD/O+twCi29z3H/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351314; x=1684943314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxcjgeLi5mR/+Rnc6mrQlDv9TmBqIx7WXWMzAgilAKE=;
        b=a8MO5oNfHdJ4aM1HepIB6v/Ptqt9nvJqXwGGhicKJxlBVZiuuFowKV7y7iDuxcOlsE
         Gl61ZE6VjvSLKbjwYpp1LZf3cKpMjYGNd/xohR6LsysroorXpRI50Yg5KWiCfe6/trig
         Nhmqol19fZPV76ig/cindBPqnwGhqq6xgRZJSa0Y0rJvwOVrOdDGKNgkx5BMyGszzxhp
         TBNTVG4EfLfabme1Lz71ljyr5fEY6babynevWEowioMBuEO2M2e+aAUHIrh0n+sKHTHo
         +M6/H+n6jlJuq56/oJWeHS1b2cZee6Qtu8PC56/mhbsjyKCzQ8QYa//CrW1YBoqfQRBs
         XD8g==
X-Gm-Message-State: AAQBX9c4VHsKQLUXMLJHsP+7xCQXv7doxgkYYLoQi5l24rI//NO3dfJs
        enhYNUA15DygVfRjSuLWQqqwtXWluWvdAo8NPSA=
X-Google-Smtp-Source: AKy350Zm9osI5zeEpTrgLqTH2iVLm20qTOTxJnSuf3EjnKONj4TZcDnPm/GUSThvz+I57LmKLFnsJQ==
X-Received: by 2002:a6b:db0a:0:b0:74c:b348:738 with SMTP id t10-20020a6bdb0a000000b0074cb3480738mr6201446ioc.11.1682351314543;
        Mon, 24 Apr 2023 08:48:34 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id r23-20020a5d96d7000000b007079249a9d1sm3339789iol.34.2023.04.24.08.48.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:48:34 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-328cb023b1dso1064545ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:48:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:1606:b0:315:8e3a:f546 with SMTP id
 t6-20020a056e02160600b003158e3af546mr480218ilu.6.1682350901412; Mon, 24 Apr
 2023 08:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <20230424125355.GA4054@aspen.lan>
In-Reply-To: <20230424125355.GA4054@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 08:41:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
Message-ID: <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
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

On Mon, Apr 24, 2023 at 5:54=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Apr 21, 2023 at 03:53:30PM -0700, Douglas Anderson wrote:
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
>
> On the Arm platforms is this code able to leverage the existing
> infrastructure to extract status from stuck CPUs:
> https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html

Yup! I wasn't explicit about this, but that's where you end up if you
follow the whole bug tracker item that was linked as [2].
Specifically, we used to have downstream patches in the ChromeOS that
just reached into the coresight range from a SoC specific driver and
printed out the CPU_DBGPCSR. When Brian was uprevving rk3399
Chromebooks he found that the equivalent functionality had made it
upstream in a generic way through the coresight framework. Brian
confirmed it was working on rk3399 and made all of the device tree
changes needed to get it all hooked up, so (at least for that SoC) it
should work on that SoC.

[2] https://issuetracker.google.com/172213129
