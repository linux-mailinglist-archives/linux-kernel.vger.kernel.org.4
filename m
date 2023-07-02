Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA45744D78
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGBLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 07:49:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BBC1B0;
        Sun,  2 Jul 2023 04:49:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so28354375e9.1;
        Sun, 02 Jul 2023 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688298582; x=1690890582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EunOBKkobwJh7cDWy0iWQX58YsO7otZ7T3L8hquovTc=;
        b=eHJTVJA2cWG8hm9UJrC474B2rwB0LJhKILsxQlAAtbeUNcS7TrwzSkTyTacWGfyoTW
         1prpWV65/BrKQMEeba/2YdM9+AODPn+sfT3Q1bzHBgUnjv3TjygMNErvDwyfn/xmyjSJ
         Lj1G1N3D9hs/SFNgiVwhgRmqD++IZWZMW0Z7KV6rTKdBxaVvII/lRRknaFfI0xa+9qGn
         SBGbEV2HbJWR2kbWHGWGbPR5P0kNvyhpzIwzN2OeFwK30pEr28qa56+gxbwuzjQdQRGW
         o3FMjq7gasgSJWvtEOgpQyI3scozc808Is4pKwNTUjJWQ3y1S6O8lQ/Ydv/u7+Z1Owcp
         HavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688298582; x=1690890582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EunOBKkobwJh7cDWy0iWQX58YsO7otZ7T3L8hquovTc=;
        b=PGXnpHG+QnVep1ugVClcdaIBKumEOHTjd1n92Vl2LDYN5PWMxyMzmYbUDodyISVfbx
         REUxk0sa+L+Gd8JpkiFAvj5eQyLRbu3m/Hv6+LT7/HXRmj2y2WND6o2C018mLdBqHZFH
         9UICJ3l6Ui+tDM/OrfHZUoy0YiFf3IXXDaQkA3EwISni+v12YS79L047YKj4qZYRMO9J
         1CzMVAdF1tNb9G8NyegeLeET1fhnhBjPkQDAA6xhoPDWzJedQAiTdLkO8yimCteLI7t2
         PLRcjiPIWI/pTZczf3JOwQjaivgdDHv2Sr+Lt/zZAfB1p9oZYYTIu1dCY1MmjWgsNLNZ
         GkiQ==
X-Gm-Message-State: ABy/qLY4t7e/ZTk7GhT2i0JmD4uo96VjUbcx+hJq/aNvH7EupUM9pihj
        D+JmvWoPwA9WEl2ZoYW2lBuYmMPNM2Ooj5iRL+LQ27apoeBEEA==
X-Google-Smtp-Source: APBJJlEewt5l8Kvq47vHFR2EHOS1/FXrcijp9I69OcIjP5A8FEPxmXGv9FrE+hG6XwICt3h8yWYvBrUR4aB/uy8vfXg=
X-Received: by 2002:adf:fc4f:0:b0:30f:af06:7320 with SMTP id
 e15-20020adffc4f000000b0030faf067320mr5973368wrs.23.1688298582272; Sun, 02
 Jul 2023 04:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
 <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com>
 <CA+CX+bjit+BsLNWn1Oh0HYjJYratcUTnoEQri4M_BiKbdVn2yA@mail.gmail.com> <CAAd53p7_RbZDA=VgMQJtC23K0-WqteJH=cmC2WQMY1hAzC7bSQ@mail.gmail.com>
In-Reply-To: <CAAd53p7_RbZDA=VgMQJtC23K0-WqteJH=cmC2WQMY1hAzC7bSQ@mail.gmail.com>
From:   Pascal Terjan <pterjan@gmail.com>
Date:   Sun, 2 Jul 2023 12:49:25 +0100
Message-ID: <CA+CX+bhMz0kUm0E=nNETstkHfaFUOurgKJV_mhFhDqqMafJRJA@mail.gmail.com>
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

On Wed, 28 Jun 2023 at 02:21, Kai-Heng Feng <kai.heng.feng@canonical.com> w=
rote:
>
> On Wed, Jun 28, 2023 at 4:29=E2=80=AFAM Pascal Terjan <pterjan@gmail.com>=
 wrote:
> >
> > On Tue, 27 Jun 2023 at 14:23, Kai-Heng Feng <kai.heng.feng@canonical.co=
m> wrote:
> > >
> > > On Tue, Jun 27, 2023 at 7:01=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > + Ricky WU, Kai Heng Feng, Oleksandr Natalenko
> > > >
> > > > On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wro=
te:
> > > > >
> > > > > Hi,
> > > > > I have an ASUS PN50 machine with a 0bda:0129 card reader. The car=
d is
> > > > > not seen unless I reload the rtsx_usb_sdmmc module.
> > > >
> > > > Thanks for reporting, let's see how we can move this forward.
> > > >
> > > > I have looped in some of the people that has been involved in the
> > > > relevant changes for rtsx_usb. Let's see if they can help too.
> > > >
> > > > >
> > > > > I found a Debian bug report for the same regression
> > > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993068 but no=
thing
> > > > > to see there.
> > > > >
> > > > > Trying to understand things I found
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> > > > > which seemed related, so I first tried to revert it and that work=
ed.
> > > >
> > > > Okay! That's certainly good information. Are you willing to help
> > > > running further debug testings?
> > > >
> > > > Unless I mistaken, I think we should avoid doing a plain revert
> > > > (assuming we can find another option) as it will cause us to waste =
a
> > > > lot of energy instead.
> > > >
> > > > >
> > > > > Assuming the description is correct and the rtsx USB driver runti=
me
> > > > > resumes the rtsx_usb_sdmmc device when it detects that a new card=
 has
> > > > > been inserted, I assume this means it doesn't detect that a card =
was
> > > > > inserted and the problem would be in rtsx_usb rather than
> > > > > rtsx_usb_sdmmc.
> > > >
> > > > There is also another interesting commit, which was also part of th=
e
> > > > re-work of the rtsx_usb_sdmmc driver that you pointed to above.
> > > >
> > > > commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signalin=
g
> > > > for card insertion detection")
> > > >
> > > > >
> > > > > I am not sure how to debug this further, usbmon doesn't see anyth=
ing
> > > > > when I insert the card.
> > > >
> > > > If you are willing to run some tests, I suggest to add some debug p=
rints in:
> > > > drivers/mmc/host/rtsx_usb_sdmmc.c
> > > >   sdmmc_get_cd()
> > > >   rtsx_usb_sdmmc_runtime_resume()
> > > >   rtsx_usb_sdmmc_runtime_suspend()
> > > >
> > > > sdmmc_get_cd() should be returning 1 when it finds that there is ca=
rd
> > > > inserted, but of course the error path would be interesting too.
> > > >
> > > > rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
> > > > rtsx_usb_sdmmc driver. Beyond that point, it should also be called
> > > > when you insert an SD card. Just having a debug print in there shou=
ld
> > > > help answer if that actually happens.
> > >
> > > Adding kernel parameter "usbcore.dyndbg" can also help, it will print
> > > out what's going on at USB side.
> >
> > Nothing happens for that device (4-4), I only get others (1, 2, 3, 5,
> > 7) waking up repeatedly:
>
> Interesting. Waking up repeatedly may be the root cause.
>
> Is it possible to file a bug at bugzilla and attach full dmesg?

Sorry for the delay, here it is
https://bugzilla.kernel.org/show_bug.cgi?id=3D217625
