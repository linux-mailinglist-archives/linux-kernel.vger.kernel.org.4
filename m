Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D5700D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjELQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjELQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BEAD36
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A9B63BC3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFE9C433A1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683909843;
        bh=cCuZX4ujJbA7/yPKfk7OPV+6vTF3PdHT+sv9n8geJhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LDHLU/ZJHBVyQotQOk2VlyorTHZWK3JCHkx1LX4PXNrLGNr4VOQCrgSfflPOoXBag
         AhapF4qsaENACL6H/v22lkRy/eZWmVslCqUn3KDFF3822glhBZiYNJN54POS1GpNl2
         bOjiFHNzCX0jDza2zEnL2poozs5g4iSkMevskk+y47ANaf+wz2QQYNbncvZrf+RTND
         cj7k7w0VK8v5RY9EP314zLhqTu3miiGzM3cNSiUSwhrQlrW00lTHTggNILgUa9iOMN
         9XhDKAPZSaodsBwbxNEy2zvhmEluYqd9dBo2v/sOh1YmspQBJmr0nLxkrbqm+FyR3N
         qDESZ35uC8wUQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ac836f4447so104069971fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:44:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDzPypva0iHCl3ixvNsg9ehjlRb0H+Lqzbbrch26h8O+/2wRvOLJ
        pTgqvwtjRt1i6udSyDWjcf8kHFSpvKKj+tbpHWs=
X-Google-Smtp-Source: ACHHUZ4wSdZRYdHIPNeVp0x4gcnmZ3D4NFTRnQbw7PpbqP3N4Ss5pemly64/C/jjuwxNNiAqu9xiEoUEG/cJuUBWVPY=
X-Received: by 2002:ac2:511e:0:b0:4eb:c4e:bd87 with SMTP id
 q30-20020ac2511e000000b004eb0c4ebd87mr3954785lfb.58.1683909840877; Fri, 12
 May 2023 09:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230509221700.859865-1-song@kernel.org> <20230512124659.GY4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230512124659.GY4253@hirez.programming.kicks-ass.net>
From:   Song Liu <song@kernel.org>
Date:   Fri, 12 May 2023 09:43:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4GD77L-i-t90E743HTam=qRC0HP7XefT_rXC_WM6s2Hw@mail.gmail.com>
Message-ID: <CAPhsuW4GD77L-i-t90E743HTam=qRC0HP7XefT_rXC_WM6s2Hw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 5:47=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, May 09, 2023 at 03:17:00PM -0700, Song Liu wrote:
> > NMI watchdog permanently consumes one hardware counters per CPU on the
> > system. For systems that use many hardware counters, this causes more
> > aggressive time multiplexing of perf events.
> >
> > OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rar=
ely
> > used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
> > that one more hardware counter is available to the user. If the CPU doe=
sn't
> > support "ref-cycles", fall back to "cycles".
> >
> > The downside of this change is that users of "ref-cycles" need to disab=
le
> > nmi_watchdog.
>
> Urgh..
>
> how about something like so instead; then you can use whatever event you
> like...

Configuring this at boot time is not ideal for our use case. Currently, we =
have
some systems support ref-cycles and some don't. So this is one more kernel
argument we need to make sure to get correctly. This also means we cannot
change this setting without reboot.

Another idea I have is to use sysctl kernel.nmi_watchdog, so we can change
the event after boot. Would this work?

Btw, the limitation here (ref-cycles users need to disable NMI watchdog) co=
mes
from the limitation that the programmable counters cannot do ref-cycles. Is=
 this
something we may change (or already changed)?

Thanks,
Song

>
> ---
>  include/linux/nmi.h   |  2 ++
>  kernel/watchdog.c     | 45 ++++++++++++++++++++++++++++++++++++---------
>  kernel/watchdog_hld.c |  4 ++--
>  3 files changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 048c0b9aa623..8b6307837346 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -19,6 +19,8 @@ bool is_hardlockup(void);
>
>  extern int watchdog_user_enabled;
>  extern int nmi_watchdog_user_enabled;
> +extern int nmi_watchdog_type;
> +extern u64 nmi_watchdog_config;
>  extern int soft_watchdog_user_enabled;
>  extern int watchdog_thresh;
>  extern unsigned long watchdog_enabled;
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8e61f21e7e33..b3c09e0f96a3 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -40,6 +40,8 @@ static DEFINE_MUTEX(watchdog_mutex);
>  unsigned long __read_mostly watchdog_enabled;
>  int __read_mostly watchdog_user_enabled =3D 1;
>  int __read_mostly nmi_watchdog_user_enabled =3D NMI_WATCHDOG_DEFAULT;
> +int __ro_after_init nmi_watchdog_type =3D PERF_TYPE_HARDWARE;
> +u64 __ro_after_init nmi_watchdog_config =3D PERF_COUNT_HW_CPU_CYCLES;
>  int __read_mostly soft_watchdog_user_enabled =3D 1;
>  int __read_mostly watchdog_thresh =3D 10;
>  static int __read_mostly nmi_watchdog_available;
> @@ -73,15 +75,40 @@ void __init hardlockup_detector_disable(void)
>
>  static int __init hardlockup_panic_setup(char *str)
>  {
> -       if (!strncmp(str, "panic", 5))
> -               hardlockup_panic =3D 1;
> -       else if (!strncmp(str, "nopanic", 7))
> -               hardlockup_panic =3D 0;
> -       else if (!strncmp(str, "0", 1))
> -               nmi_watchdog_user_enabled =3D 0;
> -       else if (!strncmp(str, "1", 1))
> -               nmi_watchdog_user_enabled =3D 1;
> -       return 1;
> +       int ret =3D 1;
> +
> +       if (!str)
> +               return -EINVAL;
> +
> +       while (str) {
> +               char *next =3D strchr(str, ',');
> +               if (next) {
> +                       *next =3D 0;
> +                       next++;
> +               }
> +
> +               if (!strcmp(str, "panic"))
> +                       hardlockup_panic =3D 1;
> +               else if (!strcmp(str, "nopanic"))
> +                       hardlockup_panic =3D 0;
> +               else if (!strcmp(str, "0"))
> +                       nmi_watchdog_user_enabled =3D 0;
> +               else if (!strcmp(str, "1"))
> +                       nmi_watchdog_user_enabled =3D 1;
> +               else if (str[0] =3D=3D 'r') {
> +                       str++;
> +                       ret =3D kstrtou64(str, 16, &nmi_watchdog_config);
> +                       if (ret)
> +                               break;
> +                       nmi_watchdog_type =3D PERF_TYPE_RAW;
> +                       nmi_watchdog_user_enabled =3D 1;
> +               }
> +
> +               str =3D next;
> +       }
> +
> +       return ret;
> +
>  }
>  __setup("nmi_watchdog=3D", hardlockup_panic_setup);
>
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..27bc15f9a92a 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -99,8 +99,6 @@ static inline bool watchdog_check_timestamp(void)
>  #endif
>
>  static struct perf_event_attr wd_hw_attr =3D {
> -       .type           =3D PERF_TYPE_HARDWARE,
> -       .config         =3D PERF_COUNT_HW_CPU_CYCLES,
>         .size           =3D sizeof(struct perf_event_attr),
>         .pinned         =3D 1,
>         .disabled       =3D 1,
> @@ -170,6 +168,8 @@ static int hardlockup_detector_event_create(void)
>         struct perf_event *evt;
>
>         wd_attr =3D &wd_hw_attr;
> +       wd_attr->type =3D nmi_watchdog_type;
> +       wd_attr->config =3D nmi_watchdog_config;
>         wd_attr->sample_period =3D hw_nmi_get_sample_period(watchdog_thre=
sh);
>
>         /* Try to register using hardware perf events */
