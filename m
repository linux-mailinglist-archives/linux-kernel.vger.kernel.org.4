Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C36CCD74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjC1Wi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC1WiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:38:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7761986
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o20so11257765ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680043088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=almqnIe5p6SPPcYPWjwjdUaws42iWdaybkLQMuaM2c4=;
        b=VNvj+Qt3Niw8C2Q2DzWedzPgUMVj4XaaPMHGKRYb33rIsm8yYIcESVqAoxf2QIFK09
         9w1BUy+nCK6RGxWxbN9c9zG+TShXJzNdQYj1Xjhy7KWnlqBBc9t7S1e8MeUx+H8p46zr
         8cGHes9OWTMlsNrVlTfwQyKCKLEn1k4C7nzWpWahTIJWrzZ4IyZzzD4LC0rixel4zZis
         A6hA1aFYygBaYGIKMc3oZ9iA+3QcFkolsE/G5KYZtTsRBFakZi8kq4EXNvZNXm6G1Iqd
         Cg0x34S43hqvGr7xhvI/gsnDXnBSYO4XsQ0uRJzitIxN8BJOGrmAHLiTh5twmCiJ9Zws
         mxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=almqnIe5p6SPPcYPWjwjdUaws42iWdaybkLQMuaM2c4=;
        b=NbUJZlmfTDAPhQLG0QwJBvcgUbIv8C0gf96lqw5IL+CMBcspThcYrH/877hlLy6Z9R
         c8XnBxSJkTtutPw1DViTLziWe4S411DXcppljfA2XyA+LMycxFQVwlFiuwvOZjOYU/fe
         M0hIfA6tKZR1IXtBcfD3j4ohmnb26JKPWoRGwBPAqh+jcFRpZAtxt3ACsd9HMt+vrEhe
         9NzfwjXkBOG/EMPV36xLMDGiEOyoPLJQ2hTOkdeznmesoipN+vLuD3vvPy5O5ONGq0NB
         a3OsgKOqi2HOfZTK/iKZmhs0tTCr/9E56SvDU0qutbeesaCOcgoEWxrKlKAoaMhc7P2q
         zpxg==
X-Gm-Message-State: AAQBX9f1/DS0cSuYIAalbizi6DjRPWF0QgoePPCS5UbSwIO7KNop/F4j
        fi1AO6kOIgLbbQpp6KZnCKoh6w==
X-Google-Smtp-Source: AKy350bJ5wG2PH5jR8pdssprervPgKgRwh9MztjWz+AdpebFRNw2/UCcujsqqC7VgiMDtHSxtqWQqA==
X-Received: by 2002:a2e:b0f3:0:b0:2a0:8d5b:95c with SMTP id h19-20020a2eb0f3000000b002a08d5b095cmr5700934ljl.34.1680043087967;
        Tue, 28 Mar 2023 15:38:07 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002934d555783sm5199522lji.6.2023.03.28.15.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:38:07 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v6 0/9] Fix DSI host idx detection on HW revision clash
Date:   Wed, 29 Mar 2023 01:37:52 +0300
Message-Id: <168004255466.1060915.2598614689172044596.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Mar 2023 14:42:46 +0100, Konrad Dybcio wrote:
> v5 -> v6:
> - Squash both fixes that concerned the deprecated QCM2290 compatible to
>   avoid warnings
> 
> v5: https://lore.kernel.org/r/20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org
> 
> v4 -> v5:
> - Drop superfluous items: level in [8/10]
> - Remove the header define for the qcm2290 config in [6/10] instead of
>   [7/10]
> - Pick up tags
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: display/msm: dsi-controller-main: Fix deprecated QCM2290 compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/236502012d47
[2/9] drm/msm/dsi: Get rid of msm_dsi_config::num_dsi
      https://gitlab.freedesktop.org/lumag/msm/-/commit/607ce0e9d462
[3/9] drm/msm/dsi: Fix DSI index detection when version clash occurs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2e6105fe7570
[4/9] drm/msm/dsi: dsi_cfg: Deduplicate identical structs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/41301c6d5e5d
[5/9] drm/msm/dsi: dsi_cfg: Merge SC7180 config into SDM845
      https://gitlab.freedesktop.org/lumag/msm/-/commit/38ba402f807d
[6/9] drm/msm/dsi: Switch the QCM2290-specific compatible to index autodetection
      https://gitlab.freedesktop.org/lumag/msm/-/commit/34f84fcf81c8
[7/9] drm/msm/dsi: Remove custom DSI config handling
      https://gitlab.freedesktop.org/lumag/msm/-/commit/ff280b6cc5ef
[8/9] dt-bindings: display/msm: dsi-controller-main: Add SM6115
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c7baf742a07b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
