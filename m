Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42726F78E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEDWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:17:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C2E41
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:17:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f597c975fso938340a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238620; x=1685830620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzswV8h6Pv5RbnDUfs5XaziOPH7Dg5YP+9HIzH76G84=;
        b=VarhjQRs/Lfrl65kzg5xmVtFY2BWNI4tD5rbg5qlVSsT/roGDAAH0sTvvCdskfbbaJ
         hzIv1roPd0B4fyQe3GnURwx7VOvRQJUOoGif0/o1m8QEeSGq2etRjwyY1aVrCXUGtBJV
         CE9jHPvhFNP5KFO3aWfHcaEDCwopDENvYyXZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238620; x=1685830620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzswV8h6Pv5RbnDUfs5XaziOPH7Dg5YP+9HIzH76G84=;
        b=BMA5xDYyeATP9o/8ZQR0/hDvo1ugl2cvMVprRNT1ZI3Qe7A1+1HNQzGwi9YWrq07Sw
         E4WvT44UWOQfgM+SZnFj7w05Vojbo8t5wDioWLVSI6MtAsKmfdpldBVewBil0A4618Ie
         sVQBB/9nTcBhNhNTxh6wUFahog2UG7lZfnXm71+qRw1ttqJmgGVUjTB/JQdkpbB8pswU
         BmsMrDamN0d7lGsgcuDpRsBX62pp7PyAhAxUFgXq6OdUZTMb4eHlMp4xfuK9QS+xPiFh
         /kGt1bfLgoqQ2loIIZ86czBPQIWe3wtSFLz3C7pqPVoO4ib/1Rmcoa/bwr3XVOWpOqx2
         hTVw==
X-Gm-Message-State: AC+VfDznT9FXE39MBdVuMnjXjGj8ccz/Xi1vgK2FN258yxYpnnsm8Sqk
        PVDAnhYVGl2Osh0ehK6J6XATtGuEB/5k3R4n4Fg=
X-Google-Smtp-Source: ACHHUZ7buWGdT6d/59j3tb3sX6lBn+4uXj+HzVNzD38Semjdl5YbCXyNLJVE5JagH5MZ7A0R2Vn9Bg==
X-Received: by 2002:a17:902:ecc5:b0:1ab:1d81:f8f1 with SMTP id a5-20020a170902ecc500b001ab1d81f8f1mr6329133plh.46.1683238619942;
        Thu, 04 May 2023 15:16:59 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001a804b16e38sm26757pls.150.2023.05.04.15.16.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:16:57 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1aaf702c3ccso490105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 15:16:57 -0700 (PDT)
X-Received: by 2002:a05:622a:144d:b0:3de:1aaa:42f5 with SMTP id
 v13-20020a05622a144d00b003de1aaa42f5mr10116qtx.15.1683238596262; Thu, 04 May
 2023 15:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <ZFEqynvf5nqkzEvQ@alley>
In-Reply-To: <ZFEqynvf5nqkzEvQ@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:16:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1nqunM83LzSXnYiODC66tn5hjSWsUvxabf6vSO7reUQ@mail.gmail.com>
Message-ID: <CAD=FV=V1nqunM83LzSXnYiODC66tn5hjSWsUvxabf6vSO7reUQ@mail.gmail.com>
Subject: Re: cpu hotplug : was: Re: [PATCH v3] hardlockup: detect hard lockups
 using secondary (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 8:23=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Mon 2023-05-01 08:24:46, Douglas Anderson wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
> >
> > --- /dev/null
> > +++ b/kernel/watchdog_buddy_cpu.c
> > +int watchdog_nmi_enable(unsigned int cpu)
> > +{
> > +     /*
> > +      * The new CPU will be marked online before the first hrtimer int=
errupt
> > +      * runs on it.
>
> It does not need to be the first hrtimer interrupt. The CPU might have
> been offlined/onlined repeatedly. The counter might have any value.
>
> > +      * If another CPU tests for a hardlockup on the new CPU
> > +      * before it has run its first hrtimer, it will get a false posit=
ive.
> > +      * Touch the watchdog on the new CPU to delay the first check for=
 at
> > +      * least 3 sampling periods to guarantee one hrtimer has run on t=
he new
> > +      * CPU.
> > +      */

OK, I've updated the above comment to:

/*
 * The new CPU will be marked online before the hrtimer interrupt
 * gets a chance to run on it. If another CPU tests for a
 * hardlockup on the new CPU before it has run its the hrtimer
 * interrupt, it will get a false positive. Touch the watchdog on
 * the new CPU to delay the check for at least 3 sampling periods
 * to guarantee one hrtimer has run on the new CPU.
 */

> > +     per_cpu(watchdog_touch, cpu) =3D true;
>
> We should touch also the next_cpu:
>
>         /*
>          * We are going to check the next CPU. Our watchdog_hrtimer
>          * need not be zero if the CPU has already been online earlier.
>          * Touch the watchdog on the next CPU to avoid false positive
>          * if we try to check it in less then 3 interrupts.
>          */
>         next_cpu =3D watchdog_next_cpu(cpu);
>         if (next_cpu < nr_cpu_ids)
>                 per_cpu(watchdog_touch, next_cpu) =3D true;
>
> Alternative would be to clear watchdog_hrtimer. But it would kind-of
> affect also the softlockup detector.

Looks reasonable. I've incorporated it.
