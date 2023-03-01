Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BD6A755C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCAUc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCAUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:32:24 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAC48E2F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:32:23 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id r4so9129052ila.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYLUGupyjMeev27c+qWxeJczPJEjR3Ydgup+v8f48I0=;
        b=GmGgxIMa7jgrR0m+YdLsk7vfyL/4rJnMGC5mfcGR/R7G0gFYRjWDlZl3TA0bO7F+Qg
         RwBcF1jdEoNchqOUUlWul6LxOLORwwjrjhzZzDQPClEh29xaJAHBiR2Ma4FzFHT6dv+B
         O8/SdUNfByPhJ947xgUUtecxVu5h5xtRet+y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYLUGupyjMeev27c+qWxeJczPJEjR3Ydgup+v8f48I0=;
        b=KvzkqMaIbf/LZchkpaT5oQoF0btKYLCbDhcO5lpr3NufjCw5sF4MP9QvcF9vf0Rxzc
         B5K5nLBo+lLZRq9ov7DMieyGVyVsUfYyyy809247SbhChEoIW0aQCuoUpJU6wr8ARErL
         1tAfoIZSmdJPhGKtBQvFxEf6RId+qvcxJ4/sMKrPUUk0CrLhz5XxFO85WAJ3hZmM/a2o
         ZBJk99xbyynjBc6i4KRN1jZUCj+Hh2fntT5PBUkH8UxWTulBCNLWHBCYPGqXGyypyyhr
         AFEGEtNSRrvhjMT+zqtXpxgcKnBR1bTfpS7JhnBHiEp+N4i6eUjQfhTlDhgEVCynKgv9
         cP+w==
X-Gm-Message-State: AO0yUKXA5Xa8Vz393KN8Fad1Ur6wm92KvslffR7G2p0DeXN9oqnpR+ck
        JXq+P3a1f4LCcWQSAk9Q5wcfTQ6FomKeve1d
X-Google-Smtp-Source: AK7set/wvJWpw7xKrszCgYYU+FYHsmM+AO2dD+CAv1o5RiT5+8xkhFKwBe777dh95PUDb4OOMK/pRg==
X-Received: by 2002:a05:6e02:1c08:b0:311:137e:83c6 with SMTP id l8-20020a056e021c0800b00311137e83c6mr7351509ilh.22.1677702742145;
        Wed, 01 Mar 2023 12:32:22 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id b13-20020a05663801ad00b003e9e5e1aacasm3887729jaq.143.2023.03.01.12.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 12:32:21 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id f14so5902706iow.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:32:20 -0800 (PST)
X-Received: by 2002:a05:6602:14a:b0:745:b287:c281 with SMTP id
 v10-20020a056602014a00b00745b287c281mr3679858iot.2.1677702739460; Wed, 01 Mar
 2023 12:32:19 -0800 (PST)
MIME-Version: 1.0
References: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com> <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
In-Reply-To: <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Mar 2023 12:32:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VD2V=NvNCotU_bLH4LuGEO8W8a0sH0uc--KsaUsneSFg@mail.gmail.com>
Message-ID: <CAD=FV=VD2V=NvNCotU_bLH4LuGEO8W8a0sH0uc--KsaUsneSFg@mail.gmail.com>
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

On Wed, Mar 1, 2023 at 11:06=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Sun, Feb 12, 2023 at 8:29=E2=80=AFAM Vinod Polimera
> <quic_vpolimer@quicinc.com> wrote:
> >
> > Changes in v2:
> >   - Use dp bridge to set psr entry/exit instead of dpu_enocder.
> >   - Don't modify whitespaces.
> >   - Set self refresh aware from atomic_check.
> >   - Set self refresh aware only if psr is supported.
> >   - Provide a stub for msm_dp_display_set_psr.
> >   - Move dp functions to bridge code.
> >
> > Changes in v3:
> >   - Change callback names to reflect atomic interfaces.
> >   - Move bridge callback change to separate patch as suggested by Dmitr=
y.
> >   - Remove psr function declaration from msm_drv.h.
> >   - Set self_refresh_aware flag only if psr is supported.
> >   - Modify the variable names to simpler form.
> >   - Define bit fields for PSR settings.
> >   - Add comments explaining the steps to enter/exit psr.
> >   - Change DRM_INFO to drm_dbg_db.
> >
> > Changes in v4:
> >   - Move the get crtc functions to drm_atomic.
> >   - Add atomic functions for DP bridge too.
> >   - Add ternary operator to choose eDP or DP ops.
> >   - Return true/false instead of 1/0.
> >   - mode_valid missing in the eDP bridge ops.
> >   - Move the functions to get crtc into drm_atomic.c.
> >   - Fix compilation issues.
> >   - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc=
.
> >   - Check for crtc state enable while reserving resources.
> >
> > Changes in v5:
> >   - Move the mode_valid changes into a different patch.
> >   - Complete psr_op_comp only when isr is set.
> >   - Move the DP atomic callback changes to a different patch.
> >   - Get crtc from drm connector state crtc.
> >   - Move to separate patch for check for crtc state enable while
> > reserving resources.
> >
> > Changes in v6:
> >   - Remove crtc from dpu_encoder_virt struct.
> >   - fix crtc check during vblank toggle crtc.
> >   - Misc changes.
> >
> > Changes in v7:
> >   - Add fix for underrun issue on kasan build.
> >
> > Changes in v8:
> >   - Drop the enc spinlock as it won't serve any purpose in
> > protetcing conn state.(Dmitry/Doug)
> >
> > Changes in v9:
> >   - Update commit message and fix alignment using spaces.(Marijn)
> >   - Misc changes.(Marijn)
> >
> > Changes in v10:
> >   - Get crtc cached in dpu_enc during obj init.(Dmitry)
> >
> > Changes in v11:
> >   - Remove crtc cached in dpu_enc during obj init.
> >   - Update dpu_enc crtc state on crtc enable/disable during self refres=
h.
> >
> > Changes in v12:
> >   - Update sc7180 intf mask to get intf timing gen status
> > based on DPU_INTF_STATUS_SUPPORTED bit.(Dmitry)
> >   - Remove "clear active interface in the datapath cleanup" change
> > as it is already included.
> >
> > Changes in v13:
> >   - Move core changes to top of the series.(Dmitry)
> >   - Drop self refresh aware disable change after psr entry.(Dmitry)
> >
> > Vinod Polimera (13):
> >   drm: add helper functions to retrieve old and new crtc
> >   drm/bridge: use atomic enable/disable callbacks for panel bridge
> >   drm/bridge: add psr support for panel bridge callbacks
> >   drm/msm/disp/dpu: check for crtc enable rather than crtc active to
> >     release shared resources
> >   drm/msm/disp/dpu: get timing engine status from intf status register
> >   drm/msm/disp/dpu: wait for extra vsync till timing engine status is
> >     disabled
> >   drm/msm/disp/dpu: reset the datapath after timing engine disable
> >   drm/msm/dp: use atomic callbacks for DP bridge ops
> >   drm/msm/dp: Add basic PSR support for eDP
> >   drm/msm/dp: use the eDP bridge ops to validate eDP modes
> >   drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
> >     functions
> >   drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
> >   drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable
> >     during self refresh
>
> I'm curious what the plan is for landing this series. I could land the
> first two in drm-misc if you want, but I'm a lowly committer and so I
> couldn't make an immutable branch for you nor can I officially Ack the
> changes to land in your branch. That means you'd be blocked for an
> extra version. Do you already have a plan? If not, then maybe we need
> to get in touch with one of the maintainers [1] of drm-misc? That's
> documented [2] to be in their set of responsibilities.
>
> [1] https://drm.pages.freedesktop.org/maintainer-tools/repositories.html#=
drm-misc-repository
> [2] https://drm.pages.freedesktop.org/maintainer-tools/maintainer-drm-mis=
c.html#maintainer-s-duties

The above question about how we'd land this is still a good one, but
perhaps less relevant quite yet because, at least in my testing, the
current series doesn't work. :-/

I know previous versions worked, so I went back and tried older
versions. It turns out that v12 _does_ work for me, but v13 doesn't
work. The difference is very small. I'm assuming you made some changes
in v13 and they looked so small that you just sent v13 out without
testing? ...or, of course, there's always a possibility that I messed
up in testing this myself, though I did repeat my results and they
were consistent.

FWIW, my testing was roughly to do this on a device that had a
PSR-enabled eDP display:

echo "dp_catalog_ctrl_set_psr" > /sys/kernel/debug/tracing/set_ftrace_filte=
r
echo function > /sys/kernel/debug/tracing/current_tracer
echo 1 > /sys/kernel/debug/tracing/tracing_on
cat /sys/kernel/debug/tracing/trace_pipe

I should see a splat in the trace buffers each time PSR is entered or
exited. On v12 I get splats as the cursor on my screen blinks. On v13,
it's just silence.

Please confirm that you tested v13. If you're confident that v13 works
then I can dig further myself.

-Doug
