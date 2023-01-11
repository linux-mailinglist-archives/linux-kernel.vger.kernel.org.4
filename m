Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862466650D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjAKA7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjAKA7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:59:44 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849F50F48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:59:42 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 3so14159772vsq.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpqKCIgPRMhpXTruKjB1OC0juXM/o08kG+iDAT9++eA=;
        b=gGC3PH3VfglXadEagUBFXOQTZR/RqQMmcQ2lP9IhyxzoFetggN2vu1o0T04fU9rYYm
         3Ms7UToJO+NO2joHkS5Qr71wryywqwqyjhAqPxtKC9qoSjCM8Fk10fCqGTnxfl2LF3er
         NVZA3sz7mHW23N/n6dGDFucJ2Tptzw0Ccr3u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpqKCIgPRMhpXTruKjB1OC0juXM/o08kG+iDAT9++eA=;
        b=CnyTasdL4wTqIGHDpRdU58XK0kZMlsOCi+5ZIel/pFffM0VFENKtZDIOIkQfZrs7qc
         YekoxbV0/eaYlrY2usCFvwtGUh6uuOY1dgmAGWwMxj1J/c6sPFMDq3SgCTMq4EmjZ3x2
         Cwc68o1JWqh+9n3+2GzL0uZpOnfbEGUd9A7UvM44NuOdyq1tcMAVNAXwEQsmDhQPeaRu
         YWSg6jjlAQkgQheWNNQOy+10zwxXcN/Z0edgTU9mZYGaigGH5dHVlaEo+OifAuakQsqA
         z2pklL/QtWWIr1iTNP1g5ZXhRcEC7L0eAGpFXaMU/U2JviU8zaGpQHpfmPWzvoXcqvB4
         EHLw==
X-Gm-Message-State: AFqh2kp33H2MmD+OQ/ejeFxzETjv+A5ZuJeysoXAJEqpAFGxovCaIqzW
        mHWTXFeHQ/5gmIYzrR4602DaKspqIHkQcnyZAEE=
X-Google-Smtp-Source: AMrXdXvP5dkm85A15C/7L+qfVGB3djRFhTez4sbHsmCgKfd4WqXZ0I8pIny21+JGWv7HJgr9K1fgHA==
X-Received: by 2002:a67:e3da:0:b0:3cb:1526:9dab with SMTP id k26-20020a67e3da000000b003cb15269dabmr25439031vsm.4.1673398781614;
        Tue, 10 Jan 2023 16:59:41 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id o13-20020a0561023f8d00b003c68cfd6630sm1099445vsv.1.2023.01.10.16.59.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 16:59:41 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id v127so9776728vsb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:59:39 -0800 (PST)
X-Received: by 2002:a05:6102:3e06:b0:3b5:fd8:7948 with SMTP id
 j6-20020a0561023e0600b003b50fd87948mr10845718vsv.85.1673398779099; Tue, 10
 Jan 2023 16:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20221231142721.338643-1-abel.vesa@linaro.org> <20221231142721.338643-2-abel.vesa@linaro.org>
In-Reply-To: <20221231142721.338643-2-abel.vesa@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Jan 2023 16:59:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XdQfg3KVdVrQtVyHM_RBeP_4TZE07mr2KWpP8PxbAdmA@mail.gmail.com>
Message-ID: <CAD=FV=XdQfg3KVdVrQtVyHM_RBeP_4TZE07mr2KWpP8PxbAdmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel-edp: add IVO M133NW4J panel entry
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 31, 2022 at 6:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add an eDP panel entry for IVO M133NW4J.
>
> Due to lack of documentation, use the delay_200_500_p2e100 timings like
> some other IVO entries for now.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>
> Assuming the information from here is correct:
> https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
>
> This fixes the following WARN_ON on my X13s:
>
> [    2.194973] CPU: 5 PID: 186 Comm: kworker/u16:6 Not tainted 6.2.0-rc1-00075-g5136d9aa278f-dirty #26
> [    2.195409] Hardware name: LENOVO 21BX000WRI/21BX000WRI, BIOS N3HET44W (1.16 ) 05/27/2022
> [    2.195820] Workqueue: events_unbound deferred_probe_work_func
> [    2.196234] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.196639] pc : panel_edp_probe+0x3d4/0x520 [panel_edp]
> [    2.197036] lr : panel_edp_probe+0x37c/0x520 [panel_edp]
> [    2.197435] sp : ffff80000970b3b0
> [    2.197833] x29: ffff80000970b3b0 x28: ffff0e0a80b7f760 x27: 0000000000000001
> [    2.198231] x26: ffff0e11fe0e1b50 x25: ffffa8f9f585e0c8 x24: 0000000000000000
> [    2.198630] x23: ffff0e0a81a39c80 x22: ffffa8f9f58c7638 x21: 0000000000000000
> [    2.199032] x20: ffff0e0a8d1b0000 x19: ffff0e0a820fea80 x18: 0000000000000000
> [    2.199576] x17: 0000000000000000 x16: ffffa8fa5e097080 x15: 0000000000000000
> [    2.199969] x14: 0000000000000003 x13: 0000000000000059 x12: 0000000000000066
> [    2.200360] x11: 0000000000000001 x10: 00000000000009e0 x9 : 0000000000000001
> [    2.200748] x8 : ffff80000970b340 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.201132] x5 : 0000000000000049 x4 : 0000000000000056 x3 : 000000000000004f
> [    2.201512] x2 : 0000000000000000 x1 : ffffa8f9f58c7a00 x0 : 000000000000854a
> [    2.201888] Call trace:
> [    2.202261]  panel_edp_probe+0x3d4/0x520 [panel_edp]
> [    2.202636]  panel_edp_dp_aux_ep_probe+0x38/0x50 [panel_edp]
> [    2.203009]  dp_aux_ep_probe+0x34/0xf4 [drm_dp_aux_bus]
> [    2.203379]  really_probe+0xc0/0x3dc
> [    2.203739]  __driver_probe_device+0x7c/0x190
> [    2.204096]  driver_probe_device+0x3c/0x110
> [    2.204448]  __device_attach_driver+0xbc/0x160
> [    2.204795]  bus_for_each_drv+0x7c/0xd4
> [    2.205136]  __device_attach+0x9c/0x1c0
> [    2.205439]  device_initial_probe+0x14/0x20
> [    2.205717]  bus_probe_device+0x9c/0xa4
> [    2.205995]  device_add+0x3c4/0x8cc
> [    2.206270]  device_register+0x20/0x30
> [    2.206543]  of_dp_aux_populate_bus+0xe0/0x1bc [drm_dp_aux_bus]
> [    2.206817]  msm_dp_modeset_init+0x1d8/0x274 [msm]
> [    2.207096]  _dpu_kms_drm_obj_init+0x128/0x670 [msm]
> [    2.207370]  dpu_kms_hw_init+0x540/0x640 [msm]
> [    2.207645]  msm_drm_bind+0x18c/0x61c [msm]
> [    2.207917]  try_to_bring_up_aggregate_device+0x1dc/0x2d0
> [    2.208186]  __component_add+0xa4/0x190
> [    2.208454]  component_add+0x14/0x20
> [    2.208720]  dp_display_probe+0x29c/0x454 [msm]
> [    2.208989]  platform_probe+0x68/0xc0
> [    2.209252]  really_probe+0xc0/0x3dc
> [    2.209511]  __driver_probe_device+0x7c/0x190
> [    2.209767]  driver_probe_device+0x3c/0x110
> [    2.210022]  __device_attach_driver+0xbc/0x160
> [    2.210275]  bus_for_each_drv+0x7c/0xd4
> [    2.210528]  __device_attach+0x9c/0x1c0
> [    2.210781]  device_initial_probe+0x14/0x20
> [    2.211032]  bus_probe_device+0x9c/0xa4
> [    2.211280]  deferred_probe_work_func+0x9c/0xf0
> [    2.211525]  process_one_work+0x1c4/0x320
> [    2.211768]  worker_thread+0x6c/0x430
> [    2.212012]  kthread+0x108/0x10c
> [    2.212251]  ret_from_fork+0x10/0x20
> [    2.212488] ---[ end trace 0000000000000000 ]---
> [    2.212755] panel-simple-dp-aux aux-aea0000.displayport-controller: Unknown panel IVO 0x854a, using conservative timings
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

e22391454e3e drm/panel-edp: add IVO M133NW4J panel entry
