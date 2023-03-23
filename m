Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D546C6E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCWQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCWQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:53:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B8DA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:53:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w25so4733198qtc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679590412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mV4JGejoE5XOnzyuiZjt16uJsH9qtIL7c03y2ALtMI=;
        b=cH4WGQSdAPzvRuWJYIKogXYHuGO3hdFI3a4OtKWeO0Pwf6AnDrkDGRfO3U4Kk7ZkCx
         OVyhq50Cd5vHfNRdsnvW8QW+ieZiz3SAdzko1clGTu4x3rB3d323iEgTAFTSv/EPS49V
         epBF93dxNZ1D9rDMPxjWmX+8a3bKRUJSpNnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mV4JGejoE5XOnzyuiZjt16uJsH9qtIL7c03y2ALtMI=;
        b=SZB1lvnqLJxnjSmfIpQcEM5sQClJi+65hUDe+mMimiwh210bJyDUEgTYRn8Bc9er+m
         S/KA8l5QoRFiCa1GLGz/07ShBOzriaV5742XfNZyCbU93/vXGTuf4sZUySvCry7auya8
         xVhZc3dvBl6nqfQlSMVXiaawGVLgTLlP36zK/bdijUjOAr9m4jfRp/9r9WNAD1TwCb4F
         cUp7sa7VFT+sC96hb1ZggkwgPUJ5cmUqBdLUfTGhWPL/h/PftgkaKO6NMK/XzAwRd2/b
         n/iJkslvfd7xshtPsf5oXvTvgZB4c+lkwVdumhFNmsSHcsianDVOiA4qjeHZU8pXFcBT
         PQTw==
X-Gm-Message-State: AO0yUKV4p+9zqasfPHaEl2eoYa9F6EYBRJXLuQDp1oP4sZfRclnOsy7Y
        IhwjllB1shVGMz+eoswPRcCLXA6U/Dvt6UDRwVk=
X-Google-Smtp-Source: AK7set8avUrYlIobX0djGyJX15PDzj/ofzxvc9qtjoq5csN2gLT8CV2lwGlEVhsqO8o+oV1LI+0wCQ==
X-Received: by 2002:ac8:5c16:0:b0:3df:50ef:fafa with SMTP id i22-20020ac85c16000000b003df50effafamr86538qti.4.1679590411871;
        Thu, 23 Mar 2023 09:53:31 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87a98000000b003d5266b14cdsm12241398qtr.5.2023.03.23.09.53.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:53:30 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5419d4c340aso405265187b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:53:30 -0700 (PDT)
X-Received: by 2002:a05:690c:78b:b0:544:bbd2:74be with SMTP id
 bw11-20020a05690c078b00b00544bbd274bemr2559449ywb.4.1679590410383; Thu, 23
 Mar 2023 09:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com> <20230323114035.GL68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230323114035.GL68926@ediswmail.ad.cirrus.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Mar 2023 09:53:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
Message-ID: <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 23, 2023 at 4:40=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Mar 23, 2023 at 09:33:12AM +0100, Marek Szyprowski wrote:
> > Restore synchronous probing for wm8994 regulators because otherwise the
> > sound device is never initialized on Exynos5250-based Arndale board.
> >
> > Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for driv=
ers that existed in 4.14")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/regulator/wm8994-regulator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/w=
m8994-regulator.c
> > index 8921051a00e9..2946db448aec 100644
> > --- a/drivers/regulator/wm8994-regulator.c
> > +++ b/drivers/regulator/wm8994-regulator.c
> > @@ -227,7 +227,7 @@ static struct platform_driver wm8994_ldo_driver =3D=
 {
> >       .probe =3D wm8994_ldo_probe,
> >       .driver         =3D {
> >               .name   =3D "wm8994-ldo",
> > -             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +             .probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> >       },
> >  };
>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Yes, these seems to be a wider problem with these complex CODECs
> that have an internal LDO. Changing to async probe, means the
> internal LDO driver doesn't probe before the code in the main MFD
> carries on, which means the regulator framework finds no driver
> and swaps in the dummy. Which means the CODEC never powers up.
>
> I think these basically have to be forced sync, I will do a patch
> to update the other devices working like this.

Sorry for the breakage and thank you for the fix.

No question that a quick switch back to PROBE_FORCE_SYNCHRONOUS is the
right first step here, but I'm wondering if there are any further
steps we want to take.

If my analysis is correct, there's still potential to run into similar
problems even with PROBE_FORCE_SYNCHRONOUS. I don't think that
mfd_add_devices() is _guaranteed_ to finish probing all the
sub-devices by the time it returns. Specifically, imagine that
wm8994_ldo_probe() tries to get a GPIO that that system hasn't made
available yet. Potentially the system could return -EPROBE_DEFER there
and that would put the LDO on the deferred probe list. Doing so won't
cause mfd_add_devices() to fail. Now we'll end up with a dummy
regulator again. Admittedly most cases GPIO providers probe really
early and so this argument is a bit of a stretch, but I guess the
point is that there's no official guarantee that mfd_add_devices()
will finish probing all sub-devices so it's not ideal to rely on.
Also, other drivers with a similar pattern might have other reasons to
-EPROBE_DEFER.

These types of issues are the same ones I faced with DP AUX bus and
the solutions were never super amazing...

One solution we ended up with for the DP AUX bus was to add a
"done_probing" callback argument to devm_of_dp_aux_populate_bus().
This allowed the parent to be called back when all the children were
done probing. This implementation is easier for DP AUX bus than it
would be in the generic MFD case, but conceivably it would be possible
there too?

Another possible solution is to somehow break the driver up into more
sub-drivers. Essentially, you have a top-level "wm8994" that's not
much more than a container. Then you create a new-sub-device and
relegate anything that needs the regulators to the new sub-device. The
new sub-device can just -EPROBE_DEFER until it detects that the
regulators have finished probing. I ended up doing stuff like this for
"ti-sn65dsi86.c" using the Linux aux bus (not to be confused with the
DP Aux bus) and it was a bit odd but worked OK.

-Doug
