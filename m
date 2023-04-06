Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D86D9822
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbjDFN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjDFN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:26:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F9AF;
        Thu,  6 Apr 2023 06:26:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so1381512ejx.7;
        Thu, 06 Apr 2023 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680787576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2uCgX6sEmCBNBe9xi6iLO8ZFa4TFh6l4wvqAexbxFE=;
        b=puXVNVU9EBdRRU51Tp3oaQEXxiY8mlkmJXepMcAeh/JUwxLDWNUB4XVSWBH4pcyQo0
         Kkr1n2cGfuFoWQn0z3QexCOAjuupo8Bo4UX1RNB28UzJhpND6D5BfiKg0kw2tA90Z0Rn
         MVrARvHfhExzCrcCSMmLuX/DjA7Nmx+4dC15pqGpLX50bYeORL52T2R3FEuwyQJSPR+6
         /O/Ki9h0tX4JsYxjcHB5CN8mzIfl8R1KcLq872ng+KG3A+sjP8wpuWD8e7Kqz8RUqVo2
         oeY5q5nyPxE/Vua8SnKydEMTQoxRJtKf0jV4h+OVAFeG75qWBuotR9+rCMvKaKmWUn6O
         wweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2uCgX6sEmCBNBe9xi6iLO8ZFa4TFh6l4wvqAexbxFE=;
        b=GoZORehMpWLwo/VukKUE12SeC1bYh/64RaWucgoJVIDHs5/d9CSmSWHG7udUyT1kzh
         xP2VZ3EJQu5s+W6Pb8PtRjsSrdKv+YYibf5g+FFdifiAcQ+mvbHqw7iKHnJN8JQkcTVB
         xgk46/Rw0jeZzVo+hu5bHU+SCpqoVLQeGltb/GnWpN9ZpT//Cglf0OrbNVI+AWm+oeWu
         AJ8mRbzJMErexjuketGElLBpFIMhZ7HZmU3DQ3XA3G6H7DVU0Nnv9MwV36gOhVUsSc+3
         QacH5i9VK9ynchNeU4RKQ7jCPzrbLS/YQI+ky5NWXc2gPXUr1Gx8o9ib4R1Pub5U2Pdx
         UAOA==
X-Gm-Message-State: AAQBX9cY12o3jNAlhjSDN1mBI+L+XIhDZFeP8CArCbN4JZzMmBjDVL8g
        wKk9Dwu8X0hZngzl33EVCktDNNEy/R0=
X-Google-Smtp-Source: AKy350aNioyvp7EHIOBjyxhYQsWZ0lS9rtfZyfNBOrNYZDg3XXXRkfQRb1puc/p3quUBiZA/VseVcQ==
X-Received: by 2002:a17:906:68c1:b0:947:fb7b:2fb5 with SMTP id y1-20020a17090668c100b00947fb7b2fb5mr6378488ejr.31.1680787575912;
        Thu, 06 Apr 2023 06:26:15 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b008cecb8f374asm840524ejc.0.2023.04.06.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:26:15 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        linux-pwm@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: pwm: mediatek: add mediatek,mt7986 compatible
Date:   Thu,  6 Apr 2023 15:26:14 +0200
Message-Id: <168078755179.1496271.10390223668553157368.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <Y+zfb2uQyKHng0kS@makrotopia.org>
References: <Y+zfb2uQyKHng0kS@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 13:34:39 +0000, Daniel Golle wrote:
> Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> been added. Also add the compatible string to dt-bindings now that
> they have been converted to YAML.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pwm: mediatek: add mediatek,mt7986 compatible
      commit: 90cb764c3fafb80ac6b3efd99f8481226da40f60

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
