Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5F74078F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjF1BVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjF1BVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:21:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC672103
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:21:11 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2A8B3F171
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687915267;
        bh=wDI7kHj/tG5867SBxqS4ZXMBhI8jaKHh3Mad9rQVoM8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KcR3Z67H5KGNyOwyvx7L/7A0N/UmbZPpyxD2trERWb4oBWf6Pwf+XICsMJWFV47FT
         nw3NoCYn4sgi++3ghCRYv5L2M77/FJgyptAlFNOoTC9PWzPjLAw5KhfIU3z9rbkMvz
         XgoHXe2P9P84nispHpr2Eb99Ihoz8mcNxgA+7UUMI/8ZmLqvYhncJKkoRAQseMPnva
         0teXHke8ua75mE0Mo0wvjc3LagqfSNhj+3cyUN5oGxEfVHwB1FgeJQoNqOaXxDQBWI
         8+ulUBAq09CGKrKY5PmqmL/PNdyJEiOq777L9I/+TmZkWThcDI/TptA9R5kad9bxXE
         A37UdmOz85o+g==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262e9467fbaso1657554a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687915266; x=1690507266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDI7kHj/tG5867SBxqS4ZXMBhI8jaKHh3Mad9rQVoM8=;
        b=h/A3tDILe8UOv1oeij9cz5kXIqCCRabAa7PeflB8IPZm5K6rsttIPA1Xo8NmGwof/X
         WE+OfXusnXuFrb7yiEmuXeedPkAUpMthdhovZbC06D1FDmwZkr+Vh1iezQl35iIu0TnI
         mYnuAeu6k5Ig3RsT4tQH7UGP0mnywit/TUtn7WKtZf/GFwt4T2fL1tvTK6BPmF26NNNv
         LJEAPlKQYCV/YLICoRoShO3gcBFOOaB83ZEiNQnXKz9rTbhHGT016MaCGSYfvuFP6VmL
         jSEAVJTp5xB3PjK4AVyAqXaYn/OBKeMGp6CXXo4fSBuWhC4A3BzQP2qijVJrozIM4uQk
         A+3g==
X-Gm-Message-State: AC+VfDzJJ143LtK/f2wshfQ+ZtStZ2mHj8hdfcpK16ajLoQvOfj1zkAF
        sdh4A+AW8Fve7B0txvqXQVDLKd3zouegKTZUVuVnhQc5iDxQC690+KVVB0dpKEbCu+GolLySOLA
        s+ZV56WjfZt8+HzyIEZ4fgpx+9XFx2wE40dTt8rbui3FikPgGYxl+SEwb+Q==
X-Received: by 2002:a17:90a:359:b0:262:b22b:8ab5 with SMTP id 25-20020a17090a035900b00262b22b8ab5mr8544000pjf.17.1687915265959;
        Tue, 27 Jun 2023 18:21:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GSMsJeJp1bEJFziW0qwIVqrJ5+DmAa7ZIVtS2HUaBMr/Zko+dqqwts9wOippO+tEXUsgPdq1setgPCMuR9Fc=
X-Received: by 2002:a17:90a:359:b0:262:b22b:8ab5 with SMTP id
 25-20020a17090a035900b00262b22b8ab5mr8543991pjf.17.1687915265578; Tue, 27 Jun
 2023 18:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
 <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com> <CA+CX+bjit+BsLNWn1Oh0HYjJYratcUTnoEQri4M_BiKbdVn2yA@mail.gmail.com>
In-Reply-To: <CA+CX+bjit+BsLNWn1Oh0HYjJYratcUTnoEQri4M_BiKbdVn2yA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 28 Jun 2023 09:20:54 +0800
Message-ID: <CAAd53p7_RbZDA=VgMQJtC23K0-WqteJH=cmC2WQMY1hAzC7bSQ@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Pascal Terjan <pterjan@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 4:29=E2=80=AFAM Pascal Terjan <pterjan@gmail.com> w=
rote:
>
> On Tue, 27 Jun 2023 at 14:23, Kai-Heng Feng <kai.heng.feng@canonical.com>=
 wrote:
> >
> > On Tue, Jun 27, 2023 at 7:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > + Ricky WU, Kai Heng Feng, Oleksandr Natalenko
> > >
> > > On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wrote=
:
> > > >
> > > > Hi,
> > > > I have an ASUS PN50 machine with a 0bda:0129 card reader. The card =
is
> > > > not seen unless I reload the rtsx_usb_sdmmc module.
> > >
> > > Thanks for reporting, let's see how we can move this forward.
> > >
> > > I have looped in some of the people that has been involved in the
> > > relevant changes for rtsx_usb. Let's see if they can help too.
> > >
> > > >
> > > > I found a Debian bug report for the same regression
> > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993068 but noth=
ing
> > > > to see there.
> > > >
> > > > Trying to understand things I found
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> > > > which seemed related, so I first tried to revert it and that worked=
.
> > >
> > > Okay! That's certainly good information. Are you willing to help
> > > running further debug testings?
> > >
> > > Unless I mistaken, I think we should avoid doing a plain revert
> > > (assuming we can find another option) as it will cause us to waste a
> > > lot of energy instead.
> > >
> > > >
> > > > Assuming the description is correct and the rtsx USB driver runtime
> > > > resumes the rtsx_usb_sdmmc device when it detects that a new card h=
as
> > > > been inserted, I assume this means it doesn't detect that a card wa=
s
> > > > inserted and the problem would be in rtsx_usb rather than
> > > > rtsx_usb_sdmmc.
> > >
> > > There is also another interesting commit, which was also part of the
> > > re-work of the rtsx_usb_sdmmc driver that you pointed to above.
> > >
> > > commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signaling
> > > for card insertion detection")
> > >
> > > >
> > > > I am not sure how to debug this further, usbmon doesn't see anythin=
g
> > > > when I insert the card.
> > >
> > > If you are willing to run some tests, I suggest to add some debug pri=
nts in:
> > > drivers/mmc/host/rtsx_usb_sdmmc.c
> > >   sdmmc_get_cd()
> > >   rtsx_usb_sdmmc_runtime_resume()
> > >   rtsx_usb_sdmmc_runtime_suspend()
> > >
> > > sdmmc_get_cd() should be returning 1 when it finds that there is card
> > > inserted, but of course the error path would be interesting too.
> > >
> > > rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
> > > rtsx_usb_sdmmc driver. Beyond that point, it should also be called
> > > when you insert an SD card. Just having a debug print in there should
> > > help answer if that actually happens.
> >
> > Adding kernel parameter "usbcore.dyndbg" can also help, it will print
> > out what's going on at USB side.
>
> Nothing happens for that device (4-4), I only get others (1, 2, 3, 5,
> 7) waking up repeatedly:

Interesting. Waking up repeatedly may be the root cause.

Is it possible to file a bug at bugzilla and attach full dmesg?

Kai-Heng

>
> [  316.890285] usb usb7: usb auto-resume
> [  316.890322] hub 7-0:1.0: hub_resume
> [  316.912386] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [  316.912460] hub 7-0:1.0: hub_suspend
> [  316.912470] usb usb7: bus auto-suspend, wakeup 1
> [  316.912595] usb usb5: usb auto-resume
> [  316.912624] hub 5-0:1.0: hub_resume
> [  316.934386] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [  316.934460] hub 5-0:1.0: hub_suspend
> [  316.934471] usb usb5: bus auto-suspend, wakeup 1
> [  316.934595] usb usb3: usb auto-resume
> [  316.934609] hub 3-0:1.0: hub_resume
> [  316.956385] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [  316.956456] hub 3-0:1.0: hub_suspend
> [  316.956466] usb usb3: bus auto-suspend, wakeup 1
> [  316.956540] usb usb2: usb auto-resume
> [  316.956553] hub 2-0:1.0: hub_resume
> [  316.956576] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [  316.956594] hub 2-0:1.0: hub_suspend
> [  316.956600] usb usb2: bus auto-suspend, wakeup 1
> [  316.956626] usb usb1: usb auto-resume
> [  316.956662] hub 1-0:1.0: hub_resume
> [  316.956679] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
> [  316.956697] hub 1-0:1.0: hub_suspend
> [  316.956703] usb usb1: bus auto-suspend, wakeup 1
>
> The only time I get a log for it is when I reload the module with the
> card in, and then eject the card:
>
> [  278.743368] usb 4-4: kworker/15:1 timed out on ep2in len=3D0/8
