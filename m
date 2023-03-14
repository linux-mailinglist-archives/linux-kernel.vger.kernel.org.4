Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166806BA1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCNWEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCNWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:04:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACC244AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:04:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so332953057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678831483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miJsRXoa9DtW30zxnEdso0UfWvRugY2awbgfkixJ034=;
        b=S9TrsILsmtNBqOKQqZF0Qp/VedPbvyPYPHDbTNNxO90nkgSEdFa/4qmozwSaCu/rQd
         cjFRamvlqBqQVAWoxYUftHvxCJFgxedKOpad9iCcLHWyyzLGO0lmzTZaLiDqoOTIvdj/
         aqG/TRyS5TnWSsDDuntf+1czyXrjEiovdRynL+YBH5qgArubIo7onCRcN+ek3pfxT7Vd
         TARIAceYjIyiPH/EnaxnDuDfh+V8LerDiJP1XJFKZLEbD7ZRzo7X52ettzyQCRXiLSRg
         77G/HHkijU97K1NOxZO/vlmqwXoCFiWf/awqk0nm1dhtqcARRJSyO2VnRG8ZdYk8T7fW
         fu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678831483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miJsRXoa9DtW30zxnEdso0UfWvRugY2awbgfkixJ034=;
        b=tZD70mKMucUyEigh2+WLEZMRvOV+SEa4t8B/FbW5Z7JHP5CQl3I9qDOnHB96o5syw2
         LZ3ZvZPDFIPZRDO7x4bLZaaWHf4rpSk2N2AkL3Xq/MO2Zr7OXGSziLF+UgdWh7T4C8Eq
         jR+eUlW+0C2WavpqxISquGzqEdTZv6FPJzzgloY6QIx56wcy5fCcAa0Us0bImmOmihZ7
         W/WxFS9WTUAP5urPzUWdzj7uBGs3QalxWVq/UbAbM/DWhw9Tax+OLBWjgUr1XErlTQVd
         Q8ozfYrw/3j3zcIczW6mwwpspDzMVcZShAuyzKkJA5X+sSYQr62JHI4JVIxQfTzKVXU5
         A3jQ==
X-Gm-Message-State: AO0yUKUIidAxOUTH9chjCJFWmTYcxK7DJL044974LHXRzK9WW0lnVEdG
        lxAblVO6sp/i0VJDMaYPulMMs8uonKrN4bdToK02vQ==
X-Google-Smtp-Source: AK7set9WBnHIldb2qAj0WVjuGFG6x9B8lzgHIOyZI4nF5WwsQAcksLE2/hVXcd7Z2LVhEOoVJlXYAyWwMAQALzoAs5w=
X-Received: by 2002:a81:b149:0:b0:530:b21f:d604 with SMTP id
 p70-20020a81b149000000b00530b21fd604mr18465664ywh.9.1678831482993; Tue, 14
 Mar 2023 15:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com> <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
In-Reply-To: <CACRpkdan0Vt_T3aRVAK4rd=hQV=MOARm9Wq7sD8rjoisTW6Dkw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 23:04:30 +0100
Message-ID: <CACRpkdaNOf+spm2PDVfnKAOBfdg+C9DdSAWiW3nkNLXd3zyL=A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc_parse_channel()
To:     Kasumov Ruslan <xhxgldhlpfy@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:12=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Tue, Mar 14, 2023 at 8:37=E2=80=AFPM Kasumov Ruslan <xhxgldhlpfy@gmail=
.com> wrote:
>
> > The left side of the loop condition never becomes false.
> > hwchan cannot be NULL, because it points to elements of the
> > hw_channels array that takes one of 4 predefined values:
> > pm8018_xoadc_channels, pm8038_xoadc_channels,
> > pm8058_xoadc_channels, pm8921_xoadc_channels.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> I am not impressed with that tool. See below:
>
> > Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOA=
DC")
> > Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
>
> (...)
> >         hwchan =3D &hw_channels[0];
> > -       while (hwchan && hwchan->datasheet_name) {
> > +       while (hwchan->datasheet_name) {
> >                 if (hwchan->pre_scale_mux =3D=3D pre_scale_mux &&
> >                     hwchan->amux_channel =3D=3D amux_channel)
> >                         break;
>
> NAK have you tested this on a real system?
>
> Here is the complete loop:
>
>         hwchan =3D &hw_channels[0];
>         while (hwchan && hwchan->datasheet_name) {
>                 if (hwchan->pre_scale_mux =3D=3D pre_scale_mux &&
>                     hwchan->amux_channel =3D=3D amux_channel)
>                         break;
>                 hwchan++;
>                 chid++;
>         }
>
> Notice how hwchan is used as iterator in hwchan++.
>
> What you are doing will cause a zero-pointer dereference.

Nah the AI is smarter than me this time, I'm wrong, I think :(

hwchan is indeed never NULL here, and the code immediately
after unconditionally dereferences hwchan->datasheet_name.

Who wrote this convoluted code again:
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  759)
 chid =3D 0;
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  760)
 hwchan =3D &hw_channels[0];
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  761)
 while (hwchan && hwchan->datasheet_name) {
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  762)
         if (hwchan->pre_scale_mux =3D=3D pre_scale_mux &&
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  763)
             hwchan->amux_channel =3D=3D amux_channel)
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  764)
                 break;
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  765)
         hwchan++;
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  766)
         chid++;
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  767)         }
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  768)
 /* The sentinel does not have a name assigned */
63c3ecd946d4a (Linus Walleij    2017-04-04 14:08:19 +0200  769)
 if (!hwchan->datasheet_name) {

Oh that guy ...

I wonder if we can make it look better and less unintuitive.

Yours,
Linus Walleij
