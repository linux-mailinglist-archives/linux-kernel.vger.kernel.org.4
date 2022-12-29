Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8565880E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiL2AXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2AXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:23:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735E86589
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:23:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d127so14691024oif.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5n19q5k9lrHaHasolTS/ptrEfcV+LGTg7kYhaCHvFHQ=;
        b=Cf4l9JKrdX/Ez2nZNvo9zM5aX/7hd7PNIEIjJ8L9QGCjmUrTdgfPSWmKAe/jUKUMNl
         dniw6e1eDsh6BzutXynzstEtsWOBfSZDoCxlMCzwDZkTRuceeUuwsWB1KFIHO5qqMy+D
         tm72D4OjR8XKDN9oncoyEFIqsb5hyMVWDTpWyAAf/dUzp/ifvY58bhba8zn1ehZQgBs9
         d8AtLNzBPOifVswf0OhJAQu3iNabD1zz/7q2bsq8Nl2Q8Yuu3AG3NkkW7YV4RZYaNTUq
         gOBDsrg3Wg3hHyg7Fi1c+c9QcyuqZYJg22yOHplkFt2Jn1aGXfYosAqoF5Ac7yVGF4dy
         jJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n19q5k9lrHaHasolTS/ptrEfcV+LGTg7kYhaCHvFHQ=;
        b=y5pV6FNbHFF/qNiJwWHFgv9T0YTFqZkcHdgyRa1rGo22tMUJ7vaMSQ4laC+rM1lkMx
         EDo3AD/zkMLEjBQAKcpNLGJLsyO4/AhJkmSVwQNSUQK/i9uDgcwRrMKFvTBxwhgYk2HL
         PifhXtrDxmlEnOpf2m5H+KjCJXje5EtEtO26HHN2s/Oe0qGJoeASBWhlE123uOQBWqIT
         mTFhYfuiblAKpHF4lhPujcpnY35gUUl6zSm6NZbkl46vSjsS5Wa4wu/xvU1iNlvkktAt
         XAVmI3RI28AXJwZE7bToz/8xo9qNR+TuZFJoDcnHwwVJCmVv6FY4FGyeS8whjaXDXVQT
         ZOtQ==
X-Gm-Message-State: AFqh2kplIPqWmMunt89n5wi8mWEC0DowdxiXtsjyke/3Hs+TEUrdNIlT
        h1wvWGKWvnQhE0Cu4/cG0Xtn+MNfw7X9JGUi07nHO9gmJ+Q0CRzNv54=
X-Google-Smtp-Source: AMrXdXt9HxYfhcMXjKBtBHyCEDmd0OQJn/C8Wfcv/tiY3a9Q9iTDYQ5TkNCQuLDAM2jjWd2akxSupd0TXW52M4s7oQo=
X-Received: by 2002:aca:3dd7:0:b0:35b:8358:aed4 with SMTP id
 k206-20020aca3dd7000000b0035b8358aed4mr1385039oia.291.1672273410711; Wed, 28
 Dec 2022 16:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com> <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20221226073908.17317-2-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 01:23:18 +0100
Message-ID: <CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hari.prasathge@microchip.com, dmitry.torokhov@gmail.com,
        ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balamanikandan,

thanks for your patch!

On Mon, Dec 26, 2022 at 8:39 AM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
>
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Overall this looks really nice! I thought about converting this driver
but was a bit afraid of doing mistakes since it was a bit elaborate.
Nice that you use fwnode accessors!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Improvement to consider (can also be a separate patch):

> +       if (slot->detect_pin) {
> +               present = !(gpiod_get_raw_value(slot->detect_pin) ^
>                             slot->detect_is_active_high);

Normally we contain all this active low/high mess in mmc_of_parse(),
but I guess this doesn't work here because the of node is different
from the device :P

Since the code says *explicitly* "active high" not "inverted" as the
core code parses it, could you try just push this to gpiolib like
we usually do, by deleting the detect_is_active_high stuff and
just apply a patch like this?

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4fff7258ee41..5979c9a75cf9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -199,7 +199,9 @@ static void of_gpio_set_polarity_by_property(const
struct device_node *np,
                { "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" },
                { "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" },
 #endif
-
+#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
+               { "atmel,hsmci", "cd-gpios", "cd-inverted" },
+#endif
                /*
                 * The regulator GPIO handles are specified such that the
                 * presence or absence of "enable-active-high" solely controls

(It's fine to include in your MMC patch if some GPIO maintainer like
me ACK it.)

Yours,
Linus Walleij
