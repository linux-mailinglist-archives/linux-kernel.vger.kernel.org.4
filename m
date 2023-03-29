Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3466CD504
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjC2Iov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjC2Ios (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:44:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B41FEE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:44:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b18so18396595ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11JaD7hdMGYDMEVM2bxoT0TPTbslQdWxsEeb3qIPYls=;
        b=F/o42EqN0ifcxbRNd2+xZEitnwqM3+QHnI4io7mZ8NINwIjSuv6zRlWQKAnB0xn8JZ
         xqC9xpLrnqHJ1583+emjfoQUQIvaptA5QNA3Ve/9P21GdEOPBwhecYZ7ZrBrmXgHxd0X
         34pz6cHbfQzaSiwaRhsvYkuq6D7Mj3d5y2cpHJKCXJRe0Pob7g90/kVZQjgzxK0NjIiQ
         bPA+AXBN/E8AU0UzMjylFIuBEqTe2EBiaEnywlhplY+UDDgQkFQEP9iIrjoQt0w6pVdc
         gpajMqQnK/xBB/d1YndivVpogE0QOTwVTQK+djV+pW+UqNgLn9631XK5Rk2Ae6NdUqu7
         et8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11JaD7hdMGYDMEVM2bxoT0TPTbslQdWxsEeb3qIPYls=;
        b=nKtip0Ml5cxi4KSEL/8wHnWM3mtH4dlwU7mvZ/fh1ywzdFF0F6LSDejlhGnZO2ntDQ
         hP/Mvp4TakAZv+ZWYkcGbNg6NTf200pFi773xsriEcgmbQu64DK/ZwtO+smKu4maBaX7
         TB9ErizssPZkr5FfnjgwFi4z5AH/R8qfSoDbg7X3VZ5kFOFG00iVM7W0GHhyBT5PUjTA
         cn1W441m7vfaqZG1bevkojehYRgpuOddDAWmmkXJto9SvSS3XhvppwueB3vnJ9m2aGFO
         mA0gn5DBVQ6wJv2a173VhH9SqiiKBB6h/sLshhEYkO71P+shcTpGBIXSQUCj+ln2rExZ
         XlBA==
X-Gm-Message-State: AAQBX9fKjjXIFJwmwy0HCpyeP5yZuhOv/Sg69Yx34k7ldj4Zf4WKGPrz
        Vn2o9NxIe/uQwZv/Z/ocuGw+APA4QNM4E/haivp3iQ==
X-Google-Smtp-Source: AKy350aY55dPk1jxy2/5OQeOccyqKlQM19jufZynt6zF0+7H1kF7mvdwzMfPacylJ663xZp1I52XCMlaxXmLogmbD9E=
X-Received: by 2002:a25:8712:0:b0:b74:3236:2fac with SMTP id
 a18-20020a258712000000b00b7432362facmr11757896ybl.4.1680079485954; Wed, 29
 Mar 2023 01:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230323205733.20763-1-asmaa@nvidia.com>
In-Reply-To: <20230323205733.20763-1-asmaa@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 10:44:34 +0200
Message-ID: <CACRpkdbc1p_BmGkQRNJYxjNAahJQQ_5+zUadm4fh4UxRmM_PyQ@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 9:57=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:

> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Neat fixup,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
