Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C146C1D75
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCTRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjCTRMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:12:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00439166EF;
        Mon, 20 Mar 2023 10:08:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id n137so2700880qka.2;
        Mon, 20 Mar 2023 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AepsGBccX9mINdUkfGRdzcenTLlU1Ril1Gh2fpnkMg0=;
        b=fAfKe7Vqb1FSh4UEg5a/gKNMBekTnHlqMEJCkihj04eho0zDryoWYgh0wkexgxHQxe
         qfhhmgFPtcN30oIbc7F2Qrp9me1iuMjwdZmuQqMh0FiSldmZpEXklhrxS6IHCOh1Psce
         ajJS7Svb8yaPaXCFr5e4wGFAHCjdWQNmnEa03di4g64bxa19cbI9u1rnT+Sam9BPK1ql
         YviKHgrfMIJQuNQ0R/UzIsEeEU35t0Ej95nqzg9ZsKcahG5cjCraCiS/r8LB+GozZYBL
         O8PckzAghjfOhMBDbOadUz57BkW1kkwh9XsmZP5/ExN9jvBiE8dzCu98tKGlamQoWosG
         bbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AepsGBccX9mINdUkfGRdzcenTLlU1Ril1Gh2fpnkMg0=;
        b=FGkZxu0OnbOm7hBiWRdtZEWKs6kP/de6PqIBbrV4NlFqf3XEyadx8ja05S4pEGmkS2
         le7K9zvSHqU+4evHwuSbQM6vBmW9v3D2+lEokTtlb7/lehlOSXjIN3yuDHIudnPaqDpW
         n0RODLg4SbjeSMv+N8Kzd5+bERpw9DabwGHeTi1/PuTnbBWmaJrQhVOto/QZCgEvYEpF
         b1SNK1q0lBFHCYe9Xmxw3WPn9vEhqSpCwEER87rsP/XzBD3JJwqjIlEP1E43L2aRzvqd
         xN/4zLT1BkBU7u1sk3lwvXW2h9mUDkEYXy4IK/eGb/SIl6o8hRKwONn1HIQUYevIFs7T
         5baQ==
X-Gm-Message-State: AO0yUKU/6PKeA9tpvSZU5JjDt0LadC6MiJhogp4vmI/W+ZcwbjUM/CV4
        50aw+e0ER/lxNo0WIPJvN7oTGX3BBh8s37GTEYc=
X-Google-Smtp-Source: AK7set/VLUdZCUFndV2EqHu0vpvo6KAef3BaP+uvhIakI+PE+Igi7J758Ej2GPOAsREC67Oqj4lmF8ff/DI0a8K+lW4=
X-Received: by 2002:a05:620a:1389:b0:743:9b78:d97e with SMTP id
 k9-20020a05620a138900b007439b78d97emr8387202qki.14.1679332049650; Mon, 20 Mar
 2023 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230320163823.886-1-clin@suse.com> <20230320163823.886-4-clin@suse.com>
In-Reply-To: <20230320163823.886-4-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 19:06:53 +0200
Message-ID: <CAHp75Ve325yfz1P4=vYndUOhV-VkqNCWVEObm1RURbKHgcLKrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: s32cc: refactor pin config parsing
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

On Mon, Mar 20, 2023 at 6:39=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Move common codes into smaller inline functions and remove some argument
> handlings that are not actually used by either S32 MSCR register or gener=
ic
> config params.

...

>         case PIN_CONFIG_OUTPUT_ENABLE:
> -               if (arg)
> -                       *config |=3D S32_MSCR_OBE;
> -               else
> -                       *config &=3D ~S32_MSCR_OBE;
> +               *config |=3D S32_MSCR_OBE;
>                 *mask |=3D S32_MSCR_OBE;
>                 break;
>         case PIN_CONFIG_INPUT_ENABLE:
> -               if (arg)
> -                       *config |=3D S32_MSCR_IBE;
> -               else
> -                       *config &=3D ~S32_MSCR_IBE;
> +               *config |=3D S32_MSCR_IBE;
>                 *mask |=3D S32_MSCR_IBE;
>                 break;

Isn't it a regression here?
Otherwise needs an explicit explanation in the commit message on
what's going on here and why it's not a regression.

...

>         case PIN_CONFIG_BIAS_DISABLE:
> -               *config &=3D ~(S32_MSCR_PUS | S32_MSCR_PUE);
> -               *mask |=3D S32_MSCR_PUS | S32_MSCR_PUE;
> +               s32_pin_set_pull(param, mask, config);
>                 break;

This now can be unified with PU and PD cases above.

--=20
With Best Regards,
Andy Shevchenko
