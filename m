Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D28740503
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjF0U3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjF0U3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:29:13 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607D26BF;
        Tue, 27 Jun 2023 13:29:09 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4716726b741so1361492e0c.3;
        Tue, 27 Jun 2023 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687897749; x=1690489749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPh2acxcnLROxhjhKZUNfv/hApqShyzr5T/UnDzlvUY=;
        b=Mjf+s2b32hWPynVylWQ/msKmOAJasxcAdf0obzN18ZOIJzZ5bfTiVMf4c1Kx1Thp0E
         hG7WGGMNNZgulKuh9n9wmVQ+hoFZ15kVHiiPvUFfja5IJco2pDlQBP2WQyH3Ecm7J5LV
         JbmJyfIi5lh+dvjwYtQV4eFXBJ+uHmvUTnP0++EP17BZVLan2W/bs1gM+rUuwDVyv/DE
         1MsriH9vtUCh8ko6wqUgPQB6d5ydbLuh4NIozuNW4+tjrQoscwG8Dzy9LOc8ON1Dt5ZU
         Iim//1qLTz1Iud8XKIzAr3xDAy5SAlmdN6zdP8dAuIxUkgr5z58W1dB/G+xjbDWC4AgK
         K7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897749; x=1690489749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPh2acxcnLROxhjhKZUNfv/hApqShyzr5T/UnDzlvUY=;
        b=fXVk6hRZtdGOCWPfiE91cdRtBxWeurKIjh3rTOtGZTBkOA52RjuRSHcdsLneOb/Ppx
         Ks7SVlGSLMJ0ci+jHRFRvCFux4mc8/OlA08KjR+XYYpG1jf3RZ7MV/PnRIK9F3k/dFe/
         hcOVIJLTki4OrrMAhfWP7lsEGVrWp2BEqMl1uaEq17rxptORdtfTJfSWXYkc5l5q41yA
         P9QT4jGWMjvlqOtNNEESBtQGokjCaEwRPPUjXLAx3GB13f/nTvGVy6XSOSu2PqUJ2j0b
         Nn0PBvADGAB08axoJoSZP4yKb0mJ9/6VexQH22kJN0zWXETE5bDan6OzwiYMsr2kXI8b
         tfkQ==
X-Gm-Message-State: AC+VfDzW9dSv4cR7XF5/J9vpBlpX2qwiKuuLlxJTd0Khdd5n4mtJd5+G
        7i8PlI7dlDwdr77purPGHHNNI+PgfTht2UMTFRA=
X-Google-Smtp-Source: ACHHUZ4pyCz5ljhuQNcO/uAin5FuWJYFwKm0nAu4les4mZCFC8rIIBIKirySJLtIPLdMNkc87gNhEsuH/mVpzV0hgWw=
X-Received: by 2002:a1f:ea45:0:b0:456:e940:b583 with SMTP id
 i66-20020a1fea45000000b00456e940b583mr9403173vkh.16.1687897748367; Tue, 27
 Jun 2023 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com> <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com>
In-Reply-To: <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com>
From:   Pascal Terjan <pterjan@gmail.com>
Date:   Tue, 27 Jun 2023 21:28:51 +0100
Message-ID: <CA+CX+bjit+BsLNWn1Oh0HYjJYratcUTnoEQri4M_BiKbdVn2yA@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 14:23, Kai-Heng Feng <kai.heng.feng@canonical.com> w=
rote:
>
> On Tue, Jun 27, 2023 at 7:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > + Ricky WU, Kai Heng Feng, Oleksandr Natalenko
> >
> > On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wrote:
> > >
> > > Hi,
> > > I have an ASUS PN50 machine with a 0bda:0129 card reader. The card is
> > > not seen unless I reload the rtsx_usb_sdmmc module.
> >
> > Thanks for reporting, let's see how we can move this forward.
> >
> > I have looped in some of the people that has been involved in the
> > relevant changes for rtsx_usb. Let's see if they can help too.
> >
> > >
> > > I found a Debian bug report for the same regression
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993068 but nothin=
g
> > > to see there.
> > >
> > > Trying to understand things I found
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> > > which seemed related, so I first tried to revert it and that worked.
> >
> > Okay! That's certainly good information. Are you willing to help
> > running further debug testings?
> >
> > Unless I mistaken, I think we should avoid doing a plain revert
> > (assuming we can find another option) as it will cause us to waste a
> > lot of energy instead.
> >
> > >
> > > Assuming the description is correct and the rtsx USB driver runtime
> > > resumes the rtsx_usb_sdmmc device when it detects that a new card has
> > > been inserted, I assume this means it doesn't detect that a card was
> > > inserted and the problem would be in rtsx_usb rather than
> > > rtsx_usb_sdmmc.
> >
> > There is also another interesting commit, which was also part of the
> > re-work of the rtsx_usb_sdmmc driver that you pointed to above.
> >
> > commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signaling
> > for card insertion detection")
> >
> > >
> > > I am not sure how to debug this further, usbmon doesn't see anything
> > > when I insert the card.
> >
> > If you are willing to run some tests, I suggest to add some debug print=
s in:
> > drivers/mmc/host/rtsx_usb_sdmmc.c
> >   sdmmc_get_cd()
> >   rtsx_usb_sdmmc_runtime_resume()
> >   rtsx_usb_sdmmc_runtime_suspend()
> >
> > sdmmc_get_cd() should be returning 1 when it finds that there is card
> > inserted, but of course the error path would be interesting too.
> >
> > rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
> > rtsx_usb_sdmmc driver. Beyond that point, it should also be called
> > when you insert an SD card. Just having a debug print in there should
> > help answer if that actually happens.
>
> Adding kernel parameter "usbcore.dyndbg" can also help, it will print
> out what's going on at USB side.

Nothing happens for that device (4-4), I only get others (1, 2, 3, 5,
7) waking up repeatedly:

[  316.890285] usb usb7: usb auto-resume
[  316.890322] hub 7-0:1.0: hub_resume
[  316.912386] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.912460] hub 7-0:1.0: hub_suspend
[  316.912470] usb usb7: bus auto-suspend, wakeup 1
[  316.912595] usb usb5: usb auto-resume
[  316.912624] hub 5-0:1.0: hub_resume
[  316.934386] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.934460] hub 5-0:1.0: hub_suspend
[  316.934471] usb usb5: bus auto-suspend, wakeup 1
[  316.934595] usb usb3: usb auto-resume
[  316.934609] hub 3-0:1.0: hub_resume
[  316.956385] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.956456] hub 3-0:1.0: hub_suspend
[  316.956466] usb usb3: bus auto-suspend, wakeup 1
[  316.956540] usb usb2: usb auto-resume
[  316.956553] hub 2-0:1.0: hub_resume
[  316.956576] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.956594] hub 2-0:1.0: hub_suspend
[  316.956600] usb usb2: bus auto-suspend, wakeup 1
[  316.956626] usb usb1: usb auto-resume
[  316.956662] hub 1-0:1.0: hub_resume
[  316.956679] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  316.956697] hub 1-0:1.0: hub_suspend
[  316.956703] usb usb1: bus auto-suspend, wakeup 1

The only time I get a log for it is when I reload the module with the
card in, and then eject the card:

[  278.743368] usb 4-4: kworker/15:1 timed out on ep2in len=3D0/8
