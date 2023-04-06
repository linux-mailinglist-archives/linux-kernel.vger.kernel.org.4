Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198C6D992A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjDFOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbjDFOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:09:30 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492309EC6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:09:05 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id d18so34528295vsv.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680790144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6btDYVV70ful2ZnPUZYxEqtx9HsYWtzma3QlwZsKhM=;
        b=XPexRhUycjAbqY7F6iS92F5klCcV1kYHC4IC7xtEhJgA03hsUtG1vTJSlyZi3j8MBw
         FMWO9VaIk772QS7IahDtmS9XM+R+KWT/VygFBb1LtGyWaEi/GeIVuLPDJbbQGOX0snJO
         ZV22Lge83u6nYgLCQrEwhS8kxMJZdTTVcfv+uRf48Ty5x5eTyLVAdELOuTK0uKPIchMq
         wqmjeD7DTMRvv5uq7maLrVEtLnRlNWvy9UWhFpl+k/qc1j0W122sQvHq9LMOvoHsGmSI
         WVEAnqX1I4x2UOtIt0D8zrKTPR6hrPjwbQLHacL/0SHpDmLgW2MprxJwqAmRj+nA/3AB
         2NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6btDYVV70ful2ZnPUZYxEqtx9HsYWtzma3QlwZsKhM=;
        b=AagDqfC5Rt0+qEPNY4gvO8wVstGfOCST1FJQScvOInMIPHadvFnbqRCXUXfzvyjmZT
         O+OEqhBcjdB72c1947fTTUROS78fMnvTk90uKFw6ZCiCi7AeTLXsuUYUnkF8SyoKNViW
         Tgytp+ht+sLkRENmjom/noFQPSJqhsA8AtGLQChVxevowGsdciBrmJBHZU17UVWx8BKL
         OMf8UR8vsDWVIdyohw6iv4734JjDJFV+MGqSecX9cX4MLK6f5XDOBYp7OYvxTHBAM+46
         vIGJOglN2YIg+bSpcN3xFP+ZrHGQuwqN4JR2tS7asTnYY0w8wjBvS+/MoY+moFKw5AZ3
         /rAA==
X-Gm-Message-State: AAQBX9d3EY6O+XsyZc5cfRxa1ohlzqa8CMY/xqwZ13BYylutorCawZK+
        kizbTyUit6lVm7u8auFuALcOb77TFECgkOQn0j2/BIQtf8Mw+lKk
X-Google-Smtp-Source: AKy350ZaONbGJ6aVu1czJ5Xo7X/it3oMWmIuQB2/6/R8krtVE4z/gHSX9Sm/mbZvZuEfNC2wjGij+3zWIxU0g/Hu7qw=
X-Received: by 2002:a67:d29a:0:b0:426:7730:2157 with SMTP id
 z26-20020a67d29a000000b0042677302157mr7325268vsi.0.1680790144095; Thu, 06 Apr
 2023 07:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230327125316.210812-1-brgl@bgdev.pl> <20230327125316.210812-13-brgl@bgdev.pl>
 <CACRpkdaYHaJMn7w_q12V3Q0WW71-U_kb+XsR1tNsirF35xYEoQ@mail.gmail.com>
In-Reply-To: <CACRpkdaYHaJMn7w_q12V3Q0WW71-U_kb+XsR1tNsirF35xYEoQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 6 Apr 2023 16:08:53 +0200
Message-ID: <CAMRc=Mf3d+ZmRs+Rj2HeWifoL0Vqzszxh_hUFDFq4eyvfgKQ4w@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] dt-bindings: pinctrl: qcom,pmic-gpio: add
 compatible for pmm8654au-gpio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 3:24=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Mon, Mar 27, 2023 at 2:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a new compatible for the GPIO controller on the pm8654au PMIC. It
> > has 12 pins with no holes.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Counting on Bjorn to pick this up.
>
> Yours,
> Linus Walleij

Linus,

Bjorn picked up the arm64 patches but these two were skipped. Can you
take it through the pinctrl tree?

Bart
