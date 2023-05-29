Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AF715087
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjE2UXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjE2UXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:23:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF42B7;
        Mon, 29 May 2023 13:23:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f7bf29550so574026266b.3;
        Mon, 29 May 2023 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685391825; x=1687983825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFRAydikPWX3pKUDK3/GeTj1gN1x9t62tUlv+AAMNb4=;
        b=N0cvIK20DWhi3/jzCpW+vil3DjAaDTVwae9+znU4tOXniLKEfesgKC0Uw5KwZsJ8A8
         utsCxSTqkBiAWbCjF0QUcDu8pfbnmuON/H9YuLgDJ3J/CuBB/BAVjwnnQPNG7aOW4rEX
         E9W1gth1xJfVEshEm4H5R6Bu1SHPbq4iP9MUbLE3lGPmx57VdTQhWAuvW/4+NqD6fuyN
         Tb07M+Wy8CdCV1YOdD1/WMvJGT4S8t+Rm6jm6+GPgMU/M1fnqC8QpIixR2ARhd/X/vNd
         6UqHQvJuMKlXPjwW8kVpzXYxY5qLo5v1f5N/1AG4yoMGrVJo/7ED4otf2rOMTywdN5Ck
         vyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685391825; x=1687983825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFRAydikPWX3pKUDK3/GeTj1gN1x9t62tUlv+AAMNb4=;
        b=VXe1PiRwo3zVYVelrMeaA25Hk9NBYh69ztOpYttGuiOoHdBIiiojEr+kO6qkVXvGC9
         W4+lEw6J9x4rpNeuieTFjYeycpfZoDHjtxYH4pNNRp66308ObnsrNBpKGLKjiCGOy4tk
         hvzM5+DUj+hSNigymzvjyf0qtSzstLYzCBrHJS3MtQARtPT+ybewd3IrRMt8OQ7V6RYK
         fkwVMEMqIHPUv1apwqoczYqPgaFWPWwFPsXlHQbqtmlajCwUNQDOvCSmfXQua5l2ibJx
         +gxNbcnbT92XN45rDc9yzVCXkQu4HdOW64yl98UeYPTfAn7pysT0knqsk6j1heGiUPMF
         +ydA==
X-Gm-Message-State: AC+VfDymwm8yBLqbkv3jWJaK/eIF7+9QeHZ5JCh9Ra6U4+9nCsB8uqLs
        3axEE1ftpy23YO6WUtphgf7+2zZxmgK+9Fmsz/k=
X-Google-Smtp-Source: ACHHUZ4U9hAAYqL77TzPMBvjLDtEWUIjr70SENM4Z8K9RbkxNwGJXVYJGzi1/9xSXn/jCG1x4JnLMwOlIIEvXc4MlAc=
X-Received: by 2002:a17:906:7945:b0:965:6d21:48bc with SMTP id
 l5-20020a170906794500b009656d2148bcmr275685ejo.75.1685391824685; Mon, 29 May
 2023 13:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru> <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
 <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021> <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
 <20230511132606.vk52yorf43alwgew@CAB-WSD-L081021> <CAFBinCCmNLQF_qV3k4kgDEAsemEsjL-GQtPex7Pmxrc2sHx30A@mail.gmail.com>
 <20230529134944.dh7isqg5ontfbtpa@CAB-WSD-L081021>
In-Reply-To: <20230529134944.dh7isqg5ontfbtpa@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 May 2023 22:23:33 +0200
Message-ID: <CAFBinCBP_pniDTSwBuFBL8YA-GnCuDHn=nCMn9XHXs=_7DFjkA@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hello Dmitry,

On Mon, May 29, 2023 at 3:49=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> Hello Martin,
>
> As I promised before, I'm now back with the vendor's reply regarding
> AUDDDS. The information is still incomplete, but I have provided the
> available details below. Please take a look.
Great, thank you for following up!

[...]
> AUDDDS is a direct digital synthesizer used as a clock source.  It is
> not used as default. You need to modify some clk registers in dts to
> enable it. Basically, it is used for audio.
>
> In A1 design, you can use AUD DDS as a clock source and it is not
> necessary. It is not used in the Amlogic default setting.
>
> According to the vendor, it is not necessary and is currently disabled
> by default. While we don't have much information about AUDDDS, the
> vendor suggests that it's not a commonly used clock object in A1
> projects and it may be skipped if not needed.
My goal is to make the dt-bindings match the hardware implementation...

> Based on all above information, I suppose we can skip it now.
...but in this case we simply don't have enough information (other
than some register names and a high level description that it can be
used as a clock) to do that.
I still think we did the best we could for now, so I agree with you:
let's skip it for now (and hope that retrofitting it later - if we
ever need it - won't be a problem).


Best regards,
Martin
