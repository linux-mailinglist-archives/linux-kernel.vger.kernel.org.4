Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18E6CCD89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC1Wij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC1WiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:38:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793872D7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o20so11257904ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680043092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2giLkDrmf+/kS5P0IwHTfvbcUznWvWbpf5OjTRcuNpk=;
        b=a29iHMs3Hnbhc3OZ1JQZ+nRgd5NjHoBwJRWvVpY1DiAF3FeY4VWiTBsgqlR8u89HHq
         HsM6jLxvXIKiFiTq+tdJnbRNwlMOm0TFLsqsWRYbbGOLRfZU/lrh9dXLC/mmtTCzR/vy
         arzHUUDiyJcwSc0ta9gGOvzY+cmTyPwev50+t+DQR8y3n64veGb8kafgnphj3zu3wGwW
         bQhh2midZaE9FeYHQel0dBWaZU6QSmZwnD2O0kgxYurO8lrYuua7vbpv2BfEube5IFlN
         OTK+xB+Z/4ZZtCCysoB04Egz2zz9SFZABNADu8pvwweUjCDJ8lFk00GmkPsWm9shrNio
         dmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2giLkDrmf+/kS5P0IwHTfvbcUznWvWbpf5OjTRcuNpk=;
        b=GpcNcxXIAQdY9eBGhK/9I6FEvjem3mwBOKJQu0gX4PmmXYcYPZOu5HWWz7sdclZKBs
         jW1J4CsjzhK53YtIv10wmq+hE2JP4N8Gvb67xWj21nTUqwuglu5xjxCprLw1GAjmJEFn
         2nhnK3VvjzcKO/eWUiay82CDlVJwEq9qtFt7nd47F2u7sBpdWm8+ELrbN+ZkaEigE7Xo
         pH89fS/+lFyyFcpn4QdZACRDFpE5qbnXx0n6En3TikhZvacxjQi5U9NWDPvW0CjLCU32
         RalCCZyFldauxT8woR527G5rf5p4yeJvt6nZZq7RwJngdh5Dvv/ky1MDwUAJ5QXd0dh1
         4Ctg==
X-Gm-Message-State: AAQBX9c4BtvJeyhGPdx6xVqRUyslZI82qoIXVO45daSun2GEDOxva8We
        pCFIorEMonFAbZ5N4Y0ci1umNg==
X-Google-Smtp-Source: AKy350ZuT+dg/CToqXJq0PLw9mvrnrKKusC4KJ2+fUBG12SiPygnK8UFv3lgFjNzEBx+vxp7CVFxGg==
X-Received: by 2002:a2e:3e18:0:b0:2a2:41cc:fb1 with SMTP id l24-20020a2e3e18000000b002a241cc0fb1mr74651lja.12.1680043091825;
        Tue, 28 Mar 2023 15:38:11 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002934d555783sm5199522lji.6.2023.03.28.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:38:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/5] arm64: dts: qcom: add DP Controller to SM8350 & SM8450 DTS
Date:   Wed, 29 Mar 2023 01:37:57 +0300
Message-Id: <168004255465.1060915.7804485364271836960.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
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


On Fri, 17 Mar 2023 16:06:31 +0100, Neil Armstrong wrote:
> Switch the QMP PHY to the newly documented USB3/DP Combo PHY
> bindings at [1] and add the DP controller nodes.
> 
> The DP output is shared with the USB3 SuperSpeed lanes and is
> usually connected to an USB-C port which Altmode is controlled
> by the PMIC Glink infrastructure in discution at [1] & [2].
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: display: msm: dp-controller: document SM8450 compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8554420f1912

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
