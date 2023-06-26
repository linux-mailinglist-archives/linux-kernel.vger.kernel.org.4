Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FD73D80D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjFZGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:54:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D74116;
        Sun, 25 Jun 2023 23:54:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98e109525d6so268381266b.0;
        Sun, 25 Jun 2023 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687762466; x=1690354466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxJz1Dk5o1sPslwYPctCnp2x8NtNSKlIcL6JzU6aOJM=;
        b=T9q/4MwkjAuBWPZSs5yMr7/a61IyeYxCPiYIAaEnmkuQ6G8jSZAi+QIowkM7/SDx0K
         Ch0ULgDFbwX6ARds/NeG1HBoQF7ZQgM2jIapXcEe9+f3HIhpCxJZ2guyr3IWR6ubW8mB
         LHo7zFYQyjObLHhxqHxC1mGu32MUsfmu7AHQLmFL4LKrdobeKkxqgmfX2uLUAWTATKwX
         5JNCO/XqR4LjUvO2d/z/kf4DxQaYNKhir3HcNP3pX5Obimg+KtN1nJxkZWsyQ2BGkCLN
         sTm3aDacZZp0OHdTxFKC9np7UwCTClB6HOvMiBiyWXs4Z+ZAh/TcnKGdhWSa9ddbKlFV
         5EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762466; x=1690354466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxJz1Dk5o1sPslwYPctCnp2x8NtNSKlIcL6JzU6aOJM=;
        b=ML0Qaef7v0VM/d1qcj7NY010kQY3XM2Nwcx4TibjiONQwQLZvEVDJP6xylS5AGDOAZ
         hXzmMAWw3IBE6JfSen2tLceX1F13s+p8SUgUoi941RgP3geo9L8kDF7wyuLDxHMBrBfe
         JRbFIQ2p7h3DPFRRy6QNssfFb6ofuYwC6UZyDZ9lUQM/AsDIRetm13VlUX5oDq1GB3Vk
         UF++S61dRA/u5jZUS1V26Yt9GpGuNuRHwJpn5QPkfRePnwyGBcsBux0aWCcU2ssl5S8E
         pfQBWN7lmpWfrlbwhcARPY1Xm4gciFcpR3ts2skwxFCiacIekIJtt+HcRcXzVaohrtjS
         E9LQ==
X-Gm-Message-State: AC+VfDy91QEblN3sgTsUPiiGmlyiTWBF4C0vE6eAqTg0dk8IsV+D+Xd6
        bhuw5TpX0+qzuCIVetKK0iy6pEtX/CqYn1LkwDYxWhPN14cyMA==
X-Google-Smtp-Source: ACHHUZ43M9Zs9IUQDV6DCvQcE0UBi5sTQTyFE/biVuabnB2tmk29FAXUMt173EFzPgXyF2MYo/5cFKqajdkuXE0XYd0=
X-Received: by 2002:a17:906:ee8c:b0:988:8efc:54fa with SMTP id
 wt12-20020a170906ee8c00b009888efc54famr16225202ejb.37.1687762465837; Sun, 25
 Jun 2023 23:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Jun 2023 09:53:49 +0300
Message-ID: <CAHp75VfqT0FWX5TPjiDcP=w48HRJGZ-xK55FuatU1XZVOx8tKw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock deadlock issue
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sun, Jun 25, 2023 at 5:45=E2=80=AFPM YE Chengfeng <cyeaa@connect.ust.hk>=
 wrote:
>
> linereq_put_event is called from both interrupt context (e.g.,
> edge_irq_thread) and process context (process_hw_ts_thread).
> Therefore, interrupt should be disabled before acquiring lock
> &lr->wait.lock inside linereq_put_event to avoid deadlock when
> the lock is held in process context and edge_irq_thread comes.
>
> Similarly, linereq_read_unlocked running in process context
> also acquies the same lock. It also need to disable interrupt

acquires

> otherwise deadlock could happen if the irq edge_irq_thread
> comes to execution while the lock is held.
>
> Fix the two potential deadlock issues by spin_lock_irqsave.

Sounds legit to me, but
1) do you have any warning/oops/etc to show the real case?
2) shouldn't we annotate with respective lockdep asserts this code?

--=20
With Best Regards,
Andy Shevchenko
