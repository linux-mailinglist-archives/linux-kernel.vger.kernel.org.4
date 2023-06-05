Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D57221CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFEJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEJOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:14:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE7D2;
        Mon,  5 Jun 2023 02:14:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75d461fde66so171900285a.1;
        Mon, 05 Jun 2023 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685956473; x=1688548473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE0xssBXcK9nZ+e8wfDpCxReNmG+e30YEh+xZMobuHQ=;
        b=PIAoC/LhkYM27nDo4SJJQNhcXu9rNI7W+He0InIiRvpP6PNh+TDH0z4fD881+7/isH
         KAAjqxuWkn3poO5jCFCS3L5KEZwcXXjiRoXVJ23LmiX2Yf1UljB1Eg5MmjqDHEbTwKRX
         bOhUFeBDWeIqMYjlM18TqumVEaAqWmgh3m1cYt0J3gnVtvDxw0z8LJF0Nhq7+eufHVWv
         B5i7i6eHHyzO5lsRKE1+ILa2n5IaCJW/Sk8vBAdk9v6hcljHeOrHSG7eLoPjelaFNmfb
         YQhfC6xgY/BZaoQKSGTR9bPxSwQqlHbE3hE9zpyX49DjOLUg3O9o+LbxJCCRqs+J96sD
         GUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685956473; x=1688548473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE0xssBXcK9nZ+e8wfDpCxReNmG+e30YEh+xZMobuHQ=;
        b=RItnRttZ+xrPvXRRzySsx9DFA1IfZ7r+0wrTGETj+v47+BXQ08Fm20ukMHueFCveZX
         M1YJh4rRlzZSbYJp90cGvbHkW6C1PygbCXHuMUHLsF7dtfe7Ewe1sEvaaChCeRWQemo4
         ZkFVnim13zJQ+mAnxr69/UPrwXBPqobcaGE6ceeGxtlI1PedLHOR5zKQTh9pB29j/1Nt
         neh7qBNgeITkhz6zX+lD3W+hid/wuHu85XyLjlhlKbYS9xcoXORmvFdbPMjsevstIBrf
         /4K8DcYxqNl1+1uXWC88gm49vfK7eevdDeWLHHqUacuFpIVOA1spwBipLTvRDrNm0KV8
         V7MQ==
X-Gm-Message-State: AC+VfDwYdu15ycBmLMQYyNhiNauZX2z/h4a5Vm3Glwu139FkT/8rs4aV
        Cs1IsLQtHzVj4lTISEO+3Xa2YeMaRIutRAzoZhWwWclavU8=
X-Google-Smtp-Source: ACHHUZ44ZC3HtizNbif0Pd3vZlP2LsWIeHXWBfYc4IZjIR0M7aQKnZ0bfR9VTq7NXsjtd03zjdTQCpOVOBIRqPK97Yw=
X-Received: by 2002:a05:620a:8b87:b0:75b:23a0:e7a0 with SMTP id
 qx7-20020a05620a8b8700b0075b23a0e7a0mr18512831qkn.1.1685956473319; Mon, 05
 Jun 2023 02:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230605014850.9591-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230605014850.9591-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jun 2023 12:13:57 +0300
Message-ID: <CAHp75VdZct58EiLDL0ebCvcQBVMzuZxJZ8z=bs8D2UDaCsuo9A@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sifive: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 4:49=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.cn=
> wrote:
>
> Add the missing check for platform_get_irq() and return error code
> if it fails.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: f52d6d8b43e5 ("gpio: sifive: To get gpio irq offset from device tr=
ee data")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
>
> v2 -> v3:
>
> 1. Check before assigning values.
>
> v1 -> v2:
>
> 1. Return "girq->parents[0]" instead of "-ENODEV".
> ---
>  drivers/gpio/gpio-sifive.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 98939cd4a71e..745e5f67254e 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -221,8 +221,12 @@ static int sifive_gpio_probe(struct platform_device =
*pdev)
>                 return -ENODEV;
>         }
>
> -       for (i =3D 0; i < ngpio; i++)
> -               chip->irq_number[i] =3D platform_get_irq(pdev, i);
> +       for (i =3D 0; i < ngpio; i++) {
> +               ret =3D platform_get_irq(pdev, i);
> +               if (ret < 0)
> +                       return ret;
> +               chip->irq_number[i] =3D ret;
> +       }
>
>         ret =3D bgpio_init(&chip->gc, dev, 4,
>                          chip->base + SIFIVE_GPIO_INPUT_VAL,
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko
