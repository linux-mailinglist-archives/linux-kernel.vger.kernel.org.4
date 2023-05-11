Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320A6FEE05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEKIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjEKIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:48:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB35256
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:48:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3075e802738so7455073f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683794926; x=1686386926;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MavG6Kk9Pe4HL8j0/etWioEuDmEHCWaEC1JE6orX7J8=;
        b=NxXdF6IBega8jFYuWRkcRkfYvkDka8+uB3602hlNkRCCOIaUDNICbSKD55cWEW8SJc
         GCUnzVdCB2GM+oMnpi0pUGK3ZAciq05gaus6Jl415AJDnoYltrMsXoj4gjsukrqg6a+p
         G86oMsjtNTL6zNdLj5KbG0Eg3xW5MKYfYWDO6ZAFdCkn97UJ5tBJo+cIs1U+8q1Fgv+K
         3lGonlm90bIZR/9/4+6L47VXHPVWgfDVt2geFOgLMDScX25vPeSlsRCEkHt3V4ESBb5J
         YpxV4yIJTYxY1/2QYAkGbbLhv8xskuMQB6Iysg9LR44sX5HACNEIXqUNPt6R8wcxC8v9
         z44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683794926; x=1686386926;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MavG6Kk9Pe4HL8j0/etWioEuDmEHCWaEC1JE6orX7J8=;
        b=Iingw4YAOXnsEoI82P0EFkVTX8gAFGoMSjvSv9R7eqkSZrYk1vTkUDx5RLEa3vEX5I
         RL7sCPMQpaVnpI48S2cDSnv0WWHHnvq4XEl0E3j5HToYuYyCGPkcuc71pTogOFZXY9mx
         t9aA3InX6dPd+4mgVKMwxLpTOOsX/uI0RX5Mwt8tpilppFMiM8Cf41rwZ2Xg6HQe93P0
         vH+pJoyHocbvte0AoGrkyV3imWqNE/wlQrnPas4w/XLoXZ2u1I8RAIYfrRFlkSinj2Vy
         26/UJZbFbSj30xj8uJnZYfdMTDdsA9J+xX6D016w/H9nxgi95s/g5v1LCBrZH6MJ4uiP
         xbPg==
X-Gm-Message-State: AC+VfDyNLaMZG257aD459lyFWibUBVr5P93clFWNGHzi524z9AKvQX4b
        CJMFwBjuVy4Lsps1utv0JBkh9A==
X-Google-Smtp-Source: ACHHUZ6FxN8xnWtJ2s+Qw/vMfGQbDW2EOFTHMfzqCuWj9Tjx6S+HdeZIbvhZc1lxPKciTJMffPqKPw==
X-Received: by 2002:a5d:4fd1:0:b0:2f4:e96e:3c86 with SMTP id h17-20020a5d4fd1000000b002f4e96e3c86mr15638478wrw.14.1683794926354;
        Thu, 11 May 2023 01:48:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b002f103ca90cdsm19707750wrp.101.2023.05.11.01.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:48:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org
In-Reply-To: <20230508083826.1016206-1-victor.liu@nxp.com>
References: <20230508083826.1016206-1-victor.liu@nxp.com>
Subject: Re: [PATCH v2 0/2] drm/panel: panel-simple: Add BOE
 EV121WXM-N10-1850 panel support
Message-Id: <168379492556.1992146.7262967209295860985.b4-ty@linaro.org>
Date:   Thu, 11 May 2023 10:48:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 08 May 2023 16:38:24 +0800, Liu Ying wrote:
> This patch series aims to add BOE EV121WXM-N10-1850 panel support
> in the DRM simple panel driver.
> 
> Patch 1/2 adds dt-bindings support for the panel.
> Patch 2/2 adds the panel support in the DRM simple panel driver.
> 
> v1->v2:
> * Add Krzysztof's A-b tag on patch 1/2.
> * Use struct display_timing in patch 2/2 to tell minimum and maximum
>   pixel clock rates.
> * Set bus_flags to DRM_BUS_FLAG_DE_HIGH in struct panel_desc in patch 2/2.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add BOE EV121WXM-N10-1850 panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0bd5bd65cd2e4d1335ea6c17cd2c8664decbc630
[2/2] drm/panel: panel-simple: Add BOE EV121WXM-N10-1850 panel support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8bb7c7bca5b70f3cd22d95b4d36029295c4274f6

-- 
Neil

