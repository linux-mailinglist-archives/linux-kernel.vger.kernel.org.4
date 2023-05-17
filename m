Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8870644D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjEQJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:40:33 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D1420B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:40:33 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-77d05b9c4a6so191538241.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684316432; x=1686908432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LahdGDO0/VUYJLEzlCMaKFa66DsQ4b5V1vjUC+JwrEk=;
        b=3KEUP/ZVCCZt0OFSklJH30+qGQ7uzjlQN/7UcOSxXHeo+i9qO+9JJwEplM2I9dlPdi
         HCsyHKp77jUUQQgJnaow7uHL88rqg+FIfFhmCMViruoUu9lcJXEY/BSLmU+1YZgIaUMZ
         g1+WQ4ZpPoFPvQVzogK+m2sGfVTeC9KzUrPykTbph3wZ6AqMzBMR5exW8ToXXq4cd6jx
         o2dBaVk5+8h3IgUiGvuVS5krOaduV0Txb0QmaGweTXyqBK8kkbyX8shu/7TUe7VZ4Y3y
         JJabZ8inGbC6VOWIIW5qaLTiQpIFo+SZXzFuadg657B/IJ14cwClNUe6O9HKKh4YFN0z
         +F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316432; x=1686908432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LahdGDO0/VUYJLEzlCMaKFa66DsQ4b5V1vjUC+JwrEk=;
        b=Ur9+9V5mQyCK1pxoEfxvv72Ov5g+gyCmeXyEwMvsM1LHF/IixR9uP6nWgP8oauCl2p
         fZaD6LIUfrzBTQQrGX0iJw+LzlXpHdGzJugaR5c8hA4M/hx0tIXLRhybnU7PGhKcXPnk
         CyV08KeLUn7cYAPCi5qJLcR8AW9SwN551/3+BJJqIgTdr8tREdgrJTQwHsU7iDdFWg57
         Pmt71V9FVIij2EzYygEO6j+eoLMYw4k+EyrG4wSt50RweQwO/sXb5LUwPHYHDFTVbRgY
         m67WE0OltheysxbJp4sQ1jtzZaRiPomu8A18lu+YlQ9j9SeTqzN6YPiKyuKN5tYt3ZQF
         2cTw==
X-Gm-Message-State: AC+VfDzwbUJfyl2qpdK2pUciffcjTbpEQWvAjyichdr49iFDYA7Y7uiX
        tqtWq7KY79N9zKGptL5bApI9s2QpCZ9G+lwcLhQzJQ==
X-Google-Smtp-Source: ACHHUZ6WmJyaYBzwQRsNEOYSVI/5u/LCg8m2qluTWKp+0Zc0ae5o6s63Z/oxuCmKHEo9+PGRDHXkGdUlADtyrCTjKeY=
X-Received: by 2002:a67:ec47:0:b0:42e:65a6:d445 with SMTP id
 z7-20020a67ec47000000b0042e65a6d445mr15178029vso.5.1684316432143; Wed, 17 May
 2023 02:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174026.494496-1-afd@ti.com>
In-Reply-To: <20230515174026.494496-1-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:40:21 +0200
Message-ID: <CAMRc=Mfc51X-F5sq57Ywd8FC64pa5kCL9Joi9PExXSTAq5CCcQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: twl4030: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:40=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>

Applied, thanks!

Bart
