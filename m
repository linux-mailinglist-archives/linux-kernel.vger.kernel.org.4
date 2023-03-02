Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFC6A80C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCBLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCBLLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:11:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428930B24;
        Thu,  2 Mar 2023 03:11:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so66008121edb.9;
        Thu, 02 Mar 2023 03:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I24OPDq/kLlSuHGPflRm2uXznKj1xztkIch5YbiVGGE=;
        b=TJomh1mcGrs7i47cr1rc9TMO9xm/mM/qr5if6bZuCS7KnWYb1jG1oY/48lvGoZyXvv
         20Xg9apPCvX2+/DgSVN/TvjCuPIU8Wn347+PIh8Bv7av77WnLHfGm4H23AitQ3gnEcfd
         cx2hFn8qtTJDmDqxPzlAKs6mFIM/YTxw8PPoU3Kkrki4JGiEow3hOf/Z416Vk10UnvoJ
         vhpfuRuZgcZezt3+ICXBy3bktHDu88Kq7AxzyGtOaB/OZJhP9Lm3wnRsAu7yi1prn8NN
         OCxYJiuq7VJdNL0Q2srwazM7FzqiX5VDEZR8k95pImv9lWUMN14mplK1O/uELmCAr8va
         HT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I24OPDq/kLlSuHGPflRm2uXznKj1xztkIch5YbiVGGE=;
        b=rxAETuxqKUkwqQ+gIhVZEmghkWqSs2tCEwGuTig+fpb0fObpqbb4wUd1B+WBUoXWsI
         /gcHUWoajgGCFdoFu6x2vq9ppDLq+OG/nGXQXSJACLMq1Q/oF/wYzI9va/3u3ENWX/ju
         uQlLF6UxQHYzutftlFUNfMlMXexDH2zl+HRUl0DXc8+fGq6lby24EX5qX0SIVFxa+bSF
         o+f4lALATVDIT0ER5JgOrsbQ4hHz44XQN7rHmq26R5k890gSvNMM1btyqfH64RzQK0o6
         cS/alsEwzODvPbM6JXlTaqtZ+ixz7I4P5uDYNnJ4+cKlYduGGA2SxmTqarB4G9YaupTL
         qrFg==
X-Gm-Message-State: AO0yUKUzNCEp13rLEKmqkYghQ+NBLa6+avAJfbVk3ygItRtLcN8VSsNm
        s4t8M+ot7VQn6gdQulL4PanPi2+WIlVWxpL81vc=
X-Google-Smtp-Source: AK7set87dFh2ULeTzYdjiEUjlSali6yM7p8x0e9gJKkw3KGbj/oaX3bqDk/rZnTirFKciv/eBiPu1AJkl4YKrflj6tE=
X-Received: by 2002:a50:cdce:0:b0:4ad:7389:d298 with SMTP id
 h14-20020a50cdce000000b004ad7389d298mr5770007edj.4.1677755504278; Thu, 02 Mar
 2023 03:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-3-keguang.zhang@gmail.com> <Y/YIDobQW8W3QAAh@surfacebook>
In-Reply-To: <Y/YIDobQW8W3QAAh@surfacebook>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 2 Mar 2023 19:11:28 +0800
Message-ID: <CAJhJPsUYR55aLNWi-VC2wmNEZZj=7E1aPpFTB6a+Bzhw=E4y5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: loongson1: Introduce ls1x_gpio_chip struct
To:     andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Wed, Feb 22, 2023 at 8:18=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:
>
> Wed, Feb 22, 2023 at 07:12:11PM +0800, Keguang Zhang kirjoitti:
> > Introduce and allocate ls1x_gpio_chip struct containing
> > gpio_chip and reg_base to avoid global gpio_reg_base.
> >
> > Use readl() & writel() instead of __raw_readl() & __raw_writel().
>
> Please, split this to two pathes.
>
Sure.
Thanks!

> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best regards,

Kelvin Cheung
