Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A839663516
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjAIXRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjAIXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A12193D0;
        Mon,  9 Jan 2023 15:16:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j17so15536351lfr.3;
        Mon, 09 Jan 2023 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfEuuSwlBNCNhQ0V5aSlOKkpq1jL3HZF0gUtECm9ca4=;
        b=H89n6zgg9/ccQW83NIXtgWreRJ1gThUzpqTRM46UyotjgGl289ZtSeYWxfwcJDA1io
         2d2eBFAobUY0hgOv/1qLa2p0T0eDMoTT0p0odlKwnpozFdXS3DsZIyq1aAK9F66VnDn1
         lYnGuIiYLNprPIGCYmAKwEkL3GUtFMIRtzeOxEOewO9fxEn2I+ZDYxhhiXtqYJx7Kw+E
         I8iMnUaogrCKo1EmgN6md2a5m4oGq0MKl0RLMPajTXSbs2L+0mIVUglLO1YYaepiAztb
         rif1zqFMFG9YtTgMFr03o+OC6R8mkG7ZQUinGmpfnBx6eg8cgH5wD/wb98AzEOplZSHE
         KCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfEuuSwlBNCNhQ0V5aSlOKkpq1jL3HZF0gUtECm9ca4=;
        b=Yay6+QtWPo5Es0mGK0t96BDG98Mr5GB4h3yeIjfChQqCwLR1EjH0u2Klr/3mh6y7Tp
         oogNeij8BBmsMPvJUwKeAOPhvwfPjNDOvxfoS3UvFhH4oZygQmllgRWCnnputtj2KJmy
         EDznLPNCbhTsfe7M2rIXVCbeRrdEbgTsmX+xHEWJcTiDJndCLDGN1E3zy8XqIEY1iezt
         eBGk63aTyS2IOHiw6SL0DNUeWKmbsT2uzSAv5Lv/KCM99vU+mV8NbFVUr6+YxvSxFzMf
         tDQI6HOZ9OzBghCOV6Dp+1y8TjL7lzafXXGyX3w5IRLJsLFyXkl909B0rN2kvTELRL6x
         U0Zw==
X-Gm-Message-State: AFqh2komaHFNDr/RzBw7/ML95SgJuvLGW2NQCQCCtuXBbwbJ+uRqDi9D
        wWAssnKsaDbk61pBsL8eaWU=
X-Google-Smtp-Source: AMrXdXvprIeLayo9AFJx7FpojNZLkyqDF96Vsu4eBGirYDKXTe9iE/pZTVa/I66i+H3OiKDocm+NhA==
X-Received: by 2002:a05:6512:10d6:b0:4b5:834b:9f75 with SMTP id k22-20020a05651210d600b004b5834b9f75mr20414337lfg.33.1673306185460;
        Mon, 09 Jan 2023 15:16:25 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512218900b004b57162edfasm1833530lft.117.2023.01.09.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:24 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
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
In-Reply-To: <20221207220012.16529-1-quic_bjorande@quicinc.com>
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
Subject: Re: [PATCH v5 00/12] drm/msm: Add SC8280XP support
Message-Id: <167330408782.609993.5872563380257036199.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:00:00 -0800, Bjorn Andersson wrote:
> This introduces support for the SC8280XP platform in the MDSS, DPU and
> DP driver. It reworks the HDP handling in the DP driver to support
> external HPD sources - such as the dp-connector, or USB Type-C altmode.
> 
> It then introduces the display clock controllers, mdss, dpu and
> displayport controllers and link everything together, for both the MDSS
> instances on the platform, and lastly enables EDP on the compute
> reference device and 6 of the MiniDP outputs on the automotive
> development platform.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display/msm: Add binding for SC8280XP MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/9ae2a57bdf9a
[02/12] drm/msm/dpu: Introduce SC8280XP
        https://gitlab.freedesktop.org/lumag/msm/-/commit/f0a1bdf64dd7
[03/12] drm/msm: Introduce SC8280XP MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/39bcdb416fb6
[04/12] dt-bindings: msm/dp: Add SDM845 and SC8280XP compatibles
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b6f8c4debc00
[05/12] drm/msm/dp: Stop using DP id as index in desc
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5d417b401146
[06/12] drm/msm/dp: Add DP and EDP compatibles for SC8280XP
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5bd69fd16198
[07/12] drm/msm/dp: Add SDM845 DisplayPort instance
        https://gitlab.freedesktop.org/lumag/msm/-/commit/fa33f2aa9674
[08/12] drm/msm/dp: Rely on hpd_enable/disable callbacks
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cd198caddea7
[09/12] drm/msm/dp: Implement hpd_notify()
        https://gitlab.freedesktop.org/lumag/msm/-/commit/542b37efc20e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
