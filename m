Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44E361F655
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiKGOlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 09:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiKGOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:41:08 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F314D3E;
        Mon,  7 Nov 2022 06:41:06 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id c15so6940569qtw.8;
        Mon, 07 Nov 2022 06:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auAl3TG+WCd06b713vu/zKhrp7Pm1giyKjxfMJDpScA=;
        b=6LdH5Bz3zyvdrARzQaBh2TH2VoqndfqauBYBfZMmnFyFx9XnXeQvE7ce2lEtoQ+3QD
         rJusGU6EW/4w5rFLyuP3JnnWr2XsoaVyf2uBV2jZu2qrmnbblLPEaGFcsYyfe8HVvBwv
         tVPnWCysRTgNjSDDCkYnngKWgph+KMKJ9YSwIqOsd6k+TmvuApTagrjTXsnGYrHmgRDI
         GGwN+WmoMsRxdqZBqreypkTnXw10AG6QyPZdOur5Pyg3aOHag6NHbpCbeoiLeflKCU2z
         hjclZBRqdbE3XM/T7m6/kmoCahh5b4VMpEhcVLkRmaFfJQBcDSmgSomjg6QCK1FjwSTb
         CIpw==
X-Gm-Message-State: ACrzQf2PIUr9yJd0WIqq9F/G2m0xqt0tduIpqgyBdnl2MAZ+U9+9bzdD
        WHDY3Cbs4XCSoJCcsQiUTG4yXN1KgFOifc48
X-Google-Smtp-Source: AMsMyM7U+myaKVvR4QyMTfQx7LX3oJpIGGCXIrDhFlQihir7IqggDZufrOJkOBU+k8R0JIzOhz32aQ==
X-Received: by 2002:a05:622a:4010:b0:3a5:3131:34f4 with SMTP id cf16-20020a05622a401000b003a5313134f4mr28932164qtb.54.1667832065660;
        Mon, 07 Nov 2022 06:41:05 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t12-20020a37ea0c000000b006bb82221013sm7080121qkj.0.2022.11.07.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:41:05 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-367b8adf788so106311287b3.2;
        Mon, 07 Nov 2022 06:41:05 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr2185019ywe.358.1667832064943; Mon, 07
 Nov 2022 06:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-2-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-2-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 15:40:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbWGYPkspMx40S02cr6sX2LZkGwye3JQCtiPtLhuDCPw@mail.gmail.com>
Message-ID: <CAMuHMdVbWGYPkspMx40S02cr6sX2LZkGwye3JQCtiPtLhuDCPw@mail.gmail.com>
Subject: Re: [PATCH 1/7] soc: renesas: r9a06g032-sysctrl: Export function to
 get H2MODE from CFG_USB register
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com> wrote:
> The CFG_USB register is located within the system controller.
>
> We need a helper to get the H2MODE value from the CFG_USB register
> without syscon.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -25,6 +25,8 @@
>  #include <linux/spinlock.h>
>  #include <dt-bindings/clock/r9a06g032-sysctrl.h>
>
> +#define R9A06G032_SYSCTRL_USB    0x00
> +#define R9A06G032_SYSCTRL_USB_H2MODE  (1<<1)
>  #define R9A06G032_SYSCTRL_DMAMUX 0xA0
>
>  struct r9a06g032_gate {
> @@ -341,6 +343,22 @@ int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val)
>  }
>  EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_set_dmamux);
>
> +
> +/* Exported helper to get the H2MODE bit from USB register */
> +int r9a06g032_sysctrl_get_usb_h2mode(bool *h2mode)
> +{
> +       u32 usb;
> +
> +       if (!sysctrl_priv)
> +               return -EPROBE_DEFER;
> +
> +       usb = readl(sysctrl_priv->reg + R9A06G032_SYSCTRL_USB);
> +       *h2mode = (usb & R9A06G032_SYSCTRL_USB_H2MODE) ? true : false;
> +
> +       return 0;

Perhaps not pass *h2mode, but just return USB_ROLE_{HOST,DEVICE}
(enum usb_role in <linux/usb/role.h>), or a negative error code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
