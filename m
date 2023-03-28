Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F36CCD83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC1Wig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjC1WiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:38:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B172D4D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a11so14173620lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680043091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES7yv6OWA07UGsRQ2Qrre927PWBN2JgohrtNzcIojBE=;
        b=HPfsmfVOqyQrYeZFNtR9ISFrSIT1mgUBhydxEyEU+B7bRS4kGBNHDfg7e0wQcqQQt1
         YcS7H99Ul3KxFoOtWhs0zLyeNp1u5T1U1Ep/+TURz50rQ2dGAp1P1rs1dXIu+m5M6wiM
         //wwkUJQD5e2IiOJchjI/T9PIT2BbD1LZ+glOLJ7UIueU0liKPqpJevUjltWGP3JF/VB
         8hyGwRLsjathIop9r6mhBGD4p52HyOaPOUY9KSvDhrWmcekB8N8cTrAaxU5OaDz1Hi8J
         6C306PK0p/aAEJ+NVtAiYc3sWewWL5j8/M+UrteMTVorOCyjTylIw+xiDmo2rxinZuvn
         Ei2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES7yv6OWA07UGsRQ2Qrre927PWBN2JgohrtNzcIojBE=;
        b=F1+Hln/ijyskkj8CFWhDTvZPJx9MEcfxYWs11+vyMw4zPUGCgFMjTf5WO3MrvP5UWi
         vjXBe3ccROnhR8l7D3O8kXNvhd39qMOTsNk1qSrUvMduTc0G1SrPpxSLo02FQwWaEZHR
         I99eNDVeGKt5rTky5hkml7IiaS0Xq3tcJLHzxXkRxla4ZcQvf+NW/+MHILM7RTWRCzyC
         ctrVMSJr+wZJPimXJ7jVrQ9pdCr/ZZCT04qLU3m7JgZF7J5D4DHeFlfmvhUPmrIv8Ag8
         P5G5OItda4luploJYEzjUDdK+eWfLrTenp9wGlBrRAy7mSM10nweZJAjoS3jVyPoBsUd
         GkPg==
X-Gm-Message-State: AAQBX9cCosPXfS+K8Oiy+Ag6BTs9SaNpEFfxArU+WiTV7TatGEsP8YN6
        V5o6yfq/rLrqhENFpHSNBxIMZQ==
X-Google-Smtp-Source: AKy350bodgR/uNywBBZhoaq7ZTPqwnTdTPuEbN0vkQg40ku+hzIFmCQpIJtS/oUFmTzLhW0qTCzE/w==
X-Received: by 2002:a2e:930c:0:b0:29f:3e2e:fbd0 with SMTP id e12-20020a2e930c000000b0029f3e2efbd0mr43107ljh.15.1680043091058;
        Tue, 28 Mar 2023 15:38:11 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t22-20020a2e9d16000000b002934d555783sm5199522lji.6.2023.03.28.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:38:10 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/7] drm/msm: add support for SM8550
Date:   Wed, 29 Mar 2023 01:37:56 +0300
Message-Id: <168004255469.1060915.1800625604847213121.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
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


On Mon, 09 Jan 2023 11:15:17 +0100, Neil Armstrong wrote:
> This adds support for the MDSS/DPU/DSI on the Qualcomm SM8550 platform.
> 
> This patchset is based on the SM8450 display support serie at [1].
> 
> In order to work, the following patchsets are required:
> - PM8550 LDO fix at [2]
> - DISPCC driver at [3]
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: display/msm: document DPU on SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4557e40338d2
[3/7] dt-bindings: display/msm: document MDSS on SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0e4205eb8663

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
