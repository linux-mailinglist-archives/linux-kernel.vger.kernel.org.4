Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEB640B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiLBQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiLBQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:54:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F8D15B8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:54:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vv4so12876185ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uIKXhJcggKv0qzzE1oIAIbI76VCnkiza8PERAP1DEig=;
        b=LrDvw4KRmNmUhhGkHd0X1Nv2p2WExtdFQ0G8r3vqma67gcmo4ApCEjVokzPIaD4gml
         UVSHIMbdQYarWkKTdjmPVZ8KYZNy/59LgEvtKiELvUmD13eN1uNGUuVwORM29K6JBvyv
         5TxKWph+Hro7zw5Vowz15PiW9KRqNrK4ciIwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIKXhJcggKv0qzzE1oIAIbI76VCnkiza8PERAP1DEig=;
        b=zrFd33DqQnwdi3wSpchALsay1f80BV4IhAIxmflN66Ew1s7A0tlxjQym474OTIYbMY
         dIeNYd+fjGkrR+SaREaKNsvHsqwuYZNRFfq0Ha3/XT/bkRS/exFS6szFMlK3EqgEjpM9
         ybcQLX+V0gpZnS6TKOeQzYNs7Cdw1l5pv664ohKBBd2Z9S7K8+4c50Xhdk0YVgqDLUaQ
         r0CmTKsUafAM5brjgcy7UFWrIEkm7wrleVee1gNZzJUv9bbvqc38w6uU+ziMWrzUBavS
         hsw4jVNJVqg2dI9tF8lneT98AXHo6XO0oO85WDX0hNk+P9DQxl82hX9CiCDy7Md8caZH
         bSCA==
X-Gm-Message-State: ANoB5pnpJZEy8w0SA056tzuVKM+YXo0EVr0SvFJK+TTbj9XA+Rl/4XwQ
        00WUDXwHkZ/KIU2QCwvcmtoJ4lIEHCMvQy+6paA=
X-Google-Smtp-Source: AA0mqf45zTW4g2QZ2j4GN8T77hOqjt/9zUmvW6076X9xXnk9T6gufwOpDjWv2/l43OoJNbU3vlxvrQ==
X-Received: by 2002:a17:906:52d4:b0:7bc:14e7:cfaf with SMTP id w20-20020a17090652d400b007bc14e7cfafmr33738620ejn.727.1670000068307;
        Fri, 02 Dec 2022 08:54:28 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id es15-20020a056402380f00b0046aa78ecd8asm3123982edb.3.2022.12.02.08.54.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:54:27 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso4761325wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:54:26 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr42831960wmb.151.1670000066491; Fri, 02
 Dec 2022 08:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org> <20221202155738.383301-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202155738.383301-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 08:54:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_kFLh1me+KGcg_hjC8_OhJtZ8ddsQyH2jNkw88ZG_aQ@mail.gmail.com>
Message-ID: <CAD=FV=U_kFLh1me+KGcg_hjC8_OhJtZ8ddsQyH2jNkw88ZG_aQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845: do not customize SPI0
 pin drive/bias
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Each board should define pin drive/bias for used busses.  All boards
> using SPI0 (db845c and cheza) already do it, so drop the bias/drive
> strength from SoC DTSI.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Changes since v2:
> 1. New patch.
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

It's hard to review device trees without noticing things that are
inefficient / wrong. In case you want any others for your list:

a) As written today, `sdm845-db845c.dts` doesn't actually need to
override the `pinctrl` of `spi0` since it's the default. So you could
remove two extra lines of device tree.

b) Officially, db845c actually _should_ be overriding the pinctrl and
we should be doing something like what we did for sc7180 where we have
different definitions for "cs" and "cs_gpio" for the SPI lines. That's
because db845c is actually using "cs-gpio" mode for this SPI part and
thus GPIO3 should be marked as being "gpio", not "qup0". It doesn't
really matter functionality-wise on Linux because the Qualcomm pinctrl
driver will automatically re-mux the pin as a GPIO the moment the SPI
core tries to use it as such, but it's a little ugly.
