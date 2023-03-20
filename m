Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46646C1132
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCTLvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCTLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:51:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C222CBD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:51:29 -0700 (PDT)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 647433F75C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1679313083;
        bh=GGpWfsM5C1ImSMDFhmoi1LbWjuKbL/WrII+NG9/nakI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hM94kEI8J2CWhITw3n83CPVx9YzA536hjQLxYB06Fxl+w8uG0/GUhF93JlycEI8AZ
         dymKrPQWZZAsV/6EfntZ5gkHMMPrFq4ol60FfcOQqq+RBWxe4G4kJntWA0i6Edhofp
         f+vtVJEfeHVPeJea8V9q+C32gk7jABGBITbezAw2GuC1weGYHVcrxta2XEtNcMVFhG
         Ef3uD2YTZ3N0dyFcRlB7W4gtsACVUENNVpNoxJO+qE7ulF0uBcUfZ+tWdZnt/RdcO9
         WYl4GYOgIZ7GpjdbgMQLupexlwgQhMHwbSFXJ3sExIasIIhXs2skMyEJG1X+C9/Kmk
         Mlq+Zc0K7+q/A==
Received: by mail-qv1-f70.google.com with SMTP id e11-20020ad4536b000000b005a9292e8c2bso5938668qvv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGpWfsM5C1ImSMDFhmoi1LbWjuKbL/WrII+NG9/nakI=;
        b=q85jdphV56/FdzGHrcCaIv1XHai577aS8EFpuuBLug9Scx9jUAklyphayT2vkRqQB1
         c3WQ0SsT77/laiEM5vC/+AJRAL9ejM0rYycTlcOJGnyZKEeD5frD5WrWhxEHoUZ9+gnW
         7AQDScjWLq03wTJ+MW+GVQGDWU+eNlmkq7NI0pXUxnyWcor5xJJUbXlfUAmixqCMktiQ
         xAxdo33F6sOYrgX9A580kSlXtX58136XBzpkpR/QZ4/8ZsPtJRjN49cHcJPQ+d5K1MWI
         1AjlpG5pY/7YuR3riWuIsBYCTLwjTw6ajm4+d/eGafJI9ICd3O+1//jFm5UFbZKYD6He
         lxOw==
X-Gm-Message-State: AO0yUKWC7qYsooyr5RkTC+aKYign147rE1ZFHTWXOx2AhJvy+ZvJogMW
        htxr2RUFaa+6UDfY0fjVi4KeeWgZWevEFJfM3KNIxAGzrF7NNjKDmt8kZjfoCWjqcziUv7Ri4W6
        DrHoUCzNmzlk14sLIhpvnxoc+oCneX8KUXQE5HfOdhtFFDVxsSuuFfyKQuQ==
X-Received: by 2002:ad4:59c7:0:b0:56f:3e5:850e with SMTP id el7-20020ad459c7000000b0056f03e5850emr6960043qvb.3.1679313082510;
        Mon, 20 Mar 2023 04:51:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set/l+AwVJZR40S7GPUVKDWevuOOVX4sYPIEehyQctIQv1qL8d4CCuDF//+jeSsWW86R+pXOcTviboByTpW6VUeI=
X-Received: by 2002:ad4:59c7:0:b0:56f:3e5:850e with SMTP id
 el7-20020ad459c7000000b0056f03e5850emr6960029qvb.3.1679313082287; Mon, 20 Mar
 2023 04:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230311090733.56918-1-hal.feng@starfivetech.com> <20230311090733.56918-6-hal.feng@starfivetech.com>
In-Reply-To: <20230311090733.56918-6-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 20 Mar 2023 12:51:06 +0100
Message-ID: <CAJM55Z-2HB4PCw3fy6n3e0FErV9DXqGazVkq4TN+X+34ozNcbw@mail.gmail.com>
Subject: Re: [PATCH v5 05/21] reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 10:07, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> Using ARCH_FOO symbol is preferred than SOC_FOO.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/reset/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2a52c990d4fe..6ae5aa46a6b2 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -234,8 +234,8 @@ config RESET_SOCFPGA
>
>  config RESET_STARFIVE_JH7100
>         bool "StarFive JH7100 Reset Driver"
> -       depends on SOC_STARFIVE || COMPILE_TEST
> -       default SOC_STARFIVE
> +       depends on ARCH_STARFIVE || COMPILE_TEST
> +       default ARCH_STARFIVE
>         help
>           This enables the reset controller driver for the StarFive JH7100 SoC.
>
> --
> 2.38.1
>
