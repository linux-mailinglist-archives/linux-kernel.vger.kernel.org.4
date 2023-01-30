Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0994B6809FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjA3JyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjA3JyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:54:00 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B12D15E;
        Mon, 30 Jan 2023 01:53:51 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w11so3743260qtc.3;
        Mon, 30 Jan 2023 01:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W5rVZ1fIbyJmvcTi+8Jg6ecbdKjIlcZKlLQLo2bEEY=;
        b=SvS9A8u0hocclY40IlK/LyJP7UeC5cEJGlZ8+DoyG6C+V0/OisIhUOU0UQveXWEapg
         cwZWXDJk52wZU40gIiCGIKBCKPKNRZsJOPhWpVHcwRGYOQw0GttQEYYKbRPQxjf1Snf5
         TREKmt3bUK+3Skgdnifb8pEZV+uhLoTPxDXL1e3mKvTkuuYyal8Ldu9s55eYvjxJLMC4
         bcZJPT94Drnzs/9abWeEM1w0n/8DRTaL256zb9Fp/ry25jDAj+z3Np8WhD9bzYhQ8PkR
         t1p5grUAQAXxoOwVc0uHHfP4sHSDKiacRrLouLjwR7QD/1LairHOA8CaWe0f7bUCfSW1
         DZTA==
X-Gm-Message-State: AFqh2kqIGQrYsy5Sn8j6b4ATzP1t02X0NaaRyeKjnWoe7m5RR8j6RJe5
        TZL/cayXRz7ZihgctLbqBhx5InEnIRbiLA==
X-Google-Smtp-Source: AMrXdXvEIQYftVQX71l5HsqSrf20Ayxi91rs58yA+8bIgN1QHKlw6BEUvCCJyvLKzjM6DBaUIe2H6g==
X-Received: by 2002:a05:622a:1e1b:b0:3b4:a6af:a2f2 with SMTP id br27-20020a05622a1e1b00b003b4a6afa2f2mr65834183qtb.34.1675072429935;
        Mon, 30 Jan 2023 01:53:49 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05620a318700b006e42a8e9f9bsm7816210qkb.121.2023.01.30.01.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 01:53:49 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 123so13270853ybv.6;
        Mon, 30 Jan 2023 01:53:48 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr3784853ybo.543.1675072428751; Mon, 30
 Jan 2023 01:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
In-Reply-To: <20230130093229.27489-3-nylon.chen@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 10:53:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiKAyUeZvmAsNfjJ7_x9bK1zO3iUPdcQ7-60tLQOx_cg@mail.gmail.com>
Message-ID: <CAMuHMdXiKAyUeZvmAsNfjJ7_x9bK1zO3iUPdcQ7-60tLQOx_cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nylon,

On Mon, Jan 30, 2023 at 10:32 AM Nylon Chen <nylon.chen@sifive.com> wrote:
> The `frac` variable represents the pulse inactive time, and the result of
> this algorithm is the pulse active time. Therefore, we must reverse the
> result.
>
> The reference is SiFive FU740-C000 Manual[0].
>
> [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

Thanks for your patch!

> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
>         /* The hardware cannot generate a 100% duty cycle */
>         frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +       frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;

Shouldn't the inversion be done before the hardware limitation fixup?

>
>         mutex_lock(&ddata->lock);
>         if (state->period != ddata->approx_period) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
