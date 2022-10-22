Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFBE608C02
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJVK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJVK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:56:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2E2FC5A3;
        Sat, 22 Oct 2022 03:13:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r14so14446268edc.7;
        Sat, 22 Oct 2022 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06Eh/nhcc2dk5YHgUHqVnCwIQ6d3gtHqF6ndFEyn00o=;
        b=VMuZTZXRwDpR3O+afkcfnJXAjQaa5SZKkHcYlMnVcwYNqOFKFxdi0LFa6WPSQTKNM/
         pc5fiF04hiUnP4DSCczNQyvQnbN4AESxQECufjLjtfKnqrc2XPmpgpeNDR7z2bs4+CHL
         IvxEmFJCZ4uAe2JcieU3RgEEe8ustULxygdjz8h62X8fClJKGJOxjr2kcqtm9V/C4mwv
         yE0qxdwqHcSimSx+euw2ho3YtC6fIVUsyvNQKYfQMgkoPu104g3gYBtWIeZiHzwa2X3P
         Z9a6e48lhW1bTuubdJt+KuMtq8fuANAk9+DD21gRtOqQNpE5bj8W7pO+mWUV8oGMa6n6
         OcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06Eh/nhcc2dk5YHgUHqVnCwIQ6d3gtHqF6ndFEyn00o=;
        b=Xgfzcd+8X0rAhGvuC5MoEy4r9s6iO7+27K0emNHr49Eh1V7G/HGk2Dp9SDmQGUYMd7
         MYI15XY0R2JfRV6RybjCusfBjQvSPKytpw7XOYm4TeRepYLMaoUgFUOCp8sqY42sh4/v
         /GWMlz21i4o/rVMZZaeQ5c5DnKohgDejKUrGDwYbG/7fhmNRRfjuNg+mtwpGptX3BIf+
         5omtDskMJswvBBbReu1IkxIfXMyzMO7CMt470+1GCx0ynKmJKHBq9toaRFHbl4b5AIvk
         7vOUMOC8J7edlfOU7ZC38wg09bGgW+XK8QQXatCGrwvkPO60irNCgxd9JSZ78pt1Z+tA
         +Ziw==
X-Gm-Message-State: ACrzQf1dW/moNpcBRgQ/S/jylWReRDmw77oXbUqjoRoMZsqnmPLlHm1h
        S0TUQw+HD1sP23SxlfisTxDt+/0VXUzZ0NP7Jhg=
X-Google-Smtp-Source: AMsMyM7QaRZd6ahXj6EN8TYBfKGXqZyCiosKZRQy5INk2+Si4bfGFYLHkGLRXI+5OCESdg4fjJkhVuQqUiCbjUV96RM=
X-Received: by 2002:a17:906:7314:b0:791:a45a:bc84 with SMTP id
 di20-20020a170906731400b00791a45abc84mr17664692ejc.394.1666433634815; Sat, 22
 Oct 2022 03:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com> <20221004-up-aml-fix-spi-v4-2-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-2-0342d8e10c49@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 12:13:43 +0200
Message-ID: <CAFBinCDWP78Eft63G_QpDH28LibUZF__GNwnBVLcM85dQO8XnA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] spi: meson-spicc: Use pinctrl to drive CLK line
 when idle
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 3:31 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
> signal from the SPICC controller it's not an issue because when the
> transaction resumes all pins come back to the right state at the same time
> as SS.
>
> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
> state change and SPI pins state change from idle, you can have a missing or
> spurious clock transition.
>
> Set a bias on the clock depending on the clock polarity requested before CS
> goes active, by passing a special "idle-low" and "idle-high" pinctrl state
> and setting the right state at a start of a message
>
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
