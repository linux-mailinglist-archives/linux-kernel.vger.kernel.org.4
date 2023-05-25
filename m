Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878B710893
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjEYJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbjEYJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:17:24 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F22A19D;
        Thu, 25 May 2023 02:17:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-623839d5c19so5588186d6.1;
        Thu, 25 May 2023 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685006242; x=1687598242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSSOPPh09pX4vWeBhoLFDRwZW9nZ5Myb1cfl7wwliIU=;
        b=k6EvXFNOttKfq/rXbP9exD5k2Z7WlJQRxqkwBEv+MqMNs2XRAIQLBPcChB4r0c7lLv
         9yGGMUYV1DL+F0SRpMlUa7bQgfUKMCsrn4p8R1fYSyRBPxqr+1rzNAMWIXGTZMYlvCTI
         sQ5FeJCxSUDoqSGXRm+hHRgAVbhGHp1Gv9UpGJMB3xe29m4AckLVBbm0CrzFAuct+iLB
         PgO3bXO+vhneyM0mL+4AtgNbYwgZChj3gqAqC/89ZXy0ItcxTR8G7SjwMCV/RYxbfaHS
         sGyPMkF3DG8pggkea0urFulae9VZhktp6Sc6s0gYroW4v7WedxzPAK+as2Vdu+iLEYrG
         rFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006242; x=1687598242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSSOPPh09pX4vWeBhoLFDRwZW9nZ5Myb1cfl7wwliIU=;
        b=DkUo80MPQQTNks8gKtpqWIQjoTQikgQKUk3L3sgEcLeoloGmbhHEzz859HyDhoiW4g
         6KHyoUYuWF7cN7KBy3R6DNOKSaAU1I1j7fROHkowXLPBckOOjn65UyJH60pVR2XMI2Lg
         226y8iWaACl2Oy8dwtEaWb0Zqic4ikm0FsrhXwwktrbvGjWHgEHxazGpDyXnmcr5+1NI
         LPvgYY+zk/dKgtwdH1YksGJiVpoXw5vDlQbrj0d2xivDOwDXfBIkI5Mqhzh/3x/MaUfS
         /M1JsQI2wwdVC9HDtSOHjmHiWYUCPNII2wtxjg9h2iXXTcZAZPKm2rbCLn4PShCYZ8zw
         TLdQ==
X-Gm-Message-State: AC+VfDzEY6zWOHls5tlT+TCAp+FjC/RCitcX4C+nFKSh3AmnDEn6+INN
        gYPnV7tOpmTrY8KPtjc/SEkqxXtHlPH/hkojuGAMAaVdX/M=
X-Google-Smtp-Source: ACHHUZ4Fu02dvgfixrEz6YPfB54tYEIwzBIOsvF4hnRLKndonIEzJBb6Df0tRkwwnrHWcTFPgIoJZJ8mqJ13hbl02mI=
X-Received: by 2002:a05:6214:19ef:b0:61b:6e43:b20 with SMTP id
 q15-20020a05621419ef00b0061b6e430b20mr545982qvc.42.1685006242514; Thu, 25 May
 2023 02:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230522071030.5193-1-zhuyinbo@loongson.cn> <20230522071030.5193-3-zhuyinbo@loongson.cn>
 <ZGy3b7ZfNwWoGDTu@surfacebook> <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
 <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com> <2a72a2c2-6fda-1ea8-3b27-5623cc1132aa@loongson.cn>
In-Reply-To: <2a72a2c2-6fda-1ea8-3b27-5623cc1132aa@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 May 2023 12:16:46 +0300
Message-ID: <CAHp75VdMSM7VMFn8BDJpx2PJOR8DJtP0GF=sTECnMhz+MoSJ=Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Thu, May 25, 2023 at 6:34=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn> wro=
te:
> =E5=9C=A8 2023/5/24 =E4=B8=8B=E5=8D=884:42, Andy Shevchenko =E5=86=99=E9=
=81=93:
> > On Wed, May 24, 2023 at 10:52=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn=
> wrote:
> >> =E5=9C=A8 2023/5/23 =E4=B8=8B=E5=8D=888:54, andy.shevchenko@gmail.com =
=E5=86=99=E9=81=93:
> >>> Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:

...

> >>>> +    ret =3D loongson_spi_init_master(dev, reg_base);
> >>>> +    if (ret)
> >>>> +            return dev_err_probe(dev, ret, "failed to initialize ma=
ster\n");
> >>>> +
> >>>> +    return ret;
> >>>
> >>>        return 0;
> >>
> >> It seems was more appropriate that initialize ret then return ret.
> >> Do you think so ?
> >
> > What do you mean and how does it help here?
>
> I'm sorry, I was wrong before and the ret varible seems not to be
> initialized and it always record the return value for
> loongson_spi_init_master.
>
> It seems was appropriate that use "return ret" and I don't got your
> point that in probe for use "return 0"

In the above excerpt you will return anything except 0 with return
dev_err_probe(); line. Why do you still need to return ret; at the end
of the function?

--=20
With Best Regards,
Andy Shevchenko
