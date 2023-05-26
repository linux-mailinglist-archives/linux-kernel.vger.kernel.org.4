Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB027120CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbjEZHWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbjEZHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:22:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDDE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:22:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3063433fa66so195879f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685085734; x=1687677734;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quLuDrImAY4dEXMU5Crf4TapiE3eFiJnHWi9mJIE9Zc=;
        b=u7LIE4uCUGqqsAaj7BYUZivMeOFoTG9VAIYRkFSGFI8fqidD4WwZNBbs8stj+XgFIH
         +Equ+MNb4C1+popYKd2y73amoQq8ocKI+4z7e3aTtJabw5JvkBGJ3+znwLw8I/ecTvoS
         J1bF2+OEGXSea0uA9CkGLaYsKYphMtpkj4Upj6OJSEf2ag5UtTHXyIaPsC4vs0HJAf/f
         4iDfmH0Swe1SVm3xfpa6Jhcg3VO0Bf4loFHdjPatH+ZWPWugMPM6j1x5tC7JhKnB0TSm
         pXgY68/NjwpVl7XfR/9FlMJXy47gcNJrBs38dE2SKcBS1I+DY4snTQkvOwO50cqIX+/I
         QwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085734; x=1687677734;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quLuDrImAY4dEXMU5Crf4TapiE3eFiJnHWi9mJIE9Zc=;
        b=mFgRci3PMNnbzt+a9ibtaTaGX+q383bfAkzvPK3minZ0DJAxK0EuCzyY2ZVpb83jiG
         yjVQl78w+XXI16pmVtsM/WjDBV+bdCzv0D473XQU0wNs2/8zAwOfiLitRoWXnzy6UcMt
         JxOnlgQ0gWrOL6UiwybSHUZ93fAYtUWf4fuuwnpzVjFprPG5crhWavjg0sPTwJy2LEEO
         otL+csQLhNY6jWzZS+JEk+XSrQiMtWlEJHCajuUzbmVoL8JGxDgpeYhVAgpbvNtEL4T5
         oiQ3uKMzYdO7qidtZlZamYC4Ts5CakXh8KmYGxetIv/ygb8l6xhYvO92LW0/FgsEAyCd
         ogoQ==
X-Gm-Message-State: AC+VfDzUWznRObxfpk+QPUVeLm2xNcs0zfX73n44ALLy7YaVzXs0UOR7
        V3+/xqTuZ252kpwCRLUe3X/K8Td9mxNKY0qz9RMlaA==
X-Google-Smtp-Source: ACHHUZ43Tr6ndY2wriomk6kcW8y+kKoegz3Q5DAUm3qWY6LzjvyaHCQbP0D0ugRAxLQWqwCOrRwvhA==
X-Received: by 2002:a5d:45cf:0:b0:306:2656:66d4 with SMTP id b15-20020a5d45cf000000b00306265666d4mr593949wrs.58.1685085734423;
        Fri, 26 May 2023 00:22:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r6-20020adff706000000b0030903371ef9sm4115935wrp.22.2023.05.26.00.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:22:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230526030559.326566-1-aford173@gmail.com>
References: <20230526030559.326566-1-aford173@gmail.com>
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable
 clocking
Message-Id: <168508573345.1449766.11809947722851001124.b4-ty@linaro.org>
Date:   Fri, 26 May 2023 09:22:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 May 2023 22:05:52 -0500, Adam Ford wrote:
> This series fixes the blanking pack size and the PMS calculation.  It then
> adds support to allows the DSIM to dynamically DPHY clocks, and support
> non-burst mode while allowing the removal of the hard-coded clock values
> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> burst-clock device tree entry when burst-mode isn't supported by connected
> devices like an HDMI brige.  In that event, the HS clock is set to the
> value requested by the bridge chip.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/7] drm: bridge: samsung-dsim: fix blanking packet size calculation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a617b33f7e513f25becf843bc97f8f1658c16337
[2/7] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=54f1a83c72250b182fa7722b0c5f6eb5e769598d
[3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=33d8d14c83bf67aa0d262961a6fda9c40f3c1052
[4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=171b3b1e0f8b8c894f2388e1cf765a56f831ee5e
[5/7] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=89691775f5735fca9dc40e119edcbb52a25b9612
[6/7] drm: bridge: samsung-dsim: Support non-burst mode
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb0e13b9e223b218c9f242f8d340a332b4381042
[7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=cfaf76d349837f695c8aa6d7077847fec4231fe5

-- 
Neil

