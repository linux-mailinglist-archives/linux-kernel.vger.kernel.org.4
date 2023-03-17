Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7745D6BF35D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCQVAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCQVAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:00:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D45D33F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:00:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-53d277c1834so115855557b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679086815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pSPDsSpYr0yzHIhE9QqHD/oXvXGj/zx+/wwbZGGiKE=;
        b=TLAPZObVbM6RimvFIq982tCnrphh2E8b4WnAsFslm59mu9C4n4OLg2kQev1+xjLbg+
         2mitKhD5cGv5G0XN85Rp4tPSNxVr85FQkGJGSwdK7KmCwJlM9e3kSu9hoM9x1IkIi/FA
         KEkxamYocSxlBIZKihAGoh5y8a68DWfU1du9MsCvsWkDvnf+uZZqM5N1n/Wp/CsSGO0p
         jSariuFyMrAx5ZnvxcUe71YEAwSQrFdGoEtyq2PudpolSPN3Yoe5lF3DAliDLyiT7h4w
         DeeKwiRKTDJO3zD/+N4mYgfokEIrqie0/2tPnMxROJ5K9GRx/jKrfJ/S+ws05JAf3CXr
         0lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pSPDsSpYr0yzHIhE9QqHD/oXvXGj/zx+/wwbZGGiKE=;
        b=qkiC4ORgP7dTSLrgXel9APv+S+I5SdE/bhWjW7wJIjspNmlxYkkLAAYkigGheoc+eG
         PjO/2PZQ3n0IEVKyO4IcTcgY2Xi789v3mnVLpxWYlHxBdOkAjzATR/55KMUB8cJhoAdD
         D+dOGuBVYXam+p4oP2Ow1FPRmdlyaAhd2LWDGWpYGfnka5OjodAMhQn+dc7ekyWDtUiy
         lvgLijZOaAhZvNovC5Xj8LKlq7wH/9yQdvLb7r5Kevvh2qOEJI3Vb0I04RqIBES/qhyc
         /nbL9MV6n1ZKDiG5xF0jwa0Z2PdZa80hdYJLEuXOiGFBmL4PAbW3OhlM8gs0feQ6U2D/
         9myQ==
X-Gm-Message-State: AO0yUKXxwA+y8YazpEB+x8sbp6CVpIyyoaN66KXGbGbsPXuZTnJqmTjW
        taed7byPEciTwgcw6sW9Lg012v2845+g7ZnntqESbg==
X-Google-Smtp-Source: AK7set/QsTUG3EEsvs9ExltdFx7/LqW6bRg6UIEkaEIPkBXihYNrXoghB4S0x7WKrIwB3mTvAVKhXTm20ajPQWcQ48Q=
X-Received: by 2002:a81:ac1f:0:b0:541:9895:4ce9 with SMTP id
 k31-20020a81ac1f000000b0054198954ce9mr5307886ywh.9.1679086815073; Fri, 17 Mar
 2023 14:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-2-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-2-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Mar 2023 22:00:03 +0100
Message-ID: <CACRpkdZwpU_ZSC2KnTjgMCwKY8iDcBt7EyEUipSm0caMUG9BxQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:

> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a use=
r
> to manipulate certain GPIO pins via libgpiod tools or other kernel driver=
s.
> The usables pins are defined via the "gpio-reserved-ranges" property.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
