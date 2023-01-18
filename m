Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53BA6710BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjARCGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjARCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AF4860D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mg12so7495368ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOhzWcuJTV5IFxzT83GfyYBuQFtDL43V4pgyOp1rbt8=;
        b=BZJK9KYCD5pDLNx+WgkyVn+9Aice3BiaQUQN1pTMQjOe0S/UgnMYDMsd6auuyRRE8S
         H+Oo++QA68kwSRtjanvLC1c8pSUYlq5R6nDKMIdLhvKk/tsnye6h8asfpRBQ80BiMLNB
         YsjKRFT9YPM8996chk28sJipFpOnIcbSvk6zQKaIFdxFWWeJu/BUh52E7tvk52LBvbL6
         +DodcHcfFrO6Pds1bm4BukCz+ONuBuzOflwOu0HskpfOPSXcM6wZTjI2q8R85LiX1XbN
         AhwoqmzPpILLsGRqMFqWJVGBC2acu4PLhtRgVHCcZC9klniZSagH7uK1RwlOJnTCYJAQ
         V0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOhzWcuJTV5IFxzT83GfyYBuQFtDL43V4pgyOp1rbt8=;
        b=BsfjcPAC+PWKExbFTdYSZtL7zu6ucM6wj15SIN4QXfztlnFp6jJIYOGDotc9R8rVfe
         3trqoRy0MjADxjkSb8y3S1U8tBiI//ZgJzIDRQq4FLmlvw2bU9V5ixZVqZLhMuTJitje
         Kp63Edh+A6N0uYCqLfe/w7CyE59W1jrLFCCzCIxa6cpcejCDsQk2JXbzUWWcHdTL8fOj
         1Z8H4B7DCAA/KzNGUzwhqD22BniIQxYVnk7Hy0TgZBVq3zjjxj202tHblflYf2047wDN
         D66KYfr4GZmpg9vb3fBTLE8NUGe2fJRCAeobpcu6sgkPRGRPYqhJM1d2LRdxeU7SuUXf
         q+lQ==
X-Gm-Message-State: AFqh2kpEhh6+EkcJFST3Lav+uyVsj2I9/xZlhlKMQz2eg5uDGq8CAjEl
        IB7bj2VSV6BkMFzn7suijeeLdA==
X-Google-Smtp-Source: AMrXdXth30o8N6JigOeU9QfoMuA2uNMELa4iXuVsuYWhFwvd5DrSr8U0u5P3kBlF3wcOxEFzST5SJw==
X-Received: by 2002:a17:907:d606:b0:86f:b541:cd02 with SMTP id wd6-20020a170907d60600b0086fb541cd02mr5993456ejc.28.1674007595443;
        Tue, 17 Jan 2023 18:06:35 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:35 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: Add SM6375 DSI PHY
Date:   Wed, 18 Jan 2023 04:06:16 +0200
Message-Id: <167400670533.1683873.6641648531354230560.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116114059.346327-1-konrad.dybcio@linaro.org>
References: <20230116114059.346327-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 12:40:58 +0100, Konrad Dybcio wrote:
> SM6375 has a single 7nm DSI PHY. Document it.
> 
> 

Applied, thanks!

[1/2] dt-bindings: display/msm: Add SM6375 DSI PHY
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f8e6d45c8152
[2/2] drm/msm/dsi: Add phy configuration for SM6375
      https://gitlab.freedesktop.org/lumag/msm/-/commit/88f46d2ccdf0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
