Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF175F3D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJDH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJDH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:59:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204732CDC6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:59:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so27106208ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L2dWGIt9t4D3CPPxZBafwRWpceR1bsADn4ayw8anRoU=;
        b=kSjCYFb/WECp8AU8gf5zV1phxBznn3Nko5hkAEEE/qaQeiiV/K6F4K8tq84ceY2ipz
         o732xkOsae1hWnGzDBjtD50zzW4LSp899EpcNOVmofbcQEu6mTA6tvg6QQKjLlEWsB1R
         bTLZ0B2A7RjW9uQ36vqbVcflUiXoyWrm8dtGf5iLhYsETybuWom+vYX6AVkzwxvEhXr+
         dCBBtW7xILOTaJqYYYcsMyCc4eaWgbs8TBj7uJlj8AGLxn+UncW/ZXVe+4e5SEK3wEqv
         QYQ40aSC8MjW+VFV3KjsmH/+6Fs6cOWih+oteihuX7gLFR4RAbG1Z6D+laB0XXBPra2Q
         bUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L2dWGIt9t4D3CPPxZBafwRWpceR1bsADn4ayw8anRoU=;
        b=ngBki23tBpxGixVoIxSfbm//JMYydw63rPnF+RXo90W5rm0dxcsYDFhSyADjB0CYZ1
         1S/Jz2As571Y56B+nz+JfDUiflqAd9m7aWRMkFFLCab1NXKg2blNt4d2oZoyzxSuR5U8
         f6mN3L8ncp1hSSrm7wqnclzuvAKlT+Lwxs0+vSsg21EfpchIg+EjUG3SbFhmkZCeJyzE
         MNw0n3Xx9iqnezO6kDyDUkrEz7nU8wGS/WsqSNjoMaW92rTAMekiBxMmeqHKmAozvfjf
         /V2O8dTJAstq0sjxAhU7ipGUsOS1DTYQzGw+p/xnmjytoWHpzkqdqnYyjrUPN/XhEZMs
         hwaw==
X-Gm-Message-State: ACrzQf2GmqebEt3N7xqIbdP+LaZ7vSdicOXoJ4XJgFB55URshx7TwR2a
        sbPKRQpKGy1vRZskx3lp/ymb4cTWT1PWffj62m8T4w==
X-Google-Smtp-Source: AMsMyM7FjHaFffQRYsw1lI3MjDtyFfLznoFjVRZRGdT4F5SGNXA1TRDK4Q3ucECogr4sI505pkfeeuZRNDaUJHEKc44=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr18490813ejs.190.1664870355648; Tue, 04
 Oct 2022 00:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <YzSsgoVoJn4+mSpv@google.com>
In-Reply-To: <YzSsgoVoJn4+mSpv@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:59:04 +0200
Message-ID: <CACRpkdaR8=BeA88gE8m2g1DQ=zOW6Y7S9J6=aYAVqXRwEHax+g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: st: stop abusing of_get_named_gpio()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:20 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Pin descriptions for this chip only look like standard GPIO device tree
> descriptions, while in fact they contain additional data (in excess of
> number of cells specified in description of gpio controllers). They also
> refer to only pins/gpios belonging to the driver and not to arbitrary
> gpio in the system.
>
> Because we want to stop exporting OF-specific handlers from gpiolib-of,
> let's parse the pin reference ourself instead of trying to call
> of_get_named_gpio().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Excellent work as usual, patch applied.

Yours,
Linus Walleij
