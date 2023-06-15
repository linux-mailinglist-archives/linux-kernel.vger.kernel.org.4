Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F107316A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjFOLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbjFOLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:31:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A672710
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:31:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b44200367bso11852921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686828698; x=1689420698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T8GgYIqVudWlnsC3oPDKoAyLE+QLU/Vc0UJQqOQEms=;
        b=asxgBI7ZjmLrmbZmvFQpyF/5eFUTJQWWW7xKqJqFCtjlsV0LV7ZxW7CJ9oqI4vd0oj
         4LPzImZ6wWupg9kgiUwvnSiwoBPIXTKiBAlXZx9T+p+A6Gt2dI9hArmwyNxiZeqpRw22
         QHWN7auMbRPeq3+WXysgOGpLScuvTkMZeJ05E1bEix8FIVKMgOTvVGSEfk0g4JiqnBIN
         RpL64eej6Q3bHM9J85d774/erJNuo6JMCRRf4v6ei65hYaWmxP5QRZfCZVDQ0m8LFEIT
         gVA5mQIlskllXR1VRwp2V/3xjTd6wlPCgqTxGKf/7pgiFUwE+bn39vHttwfqr7toC9wb
         Adsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828698; x=1689420698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T8GgYIqVudWlnsC3oPDKoAyLE+QLU/Vc0UJQqOQEms=;
        b=VTvctptyscyuIf43UR9UKjrF3mVRJKW4Iw21nx9SUiGiqvaKozfVidaH79q6Ueb8SE
         lqc3OkRn9tZ4YatRyUmnbrxFoC9WOIdVjhHco/VZBNaFQviKHjAdNaDcwEtejDqB/lS8
         6iqaudRE08Ch3wUV4XUQ3qNJ9XKJ/F32E0k6DylQzcxqKvQC4A+Gxu/C5te/C/hnhYan
         czjl3dPve/FWv59028p9QmxYgFCrRFKeI0RhOk+1ZUtG+2Jcshl4ODynRqYtk6EsFUgT
         4y7/ydUTzFBiYD19EFHw2u7TIAUGtcyO+b5jQpJ88HP8ECyDFx0FTJMS+MdogFFmAjqV
         yZZw==
X-Gm-Message-State: AC+VfDwThHt/Ypevz93/W7KCJNJ7xl4Onhz6L6jgLY++oRXVHi3hXGZd
        ZqD46UKqVzDK9V9v255dC4KQPg==
X-Google-Smtp-Source: ACHHUZ7anJq5+jo+HNiZTaLF+2RxcGBAkP3TUmnIjwSU0KcnYb1vyWAXaCDG02wduM41vfWbpKYzEQ==
X-Received: by 2002:a2e:3c0a:0:b0:2b1:fcb2:3029 with SMTP id j10-20020a2e3c0a000000b002b1fcb23029mr8451714lja.28.1686828698241;
        Thu, 15 Jun 2023 04:31:38 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y12-20020a2e320c000000b002b345f71039sm860525ljy.36.2023.06.15.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:31:37 -0700 (PDT)
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
Subject: Re: [PATCH v14 00/10] add DSC 1.2 dpu supports
Date:   Thu, 15 Jun 2023 14:31:27 +0300
Message-Id: <168682860387.384026.8615794645993103495.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1685036458-22683-1-git-send-email-quic_khsieh@quicinc.com>
References: <1685036458-22683-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 May 2023 10:40:48 -0700, Kuogee Hsieh wrote:
> This series adds the DPU side changes to support DSC 1.2 encoder. This
> was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
> The DSI and DP parts will be pushed later on top of this change.
> This seriel is rebase on [1], [2] and catalog fixes from rev-4 of [3].
> 
> [1]: https://patchwork.freedesktop.org/series/116851/
> [2]: https://patchwork.freedesktop.org/series/116615/
> [3]: https://patchwork.freedesktop.org/series/112332/
> 
> [...]

Applied, thanks!

[06/10] drm/msm/dpu: add support for DSC encoder v1.2 engine
        https://gitlab.freedesktop.org/lumag/msm/-/commit/8c4094b275f6
[09/10] drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
        https://gitlab.freedesktop.org/lumag/msm/-/commit/0d1b10c63346

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
