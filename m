Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2472310D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjFEUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjFEUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:19:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18594170C;
        Mon,  5 Jun 2023 13:18:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so46258891fa.1;
        Mon, 05 Jun 2023 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685996320; x=1688588320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DmAqdFCTWcCnSv3cNxtbIKYt0BJjIXyl6B4XL9Pfx4=;
        b=pAuJ/+en+DXnrhMOQmfLxIW5mtJj9bT2iORrZSmomltq7qrdY4y7ND8wjL+6Nbpoue
         JmE18818aJ0/b+W0fnoSO68NXR5Ym2tBOgAR1mlL5g3UkHvj8Cn+xcpDTy9KBOm6vEBk
         jy6EgYeukLRAGRSZb9J+i5cfBNWCwvT0dn/IqWiFUbYiST+nkMxC+IBIlfAr9Z7b1NXM
         340Vkmw4j3hgOgdZT40piHPcAqoCpiI91PxJ5R3HWJqSmLrij2msaV21cTDwYpaCMZGI
         0XO0HznaoKlIWKUw5GlH32p0gTPyMO4MpCwWlXPxwIB7BrDIBUK8uKtW/kS9wg+9e/cD
         DeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996320; x=1688588320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DmAqdFCTWcCnSv3cNxtbIKYt0BJjIXyl6B4XL9Pfx4=;
        b=BkMKWUbvQXEyqr+vafpFwWP4YLRKEBl5c22eCR/VQjXLOq+01+BHkJCp4zNzyhtV1r
         8WqKwOpSenRbLtU6B8PRCwKUNBY3TQ8kuaQrrotFy0HiSqLyBNRsAylW9upSUFioTlME
         YchvjASabKh3XCEbbhqQgPNhhq/WMIXJaHNB7Mw3g+lxcQDStg/Ml6xub7OBaR/nJgyf
         pXqOFSjerb+zdkZ49t9WfZ0ux7vAisbNi8B+RkDVYQNLmuSMkHhboq1dZskBjcPNnSxO
         iETHU9SHPU1aE+haEl/hj8uMKWi4jYkvcHL8iDQheE5HNifCvi32Zy9yCCz49srlS0SW
         UStA==
X-Gm-Message-State: AC+VfDz2dvfxof4dhvuEpFkozPU1HWK/pqvON9P1mNYgF3dd2vOYb9n7
        Vvyk24qROCCklzLBzcRF1LOLuBls5n1hmA0z3TE=
X-Google-Smtp-Source: ACHHUZ4nCyRkQvzS2d4v2PHRMh6yMoQjq2Po298dhjhuNHkip3zW6T3mYtWCy6AV+0gnVai4bxaMbvgxz0U0qN//wiU=
X-Received: by 2002:a2e:88da:0:b0:2b0:770f:c83c with SMTP id
 a26-20020a2e88da000000b002b0770fc83cmr214990ljk.4.1685996319762; Mon, 05 Jun
 2023 13:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in> <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
 <6910550a-b025-0d97-0b39-bc89b235541e@sberdevices.ru> <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
 <dcb05f27-4c6d-0544-ff0d-288a6848ccaf@sberdevices.ru>
In-Reply-To: <dcb05f27-4c6d-0544-ff0d-288a6848ccaf@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 5 Jun 2023 22:18:28 +0200
Message-ID: <CAFBinCCnAVveiYEOSq=KkBq0kRJti7eWgfRxqiTkQWe9i8mTzA@mail.gmail.com>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     George Stark <gnstark@sberdevices.ru>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>, Vyacheslav <adeep@lexina.in>
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

Hi George,

On Thu, Jun 1, 2023 at 10:56=E2=80=AFPM George Stark <gnstark@sberdevices.r=
u> wrote:
[...]
> Here the test I promised:
> Question: what's the real size of clock divder field in SAR_ADC_REG3 regi=
ster in saradc in meson8 socs?
> The current kernel code says 5 bits
> The datasheet says 6 bit
>
> The parent clock of adc clock is 24Mhz
> I can check it here by:
>
> # cat /sys/kernel/debug/clk/clk_summary
>   xtal                                 4        4        1    24000000   =
       0     0  50000         Y
>      c1108680.adc#adc_div              1        1        0      1142858  =
       0     0  50000         Y
>         c1108680.adc#adc_en            1        1        0      1142858  =
       0     0  50000         Y
>
> for divider width 5bit min adc clock is 24Mhz / 32 =3D  750KHZ
> for divider width 6bit min adc clock is 24Mhz / 64 =3D  375KHz
>
> I suppose that the lower adc clock rate the higher measurement time
> so I need to get measurement time at both clk freqs and the times differ =
so
> 6bit divider is really applied
>
> I performed test at Odroid-C1, kernel 6.2-rc8
> Two kernel patches must be applied:
>
> the topic starter patch and the helper patch at the end of the letter
> In the helper patch I turn on CLOCK_ALLOW_WRITE_DEBUGFS to change clock r=
ate from she shell
> and use ktime_get_raw_ts64 to measure measurement time
>
> So the the test itself:
> cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_v=
oltage3_raw
> [ 1781.226309] =3D=3D=3D=3D freq: 1142858 time 42408000
>
> # echo 750000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
> # cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in=
_voltage3_raw
> [ 1790.728656] =3D=3D=3D=3D freq: 750000 time 49173000
>
> # echo 375000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
> # cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in=
_voltage3_raw
> [ 1816.955477] =3D=3D=3D=3D freq: 375000 time 68245000
>
> # cat /sys/kernel/debug/clk/clk_summary
>   xtal                                 4        4        1    24000000   =
       0     0  50000         Y
>      c1108680.adc#adc_div              1        1        0      375000   =
       0     0  50000         Y
>         c1108680.adc#adc_en            1        1        0      375000   =
       0     0  50000         Y
These results looks excellent - thanks for sharing the test results!
Could you please check one last thing:
$ grep -i adc /sys/kernel/debug/meson-clk-msr/measure_summary
It should confirm that the clock rate is 375kHz (or close to it, SoC
internal clock measurement is not 100% precise)

Once we have that confirmation: can you please re-send the patch with
the description updated so it's clear which SoC generations are
affected and by stating that the fix was tested on a Meson8b Odroid-C1
board.


Thank you and best regards,
Martin
