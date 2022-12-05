Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C5643697
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiLEVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLEVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:11:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EF11A0C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:11:57 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a19so15062337ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eq2ZXszLjKr//ikj+7g9JMKWJ4MAQFXRFYQxnRJH2ns=;
        b=uv+ysMBoXT9OnHKv2d2ki4+o8X18uddVwaH+9qoMgLHkXZr1y7R44ea/VhSpZQ7DYz
         1yALAGAZQ5JH369QRzwze66Sq7aIZl2dAMX1BdtW8wkXEZVMk3OyVDaX/80U3zZdTwVD
         jy3jMsLIKlkZZDqu3ZrYQYbspKuuZhB/FNPfjWlC1AHJ+OYWuHe6g/Mi3CXFMe1uHgih
         8h9zv522tJ2uFqhJ9XXrejJenWLGou3A5lbcQkzR5x8WpeuOuG4VXUrUCeGa59qU7M1E
         7QHiZl7dEhUPoJdwztGMxZbu62ot2vb86an7VugcCHooAtH2MDEufICxZbVOnKLEwgcG
         3x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eq2ZXszLjKr//ikj+7g9JMKWJ4MAQFXRFYQxnRJH2ns=;
        b=347e3jfbINpcWz7421QK0UVVCx8NSxjcK2/8A4G64aDeaHcnl9gppnQ4gF7McKzkq+
         g4pWB26kf1c5cZNnbEO4rF5GMMFKRAqeNazOOePchjTtb3TWSH8a3C9D9IdP8TgQXWDb
         OIy+2yKxa9sZdFEVoF6iZofvqphTyRgBXWUC2wH+IkmvW7PPWjWvy7FKJoPwsE7RqAYV
         Es0XkktnWPGQ/EuKp8EKJCRd3wZq/m3EKcq1plPoPhOsmFinENDgINIF0C4T9uiD2gfl
         cNz7sHeRimDATU+DB7yXhwXuNWAnVDkQWokMTY4b1dsPC/a7wZbLQdJ4gkvOYk+B6f6Z
         sOBA==
X-Gm-Message-State: ANoB5pl1fruucVswRAbeogMiUFKCPlfPwLXv8erBOG30oFD8YUD94sn7
        ysAHSim0sMc3s/xqmHNPssw9vA==
X-Google-Smtp-Source: AA0mqf40g4Eax0o9RTqpNOnSr4NFV/WsN+mtKCY5opKnXRZdgli634oXeQBgQNpNxXsndr+D+MAr3A==
X-Received: by 2002:a2e:bd87:0:b0:277:1cfe:398 with SMTP id o7-20020a2ebd87000000b002771cfe0398mr19179355ljq.10.1670274715882;
        Mon, 05 Dec 2022 13:11:55 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651c118900b00279d206a43bsm1241901ljo.34.2022.12.05.13.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:11:55 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:11:52 +0300
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
Subject: Re: [PATCH v4 09/13] drm/msm/dp: Don't enable HPD interrupts for edp
User-Agent: K-9 Mail for Android
In-Reply-To: <62FFEABE-0074-4836-84BE-2C88C83F8674@linaro.org>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com> <20221205174433.16847-10-quic_bjorande@quicinc.com> <62FFEABE-0074-4836-84BE-2C88C83F8674@linaro.org>
Message-ID: <72DDE54D-8368-4E2A-82D6-30265118D7D4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 December 2022 00:07:12 GMT+03:00, Dmitry Baryshkov <dmitry=2Ebaryshko=
v@linaro=2Eorg> wrote:
>
>
>On 5 December 2022 20:44:29 GMT+03:00, Bjorn Andersson <quic_bjorande@qui=
cinc=2Ecom> wrote:
>>From: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>>
>>Most instances where HPD interrupts are masked and unmasked are guareded
>>by the presence of an EDP panel being connected, but not all=2E Extend
>>this to cover the last few places, as HPD interrupt handling is not used
>>for the EDP case=2E
>
>I don't remember whether I asked that or not=2E Would it be possible to m=
ove hpd irq enablement to bridge's hpd_enable() / hpd_disable() callbacks ?=
 I think this would allow us to drop the is_edp checks=2E

Ignore this=2E I should read the series carefully=2E

>
>>
>>Signed-off-by: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>>Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>>Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>>---
>>
>>Changes since v3:
>>- None
>>
>> drivers/gpu/drm/msm/dp/dp_display=2Ec | 15 ++++++++++-----
>> 1 file changed, 10 insertions(+), 5 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/msm/dp/dp_display=2Ec b/drivers/gpu/drm/msm=
/dp/dp_display=2Ec
>>index 17fcf8cd84cd=2E=2Ebb92c33beff8 100644
>>--- a/drivers/gpu/drm/msm/dp/dp_display=2Ec
>>+++ b/drivers/gpu/drm/msm/dp/dp_display=2Ec
>>@@ -610,8 +610,10 @@ static int dp_hpd_plug_handle(struct dp_display_pri=
vate *dp, u32 data)
>> 	}
>>=20
>> 	/* enable HDP irq_hpd/replug interrupt */
>>-	dp_catalog_hpd_config_intr(dp->catalog,
>>-		DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK, true);
>>+	if (!dp->dp_display=2Eis_edp)
>>+		dp_catalog_hpd_config_intr(dp->catalog,
>>+					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
>>+					   true);
>>=20
>> 	drm_dbg_dp(dp->drm_dev, "After, type=3D%d hpd_state=3D%d\n",
>> 			dp->dp_display=2Econnector_type, state);
>>@@ -651,8 +653,10 @@ static int dp_hpd_unplug_handle(struct dp_display_p=
rivate *dp, u32 data)
>> 			dp->dp_display=2Econnector_type, state);
>>=20
>> 	/* disable irq_hpd/replug interrupts */
>>-	dp_catalog_hpd_config_intr(dp->catalog,
>>-		DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK, false);
>>+	if (!dp->dp_display=2Eis_edp)
>>+		dp_catalog_hpd_config_intr(dp->catalog,
>>+					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
>>+					   false);
>>=20
>> 	/* unplugged, no more irq_hpd handle */
>> 	dp_del_event(dp, EV_IRQ_HPD_INT);
>>@@ -678,7 +682,8 @@ static int dp_hpd_unplug_handle(struct dp_display_pr=
ivate *dp, u32 data)
>> 	}
>>=20
>> 	/* disable HPD plug interrupts */
>>-	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false=
);
>>+	if (!dp->dp_display=2Eis_edp)
>>+		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, fals=
e);
>>=20
>> 	/*
>> 	 * We don't need separate work for disconnect as
>

--=20
With best wishes
Dmitry
