Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB672167A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFDL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:58:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE14A4;
        Sun,  4 Jun 2023 04:58:08 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f7f864525fso41959461cf.1;
        Sun, 04 Jun 2023 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685879888; x=1688471888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T18QKAipN8vW8fTZCSkrcFHiXgR2OFXGMISa9G5pUdU=;
        b=Tf5/QIh10fPABekvmYtfjVYVrCHUeFdeAJhYChgKRxDpBZaBGDVaUTYjZYbelx6gyY
         /GubRiLI2i04OlgJ7x4oFquj6ehS926hjMqKCij95031EwHkBTfdje0BV2+rwUsVLEun
         yyXgXWWCPZ8mlTRprYLzr7fGkQcj6SOrF6gj6CEKT9kqynhljWotO9SRlN4dOLRPixJT
         Dv7AvdmKtTtXU6B3WCtvQ1Iz3MDxG6ghQ6898AmXEYH0LoDY8I41YD3uClKLo8fvpPrK
         LjRrn1YkteeW/9dnkxipeb0SQgW0QfYeil4VB4wgsY0Ha4GwlOynpmy0xrrY/ahpvGOG
         HX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685879888; x=1688471888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T18QKAipN8vW8fTZCSkrcFHiXgR2OFXGMISa9G5pUdU=;
        b=URJjoCZZZZRYMX+nEqchjTJROO9rrMKRlH6YSb7/oHk5anQeneQqCMidZ4G3EbDFXc
         ZalxSwuLcGC1WNEMmRlbF7yqhKpu6IUy81omma+gm4iQhsyGyGOJiMWcOzbhXPJw/ToC
         0m8bcXm2LP213Hf5cFPuy9KH5h2h5TWJNfieVTFAJ6XTjRjDKahudAFSTUx5iJhfHEdB
         FeBKfLhMjQZ2cQ5nmqKz5BVK8cDmbKXC9KY+3VMpizw2ayW61OFxelURZBAWnuKG+S73
         u5VwYG5ZBnuuCnON4U/pZr0PXYsYtg5xD70xDMq4gL65lZuPP9Uaf8wd+ikuKHVd6EIv
         nlrQ==
X-Gm-Message-State: AC+VfDxYngUo3KFJVtRU33UHLLBhqiT7Q+J/3e+G9Hqv1Nl/V4TUOg7b
        7kKeFor1s+7eGql+5NJ24FfjwIIWu3iRuo5qAtU=
X-Google-Smtp-Source: ACHHUZ6fLvXz6Td/lh8jNS6ZNkXReU+YUmxjbGH4qHdHOUzIZfT7IJkWjTozo2wMAONw1IdmQ7ka+PV9zVx13/qOT+c=
X-Received: by 2002:a05:622a:291:b0:3f8:698b:34a3 with SMTP id
 z17-20020a05622a029100b003f8698b34a3mr3555140qtw.67.1685879887741; Sun, 04
 Jun 2023 04:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230602152626.284324-1-hugo@hugovil.com> <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh>
In-Reply-To: <2023060454-cotton-paramount-e33e@gregkh>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Jun 2023 14:57:31 +0300
Message-ID: <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
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

On Sun, Jun 4, 2023 at 10:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:

...

> > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
>
> This returns what, mctrl?  If so, please document that, it doesn't look
> obvious.

Good suggestion. Because I also stumbled over the returned type.

>  And as the kernel test robot reported, you do nothing with the
> return value so why compute it?

It seems that the entire function and respective call has to be moved
under #ifdef CONFIG_GPIOLIB.

> And you have a real port here, no need to pass in a "raw" struct device,
> right?


--=20
With Best Regards,
Andy Shevchenko
