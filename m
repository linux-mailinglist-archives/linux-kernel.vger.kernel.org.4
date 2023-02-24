Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49A6A214A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBXSRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBXSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:17:01 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010113DF9;
        Fri, 24 Feb 2023 10:16:57 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id w42so342065qtc.2;
        Fri, 24 Feb 2023 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbrfWU2+v05vgW558zPyEG9XfLlb2Qbh/gfCUZwyWQI=;
        b=XxVCTehJPVgGP8dSH5G4p1FqFXEfrPHgU2eYaRv+X11mO/DuNCGQckQRBF3/LrmSY2
         D44KmJy+nLSBv0VNdeyWDfSr1OjSAQL0CGK9IRH4TJY2/nP7BB+ednlGpJZ+FrGS1jSj
         HOa5cD9M+qUROep+ycPHiZIhAp6+uKwkYNccouNORcgIcUMDL2EKOE/9w4z+BygSjH2i
         mYgcTHtSZnj9oxdi2o9wKDBf9OaqQtZA9XvPa/Clpy2HbI9KeQ4y7UafIKQPFOHmUgbO
         xDNlWkJ+kQx3glj28N05xw7N5Wpj7Qo7jLTwcCiql6K8C3GS+Z3U+gWNnUDedahlHiph
         7Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbrfWU2+v05vgW558zPyEG9XfLlb2Qbh/gfCUZwyWQI=;
        b=D+K2lkZkMYMRHaZDDvGIVsS0TnmiwoaZnn6B8bos0jQ3Y2Q1W3qS88uRr2uEyH5/0U
         DTQvSypsGnciu+Ssa0herONFPfUKXHbMkbgbPFfaXoea+e6bkjpmN+WD1+Tzt3my9c2F
         oStbmaoH4a4PZDdpVWlsTd6FUepyZEYeJT5ySQy0KvoVeAMZApCIfG+V3FZtx7nHhrH5
         eA0OK6pM38WxJNdHqr4zsJGxpgRNkDY/MUuBtIu0euAyhGb0Id8J4bup2tKBQI313asA
         lRll5u+RF8hQ4zmkK5OxDNOj2SMSkDFvp+4ZDWmMJ1ESER5XVyg+la6NdFNpOI08lJuL
         kKjQ==
X-Gm-Message-State: AO0yUKW/uTm3gtNY8fD1z2l9yy1Z6zQ5lJvt/+TtfgRKfR+HZEMJdIUX
        gRxU+rVL/fN8AnBoH4t5b5pVN5KNBw35BeU9be4=
X-Google-Smtp-Source: AK7set8PMPukDTNXLaVQNOCTO1ktYqvA4vD54uZFEKxFwUo9Q0hg2ln9c8i57jCCtLgbdMyUGKFO6/Q/BBs1/KHAm1M=
X-Received: by 2002:ac8:24f:0:b0:3bf:b93b:6af1 with SMTP id
 o15-20020ac8024f000000b003bfb93b6af1mr848795qtg.1.1677262617128; Fri, 24 Feb
 2023 10:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20230224174007.13009-1-asmaa@nvidia.com>
In-Reply-To: <20230224174007.13009-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 20:16:21 +0200
Message-ID: <CAHp75Vf_yHVhZS4ghZK5aZ7sQjdZ_1_MT=Ke6vVfUBRpL70-Eg@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mmio: handle "ngpios" properly in bgpio_init
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 7:40 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> bgpio_init uses "sz" argument to populate ngpio, which is not accurate.

bgpio_init() uses the

(Note parentheses, same for other func() mentions)

> Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init.

Thank you!

...

> +       ret = device_property_read_u32(dev, "ngpios", &ngpios);
> +       if (!ret)
> +               gc->ngpio = ngpios;
> +       else
> +               gc->ngpio = gc->bgpio_bits;

This duplicates the GPIO library. What probably better to have is to
just check the property existence

device_property_present() and do accordingly.

-- 
With Best Regards,
Andy Shevchenko
