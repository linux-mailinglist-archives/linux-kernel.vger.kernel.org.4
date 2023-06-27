Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE3873F62E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjF0Hyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjF0Hy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:54:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966810FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:54:22 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6985de215so38378461fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687852461; x=1690444461;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/9SiAC6+9hSpeXdep9Ze7xghxn8zCBJk7xNH3HIPpA=;
        b=xH3OBdpByqpSTSDwgUUbQnCdFbZ8EGBUquiIbTgoM6ur/RxO4jzr5N7FVdLEyp9osu
         4fUg5o1kQgFd39kaSQB/v3Dt2i5+kH+XtjQrYFY2H/phUVXzEfm1YhsIZTP5BWuD6/AC
         d8Wd1CuUwipCNMSrcoEVdiV0oA82bEUcO/DWeKoMQVtlExD0oo0eqYO+EDG5OgJWsT5q
         l5gdVK4Ub+V8MQoKEiEqvq2+3rmEiIOuUolAzbjTnUgRBWqSgyoCdv8UKbyPfLgPtOaA
         E3s1bXCmPgb9Iy0Atr6leoWtgDn/a0RgdPONUCFznSOJfqB4wsYAYc3aSmK8lQQxqugZ
         5rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852461; x=1690444461;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/9SiAC6+9hSpeXdep9Ze7xghxn8zCBJk7xNH3HIPpA=;
        b=WxRZ3Sk1znlfbolc5pe7Cg9N1sV0182JTCfa0jY/QBsjDFqdAEPHPKrICyFKjpOK0O
         RbblyircJr8RCdOECr9mGBWOTbyRLVMmINZx5k6CBG3cW5yaNsqibZjIBh/yURLPjHYU
         DLeJ8VfexiQQVeGobuxRHZ/J9UEuGd2LfJ7usCcKpyMwV2iZcjNxwZZ9LsTI5sZXRXDP
         gggWQ8++WNZkI/bOE6ZEPTUsB61qSQwa2obuXl7lPJrs6JTo3/y+I9K8uwAq8yUCwAfP
         QH4EVir7iwuQJkd5hVTa+GUfvfb/9+GoUq75Ae6N4+lsusMYiEhKxHrAKYM7E5ubAeEP
         Q2Mw==
X-Gm-Message-State: AC+VfDxcwYSBuOMM1pBz+WSI48zLzjzDJQoYZ4X2GgSYFekz0S4eh+/9
        kNNJ/Kz04GYNfcwnTc4WaLrNig==
X-Google-Smtp-Source: ACHHUZ7bpuVEi9RLkIMrLwAHeRUB8Dq5bSdhVpr9n9MLMwiGjVZ9wyoQ3JQkv2KD/Z88PbBdz+0EsQ==
X-Received: by 2002:a2e:6e16:0:b0:2b5:950a:711c with SMTP id j22-20020a2e6e16000000b002b5950a711cmr8267099ljc.10.1687852460842;
        Tue, 27 Jun 2023 00:54:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d4561000000b0030e5a63e2dbsm9665578wrc.80.2023.06.27.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:54:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <cover.1687702042.git.adrian.larumbe@collabora.com>
References: <cover.1687702042.git.adrian.larumbe@collabora.com>
Subject: Re: [PATCH v3 0/3] Add additional YUV420 bus format check for
 dw-meson's bridge enable
Message-Id: <168785245992.3048852.18155160209808336465.b4-ty@linaro.org>
Date:   Tue, 27 Jun 2023 09:54:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 25 Jun 2023 15:17:14 +0100, Adrián Larumbe wrote:
> This is a belated follow-up on
> https://lore.kernel.org/dri-devel/20220515204412.2733803-1-adrian.larumbe@collabora.com
> 
> Commit e67f6037ae1be34b2b68 ("drm/meson: split out encoder from meson_dw_hdmi")
> broke 4K display modes for me, and I discovered it was because the right
> pixel clock wasn't being chosen in dw_hdmi_phy_init. I misinterpreted the
> reason as a problem in figuring out whether we want to enforce YUV420 mode,
> but it turned out to be a mismatch between what dw-meson code is doing and
> the way the bus format is being picked by the dw-hdmi bus output format drm
> helper.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] drm/bridge: dw-hdmi: change YUV420 selection logic at clock setup
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7ed40ff1d134bf3a4aef706eed478b926f35b404
[2/3] drm/bridge: dw-hdmi: truly enforce 420-only formats when drm mode demands it
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f3710b424a96078f416e1be9cf52b87eadabae78
[3/3] drm/bridge: dw-hdmi: remove dead code and fix indentation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2299a8d12c1cbcdc7086027615d9936a970e7d68

-- 
Neil

