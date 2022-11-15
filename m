Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392EB62AF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiKOXPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKOXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:14:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3277665
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:14:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z26so15775703pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0uftbK3o2kwR2nvD90dsb+LA1y7S9LzGYBR1hgiw/w=;
        b=rkBJzaguJ6AEhOpAcCRXOuIVWePbPATZpT6hYsVnbgEBV4uTLmp9hwmT0L4e8j87RT
         BGqhP6xWQdS8tQmzJ/UDv1U3liafAUoBr7jefjPhP5mxcHNP7/frHIPMqG8fUvI+txfp
         Jfs5Xh04jxxNV6GnM/xPV7BQwp4Y1YXkE35H8PWUTh6LvLe1YwcFiF+/4LAPsQv3XHpi
         KY1TTsosAsu456FszOqpHMf2zn32coJHYgCxbgnX6oog7MP4Ps9R7iPkYK+g2ghZaNjx
         BrjxCiPbFZtr03FfC40lJ/JeIpU7os/T1ZfHUOnjHqfnb9OSIHmiivRs4IyivGnmA4SV
         HMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0uftbK3o2kwR2nvD90dsb+LA1y7S9LzGYBR1hgiw/w=;
        b=47udDjUagvVCAPDOKQv2oOF9jgglMs71N5+Do9MEhFsuqQbO2Gl20NAvdkVv5CtI22
         pGXh8pyUKsXCZPp7kVdHLhUn3xv+Fb2s54PwIyXNe4KeNnZ8y8IHja10mATXK/9bffOp
         kpnse8NqGkNEtv+OD/xVxsj+S1OORULiGGySPvAfemCrdruWUNJRRsaQidG/nmmQgIOz
         +kztAT52EXbrFMuxRXq0w3luXcjb9ji9pdW8BcSXT597hXghpocruJpyBWNmOqo9lLMr
         HVLhZ/YjzXiSM4x5z9d4r1EmlEpOJjeK/QqmTTg2x2ZBL/CWs6fbp72LLylOdHz7zhgJ
         jWPw==
X-Gm-Message-State: ANoB5plIvrO8MYeuq8Rr0F3trZ/QYHlPNrHmflXPrUwDTpaXTyeKZliZ
        KYw2rxw2pnddurOa6HQREVC9VA==
X-Google-Smtp-Source: AA0mqf4CKlVKX8SbFuD7sRH7eqvZK1DoM8NYkkY4a5A2CELaFOotf4CiY3Oh1enmQw4eR8TqSghhbA==
X-Received: by 2002:a63:1949:0:b0:46f:38ad:de99 with SMTP id 9-20020a631949000000b0046f38adde99mr18267574pgz.218.1668554094371;
        Tue, 15 Nov 2022 15:14:54 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id w13-20020a627b0d000000b0056ee49d6e95sm9291846pfc.86.2022.11.15.15.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:14:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Jerome Neanne <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com, afd@ti.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
In-Reply-To: <20221104152311.1098603-5-jneanne@baylibre.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-5-jneanne@baylibre.com>
Date:   Tue, 15 Nov 2022 15:14:53 -0800
Message-ID: <7hr0y395ea.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Jerome Neanne <jneanne@baylibre.com> writes:

> The TPS65219 is a power management IC PMIC designed to supply a wide
> range of SoCs in both portable and stationary applications. Any SoC can
> control TPS65219 over a standard I2C interface.
>
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
> - power-button
>
> This patch adds support for tps65219 PMIC. At this time only
> the functionalities listed below are made available:
>
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
> - Regulator warnings via IRQs
> - Power-button via IRQ
>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-for-mfd-by: Lee Jones <lee@kernel.org>

You've ack'd this for mfd, and Dmitry acked the input one (PATCH 5/6)
but suggested it be merged via the mfd tree.

Could you please take patches 4 & 5 of this series? Then the DT
patch can go via arm-soc.

Thanks,

Kevin
