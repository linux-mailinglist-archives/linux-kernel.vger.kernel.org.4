Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42921666E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbjALJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjALJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:27:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D0B57;
        Thu, 12 Jan 2023 01:19:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz12so43207391ejc.9;
        Thu, 12 Jan 2023 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2F015oMATpuWShCHNXOwNWi691GDNYuGqKdTMWs8xA=;
        b=CiIgS3rsRGi73IrS6drvleCIKh9LQuJE3q/5jfd9d/RK13h3/tlPXTQAPGwUDL4dmo
         wjET0IdC0KOfavfSvST7q/MW7izquaQ7o7Zr3LuNnmqYP5Y4SYAtgBfCSf+/RPWGwV9w
         sf9brE5js40Ju4u/HQDDNVCtAxto9x70cfJra89/a4J8EJ6oWVXGRUnNFDUuwex4X1xw
         +kqVSiogycj0od/4MYjT2fNnFhqJRFWmsG/GKLWsLCqVCwDRJjytjuYnuSLX57A9kZZV
         upNz8BCStCKVVoVJP8pSHtBR6RP2I5OzYuK3hJhc2BxSLxRaugcw4Go83VJ39JBKDAld
         QZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2F015oMATpuWShCHNXOwNWi691GDNYuGqKdTMWs8xA=;
        b=B2pS7osLDlykEKVm1VuFpyk5WiODKhzBjGhizj0OFzx1ob56ekhOAEUPVGXpBb8+eR
         38J/yvEKM/VPoe26jw/N0thEhoHgv45GA39HQvnKOcdsuKsOPnL0OcfFgKvA4EN0HGvq
         RynAJFvlaRyZDC2U6JwW1wQh4+YssIcw3H1i+U5y0RhdTpGMMW6Zz+J3ZZltcKsq5aNC
         9JZ2BQO/FJi79th1f0sX3bAw1H4ePONUFqJJdojS5cZCEA4LmI10HrVJKtA/dZmDbmza
         jOf8NW1gG/KkA80tTpiJVIk7WH5q1Cbk3lVKgad107o8P/5B8uTqB8Ka02TyodB+GPbM
         9QAw==
X-Gm-Message-State: AFqh2kp4xjLtX+s4qyvZHOouGcQpDyirnsaTGIsy9mCAuSMP7d22/Dxz
        qlYEHNDrNXqOY+gvNvPXuaB+oIDeh+ZkQdHCHkE=
X-Google-Smtp-Source: AMrXdXtbjwlni0oo+vbOtg+PV6WaGLudh/F3ifwpsn/TiN6E6hTMxrSciIqk0GOPKTMCktPtPRJ6fVZI8Vq5G5v1Ed0=
X-Received: by 2002:a17:907:20fa:b0:7c1:6f86:ec4 with SMTP id
 rh26-20020a17090720fa00b007c16f860ec4mr8952406ejb.621.1673515158387; Thu, 12
 Jan 2023 01:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com> <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
In-Reply-To: <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 12 Jan 2023 10:19:06 +0100
Message-ID: <CAKXUXMyRBhtHBu=9TdaumwuHPzKv48YCWnAoCx=Vr8p_fTJVqg@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI
 support for OMAP1/2 chips
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jan 12, 2023 at 10:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> > Commit 0fee2eac5c2b ("usb: phy: remove phy-isp1301-omap driver") removes
> > the Philips ISP1301 with OMAP OTG driver and its corresponding config
> > ISP1301_OMAP. The drivers, OMAP USB Device Controller and OHCI support for
> > OMAP1/2 chips, with corresponding configs, USB_OMAP and USB_OHCI_HCD_OMAP1,
> > need this removed driver (see "depends on ISP1301_OMAP") to build.
> >
> > Remove those two drivers.
> >
> > With the config USB_OMAP removed in this commit, remove some further code
> > in the omap-dma header and mach-omap1 architecture code.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> This would be a great cleanup because of the simplications of the
> omap-dma code. I had previously looked at it and concluded that
> the driver is still in use though, and I think my mistake was
> just in the Kconfig part of this patch:
>
> commit c32fd10914a314dd96c5d24030200070c84df5f1
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Sep 29 15:38:56 2022 +0200
>
>     ARM: omap1: remove unused board files
>
>     All board support that was marked as 'unused' earlier can
>     now be removed, leaving the five machines that that still
>     had someone using them in 2022, or that are supported in
>     qemu.
>
>     Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
>     Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>     Cc: Tony Lindgren <tony@atomide.com>
>     Cc: linux-omap@vger.kernel.org
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index b3006d8b04ab..95751062078e 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -118,7 +118,7 @@ config USB_GR_UDC
>  config USB_OMAP
>         tristate "OMAP USB Device Controller"
>         depends on ARCH_OMAP1
> -       depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
> +       depends on ISP1301_OMAP
>         help
>            Many Texas Instruments OMAP processors have flexible full
>            speed USB device controllers, with support for up to 30
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0442dc4bc334..a0c14c62ff32 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -409,7 +409,7 @@ if USB_OHCI_HCD
>  config USB_OHCI_HCD_OMAP1
>         tristate "OHCI support for OMAP1/2 chips"
>         depends on ARCH_OMAP1
> -       depends on ISP1301_OMAP || !(MACH_OMAP_H2 || MACH_OMAP_H3)
> +       depends on ISP1301_OMAP
>         default y
>         help
>           Enables support for the OHCI controller on OMAP1/2 chips.
>
> Instead of changing this to 'depends on ISP1301_OMAP', the line
> probably should just be dropped entirely.
>

I see. Yes, probably, !(MACH_OMAP_H2 || MACH_OMAP_H3) is really in the
current state of the repository "always true", and hence this
dependency "depends on ISP1301_OMAP || !(MACH_OMAP_H2 ||
MACH_OMAP_H3)" is always independent of  ISP1301_OMAP.

Are you going to fix up your commit "ARM: omap1: remove unused board
files" with this change?

Please ignore this patch then; patch 1 and 4 still seem good to pick, though.

Lukas
