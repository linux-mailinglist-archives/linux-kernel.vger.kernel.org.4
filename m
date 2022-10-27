Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980160FD81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiJ0Qus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiJ0QuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:50:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D271993
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:50:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud5so6397056ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27thMH6kbiBYeHImVpD7suGwEm5dpzCEVU9319M7znE=;
        b=LR5ylFn+fuISymwTB00xHZ6t3I/9VqmosSnSmVnG+w+wni69hiZfzUtKio5rU1epqQ
         PKwl26tatzAMYRrFcU1ArEm9elaSOfVYxYBaGAWAwJBeUH6o3WbL+H1eChTNMnckRwoz
         YLpPwxWkmTWPIxMH08r77/N86vm90ow8+Nhsduxhz4JqYgwq6ENfqc6awtMqNKOHO+6V
         APUEvq4dtPgK6eeZbttohwccXcC/kku6WwdXXlVR1ixzeDn8iQsKFSwKwl3AdZMJa2ue
         mqr0ytlrq4EJhLDIncsbdsYhTXeS7S5MImB0/owkhV2qBAOaNUPPhxO/Xwo4qnZHWMA+
         JDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27thMH6kbiBYeHImVpD7suGwEm5dpzCEVU9319M7znE=;
        b=wxoIuwLhWsgP17PcRPEHqYIbHiv4qzBbi1yvydM49JgGsT2KUJkoJ4EVKGOk4diYUX
         3ctK4mzSWtYrKv4sQ1oWVZ8klGoT1BIXDKA1/rpq7h/SrzIWoGL/Ri2TFIElGaLCBre/
         FMoq9/RN+MLFzrpPr2wdlA465U9P6C1Vi6GB0RY8sMhdtk7liOszFWaptd8im+6z9yPT
         GBQcGtlMVrACmfQ1UIzX71R5A9GuEwowhgWH5KGaiDaUKyZY+PQ94MCyzVLs1IR3I5Xc
         aB1ZZdeWB62n5FqZnS89qgx6XC00Tg09shDDmA4G11kUnqj82AHvXObEC+TwVzia+F0R
         n4Fw==
X-Gm-Message-State: ACrzQf3sFWQ0Czyn0/ja574fmMRriQDgtVvty4eKz1AZySaeqsBxKvn+
        gLgd1JUuUiAE92MaFBvZZRC6jsUlxgKn+hpfZq0=
X-Google-Smtp-Source: AMsMyM58LmKYkZC59FJWd+D3WjBzjSxLpn7tvaAGnZjFQMskGI5vXH3qrtVsby1unS0KOziaRirmP2zfJqz42OjuNno=
X-Received: by 2002:a17:906:da85:b0:741:40a7:d08d with SMTP id
 xh5-20020a170906da8500b0074140a7d08dmr45198589ejb.263.1666889399497; Thu, 27
 Oct 2022 09:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224450.2958762-1-f.fainelli@gmail.com>
In-Reply-To: <20221026224450.2958762-1-f.fainelli@gmail.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 27 Oct 2022 09:49:48 -0700
Message-ID: <CAJx26kWS6+FPjpe125817f7Rf6LiXHBPJ2AfM_1Sj7BwK09Fug@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-brcm-usb: Utilize platform_get_irq_byname_optional()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 3:45 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The wake-up interrupt lines are entirely optional, avoid printing
> messages that interrupts were not found by switching to the _optional
> variant.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Justin Chen <justinpopo6@gmail.com>

> ---
>  drivers/phy/broadcom/phy-brcm-usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
> index 2cb3779fcdf8..fbf454b206f2 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb.c
> @@ -445,9 +445,9 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
>                 priv->suspend_clk = NULL;
>         }
>
> -       priv->wake_irq = platform_get_irq_byname(pdev, "wake");
> +       priv->wake_irq = platform_get_irq_byname_optional(pdev, "wake");
>         if (priv->wake_irq < 0)
> -               priv->wake_irq = platform_get_irq_byname(pdev, "wakeup");
> +               priv->wake_irq = platform_get_irq_byname_optional(pdev, "wakeup");
>         if (priv->wake_irq >= 0) {
>                 err = devm_request_irq(dev, priv->wake_irq,
>                                        brcm_usb_phy_wake_isr, 0,
> --
> 2.25.1
>
