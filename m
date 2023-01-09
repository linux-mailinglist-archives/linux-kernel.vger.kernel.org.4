Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC91663518
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbjAIXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbjAIXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E60B13F3C;
        Mon,  9 Jan 2023 15:16:25 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bt23so15494478lfb.5;
        Mon, 09 Jan 2023 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKRTpVUA1bI23v2sl/8AqQtigjh3NRGLCQQVjyhb50M=;
        b=ID5RD1P7egCKU0bXKs/7TL+oy2vbYrPqA0fq7RbCjpuJJqD6y2euMfTbN41bE9TTrd
         kcR+UfBHEAzY/iTEb8RbL7VCxXF9kTU5/Av8IhzbDu9kHOrnFDFclf7j0435UU1BtpN9
         8ak6JABZpw4OjpAgzCyH4cJn1HsbQL8jCWqrU9TSAb95BiP8h5EfoQhRoAGnY03WuEMh
         8y2yOHsvdcpcgGvRxTpx96IjxORm+b/mJAwaCYUmE7emfv2Ba7HeT6WUS8bDoMJcK2q+
         czJPJACiYDaVHkzsWQ/L+YV10/qcWMbL5nn4TfdqirIQut77ERzZG/aiVhVNsINW7xD/
         OmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKRTpVUA1bI23v2sl/8AqQtigjh3NRGLCQQVjyhb50M=;
        b=iz4SKM53nD+ALKV1m+/3TRdHaur0Z9U8dHNrQMiYqj9r1fje0gvkT4U3/AyOS56Emu
         RjCnhUPPXWbqBmytfHNUj5lsh3UrhS585DNNjjpMI1A0UhrHFg/ZpRV2x8Ba2HmsCMwD
         zpzy6wp7q4ClxCr1QNn93Jrb9JRNMt0Fn+f54En0bzU8cFFWfVn/Syxbom7tnNZRkvO9
         wR+pCL0TvurJThbxvMGpRHmyXBUWwopnTC+A9TyLFMUb4Snl4ZlW/nDJ5wDzYV/q6Jkb
         2TMa7ooyTtKJOSORYrZj7KlXEaRYwsBJP/0vrs4YlU6yrpwnCmRfvcFwKxvl1w4R4qny
         hc4w==
X-Gm-Message-State: AFqh2kouvY4Bj2DnzlU14nGjUEjDDxQIhIsc/62Jh2hLvNYYlejJOhbr
        p+S1VhqwwQOZuM1eQwA8wEg=
X-Google-Smtp-Source: AMrXdXuXusu5oFoA/8A3+GlBsZULT5rze2ntTHddBwCY5Dp49n+TXLshx1vPGl+8Qyei8sjiNOtWzQ==
X-Received: by 2002:a05:6512:2828:b0:4b9:f5e5:8fbc with SMTP id cf40-20020a056512282800b004b9f5e58fbcmr24474236lfb.30.1673306183433;
        Mon, 09 Jan 2023 15:16:23 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004aa0870b5e5sm1836900lfr.147.2023.01.09.15.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:22 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
Subject: Re: [PATCH v3 0/7] drm/msm: add support for SM8550
Message-Id: <167330408777.609993.13359003796525315964.b4-ty@linaro.org>
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

[1/7] dt-bindings: display/msm: document the SM8550 DSI PHY
      https://gitlab.freedesktop.org/lumag/msm/-/commit/71917f654bae
[2/7] dt-bindings: display/msm: document DPU on SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/602082368233
[3/7] dt-bindings: display/msm: document MDSS on SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9cb8eacfb528
[4/7] drm/msm/dpu: add support for SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c3cc4e88efb0
[5/7] drm/msm: mdss: add support for SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f96cca5ed719
[6/7] drm/msm/dsi: add support for DSI-PHY on SM8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0fd17f93661d
[7/7] drm/msm/dsi: add support for DSI 2.7.0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d797ca161b87

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
