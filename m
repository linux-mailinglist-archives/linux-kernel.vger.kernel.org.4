Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F16ED43D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDXSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:17:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B27EED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:16:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32b4e379000so13341845ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682360184; x=1684952184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j798mRgzagav4OXiZ0yBmBHNPfVDqUqZ2VrQzSezYUw=;
        b=N3cz31Io2oZqrF4wM47UT59U/8cwec6KWT8Xp2Y+c8jbrjGcgBDxxX/GpFTcXbM3vT
         tEf1LpsMfdq5oXlQXtKn28JRBkYoP8sRPlzOj4RYbs+/iT2z+iXVA96lCsT1Eroo4qR7
         VcOZ8Y8LHPJef0jYYVIBY0wWLowcXLHPflEA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360184; x=1684952184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j798mRgzagav4OXiZ0yBmBHNPfVDqUqZ2VrQzSezYUw=;
        b=JxnVgsWRIfu+dguSi+52T1oGqmEa8ojhntxHHn/v9z79EtjgU0SsX7QcT7j6xai2B+
         IFLMCzR55GwFBW0kLBEutmvbaxU0MoQ6lhRxiCV9WWsfEliIKtutHAJcqZu6Y32WLOk0
         pncfPQIYT5Sn7m2lQ/fXAk4BL2Iln4KpKvzugQJg5H/SBpbobnGMFvz1Auna9Lc4m3DW
         Whx73gLufpuvxNHbfWmARzN8ylfw+4DBkO2v21Cv/tiNDZXTFSzKslkD2vAr7SksMhiy
         34fcDSrhWaT+Yg6RssEyIEOZkTmrlxo9MXee5CwR2U5DBRGsymmC4LX6EsL/fa2Al0wm
         ji9g==
X-Gm-Message-State: AAQBX9dL7EQ+HC8ljgydkzG7TOw81r4mGJnvVebaIHokJPpECw2oj5IT
        nsnouB48wBs7ejh4ffQj9cFTpoQKTKdnFCcG+qk=
X-Google-Smtp-Source: AKy350YLswjOl7pz+o5m1uteRFXf4ubNMDBdJ/t4/3d7fRQOANOxFigR+J8AF+IvgJgW+P0szj5KVw==
X-Received: by 2002:a92:2904:0:b0:32a:ea4e:97d1 with SMTP id l4-20020a922904000000b0032aea4e97d1mr6798329ilg.10.1682360184605;
        Mon, 24 Apr 2023 11:16:24 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id cl13-20020a0566383d0d00b0040faf05071asm3422648jab.156.2023.04.24.11.16.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 11:16:22 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-325f728402cso1100315ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:16:22 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b83:b0:32a:f2a9:d1b7 with SMTP id
 h3-20020a056e021b8300b0032af2a9d1b7mr19498ili.10.1682360181408; Mon, 24 Apr
 2023 11:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230418124953.3170028-1-fshao@chromium.org> <20230418124953.3170028-3-fshao@chromium.org>
 <ZEX5tc2LSZoVswc2@nixie71>
In-Reply-To: <ZEX5tc2LSZoVswc2@nixie71>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 11:16:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnrSskS=0UKRGGPBxSnPYQtUkJeoBm44bDnwKVBHJLyA@mail.gmail.com>
Message-ID: <CAD=FV=XnrSskS=0UKRGGPBxSnPYQtUkJeoBm44bDnwKVBHJLyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: goodix: Add support for
 powered-in-suspend property
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Fei Shao <fshao@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 23, 2023 at 8:38=E2=80=AFPM Jeff LaBundy <jeff@labundy.com> wro=
te:
>
> > @@ -37,13 +38,34 @@ static int goodix_i2c_hid_power_up(struct i2chid_op=
s *ops)
> >               container_of(ops, struct i2c_hid_of_goodix, ops);
> >       int ret;
> >
> > -     ret =3D regulator_enable(ihid_goodix->vdd);
> > -     if (ret)
> > -             return ret;
> > -
> > -     ret =3D regulator_enable(ihid_goodix->vddio);
> > -     if (ret)
> > -             return ret;
> > +     /*
> > +      * This is to ensure that the reset GPIO will be asserted and the
> > +      * regulators will be enabled for all cases.
> > +      */
> > +     if (ihid_goodix->powered_in_suspend) {
> > +             /*
> > +              * This is not mandatory, but we assert reset here (inste=
ad of
> > +              * in power-down) to ensure that the device will have a c=
lean
> > +              * state later on just like the normal scenarios would ha=
ve.
> > +              *
> > +              * Also, since the regulators were not disabled in power-=
down,
> > +              * we don't need to enable them here.
> > +              */
> > +             gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> > +     } else {
> > +             /*
> > +              * In this case, the reset is already asserted (either in
> > +              * probe or power-down).
> > +              * All we need is to enable the regulators.
> > +              */
> > +             ret =3D regulator_enable(ihid_goodix->vdd);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regulator_enable(ihid_goodix->vddio);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Please let me know in case I have misunderstood, but I don't see a need
> to change the regulator_enable/disable() logic if this property is set.
> If the regulators are truly always-on, the regulator core already knows
> what to do and we should not duplicate that logic here.
>
> Based on the alleged silicon erratum discussed in patch [1/2], it seems
> we only want to control the behavior of the reset GPIO. Therefore, only
> the calls to gpiod_set_value_cansleep() should be affected and the name
> of the property updated to reflect what it's actually doing.

This would be OK w/ me.
