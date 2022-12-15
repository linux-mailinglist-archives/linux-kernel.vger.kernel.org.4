Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04764D7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLOImI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLOImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:42:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A32A700
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:42:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 192so2673248ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HXhudpMG5ipoBTmDLzbqLq8C65gsSAGF3azolDiFn1I=;
        b=oS7MvThUFU/JGOGYBihO3JXdurEUA6AetFLg9F1AnzodZpwdxJ17GYUjSqGNCzoTGp
         CRuFzoKrac00hc011hygTaS6JwiED8YasNIiSyZOwO7Rr2BVjvDSPNZ2jW+55SXgL37h
         zS6tDMdtBWFqggnFJiu/bgOLD6DBI6onfSgpbJOitHJdVcPWTCDFAYwazw/7H8ZBL9Ud
         AFOFTA2S1zpGlxZ8fdoJeDXulzQWRXncyFQDnM4Af34bO2NwHMXQoF1R1nNbw0+pdP5o
         2yTopVMiLG76IUn8j6mKOuDmJj2ULCmX8EJyryF4gVzwlQtyLCBOMWPY0wZlTC8TJ9p8
         GxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXhudpMG5ipoBTmDLzbqLq8C65gsSAGF3azolDiFn1I=;
        b=586mFIgwVgrezz+lS8ONYDf2O06e2+N23JhWsG7aJU9V2dfV62TS2l+Q4KyY+ByC0D
         RZHOwlL+w4FjUaRANIwuOphQ5fEhTJjLcXZxOnb8b04Z+m3WJmbWQA9r6q0HGbecFKE0
         PaLP3uD/m8tANCxvsiQtjWqzMQ8Wjc6P9ld1FoCdjtY6teeYCDuM/Eev6LGqWo65XXlI
         nlOGPxPmzcOFuaKObyjdR192hy3x/NHXV+71RcpRPiiIwpIZL1s8UqHS1kfzmgsIiqfu
         S2m5E/OrmOErWe5sGDfEgeLJe0589g+Dl8C173K4xDiykC/CQkAv3H9JPxrGPDXYTO7t
         26Dw==
X-Gm-Message-State: ANoB5plpxG+dpzkEPtJh/W9ppvYARzFSbBKZ4drnX13UMz2NJEPkr7OP
        eKB/6JgNmshmqGwNQ/kiFmpaoN+3QRTL64TRgoRiTA==
X-Google-Smtp-Source: AA0mqf4x35ybJ0oUwOo6o569NEGQzeowDVqPBuoUY4Xc84d7hRJqGGcAdp6C8e04o0YEL7GfLMl3vaM3+xKvTlpWnG0=
X-Received: by 2002:a25:7648:0:b0:6fe:54d5:2524 with SMTP id
 r69-20020a257648000000b006fe54d52524mr24020034ybc.522.1671093719699; Thu, 15
 Dec 2022 00:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214110037.149387-1-cbranchereau@gmail.com> <20221214110037.149387-2-cbranchereau@gmail.com>
In-Reply-To: <20221214110037.149387-2-cbranchereau@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Dec 2022 09:41:48 +0100
Message-ID: <CACRpkdag1ZDyHRu5FqLWrsiqbmVuX2Wj5z67yhkg_=ooFqsboQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel: add the orisetech ota5601a
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

thanks for your patch!

On Wed, Dec 14, 2022 at 12:01 PM Christophe Branchereau
<cbranchereau@gmail.com> wrote:

> Add the orisetech ota5601a ic driver
>
> For now it only supports the focaltech gpt3 3" 640x480 ips panel
> found in the ylm rg300x handheld.
>
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
(...)
> +config DRM_PANEL_ORISETECH_OTA5601A
> +       tristate "Orise Technology ota5601a RGB/SPI panel"
> +       depends on OF && SPI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       select REGMAP_SPI

Nice use of regmap in this driver.

> +static const struct reg_sequence ota5601a_panel_regs[] = {
> +       { 0xfd, 0x00 },
> +       { 0x02, 0x00 },
> +
> +       { 0x18, 0x00 },
> +       { 0x34, 0x20 },
> +
> +       { 0x0c, 0x01 },
> +       { 0x0d, 0x48 },
> +       { 0x0e, 0x48 },
> +       { 0x0f, 0x48 },
> +       { 0x07, 0x40 },
> +       { 0x08, 0x33 },
> +       { 0x09, 0x3a },
> +
> +       { 0x16, 0x01 },
> +       { 0x19, 0x8d },
> +       { 0x1a, 0x28 },
> +       { 0x1c, 0x00 },
> +
> +       { 0xfd, 0xc5 },
> +       { 0x82, 0x0c },
> +       { 0xa2, 0xb4 },
> +
> +       { 0xfd, 0xc4 },
> +       { 0x82, 0x45 },
> +
> +       { 0xfd, 0xc1 },
> +       { 0x91, 0x02 },
> +
> +       { 0xfd, 0xc0 },
> +       { 0xa1, 0x01 },
> +       { 0xa2, 0x1f },
> +       { 0xa3, 0x0b },
> +       { 0xa4, 0x38 },
> +       { 0xa5, 0x00 },
> +       { 0xa6, 0x0a },
> +       { 0xa7, 0x38 },
> +       { 0xa8, 0x00 },
> +       { 0xa9, 0x0a },
> +       { 0xaa, 0x37 },
> +
> +       { 0xfd, 0xce },
> +       { 0x81, 0x18 },
> +       { 0x82, 0x43 },
> +       { 0x83, 0x43 },
> +       { 0x91, 0x06 },
> +       { 0x93, 0x38 },
> +       { 0x94, 0x02 },
> +       { 0x95, 0x06 },
> +       { 0x97, 0x38 },
> +       { 0x98, 0x02 },
> +       { 0x99, 0x06 },
> +       { 0x9b, 0x38 },
> +       { 0x9c, 0x02 },
> +
> +       { 0xfd, 0x00 },
> +};

If these are registers, why is register 0xfd written 7 times with different
values?

This is rather a jam table or intializations sequence, so it should be
names something like that and a comment about undocumented
registers added probably as well.

> +static int ota5601a_enable(struct drm_panel *drm_panel)
> +{
> +       struct ota5601a *panel = to_ota5601a(drm_panel);
> +       int err;
> +
> +       err = regmap_write(panel->map, 0x01, 0x01);

Since you know what this register does, what about:

#include <linux/bits.h>

#define OTA5601A_CTL 0x01
#define OTA5601A_CTL_OFF 0x00
#define OTA5601A_CTL_ON BIT(0)

> +static int ota5601a_get_modes(struct drm_panel *drm_panel,
> +                            struct drm_connector *connector)
> +{
> +       struct ota5601a *panel = to_ota5601a(drm_panel);
> +       const struct ota5601a_panel_info *panel_info = panel->panel_info;
> +       struct drm_display_mode *mode;
> +       unsigned int i;
> +
> +       for (i = 0; i < panel_info->num_modes; i++) {
> +               mode = drm_mode_duplicate(connector->dev,
> +                                         &panel_info->display_modes[i]);
> +               if (!mode)
> +                       return -ENOMEM;
> +
> +               drm_mode_set_name(mode);
> +
> +               mode->type = DRM_MODE_TYPE_DRIVER;
> +               if (panel_info->num_modes == 1)

But ... you have just added an array that contains 2 elements, you
KNOW it will not be 1.

> +                       mode->type |= DRM_MODE_TYPE_PREFERRED;

I think you should probably set this on the preferred resolution
anyways, take the one you actually use.

> +static const struct of_device_id ota5601a_of_match[] = {
> +       { .compatible = "focaltech,gpt3", .data = &gpt3_info },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ota5601a_of_match);

Does this mean the display controller is ota5601a and the display
manufacturer and product is focaltech gpt3? Then it's fine.

Overall the driver looks very good, just the above little details.

Yours,
Linus Walleij
