Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC42C74E033
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGJVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGJVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:25:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F65C0;
        Mon, 10 Jul 2023 14:25:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so5459456f8f.1;
        Mon, 10 Jul 2023 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689024354; x=1691616354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZNC3U+svTWZHED23Hj8Ir5VoFZeTjzE5AyMvE+V+PI=;
        b=NMFpF2XqB8+cBs1tqoYE49RKuX6tmqDvpHUMPWWE3UCfli2ckqE363ro+yFG59OvQt
         LkvGFFkhC4Nn/ObVuePB/0EZXN4lfcHKg160ZCo0z95UFZsDkYimvN/4ENTEswspmchv
         UGIcXVs05ysV4IQ9Usvg3FU4atbikbt0XDubTJVNcBb5v3n6bz+LRFrdY0/Eru++BLLB
         Zkq9JgEDrfwOUAMvDUgj2pFYr2TKm6fMnfiM4ZgCTc1rABqMBHEwDwzeUwOwve9wZsjZ
         Lv8Nt9aBtPdy5mIQnkTFF4vEc+CyDcwJqKdlG9CGb5eHTGWs/4s9/N2cbvHMsBb75eAV
         MKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024354; x=1691616354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZNC3U+svTWZHED23Hj8Ir5VoFZeTjzE5AyMvE+V+PI=;
        b=hVrn70HJSMogvaHkb/SpbVC2qG2hOr+kxrDjt/qrYBv1NLUWiM56a6k1NOaktf5XmN
         JGbRjLUrRi8Y3ORGX2KFX276heerl8sV1FJulgL99q5OYwkCq4vtvwDDA6otRsiTimeB
         9PdTTU5dOhsyNvjRmGW3VRGUAgGXF0XHXCsltPJDqmBM22GWhdwPK+4e5B7qRkwaiwzj
         U2zvCZ73B8y1RJvzLFusT4mWf1y/uYdetAD6GhWYHStDxFlG6QUDYdlq8O+Uqgq1uyjU
         BTVdCYF6XO8qDZTY257kPWeROvAriMntFuBh8q3diiHixtTjCYoAhL2ctKCOJvl4UqjV
         AqIA==
X-Gm-Message-State: ABy/qLbETIKGwGgCrx+grJh6ZatI4lFDg6exnH42zsvoErUig77HMSEz
        qNhA+PkdS9gSlbn/h9gWqP7zAvR+QOFHK2R9boq5dHNaqFI=
X-Google-Smtp-Source: APBJJlGrYH9e7+cmjb4kZV5QZ9QfaxSlOuglhJCLOFA0gG7JvhKs2QcYJhx5rSHb+YUwS0Ye+nfp3aJNHKCnb0FCmN0=
X-Received: by 2002:a5d:5605:0:b0:315:9e1b:4ea6 with SMTP id
 l5-20020a5d5605000000b003159e1b4ea6mr3396610wrv.58.1689024353984; Mon, 10 Jul
 2023 14:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230710212142.10566-1-asmaa@nvidia.com>
In-Reply-To: <20230710212142.10566-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 00:25:17 +0300
Message-ID: <CAHp75VfNyNfPRRte6ixzPcwxiVdwO_8t0JBRDvsASq87VWPtGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        davthompson@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:22=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init().
>
> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().

The below should be in the changelog area.
Moreover, it doesn't explain why you dropped my tags.

> The following 2 patches were approved in the past but didn't make it
> into the tree. I combined them into one patch since the second one
> fixes a bug in the first one:
> [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
> [PATCH v1] gpio: mmio: fix calculation of bgpio_bits

Please, try again.

--=20
With Best Regards,
Andy Shevchenko
