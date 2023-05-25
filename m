Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E907B711AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbjEYXds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjEYXdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:33:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71F10F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:33:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75b0b5c9eb8so22577185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685057622; x=1687649622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=h2QNJoLU7LdCW/4JD6SbgHcvP1akj3osxm8wAuqq0zB9rXyYxSnU1Ic8kk9sFsn/r9
         /YxkgNuWsOwf4Ob5cIVmkFZ+3ZH4Af6Nzqk4ZeHgXC0ZgeBc1c7JbzF7pWUmSKHI41zx
         nA3tYraGJSKdkAtwkG55wZ2fxmjB8oykQZP5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057622; x=1687649622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=Ys/k5mpsjnbKHjzCMC6RbUeweLwsD4Ne9WqjKMNoTFrnXrYGYSPtbontbwItEe+X9C
         Dk/TZu2lQsjQ4iS/KyQv1HrwrLV5iNvN7dwPrgTh6fYUG/hS6tb8Ctq70X38xSus/Azv
         UIIvcUrMWPzNhIife/ZCC903zzKJ3j1VwTDbJVMcfkmFvNAbuaaMi+j1kDrEes2+4WuN
         3PrUcNO6tNyqcgcv35/4BKTuBVBHTbO9bCkeUH1euvHCtGmXvk+xWF7UpjICWKEdUkwQ
         NK6hWpuntrwEa/6Wf7K1JOuN4uLoGE4Iy0LWKz3I682F94IsT67RRDgaDPWdXqccHkbB
         AIEQ==
X-Gm-Message-State: AC+VfDztpLhw8QNdcpmiQ+H+TkDo1wzU1EMMdK/cNmhQaeRUc4Ve+Mxh
        Ecyjen7OBEMcplqKQfduHjm7tFix9WnYRNldT2I=
X-Google-Smtp-Source: ACHHUZ4LQEHh6vh6H8YVJhtmxtEJ2AyflfaxHoIm35SlT9SelHW+JRWoV884a2CsTW3hgIlzxVMo7A==
X-Received: by 2002:a05:620a:828a:b0:75b:23a0:e7eb with SMTP id ox10-20020a05620a828a00b0075b23a0e7ebmr248236qkn.76.1685057622506;
        Thu, 25 May 2023 16:33:42 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id m3-20020ae9e003000000b0075785052e97sm740228qkk.95.2023.05.25.16.33.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:33:41 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f51ea3a062so41241cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:33:41 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c84:b0:331:a582:1c63 with SMTP id
 w4-20020a056e021c8400b00331a5821c63mr3274ill.3.1685057600304; Thu, 25 May
 2023 16:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.12.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid> <ZG4TW--j-DdSsUO6@alley>
In-Reply-To: <ZG4TW--j-DdSsUO6@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 16:33:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/18] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
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

On Wed, May 24, 2023 at 6:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:36, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED =3D> WATCHDOG_HARDLOCKUP_ENABLED
> > - SOFT_WATCHDOG_ENABLED =3D> WATCHDOG_SOFTOCKUP_ENABLED
> > - watchdog_nmi_ =3D> watchdog_hardlockup_
> > - nmi_watchdog_available =3D> watchdog_hardlockup_available
> > - nmi_watchdog_user_enabled =3D> watchdog_hardlockup_user_enabled
> > - soft_watchdog_user_enabled =3D> watchdog_softlockup_user_enabled
> > - NMI_WATCHDOG_DEFAULT =3D> WATCHDOG_HARDLOCKUP_DEFAULT
> >
> > Then update a few comments near where names were changed.
> >
> > This is specifically to make it less confusing when we want to
> > introduce the buddy hardlockup detector, which isn't using NMIs. As
> > part of this, we sanitized a few names for consistency.
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -30,17 +30,17 @@
> >  static DEFINE_MUTEX(watchdog_mutex);
> >
> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WAT=
CHDOG)
> > -# define NMI_WATCHDOG_DEFAULT        1
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 1
> >  #else
> > -# define NMI_WATCHDOG_DEFAULT        0
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 0
> >  #endif
> >
> >  unsigned long __read_mostly watchdog_enabled;
> >  int __read_mostly watchdog_user_enabled =3D 1;
> > -int __read_mostly nmi_watchdog_user_enabled =3D NMI_WATCHDOG_DEFAULT;
> > -int __read_mostly soft_watchdog_user_enabled =3D 1;
> > +int __read_mostly watchdog_hardlockup_user_enabled =3D WATCHDOG_HARDLO=
CKUP_DEFAULT;
> > +int __read_mostly watchdog_softlockup_user_enabled =3D 1;
>
> I still see nmi_watchdog_user_enabled and soft_watchdog_user_enabled
> in include/linux/nmi.h. They are declared there and also mentioned
> in a comment.
>
> It seems that they do not actually need to be declared there.
> I guess that it was need for the /proc stuff. But it was
> moved into kernel/watchdog.c by the commit commit dd0693fdf054f2ed37
> ("watchdog: move watchdog sysctl interface to watchdog.c").
>
> >  int __read_mostly watchdog_thresh =3D 10;
> > -static int __read_mostly nmi_watchdog_available;
> > +static int __read_mostly watchdog_hardlockup_available;
> >
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits =3D cpumask_bits(&watchdog_cpumas=
k);
>
> Otherwise, I like the changes.
>
> With the following:
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 83076bf70ce8..d14fe345eae9 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -17,8 +17,6 @@ void lockup_detector_soft_poweroff(void);
>  void lockup_detector_cleanup(void);
>
>  extern int watchdog_user_enabled;
> -extern int nmi_watchdog_user_enabled;
> -extern int soft_watchdog_user_enabled;
>  extern int watchdog_thresh;
>  extern unsigned long watchdog_enabled;
>
> @@ -68,8 +66,8 @@ static inline void reset_hung_task_detector(void) { }
>   * 'watchdog_enabled' variable. Each lockup detector has its dedicated b=
it -
>   * bit 0 for the hard lockup detector and bit 1 for the soft lockup dete=
ctor.
>   *
> - * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
> - * 'soft_watchdog_user_enabled' are variables that are only used as an
> + * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
> + * 'watchdog_softlockup_user_enabled' are variables that are only used a=
s an
>   * 'interface' between the parameters in /proc/sys/kernel and the intern=
al
>   * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
>   * handled differently because its value is not boolean, and the lockup
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Even better might be to remove the unused declaration in a separate
> patch. I think that more declarations are not needed after moving
> the /proc stuff into kernel/watchdog.c.
>
> But it might also be fixed later.

Breadcrumbs: I squashed your suggestion together with Tom's patch and
posted the result:

https://lore.kernel.org/r/20230525162822.1.I0fb41d138d158c9230573eaa37dc56a=
fa2fb14ee@changeid

-Doug
