Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148BE643650
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiLEVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiLEVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:03:36 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206602B26D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:02:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l8so14956033ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHs+FqdUXZ8dY/1UdxeesnQgdtIGHLBMYAul3CErIMw=;
        b=oo/3QD3RnOsB//i0LeWi6f6xfNMxY4CIVu6ymNCgcGX2szuQj5mK3IKlg43DG4CGAG
         +m1cE1p1YACPkg553lAIpp2JKY6g0ovpeGNg2jVVWd8/48ab1FbctWf2ZfjxtJgLgP2r
         ebGYj1hy/Uz12mNeHAUnwPzyctKuwkFFobCvL6mW3oMDzf/DUW9Vptlm8f0CTsguxFlT
         9S0b0tieMW04bK25zhYN5vj6k5eeWvb/pWD+BhakFa5w887cHFOL+/8qh46VneOG3sU0
         0KrETIj/yJ+fVav/i5C43uaP8sM8sHhfiSNwNydhpHdwM1O3Nh/8nv+lDsxHhiVHZW2z
         PNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHs+FqdUXZ8dY/1UdxeesnQgdtIGHLBMYAul3CErIMw=;
        b=SLLljRptDrczpME6t7XAsMf6+ut3/9ACgnHtxs6yLSn0x7HFylUu2d0pkeI1D9DcN5
         HJ+GV/KbJe0iWtLvqAEjC0JnjH3zMwuSNJ5jODW7Xndg/qMXeV2nJErfxAmoWHUCuuW7
         e1NdLDn9r+pA0kMw6tT8HUVK1RLVHK9KQacQIQ7GcjigEK5D2tUBcz9IF3saXAcfx+5t
         IoASoNMG+rtg23WFYg6mEbg7+IlSs8mBGvIYXVqBiAXYu6x1IEV3ufzmpea+9M8HuEr0
         y0K/zHT+0pPEXrYZWANcIESoVlTxTAlM0HuoH6tl10t64RHTSE3zaB09HC0j5BHwf8wf
         5+/Q==
X-Gm-Message-State: ANoB5pk6BWcRbTNmzHxNuuYDFzhxkFHftYDha1hSOBYxkfSPIeqzI5AN
        fXL/GQCIsEbnMwu5FWNG7vJO9g==
X-Google-Smtp-Source: AA0mqf7b8AihvPHnHW9Fpk0XOGRCY4PnhRVvSAU8ZHOm+17Io0XAUyzYe1yURuzbjdyF40G3jN+d1w==
X-Received: by 2002:a2e:2d01:0:b0:278:ebb5:ddd2 with SMTP id t1-20020a2e2d01000000b00278ebb5ddd2mr25350274ljt.494.1670274125389;
        Mon, 05 Dec 2022 13:02:05 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id z15-20020a0565120c0f00b004b56de48f05sm733929lfu.27.2022.12.05.13.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:02:04 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:02:00 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/13] drm/msm/dp: Implement hpd_notify()
User-Agent: K-9 Mail for Android
In-Reply-To: <20221205174433.16847-9-quic_bjorande@quicinc.com>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com> <20221205174433.16847-9-quic_bjorande@quicinc.com>
Message-ID: <0C21338C-EC82-4A57-949F-6EE8044BBFFD@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 December 2022 20:44:28 GMT+03:00, Bjorn Andersson <quic_bjorande@quic=
inc=2Ecom> wrote:
>From: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>
>The DisplayPort controller's hot-plug mechanism is based on pinmuxing a
>physical signal on a GPIO pin into the controller=2E This is not always
>possible, either because there aren't dedicated GPIOs available or
>because the hot-plug signal is a virtual notification, in cases such as
>USB Type-C=2E
>
>For these cases, by implementing the hpd_notify() callback for the
>DisplayPort controller's drm_bridge, a downstream drm_bridge
>(next_bridge) can be used to track and signal the connection status
>changes=2E
>
>This makes it possible to use downstream drm_bridges such as
>display-connector or any virtual mechanism, as long as they are
>implemented as a drm_bridge=2E
>
>Signed-off-by: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>[bjorn: Drop connector->fwnode assignment and dev from struct msm_dp]
>Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>---
>
>Changes since v3:
>- None
>
> drivers/gpu/drm/msm/dp/dp_display=2Ec | 22 ++++++++++++++++++++++
> drivers/gpu/drm/msm/dp/dp_drm=2Ec     |  1 +
> drivers/gpu/drm/msm/dp/dp_drm=2Eh     |  2 ++
> 3 files changed, 25 insertions(+)
>
>diff --git a/drivers/gpu/drm/msm/dp/dp_display=2Ec b/drivers/gpu/drm/msm/=
dp/dp_display=2Ec
>index 666b45c8ab80=2E=2E17fcf8cd84cd 100644
>--- a/drivers/gpu/drm/msm/dp/dp_display=2Ec
>+++ b/drivers/gpu/drm/msm/dp/dp_display=2Ec
>@@ -1772,3 +1772,25 @@ void dp_bridge_mode_set(struct drm_bridge *drm_bri=
dge,
> 	dp_display->dp_mode=2Eh_active_low =3D
> 		!!(dp_display->dp_mode=2Edrm_mode=2Eflags & DRM_MODE_FLAG_NHSYNC);
> }
>+
>+void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>+			  enum drm_connector_status status)
>+{
>+	struct msm_dp_bridge *dp_bridge =3D to_dp_bridge(bridge);
>+	struct msm_dp *dp_display =3D dp_bridge->dp_display;
>+	struct dp_display_private *dp =3D container_of(dp_display, struct dp_di=
splay_private, dp_display);
>+
>+	/* Without next_bridge interrupts are handled by the DP core directly *=
/
>+	if (!dp_display->next_bridge)
>+		return;

Can we use hpd_notify in all the cases by dropping the corresponding piece=
 of code from the core driver?=20


>+
>+	if (!dp->core_initialized) {
>+		drm_dbg_dp(dp->drm_dev, "not initialized\n");
>+		return;
>+	}
>+
>+	if (!dp_display->is_connected && status =3D=3D connector_status_connect=
ed)
>+		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>+	else if (dp_display->is_connected && status =3D=3D connector_status_dis=
connected)
>+		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>+}
>diff --git a/drivers/gpu/drm/msm/dp/dp_drm=2Ec b/drivers/gpu/drm/msm/dp/d=
p_drm=2Ec
>index 6db82f9b03af=2E=2E3898366ebd5e 100644
>--- a/drivers/gpu/drm/msm/dp/dp_drm=2Ec
>+++ b/drivers/gpu/drm/msm/dp/dp_drm=2Ec
>@@ -102,6 +102,7 @@ static const struct drm_bridge_funcs dp_bridge_ops =
=3D {
> 	=2Eget_modes    =3D dp_bridge_get_modes,
> 	=2Edetect       =3D dp_bridge_detect,
> 	=2Eatomic_check =3D dp_bridge_atomic_check,
>+	=2Ehpd_notify   =3D dp_bridge_hpd_notify,
> };
>=20
> struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_=
device *dev,
>diff --git a/drivers/gpu/drm/msm/dp/dp_drm=2Eh b/drivers/gpu/drm/msm/dp/d=
p_drm=2Eh
>index 82035dbb0578=2E=2E79e6b2cf2d25 100644
>--- a/drivers/gpu/drm/msm/dp/dp_drm=2Eh
>+++ b/drivers/gpu/drm/msm/dp/dp_drm=2Eh
>@@ -32,5 +32,7 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_br=
idge *bridge,
> void dp_bridge_mode_set(struct drm_bridge *drm_bridge,
> 			const struct drm_display_mode *mode,
> 			const struct drm_display_mode *adjusted_mode);
>+void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>+			  enum drm_connector_status status);
>=20
> #endif /* _DP_DRM_H_ */

--=20
With best wishes
Dmitry
