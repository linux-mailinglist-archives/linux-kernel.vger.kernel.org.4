Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B66C8079
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCXO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjCXO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:56:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEB2101;
        Fri, 24 Mar 2023 07:56:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q88so1667989qvq.13;
        Fri, 24 Mar 2023 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfQeRAUQ1sYH8jejnGUjF6wZ1+eebaWTvxfhMe12ulE=;
        b=ck8aUFt3Tzmq6oJqHgjCskSNmgf+cW+LTMq9MZByBA0myNZF4TLzS4SU43PuChD0HO
         KdZiC7E440UaTr/+ESu4VyxySNdBVQisHkvuLYpFeZsA6AJMmIqBHYh4ct4suHNGw2dV
         9o9qswsM5ZD6muOSBP7cEO96FGZYnr1bNNdsBB50CShdXtR3KSI6jgztu8ZMQywnLH3N
         Dd5ktK+1KU8pxgEZEmqvcup0gE4UpcwYGpWktLptsOzC3xCepwbdO8i/4jB9USX/j+Wp
         McaxrGUz5MSG/sEaAkGxFjzMbqyLHxgOAgo7PfzaiFZhZphGhZt5vYEC9Vgdu6MAEyMC
         LwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfQeRAUQ1sYH8jejnGUjF6wZ1+eebaWTvxfhMe12ulE=;
        b=kFyrGsdYIpxbsaj2lG9Eviez1a8CuUHkJm1NrH32q045KqmY96uP9ggbwOK9f94FF6
         GEguvjfDRt1uxx/qBDncdIfmoZWgxwqA38y8uBKJ6+FNJG4hsox5g6c/Bmo5pU2z0HCT
         xUIezMM9FjWnmmOPhH/BfewY6cNFMxvJFyjAqSx8kIh/Pu4PCLmd41f6or7NwduddBTq
         SmCMqdVw8LtL2ZIk7nlDnzjSpAjzYlSqHQYPiblITetyccVik7XVAv5UJNG07THBi1X+
         3udGCtUm3fU5enQ2NpkCfymRicqfJ7AjQdIxi8bWPvU8oqzVfa9HBw/9F9Ko59JxOsP3
         hueg==
X-Gm-Message-State: AAQBX9ehRVjWEbMh+hGuM3gUGEajlUwGtJR406LSGwSegDUWQRyyFPvA
        IAWrnAYI8JI9lhmPfyckbL4oWnThOle+Shi7AO0=
X-Google-Smtp-Source: AKy350ZOiUboDCYVCjLTx1izxg117Yi0V+Kgoq5YpDlR/MdhajgP/uYoiUhxqb0nSpuJrfdC9gIBnAxy/HfDYWQZu0Y=
X-Received: by 2002:ad4:4f2b:0:b0:570:ffdf:c0a3 with SMTP id
 fc11-20020ad44f2b000000b00570ffdfc0a3mr437746qvb.10.1679669772932; Fri, 24
 Mar 2023 07:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230324143626.16336-1-clin@suse.com> <20230324143626.16336-6-clin@suse.com>
In-Reply-To: <20230324143626.16336-6-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Mar 2023 16:55:36 +0200
Message-ID: <CAHp75Vc5SiB7HCdMmigAJOWyqr50s_Urny0XSN61hyx=u5JzjQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:38=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> The .data field in struct of_device_id is used as a const member so it's
> inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> because some members in s32_pinctrl_soc_info need to be filled by
> pinctrl-s32cc at runtime.
>
> For this reason, struct s32_pinctrl_soc_info must be allocated in
> pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> to represent const .data in of_device_id. To combine these two structures=
,
> a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.
>
> Besides, use of_device_get_match_data() instead of of_match_device() sinc=
e
> the driver only needs to retrieve the .data from of_device_id.

...

>                 .compatible =3D "nxp,s32g2-siul2-pinctrl",
> -               .data =3D (void *) &s32_pinctrl_info,
> +               .data =3D (void *) &s32_pinctrl_data,

Do you need casting now?

--=20
With Best Regards,
Andy Shevchenko
