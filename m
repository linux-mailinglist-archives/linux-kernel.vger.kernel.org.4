Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840236FE603
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEJVNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjEJVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:13:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737802106
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:13:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f3faefc92cso12854841cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683753222; x=1686345222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyh0bxNbQysRLzMlyvYUgAW6FOR/Pp87rMETzWIkR6k=;
        b=A14StfHdbkJKZijkez2+/BYgu2IMYbzv/P21/kjZFWp1g4RoZeEzjKp1cxUkKodOL0
         qzASJwzDrMNFXfkQG5Dtqu9ETy00/6BO3ag2CRkK9qijVNyT1R/mB820lOby+iW6bcRp
         AlwMMqXSov2FRXwp0N2fts4G5MCOHziDqXwkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753222; x=1686345222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyh0bxNbQysRLzMlyvYUgAW6FOR/Pp87rMETzWIkR6k=;
        b=SVxDctzkU8kSvUP4nt1/IeFbiM6QO7i1sRz51o5Y32Nl6Bsf99//yOuQL1+tsrVASO
         1QoNNmYvT8/lq8MlcsdEm37w/72mZG0Jp/n7z/QsDkop26OsUIIHkwSKBgAOVgOEWIaH
         N/NByHNd5aXMWGg5lO/Zwv9bGy17JlXBHuPJ18xRBCZi/BHiEkPddR4vMfnQpRkwFpBf
         u9F/9/p5XLFrp0kgQYCplfEF3Ldlqzn1qaY3jpj2iFHv+NcEfKQIeR3mPc92jYfRHsY9
         XlXczgisWcHdZ/aileUDpuBOx5pg4c2xAhzWGGd4pIzpX+s7Btvrof5slWIqIV4FmJHc
         f7Nw==
X-Gm-Message-State: AC+VfDyM2zyT3+pUL0tCCVCA9yallNFfnlGZ2Y0V4XHUxYaExfZy2hhR
        DrWOSHA6i5t4oN9xCbS5H4N2EXKys6BjmEg74kGWBA==
X-Google-Smtp-Source: ACHHUZ4VfjrbqB8uct6MonhZRXQnK6FmgLJfpzI9F6IpGl27hGZDjc/yZMyqoTtRa5rxnTBqH0qaSw==
X-Received: by 2002:ac8:5dcd:0:b0:3ef:5981:2e96 with SMTP id e13-20020ac85dcd000000b003ef59812e96mr30885068qtx.4.1683753222188;
        Wed, 10 May 2023 14:13:42 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id p26-20020ac8409a000000b003ef58044a4bsm34369qtl.34.2023.05.10.14.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:13:41 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f396606ab0so608091cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:13:41 -0700 (PDT)
X-Received: by 2002:ac8:5c12:0:b0:3f2:1441:3c11 with SMTP id
 i18-20020ac85c12000000b003f214413c11mr120377qti.2.1683753200902; Wed, 10 May
 2023 14:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.6.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
 <ZFvJqIYo00vfqRiB@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZFvJqIYo00vfqRiB@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 May 2023 14:13:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuONtodLgMSubLANywT1LVd2T3PQHxm18EN090YnrkNw@mail.gmail.com>
Message-ID: <CAD=FV=WuONtodLgMSubLANywT1LVd2T3PQHxm18EN090YnrkNw@mail.gmail.com>
Subject: Re: [PATCH v8 06/10] arm64: idle: Tag the arm64 idle functions as __cpuidle
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 9:43=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Apr 19, 2023 at 03:56:00PM -0700, Douglas Anderson wrote:
> > As per the (somewhat recent) comment before the definition of
> > `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> > can be identified by cpu_in_idle(). Let'a add this.
> >
> > After doing this then when we dump stack traces of all processors
> > using nmi_cpu_backtrace() then instead of getting useless backtraces
> > we get things like:
> >
> >   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98
>
> As a heads-up, this is only going to work in the trivial case where a CPU=
 is
> within the default cpu_do_idle(), and not for anything using PSCI
> cpu_suspend() (which I'd *really* hope is the common case).

Thanks for the review and the heads up! Right. It only catches shallow
idle. Specifically this was the stack trace when it was "caught" on a
sc7180-trogdor device:

 cpu_do_idle+0x94/0x98
 psci_enter_idle_state+0x58/0x70
 cpuidle_enter_state+0xb8/0x260
 cpuidle_enter+0x44/0x5c
 do_idle+0x188/0x30c
 ...

I checked in kgdb and saw that "psci_enter_idle_state()" had "idx" as
0, which makes sense since __CPU_PM_CPU_IDLE_ENTER will directly call
cpu_do_idle() when idx is 0.

I agree that it doesn't catch every case. Certainly it's not too hard
to see a CPU here:

 gic_cpu_sys_reg_init+0x1f8/0x314
 gic_cpu_pm_notifier+0x40/0x78
 raw_notifier_call_chain+0x5c/0x134
 cpu_pm_notify+0x38/0x64
 cpu_pm_exit+0x20/0x2c
 psci_enter_idle_state+0x48/0x70
 cpuidle_enter_state+0xb8/0x260
 cpuidle_enter+0x44/0x5c
 do_idle+0x188/0x30c
 ...

...and kgdb showed "idx" was 3.

That being said, catching some of the cases is better than catching
none of the cases. ;-)

In reality, I've seen cases where it catches most CPUs. For instance,
running soon after bootup on my sc7180-trogdor device:

echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

...and then having the "buddy" hardlockup detector [1] catch the crash
caught all of the CPUs other than the one that was locked up and the
one that detected it. Specifically:

NMI backtrace for cpu 2 skipped: idling at cpu_do_idle+0x94/0x98
NMI backtrace for cpu 1 skipped: idling at cpu_do_idle+0x94/0x98
NMI backtrace for cpu 0 skipped: idling at cpu_do_idle+0x94/0x98
NMI backtrace for cpu 3 skipped: idling at cpu_do_idle+0x94/0x98
NMI backtrace for cpu 4 skipped: idling at cpu_do_idle+0x94/0x98
NMI backtrace for cpu 7 skipped: idling at cpu_do_idle+0x94/0x98

I haven't analyzed it, but I guess it's possible that when the buddy
hardlockup detector triggers that other CPUs are more likely to be in
a shallow idle? Certainly I seem to catch a lot more CPUs in a shallow
idle in buddy lockup reports...


[1] https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.or=
g


> That doesn't get inlined, and the invocation is shared with other SMCCC u=
sers,
> so we probably need more work there if culling idle backtraces is importa=
nt.

At this point I'd say that we should just take the low hanging fruit
(this patch). If someone later wants to try to do better they can.


> I'm not averse to this change itself.

Any chance you'd be willing to give any tags to it? :-P Do you need me
to add any of the above caveats to the commit message?

I also certainly wouldn't object to this patch landing even if others
aren't ready. It has no dependencies on any other patches and just
makes the debug messages prettier in some cases.

-Doug
