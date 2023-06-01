Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260B271F521
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjFAVyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:54:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E5719B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:54:32 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f6b20ad49dso11326371cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685656471; x=1688248471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eogoQvqQO6ZvyvYBhcgWNYvozKgAFgLZqqjPS4QzrXk=;
        b=aHaZO8ZGPwPhTZMw4aI0T6glLAvzzmbSmgbiitBFarz02pIOheFeoH32W0ZGsxr2iU
         MOjc9xXdnItFCu3xyPNw2qhW6QKs/LCYGbWtklsdTTkMJkuFJyShD4iZInnIvl+SoQXI
         oLVfWFJGL+55hGrG0syYPhn7ab1aa+/jNG9As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685656471; x=1688248471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eogoQvqQO6ZvyvYBhcgWNYvozKgAFgLZqqjPS4QzrXk=;
        b=etZtnDaC3fO4n/UHXVrdSqvO56UOC31SSrBoJ43wwtqF+mj0jHd+stQfzd/8J2US9d
         sAXMUL+qvOhNlESOGDRqX/6D1rQTN6ck0lGrCkiZcH19jknwODR6RHPPzNn7yWn2BpE8
         XP59SZB4RYIb1mha+24N6FivJZJdgJ12xp1Ay//wE6otsr+unWHeGYoaz8N7nsRiRFp0
         9tAHHKCY7eP9D8PbOe0Tt96f3kXnWXQy/TAO4paofrkkAlRmP3ZYZbaCkX6+CExBsQuK
         tc7rujbSdVhW1rkzGZ4thSusIZ0Chfoz1IPT4RF159wtliaZ7eK7ZnkVK9cBS6JkfJt8
         nzDg==
X-Gm-Message-State: AC+VfDz6F3+YP8bMqvB5s0EZ6+yyMUq2uyeU4OXxBmEWOcJ0Ki66dRH8
        3jNL+wCikFNzvJCHjVcCkf6EnAoeA0yI6ZxalEQ=
X-Google-Smtp-Source: ACHHUZ5+jo8GHRrr5CBZX2eEn7GXLv+isNn4E+jh4bSVbg2ZAGUycFpN6nHpXOzf8AQmjwAPiYygKw==
X-Received: by 2002:a05:622a:24d:b0:3f6:af73:3c59 with SMTP id c13-20020a05622a024d00b003f6af733c59mr12800698qtx.58.1685656471687;
        Thu, 01 Jun 2023 14:54:31 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id ch6-20020a05622a40c600b003f5352907a5sm8213450qtb.88.2023.06.01.14.54.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 14:54:31 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f81ffc9065so23771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:54:31 -0700 (PDT)
X-Received: by 2002:a05:6e02:214e:b0:33b:3d94:afb5 with SMTP id
 d14-20020a056e02214e00b0033b3d94afb5mr11901ilv.25.1685656080333; Thu, 01 Jun
 2023 14:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
 <20230512134853.GA216623@aspen.lan> <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
In-Reply-To: <CAD=FV=W4owWm4pVhXWKJpjFj75E=hzYkOZ6ZrZu2DqUF8Nt0cw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Jun 2023 14:47:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLAMv1rHiWWAoP8aTCpjWyzuHRuZtYAQRP3BwxFY0YNQ@mail.gmail.com>
Message-ID: <CAD=FV=WLAMv1rHiWWAoP8aTCpjWyzuHRuZtYAQRP3BwxFY0YNQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 15, 2023 at 4:21=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, May 12, 2023 at 6:49=E2=80=AFAM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> > > mechanism to a particular archichecture as a runtime fallback if it
> > > detects to not support NMI roundup.
> > >
> > > Currently such an architecture example is arm64 supporting pseudo NMI=
s
> > > feature which is only available on platforms which have support for G=
ICv3
> > > or later version.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  include/linux/kgdb.h      | 12 ++++++++++++
> > >  kernel/debug/debug_core.c |  8 +++++++-
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > > index 258cdde8d356..87713bd390f3 100644
> > > --- a/include/linux/kgdb.h
> > > +++ b/include/linux/kgdb.h
> > > @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffe=
r,
> > >
> > >  extern void kgdb_call_nmi_hook(void *ignored);
> > >
> > > +/**
> > > + *   kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> > > + *                            round-up CPUs
> > > + *
> > > + *   If you're using the default implementation of kgdb_roundup_cpus=
()
> > > + *   this function will be called.  And if an arch detects at runtim=
e to
> > > + *   not support NMI based roundup then it can fallback to default
> > > + *   mechanism using this API.
> > > + */
> > > +
> > > +extern void kgdb_smp_call_nmi_hook(void);
> >
> > Concept looks sensible but this is a terrible name for aa command to
> > round up the CPUs using smp_call... functions. Whilst it is true it tha=
t
> > kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
> > doesn't mean we should name functions after it. They should be named
> > after what they are do, not how they do it.
> >
> > Something more like kgdb_roundup_cpus_with_smp_call() would be a much
> > better name.
>
> Sounds good. I'm happy to spin with this rename, though I was kinda
> hoping to drop ${SUBJECT} patch if folks were OK with patch #10 in
> this series [1]. I personally think that's the right way to go but
> it's unclear to me if arm64 maintainers will think it's a hack
> (despite the fact that arm32 implements the "nmi" functions with
> regular IPIs).
>
> For now, maybe I'll think positive thoughts and hope that folks will
> have the time to review the series soon. If another few weeks go by
> then I'll send a v9 with just your comments addressed. If nothing
> else, maybe you can land the kgdb parts in a tree targeting v6.5 and
> then when arm64 folks have the bandwidth then it will be easier to get
> them landed.
>
> [1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522=
fc3afcdfd88d7a5f030@changeid

Breadcrumbs: I've dropped this patch and several others in v9 [1] by
embracing the idea of using a normal IPI as a fallback.

[1] https://lore.kernel.org/r/20230601213440.2488667-1-dianders@chromium.or=
g/
