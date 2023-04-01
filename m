Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1896D311F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDANn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:43:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E5191E8
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 06:43:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e65so30215151ybh.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680356634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP7UpzHOr3tkhr619arFQRlNrfveNlWZwn+YXq6owuk=;
        b=lBWAZonbtaNgRQcvNRoZwNkSUWGBKIvZtyo98vzy8zpc8cJhMpYhTMnUJ4KzOYX5Ul
         E3+vkr+HHGM2eiiNCcf+GegpywDRRzirfkRlKaD7KEG8Kh9VfU9wIOJY1BnQKUpyKH/n
         5XcUsXQ+p3OdSF3/aYoC3XhWOVhyo3X1Y+t6BudhbCTrrGh/eUJRo9aa++G7H7BGEYkU
         qwABcgSseLVyF0sc3gYPWHn/yKgBBRwakfGAYnt6ZZbI8OUIrLZMTYPF+zdyPNi3pGAS
         Zcx2IoNWdl71bI6hCtfIfMmTauQoPdwrSa4Z2SjGsWroJwxu6xFF9JNXKC4twR/hSTP6
         tQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680356634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP7UpzHOr3tkhr619arFQRlNrfveNlWZwn+YXq6owuk=;
        b=psqvkdQuAXiRz0axvDSvWOl7ihmItp09IfZhBXBSaPztUkcR6r2PIFA/nUqWqJsFFD
         9gK2C4+66/2/leCt4qOgoRWDWVXAXn14rCTAOUdqng47iEkzq7vGatkv7lFKxylj/eIv
         ntGZMNyjx18RnQsqGugy/7CNrODqoXb18pgCzQQzNUqhoTDCNIu9Yy2Oqil3oIaohmgC
         sam/dz9qkNVBfuyWFUBt68uTaApzP0aiiJ7esh5Ak72blwfv1p8SpOSlqX7MxiAGN/Rf
         uWtSYiq6JrZgnqL3vskXkKTVkEEq3MDYZeIBeoyDYJadYhpEHCvIBgxeZBiH63eEajo/
         41Kw==
X-Gm-Message-State: AAQBX9fEB64Yfd5y8ypoHr9Mp1BwrZYeo3MVnqDfxkcsYgMocmevTHVy
        ZEQ8aehKQ/3kB5ObmnFah+1mXw==
X-Google-Smtp-Source: AKy350YskRo0KwXK+RPnoX6NndU3tvfL3ndo1tK2qR2YhfdASlwk4sHfJtRTLlpftifhiu34+J7DhA==
X-Received: by 2002:a25:ad87:0:b0:97d:c4d4:911c with SMTP id z7-20020a25ad87000000b0097dc4d4911cmr32000078ybi.57.1680356634130;
        Sat, 01 Apr 2023 06:43:54 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y19-20020a25bb93000000b00b7767ca747bsm1225457ybg.24.2023.04.01.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 06:43:53 -0700 (PDT)
Date:   Sat, 1 Apr 2023 09:43:51 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZCg1FyfcOvpLrMmH@fedora>
References: <cover.1679867815.git.william.gray@linaro.org>
 <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
 <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
 <20230401145121.1a64a113@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KbeYdy2842VnTNzT"
Content-Disposition: inline
In-Reply-To: <20230401145121.1a64a113@jic23-huawei>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KbeYdy2842VnTNzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2023 at 02:51:21PM +0100, Jonathan Cameron wrote:
>=20
> >=20
> > > +		do {
> > > +			err =3D regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_st=
atus);
> > > +			if (err)
> > > +				return err;
> > > +		} while (u8_get_bits(adc_status, STX104_CNV)); =20
> >=20
> > Hmm... Isn't it a potential infinite loop (e.g., ther hardware / firmwa=
re
> > is broken)?
> >=20
> > Why not using regmap_read_poll_timeout() (or its atomic variant, depend=
s on
> > the case)?
>=20
> Just to shortcut things as I'm looking at this.
> That's currently handled in patch 2.  Argument being this is a direct con=
version
> of existing code, whereas changing to xxx_poll_timeout() is an improvemen=
t.
>=20
> I'm fine with it just being rolled into first patch with a note in the pa=
tch
> description though if that works better.

I'm going to keep it as a separate follow-up patch because introducing a
timeout is enough of a functional change to risk a regression that
having it in a dedicated commit makes it easier to revert later if we
need to.

William Breathitt Gray

--KbeYdy2842VnTNzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCg1FwAKCRC1SFbKvhIj
KwfPAQC0qyFGLIKKcxO0aN0oqjFdF6fMtToeQek70VRbNnBA7gEAy9WIVmR1n/LP
XtuVVyKufI9v+lw3SM0J+9icvaYeLAU=
=DZ9m
-----END PGP SIGNATURE-----

--KbeYdy2842VnTNzT--
