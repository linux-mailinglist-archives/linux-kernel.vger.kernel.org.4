Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714AD703F65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbjEOVJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbjEOVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:09:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B66E6D;
        Mon, 15 May 2023 14:09:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7576516c81fso1024193785a.1;
        Mon, 15 May 2023 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184948; x=1686776948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq0o/8p4FZPAmRFUAQ0rfN/u9SgX8f0uwc+1Yna0210=;
        b=G6QsJbf5NUzZl3Yted2qE5YjizUvlyhoHuoUQSk6rEEmNEX/L8lMT4vgzQEWLSJhYO
         x3v8Rn+sRS7G+sbpHiPGv7DHoHB0JJ8Hti2V121bSA4b8fp4ibqfq1GUcgMBZ/fT72Wi
         YdhsxIA/GahYdLusb9vnC2KrJ9Gf1/NvwjwEEgT5KJEjQS9Kp6IovzwaLsNPZ3vOmky9
         IN52IQNDIEhcKV8ioGcUbm7uenRsLxe5LOpIAAPgvdpnwnNGWv6fZEuhv1eYIOpM33HE
         gXeSXbepMIyVvQZDurL5cdG7354t8p4bDZgYw51tvFcn6dX/1GhYbiyBGFb+L9U1yZNL
         vw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184948; x=1686776948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq0o/8p4FZPAmRFUAQ0rfN/u9SgX8f0uwc+1Yna0210=;
        b=ehaLOqkyFoNS44VwnL/6IqsaZRL6RYG7He+rEKkqZrNjPLPykwKGbRhmnTisLP3sPt
         89sarJZduEc0wPLK9QmAGav77kpPzbGPIrOLS9+iv+PQd3SZwpDdeprSoJqYdcrTupgz
         5lUOU8b/IkuGVPqdv6cc4tvhlYNt1uKr8qLyIxBL49Z2TrUguMU6hlSMCGPK1MVAzRDA
         7nXT3ZsWnqnDxU8JqccWN/HKXARduO2joiSy455mceV2GFZfKA1pm4Rm4hG2yCRqhM4m
         GiF9qlQraEnd32wi5mqcWKarqSb9zpxGBTz9Su2dPhfv2GSv75RHVvzQN+EbCu9kK1Yl
         OsWw==
X-Gm-Message-State: AC+VfDwtZum4fkFhfzvqo3HV4lGuj/iJt++9VjY6P3Ireif6j8StJXkg
        2KUra2Cz5Iobubx/gKKXnImg2gOvW2xhuU41QFk=
X-Google-Smtp-Source: ACHHUZ51/aKHgFdpcLMsrSziQUJZGZ8PCZ5e4zImtndwtajs0yJLWDCu8QuZWkEoA8oh3e4gO7i5U7JE5iJ6YyXFqOg=
X-Received: by 2002:a05:6214:5299:b0:5c1:fa35:fe6 with SMTP id
 kj25-20020a056214529900b005c1fa350fe6mr51005095qvb.24.1684184947993; Mon, 15
 May 2023 14:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174224.494631-1-afd@ti.com>
In-Reply-To: <20230515174224.494631-1-afd@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 00:08:32 +0300
Message-ID: <CAHp75Veu-HbANATV2trD=wAkNx4zia2L8Y+roLQ9k9VA_Vxu3Q@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 8:42=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.

...version of gpiochip_add() function...

...

> +               err =3D devm_gpiochip_add_data(&pdev->dev, &block->chip, =
block);
>                 if (err < 0) {
>                         dev_err(&pdev->dev,
>                                 "Could not register gpiochip, %d\n", err)=
;
> -                       goto exit_err;
> +                       return err;

With this applied you can consider a followup to have this be converted to =
use

    return dev_err_probe(...);

here and in other ->probe() related pieces.

>                 }

--=20
With Best Regards,
Andy Shevchenko
