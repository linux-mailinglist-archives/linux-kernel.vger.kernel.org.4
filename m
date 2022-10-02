Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B475F2222
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiJBIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:53:24 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0E240BA;
        Sun,  2 Oct 2022 01:53:22 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id l14so5408866qvq.8;
        Sun, 02 Oct 2022 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Dg8wAyXlxOGTFI2BY11fpPc+9jHYON03ZefK5xf63Fg=;
        b=ZjRyHjTeOSCQgkOoMd+88aQgpX88mkN4tlSmPCULZ8uaaFHOBKYVSe5PRHW6SuxE5L
         r43aOf/mvKy9ob4Wc72YTxSDPkeTVpKsvPOYTRlwZL+xkR1AFscBJcOV4G+Lm6Z8mepY
         W6lQivHUkjFNF97VwI27hiJFgXFGSVP57heY4WYvxgVdutc8L2+XxI3YZDAJ37XT5b5w
         tXp2pejffsaswjWceM77H4g9FoQqz6+XbjTkYfuJH0/4CGJOdbeiMugk1WFVZXb4KnXw
         iowvTJxASmlL5Lc6v4JpCbDsoJnlmBYf5QsdKRetwhCobupsgwSmQpd8tEr5j4dhxNqP
         s6hA==
X-Gm-Message-State: ACrzQf23ax2NSEoGwoaf2PknGZAgBcAjAaTmXC4E6WaueHey+CznIxqN
        XVUypGaDq7Zd3iAp9SotwQWmaxIDY/4/CQ==
X-Google-Smtp-Source: AMsMyM65eE4B0ssXiAWwmRLVxZWIdejmo1nC7Fi8PAUe4iIZdhJNJLoKrM0S6Dc0msPKZQuRxityXw==
X-Received: by 2002:ad4:5d4a:0:b0:4af:83e0:bac0 with SMTP id jk10-20020ad45d4a000000b004af83e0bac0mr13117464qvb.12.1664700801754;
        Sun, 02 Oct 2022 01:53:21 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id s10-20020a05622a178a00b0035cd2dc1b08sm6538232qtk.14.2022.10.02.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:53:21 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso81705337b3.5;
        Sun, 02 Oct 2022 01:53:21 -0700 (PDT)
X-Received: by 2002:a81:a24e:0:b0:358:934b:980c with SMTP id
 z14-20020a81a24e000000b00358934b980cmr3246499ywg.383.1664700800822; Sun, 02
 Oct 2022 01:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <87pmfavfpt.wl-tiwai@suse.de> <56a04cae-7240-9005-4931-5b3e9f598ffb@gmx.com>
In-Reply-To: <56a04cae-7240-9005-4931-5b3e9f598ffb@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 10:53:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuEnfOkbw2zYXBS+WSZbrkajAPFoYVGFAZBuXK+ac8oA@mail.gmail.com>
Message-ID: <CAMuHMdVuEnfOkbw2zYXBS+WSZbrkajAPFoYVGFAZBuXK+ac8oA@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Oct 2, 2022 at 10:23 AM Artem S. Tashkinov <aros@gmx.com> wrote:
> On 10/2/22 07:37, Takashi Iwai wrote:
> > On Sat, 01 Oct 2022 12:30:22 +0200,
> > Artem S. Tashkinov wrote:
> >> Here's another one which is outright puzzling:
> >>
> >> You run: dmesg -t --level=emerg,crit,err
> >>
> >> And you see some non-descript errors of some kernel subsystems seemingly
> >> failing or being unhappy about your hardware. Errors are as cryptic as
> >> humanly possible, you don't even know what part of kernel has produced them.
> >>
> >> OK, as a "power" user I download the kernel source, run `grep -R message
> >> /tmp/linux-5.19` and there are _multiple_ different modules and places
> >> which contain this message.
> >>
> >> I'm lost. Send this to LKML? Did that in the long past, no one cared, I
> >> stopped.
> >>
> >> Here's what I'm getting with Linux 5.19.12:
> >>
> >> platform wdat_wdt: failed to claim resource 5: [mem
> >> 0x00000000-0xffffffff7fffffff]
> >> ACPI: watchdog: Device creation failed: -16
> >> ACPI BIOS Error (bug): Could not resolve symbol
> >> [\_SB.PCI0.XHC.RHUB.TPLD], AE_NOT_FOUND (20220331/psargs-330)
> >> ACPI Error: Aborting method \_SB.UBTC.CR01._PLD due to previous error
> >> (AE_NOT_FOUND) (20220331/psparse-529)
> >> platform MSFT0101:00: failed to claim resource 1: [mem
> >> 0xfed40000-0xfed40fff]
> >> acpi MSFT0101:00: platform device creation failed: -16
> >> lis3lv02d: unknown sensor type 0x0
> >>
> >> Are they serious? Should they be reported or not? Is my laptop properly
> >> working? I have no clue at all.
> >
> > That's a dilemma.  The kernel can't know whether it's "properly"
> > working, either -- that is, whether the lack of some functions matters
> > for you or not.  In your case above, it's about a watchdog, something
> > related with USB, TPM, and acceleration sensor, all of which likely
> > come from a buggy BIOS.  Would you mind if those features are missing?
> > Or even whether your device has a correct hardware implementation?
> > Kernel doesn't know, hence it complains as an error.
> >
> > In many drivers, there are mechanisms to shut off superfluous error
> > messages for known devices.  So it's case-by-case solutions.
> >
> > Or you can completely hide those errors at boot by a boot option
> > (e.g. loglevel=2).
>
> The problem is some of such messages are indeed indicative of certain
> real issues which result in HW not working properly, including:
>
> 1) missing/incorrect firmware
> 2) most importantly: not enabled power saving modes
> 3) not enabled high performance modes
> 4) not enabled devices
> 5) not enabled devices' functions
> 6) drivers conflicts (i.e. the wrong module gets loaded for the device)
> 7) physically failing hardware
>
> I'm quite sure you don't really know what half of those messages
> actually mean.
>
> Speaking of 7. Various kernel subsystems/drivers deal with e.g. mass
> storage which is known to fail quite often. There's not a single driver
> in the kernel which is actually brave enough to spew something like this:
>
> "/dev/xxxx might be failing, please RMA or seek help online"
>
> instead you get a dmesg choke full of "unable to read sector XXX" or
> something like that.
>
> To return to the previous errors: it's impossible for the user to assess
> their severity and that sucks. What is "platform device creation
> failed"? What is "unknown sensor type"? What am I missing? Who's
> responsible? The kernel? My HW vendor? Are those errors actionable? In
> my understanding a properly working computer must not produce
> "emerg,crit,err" errors. I'm not even talking about "warn,info" and such.

I am afraid that for most of the above, the kernel cannot know the
answer.  Hence more investigation/debugging is needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
