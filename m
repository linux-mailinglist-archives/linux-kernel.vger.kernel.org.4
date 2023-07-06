Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692DE74A21F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjGFQWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGFQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:22:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA67DC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:22:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso1285701e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688660537; x=1691252537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMP9lJbEuPcrzMgcvC+7r18VxLSwEABRng+Vk+MPbX4=;
        b=cAxfuoX7BD0seqrSILs5Unpw5ygUM+8qHLuhLgRDdjtDpJmtuViazC+01Ld4eg/Tt7
         a0sRmC36DdJ9IR6ivB44mkLq1pwDNbr8KjhCRc8+dXuoqHt1XICmJkP4p5fDDec2eBvd
         AQgPqyn/67p8WQaZJw5E3BnMMz+ZUg5JxAOEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688660537; x=1691252537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMP9lJbEuPcrzMgcvC+7r18VxLSwEABRng+Vk+MPbX4=;
        b=GJOvEUhITrr0yPqr5ut2mM+foJTFtO87XN2K4tT9lHb/ffi0B08nipmfzMNcOxMr0u
         kjSjMDe0SrwN4McpHOyAVdP2f455oXt0wOdo5hVpx+khBzplJ8B33Yc887HbLuWYMop/
         DqBFYW33S/1qvBboe5rrP/pvJ9yJip4kcCsIzx4NfpAzeBSWba1UkeQRm2sSSdgiT9k9
         YIeXsG6VIMYpU88pqpP3EOwHkJ28yxwl6QEPgn0Y3JSq1//rKZEiT1JzWcjubZWenTQT
         XyfbI1fTng66SRGotJP4IXNmK6Vtea3fJpOFXcsbCOOxi1oYKurorQZAQHM2s59svUwz
         GdYA==
X-Gm-Message-State: ABy/qLavg5E7r+cNxM+evv8w1SBBIHG1f437UXERc3ZyefZFZnMD0f5Q
        Sxz2qA8f3mt4jPS6IhYadPj4SGTfT0UaTsms9qwvwg==
X-Google-Smtp-Source: APBJJlFBYBKAdp95JKMSGyNDbCA4qWmeQBnTJ7RuOcSI1Xfno0JaSxvGOZJTPO6RkYGH24jqt6MvCw==
X-Received: by 2002:a05:6512:3da6:b0:4f9:5933:8eea with SMTP id k38-20020a0565123da600b004f959338eeamr2303417lfv.3.1688660536681;
        Thu, 06 Jul 2023 09:22:16 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b00988be3c1d87sm1006492ejb.116.2023.07.06.09.22.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 09:22:16 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so150315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:22:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1ca6:b0:3f7:7bd4:3b9d with SMTP id
 k38-20020a05600c1ca600b003f77bd43b9dmr148605wms.6.1688660535582; Thu, 06 Jul
 2023 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <c27953274997a56f8e0522f9331e733ae92bf25b.camel@web.de>
In-Reply-To: <c27953274997a56f8e0522f9331e733ae92bf25b.camel@web.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 09:22:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_WMo4NGMQMYeLGUc_jBM3X4hZAOe-YQw6exBioEtadw@mail.gmail.com>
Message-ID: <CAD=FV=W_WMo4NGMQMYeLGUc_jBM3X4hZAOe-YQw6exBioEtadw@mail.gmail.com>
Subject: Re: drm_bridges on fairphone-fp3 are enabled in the wrong order
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 5, 2023 at 12:51=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> The fairphone-fp3 has a drm_panel attached to a dsi bridge. This are adde=
d to
> the bridge_chain in struct drm_encoder in the order dsi, panel. When the
> drm_atomic_bridge_chain_pre_enable these get enabled in the order panel, =
dsi
> because of the list_for_each_entry_reverse. But the drm_panel of the fair=
phone-
> fp3 is enabled using mipi_dsi_dcs_write_buffer which only works if the ds=
i is
> enabled before the panel.
>  To work around this one can revert
>
> commit 9e15123eca7942caa8a3e1f58ec0df7d088df149
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Tue Jan 31 14:18:25 2023 -0800
>
>     drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset
>
> This leads to a working panel on startup. But when suspending one runs ag=
ain
> into a similar problem. When the bridges are disabled the dsi is disabled=
 first
> which leads to a failure in disabling the panel again because
> mipi_dsi_dcs_write_buffer fails when the dsi is already switched of.
>  As a simple workarund for both problems I have found it works to exchang=
e the
> order of the bridge chain in drm_endcoder:
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 28b8012a21f2..990f7c68a27c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -550,6 +555,8 @@ int msm_dsi_manager_ext_bridge_init(u8 id)
>                 if (ret < 0)
>                         return ret;
>         }
> +       /* swap bridges in list */
> +       list_swap(&encoder->bridge_chain, encoder->bridge_chain.next);
>
>         /* The pipeline is ready, ping encoders if necessary */
>         msm_dsi_manager_set_split_display(id);
>
> But this does not look like a portable solution so I wonder if there is a=
 better
> way to do this.
>
> The linux kernel used here is a linux-next-20220630, with several out-of-=
tree
> patches which are needed for the msm8953 gpu and the display used in the
> fairphone-fp3 located here: https://github.com/spasswolf/msm8953-linux.gi=
t in
> branch msm8953_iommu_rebase_v2_wlan_modem_ipa_cpufreq_display_debug.

Any chance that "pre_enable_prev_first" works for you? For the best
summary I'm aware of this issue, see:

https://lore.kernel.org/r/CAD=3DFV=3DX_xonf1Dz0BsNTKm4-zBm+ccKvPO+wEWFVMUVY=
_2=3Dh3Q@mail.gmail.com

-Doug
