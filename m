Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4005694EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBMSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjBMSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:12:10 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11767B74E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:59 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v81so6694473vkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb3LshHLxSQgF3w0k9C11QJ/y6qj7sAJ3S8kmCUrATA=;
        b=c2vB7YepOv3IasRmcEsYKNTFXbAREvzH2Jzz9ZqXKc9LKKJN4DwSMLQbFzMk6jRKf7
         wjyW1FMLu6kf+tpkMB4eYPphpxFII5HbWM9MaByn+UIe1U2O+SKvSJp3t7/IPuMpSF6F
         56ECThgLIUwn0lGSUzcCICY6TlEwwarijCqBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb3LshHLxSQgF3w0k9C11QJ/y6qj7sAJ3S8kmCUrATA=;
        b=Y70l4IpH2UUBqg3Yikzve5tNNxbtJps4qRd+JktSCQQWMfDPgWjOl+gOkt7ockzuHO
         PnzTOUPYpo7gmKZ0lytV3uIaZXnYzeDRQkNRKqgjaIivmzp8+OMUJxH/tFM49BwU+dCe
         8yZXeI2eNHQG6YRRe+KxyNKoad0MvkHS0mRvanykCCLlGTnplWgK+ajr4IFrsEwdifIC
         nPhgmFEzuuoccLNuSbA6aKAsy2Vli/SyiBf9Z9ALbOWJ5lOK2JLHDhlvzmQhKVRBtbxg
         bF2KvVB2k/KQsuoITPT/n7KPNHbcQlfB/FsT0sqwk/eMPVp4fNfNeRnvMLUnXT7KmlpN
         7Naw==
X-Gm-Message-State: AO0yUKWoH3rFE/w8oPOhLT7aRtLEcoSWNTO2EObjBm0+Lm4jjdv20Kae
        /2VeLCS3UD2bU8e1G81I6hBP0EX37ZjKk/Xd
X-Google-Smtp-Source: AK7set+U+mM8RQJPd0oOb0xYAWOO4sNtgjkE3RvNyoi/5pVwhc3EC1MUzNCGb9xSpRk/FIYO3Wr9Ww==
X-Received: by 2002:ac5:c14b:0:b0:401:6022:f8bf with SMTP id e11-20020ac5c14b000000b004016022f8bfmr2928518vkk.1.1676311918630;
        Mon, 13 Feb 2023 10:11:58 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id b67-20020a1f1b46000000b003daf1970223sm983286vkb.23.2023.02.13.10.11.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:11:57 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id p14so1704621vsn.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:11:57 -0800 (PST)
X-Received: by 2002:a05:6102:1590:b0:411:c7ae:5b47 with SMTP id
 g16-20020a056102159000b00411c7ae5b47mr2679338vsv.68.1676311917426; Mon, 13
 Feb 2023 10:11:57 -0800 (PST)
MIME-Version: 1.0
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Feb 2023 10:11:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WdMtzHryJXxMgYqXkqtFzowqcdvWYOxn4du8mQwYKvcg@mail.gmail.com>
Message-ID: <CAD=FV=WdMtzHryJXxMgYqXkqtFzowqcdvWYOxn4du8mQwYKvcg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Reserve DSPPs based on user request
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
        marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 13, 2023 at 3:11 AM Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> This series will enable color features on sc7280 target which has
> primary panel as eDP
>
> The series removes DSPP allocation based on encoder type and allows
> the DSPP reservation based on user request via CTM.
>
> The series will release/reserve the dpu resources whenever there is
> a CTM enable/disable change so that DSPPs are allocated appropriately.
>
> Kalyan Thota (4):
>   drm/msm/dpu: clear DSPP reservations in rm release
>   drm/msm/dpu: add DSPPs into reservation upon a CTM request
>   drm/msm/dpu: avoid unnecessary check in DPU reservations
>   drm/msm/dpu: manage DPU resources if CTM is requested
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 38 ++++++++++++-----------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 ++
>  drivers/gpu/drm/msm/msm_atomic.c            | 18 ++++++++++++++
>  drivers/gpu/drm/msm/msm_drv.c               |  2 +-
>  drivers/gpu/drm/msm/msm_drv.h               |  1 +
>  5 files changed, 38 insertions(+), 23 deletions(-)

For whatever reason when I use "b4 shazam" on your series it yells:

Patch failed at 0002 drm/msm/dpu: add DSPPs into reservation upon a CTM request
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:573
error: drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch

...but then I can apply it with `git am --show-current-patch=diff |
patch -p1` and it just applies with fuzz. Presumably Abhniav / Dmitry
can do the same but it would be nice if your patch applied cleanly to
msm-next.

In any case, I tried this patch on both a herobrine (sc7280) and
trogdor (sc7180) based board running msm-next (including the sc7280
patch [1]). In both cases the night light on the internal display
worked fine when using ChromeOS. External night light didn't work on
either of them (as expected) because we don't have the compositor
support yet.

I'm happy enough with:

Tested-by: Douglas Anderson <dianders@chromium.org>


[1] https://lore.kernel.org/r/1674814487-2112-1-git-send-email-quic_kalyant@quicinc.com/
