Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A200605197
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJSUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiJSUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:50:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D1763E5;
        Wed, 19 Oct 2022 13:50:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t16so7781163edd.2;
        Wed, 19 Oct 2022 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Jb/D65Nwg00CddvhyNz1Pxcixmx0unsPQe8+d9sp4=;
        b=fa63IEr9jQKvbBnkDN5zidLJtLtuwez4NKCLptx6HoEnO1qmslQdNwePVxo+j8j6gJ
         CSOAWaJkDuvnh1wfFKZ99frANkEA4eD1QIC/zwJxwGUssFUqpMJR2HPKaBwqI5i35EO0
         33JTLh0XzNYoxV8mHYhujKZezsqZDSbXNYWhQyo2Z1fz//3JYSzQqcRHukFoVylsufnt
         qwNI57GTs468vVKMRDx42UutK9QiLwmfypca+jdxntZCzOHCua633n7YZsx6lil/LCbQ
         B5XOP0ltuncOShhY9+AjxVbSq7c00WUHlTPhpIukN92c1R6mTfW/2P/fzarRKmQgPvO6
         60nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Jb/D65Nwg00CddvhyNz1Pxcixmx0unsPQe8+d9sp4=;
        b=Re/XOZDSU4mjKt/vtYY/u7PY/O2XTA4ykiXkzR4NiICfz3Ygf9YDnx5jz9glE7+Y+d
         895wHI3jX2FES0GBQhv2gEeklJzCabqlEVHmx6oyxsyavCv1VV2saf2mF9y1ZXomQdsD
         kGvGtOAtBRSXH2MT3JwGU+u8prnFv7kR9LqhYhWdd0qmmJe4SExe5gtGLkXHR5whwFvf
         pkbL2neFlIfUKEWDG3q1T0uA8IqnfX9qdQ1oYOz7uQE5fhOkhHWY655j2CPJz6Zu2gR5
         aht6690oJ6r09VfIPBagcQXIrpbCjAU55mg+5Z+5hGYnnWt/e2+T0OLblvuvuJEYBG+l
         benw==
X-Gm-Message-State: ACrzQf2JWIBZcgGoUpwp/jEvHypgIdIhLn0WLw8TfbJGmyhxOb8t4PsY
        C4R/HOenRp+sy5jFrjJHxkX3Z576pkJBG3g8Dk4=
X-Google-Smtp-Source: AMsMyM5WSDH4F3/5sQv3/kCfh6o4ZgGBFVx1bvDggwII+Ekb/WVPf3ARd86uFycXR7ZHWTK4GNRjOWYhMn+7yLUmzC4=
X-Received: by 2002:a05:6402:190e:b0:45c:d10a:4c1a with SMTP id
 e14-20020a056402190e00b0045cd10a4c1amr9266859edz.345.1666212640531; Wed, 19
 Oct 2022 13:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com> <20221004-up-aml-fix-spi-v3-2-89de126fd163@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v3-2-89de126fd163@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 19 Oct 2022 22:50:29 +0200
Message-ID: <CAFBinCAsCg6QQRH3VPY1OKuyfkxY0oCXLhAuMwO6=00gXKqQrQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: meson-spicc: Use pinctrl to drive CLK line
 when idle
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Amjad,

On Wed, Oct 19, 2022 at 4:03 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
[...]
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index c3ac531c4f84..04e9d0f1bde0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -429,6 +429,20 @@ mux {
>                         };
>                 };
>
> +               spi_idle_high_pins: spi-idle-high-pins {
> +                       mux {
> +                               groups = "spi_sclk";
> +                               bias-pull-up;
> +                       };
> +               };
> +
> +               spi_idle_low_pins: spi-idle-low-pins {
> +                       mux {
> +                               groups = "spi_sclk";
> +                               bias-pull-down;
> +                       };
> +               };
> +
We typically have the .dts{,i} changes in a separate patch. I suggest
doing the same here.
I also have two questions about this part:
- why are these not referenced by the SPICC controller node?
- is there a particular reason why meson-gxl.dtsi is updated but
meson-gxbb.dtsi is not? (my understanding is that GXBB is also lacking
hardware OEN support)


Best regards,
Martin
