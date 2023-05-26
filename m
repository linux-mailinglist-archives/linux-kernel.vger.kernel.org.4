Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9938712259
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbjEZIhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjEZIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:36:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081A194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:36:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so5387935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685090215; x=1687682215;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh7efR5v8e0vkSD7MWnUSokvejiF72nQWy6QT+M4OEk=;
        b=q6/joui9LGDiR+/gTQhuf4Wv4GUwBNdNe5SV8a9OxQaMFBNrECsD+/xfgc3n+tuA0X
         bJ3TC+gQoiK0e9lqfAlIiCVXocq7DF9xg6/AKzCBkpAhJ3KBjXgyT4VeBEt2j+sN3urw
         imVBx+66mwbmOM5enOj43i+K/8FPYaUK88WUtsr8ABViExtIgmBL61CSdLcWRXPSs0NE
         agkDMcvSFoGMfd9HVKlxR/TEpAY7OvWTdRNskfJS38/sj0bQg5NSybtwowZjYwY6m6Jr
         QNRhYXXqSI6Zo66zjwT+pzQP0Vs0NU0mHc0R0xucNnCsJTYgQC71WHwNRyWOdsPc+Paz
         ehfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685090215; x=1687682215;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh7efR5v8e0vkSD7MWnUSokvejiF72nQWy6QT+M4OEk=;
        b=aFnJ55ez9DOjmz6OwLCfGI42ioVu0+LLSJUd5OOKWKnMIZzd3vVHXISgz2eBHf5q1v
         ptjdTAOW300BGSDn9MOZbs8WixcPwr7sXWw7d4bC077KKWY7dCKVJrd51uejKitjhrsD
         Blhopm09kWGL3FWKvPyGXlHVY/TNN/sYskjw2q7uSZNmEv2xMwK4qZy9ZwpsGwSxwNE0
         bQ8EobgppS8JQ6duVnMbjC+iEkZgkoSUl746NxGxa+1wlyLsZeuIPeX5pziBPi8ryM+O
         XPgABEdxdPz4zRWYyCOphdqoFQEGPSKAOjW6L/YlRNmjD4cP9swnXW4QATBsZnitW5k7
         X26g==
X-Gm-Message-State: AC+VfDwJNsY45k/ZCq7zrX0DpZ/lpAGxPl6ndB0BaITjaDVKPnlSIvpR
        lPNPzzuHiw/k/Hhb1LWqF152BczvsfpdJ3gigSpyNA==
X-Google-Smtp-Source: ACHHUZ7DYQBiHBk+ExfjvmQiPj/1QqxrrFxOJu0T+gIHhioXAxvPRHTfhknpnn6dS5cYrmO4riAOHw==
X-Received: by 2002:a1c:ed0b:0:b0:3f0:9564:f4f6 with SMTP id l11-20020a1ced0b000000b003f09564f4f6mr821681wmh.1.1685090214836;
        Fri, 26 May 2023 01:36:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d45c5000000b002fda1b12a0bsm4379284wrs.2.2023.05.26.01.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:36:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Inki Dae <inki.dae@samsung.com>,
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
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230526-revert-bad-binding-v1-1-67329ad1bd80@linaro.org>
References: <20230526-revert-bad-binding-v1-1-67329ad1bd80@linaro.org>
Subject: Re: [PATCH] Revert "dt-bindings: bridge: samsung-dsim: Make some
 flags optional"
Message-Id: <168509021387.1545019.9918047087016823576.b4-ty@linaro.org>
Date:   Fri, 26 May 2023 10:36:53 +0200
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

On Fri, 26 May 2023 09:27:16 +0200, Neil Armstrong wrote:
> This reverts commit cfaf76d349837f695c8aa6d7077847fec4231fe5 which was applied
> without review due to a bad tool manipulation.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] Revert "dt-bindings: bridge: samsung-dsim: Make some flags optional"
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=35070674f488eefaeb753a13df11199d10328ff8

-- 
Neil

