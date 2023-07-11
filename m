Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250274F210
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjGKOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGKOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9222691
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b702319893so91953961fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085324; x=1691677324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgmqG4jujLqQxwJIJ5hn90DGaowksqxT71+ZFrlpWAo=;
        b=P+XhG1RoWkWCxoS/7h6wBFCjdnfi47tfCVIzhcVEL+s2Wkg2e39YOL6s9PfhplMbYP
         EG82NB933L18GZCmT73/u+8O+rJknSLCjJ2UHD0ZIMnYgY0yRzt+WpS5goY1vHMsEJCX
         LiWipyvBpnEvRm1HeV1gmN9CO/SHEF5uysxR4qUPpU7PytyEXjXopbml5+KNoW4CjOVG
         gd7DgbJ26HEtyi4tIIwZlgbMnmcVL/zWoOLshUgBjHzXj0Yg4BuXVyQyroAL28+5xzWI
         HI0BGpV0HSKRJkFvZg1byOqwvimpaCNTYp/3G3HjsdR8m1HkBwIn5DLwxzB7SVOM0rn0
         M3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085324; x=1691677324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgmqG4jujLqQxwJIJ5hn90DGaowksqxT71+ZFrlpWAo=;
        b=jOXNgJvE2IG7iqrW6DVeSwhzQDByT6X5PWVMtddXrsaRVokU/5wNNtrN9aV9mv/Bxq
         rLAFpyRqRoDODm9Cv75RgupW1lgWrUO7Rk8KGcN+V77R3MvLwoOPGVnupmT9gII85BF/
         aaBlFHE2wDtykoR9xOgrHzkaMo6kDxjERbgbghb9unlZRMcU34JxLI/mzBhs6kiVMm/v
         cqV1Q+MB1Ih2SN6DS0Pq9tuJMMdzvlV5LOy2QhTD1GyFTZp4dXoL6AxR9C0ScX0CBm9y
         Y57N81j0KmiLnEnofy0HKIxy5rMDDvQ3fD0GURXHlhfrBq0UfHpurpealft4gunL/57F
         uFvQ==
X-Gm-Message-State: ABy/qLYVi/kD2vPeoph1WCwHLM8a/hN93ydAxsFtcBtMTkOrirHmtRwC
        KIWPVFGxAC3gN1DIr4lmtQN/ug==
X-Google-Smtp-Source: APBJJlHpfuT3UxsY6ALFZB4Z/BEceDANtxuKi9GxtHxD67I2xBdVnCt8nJfM6i+UTVnNQAOf+0OKOA==
X-Received: by 2002:a2e:a0c8:0:b0:2b7:764:3caf with SMTP id f8-20020a2ea0c8000000b002b707643cafmr12539420ljm.10.1689085323898;
        Tue, 11 Jul 2023 07:22:03 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] retrieve DSI DSC through priv-dsi[0]
Date:   Tue, 11 Jul 2023 17:21:53 +0300
Message-Id: <168908465045.1869384.116123598004032569.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1687454686-10340-1-git-send-email-quic_khsieh@quicinc.com>
References: <1687454686-10340-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2023 10:24:44 -0700, Kuogee Hsieh wrote:
> moving retrieving struct drm_dsc_cofnig from setup_display to
> atomic_enable() and delete struct drm_dsc_config from
> struct msm_display_info.
> 
> Kuogee Hsieh (2):
>   drm/msm/dpu: retrieve DSI DSC struct through priv->dsi[0]
>   drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info
> 
> [...]

Applied, thanks!

[1/2] drm/msm/dpu: retrieve DSI DSC struct through priv->dsi[0]
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5430ec2d2992
[2/2] drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info
      https://gitlab.freedesktop.org/lumag/msm/-/commit/86841ba67bf0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
