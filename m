Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8C6E8EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjDTKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjDTKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:04:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E26A19AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:04:42 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0655F3F32E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681985080;
        bh=MPSX/AfZygcMhOCNuxX1ZecGolc5hbcZ2NhciybSDRM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b6v/jqmA6ujYWkGJoyz6sY7E2xd9+810N4cyaOlOReZ/QBOnWRDLRSdYgE/Td26hL
         aSyFx1T5kmV7XDKlK3w8O/bAt/VGft8A9gM6euaY2O5k3cXq+zQkqDonsv6pGebYTx
         xNP8YYZk4MRr07mmmYUynHSnIziIH6av3NRg5QxkPJRnTvZ2rOAq4tlO7kYvUnPl7y
         m0ApYR7OdwJ+8pywj7+WozFoQee6GE3Q3lsb0Tfh4RLdbbGJeeGq41tf7JTm/Nsy1V
         T0ixv/5VgWr4g8V2GWygmcqyuimp9ipPfTiK1xwvnmLC724rxa+T349v462sCkDjxx
         mVfWF9whStzSA==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74e0e819d7fso32957285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985079; x=1684577079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPSX/AfZygcMhOCNuxX1ZecGolc5hbcZ2NhciybSDRM=;
        b=A0Q2yWmIZU3WOhP2yU1KlQaSL/XQQQ7vS1nmFJygxmJnt/BTtb6GdOvnBT4yEYsqHc
         BywmltUYnU84CoCoVo4JkxKCBjeerLrLdD8s1I7swC30ex+p/c6sF5CC/+JYijS/jW0g
         UHH08puKFInA3SZ/ajZNLEpq+CuiYL39mUPzTC6sgFrtBxNs+KOIKpkX19ZCP4kLcqJF
         zGmoDz7oTl2GHVa6doEeAAYujZsZTKeYrYxoYNnMv17aVVcJD0xATrpAKj01sMXVp19E
         mhwulbHPVdcxcrYQyv89svhx6Uf0R+h23QyYBDUmJdRTGbPymtrrXuyt36sUfVcGqnuw
         dpvQ==
X-Gm-Message-State: AAQBX9eYPJRYwrIEAhkZdHnKJXvSbJAiZdit3V41dsvbxmwiRv/ojIV2
        9M3s9EAHXFCMpjizlrvr/ooSq2a7qGDbrUn08TIsOzihmOpt0zVMNYyzabDyqL2BgrwHagZOd7/
        jDFy6RaFERMd6y+uIp8X0rxl4hB1qiW5JeAI8fnU8Y5xPYbwKyafYksipAg==
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id v18-20020ac85792000000b003ef573329e4mr667764qta.64.1681985079076;
        Thu, 20 Apr 2023 03:04:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZOJhhJ2/DG8mPZrGpHZG2bUew/6AA3c59/iwkpF1lN4P7gKE74NKz6hnyMtvTbz3kA9sQrlj/oL+Xnlk50P8=
X-Received: by 2002:ac8:5792:0:b0:3ef:5733:29e4 with SMTP id
 v18-20020ac85792000000b003ef573329e4mr667740qta.64.1681985078844; Thu, 20 Apr
 2023 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420093457.18936-1-nylon.chen@sifive.com> <20230420093457.18936-3-nylon.chen@sifive.com>
In-Reply-To: <20230420093457.18936-3-nylon.chen@sifive.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 20 Apr 2023 12:04:22 +0200
Message-ID: <CAJM55Z-smXpgL+QyTSeAWt=B-RS_qtbrFZtJpP-cQS0gsQnDSw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 at 11:35, Nylon Chen <nylon.chen@sifive.com> wrote:
>
> The `frac` variable represents the pulse inactive time, and the result of
> this algorithm is the pulse active time. Therefore, we must reverse the
> result.
>
> The reference is SiFive FU740-C000 Manual[0]
>
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 393a4b97fc19..d5d5f36da297 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -132,13 +132,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>         struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
>         struct pwm_state cur_state;
> -       unsigned int duty_cycle;
> +       unsigned int duty_cycle, period;
>         unsigned long long num;
>         bool enabled;
>         int ret = 0;
>         u32 frac;
>
> -       if (state->polarity != PWM_POLARITY_INVERSED)
> +       if (state->polarity != PWM_POLARITY_NORMAL && state->polarity != PWM_POLARITY_INVERSED)
>                 return -EINVAL;
>
>         cur_state = pwm->state;
> @@ -154,10 +154,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>          * calculating the register values first and then writing them
>          * consecutively
>          */
> +       period = max(state->period, ddata->approx_period);

Hi Nylon,

I don't understand this patch. You introduce this new variable,
period, and set it here but you never seem to use it. If you planned
to use it instead of state->period below, why should it be the max of
the old period and what is requested? What happens if the consumer
wants to lower the period?

Also above you now allow both PWM_POLARITY_NORMAL and
PWM_POLARITY_INVERSED but you treat both cases the same.

/Emil

>         num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
>         frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
> -       /* The hardware cannot generate a 100% duty cycle */
>         frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +       /* The hardware cannot generate a 100% duty cycle */
> +       frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> +
>
>         mutex_lock(&ddata->lock);
>         if (state->period != ddata->approx_period) {
> --
> 2.40.0
>
