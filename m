Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9A67B2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjAYND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:03:23 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FA32517;
        Wed, 25 Jan 2023 05:03:22 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id s66so16149634oib.7;
        Wed, 25 Jan 2023 05:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IsTVqB/pcPCh7jFJPHGPuaVWAVoNerPG3I9d0JHPnA=;
        b=m01hYGWVW2kp1jbQlXzvLFodqjunuo+iSk/2MfS0grzI+g/0ppQjBQv8dlj8m1Uqig
         8TilW5ASnjTDBq4fzZglRBhqZHYtDKm/FsxSFLcJeOHbuDk54jHS+DI6SI7aBDcAysLt
         ADzqlgSP5cAJpyzQHW+39kHoYJWnUyrWjV0LB27SJY931KUk8T0YSI9ynxQzdlBM4/6D
         OTS0hGF0F4GXqT6b88aWK4SJB71I2QzLbnRlTIKXHzRL0Wcw5Fg4h4cZUFIEFfmA8QX+
         Pen1Mt/yl12MgJLcTxn+0mH4C2bcWZHtFybYmdgvv1d59BB+KnQbz0ahZs3YRwbK424P
         QbvA==
X-Gm-Message-State: AFqh2krIj3J5dSpin1QsxsrAEq5QCMNqYnQLlCAyhC++nyqGkc/tK9qi
        YRsQWlmlC3wOrj84n/vzm87G76dDFGpqtQ==
X-Google-Smtp-Source: AMrXdXua2J87aMbWaDqi6lg/OySCUUJw0Je5bvO/eaErvs39xZbjLj3PsbGZkrR5L0mUAkX7R3u+iw==
X-Received: by 2002:aca:d17:0:b0:365:ce9c:edb6 with SMTP id 23-20020aca0d17000000b00365ce9cedb6mr14169059oin.30.1674651801032;
        Wed, 25 Jan 2023 05:03:21 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a166a00b00706b299d014sm3332243qko.132.2023.01.25.05.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:03:20 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id d132so1340502ybb.5;
        Wed, 25 Jan 2023 05:03:20 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr2613641ybe.365.1674651799865; Wed, 25
 Jan 2023 05:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230102221815.273719-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230102221815.273719-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 14:03:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaUE2xyP-t1fh2d1d4AVJ0Jm+-6rf3YMEx2n+MxjLRpg@mail.gmail.com>
Message-ID: <CAMuHMdXaUE2xyP-t1fh2d1d4AVJ0Jm+-6rf3YMEx2n+MxjLRpg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
> The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
> ETH1 respectively.
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
