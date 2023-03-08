Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7D76B0417
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCHKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCHKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:24:49 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E99AFE7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:24:34 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id s13so10830163uac.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678271074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xusFC84LWq+hQQWH9l9KyGW8WLhpi+RLY/FC1FINVa8=;
        b=yADZFNqTg0Yk+jainBo7JMe0BgN79XEAO6bbEmFSSOjqeFsKaC6+YHr2hC3uZ2u733
         LkaiLq+R2+J17UIXN5jx/PRcfVY3eaJA15lfrpH6jrKpo4ao681JB+JVDheUz87a6eXM
         i0bg9aConEDw1qxOUtH4Rfe3vJbP1/U1DCAMy0W803q5k1kq34XbI2LRqsQtzCTIgC0T
         QfIXmyW+GU+nnvF62HNGWjoLSbiekDvp/I7h/j8NC1360Sw/abkw8mivDCQoKQgELHm1
         g3gycZ6nsoRXU/Ir/SZMMXHyEW+qVaqaGko/AdEXfOrpWqLqHF4dZciIu0HhwDmJqbih
         crTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xusFC84LWq+hQQWH9l9KyGW8WLhpi+RLY/FC1FINVa8=;
        b=BNMmX7mYhpyd7GA6tATBAHNTcIGpIbI+rAmCZCPJvFnU/yKwHRWW3EJjVAUBqT3jxb
         /QcmkOK3s3wQS1LBtK1j5Hqc5Bhf56fpE/KJk+ymcRX08XDOHzwsyyKLMdoS/g34PUO+
         1UtFNYP4cwwBgpglc551JkD3219Svpmq8vL7dOtnpEb8iof1AmagdaHfjEu8lEHqvSdg
         00Qks2Vry/eCGOQab6iNGlODS8G9/69WBtEJONdh/wfrrIuQB+brc8TWtSyPMTo1bMu6
         ydkULACkyVEiOMEAcYSECqnEl2egSXIT9slguwuR7WxmLbM+SIx0rmhouKA0NbP7biDj
         GxJQ==
X-Gm-Message-State: AO0yUKUCZYbx7RnRn4DO8Ji9QSxfhIeVBZ454NKvW3KlYt0udM0Snkab
        vbVN6stokllB4QgLCUUXw+6/88aU7MZb3URvH0Alhg==
X-Google-Smtp-Source: AK7set+VBTrthx+dNIR5XybSUeHl/KtfuuGjtxKEnQRPYCM/rg+oNJJdyLT0yEE2LmVUHMnx8ZQpjjusjgXmAZt0vcc=
X-Received: by 2002:ab0:4a12:0:b0:68b:b624:7b86 with SMTP id
 q18-20020ab04a12000000b0068bb6247b86mr11765061uae.2.1678271073786; Wed, 08
 Mar 2023 02:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-3-afd@ti.com>
In-Reply-To: <20230307165432.25484-3-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:24:22 +0100
Message-ID: <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-sch311x.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>

Applied, thanks!

Bart
