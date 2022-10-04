Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A95F3F10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJDJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJDJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:02:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91742B603
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:02:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nb11so27428328ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MaE+VYQSDiY92kjGX4h2jSkOyA7XFQBMOSLljPLW3Fs=;
        b=kOrG/KsOgzPslDjCA/2wVvVO8wIY+Cw63qRlS34Bc2Gp0ysABkZAdfwKG3GoOZ3Qov
         t4oapKrVCSblA5nYqcznfIMp6w4ItdU0n5J/SYR+0Hceg0Jqz/Q6SNrd3vhaaCFEqQdD
         zeNuwz5e8oIdedEly8BXGR4rPJLr85M/PVlA/PCGFIq+Ggxp+UmRpOxC53yYJetG5DYL
         Q+HgO/POXHyWYUav/27yx9hiPsg7rGyNS5edBzAQjt7AAACiph3U60WYVAvU393riZGy
         0XVfHUXoDmykiCYSMMFso6leDg6qDMmNQAV3bd8hLOxObTYNZhQ4bCRzK59pirN9TatC
         3v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MaE+VYQSDiY92kjGX4h2jSkOyA7XFQBMOSLljPLW3Fs=;
        b=zaMf7uUkYekzryYSQiyEoWu6hWfdHVFuHu+dlSaBYbyEvIB8bAqa02x48V2S/OHI+Y
         GIHDOIWCaSAZ3ogD+kEB4DgFOGz2qXG1A/4Lg5XXVvwbqWqRI6SQgeZgArpQ6D+SA8vf
         ZrUKHoBB34ZTAbuXxjSXCOX7Ilg1HrawxvAvKD2Vg1fupfsOtFbqgfmh+4VJSNKHumnd
         f7sBOda5rN+noic9+LmcIxuhdleasSJq3+mIU76dhgwl7FTolkvD3UXX8zkI9h5IhnP6
         hPCLFRlqiaHCrPXf5+gVj3H9ZZyS17puF9CpbLj0I6jv/YMLFKv0krbkoif0P0CvgRzu
         7uuQ==
X-Gm-Message-State: ACrzQf0T3C9fIZ5E1mON2G4bAmxQ36PsX7sZM1HVrhRtvM+XH2wqYMP3
        8jfu8Y/CqeYyAciXW4d1M4KbpCt+BIlydqpb0O5ytQ==
X-Google-Smtp-Source: AMsMyM4xndojXaNMN2ex8pnWSc6yo524zQadaqbeACW6jhGMMrzwPKdUyNStMO3sE6xymDGbSG30wCrcXWZUR4MZZtg=
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id
 g4-20020a1709065d0400b0077fca9f33d1mr19070022ejt.526.1664874137461; Tue, 04
 Oct 2022 02:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <YzN6A9Y20Ea1LdEz@google.com>
In-Reply-To: <YzN6A9Y20Ea1LdEz@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 11:02:06 +0200
Message-ID: <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:32 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Properties describing GPIOs should be named as "<property>-gpios" or
> "<property>-gpio", and that is what gpiod API expects, however the
> driver uses non-standard "gpios-reset" name. Let's adjust this, and also
> note that the reset line is active low as that is also important to
> gpiod API.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I think the gods of Open Firmware will try to punish you for such
incompatible changes. But I have long since renounced them.

> Another option is to add another quirk into gpiolib-of.c, but we
> may end up with a ton of them once we convert everything away from
> of_get_named_gpio() to gpiod API, so I'd prefer not doing that.

We need to know if i.MX is shipping device trees stored in flash,
or if they bundle it with the kernel.

In the former case, you have to add quirks, in the latter case this
patch is fine.

Sascha, what does the Freescale maintainer say?

Yours,
Linus Walleij
