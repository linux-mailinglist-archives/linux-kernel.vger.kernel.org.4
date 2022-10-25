Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937160CC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiJYMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:41:00 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82D185425;
        Tue, 25 Oct 2022 05:40:59 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id 8so7909888qka.1;
        Tue, 25 Oct 2022 05:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lao/ypUUNI0LjIKEvGEpGGZT7cntnLS2PFomcQrERvE=;
        b=isKE4M3Ed15PP3W2RI9Xgl09g+mee7lta8lrAXvRWga5CRrE+vESEEnLhZi+omNHaQ
         DPRj/DoXeqnLeHe85RnlmgVFl1W1yhkOVGvTG6FZ5aPwZ41GhDlJ4I69GP8VrmaCkcLB
         O8a++ioqdZ/xcx1qks59yo8rnf7HadckRpnuoTD0PMqjYo5LCCepgyU6xClkPuzUNvIz
         IYAzd3IzK+lScBLuCsoGc5WquYuxA+DMKWQxxw8k+9ojH/wg/g3gPajstPFliCJHM9Bd
         cuHqYSbzBgNVW0YQ006s4fMrbikHvgimxNBkEYUiBQqA/3X28OC5yH+0OgwpkU6Srga9
         XP0w==
X-Gm-Message-State: ACrzQf26KjDuz4b/u5uA7YwjnpCuVx3UNLJm+yPl6HY5+t35jrj7xHxW
        BHBUKDcDm28gOP8vVPC6LNePYpIJFiK5Nw==
X-Google-Smtp-Source: AMsMyM7MsvRpNJJYaxWIj/JGMMdI8VbctEcpSCeueXrEDTD2qjlQ7VI6zTZEqU1ktt+xkO7jIGg4mQ==
X-Received: by 2002:a37:b802:0:b0:6ee:9495:9a79 with SMTP id i2-20020a37b802000000b006ee94959a79mr25672278qkf.136.1666701657782;
        Tue, 25 Oct 2022 05:40:57 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006cfc01b4461sm1975292qkn.118.2022.10.25.05.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:40:57 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o70so14386009yba.7;
        Tue, 25 Oct 2022 05:40:57 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr31753639ybb.604.1666701657095; Tue, 25
 Oct 2022 05:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 14:40:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfExBuXNiRBaPRqaX9AvDprTHec7+1K-7Un6gDf6VWJA@mail.gmail.com>
Message-ID: <CAMuHMdVfExBuXNiRBaPRqaX9AvDprTHec7+1K-7Un6gDf6VWJA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] RZ/G2UL separate out SoC specific parts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 29, 2022 at 7:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> This patch series aims to split up the RZ/G2UL SoC DTSI into common parts
> so that this can be shared with the RZ/Five SoC.
>
> Implementation is based on the discussion [0] where I have used option#2.
>
> The Renesas RZ/G2UL (ARM64) and RZ/Five (RISC-V) have almost the same
> identical blocks to avoid duplication a base SoC dtsi (r9a07g043.dtsi) is
> created which will be used by the RZ/G2UL (r9a07g043u.dtsi) and RZ/Five
> (r9a07g043F.dtsi)

Thanks for your series!

> r9a07g043f.dtsi will look something like below:
>
> #include <dt-bindings/interrupt-controller/irq.h>
>
> #define SOC_PERIPHERAL_IRQ_NUMBER(nr)   (nr + 32)
> #define SOC_PERIPHERAL_IRQ(nr, na)      SOC_PERIPHERAL_IRQ_NUMBER(nr) na

Originally, when I assumed incorrectly that dtc does not support
arithmetic, I used "nr" and "na" in the macro I proposed to mean RISC-V
("r") resp. ARM ("a") interrupt number.  Apparently the names stuck,
although the second parameter now has a completely different meaning ;-)

However, as the NCEPLIC does support interrupt flags, unlike the SiFive
PLIC, there is no need to have the flags parameter in the macro.

Moreover,  it looks like the SOC_PERIPHERAL_IRQ_NUMBER()
intermediate is not needed, so you can just write:

    #define SOC_PERIPHERAL_IRQ(nr)  (nr + 32)

> #include <arm64/renesas/r9a07g043.dtsi>
>
> / {
>    ...
>    ...
> };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
