Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04896710CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjARCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjARCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:43 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55B4521C5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so79873606ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLPgSw0irM5YzAF5nZ346rzglXvudc7WJVvK+w5PcIU=;
        b=wWQtCktXZaI6BanHhfkK0swKa4aLr3ijictfcdpe7XnxB7LMUp9tt+Givr4t5doTNZ
         1RcMJZ0GihusQQDF+YsYJo/r/m7p5BLn+ZVokpirswxYYLgGmqeDgMJ1mSmSCLbnqoh5
         l/fvQdzYHNV8pYDyprky76jUOHs20Om2Qvi2qXalD6ruNVVzuImfWHjKTUPJNYyI7f+D
         GabJ7wTVugFzH/BMElRbvILAWYHtK3B6tTl9KsEkZkpt0mG5L9/+yNA42kBt1ywmLzlh
         zGWuVl4UtaI0qzgtC6GXMj9yCTLFRGr8/kgt3wziSu4eIGnqsShwuP3TPMdKYkdY3Bxl
         LhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLPgSw0irM5YzAF5nZ346rzglXvudc7WJVvK+w5PcIU=;
        b=pcaZZsxrdG31Ge+xzNLstaB8aMq1F/nO7d7nVg+ZGdpsqmqHDWVU8NVqeFbN1vGjsq
         K5MV/qqcxpkCJyZAdM09zYxVKVooJpQi6V3S862NP5IpO7gg0wfl3mgW7SfaoObG5YEp
         8jHscGODydFP9sWBM3ah/XsBOpFl/5D6VMqdYCz+47uuMU5nJiECzX6AYo2ITsWFHaLB
         Ff7NN5E1dZio+Rm+yf2AWXXwW6X8GAJ7WIUPaEklF1fjwuxEH5yfMbASO3DtmjfCuDUl
         /2JuRzY8HzyYN9FQ3+KGCLonVZ+QKP0BCksQj4FMRkujstAmHkWSZimQdxet6k6trZT1
         a+5g==
X-Gm-Message-State: AFqh2kq0ma5xLe/EGO7og0T6D7Jz29j56v9OLEBf1gSr+9X2/4p5wq/U
        I7V9johuyNtcbAn/fX0HwIrTVw==
X-Google-Smtp-Source: AMrXdXvVpUEZsx3KcELZ64o0nenozD8z4wMbxcHvAeSa0WZDEiedT8sOTPcjC+HYhUBReAflau+nog==
X-Received: by 2002:a17:906:f1d6:b0:86e:7896:80d4 with SMTP id gx22-20020a170906f1d600b0086e789680d4mr5137016ejb.49.1674007601304;
        Tue, 17 Jan 2023 18:06:41 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:40 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Remove INIT_SETUP delay
Date:   Wed, 18 Jan 2023 04:06:21 +0200
Message-Id: <167400670531.1683873.4513062713172900376.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117172951.2748456-1-quic_bjorande@quicinc.com>
References: <20230117172951.2748456-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jan 2023 09:29:51 -0800, Bjorn Andersson wrote:
> During initalization of the DisplayPort controller an EV_HPD_INIT_SETUP
> event is generated, but with a delay of 100 units. This delay existed to
> circumvent bug in the QMP combo PHY driver, where if the DP part was
> powered up before USB, the common properties would not be properly
> initialized - and USB wouldn't work.
> 
> This issue was resolved in the recent refactoring of the QMP driver,
> so it's now possible to remove this delay.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dp: Remove INIT_SETUP delay
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e17af1c9d861

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
