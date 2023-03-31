Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28726D1CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCaJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjCaJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:41:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD149026
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p203so26675316ybb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680255708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnaNB1XEFARvtvmMjnyCWM6urGrAoqOyko+dcOeieP4=;
        b=CNHXi9MB2mEr2AuQ/LvwUlACS4Az3+B0YUHQfIOr//HmiPYsXroiJvw3pgwNkVgFE0
         wXRRtCk8TRxTYe0wfCYNIFxtdKH+w8zE8RbLvoKhkDoNCGL2CkfEigwt2+q+2NuBJyRz
         dCcNB6lgTz5vwlDrYJfVyKRPDLZVmmL42SoCJnFhCEsKkRjpsX9lAHfYTLvGgjKGzxQU
         BrZgcPGmtxg9mwOqx8FSa+ou0oa8VLI87WVpMWh+hOKsWpbO6YVwrHw/IBl7DOHwdYVe
         xM5ICyc7V9ewynH7CtsaO3LEiNeSEO7eiT11ZJZ7SdsuTTGaKQY5TjAcmyAC6rPLyptR
         Kozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnaNB1XEFARvtvmMjnyCWM6urGrAoqOyko+dcOeieP4=;
        b=yWPKlpg2V9RmsrD1fnhE5YRffgK3XJqAP8A0VpjWg9sUQC7qLsl3s988GbT6fKu4fW
         HbSwhU3YLAJTGf31wpXMgkGmnWQlG2GuHhV2Nm3BSmdTCeQKGiKAKvdh6pDuK/MMLLJ7
         DN77iMXRoZaK+noIn9aaYvwH2s4WTbbn+HCcrSVY4gdGq7+te+uucxHpNlC1zql3fsD5
         SlcIO0ZwngTtdEfo/ka+PmsRjCheesXaFQZF/b73QRxLgSAf/kMDTgIS7wjcGfdfrvGG
         obLovw7TSF6dQZyejxw1YGslo2XLnvO2TRXQf0zHaOAcK2OfVDjsrRwIg2pEfexBG6f4
         2V1A==
X-Gm-Message-State: AAQBX9d/naw9jdXplaiMs6f2sStq7KD4/EjcJ3wGUETjVCf4i4LR0eaU
        /aGQOATf0+5QELb2KlNH8BixcPVRgCamiDNuQKKUpw==
X-Google-Smtp-Source: AKy350amcuIyJx1ZU05trxaUHqtJYPGKJJHR/eSVOApb4wFEITF/ZQ6+GZDgwhTCygxuJPp9AYOmneX/QLQ0r4PG1oM=
X-Received: by 2002:a05:6902:168d:b0:b26:47f3:6cb with SMTP id
 bx13-20020a056902168d00b00b2647f306cbmr14114282ybb.4.1680255708125; Fri, 31
 Mar 2023 02:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130010.8342-1-okan.sahin@analog.com> <20230327130010.8342-3-okan.sahin@analog.com>
In-Reply-To: <20230327130010.8342-3-okan.sahin@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 11:41:36 +0200
Message-ID: <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Okan,

thanks for your patch!

First: why is the word "Regulator" in the subject? I don't quite get it.

On Mon, Mar 27, 2023 at 3:01=E2=80=AFPM Okan Sahin <okan.sahin@analog.com> =
wrote:
>
> Gpio I/O expander.
>
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

This commit log is too terse. Write a bit about what this hardware is.

> +config GPIO_DS4520
> +       tristate "DS4520 I2C GPIO expander"
> +       select REGMAP_I2C
> +       help
> +         GPIO driver for Maxim MAX7300 I2C-based GPIO expander.

Is it MAX7300, I don't get this, it seems super-confused.

> +         Say yes here to enable the GPIO driver for the ADI DS4520 chip.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called gpio-ds4520.

(...)

The driver is pretty straight-forward, but I think this can use the
generic GPIO_REGMAP helpers in
drivers/gpio/gpio-regmap.c
check other drivers selecting this helper library for inspiration.

Yours,
Linus Walleij
