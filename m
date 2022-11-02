Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14298616FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKBVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:30:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57519646E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:30:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x15so13404731qvp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnhizWAIbi5qruvOMfkQD7JHf83kJnMNlqaH+GW5Vh0=;
        b=QDdBEz1O25l6wo9j8kV5Sjmnbo1c3FXDV4OHpi1WeilJLJ5Z+VOzqW0FQ5cxaWwPp+
         rrfQWNepZUUXSyKd1X8Hu8Eqi0blhQGKXmerRF4DuU6AQ3b/jqUcMkOyfVbsPhYnGKLs
         1nK2/BEq403NTL0VW9SFzDitWTyJmAlcXR/QlT7KsSNC/xqEoTxG5VdewkDFCIp9q+K1
         h81ZawANVfE0Ip2sP3p34JTqN+d1FE9G7pXbs7cO2NGWjJYZuvrLuwgNjpuhsOzOsXKw
         qm82J9JF8p5KKnkvgDteUXWfixnKplnTEYOL2UgFW1Vv4P3WapBiGCT5xFdPB4ZdnzJ1
         T9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnhizWAIbi5qruvOMfkQD7JHf83kJnMNlqaH+GW5Vh0=;
        b=RNBkBaoYw7eVBEt0Gxk9mPlHyBZQBTelVF29ZSYN95FBS7i52khBm8p6Ky9PsCwur2
         O5szGAp/yVn2tPrBg0BNzoyPlQCNtdF1eapMpJdN0cS+Eng7KWzjqnYm+MezRYKXTtwd
         toqVH6Tn/qka+RZ09rw4Nzi4Wnu+6VAPKW9bvE3EWuVAWO4UAzmRXeVvOhUGRdO6xM3O
         xuHi/aV8ympjiizWpX0SRNxQqiqNcySzOe2nX18/V9mroxI5XX+UVm7/Gy/IHt02IQWp
         l5KkMSBaKlu2Pd6SrqdLk7tjNQ92HzFQBk3N365S4YibTPNHI13m8F3YQPbHwzPzsl2l
         yWmw==
X-Gm-Message-State: ACrzQf1i0YQD0K1+DCwU7gIe6jE+1SRHG0ja2AOFqZaPIQyOG38of/cC
        NN7SaVovtXDwPRg19XjOImJ0Bw==
X-Google-Smtp-Source: AMsMyM5b+7hwrgJkxmNhxObQT8swErvoEdNYJyoRn824mVM6oOxzwoYl3T/uGWd8STZXh4U9qyFLdw==
X-Received: by 2002:a0c:9c8b:0:b0:4b1:ac82:5c50 with SMTP id i11-20020a0c9c8b000000b004b1ac825c50mr24036814qvf.15.1667424609463;
        Wed, 02 Nov 2022 14:30:09 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id m11-20020ac8688b000000b0039a610a04b1sm7195595qtq.37.2022.11.02.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:30:08 -0700 (PDT)
Date:   Wed, 2 Nov 2022 17:30:06 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] counter: Adjust final parameter type in function and
 signal callbacks
Message-ID: <Y2LhXqZgOAxL47AT@fedora>
References: <20221102172217.2860740-1-nathan@kernel.org>
 <202211021216.FF49E84C69@keescook>
 <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HEJ7wVOWhWkBpraW"
Content-Disposition: inline
In-Reply-To: <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HEJ7wVOWhWkBpraW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 01:23:51PM -0700, Nathan Chancellor wrote:
> On Wed, Nov 02, 2022 at 12:21:23PM -0700, Kees Cook wrote:
> > On Wed, Nov 02, 2022 at 10:22:14AM -0700, Nathan Chancellor wrote:
> > > The ->signal_u32_read(), ->count_u32_read(), and ->count_u32_write()
> > > callbacks in 'struct counter_comp' expect the final parameter to have=
 a
> > > type of 'u32' or 'u32 *' but the ops functions that are being assigned
> > > to those callbacks have an enumerated type as the final parameter. Wh=
ile
> > > these are compatible from an ABI perspective, they will fail the
> > > aforementioned CFI checks.
> > >=20
> > > Adjust the type of the final parameter in the ->signal_read(),
> > > ->function_read(), and ->function_write() callbacks in 'struct
> > > counter_ops' and their implementations to match the prototypes in
> > > 'struct counter_comp' to clear up these warnings and CFI failures.
> >=20
> > I don't understand these changes. Where do 'struct counter_comp'
> > and 'struct counter_ops' get confused? I can only find matching
> > ops/assignments/calls, so I must be missing something. This looks like
> > a loss of CFI granularity instead of having wrappers added if there is
> > an enum/u32 conversion needed somewhere.
>=20
> Right, I am not the biggest fan of this change myself and it is entirely
> possible that I am misreading the warnings from the commit message but I
> do not see how
>=20
>         comp_node.comp.signal_u32_read =3D counter->ops->signal_read;
>=20
> and
>=20
>         comp_node.comp.count_u32_read =3D counter->ops->function_read;
>=20
> in counter_add_watch(),
>=20
>         comp.signal_u32_read =3D counter->ops->signal_read;
>=20
> in counter_signal_attrs_create(), and
>=20
>         comp.count_u32_read =3D counter->ops->function_read;
>         comp.count_u32_write =3D counter->ops->function_write;
>=20
> in counter_count_attrs_create() are currently safe under kCFI, since the
> final parameter type of the prototypes in 'struct counter_ops' does not
> match the final parameter type of the prototypes in 'struct
> counter_comp'. I would expect the indirect calls in counter_get_data()
> and counter_comp_u32_show() to fail currently.
>=20
> I briefly looked at making the 'struct counter_comp' callbacks match the
> 'struct counter_ops' ones but the COUNTER_COMP macros in
> include/linux/counter.h made it seem like these callbacks might be used
> by implementations that might use different enumerated types as the
> final parameter. I can look a little closer to see if we can make
> everything match.
>=20
> I am not sure how wrappers would work here, I can take a look into how
> feasible that is.
>=20
> Cheers,
> Nathan

The intention of the code here is to treat the last parameter as an
makeshift generic; the u32 will always be some corresponding enum type
provided by the driver. The expectation is for drivers to define
components via respective COUNTER_COMP_* macros, such that the
assignments of the *_u32_read/*_u32_write callbacks are abstracted away
and the driver can treat the respective last parameter as of the desired
enum type.

For example, COUNTER_COMP_DIRECTION is expected to be used with enum
counter_count_direction, COUNTER_COMP_POLARITY is expected to be used
with enum counter_signal_polarity, etc.

What would be nice is if there is a way to ensure the enum type of the
last parameter of the callback provided to these COUNTER_COMP_* macros
matches the particular respective COUNTER_COMP_* macro's expectation;
e.g. we should get some sort of error if COUNTER_COMP_DIRECTION is used
for a enum counter_signal_level, etc.

William Breathitt Gray

--HEJ7wVOWhWkBpraW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY2LhXgAKCRC1SFbKvhIj
K7ujAP4vYYp4QiiMKB8y1V9TP6m+SGeLI3IIjMY/y3kpizOZ5gD/XNnop9AeiGkp
N0Emw/FK2KiTf7jlxG8uhVJCVgkrKQ8=
=e2Hi
-----END PGP SIGNATURE-----

--HEJ7wVOWhWkBpraW--
