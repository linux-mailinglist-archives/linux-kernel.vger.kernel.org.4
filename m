Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67619730CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjFOBxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjFOBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:53:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEBA6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:53:34 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0C87C3F18B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686794013;
        bh=4QZ5MF49DRVWjswQ0OeAsHwz2voC9Lsfi85wkJvwEAA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CQec5SrPXNrlw9AKRfarvVev/HBteyx5EhiEhkY8ROlg5RTywZqZr7ez3BRVlwl/V
         KggGI4qYw/6t5rVQjsRxf3Saa1XFf/TktGksXoycHa78ihLrdObAakv7l9EBZZyxNM
         +rq/pLsN8YnfTPPHi7q0tyLzG6WAO+lU8xUvf9DWoDTwg8VyuSfJsdt5H+JAplL7EE
         ESvPLMCQ2xalimpaa2DdjzRhy99iqUyIgoe2q++j2+XPt4bOt1laUm3hnviFMzbYgq
         YU3tOJntuPl6Wd9/wJMOzJ+jEuiLMDFGaPMTsVg/jKXhaWnLmoG/MvOyEJZhSjfgR4
         /jgoNQb58CoVg==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-babb76a9831so1316991276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686794011; x=1689386011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QZ5MF49DRVWjswQ0OeAsHwz2voC9Lsfi85wkJvwEAA=;
        b=Y5MFbY4MZtnP5spBrRJrPurB2Gx0/U7rRrUzKAUsP/GwcTdWQf2yx/WoawwXMVxW/G
         QD1s7Dj5TPeavRGYOKDRt4oz1j1TVwY6fdpvY5dWs2HlKb1To6GCqZM1LrMboyi8fwuy
         gGoe9+LtbJMrzl90Q4rxB/pZbwa2yQvoU+abygT4+HjHr9jVw+ysGjVZdtM1moiwGUeE
         ddCLiWvXeg2ElvK+2aRaJfNODXzLihVLjMv6FOx7FeYWUFZaEYMoMSV9IjJdfJkIGLCr
         mLPAxMVKdVDc4p0Z8OpXzBgzvN5dFewvKtkWXej3lzZXO4T5rg3jTl6e+rtt3muMoNKR
         sWIQ==
X-Gm-Message-State: AC+VfDxZ2mDU4cVOKlRqEOayMT/14Iyajzu2c8kjntpGs+KnEIWeeHt0
        vaYTtMuj8klTcmL0yLrfREyKXmgj18MBHn2R8cs46NaEYRgGOhHJLCUpMXwDb1nisu0FjmCAD0H
        nF/jsNHGV5Ya6xhOScMBnQyaMfdndoIcFyuHSHj5yYINjVt2YUu3si4PGxA==
X-Received: by 2002:a25:bcd1:0:b0:bbb:14a6:fc85 with SMTP id l17-20020a25bcd1000000b00bbb14a6fc85mr3606208ybm.8.1686794011528;
        Wed, 14 Jun 2023 18:53:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zuKyxqrimiqlrwXS43VKYK+HXSbIgd0UEF4pKCHTFk8UrzT6ON3as6ybqPj6IvapwGZTlbALch+5Ilu3GkaI=
X-Received: by 2002:a25:bcd1:0:b0:bbb:14a6:fc85 with SMTP id
 l17-20020a25bcd1000000b00bbb14a6fc85mr3606196ybm.8.1686794011161; Wed, 14 Jun
 2023 18:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org> <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org> <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
 <20230607062341.GA30618@srcf.ucam.org> <20230607065604.yaivqbbd3dkawxo4@pali>
 <CAFv23Q==r4newMXE3OWavRSRt-bEi5-qR0Vo-5HGLw4r9J36MA@mail.gmail.com>
 <20230607074732.GA31666@srcf.ucam.org> <457e2a4a-e28a-cd24-c129-4ff6162ccc36@redhat.com>
 <CAFv23QmVP4ZFAhAFBSx6ty-4fcQ-u9+uZb0xaD2gCJPCdpPvQg@mail.gmail.com>
 <f27f0d06-0b18-06bb-cb1f-042527c1ca31@redhat.com> <CAFv23Q==ghYCW-ukKQJZ_JhYgS4CSCDwbg9sZL9_B1Pa_LviWg@mail.gmail.com>
 <0132feaa-6a89-2a8a-9eb2-c444b61c01b3@redhat.com>
In-Reply-To: <0132feaa-6a89-2a8a-9eb2-c444b61c01b3@redhat.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 15 Jun 2023 09:53:19 +0800
Message-ID: <CAFv23QmzjKA75Z=r9v-2BzePwaD_25MepBvpWXArThypH_rMsA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Hans de Goede <hdegoede@redhat.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi AceLan,
>
> On 6/13/23 09:30, AceLan Kao wrote:
> > Hans de Goede <hdegoede@redhat.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=888=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> Hi AceLan,
> >>
> >> On 6/8/23 05:04, AceLan Kao wrote:
> >>> Hans de Goede <hdegoede@redhat.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=88=
8=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 6/7/23 09:47, Matthew Garrett wrote:
> >>>>> On Wed, Jun 07, 2023 at 03:39:33PM +0800, AceLan Kao wrote:
> >>>>>
> >>>>>> What do you think if we unregister backlight devices if the backli=
ght type
> >>>>>> is larger than the current registered one.
> >>>>>> Do this check in backlight_device_register() and unregister backli=
ght
> >>>>>> devices by the order raw(1) > platform(2) > firmware(3)
> >>>>>> And maybe introduce a sticky bit into the backlight device if the =
backlight
> >>>>>> driver doesn't want to be removed.
> >>>>>
> >>>>> Hans looked at doing this, but there were some awkward corner cases=
.
> >>>>> When we first introduced this functionality, firmware was preferred=
 to
> >>>>> platform was preferred to raw - but on Intel, at least, this behavi=
our
> >>>>> changed with later versions of Windows. I don't think there's a sin=
gle
> >>>>> static policy that works, I think you need to pay attention to the =
hints
> >>>>> the platform gives you. How does Windows know which interface to us=
e on
> >>>>> this platform? The simplest solution may actually just be for
> >>>>> dell-laptop to refuse to register a backlight if the platform claim=
s to
> >>>>> be Windows 8 or later.
> >>>>
> >>>> I like that idea.
> >>>>
> >>>> AceLan, I guess that you hit this easy while testing on a (developme=
nt)
> >>>> Meteor Lake platform ?
> >>>>
> >>>> I have had other/similar reports about Meteor Lake platforms.
> >>>>
> >>>> On hw from the last 10 years dell-laptop will not register
> >>>> its vendor-type backlight class device because
> >>>> acpi_video_get_backlight_type() will return acpi_backlight_video
> >>>> there (1) so it does not matter if the GPU driver shows up only
> >>>> later (2).
> >>>>
> >>>> But it seems that on Meteor Lake the ACPI tables will no longer
> >>>> contain acpi_video backlight control support which causes
> >>>> acpi_video_get_backlight_type() to return acpi_backlight_vendor (2).
> >>>> triggering the issue you are seeing.
> >>>>
> >>>> Can you give the attached patch a try please ?
> >>>>
> >>>> Regards,
> >>>>
> >>>> Hans
> >>>>
> >>>>
> >>>> 1) Starting with kernel >=3D 6.2 acpi_video.c will only register
> >>>> the /sys/class/backlight/acpi_video# node after a drm/kms drivers
> >>>> asks it to register it.
> >>>>
> >>>> 2) The native GPU driver will tell the drivers/acpi/video_detect.c
> >>>> code that native backlight control is available changing
> >>>> the return of acpi_video_get_backlight_type() to native, which
> >>>> is why loading the native GPU driver first also fixes this issue.
> >>>
> >>> Hi Hans,
> >>>
> >>> Yes, this patch works for me, thanks.
> >>>
> >>> BTW, I encountered this issue on the RPL platform.
> >>
> >> Thank you for testing. I have updated the commit message
> >> to reflect that this impacts both RPL and MTL platforms
> >> and submitted the fix upstream:
> >>
> >> https://lore.kernel.org/linux-acpi/20230608091258.7963-1-hdegoede@redh=
at.com/
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >
> > Hi Hans,
> >
> > I got another issue on the same platform.
> > The first issue was that when set to DSC graphics only in the BIOS,
> > I encountered the issue I reported here, dell_laptop creates dell_backl=
ight
> > and then nvidia creates nvidia_0 later.
> >
> > Now, set to hybrid mode in the BIOS, I found I still got 2 backlight in=
terfaces
> >    $ ls /sys/class/backlight/
> >    acpi_video0  intel_backlight
> > acpi_video0 is redundant and non-working.
> >
> > Do you think should I set this platform to the dmi quirk? Or is there a=
nything
> > I could try to get rid of this?
>
>
> This is very hard to answer without more info.
>
> For starters please make sure that you are testing with the latest kernel=
 and
> provide full dmesg output for a boot with the BIOS set to hybrid mode.
>
> Regards,
>
> Hans
>
Sorry to bother you, the issue has been fixed by the below commit.
e506731c8f35 ("ACPI: video: Make acpi_backlight=3Dvideo work independent
from GPU driver")
Thanks.
