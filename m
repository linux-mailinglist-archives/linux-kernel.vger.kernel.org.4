Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F91725728
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbjFGIPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbjFGIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:15:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DF10EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:15:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso70544245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125718; x=1688717718;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgIJSCejdHbYC6I5SehTRhoGCRpBeLeg1t9A/6zhpJo=;
        b=CIa64ozSdrDVRVg1jUgCTAiz36xySfnySuAigODI+An3r6XQLwAc3N8g+VaXmEjiEg
         He1RlJVQUxoLOzw6647ujk2cBWuG5dLxGbvmEZLSDY/gUh0iyjzUzrkaqmUzjpAHIVto
         lNKKf85hRuxVY5yhehspifd10g2gJM3UEbPTZy8ervc6l0QMC7MVrs7qvS0wu/HlEg80
         1VnX3ZT8NUJESTVrBaVbM2EbqeHm1gyq8NkjCit3BV9MxDJJala3XneiAODy5RWorTMY
         SR8xwkEIMgMIl5LO04gTuqe42G4s/GQE4SzegI6ubCioeBvlyAmb1IvNom+TsBe8gpYj
         WQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125718; x=1688717718;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgIJSCejdHbYC6I5SehTRhoGCRpBeLeg1t9A/6zhpJo=;
        b=a7O5lXhMxhzqOCii1OvBWQYQbvYHUEhSQZDGV7N+53zHZM3C21E0+24xTtvbt+6Nvn
         dqXnHDbyHL09yf+bPalX6253l2u+m4OLj+zOmw8VnBRSkEZO8UH27ieXRotp66xVWsxf
         Cgi7NT7d0ALapCudcasi8SZk17t151+kfizxYXHfBh94FB4xpcfF4rRlZ/BeEISdL6EQ
         EVUCvSE1Vx1E+/MegYVF271Gzirqg6FOZK+thJ4TS/r1c9IKzrH4hnKyBuUv4vXifyhH
         avXVBkfGXTNtLPheL9H4+TP5DWJWhxx3UXEeDd/oCM9O+4Q649gD/nRzScPbbxlzLTqL
         iRuw==
X-Gm-Message-State: AC+VfDxZOO8I+AZhMv4+4PTLg2lZlAVAHEhx4Hh4yVeyNY1EF/qqrfwr
        R/jAGlhJLZjravkXOtmqIRDctQ==
X-Google-Smtp-Source: ACHHUZ5tk6FymA5P3QCBia2YNIyTmWdjetu2eTi8qhNYTXKqJxyKEcwTWpSXM+EeMCN65Vy6Ap03GQ==
X-Received: by 2002:a7b:c411:0:b0:3f7:3545:4630 with SMTP id k17-20020a7bc411000000b003f735454630mr5745200wmi.20.1686125718557;
        Wed, 07 Jun 2023 01:15:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f8-20020a1c6a08000000b003f72a7918e7sm1228212wmc.45.2023.06.07.01.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:15:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
Subject: Re: (subset) [RESEND PATCH v2 0/6] Add display support on the
 stm32f746-disco board
Message-Id: <168612571728.2521024.1084005865126960680.b4-ty@linaro.org>
Date:   Wed, 07 Jun 2023 10:15:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 07 Jun 2023 08:31:33 +0200, Dario Binacchi wrote:
> The series adds support for the display on the stm32f746-disco board,
> along with a generic patch that adds the "bpp" parameter to the stm-drm
> module. The intention is to allow users to size, within certain limits,
> the memory footprint required by the framebuffer.
> 
> Changes in v2:
> - Add 'Acked-by' tag of Conor Dooley.
> - Fix build warning reported by kernel test robot.
> - Add 'Reported-by' tag of kernel test robot.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
[5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

-- 
Neil

