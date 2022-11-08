Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E6620DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKHKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiKHKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:50:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5BD43AE1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:50:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f5so37523457ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cI1zMfq3lTc8UzWRLodrLvVbxywyN3pwGfeoh4TP7Pk=;
        b=HbSjHAG+XMjuE1yuF4Dqsww1Soriw/tDonvjEn0RhbG+dx+XK/8rNeqM9nIhaOci/i
         IhP4Iu9O+G4vaxfHK2IvYHtLJ3wrdJ7/2pByztIlpV6zD6khoDqfZwfecGHBtSu6Kbuh
         QMhjVDGzCZhCkUNYa1oFs+lzelwJLwKAWi22MirwImE3XSBLphjrI6wB9baH2oYH9Ijj
         nIWof0HDKDJUzG2DkSO5EmnherOt+8ASNa0iRG56Y1hzmQg9xkxB/o56l9XI/qvzUjaI
         XRh0xaRroeM3nx65FnZlrRtcNMAxDGy3d1RVQw2LFNcj215HWrk9t017EfrBrP070Rj+
         EDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI1zMfq3lTc8UzWRLodrLvVbxywyN3pwGfeoh4TP7Pk=;
        b=pjIfFhqaBoC9JvQHEJEXo61hl+Id+U2nrhH09sextgR7GhkH+Fs+D7QdpB6E7X5rNx
         9Wsrkl2+wj2Iqf/Vcj702RlUaSK4+gDEnLFuJnANvfn7woHZAl2hjGF59pAnRJtTCPPm
         0e/z0RkAL9LWVRm8phj7Kgqxu4dspW0sMmtP3Bmxj8RBdNj3jpy2BfLsVGLQ3czPj393
         8/3HPeJz1ee8Obo7m4WLzmIFFBqJoo4bQKKIC/ZA5miuCksUp7YKXmB/3QfNPRRYnVkr
         VQI/ThTlcexHa0AcbX3GrCiikHib0L8gRruJsXPT1kCYx8zk6E1ufwJ35T3wKzValfdQ
         PQng==
X-Gm-Message-State: ACrzQf1Lrr5VyZz9pWImWD4QT01ZbwNQZ0Twz8xNJxdNTKMztLKN4HeM
        XuVzP3FX56tUWEy/20Yqxxjd6Sf3DtdXPJRvdo/FjCLwtlk=
X-Google-Smtp-Source: AMsMyM6TWlffPm2NhzhPMpDHWJ7vQjbA7Kdk+SXNums04xc/5fH3UzZ48rtJuLU8M+7f5WqkQMIJWkoF20YdR/IBeKQ=
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id
 d11-20020a1709064c4b00b007ada197b58emr53429067ejw.203.1667904619249; Tue, 08
 Nov 2022 02:50:19 -0800 (PST)
MIME-Version: 1.0
References: <Y2nKIbKxHAMimxII@google.com>
In-Reply-To: <Y2nKIbKxHAMimxII@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:50:07 +0100
Message-ID: <CACRpkdaW-dwKNtTQ2_Mj4JpG34N3m19g+s5xcs3Xj=2kAdE0cw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: request pins non-exclusively
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
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

On Tue, Nov 8, 2022 at 4:16 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Commit 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()") changed
> qe_pin_request() to request and hold GPIO corresponding to a given pin.
> Unfortunately this does not work, as fhci-hcd requests these GPIOs
> first, befor calling qe_pin_request() (see
> drivers/usb/host/fhci-hcd.c::of_fhci_probe()).
> To fix it change qe_pin_request() to request GPIOs non-exclusively, and
> free them once the code determines GPIO controller and offset for each
> GPIO/pin.
>
> Also reaching deep into gpiolib implementation is not the best idea. We
> should either export gpio_chip_hwgpio() or keep converting to the global
> gpio numbers space until we fix the driver to implement proper pin
> control.
>
> Fixes: 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Wow! Thanks for fixing this!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I just sent that patch into the SoC patch tracker (soc@kernel.org)
with a not to apply it directly, I suggest you do the same (or ask me
to sign it off and send it).

Yours,
Linus Walleij
