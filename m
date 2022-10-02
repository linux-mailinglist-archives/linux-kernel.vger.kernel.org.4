Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914B5F2253
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJBJ0B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJBJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:25:50 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFDA3DBFE;
        Sun,  2 Oct 2022 02:25:47 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id mg6so148393qvb.10;
        Sun, 02 Oct 2022 02:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cumPVsGyJ75uwGdypAwkIxh9fxEP/aivGx3S80E0Nhk=;
        b=2SERvntbplpgBFHtpy1Q+CG4rPlCfjZEkVk7Yj6ld6vpc1J1Lv0dGD1bilkw/LPf/f
         fpg6mautrKW6fCChmL7gNv9H5TwpJoYVK/hJPsiWHt9kOxPbTnAdt4IgpXsZ6LWavgKX
         lVQ4ZZYSzYZzD5LXfGlYI1jQSM4fQxEz6jI+bEviWs/HVDUVzaa6x2+Mtu+kmdhYIQfY
         B0/VgR+5WSeQI3GJRCJG2FG+zq7BeFIZPgcpqsC9v/x99jltZLvtMGBpuU9fOrb7E0cb
         8tPxN1erAoh3ERh7ygr3fu4OOvrgCCtXl1zLR0rQ1N3HFX1uNPysjuiBqsjvLGs4dKbi
         nNTQ==
X-Gm-Message-State: ACrzQf3ch5FfyyAuycv/cs1/N0ZVS3F2k/eus10JzLxoijubcilRcVNp
        EoLyFXNF4Ozn+MeHeTva/jExGZmqHph8kQ==
X-Google-Smtp-Source: AMsMyM7AQyfsHQpHpjw92TY9F9eZfcoPiPwG9pgAYtOPQ76c6Bl9tKjXd3DSxHUd0TACSEZLPb/9aA==
X-Received: by 2002:ad4:5941:0:b0:47b:5b81:e329 with SMTP id eo1-20020ad45941000000b0047b5b81e329mr13021718qvb.24.1664702746099;
        Sun, 02 Oct 2022 02:25:46 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t14-20020ac8760e000000b003437a694049sm6469996qtq.96.2022.10.02.02.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 02:25:45 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y144so2962955yby.11;
        Sun, 02 Oct 2022 02:25:45 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr13969029ybp.365.1664702745278; Sun, 02
 Oct 2022 02:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info> <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <CAMuHMdUWontzcX=ww8HbVWc2j418SdyzoPyKa4HHFsxzijbVSw@mail.gmail.com> <90b7db52-38c3-aafe-2b8e-c7ebd6a484c0@gmx.com>
In-Reply-To: <90b7db52-38c3-aafe-2b8e-c7ebd6a484c0@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 11:25:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgxmTCcx2v_jhO7iF6NEwjDHesX2LLAgrdFFUYxiRcAQ@mail.gmail.com>
Message-ID: <CAMuHMdUgxmTCcx2v_jhO7iF6NEwjDHesX2LLAgrdFFUYxiRcAQ@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Sun, Oct 2, 2022 at 11:07 AM Artem S. Tashkinov <aros@gmx.com> wrote:
> On 10/2/22 09:03, Geert Uytterhoeven wrote:
> > On Sat, Oct 1, 2022 at 1:21 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> >> On 10/1/22 10:57, Thorsten Leemhuis wrote:
> >>> On 01.10.22 12:47, Artem S. Tashkinov wrote:
> >>>> On 10/1/22 10:39, Greg KH wrote:
> >>>>> On Sat, Oct 01, 2022 at 10:30:22AM +0000, Artem S. Tashkinov wrote:
> >>>
> >>>>>> I have a 20+ years experience in IT and some kernel issues are just
> >>>>>> baffling in terms of trying to understand what to do about them.
> >>>>>>
> >>>>>> Here's an example: https://bugzilla.kernel.org/show_bug.cgi?id=216274
> >>>>>>
> >>>>>> What should I do about that? Who's responsible for this? Who should I
> >>>>>> CC?
> >>>>>
> >>>>> Input subsystem.
> >>>>
> >>>> It's great you've replied immediately, what about hundreds or even
> >>>> thousands of other bug reports where people have no clue who has to be
> >>>> CC'ed?
> >>>
> >>> Quoting from https://docs.kernel.org/admin-guide/reporting-issues.html:
> >>>
> >>> "[...] try your best guess which kernel part might be causing the issue.
> >>> Check the MAINTAINERS file [...] In case tricks like these don’t bring
> >>> you any further, try to search the internet on how to narrow down the
> >>> driver or subsystem in question. And if you are unsure which it is: just
> >>> try your best guess, somebody will help you if you guessed poorly. [...]"
> >>>
> >>> HTH, Ciao, Thorsten
> >>
> >> Absolute most people:
> >>
> >> * Will never read this document
> >> * Will not be able to "search the internet on how to narrow down the
> >> driver or subsystem in question"
> >
> > So how did these people arrive at "bugzilla" in the first place? ;-)
>
> Google kernel bug -> bugzilla.kernel.org

First three hits:

  1. Google just tripled its bounty for Linux kernel bugs. Here's
whyhttps://www.zdnet.com › Innovation › Security
     02 Nov 2021 — Google has kicked off a special three-month bug
bounty targeting flaws in the Linux kernel with triple the rewards for
security researchers.

  2. Google's New Bug Bounties Include Their Custom Linux
...https://linux.slashdot.org › story › googles-new-bug-bo...
     13 Aug 2022 — All of GKE and its dependencies are in scope, but
every flag caught so far has been a container breakout through a Linux
kernel vulnerability.

  3. How to report Linux kernel bugs - google/syzkaller -
GitHubhttps://github.com › syzkaller › blob › master › docs
     Reporting Linux kernel bugs. Before reporting a bug make sure
nobody else already reported it. The easiest way to do this is to
search through the syzkaller ...

Bingo, that page tells you to use the MAINTAINERS file.
Nothing about bugzilla on the first page (Google is adapting quickly ;-)

> > Or is this a case of "if all you have is a hammer...", so you
> > actively start looking for a bugzilla?
> > I.e. people who are used to bugzilla/discourse/slack/irc/trac/... will
> > look for how to use bugzilla/discourse/slack/irc/trac/... to interact
> > with the developer and/or maintainer.
> >
> > The definitive guide is the MAINTAINERS file.  If there is a (rare)
> > corresponding "B" entry, you can use that.  Else fall back to the
> > "M" and "L" entries.  "C" might be good for an initial query, but not
> > for the actual reporting, as there's even less traceability than with
> > mailing lists (the latter are archived by lore).
>
> Just like I said before email sucks terribly for bug reporting except
> for rare cases when the developer notices your email right away and
> promptly submits a patch. This happens once in a blue moon unfortunately.

During the last decade, I received three emails from kernel bugzilla
(four including the "please change your password" email).

The first one was incorrectly assigned to me, but closest as fixed
later.
The second was fixed by the reporter after feedback from someone else.
The third was a complex configuration issue (think randconfig) that
was not trivial to fix, but doesn't matter in the real world.

Now, for bug reports by email that I did fix, I cannot give you the
details easily, as the list would be a few orders of magnitude larger...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
