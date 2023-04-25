Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502A6EDAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 06:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDYE6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 00:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYE6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 00:58:14 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1183CB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:58:13 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-779701b7265so1801376241.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682398692; x=1684990692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKKkeNYy26t1TjKVwBgMLbds1eKVkw1hMyFByHcDzQ8=;
        b=dClWn8nq9rhEMd87NqePK0FRmC3PDIyZw3hNI4Y6kWzhsoOdCrl23hkYVmMtLxs0eB
         BAsWynnRwqY4Uo2vZFhLHqfVcBHwutaEM3DB0UweV6tlcoX/qc9tPAOSt26d7bl6hIsE
         hUu9Hw6PAg8ceY58RXg9Sl/hl1RlCY7CY8vhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682398692; x=1684990692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKKkeNYy26t1TjKVwBgMLbds1eKVkw1hMyFByHcDzQ8=;
        b=LUPsfw7hNYjEtY9TNFJecB4hyzX66737R9Bwm2pOIOCQ8kGjdOb2T1PNZVFIJwnTBT
         +CqkP8yh8KIHj0cHIYkPnNnPjvCb4V/IGnOHxlchO1PINMcEZl9Nm8Xl2cFrXr7fFpSL
         sWbI4pR1jna8T+QhUEbBzpKHt6DrMk/x7Nce5DH1zp+2najtUGHFbcVD3LBFoIz5dqG3
         9N8cJBfbPoiK9eoYxhCoy3m0zWIuMyVPupDdg1am0+arOJ3j568Unbdb2kqkX021pzUa
         aBlYjauq2yDv3DF1Gxt+jS2K69QDnGNgWTLFlI0g13GBmNxO2aN94tqy+a+xhArxaRsf
         lrLQ==
X-Gm-Message-State: AAQBX9fNP8wFundi5+lAAXdiUn6ruzj7vLmNDYzLmi+CDVHQTpX9Da+6
        cRl61ovnlV4zn/PqhLMOL5JSzsNRmUAtve8R+ZHggg==
X-Google-Smtp-Source: AKy350YV9yq/BYIVC0vQ1BiX8lbq0Q/kk/Y+qtOenk4wtXVHcFqYgVVennu93j8KBIiSa0redLYnm3nczDpo6ZTYECw=
X-Received: by 2002:a1f:cb02:0:b0:43f:a097:5e8c with SMTP id
 b2-20020a1fcb02000000b0043fa0975e8cmr3429523vkg.16.1682398692723; Mon, 24 Apr
 2023 21:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <20230424125355.GA4054@aspen.lan> <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
In-Reply-To: <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 25 Apr 2023 12:58:01 +0800
Message-ID: <CAGXv+5Gbph1r0u_NVBS7Lg8w8X4Qw0Q=yxmEkJDs4ptOJu2NVA@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:42=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Apr 24, 2023 at 5:54=E2=80=AFAM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Apr 21, 2023 at 03:53:30PM -0700, Douglas Anderson wrote:
> > > From: Colin Cross <ccross@android.com>
> > >
> > > Implement a hardlockup detector that can be enabled on SMP systems
> > > that don't have an arch provided one or one implemented atop perf by
> > > using interrupts on other cpus. Each cpu will use its softlockup
> > > hrtimer to check that the next cpu is processing hrtimer interrupts b=
y
> > > verifying that a counter is increasing.
> > >
> > > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > > easily provide a backtrace on the CPU that locked up. It relies on
> > > some other mechanism in the system to get information about the locke=
d
> > > up CPUs. This could be support for NMI backtraces like [1], it could
> > > be a mechanism for printing the PC of locked CPUs like [2], or it
> > > could be something else.
> > >
> > > This style of hardlockup detector originated in some downstream
> > > Android trees and has been rebased on / carried in ChromeOS trees for
> > > quite a long time for use on arm and arm64 boards. Historically on
> > > these boards we've leveraged mechanism [2] to get information about
> > > hung CPUs, but we could move to [1].
> >
> > On the Arm platforms is this code able to leverage the existing
> > infrastructure to extract status from stuck CPUs:
> > https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
>
> Yup! I wasn't explicit about this, but that's where you end up if you
> follow the whole bug tracker item that was linked as [2].
> Specifically, we used to have downstream patches in the ChromeOS that
> just reached into the coresight range from a SoC specific driver and
> printed out the CPU_DBGPCSR. When Brian was uprevving rk3399
> Chromebooks he found that the equivalent functionality had made it
> upstream in a generic way through the coresight framework. Brian
> confirmed it was working on rk3399 and made all of the device tree
> changes needed to get it all hooked up, so (at least for that SoC) it
> should work on that SoC.
>
> [2] https://issuetracker.google.com/172213129

IIRC with the coresight CPU debug driver enabled and the proper DT nodes
added, the panic handler does dump out information from the hardware.
I don't think it's wired up for hung tasks though.

ChenYu
