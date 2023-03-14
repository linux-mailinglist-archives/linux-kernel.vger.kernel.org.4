Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F166B9CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjCNRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCNRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:16:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA934A2C3E;
        Tue, 14 Mar 2023 10:16:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t13so2482564qkt.6;
        Tue, 14 Mar 2023 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678814185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pgNBQ0CdsqilURKg8GAjZGRO00fDHxLxxQxejhC4bs=;
        b=ZDUhkxabj9Bs9sEDJCZTcg2JxZjqCQWoPisiolIDfF3zMRcdXjSgxniZL9R3QrBMjo
         BM0q6gQF1+hwECLLxyURp9weXDwpR665sMsrZn74QjbQGovDJgVimCfdg2VDTqU9Ams2
         7bHrdwLzv8tHxfEeAF3zak1cYENgJoFB+ejqjCYSzHJKoaIqYab2uCbGPrmLpDaw3JgP
         7MRp/nsIMUhyy7zPvDe6BDhzZmISVOe0YO0mHCpUuN9C4aOklQU14DY2XquFLUIvZdkt
         3ghhJmact+KJPY/W5jj6bL4VHStlJG04kF66gU/NeM40yDsH+N48oa4pidkZPKkyMOWg
         SIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678814185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pgNBQ0CdsqilURKg8GAjZGRO00fDHxLxxQxejhC4bs=;
        b=iXQj0eH2l14XXRnSH9VCLzNSdZrDu2jma531MQKO5/0zZBUqP9PswVeGGmXWdEBfFT
         gD3lvmzJyjO8M5IHv1ALLvzVdrh9VigW1iSVUoPCnvSync5+H6MUzhduck3y142SLa5O
         07TwOgMaXvm/tLNAg3b86gwpomGfVgm+O548q/3OY5TEURp+axITWsx0rXY2+DYPtrtf
         fW6yDZPW2CZS3o63t8FsqidLH4xF/+Ml0IdH6gADDB12ys2QMp87MrifnwYclFnnYwXl
         zHWlp0A0ij8WZ3KuIQZipH9OspoFgQdxUFv0YVlIMyvppBNGvBKHdGZ8CzxGwUah1KQL
         0nBQ==
X-Gm-Message-State: AO0yUKV6YkvhmqgTCiioG0b/by8cOTrX8dy3bMyBqOKFEsFgSnM2Yifv
        kJ8daVV59w99otYjPxrw3rvzdh7saWwWU7rxNvo=
X-Google-Smtp-Source: AK7set880G3n0k1DgxMZ58IjruNgznef4Zkz2IBY5tpKY1R9EANbhajSwOKIGKCZvlnlP8I6hR0e34C7FeaZZA09CV8=
X-Received: by 2002:a05:620a:1011:b0:745:a78b:b32 with SMTP id
 z17-20020a05620a101100b00745a78b0b32mr1562957qkj.14.1678814184813; Tue, 14
 Mar 2023 10:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230314134642.21535-1-clin@suse.com> <20230314134642.21535-3-clin@suse.com>
In-Reply-To: <20230314134642.21535-3-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 19:15:48 +0200
Message-ID: <CAHp75VcTLjtkKx46fye_NCtHG4ofYPtnA1RTjE0m_PDXPJKa5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: s32cc: refactor pin config parsing
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 3:47=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Move common codes into smaller inline functions and remove some argument
> handlings that are not actually used by either S32 MSCR register or gener=
ic
> config params.

...

> +#define S32_CFG_SET            true
> +#define S32_CFG_CLR            false

Have no value, use boolean values directly.

...

> +static inline void s32_pin_config(unsigned int *mask, unsigned int *conf=
ig,
> +                                 unsigned int bits, bool set)
> +{
> +       if (set)
> +               *config |=3D bits;
> +       else
> +               *config &=3D ~bits;
> +       *mask |=3D bits;
> +}
> +
> +static inline void s32_pull_enable(enum pin_config_param param,
> +                                  unsigned int *mask, unsigned int *conf=
ig)
> +{

> +

Unneeded blank line

> +       if (param =3D=3D PIN_CONFIG_BIAS_PULL_UP) {
> +               s32_pin_config(mask, config, S32_MSCR_PUS | S32_MSCR_PUE,
> +                              S32_CFG_SET);
> +       } else if (param =3D=3D PIN_CONFIG_BIAS_PULL_DOWN) {
> +               *config &=3D ~S32_MSCR_PUS;
> +               *config |=3D S32_MSCR_PUE;
> +               *mask |=3D S32_MSCR_PUS | S32_MSCR_PUE;
> +       }

This looks intransparent.

Just use your common sense and write it without that s32_pin_config() helpe=
r.

> +}
> +
> +static inline void s32_pull_disable(unsigned int *mask, unsigned int *co=
nfig)
> +{
> +       s32_pin_config(mask, config, S32_MSCR_PUS | S32_MSCR_PUE, S32_CFG=
_CLR);
> +}

This should go with above together, just use switch and make the
configuration based on it.
Before the switch-case, clear what has to be cleared for all cases
(some cases may override some bits afterwards), set what has to be set
for all cases (some cases may override some bits afterwards) and
adjust.

Look into pinctrl-intel.c for the rough example.

--=20
With Best Regards,
Andy Shevchenko
