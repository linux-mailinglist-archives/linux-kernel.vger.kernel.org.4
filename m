Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0480D62191F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiKHQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiKHQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:10:23 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3D64EA;
        Tue,  8 Nov 2022 08:10:22 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13bd19c3b68so16727915fac.7;
        Tue, 08 Nov 2022 08:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgYwl0gmnsxFOUsgyWE/Sl4MS1UpSQ37yRLVhvYKL6w=;
        b=yktN0pk7EvGJHTbI3HvqPHaxglC0owyhkI8v8QNN/BrBtxUHUzwGfWPLoglQU8kfjq
         YAlljEdmIkv2CDYH8E0DUIhOgL2OkMXkDd6xzCh8ug/++2qjNzRucWzhaM70MpH8tlHf
         IRnmzfmvOmHgK/MZuAY2kL5DTKyr7FSSCcpby2WN3fjPstp0keY7oidOSjvJtn/EyFqv
         qM9mLSBlkHVvrp+sQgKxxzga6OMljpV/xxC7j+RneiMxp4KtcI01CRjDtfbGqXSPDvcX
         15uBkfiDBWpBoBCbfUiVWQWkaVgmaw9+iXsaBo/J1Oz8uakh7A0cDEcf4zde2Pn+//vY
         xYwQ==
X-Gm-Message-State: ACrzQf1a6ZrNLkS2WznBE1eWybV8VjlHoRlJOb+dxnSEG8sI+uSVa8sb
        PfdW/yntghlJPRPv9AQ/Gu/UDKzrdYXoV4lL
X-Google-Smtp-Source: AMsMyM7XkTAVkimfUleHK0FDOWapWsrhTdaox2C6TD+xEsoLtkeAL1hncV71Gj5WQeTM/C5Xuk/j0w==
X-Received: by 2002:a05:6870:aa94:b0:136:c9c1:6737 with SMTP id gr20-20020a056870aa9400b00136c9c16737mr714857oab.146.1667923821332;
        Tue, 08 Nov 2022 08:10:21 -0800 (PST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id s205-20020acadbd6000000b0034d9042758fsm3609549oig.24.2022.11.08.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:10:21 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so8618791otu.7;
        Tue, 08 Nov 2022 08:10:21 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr43158792ybc.89.1667923389628; Tue, 08
 Nov 2022 08:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud> <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
 <Y17+pHAg/SBJAEXq@spud> <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
 <CA+V-a8utoDSKcZFdtJ0BKwvPfcvf0WVH2Va-Fv_-pKC1FOOVsQ@mail.gmail.com> <Y2lLpCRpTQL+0dsR@spud>
In-Reply-To: <Y2lLpCRpTQL+0dsR@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 17:02:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjZGTNM7pUqxwXd08bjuPEFUuUwKFGx01FVCqOGnc6hQ@mail.gmail.com>
Message-ID: <CAMuHMdXjZGTNM7pUqxwXd08bjuPEFUuUwKFGx01FVCqOGnc6hQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Nov 7, 2022 at 7:17 PM Conor Dooley <conor@kernel.org> wrote:
> On Mon, Nov 07, 2022 at 06:03:41PM +0000, Lad, Prabhakar wrote:
> > On Sun, Oct 30, 2022 at 11:01 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Sun, Oct 30, 2022 at 10:46 PM Conor Dooley <conor@kernel.org> wrote:
> > > > On Sun, Oct 30, 2022 at 10:37:01PM +0000, Lad, Prabhakar wrote:
> > > > > On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
> > > > > > On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > > > > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > > > > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > > > > > entry-class social infrastructure gateway control and industrial gateway
> > > > > > > control.
> > > > > > >
> > > > > > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > > > > > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > > > > > > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > > > > - AX45MP CPU
> > > > > > > - CPG
> > > > > > > - PINCTRL
> > > > > >
> > > > > > Hey,
> > > > > > Looks like you've got a pair of warnings here from dtbs_check. I tested
> > > > > > this on top of 20221028's next, with the three branches below merged in,
> > > > > > hopefully my merges aren't the source of them:
> > > > > >
> > > > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
> > > > > >         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
> > > > > >         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > > > >
> > > > > Thanks for the review and test. The warnings above are coming from [0]
> > > > > as support for IRQC is missing, once that is added the warnings should
> > > > > go away.
> > > >
> > > > Right. I merged in the stuff in Geert's trees & I don't think I saw any
> > > > pending patches in the cover that I missed. Is there something else that
> > > > adds the support that's not going to make v6.2? I got rid of all the
> > > > dtbs_check warnings for v6.1 and I'd really like to keep things that
> > > > way!
> > > >
> > > Sorry that pacth wasn't posted yet so I hadn't mentioned it in the
> > > cover letter. I'll make sure I get it posted asap and merged for v6.2.

> > BTW on the riscv patchwork I see status as fail "Patch does not apply
> > to for-next" does that mean I need to resend re-basing on your tree?
>
> Nah, I though that Geert would be applying this patchset, no?
> If that's the case, it only needs to apply to his tree.
>
> Geert, are you waiting for an ack from Palmer?

I can take:
  - [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
Renesas RZ/Five SoC
  - [PATCH v5 5/7] riscv: dts: renesas: Add minimal DTS for Renesas
RZ/Five SMARC EVK
  - [PATCH v5 6/7] MAINTAINERS: Add entry for Renesas RISC-V
(4/7 and 5/7 depend on my renesas-arm-dt-for-v6.2 branch) and funnel
them to the SoC-people.

I can take
  - [PATCH v5 3/7] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
  - [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
with an ack from Palmer.

The rest
  - [PATCH v5 1/7] dt-bindings: riscv: Sort the CPU core list alphabetically
  - [PATCH v5 2/7] dt-bindings: riscv: Add Andes AX45MP core to the list
should probably go through the riscv tree, to avoid merge conflicts
when support for other SoCs is added?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
