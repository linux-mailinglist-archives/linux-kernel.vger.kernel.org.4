Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F19718BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEaVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEaVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:20:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1DC129;
        Wed, 31 May 2023 14:20:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso370356a12.0;
        Wed, 31 May 2023 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568010; x=1688160010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTefpjTnRZwzVlyTq29ijDBrPiJ0xnSJwo8bcfjK+r0=;
        b=ZFTcDDCB+AImDsN60FrC9VBlEtsMZFDvVnEE5x4/2yTGBPIiWndvUFYAl6tHOi6WIy
         YieUjYix44EqaB5hUp4ldMGNazarRLkck+YAQf8DViExoqjwYF4ZS+aReuMLn0SY2GtR
         hdPVtp1IJOwkQ59+zx6g6KN4PzSVy8+4Nb85rJbAUfEtpk1ag+Q1KfFHcwieqYph9BJV
         NhiflZjBIF9AfS/BsyhTCmjOs9ir4NwE75gyg28zu921bkgsb+KVnAazMybI11s8L+sp
         2DFGmwd1oXlYdiWZUrxe7i1Lo3XdUiyQ5Fcaf61KhqxahCPiQKk/Q8655i9AHLyOSvV3
         Qrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568010; x=1688160010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTefpjTnRZwzVlyTq29ijDBrPiJ0xnSJwo8bcfjK+r0=;
        b=P9xq3/tathTpEYDzQ9z+QQqLKyH5xOAanm9SScip++AMSEIwyFa0YiUDOwbzWfc/iW
         Z9zQ67TobFVV40VllrHuc3g5aTZMeBX8qlGO4KvCK74u4uuZpgOjyoGmJ0P14ThLv67L
         hARtEMhB1hqipjD7+x/MiYDy/XjZq7e9If2U0fav+MBaFqJ0XcFRpf0RGWlKuk/Yllgl
         EVPbGUpesJoWx7VDuxm/m+GEd0vUGoCZhHd/wEtWXh+J8mpNP7sR5QCMqkx7N1KvBT9s
         wcek/4QdPY9ueGPaRbx8pzvoxYCHpZYgKm8I6dfvBGbgaZ4Alr9AyNDZ1KoOX1zWrz58
         hnJA==
X-Gm-Message-State: AC+VfDw9iFYYZYFQjnKm9FZTQ2Jczjn4FD7Jx8bM6rqKadzZPK499PBl
        C+3YCnoGKF5YtV2H/g+RAHw=
X-Google-Smtp-Source: ACHHUZ5mr/4sMrKF5T8XZ8TsweV7bGMUcQcBrBBBVN+jEXwVJ5fiLfFcaaqr4tN2QnOP13QcHGC7qA==
X-Received: by 2002:a17:907:6d23:b0:973:d9ad:273f with SMTP id sa35-20020a1709076d2300b00973d9ad273fmr6055603ejc.46.1685568010061;
        Wed, 31 May 2023 14:20:10 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709064d4800b00965f31ff894sm9472629ejv.137.2023.05.31.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:20:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Minor device-tree additions for C.H.I.P
Date:   Wed, 31 May 2023 23:20:06 +0200
Message-ID: <4832198.31r3eYUQgx@jernej-laptop>
In-Reply-To: <cover.1684258957.git.noodles@earth.li>
References: <cover.1683719613.git.noodles@earth.li>
 <cover.1684258957.git.noodles@earth.li>
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

Dne torek, 16. maj 2023 ob 19:46:55 CEST je Jonathan McDowell napisal(a):
> This small patch series adds some improvements for the C.H.I.P DTS,
> enabling bluetooth, exporting the PMIC temperature details via iio-hwmon
> and finally adding the appropriate base pinmux info for an external MMC
> card. As a pre-requisite for the Bluetooth it also adds support to the
> AXP209 driver for GPIO3, which is the Bluetooth device wakeup line.
> 
> v3:
> - Add Reviewed-By/Acked-Bys
> - Drop redundant else
> - Switch to GENMASK/decimal values for GPIO3 function defs
> v2:
> - Fix missing ; on bluetooth stanza in DTS
> - Add device/host wake GPIOs for Bluetooth device
> - Add omit-if-no-ref on the port E pinmux stanza
> - Rename axp20x_temp to pmic-temp
> - Add AXP209 GPIO3 support
> 
> Jonathan McDowell (5):
>   dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding schema
>   pinctrl: axp209: Add support for GPIO3 on the AXP209
>   ARM: dts: sun5i: chip: Enable bluetooth
>   ARM: dts: sun5i: Add port E pinmux settings for mmc2
>   ARM: dts: axp209: Add iio-hwmon node for internal temperature

Patches 3-5 applied to sunxi tree. Thanks!

Best regards,
Jernej

> 
>  .../bindings/gpio/x-powers,axp209-gpio.yaml   |  1 +
>  arch/arm/boot/dts/axp209.dtsi                 |  7 ++++
>  arch/arm/boot/dts/sun5i-r8-chip.dts           |  6 +++
>  arch/arm/boot/dts/sun5i.dtsi                  |  9 ++++
>  drivers/pinctrl/pinctrl-axp209.c              | 42 +++++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> 




