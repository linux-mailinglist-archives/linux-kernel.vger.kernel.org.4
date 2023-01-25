Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAC67B19E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjAYLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjAYLiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:38:25 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112EE5618E;
        Wed, 25 Jan 2023 03:37:55 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id m12so13866102qvt.9;
        Wed, 25 Jan 2023 03:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/t7ys6E2CbYDYuVcXfgtBpZgdyeb4IZ4cqbwkss4Uo=;
        b=UZBvsy//01TZAyy8XetTeHupyQ0DKpMhFBtSMsATvkYgH2X/0Mo1rjz5UmMCCx1g+d
         BRa83TsBJkJo7HBuNt5w8OaKLRJEgqnq9V0tb6bFqZXCa93/Gjj1xK9s9NuLesGjNywL
         SNUVk9MGOCFurN/H3JUhNKq2uo8FQmM5MBpXwxlO829K5xkXt45MrMQe4MSJnmkaC0Km
         lMfZP4h8kmeqv+Wc4L0k4gNm1ssNCfDGWe32HW/8AYIudLjoRNgtL0FKZBcgcaeoalFd
         8/vGl+qkZCfxRB5d8NQOduFhEbu17noPcITdEs2GNCDruarJk4iUVpSsgF9qJJQEL49X
         Dkyg==
X-Gm-Message-State: AO0yUKUCxF53zUrkAkStATOr06XGhjEIVu3Wqfu9auCH0Qtsd6f0EaoK
        oNOHcH8WH/WIOyg/mf95J47Qr25SNSyirg==
X-Google-Smtp-Source: AK7set9OF5JhON/JLlyY5FFbCkQZmy+rqSEs2v5J2i1sSCZoOgt+xUwTy+lwrQrqGwC3KYROOsz3NQ==
X-Received: by 2002:a0c:f441:0:b0:537:7057:49cf with SMTP id h1-20020a0cf441000000b00537705749cfmr5215902qvm.37.1674646630205;
        Wed, 25 Jan 2023 03:37:10 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i65-20020a37b844000000b006fec1c0754csm3329969qkf.87.2023.01.25.03.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:37:09 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id p141so19819238ybg.12;
        Wed, 25 Jan 2023 03:37:09 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr2485292ybo.543.1674646629124; Wed, 25
 Jan 2023 03:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 12:36:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXeEXgMYgFq_nTRmco7P7TFSMKcRoQxcL-hKECn+_5FGw@mail.gmail.com>
Message-ID: <CAMuHMdXeEXgMYgFq_nTRmco7P7TFSMKcRoQxcL-hKECn+_5FGw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: renesas: r9a07g043[u]: Update pinctrl
 node to handle GPIO interrupts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Mon, Jan 2, 2023 at 11:19 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add required properties in pinctrl node to handle GPIO interrupts.
>
> Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
> is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
> continues without waiting for IRQC to probe.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 -> v3
> * No change

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
