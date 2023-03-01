Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B207F6A7402
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCATGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCATGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:06:35 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C44C6C4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:06:33 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b16so8982693iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 11:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nKAIImYnR4VY+mZrL40T8w+LQbikOjFpNewqlXCyj8=;
        b=OV8S586G9AFm1/8w9oYCFIsznJuud/neA8wqia26BClD7KXP2fGeGaDSsVRI8TIL37
         4io6dzUbTNvMTMEN1uTw4P/Dv4z7VnZh6cp25YrBJ2G6r35Jszp2pJQSK3255wnfYC4j
         h9AZfEPujFC6V+vLfeqxylvCcgQFSaDqrbeN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nKAIImYnR4VY+mZrL40T8w+LQbikOjFpNewqlXCyj8=;
        b=tCCrUT/EyUlnomleHujG+Klgnq8u83M4Lo/mOwIE59RmTcFiytXIhZC4t7Ci+Vt5Wd
         tdE64zMiJSa9Eg5+2qKuZupmzUAeEegGahh3W1Zv00HZhfwXOrZAFW8CD4mBiVFyiaVh
         e1y92xS5wrSxIxH8vUBhy6AZLD208si+WlJJmk3zQtaycKvpNrS2iRYe32Ic0ebZPcp4
         Znv582HwR/SgWnpxdDKggaxWQBXZguvNHj2YwPetX8yZWwkP+lWnpdbAb6tNGL1s9Pky
         1NJ5hu8mbyGtnG5Y65KFfiH6I3RTAqRY1KYf+DMZ4OeyXcXU6E76m1HvRAroijeYCdta
         e8NQ==
X-Gm-Message-State: AO0yUKV4/8sprSCxX8VN1TgTRCwz/82rejkijiaD5DKC4oNr9T8QDcmn
        I3g5Xr7s43MBlWZ5z8GSZfjbGIU/5dRi9U1V
X-Google-Smtp-Source: AK7set/s2Vg97+Egd4pG+dYk00L0IeeBnLBfElSxsMcuRUQhx9OXjOKT2D9SvFaJXkkd99zhBahZxA==
X-Received: by 2002:a05:6e02:12ed:b0:315:32a7:db1b with SMTP id l13-20020a056e0212ed00b0031532a7db1bmr6309922iln.2.1677697591890;
        Wed, 01 Mar 2023 11:06:31 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id u8-20020a056e02110800b00316e03385fdsm3809572ilk.31.2023.03.01.11.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 11:06:31 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id b5so5825886iow.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 11:06:30 -0800 (PST)
X-Received: by 2002:a02:858c:0:b0:3c5:1971:1b7f with SMTP id
 d12-20020a02858c000000b003c519711b7fmr3401570jai.6.1677697590506; Wed, 01 Mar
 2023 11:06:30 -0800 (PST)
MIME-Version: 1.0
References: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Mar 2023 11:06:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
Message-ID: <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
Subject: Re: [PATCH v13 00/13] Add PSR support for eDP
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        swboyd@chromium.org, quic_kalyant@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 12, 2023 at 8:29=E2=80=AFAM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> Changes in v2:
>   - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>   - Don't modify whitespaces.
>   - Set self refresh aware from atomic_check.
>   - Set self refresh aware only if psr is supported.
>   - Provide a stub for msm_dp_display_set_psr.
>   - Move dp functions to bridge code.
>
> Changes in v3:
>   - Change callback names to reflect atomic interfaces.
>   - Move bridge callback change to separate patch as suggested by Dmitry.
>   - Remove psr function declaration from msm_drv.h.
>   - Set self_refresh_aware flag only if psr is supported.
>   - Modify the variable names to simpler form.
>   - Define bit fields for PSR settings.
>   - Add comments explaining the steps to enter/exit psr.
>   - Change DRM_INFO to drm_dbg_db.
>
> Changes in v4:
>   - Move the get crtc functions to drm_atomic.
>   - Add atomic functions for DP bridge too.
>   - Add ternary operator to choose eDP or DP ops.
>   - Return true/false instead of 1/0.
>   - mode_valid missing in the eDP bridge ops.
>   - Move the functions to get crtc into drm_atomic.c.
>   - Fix compilation issues.
>   - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
>   - Check for crtc state enable while reserving resources.
>
> Changes in v5:
>   - Move the mode_valid changes into a different patch.
>   - Complete psr_op_comp only when isr is set.
>   - Move the DP atomic callback changes to a different patch.
>   - Get crtc from drm connector state crtc.
>   - Move to separate patch for check for crtc state enable while
> reserving resources.
>
> Changes in v6:
>   - Remove crtc from dpu_encoder_virt struct.
>   - fix crtc check during vblank toggle crtc.
>   - Misc changes.
>
> Changes in v7:
>   - Add fix for underrun issue on kasan build.
>
> Changes in v8:
>   - Drop the enc spinlock as it won't serve any purpose in
> protetcing conn state.(Dmitry/Doug)
>
> Changes in v9:
>   - Update commit message and fix alignment using spaces.(Marijn)
>   - Misc changes.(Marijn)
>
> Changes in v10:
>   - Get crtc cached in dpu_enc during obj init.(Dmitry)
>
> Changes in v11:
>   - Remove crtc cached in dpu_enc during obj init.
>   - Update dpu_enc crtc state on crtc enable/disable during self refresh.
>
> Changes in v12:
>   - Update sc7180 intf mask to get intf timing gen status
> based on DPU_INTF_STATUS_SUPPORTED bit.(Dmitry)
>   - Remove "clear active interface in the datapath cleanup" change
> as it is already included.
>
> Changes in v13:
>   - Move core changes to top of the series.(Dmitry)
>   - Drop self refresh aware disable change after psr entry.(Dmitry)
>
> Vinod Polimera (13):
>   drm: add helper functions to retrieve old and new crtc
>   drm/bridge: use atomic enable/disable callbacks for panel bridge
>   drm/bridge: add psr support for panel bridge callbacks
>   drm/msm/disp/dpu: check for crtc enable rather than crtc active to
>     release shared resources
>   drm/msm/disp/dpu: get timing engine status from intf status register
>   drm/msm/disp/dpu: wait for extra vsync till timing engine status is
>     disabled
>   drm/msm/disp/dpu: reset the datapath after timing engine disable
>   drm/msm/dp: use atomic callbacks for DP bridge ops
>   drm/msm/dp: Add basic PSR support for eDP
>   drm/msm/dp: use the eDP bridge ops to validate eDP modes
>   drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
>     functions
>   drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
>   drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable
>     during self refresh

I'm curious what the plan is for landing this series. I could land the
first two in drm-misc if you want, but I'm a lowly committer and so I
couldn't make an immutable branch for you nor can I officially Ack the
changes to land in your branch. That means you'd be blocked for an
extra version. Do you already have a plan? If not, then maybe we need
to get in touch with one of the maintainers [1] of drm-misc? That's
documented [2] to be in their set of responsibilities.

[1] https://drm.pages.freedesktop.org/maintainer-tools/repositories.html#dr=
m-misc-repository
[2] https://drm.pages.freedesktop.org/maintainer-tools/maintainer-drm-misc.=
html#maintainer-s-duties

-Doug
