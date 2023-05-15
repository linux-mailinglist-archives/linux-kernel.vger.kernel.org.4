Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAB704150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbjEOXMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbjEOXMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:12:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31B7ECA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:12:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52c6f81193cso9318016a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684192350; x=1686784350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqtkImGxR85aToYA0Aq0yuOc2duxdpDWQf3A/P/lpm0=;
        b=EdpFL+KZLlPHxw7rdjvVXbXUuGZfNi+/txxDwb8/GUnWMKryAVgNAPfTyWLf95UuC2
         LceIckU1uO2wknsEqjz4eC65SYWIzkiK5m7Iue2lVvGDWpLPfav2XA1RpgsaKuVuFBTs
         2XUoBopBvZwWeOMZrM2i5ipVzRFDhrCn6+9eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192350; x=1686784350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqtkImGxR85aToYA0Aq0yuOc2duxdpDWQf3A/P/lpm0=;
        b=EJa9FHXJQ4Cpr4oVvnlzNClJ3oU1zVGwiSkL6oIOLvT42ufB0bXDJ4Ma69Rrvdsczh
         1RelnKgo5CfIQTQ2VwezH02EHrRVOJ8uM2fBqUGK2zEw78Vbd4mdRrgLK2Bs9V4y395b
         B4OAXzwxifYZrSmwpHH4ESWp/YBnGV5zeADdfiP6GRe/dKjb5UO4Ng7EQ5frG6qTAjUR
         t4R6bF4jsskUMTUsayPW04/1D2pYkKVsvt0iTToAHqYCrI1+jTYSM7S/H8au6FS3GcfU
         2uww4HEzV+l/Nj/flDeJdJta12n4lYE+5O+Afgss3Sk3ibnv1HyscZdHJD3U5ta/tH3+
         BT7g==
X-Gm-Message-State: AC+VfDwXm2tlMjW9nynawPviVjUE1nEJhy5ewwcVQrkZ8LdPCOsKAUzh
        pTynjqrCpnWWvYqT6Tw9nc+JpM+SUAEsfMEdXH8=
X-Google-Smtp-Source: ACHHUZ6tF43RkIT4ExYh8gNDzEWJpOCKd+KQpRoyR3RaNERcSsRfRlSWPf5IdQjV/nDnb5eEJVN4FA==
X-Received: by 2002:a17:90b:1296:b0:246:af1f:62ef with SMTP id fw22-20020a17090b129600b00246af1f62efmr33459260pjb.5.1684192349981;
        Mon, 15 May 2023 16:12:29 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090a9bc500b002367325203fsm129417pjw.50.2023.05.15.16.12.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:12:29 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1a950b982d4so773595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:12:29 -0700 (PDT)
X-Received: by 2002:ac8:5c48:0:b0:3f3:8b28:f0b4 with SMTP id
 j8-20020ac85c48000000b003f38b28f0b4mr67302qtj.18.1684192327980; Mon, 15 May
 2023 16:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <20230512140051.GA217273@aspen.lan>
In-Reply-To: <20230512140051.GA217273@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 16:11:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPy5kA7mJteY+YzHa2ExvBKHvxR9SnM=qxxKwXbTNHkw@mail.gmail.com>
Message-ID: <CAD=FV=UPy5kA7mJteY+YzHa2ExvBKHvxR9SnM=qxxKwXbTNHkw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] arm64: kgdb: Roundup cpus using IPI as NMI
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
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
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 7:00=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 19, 2023 at 03:56:03PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > leveraged to roundup CPUs which are stuck in hard lockup state with
> > interrupts disabled that wouldn't be possible with a normal IPI.
> >
> > So instead switch to roundup CPUs using IPI turned as NMI. And in
> > case a particular arm64 platform doesn't supports pseudo NMIs,
> > it will switch back to default kgdb CPUs roundup mechanism.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm64/kernel/ipi_nmi.c |  5 +++++
> >  arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > index c592e92b8cbf..2adaaf1519e5 100644
> > --- a/arch/arm64/kernel/ipi_nmi.c
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/kgdb.h>
> >  #include <linux/nmi.h>
> >  #include <linux/smp.h>
> >
> > @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t=
 *mask, bool exclude_self)
> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >  {
> >       irqreturn_t ret =3D IRQ_NONE;
> > +     unsigned int cpu =3D smp_processor_id();
>
> Does this play nice with CONFIG_DEBUG_PREEMPT? I may have missed
> something about the NMI entry but a quick scan of the arm64
> arch_irq_disabled() suggests that debug_smp_processor_id() will issue
> warnings at this point...
>
> Other than I didn't see anything I don't like here.

Good question. It seems to, at least on the sc7180-trogdor-based
system I tested.

Just to confirm, I printed out the values of some of the stuff that's
checked. When this function was called, I saw:

irqs_disabled() =3D> true
raw_local_save_flags() =3D> 0x000000f0
__irqflags_uses_pmr() =3D> 1

The "__irqflags_uses_pmr" is the thing that gets set when we try to
enable pseudo-NMIs and they're actually there. That causes us to call
__pmr_irqs_disabled_flags() which will compare the flags (0xf0) to
GIC_PRIO_IRQON (0xe0). If flags is not the same as GIC_PRIO_IRQON then
interrupts are disabled.

...so, assuming I understood everything, I think we're OK.

I also tried to see what happened with the whole "fallback to use
regular IPIs if we don't have pseudo-NMIs enabled" (AKA patch #10 in
this series). In that case, I had:

irqs_disabled() =3D> true
raw_local_save_flags() =3D> 0x000000c0
__irqflags_uses_pmr() =3D> 0

...in this case we end up in __daif_irqs_disabled_flags(). That checks
to see if the flags (0xc0) has the "I bit" (0x80) set. It is set, so
interrupts are disabled.

-Doug
