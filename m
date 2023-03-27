Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31BF6CAA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjC0Q1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0Q1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:27:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0E1707
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:27:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e11so9646803lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679934456;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfqsUiLP5Vh8YGPxF2VMjFnsdklhQkYhzVCbJtdJx1Y=;
        b=BULGouv4k14uH72Y42Uplkdk+YxchsnjND6wQ+JwP5esObqf5l7IIL+EH8bPZ8VOuv
         ZuCgr2KQXEjieFab/CwvaUP5WVSHaQzymir9PpPgM01oUBC2bLL2dbGlfeBGqbEQJ9hQ
         RSaWr+Q8RDY647kvicF7BJCQw9QoX4D2PXGss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934456;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfqsUiLP5Vh8YGPxF2VMjFnsdklhQkYhzVCbJtdJx1Y=;
        b=xQbR8hy/N2vfCasQAy9H0t7KbQTjC5se9Fs9y5lY3BhvE4mt+ve9S/+k+A2Eh/x9b2
         ApuPWXlnghaqLydoJ9pgwXyuZqqlSmSy5ykHHSdA8EceuBLzgDKDG0yTZm/CP9aE0eqC
         kVVmg9t70SK73wO9/NUiEKlDk7rNUje0ilqIvPUUk1DlcDnPvyC3wDjFXLTKGj6kcBWs
         BHjuDLOy/mibM0RAeovWpQTUhPUD0/zDjYPVKNEoENqmef9uZq8TTcOxW5Le0fgCbB6e
         uF7CdYXJ08raETv/LB9h9u2Z7/mztXGPt96BHrJA7zysUOhS1oihr4/eEs5E5BMDEUXS
         pjOQ==
X-Gm-Message-State: AAQBX9fUPSc5IFWIDPtLD2pl+cDg5SniLY2GYz6HB5UgErK8VYUW2aTj
        530ZCOGdGgrSipZ7qC+yD8yX6IL0EwCDZxGqFH+iyQ==
X-Google-Smtp-Source: AKy350Y5rCbfQeYtWgJzS3zFEW8VUffjLZ9uIR3CgRrH+NheaWYomMEl7eyKQ0BV0h4gWbqifwKF1r/nWBPuk4A4eaY=
X-Received: by 2002:a2e:9792:0:b0:2a3:fc8:711b with SMTP id
 y18-20020a2e9792000000b002a30fc8711bmr3696218lji.10.1679934456057; Mon, 27
 Mar 2023 09:27:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Mar 2023 16:27:35 +0000
MIME-Version: 1.0
In-Reply-To: <20230326163556.iesjkoh3nw3iwvf2@ripper>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
 <20230326162723.3lo6pnsfdwzsvbhj@ripper> <20230326163556.iesjkoh3nw3iwvf2@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 27 Mar 2023 16:27:35 +0000
Message-ID: <CAE-0n520ypTRNT1X6kZ8o_Z+DN_68qwqZc1wZGMwsFqV5naktw@mail.gmail.com>
Subject: Re: [PATCH v14 14/14] drm/msm/dp: set self refresh aware based on PSR support
To:     Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2023-03-26 09:35:56)
> On Sun, Mar 26, 2023 at 09:27:23AM -0700, Bjorn Andersson wrote:
> > On Thu, Mar 02, 2023 at 10:03:17PM +0530, Vinod Polimera wrote:
> > > For the PSR to kick in, self_refresh_aware has to be set.
> > > Initialize it based on the PSR support for the eDP interface.
> > >
> >
> > When I boot my sc8280xp devices (CRD and X13s) to console with this
> > patch included I get a login prompt, and then there are no more screen
> > updates.
> >
> > Switching virtual terminal (ctrl+alt+fN) causes the screen to redraw.
> >
> > Blindly login in and launching Wayland works and from then on screen
> > updates works as expected.
> >
> > Switching from Wayland to another virtual terminal causes the problem to
> > re-appear, no updates after the initial refresh, switching back go the
> > Wayland-terminal crashed the machine.
> >
>
> Also, trying to bring the eDP-screen back from DPMS gives me:
>
> <3>[ 2355.218099] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
> <3>[ 2355.218926] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
> <3>[ 2355.262859] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
> <3>[ 2355.263600] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
> <3>[ 2355.305211] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
> <3>[ 2355.305955] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
> <3>[ 2355.345250] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
> <3>[ 2355.346026] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
> <3>[ 2355.405650] [drm:dp_display_process_hpd_high [msm]] *ERROR* failed to complete DP link training
> <3>[ 2355.668988] [drm:dpu_encoder_phys_vid_wait_for_commit_done:488] [dpu error]vblank timeout
> <3>[ 2355.669030] [drm:dpu_kms_wait_for_commit_done:510] [dpu error]wait for commit done returned -110
> <3>[ 2355.699989] [drm:dpu_encoder_frame_done_timeout:2398] [dpu error]enc35 frame done timeout
>
> And then the machine just resets.
>

I saw similar behavior on ChromeOS after we picked the PSR patches into
our kernel. I suspect it's the same problem. I switched back and forth
between VT2 and the OOBE screen with ctrl+alt+forward and that showed
what I typed on the virtual terminal after switching back and forth.
It's like the redraw only happens once on the switch and never again. I
switched back and forth enough times that it eventually crashed the
kernel and rebooted. This was on CRD (sc7280-herobrine-crd.dts).

There's an animation on the OOBE screen that is working though, so
perhaps PSR is working with the chrome compositor but not the virtual
terminal? I haven't investigated.
