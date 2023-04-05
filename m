Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F96D8340
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjDEQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjDEQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:12:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0BC6E9B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:11:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w133so27027887oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680711114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3/hKDGLIBgYBsSp9JxGzVD0t/I/eyqeXE/qh58RSV8=;
        b=AdzTEGbNSycljYJy5WCNyP5smG6PKUNLqxy4H4UJ7Wcj41efVFYkFlZP52ymD3pCkn
         lP7fv+4vTGcjRt9z705FLodCuOKHJ8PvpxFxkk3zVVVkCZ/iuDjbPHN2o6ZefGqpAmW8
         eHvrkjYcd4ysJfZYtndZFcaRh6xYfF9XnQqOc5NP/htmGXl415+V8kWEX4ZSVxbbk1Ie
         dOuqqkujn+0FXzODX+WCGsfU68UyuieYtpytIXQwIgn22pJPpJA2B8qD9k0ls68xgbK6
         fGznrhIWcrIj0hVLzmBkz/Z4tJ4frIwoscDk/8BQ7bBvZFh27gcDlzOrtXniT7kYldF0
         qAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680711114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3/hKDGLIBgYBsSp9JxGzVD0t/I/eyqeXE/qh58RSV8=;
        b=kr5oZAiBcUB3BQurKWbxKEgZgTqeODEVBDvzqNpL9KBWj5BqFi4v0VLwzUt42YyDfz
         WE0Claj+maTDgUQkBLXC5RfGpUsD6D5TOobYTt2UJ9IuotCDZ7nsnxXrRtLfeflDaZJM
         MKWNZSQtF253TZKF2ukwEAAEL9wItJ/+98Qd1U76gq7TapN//MhxAbX8VdMssY4tmUIg
         2Sh3Y7NUuaqFdyJ7QtmScKqgZssRml3FrJG8pxt+2IX6Yj8VXfJ6OmerraUSNYC2PRaO
         dY24suz2snKBG01yrWTfthAoONfR3Ct7G0A7F3YBO92xoIA0bYFtBqLKwHlGZR8zndzw
         jqFg==
X-Gm-Message-State: AAQBX9dkEn4z9cF4dqe8ApyhA/biCKkpzjBr6nfhLHMw/rIh42gg5wpg
        HKbymXOOEOZpagQjDWIJehInLuRX2NC0nzHW3WqmrQ==
X-Google-Smtp-Source: AKy350ZNmJ75pUP3KEgVS+A+KgV79Qyj8cTKV6rrrYe2WhtX88ntGPgBr6gri0UAXqv8Zj3f1JulZA==
X-Received: by 2002:a05:6808:2221:b0:389:7955:bd66 with SMTP id bd33-20020a056808222100b003897955bd66mr3608870oib.34.1680711114267;
        Wed, 05 Apr 2023 09:11:54 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d22-20020a4a5216000000b0053b56462336sm6929712oob.21.2023.04.05.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:11:53 -0700 (PDT)
Date:   Wed, 5 Apr 2023 12:11:51 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: addac: stx104: Improve indentation in
 stx104_write_raw()
Message-ID: <ZC2dx2LCLdkEUh02@fedora>
References: <cover.1680564468.git.william.gray@linaro.org>
 <ac00afab032039350d23cfc9752f8e9225537fd0.1680564468.git.william.gray@linaro.org>
 <ZC02QAYZodp/cgi5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1jYOn3g9KEyDd8dW"
Content-Disposition: inline
In-Reply-To: <ZC02QAYZodp/cgi5@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1jYOn3g9KEyDd8dW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 11:50:08AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 04, 2023 at 10:12:00AM -0400, William Breathitt Gray wrote:
> > By bailing out early if chan->output is false for the IIO_CHAN_INFO_RAW,
> > indentation can be decreased by a tab and code readability improved.
>=20
> ...
>=20
> > +		/* DAC can only accept up to a 16-bit value */
> > +		if ((unsigned int)val > 65535)
> > +			return -EINVAL;
>=20
> While the patch is good per se, I don't like two things (which are also i=
n the
> original code):
> - explicit casting (can it be avoided?)

We could explicitly check for negative instead:

    if (val < 0 || val > 65535)

Would that be better?

> - would be good to have U16_MAX or ?.. instead of hard coded number

Fair point, I'll use U16_MAX then.

> Can it be addressed with (additional) patches?

Sure, I'll submit a separate patch to address this.

William Breathitt Gray

--1jYOn3g9KEyDd8dW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZC2dxwAKCRC1SFbKvhIj
K3Q+APsE95kTreE0b52i3BDXKPVUHEkYx+70aW7kAfkJ89TLfgEAruHwB9k+q/3J
M5eK7yomsLlRXu2iPnwG82wIJoceOQk=
=k33s
-----END PGP SIGNATURE-----

--1jYOn3g9KEyDd8dW--
