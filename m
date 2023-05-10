Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51686FE424
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjEJSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:43:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EA8F;
        Wed, 10 May 2023 11:43:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1380937866b.1;
        Wed, 10 May 2023 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744211; x=1686336211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq7FGBBCVUWg9J5mCHnrCLlt8OqBW6wcJOJEyZGAjTU=;
        b=bmqkK9YGPu+Dx9JKP0oGXBndlrDSdWNiog1vFSUuZI0DvCy+7UmDadEPQTNfWgTOkS
         1bzucwXk1rJ74lAUkDBcwOfw7QkyVFfAkQNvjGr/22/3IiGyKfi1WZ6FtHe+et3MTS0G
         DiaEan1VTKwjOg1VQ2icxdFSJlBcQGvicNobmsXb56tbONBfx+0O0bc5lFjlseDZ/0av
         Yk8Bn2n1oXTrZFabtWVmJmjf5dSnU0Axt1NUKGfMjVJbnZw+eFmRKHAp97IKd8vUiCkh
         m4Jr80UbW7FLE/oWq3QHKlBQZvvjd8QgbF+cKqyd2E/+8ekX7bkuc9MmwQFaGP/mEu0f
         gXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744211; x=1686336211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gq7FGBBCVUWg9J5mCHnrCLlt8OqBW6wcJOJEyZGAjTU=;
        b=gAOISCBAX+je840lNslBcHM5KKIq3EdjSCsUpiUkUIg3ASEieAJ9c6Zo5LwB7DAX0k
         iWWk7X3AjcQPjchDB5QzzqS1LRFCnZGMG3d6HCjIzY3L+5gfRVEjcZvzrpghsnEIJKad
         tWBanViqabrwte/tPi+l6C0f2DpYAv1xTFWaoaJiX7KDtoNqdhfIKByE17Fw5HrokOJj
         hDr1a2zAT+g45vzOguTeRQ1Ax1vn4DWsyGwxQWG2GAd1qUbF6YM8RbHiyoDKKhNbbbma
         YAbIIQ5sxPc9PI5fCd3uD+1PnnV8m+fU1s6OYC/eLRgF+z8sWS+a2ImnX5Zd+sTUOa8X
         PjHw==
X-Gm-Message-State: AC+VfDzQaFyY8nEx7mvz+g1YcNDEfXeDKreZw5EcbeGFeNahZ9KI7Uwu
        V6Z0BYZOZEht5Fb6kqNAQKY=
X-Google-Smtp-Source: ACHHUZ5qQHPAak3fJENQzWiF5faDzhV/CfrF6o5JZeuLw4jsNWWDaYlpbOzCCgyE3kmTmGrXn0ZNzQ==
X-Received: by 2002:a17:907:7f14:b0:94f:9acc:65c9 with SMTP id qf20-20020a1709077f1400b0094f9acc65c9mr16822802ejc.66.1683744211262;
        Wed, 10 May 2023 11:43:31 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jz24-20020a17090775f800b0096347ef816dsm3003796ejc.64.2023.05.10.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:43:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roman Beranek <me@crly.cz>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux
Date:   Wed, 10 May 2023 20:43:29 +0200
Message-ID: <5674988.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20230505052110.67514-2-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-2-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 05. maj 2023 ob 07:21:07 CEST je Roman Beranek napisal(a):
> TCON0's source clock can be fed from either PLL_MIPI, or PLL_VIDEO0(2X),
> however MIPI DSI output only seems to work when PLL_MIPI is selected and
> thus the choice must be hardcoded in.
> 
> Currently, this driver can't propagate rate change from N-K-M clocks
> (such as PLL_MIPI) upwards. This prevents PLL_VIDEO0 from participating
> in setting of the TCON0 data clock rate, limiting the precision with
> which a target pixel clock can be matched.
> 
> For outputs with fixed TCON0 divider, that is DSI and LVDS, the dotclock
> can deviate up to 8% off target.
> 
> Signed-off-by: Roman Beranek <me@crly.cz>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


