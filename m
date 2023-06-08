Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDE7281DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjFHNzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjFHNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:55:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01A19BB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:55:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77ac30e95caso22143039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686232539; x=1688824539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=a2jfGHiuvki4o+FZ9TgQVGZTbfrXjGsGcKLEiSOwW65OyilhfesiJEWIE6IqIWYs9Y
         t0vDniE1rX13BVJWm9Cwb0DIrLbHB4Rw3ciAhdDfBkl+OZzdUPd1DfokaFukIGIYxZUo
         mydx7Xc4oCfXTHZrJfv0itD4PbVkAVkP+xFXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232539; x=1688824539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Vs9lje4ue6a9YND5XSnEpnS9VI2Lo/geXINpFnbB8=;
        b=lDn70H+VcBf3D6HB8vuBhw6EKQ8Bka7mu9fSJmTN+jtIHdeJz/2Jh48dsNYSWgW/Mm
         JXP9U6Z+gvz18HN1V3PYKqMJSqCrk7yFEYRC/ry6xcQ95tJE/CpfkuO/E47YmDoU+odd
         Th5sCwzf96nBJUc60tB+6yfpTzZGgyQ5MhgwU6dStMzew/9PULGI9bUH8zoQTklckCOL
         bwtLmIIUBKKjWaXdXtyHCqasfNJes7N/A8pB/qB5HfYv5vFXoc7eWal4dOzsSmHiNta0
         GUc9ZP0fgJ3hX3eFw2mBQXmx81O3b5URbK++Dov4qMSAzi1Fn0eF3N+rxZKNUTAHrysn
         FZCA==
X-Gm-Message-State: AC+VfDySEkR777H5DSidp2cWb3zDbOy3E0bIcS7+0IdTY/OuFxzIyguf
        n6vg26Qk61wlZJxYOFdDE6o3rA5/IHIAN2Di7bo=
X-Google-Smtp-Source: ACHHUZ5pKLqVgUPd1/t4UYIwAYz24xWhlUSOTCpTenQSaRliQZ8VtkaUVe0eiNyb1C9EbW1t3fooyQ==
X-Received: by 2002:a5e:de08:0:b0:76c:c701:2f77 with SMTP id e8-20020a5ede08000000b0076cc7012f77mr12386161iok.3.1686232538970;
        Thu, 08 Jun 2023 06:55:38 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id u13-20020a6be90d000000b0076c750dc780sm366548iof.29.2023.06.08.06.55.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:55:37 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33d928a268eso121355ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:55:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a82:b0:32f:7715:4482 with SMTP id
 k2-20020a056e021a8200b0032f77154482mr109894ilv.4.1686232535228; Thu, 08 Jun
 2023 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-3-pmladek@suse.com>
 <CAD=FV=WRzaLbLQ65usGeFq3ya=DV8cYyHQina_721EFoSTdBGA@mail.gmail.com> <ZIG1Qi0iUjTKICQM@alley>
In-Reply-To: <ZIG1Qi0iUjTKICQM@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 06:55:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Message-ID: <CAD=FV=XzueJia--Zv4cAofzk7yocmP-7K8wa4doAN8pzED_hZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
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

On Thu, Jun 8, 2023 at 4:02=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> > >  config HARDLOCKUP_DETECTOR
> > >         bool "Detect Hard Lockups"
> > >         depends on DEBUG_KERNEL && !S390
> > > -       depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCK=
UP_DETECTOR_ARCH
> > > +       depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP=
_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
> >
> > Adding the dependency to buddy (see ablove) would simplify the above
> > to just this:
> >
> > depends on HAVE_HARDLOCKUP_DETECTOR_PERF ||
> > HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
>
> This is exactly what I do not want. It would just move the check
> somewhere else. But it would make the logic harder to understand.

Hmmm. To me, it felt easier to understand by moving this into the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY". To me it was pretty easy to say "if
an architecture defined its own arch-specific watchdog then buddy
can't be enabled" and that felt like it fit cleanly within the
"HAVE_HARDLOCKUP_DETECTOR_BUDDY" definition. It got rid of _a lot_ of
other special cases / checks elsewhere and felt quite a bit cleaner to
me. I only had to think about the conflict between the "buddy" and
"nmi" watchdogs once when I understood
"HAVE_HARDLOCKUP_DETECTOR_BUDDY".


> > As per above, it's simply a responsibility of architectures not to
> > define that they have both "perf" if they have the NMI watchdog, so
> > it's just buddy to worry about.
>
> Where is this documented, please?
> Is it safe to assume this?

It's not well documented and I agree that it could be improved. Right
now, HAVE_NMI_WATCHDOG is documented to say that the architecture
"defines its own arch_touch_nmi_watchdog()". Looking before my
patches, you can see that "kernel/watchdog_hld.c" (the "perf" detector
code) unconditionally defines arch_touch_nmi_watchdog(). That would
give you a linker error.


> I would personally prefer to ensure this by the config check.
> It is even better than documentation because nobody reads
> documentation ;-)

Sure. IMO this should be documented as close as possible to the root
of the problem. Make "HAVE_NMI_WATCHDOG" depend on
"!HAVE_HARDLOCKUP_DETECTOR_PERF". That expresses that an architecture
is not allowed to declare that it has both.
