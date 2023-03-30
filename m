Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC76D0821
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjC3OYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjC3OYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:24:08 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D9A246
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:23:59 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 89so13973451uao.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680186234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdDVtbZuDJf8upkh5HvXpNatNcQceszJUO7yYX9Degg=;
        b=ip/Zu7Dn0JOCA+qBKDnaoAQOGK0/Y6mlD+9t+OPR8CGp1jr48wTcuavX42kVvk5NzL
         VnZSde1nOrs56QzIZjtT6nyQsR5Nx5heXNnemz/MZq8zKtL0CgEmWZ3ZI+yctVs9aYdj
         m4eNbw0dsJOuyXukigG1NnONS7JUJUFG6yt2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdDVtbZuDJf8upkh5HvXpNatNcQceszJUO7yYX9Degg=;
        b=J6WlHPfJ0WFCJw3o5sFwEVg1EUWT8DSgUR/tz6xtBuXOEip+9oZiAQuZSn7Pi5ml7e
         Lp8txbKyPSSrka9akxhTIBILOw2Lr0ibgNZnzoNITBGyNwsAr7rD4JAHRSt7vTlPJFT0
         PxWw2fQbA7oAVQnO/4GvOJb4SrPjIQPHEldI3rdU0Vczn73AWeWHxempNKGyMw99aeor
         IuSMx3guQoInf1IJG3rt4V3DzjGjAwTtLcT99UsiogJ+uVkZw85UCNNXgsBCk8wQ0PmP
         LlhlbON51lJVnjAckJECOgrFp+W72upPgUJHu+MSa9dyOQ/Mlv4yIdSoOjz6UAkKzW6P
         QIdA==
X-Gm-Message-State: AAQBX9cWTIBkFw+cux831Rpyx0YcCV6Y6712BlYFhhqolPX82R2Ht7BX
        +6fcOZAr3hUbdZWlCtkYndyGpaNI3Gqg7ImkSmA=
X-Google-Smtp-Source: AKy350ZiMG5KMnn2UY8f6nDrqrva+bL4rSdRZ1cIqK0cE76vKpkkZcJehntarW7U4DRYAjY7fpCsKg==
X-Received: by 2002:a1f:ee05:0:b0:436:8d4b:e7d3 with SMTP id m5-20020a1fee05000000b004368d4be7d3mr8967872vkh.12.1680186234705;
        Thu, 30 Mar 2023 07:23:54 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id f17-20020a1f3811000000b0043b79172fa2sm2464080vka.56.2023.03.30.07.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:23:52 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id r7so13955629uaj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:23:51 -0700 (PDT)
X-Received: by 2002:a1f:ac17:0:b0:43b:7928:7a25 with SMTP id
 v23-20020a1fac17000000b0043b79287a25mr10387566vke.1.1680186230654; Thu, 30
 Mar 2023 07:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
 <20230326162723.3lo6pnsfdwzsvbhj@ripper> <20230326163556.iesjkoh3nw3iwvf2@ripper>
 <CAE-0n520ypTRNT1X6kZ8o_Z+DN_68qwqZc1wZGMwsFqV5naktw@mail.gmail.com>
 <BN0PR02MB81736AFC01FB13F1640068CEE4899@BN0PR02MB8173.namprd02.prod.outlook.com>
 <CAD=FV=UjHiEk==KAhbx6QFW++69vDAM44sw-b2MGcJ7NsfbF-A@mail.gmail.com>
In-Reply-To: <CAD=FV=UjHiEk==KAhbx6QFW++69vDAM44sw-b2MGcJ7NsfbF-A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Mar 2023 07:23:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7UoA5jP-ANFMNzm3oLbYmT73uDnqs0oKHKb16-NcULg@mail.gmail.com>
Message-ID: <CAD=FV=V7UoA5jP-ANFMNzm3oLbYmT73uDnqs0oKHKb16-NcULg@mail.gmail.com>
Subject: Re: [PATCH v14 14/14] drm/msm/dp: set self refresh aware based on PSR support
To:     Vinod Polimera <vpolimer@qti.qualcomm.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "Vishnuvardhan Prodduturi (QUIC)" <quic_vproddut@quicinc.com>,
        "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
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

On Wed, Mar 29, 2023 at 8:47=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Mar 29, 2023 at 8:16=E2=80=AFAM Vinod Polimera
> <vpolimer@qti.qualcomm.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Stephen Boyd <swboyd@chromium.org>
> > > Sent: Monday, March 27, 2023 9:58 PM
> > > To: Bjorn Andersson <andersson@kernel.org>; Vinod Polimera (QUIC)
> > > <quic_vpolimer@quicinc.com>
> > > Cc: dri-devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
> > > freedreno@lists.freedesktop.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; robdclark@gmail.com; dianders@chromium.org;
> > > Kalyan Thota (QUIC) <quic_kalyant@quicinc.com>;
> > > dmitry.baryshkov@linaro.org; Kuogee Hsieh (QUIC)
> > > <quic_khsieh@quicinc.com>; Vishnuvardhan Prodduturi (QUIC)
> > > <quic_vproddut@quicinc.com>; Bjorn Andersson (QUIC)
> > > <quic_bjorande@quicinc.com>; Abhinav Kumar (QUIC)
> > > <quic_abhinavk@quicinc.com>; Sankeerth Billakanti (QUIC)
> > > <quic_sbillaka@quicinc.com>
> > > Subject: Re: [PATCH v14 14/14] drm/msm/dp: set self refresh aware bas=
ed
> > > on PSR support
> > >
> > > Quoting Bjorn Andersson (2023-03-26 09:35:56)
> > > > On Sun, Mar 26, 2023 at 09:27:23AM -0700, Bjorn Andersson wrote:
> > > > > On Thu, Mar 02, 2023 at 10:03:17PM +0530, Vinod Polimera wrote:
> > > > > > For the PSR to kick in, self_refresh_aware has to be set.
> > > > > > Initialize it based on the PSR support for the eDP interface.
> > > > > >
> > > > >
> > > > > When I boot my sc8280xp devices (CRD and X13s) to console with th=
is
> > > > > patch included I get a login prompt, and then there are no more s=
creen
> > > > > updates.
> > > > >
> > > > > Switching virtual terminal (ctrl+alt+fN) causes the screen to red=
raw.
> > > > >
> > > > > Blindly login in and launching Wayland works and from then on scr=
een
> > > > > updates works as expected.
> > > > >
> > > > > Switching from Wayland to another virtual terminal causes the pro=
blem
> > > to
> > > > > re-appear, no updates after the initial refresh, switching back g=
o the
> > > > > Wayland-terminal crashed the machine.
> > > > >
> > > >
> > > > Also, trying to bring the eDP-screen back from DPMS gives me:
> > > >
> > > > <3>[ 2355.218099] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]]
> > > *ERROR* set state_bit for link_train=3D1 failed
> > > > <3>[ 2355.218926] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > training #1 failed. ret=3D-110
> > > > <3>[ 2355.262859] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]]
> > > *ERROR* set state_bit for link_train=3D1 failed
> > > > <3>[ 2355.263600] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > training #1 failed. ret=3D-110
> > > > <3>[ 2355.305211] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]]
> > > *ERROR* set state_bit for link_train=3D1 failed
> > > > <3>[ 2355.305955] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > training #1 failed. ret=3D-110
> > > > <3>[ 2355.345250] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]]
> > > *ERROR* set state_bit for link_train=3D1 failed
> > > > <3>[ 2355.346026] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link
> > > training #1 failed. ret=3D-110
> > > > <3>[ 2355.405650] [drm:dp_display_process_hpd_high [msm]] *ERROR*
> > > failed to complete DP link training
> > > > <3>[ 2355.668988]
> > > [drm:dpu_encoder_phys_vid_wait_for_commit_done:488] [dpu
> > > error]vblank timeout
> > > > <3>[ 2355.669030] [drm:dpu_kms_wait_for_commit_done:510] [dpu
> > > error]wait for commit done returned -110
> > > > <3>[ 2355.699989] [drm:dpu_encoder_frame_done_timeout:2398] [dpu
> > > error]enc35 frame done timeout
> > > >
> > > > And then the machine just resets.
> > > >
> > >
> > > I saw similar behavior on ChromeOS after we picked the PSR patches in=
to
> > > our kernel. I suspect it's the same problem. I switched back and fort=
h
> > > between VT2 and the OOBE screen with ctrl+alt+forward and that showed
> > > what I typed on the virtual terminal after switching back and forth.
> > > It's like the redraw only happens once on the switch and never again.=
 I
> > > switched back and forth enough times that it eventually crashed the
> > > kernel and rebooted. This was on CRD (sc7280-herobrine-crd.dts).
> > >
> > > There's an animation on the OOBE screen that is working though, so
> > > perhaps PSR is working with the chrome compositor but not the virtual
> > > terminal? I haven't investigated.
> >
> > I was able to reproduce the issue where in virtual terminal, I don't se=
e any screen refresh despite typing in.
> > In the VT mode, I see that PSR is entered, but despite typing in there =
are no atomic commits triggered, hence the last buffer was always refreshed=
.
> >
> > Queries from my side to Rob & Doug:
> > 1) In VT mode, does the framework operates in single buffer mode withou=
t any commit for new updates ?
> > 2) if above is true then, how does driver know if the framework operate=
s in single buffer mode, to make any appropriate action
> > 3) what is the expected behavior with the driver here ? should it retur=
n atomic_check failure, for single buffer mode operation or, it should exit=
 PSR ?
> > 4) is there any HINT passed down to the driver so that we can bank on i=
t and act accordingly?
>
> I haven't looked at this detail about PSR before, and I left my
> PSR-enabled device at home so I can't easily test this right now. That
> being said, from a bit of searching I would guess that
> msm_framebuffer_dirtyfb() is somehow involved here. Are things better
> if you get rid of the test against 'msm_fb->dirtyfb'?
>
> I at least used ftrace to confirm that on a different device
> msm_framebuffer_dirtyfb() is not called during normal ChromeOS usage
> but it _is_ called in VT2 usage.

Indeed, I can confirm that if I comment out the test in
msm_framebuffer_dirtyfb() and just call straight through to
drm_atomic_helper_dirtyfb() that typing on VT2 works fine.

...so presumably you need to figure out how to get "dirtyfb" set
properly when you have a PSR-enabled panel or maybe whenever the panel
enters PSR mode?

-Doug
