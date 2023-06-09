Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABFD729151
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbjFIHiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjFIHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:38:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DA193
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:38:06 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39a3f2668d5so419261b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296286; x=1688888286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eek9PNJnyCtKyekmvAspHpY2O46dtVatAGKNcAtI9H8=;
        b=IRw1pAu1cs9xYZM9EKMHdfyMh2j5/2COsPmsR2+0Hjg4+RA+7pSAaL/B4AM/bQBoH9
         A9cS1w9MVFzCgC7ayePC0Q54d+ef2a+EKKzb0EL8RtNcPicYWAaIZezKJPSAGeq7LxgJ
         RgQbdRFZMy8EzpjX2aa3Yv6Q2AQrIFe4TrUwbehbRAh3K+9JWZ7y/tDv8rbGCHVH0qwy
         3qGjHd4U82TweivONwTyUElVVPNLNof+x6FepxOrrECglEkN4hJ7MsLhADiIZ3xehuxS
         Cnqz7a7L5izD6wwFvT/6RuCC1eS50oKzbJj8frWtY+HO0z35rs7N0Dpn357i6UlsNPG0
         jdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296286; x=1688888286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eek9PNJnyCtKyekmvAspHpY2O46dtVatAGKNcAtI9H8=;
        b=WCdfmxnhprPM9TV5tALPniT+2eHJfmeiWLaVDbgUkgRH9Jr2x1SaWh0ZHc0J8FIG+9
         mOqwpNq3ywDqHJrzlaV2ikDoMaUA3JzYsVXRxJVh8Mye4BBCIcB422UXPnwOx2QNCnYs
         h0AGbdi0Ok4IeT2RAC/GJhqxDYkErw1HCsP1u3TMpKiWxwQEAOC3OslJhiabsmWHvMj3
         +t7FAp/5EvdmMrsGBUM9VaVW91WmsKnqhH74/n5CSaaURcb6astNgIKi0i4BjdoUHVtd
         p4NYg+4zsc4G3/ymwaQrL56ca05sbmaEcMbIQtR1bsVPsdXc96aXxepnGetd0GoslNNL
         vqJQ==
X-Gm-Message-State: AC+VfDxKbm7IGfL67ogl/RIy+wBiTH2AtMBmu2+TkQigc7ImuNkUPQqV
        XEyjk9HsYxgSmdOkYMeOWJo7cgu5CS+1rSf0GPfFng==
X-Google-Smtp-Source: ACHHUZ6wash2adXVoBqs+8SFc0fMUE5lD3iFWKimwfpHSAzCrZvPtZTRlOo6oFI3zY+ftldTJcqxXm/rOAmTEAzJqvg=
X-Received: by 2002:a05:6808:f15:b0:397:f94e:4321 with SMTP id
 m21-20020a0568080f1500b00397f94e4321mr835247oiw.23.1686296286137; Fri, 09 Jun
 2023 00:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230607081803.778223-1-jiawenwu@trustnetic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:37:55 +0200
Message-ID: <CACRpkdZvV27wcp6ZxrUHtEC8+dydnH8_GJW9T97qROgfT1mZow@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     brgl@bgdev.pl, shreeya.patel@collabora.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 10:20=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:

> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated wi=
th
> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was n=
ot
> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to retu=
rn
> -EPROBE_DEFER.
>
> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members befor=
e initialization")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Looks correct.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours.
Linus Walleij
