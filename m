Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D569470415F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbjEOXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbjEOXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:21:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11449D4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:21:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f4c8d78a18so69248721cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684192906; x=1686784906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHuslTqJZ+9z+0LpFkq3T91ljIFdmNLjNbw3NtdKpY8=;
        b=m2bpTgeWxIFgPnEMmTLsiTsij3zg26LgwNedMkYGqG57KvylXN+UzzP+x4bvOVAxRH
         VhvtcP2s15GFmUZRXfRqjAmlcKZaNSReHRq9VWZIB8L41NYHZnaWAleD5U8gKt5cCQFo
         h5P/Zh7eH/XFI+rSE3pOlfulg5rQ5zNFNooqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192906; x=1686784906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHuslTqJZ+9z+0LpFkq3T91ljIFdmNLjNbw3NtdKpY8=;
        b=V9Qz3j+8Ri/3Pw5SVQTU7TefsDpmsTBouHJXewaqXI97od8k7qMc+e1wsKsbI/lXYz
         n+02b15XcndQeFTPVE9V9O9M0kJymfNKqLhfKT+7z8V3HFv0S7Wf7okb/viYTIKKOxw/
         b8zvoMMRwAFtgdPrPocubd+mBDeKH57yZ9xIQ+oYY5PU+xY57+UuzYL0EIG0iJKXyIg8
         /YznXIGWnF1o6TTWsHYWL7ArdvFChzXIGY50cSU8KQB0d0H1nq94j71TTvHklmntvCDK
         jK4wU2BzPdocTR9HoekBYW/BWVjDu/VEfzdUeoyuDHLFPq6/SfgbJ3zRGRdVhVaY878F
         U5aw==
X-Gm-Message-State: AC+VfDzvWizccG2/u6dyvRHrtJ8kRLjH8FmQhn4tSr2rk5lG2fjtMc7F
        ltILUdmQx65ax987pxTJqzyQS8zs0IvN1lN8FQ0=
X-Google-Smtp-Source: ACHHUZ5MG3INq23WpG9EvHoeqb7Mj6EfEEaqMnaaD0X3R9Rxy01D3owBqvIwdYGdyNA9SSYLBtMCtQ==
X-Received: by 2002:ac8:5a85:0:b0:3ef:3af7:1c43 with SMTP id c5-20020ac85a85000000b003ef3af71c43mr51406589qtc.65.1684192906726;
        Mon, 15 May 2023 16:21:46 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id b14-20020ac801ce000000b003e3895903bfsm5752234qtg.8.2023.05.15.16.21.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:21:45 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f51ea3a062so373661cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:21:44 -0700 (PDT)
X-Received: by 2002:a05:622a:88:b0:3f3:9c91:fee7 with SMTP id
 o8-20020a05622a008800b003f39c91fee7mr75321qtw.16.1684192903654; Mon, 15 May
 2023 16:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
 <20230512134853.GA216623@aspen.lan>
In-Reply-To: <20230512134853.GA216623@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 16:21:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
Message-ID: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] kgdb: Expose default CPUs roundup fallback mechanism
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
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 6:49=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> > mechanism to a particular archichecture as a runtime fallback if it
> > detects to not support NMI roundup.
> >
> > Currently such an architecture example is arm64 supporting pseudo NMIs
> > feature which is only available on platforms which have support for GIC=
v3
> > or later version.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  include/linux/kgdb.h      | 12 ++++++++++++
> >  kernel/debug/debug_core.c |  8 +++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 258cdde8d356..87713bd390f3 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
> >
> >  extern void kgdb_call_nmi_hook(void *ignored);
> >
> > +/**
> > + *   kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> > + *                            round-up CPUs
> > + *
> > + *   If you're using the default implementation of kgdb_roundup_cpus()
> > + *   this function will be called.  And if an arch detects at runtime =
to
> > + *   not support NMI based roundup then it can fallback to default
> > + *   mechanism using this API.
> > + */
> > +
> > +extern void kgdb_smp_call_nmi_hook(void);
>
> Concept looks sensible but this is a terrible name for aa command to
> round up the CPUs using smp_call... functions. Whilst it is true it that
> kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
> doesn't mean we should name functions after it. They should be named
> after what they are do, not how they do it.
>
> Something more like kgdb_roundup_cpus_with_smp_call() would be a much
> better name.

Sounds good. I'm happy to spin with this rename, though I was kinda
hoping to drop ${SUBJECT} patch if folks were OK with patch #10 in
this series [1]. I personally think that's the right way to go but
it's unclear to me if arm64 maintainers will think it's a hack
(despite the fact that arm32 implements the "nmi" functions with
regular IPIs).

For now, maybe I'll think positive thoughts and hope that folks will
have the time to review the series soon. If another few weeks go by
then I'll send a v9 with just your comments addressed. If nothing
else, maybe you can land the kgdb parts in a tree targeting v6.5 and
then when arm64 folks have the bandwidth then it will be easier to get
them landed.

[1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc=
3afcdfd88d7a5f030@changeid


-Doug
