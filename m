Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12686B01E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCHIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCHIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:46:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122D8FBDF;
        Wed,  8 Mar 2023 00:46:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so62475043edb.12;
        Wed, 08 Mar 2023 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df/YEZAmTHHgOJZzimpFENNOzrkQQXivqI+e8opz+MA=;
        b=fZJQ/3AclEHsAaSulaH4QkRMYPbVEMz+Het7X5ivxrbTUt3W1vF6V5FSY5bAjwVJmA
         5Dakc9aLrhDad6x0INdMOeq8xXrDs13nWWr/pVt9EXtt1YaPOU9KSjRg3o2QzfjavI58
         78+t8L+W9dqbQevl73xEFcPslj0jwyNAdTFiIN/KsoZmISpKrPSHDnhjESox4Frjgihe
         qQkE6RNz8vgGUY4Xl0SeVfHXdXxhIMxzBFij2CMVmdRvl/3h+67zeVx6V8acvtP5BWp/
         66jgpat0dDIDjOX+TOoeQG8vR3TVbQBBt3ndiLvs2wmeNYS+6WMTARJUGQXqRHOhRkVc
         S1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df/YEZAmTHHgOJZzimpFENNOzrkQQXivqI+e8opz+MA=;
        b=mzwtpViOkB3iXZO/JMRLJSzRdXzYNHc/eBojYy07BY6/QRXdQ+pQml/lsVONPBQ8JP
         O8/fSR/BIciwyhYSGGCEnwFhVpuz5Up0dEbuftAK/bE0oAE8rs/RYcCblHS7yR5qcayI
         177oPyAhyoaSiqcd82eZ9UaJQY4crnH0Jii2yjrba/ukoi/TAjQfWUQETBjSTBnr74Ck
         Jq1neWlyM0RihabJX0EtJEjEGKakQiSu3PcF67DTdUUc/Q6aj5/pMhAAAqMr+CLsysHZ
         GmtZVRR4xoeRLY/u0KrZ67mXDuGjhqN20kNj+1vJNWxTIjfQbbdxf2ijRa1JcoJeT0Lz
         LdPg==
X-Gm-Message-State: AO0yUKVGtfP8dTKSgXlpxxKiAVS3613cUHaShww+CRItOsMxAkNb92kH
        53havzdZUuz1IXRIv79pxVX7KZlykzEtXQ/ztmZQpBIWviM=
X-Google-Smtp-Source: AK7set8HhAHXD2Hw5RZlDqVvV4+JnaxyaXuqxPjd9OvQ2XIaYoNvMQAk+GMxc3uwWpBHasVb6GCTt6SK/GNNdLrs6G4=
X-Received: by 2002:a17:906:3090:b0:878:b86b:de15 with SMTP id
 16-20020a170906309000b00878b86bde15mr8945905ejv.11.1678265185008; Wed, 08 Mar
 2023 00:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20230308083759.11692-1-clamor95@gmail.com> <202303080844360ced8b82@mail.local>
In-Reply-To: <202303080844360ced8b82@mail.local>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 10:46:13 +0200
Message-ID: <CAPVz0n2XErDOCERV+XO3ek4_15hiwTasy4agLZLijqx2z67UnA@mail.gmail.com>
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 10:44 Alexa=
ndre Belloni
<alexandre.belloni@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> the subject is not correct, please use the subsystem style
>
> On 08/03/2023 10:37:59+0200, Svyatoslav Ryhel wrote:
> > MAX77663 PMIC can have RTC on both 0x63 i2c address (like grouper)
> > which is main address but on some devices RTC is located on 0x48
> > i2c address (like p880 and p895 from LG). Lets add property to be
> > able to use alternative address if needed without breaking existing
> > bindings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/rtc/rtc-max77686.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> > index b0250d91fb00..218177375531 100644
> > --- a/drivers/rtc/rtc-max77686.c
> > +++ b/drivers/rtc/rtc-max77686.c
> > @@ -691,6 +691,7 @@ static int max77686_init_rtc_regmap(struct max77686=
_rtc_info *info)
> >  {
> >       struct device *parent =3D info->dev->parent;
> >       struct i2c_client *parent_i2c =3D to_i2c_client(parent);
> > +     int rtc_i2c_addr;
> >       int ret;
> >
> >       if (info->drv_data->rtc_irq_from_platform) {
> > @@ -714,8 +715,13 @@ static int max77686_init_rtc_regmap(struct max7768=
6_rtc_info *info)
> >               goto add_rtc_irq;
> >       }
> >
> > +     ret =3D device_property_read_u32(parent, "maxim,rtc-i2c-address",
> > +                                    &rtc_i2c_addr);
>
> This property needs to be documented
>

max776xx pmic has no yaml to document

> > +     if (ret)
> > +             rtc_i2c_addr =3D info->drv_data->rtc_i2c_addr;
> > +
> >       info->rtc =3D devm_i2c_new_dummy_device(info->dev, parent_i2c->ad=
apter,
> > -                                           info->drv_data->rtc_i2c_add=
r);
> > +                                           rtc_i2c_addr);
> >       if (IS_ERR(info->rtc)) {
> >               dev_err(info->dev, "Failed to allocate I2C device for RTC=
\n");
> >               return PTR_ERR(info->rtc);
> > --
> > 2.37.2
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
