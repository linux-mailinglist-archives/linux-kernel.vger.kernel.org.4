Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D9604C43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiJSPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiJSPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96170FADE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:50:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q9so41014285ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/LBGeRA1bR4x/er8ptm3OVF4CHSU/5RYrhJUueSgZE=;
        b=C1ufBFChd3ta9Bpk6NhYscZbbJ7JDe1ZFQ+hb33zZWt91jdlj+w86KBpTM6vakXu2U
         Qv0x1YlEOhpT9celq+q/nlE3hxnC7RldNre50cZVo02wJvg8NgB+MdadbWkRBZzB49bQ
         k6FO3/apf9bvCZYQGYyY9ln1WQ/EFw8vZXsyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/LBGeRA1bR4x/er8ptm3OVF4CHSU/5RYrhJUueSgZE=;
        b=NmEeg2cmcJaP4um8d+LAk/6GF1Ih/RQ8aomyhLeOovKUvUief3cVvFxsd7mrKwFITE
         4nzv5jrAmwohi2LYzQWnKDuXI75qUscOuaxw3kxG5Y3vGqjPL+2oFjTK4gQRhBzImfq6
         JWzBqt25nyUcmxW8FoVCN9u5EQsbmavv94Ie1zCyC03ykEJk7eVJ6IoSKv3pdMBVPpnA
         UcR2eK1G252XvqQlyc9wc0dgmOsrproV4QCZ775d2Eh1wMKOGv83QcA7xQ3Z1Otwz/wP
         ACVgcuZ8SpUXteP/DVLdEkFlzm1xxo2d8gvBeuJOux+HMg7OfZq86Eqx9PvLKP8SYYln
         uyKw==
X-Gm-Message-State: ACrzQf0TJLzdgOrn3JSYhy7gJhZl0lAT6AwX5VY+X5aqhHpsImAzql2y
        3vZkjrYHWwmkmncOLt7oa+nOH9Z1+7iZwl/a
X-Google-Smtp-Source: AMsMyM5cEowiuD3xN+yYUta4fPyql8N+S1hrW1ObVh2N/oB4UBCb7yBJL26Y14TAgxrBah2dZBC5Og==
X-Received: by 2002:a17:907:a068:b0:78d:cbcf:f7bc with SMTP id ia8-20020a170907a06800b0078dcbcff7bcmr7312554ejc.519.1666194500606;
        Wed, 19 Oct 2022 08:48:20 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7dbd9000000b00456c6b4b777sm10396870edt.69.2022.10.19.08.48.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:48:19 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so288804wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:48:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4b19:b0:3c6:cc7c:763c with SMTP id
 i25-20020a05600c4b1900b003c6cc7c763cmr6355432wmp.57.1666194498976; Wed, 19
 Oct 2022 08:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org> <20221019001351.1630089-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019001351.1630089-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Oct 2022 08:48:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UriVs4-=KCg5TkzCuQaS=LEZS=CDOH0=69GsYjhPcu_g@mail.gmail.com>
Message-ID: <CAD=FV=UriVs4-=KCg5TkzCuQaS=LEZS=CDOH0=69GsYjhPcu_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sc7180: revert "arm64: dts:
 qcom: sc7180: Avoid glitching SPI CS at bootup on trogdor"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 5:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> This reverts commit e440e30e26dd6b0424002ad0ddcbbcea783efd85 because it
> is not a reliable way of fixing SPI CS glitch and it depends on specific
> Linux kernel pin controller driver behavior.
>
> This behavior of kernel driver was changed in commit b991f8c3622c
> ("pinctrl: core: Handling pinmux and pinconf separately") thus
> effectively the DTS fix stopped being effective.
>
> Proper solution for the glitching SPI chip select must be implemented in
> the drivers, not via ordering of entries in DTS.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v2:
> 1. New patch
>
> Not tested on hardware.
>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 27 +++-----------------
>  1 file changed, 3 insertions(+), 24 deletions(-)

It would have been nice for the commit message to mention the fix in
the driver, which has already landed as commit d21f4b7ffc22 ("pinctrl:
qcom: Avoid glitching lines when we first mux to output").

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've confirmed that this patch is fine after taking the pinctrl fix.

Tested-by: Douglas Anderson <dianders@chromium.org>
