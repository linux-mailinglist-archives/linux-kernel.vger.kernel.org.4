Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BC70947E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjESKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjESKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:09:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6FE5F;
        Fri, 19 May 2023 03:09:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-757807cb299so168975685a.2;
        Fri, 19 May 2023 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490967; x=1687082967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWPrIQpavQse0yrjECi1Bzp77wOdSMU9RuJ1sY2T/oY=;
        b=FG4fx6/fJsVA0LcEEZjeVRJRUDBqCYqHqYr0KyXwLmkRuUE/RIvun8eEIp388EMdcV
         DoDTtbMvAxPongRM62QuSODSDDK2PQeQ4c6w9/nbsdenalJb7Gjt/dtq5KeVzphZW66S
         0PP44hEiV/x5GbZKlO+RrWI1/NLTbiYMr1nay+QN/AntBoJaDZp4kvt2dXvXs8r7c9eK
         1fY4NTQvonXtFs/EwDLJBcOby/vu5lMMMUt6cxY3jZBPL1iyYkpun1dvJpWqJGRxh7Sq
         mcNOFKCvQNQN4s6ikZcW5vv40DfLFyN5lephAeRa4Gl+34ZLUYSz2649P4kpCu9/uDwJ
         ngpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490967; x=1687082967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWPrIQpavQse0yrjECi1Bzp77wOdSMU9RuJ1sY2T/oY=;
        b=EMer2sfXORXh5D3Q+6kHtB6DB5+NVcHqyqvgBEgb0HLIy3aHE8+IJax9bU4HfNObKT
         dTLu4gg2VUJJnVFAsSjduBQcL96qOxUgtOeopH1Z/4sNJ0XcJZAz5fgMuUZDgL5DxmoX
         1qrX6bki43ShoVOVAUiLIle6JdvcaU6FSF0g3BboXuqB1bMFNTaX14vyDWn0TiLrLJP5
         1/LNIijuI7KvhrO8fOe9yf2ERMdHaSdpsH/589FAf8PbSeHvHc7d3g1DQjNSD3JDbmfD
         5kaMYSfPa+4rCs6Z8gfPCtvod7EvaSwGbAnSG+KRIjEUTuIfBAGtfNAyMg1CXAecaK1S
         b0gg==
X-Gm-Message-State: AC+VfDzseyrEJUh3JNWCrtLpYhSd1F9EAwkCV+6F2ELP0h7+ADdPzbIz
        fhoLXtAys+NNG2Aq08NUWg/os4oGU5WanWWaO98=
X-Google-Smtp-Source: ACHHUZ5vBRw0GXtUhMFzhODE1MN8b8XqI/WYuGIujirALEyANC5wadWFGY5kJ+eZmO85GGaANIqC6rk9WBZLIP4+ISA=
X-Received: by 2002:a05:6214:509b:b0:623:557d:91ba with SMTP id
 kk27-20020a056214509b00b00623557d91bamr3284512qvb.34.1684490967463; Fri, 19
 May 2023 03:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20230519050702.3681791-1-chris.packham@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 May 2023 13:08:50 +0300
Message-ID: <CAHp75Vcd8Q+-XMyfg3Y_hv_AL00PGgqg0jo7Yd7TTC4GrxPOuQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Avoid side effects in gpio_is_visible()
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, johan@kernel.org,
        maz@kernel.org, warthog618@gmail.com, linux-gpio@vger.kernel.org,
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

On Fri, May 19, 2023 at 8:07=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> On a system with pca9555 GPIOs that have been exported via sysfs the
> following warning could be triggered on kexec().
>
>   WARNING: CPU: 0 PID: 265 at drivers/gpio/gpiolib.c:3411 gpiochip_disabl=
e_irq
>   Call trace:
>    gpiochip_disable_irq
>    machine_crash_shutdown
>    __crash_kexec
>    panic
>    sysrq_reset_seq_param_set
>    __handle_sysrq
>    write_sysrq_trigger
>
> The warning is triggered because there is an irq_desc for the GPIO but
> it does not have the FLAG_USED_AS_IRQ set. This is because when the GPIO
> is exported via gpiod_export(), gpio_is_visible() is used to determine
> if the "edge" attribute should be provided but in doing so it ends up
> calling gpiochip_to_irq() which creates the irq_desc.
>
> Remove the call to gpiod_to_irq() from gpio_is_visible(). The actual
> intended creation of the irq_desc comes via edge_store() when requested
> by the user.

To me it still sounds like a hack and the real solution should be done
differently/elsewhere.

Also I'm worrying that not having this file visible or not may affect
existing user space custom scripts we will never hear about.

P.S. TBH, I don't care much about sysfs, so if this patch finds its
way upstream, I won't be unhappy.

--=20
With Best Regards,
Andy Shevchenko
