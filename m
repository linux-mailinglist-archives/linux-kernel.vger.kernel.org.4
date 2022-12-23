Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD2654BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiLWELF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLWEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:10:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE2C5F9C;
        Thu, 22 Dec 2022 20:10:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r26so387979edc.5;
        Thu, 22 Dec 2022 20:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DDJIRU2drmES57oYUNlv6w2Z7XNzbYJ4ME3pRqcx8ks=;
        b=M/aAcfuN+KqkaGqL5MOJrERhTOfdIgOkRefh7fbtU/vjIYnQUHMPxL/VQcUu923rzP
         clZT3pPnGZnbCBrKnfoNVQxoCCrqMgE1CF+pmKF5WLIZ4ZbrUgamzR6+AElGLiGmKa1V
         VVpOzdeNYEyn166M1lKrlfbE9NEM1nn1Lcq5ZlsOuJTgWMUDSNUncK5T4mPZCAUqFOEb
         4hsawg1wzyeIh5+aszdZ2+zcykbYaO+4+XRmMTHmiFP43AfzePG5qat7ex36Q/akE8Gx
         0bKLOsprGfnsOCe2f7AJjCtGFt9PTa/cAil+5VSBXc0JNkleBiXp117rY7ABHmoJnbTG
         kMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDJIRU2drmES57oYUNlv6w2Z7XNzbYJ4ME3pRqcx8ks=;
        b=bY1P2lwyBc3K/QUJ5pmRmC/aTQCsjOE1hzw2zKaDVM+6oIIzrTaEyejXp/DirV/OOD
         wPA6XDI8w/mjG2dJ8gbPQOzhAXfYYZJpukqIvKL2qeYr5DK7KTrmYcSATrQ65DDlcbYK
         juUMlTm4OHoRR/f/Zwre7bM9TJNCm7lyYY4iv/kf7L25FaRNfATpU8IVNq1DN5PIH12+
         g3p5BUUKUA0tZt7j7Mef6Wc0zI+NS+BJdxYCAA4Ksvicfv1RKw7P2RnF5ecQezrdEgv6
         lgG0Nb2KMemrTP658ZWBdFQz8jL60qOqz5XZy1IokVDV1TTltXzlmnvvkkfPc1uCzlNL
         wvdA==
X-Gm-Message-State: AFqh2kp57nIcDrI2Q96iWG/7kypedkCs22PH0wKQ0LV7Xmm3aonnzXYI
        pw2av/cMIMf+QtmGxEqbAvqZNPrIqsVtW1N26KI=
X-Google-Smtp-Source: AMrXdXvgXvdfvnweasilwTRfhGfNgSEbDOVlCERqKczxj805dUqByh38/Cs9Oc1qUdjeAW1NFwFwqpUdb0yCWvkDowg=
X-Received: by 2002:aa7:da42:0:b0:46c:226e:6ec8 with SMTP id
 w2-20020aa7da42000000b0046c226e6ec8mr762046eds.319.1671768656910; Thu, 22 Dec
 2022 20:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 23 Dec 2022 04:10:17 +0000
Message-ID: <CA+V-a8urku9J3dre00PCDGBSFmFKeNpcZ4ST3bcRuJGFj8f87w@mail.gmail.com>
Subject: Re: [RFC PATCH] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sun, Dec 11, 2022 at 9:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Having a clocksource_arch_init() callback always sets vdso_clock_mode to
> VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
> required for the riscv-timer.
>
> This works for platforms where just riscv-timer clocksource is present.
> On platforms where other clock sources are available we want them to
> register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.
>
> On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
> avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
> move setting of vdso_clock_mode in the riscv-timer driver instead of doing
> this in clocksource_arch_init() callback as done similarly for ARM/64
> architecture.
>
> [0] drivers/clocksource/renesas-ostm.c
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/Kconfig                | 1 -
>  arch/riscv/kernel/time.c          | 9 ---------
>  drivers/clocksource/timer-riscv.c | 7 +++++++
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
Gentle ping for review.

Cheers,
Prabhakar
