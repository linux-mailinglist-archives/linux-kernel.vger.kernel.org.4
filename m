Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80F726011
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjFGMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbjFGMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:51:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656562694
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:50:56 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6260e8a1424so49078066d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686142255; x=1688734255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPvqIHpEWG/UkEkGmT422Sfo2Ynh7GRgq6Y26ChbDlA=;
        b=4kBz506/8MB4xFVCYlvghi2sLhXN7CMMAvhBv8C67FBAyp0hTfK2lmTP7F1wSgr8VX
         Mvt73HFmrBJ0mqZPFDxcsNratddwpPZyJEeKGgxgdgQInBxOr0QfOw276vyDu0b6zyLw
         ESj0vFFvCve4S8lfzECEhGt/Ij9uBifYY4P7L2EkPHwORPhAKbJ/lrSUQD2H+S86XcT4
         oMpqw8sQWC9aNwgFzFwgnHc9lP2uz+5AqvyXfMki50tJJphQtTJhk5QLLOC7ykFXKXVN
         jTEnoTMDiwf6GziG0BXO3LqOxM/N4DiTBueZvQb+3535RttO1m+fjzhh/88/NslBRSVP
         fjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142255; x=1688734255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPvqIHpEWG/UkEkGmT422Sfo2Ynh7GRgq6Y26ChbDlA=;
        b=K0bmiWCmkcT8XBA38S+J9KlQje8D3Nypc+1HzBct2LR4pdtuQWblXViU3aFK7XDv+H
         JSB2Da1n8AO9XoBMEVoPEy+rBFlT6FOfB/71ZLpk6tY95AkqR8DfW9ft5vFErRWJ346f
         Qbm58CZDhGZfTkYj+8FnrIMz8Q/uEVOdjGbG5xD/17O2RflWlMEYOLy5dij8x19nYF2I
         +NuzKNt2SXAXuIb9GpZ3i7zxTNaatvQ5FzmW0cAINkr/kM+ZL50z8O2lXbKrM8AN9juo
         zduBhsherwWF/jny05u6rZRFZTyLjEU2haSndKg/Ebj4qogcxpY3BxPn7Rl5pH46Pvrz
         oxpQ==
X-Gm-Message-State: AC+VfDzBI5Cww44VfFKYvqrPZ+A2rVQt6oe7DVikB99qBDCNZwZH3qQN
        pl/Ns9X18yCaMHg2JZ/X8VXlM9RxCp4cjLn5yxa36kmqcSKIANd6
X-Google-Smtp-Source: ACHHUZ6ZgJ5W0sKcnYzJrSVT0fhE6NX3UJDk/RAoItK9WocbEfey/AnLtkXUtEkprxlBVt+nReZ3b+v2Vy1yQwofWI0=
X-Received: by 2002:ad4:5e8b:0:b0:626:29d4:9a09 with SMTP id
 jl11-20020ad45e8b000000b0062629d49a09mr3107604qvb.53.1686142254701; Wed, 07
 Jun 2023 05:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607065004.37112-1-warthog618@gmail.com>
In-Reply-To: <20230607065004.37112-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 7 Jun 2023 14:50:43 +0200
Message-ID: <CAMRc=Mf9K=_a=UzmazHF1Qc7XxWfP_qJH2gftPAT0Y=e_3FtyQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: quietly ignore configured lines outside the bank
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 8:50=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> The user-space policy of the gpio-sim is that configuration for lines
> with offsets outside the bounds of the corresponding bank is ignored,
> but gpio-sim is still using that configuration when constructing the
> sim.  In the case of named lines this results in temporarily allocating
> space for names that are not used, and for hogs results in errors being
> logged when the gpio-sim attempts to register the out of range hog with
> gpiolib:
>
> gpiochip_machine_hog: unable to get GPIO desc: -22
>
> Add checks to filter out any line configuration outside the bounds
> of the bank when constructing the sim.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> This is based on for-next patched with my recent memory corruption fix,
> as it touches a bit of the same code.
>
> Cheers,
> Kent.
>
>  drivers/gpio/gpio-sim.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index fab67a5785d7..8b49b0abacd5 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -696,6 +696,9 @@ static char **gpio_sim_make_line_names(struct gpio_si=
m_bank *bank,
>         char **line_names;
>
>         list_for_each_entry(line, &bank->line_list, siblings) {
> +               if (line->offset >=3D bank->num_lines)
> +                       continue;
> +
>                 if (line->name) {
>                         if (line->offset > max_offset)
>                                 max_offset =3D line->offset;
> @@ -722,6 +725,9 @@ static char **gpio_sim_make_line_names(struct gpio_si=
m_bank *bank,
>                 return ERR_PTR(-ENOMEM);
>
>         list_for_each_entry(line, &bank->line_list, siblings) {
> +               if (line->offset >=3D bank->num_lines)
> +                       continue;
> +
>                 if (line->name && (line->offset <=3D max_offset))
>                         line_names[line->offset] =3D line->name;
>         }
> @@ -756,6 +762,9 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *=
dev)
>
>         list_for_each_entry(bank, &dev->bank_list, siblings) {
>                 list_for_each_entry(line, &bank->line_list, siblings) {
> +                       if (line->offset >=3D bank->num_lines)
> +                               continue;
> +
>                         if (line->hog)
>                                 num_hogs++;
>                 }
> @@ -771,6 +780,9 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *=
dev)
>
>         list_for_each_entry(bank, &dev->bank_list, siblings) {
>                 list_for_each_entry(line, &bank->line_list, siblings) {
> +                       if (line->offset >=3D bank->num_lines)
> +                               continue;
> +
>                         if (!line->hog)
>                                 continue;
>
>
> base-commit: ba65c79fbb813423e7d42d99375e2045b27958a6
> prerequisite-patch-id: d89da2e3b7511c5b8132a379b12e4996256ac214
> --
> 2.40.1
>

I queued this for fixes, thanks!

Bart
