Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D402717461
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjEaD3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjEaD2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:28:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D5185;
        Tue, 30 May 2023 20:27:58 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62606e67c0dso41562146d6.2;
        Tue, 30 May 2023 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685503677; x=1688095677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn2U0s4fBQdd3i8IB2GOH73ojEeCe082Tq1S5O2jJn8=;
        b=JrfEB/gNVXo4yqKEty8ZKE1juPLeQyhnnQsWk74ozVq4XhI2+atcF+i9MOCy7TOt6k
         4k5twaQPvEatnI4tahsyPMV4yaOevyuv3u05/NxM4HABBEdymw7m36DHIb0qoA3XZKZi
         z0FaY9i4YVrIKL0Yd0tAgRZRNwBOkQBuaO8qSqfFi7mavW+ywhVNf9hy5twTd4jjhztE
         BxUcxDgRz+LW1RfBLoKy8mnhzQY3DbdJKTiyjQpt97uTtggnW/gPniu1G/ZnaeJoRRBh
         D7bBLUdOd8rZhzuKCx48T4PnJ4sMuaTu/b7VsX9fgI+WbTveVq5rLq8wghn9B5GwtWNW
         7VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503677; x=1688095677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn2U0s4fBQdd3i8IB2GOH73ojEeCe082Tq1S5O2jJn8=;
        b=QBmdzecCzybZuOLAUtoDtIBFfLN9NqFbsjCj+q3mePKFCEqKDQL9/mjwr+vYVV68CM
         L/ih2QzQ90s+DFsdvA5xWPmOlDI7kx88feWv41aiVVeMZZoqLG98iD6pjtSTlpb026NZ
         xWwjazFlmwoo3SUWrtyn5whStfbLQfGBbPtqwijWOLrwIFEa2ltHhj5/Y2POoPqu7se2
         ujxuPUSNfvph0QTXM39gRFveQHDfLbzuJ6RrFBIi9WIRe4p+ny2ZokxcqyLqSxWDmSEU
         nBy80S/yp39znTPMUZqAHsAte9a/dYA4xFGWDxDaLsdXyqiwghFaBwdivdjub4HxV9lL
         Uezw==
X-Gm-Message-State: AC+VfDxmFJnsrTmyNGQCoHSpzmM7bA42II3Mgft3A4TmuPXPV5VdnncG
        SUpLzVAs7xED5uhbu8n3LF67K+TU1ssYAbOBDLCDacKE
X-Google-Smtp-Source: ACHHUZ6HlmE1o8FSrbwNOApZrhnLizfdBtBcEXFMLSKWWIrk3dZHOIMQfzYxWkdtmqmesmoWzYnUj7AqXlG8pxiKnAA=
X-Received: by 2002:a05:6214:d4d:b0:621:451b:6e1c with SMTP id
 13-20020a0562140d4d00b00621451b6e1cmr5195733qvr.6.1685503677399; Tue, 30 May
 2023 20:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230529074227.636933-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230529074227.636933-1-jiawenwu@trustnetic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 May 2023 06:27:21 +0300
Message-ID: <CAHp75VcKn7KtX4VnfPD1Q8L6n4Bb0oA_rG9Z=0dtjpZgUswunQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix GPIO chip IRQ initialization restriction
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        shreeya.patel@collabora.com, linux-gpio@vger.kernel.org,
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

On Mon, May 29, 2023 at 10:44=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com=
> wrote:
>
> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated wi=
th
> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was n=
ot
> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to retu=
rn
> -EPROBE_DEFER.

Makes sense to me.

> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members befor=
e initialization")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

> Cc: shreeya.patel@collabora.com

This can be replaced with the --cc option.

...

>         gc->to_irq =3D gpiochip_to_irq;
>         gc->irq.domain =3D domain;

I'm wondering if you need the same (compiler) barrier here as in the
other place.

> +       gc->irq.initialized =3D true;

--
With Best Regards,
Andy Shevchenko
