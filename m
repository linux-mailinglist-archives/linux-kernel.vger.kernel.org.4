Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BE610FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJ1LcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJ1Lbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:31:50 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6B1C69E0;
        Fri, 28 Oct 2022 04:31:49 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id t16so3828548qvm.9;
        Fri, 28 Oct 2022 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n41bBGLdctrsHUVRRarV2Di1E8TbeCdMm8nLJHc7p30=;
        b=QdGnf8Al3r4Bxds/vIGbVNyxKW6/OFkLKLmux5FZyqjR6NpUOVHYCMoWSFoU17LsfV
         6ZjVdha7Zujjv5QvTfA0nEL9UZUf/FD4zjeGfqCKyVOym41XHOWPfssRbudosVTjTp1e
         WBw1D+++gWPpeTZJNl7BzA0lT2ZxDzbZxLp+F6riUFjPtnj3HolfLNTMwjGNSxKUxM8C
         UhUfSPx6VIo1MZavoTEEEFmOHJCEPObyK4Rp6JBX/XkO+tdUbF+gC0+NokUB4SfFW/WT
         GAOUbqZxVnMYL/wvAhVID0qwAjCVHkmsx+kxk7fy//h7HnF7wKDXaCKVvkPQGrAeBPZl
         oysg==
X-Gm-Message-State: ACrzQf0ATg1EMZRNDzFNGDh1MEOkstTGbyM7pxWyc4izRTQ/gEL1IbT2
        gMI55ymC/6EsSVjiyWTZACxk7Emf/YH1/Q==
X-Google-Smtp-Source: AMsMyM4fyvVF185S17OIHzIY0izCtaxCEfc0idtMPWjWFjp2S1zCGB+A0XTJLS73cjE03fLhwUbARQ==
X-Received: by 2002:a05:6214:4005:b0:4bb:9c0f:bcaa with SMTP id kd5-20020a056214400500b004bb9c0fbcaamr9298285qvb.42.1666956708553;
        Fri, 28 Oct 2022 04:31:48 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006f926a0572asm2817476qkp.27.2022.10.28.04.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:31:47 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-35befab86a4so44417907b3.8;
        Fri, 28 Oct 2022 04:31:47 -0700 (PDT)
X-Received: by 2002:a81:3d2:0:b0:36b:6772:75a3 with SMTP id
 201-20020a8103d2000000b0036b677275a3mr29799990ywd.383.1666956706935; Fri, 28
 Oct 2022 04:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221025220629.79321-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221025220629.79321-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221025220629.79321-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 13:31:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-OXF3hG2im4SNsFsLXES84PVKkOxo5gRAi1dD7V6BnQ@mail.gmail.com>
Message-ID: <CAMuHMdW-OXF3hG2im4SNsFsLXES84PVKkOxo5gRAi1dD7V6BnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: renesas: r9a07g043: Introduce
 SOC_PERIPHERAL_IRQ() macro to specify interrupt property
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, Oct 26, 2022 at 12:06 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce SOC_PERIPHERAL_IRQ() macro to specify interrupt property so
> that we can share the common parts of the SoC DTSI with the RZ/Five
> (RISC-V) SoC and the RZ/G2UL (ARM64) SoC.
>
> This patch adds a new file r9a07g043u.dtsi to separate out RZ/G2UL
> (ARM64) SoC specific parts. No functional changes (same DTB).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> rfc -> v2
> * Changed the SOC_PERIPHERAL_IRQ() macro to just accept IRQ number

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
