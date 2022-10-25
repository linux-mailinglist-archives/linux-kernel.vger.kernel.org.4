Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B060CC25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiJYMm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiJYMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:40 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6618C94D;
        Tue, 25 Oct 2022 05:42:39 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id w29so272929qtv.9;
        Tue, 25 Oct 2022 05:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaYh77K+gCSv1Fw/DuS4kr5mhCxIMTP6JrJoQ/+vP5Q=;
        b=oNq0PePdTKVuZuxIU3vEjRJ7Gtnqgf6kxecDbjTrhl/IAByhBoGTpiwCDwy/RDMrn5
         u1mVGVoMeKe81UxCqcDTZy8Rh9fSh1q2KIZpHR1Tn2VAJ4KdhcDOYfaCzGYCsaTH+wi6
         ShtCBX8R1Ikq3hkHn9zoKWsLK4av2TxQLvtsQppUsnOnezn8vcIEoH/BnBa44667rhO5
         fBOIBT/f2F1zdkQYG75OGIO+qTQxOKSbaps7y3q27Hu5DuOQULlrzGvT5+j4UXxeGGaU
         MbYvijD2LGu0N8nckjIDyByXTT+JPYq4wtDkQXCfObZFnuPekjcRDSuzZKWzGCt3XJsO
         0Uew==
X-Gm-Message-State: ACrzQf28QgyfK1YVsWkYuocrpoQ4kYgWN67oV0S2MCQAUb1Ze0U3ontw
        3heeB4T+bFpOSn84jsS0sV9FDrrnKn5EDw==
X-Google-Smtp-Source: AMsMyM7vxbSJh2IZzrRJ02eG+I/uXNlPtmSk8hAZ31q/rWAHIbQwpZaWCqAGSGNNRlxQL6M80w1riQ==
X-Received: by 2002:a05:622a:10b:b0:39c:e3ae:b790 with SMTP id u11-20020a05622a010b00b0039ce3aeb790mr32347148qtw.306.1666701758628;
        Tue, 25 Oct 2022 05:42:38 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006bb2cd2f6d1sm1889653qke.127.2022.10.25.05.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:42:37 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j7so14381273ybb.8;
        Tue, 25 Oct 2022 05:42:36 -0700 (PDT)
X-Received: by 2002:a5b:52:0:b0:6cb:7584:1b20 with SMTP id e18-20020a5b0052000000b006cb75841b20mr1953298ybp.380.1666701756292;
 Tue, 25 Oct 2022 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221017091201.199457-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 14:42:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcHWaUS3rq=3bQOeax1Vig4R1MpG8dDHbe5TDjkVYx0Q@mail.gmail.com>
Message-ID: <CAMuHMdXcHWaUS3rq=3bQOeax1Vig4R1MpG8dDHbe5TDjkVYx0Q@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 0/2] RZ/G2UL separate out SoC specific parts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

(now replying to the latest version)

On Mon, Oct 17, 2022 at 11:12 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
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

> Sending this as an RFC to get some feedback.
>
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
