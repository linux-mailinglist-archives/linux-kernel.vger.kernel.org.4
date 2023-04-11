Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776766DE68B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDKVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDKVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:35:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E725260
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:35:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i20so13431547ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681248913; x=1683840913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pLFX6ad4QGodETcTebKk90wi9LId4RBUIMWZKtUXWgs=;
        b=H1jjBhJlCRiwvmJgfzDzJtiLeCpBky/cuZNIhbbXEJlUS8VsV7V07b9c/rDpW4PZOz
         aOQkZ/NUkADy8AXoHP5Wn0siXfOG497CWEsug5aC3d7m5P0jdNMsRLgokaRcTc9kkgu/
         l1o08zASPpBHXGvGmaC7mu7PE9vxT4slcMYGOtxmMiOkdksClNH3sfMDoHKZhjKKNOJ3
         Pa7cis4rOLf+06CUeBDS1wiZXkkAuiMwLBb8dGNjHvBq44g8hwAtikJLzPOuRG8u3NHB
         a2KqkT+fN/mIBzhDshRWgGOQTrehT4wZvEP2VP/jWLQyhFmMECY0LbjT3e/xIN97Hcfc
         +/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248913; x=1683840913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLFX6ad4QGodETcTebKk90wi9LId4RBUIMWZKtUXWgs=;
        b=iwcZgoZp9zTrjnEoCopgnxDxITHsNtSuAe1HtwaNOzjfLmJMDYHm8IQtqDBGa9louV
         9yu3jta6pXM6elopwo2QIExFASq8pmH6q2ch0HcHAeGSGscpYDahyAK6F6sVPTpK9oxh
         VBFv3wv3gXvbzllGt80tb/M3QKt4G18v0MaCjpIbd2Dg1jU7qphbENNyEzV1eokdKh7u
         cPrxPFp3AcjOXvgebYU/cALreltb4euNOyYwxTKD8Ecc8zW48wnreu8NrtogZ4mnnzfb
         XJVf92JN6PJqwWrhG+G2Io4P3DNgetLS70jXNOrrrQJD2DGVd5AUtOQndtBYtDYSr0pq
         4qxQ==
X-Gm-Message-State: AAQBX9ceVNMHQ8+CwfwoyxWNW1Ra+qLxi3N80GEpbybWIPEMKdx0G/Mn
        Dg62B8BUW1sThZraooRHi2KVKrSflJPhC9jQOFZdew==
X-Google-Smtp-Source: AKy350b9kOBVpIqWF0DXrV+eKfcz0GLC4Hdl/0P4dk0vGd4xc0O64N3qVKyw/nRxN4IuA+BGE1/pHg==
X-Received: by 2002:a25:a187:0:b0:b8e:fc1f:acff with SMTP id a7-20020a25a187000000b00b8efc1facffmr2849082ybi.23.1681248913304;
        Tue, 11 Apr 2023 14:35:13 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k6-20020a25bec6000000b00b8bfb4c4f1esm3518999ybm.62.2023.04.11.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:35:12 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:35:10 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Message-ID: <ZDXSjsjryXn0pHCz@fedora>
References: <cover.1679323449.git.william.gray@linaro.org>
 <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
 <571b4df1-91ea-481c-9797-842974dfa922@sirena.org.uk>
 <ZDWopwozNjFg/9NX@fedora>
 <db1edaaa-ea56-4f21-bc69-43f648e79c5b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48Noe0+nb7AHw+BE"
Content-Disposition: inline
In-Reply-To: <db1edaaa-ea56-4f21-bc69-43f648e79c5b@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48Noe0+nb7AHw+BE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 10:15:54PM +0100, Mark Brown wrote:
> On Tue, Apr 11, 2023 at 02:36:23PM -0400, William Breathitt Gray wrote:
> > On Tue, Apr 11, 2023 at 09:23:55PM +0100, Mark Brown wrote:
> > > On Mon, Mar 20, 2023 at 10:50:15AM -0400, William Breathitt Gray wrot=
e:
> > > > A private data structure struct dio48e_gpio is introduced to facili=
tate
> > > > passage of the regmap and IRQ mask state for the device to the call=
back
> > > > dio48e_handle_mask_sync(). This is in preparation for the removal o=
f the
> > > > handle_mask_sync() map parameter in a subsequent patch.
>=20
> > > What's the story with this patch?
>=20
> > Currently dio48e_handle_mask_sync() uses the map argument in its
> > implementation. Once the map parameter is removed, the current
> > implementation of dio48e_handle_mask_sync() will no longer build, so we
> > must adjust the implementation to no longer depend on map.
>=20
> I mean what's the story with getting this patch applied?  It doesn't
> seem to have been reviewed...

I'm sorry, I forgot to add Linus' tag from v2 [0]. Linus, would you
confirm you're still okay with this patch?

William Breathitt Gray

[0] https://lore.kernel.org/all/CACRpkdYFSu3DAY4+EeoRk4cTkypgWg1C=3DUgforDO=
7mT96f0GDQ@mail.gmail.com/

--48Noe0+nb7AHw+BE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDXSjgAKCRC1SFbKvhIj
KwrCAP9VYpmQaYtooKnX1jtXhKeFvVEc7Z9Ji8JwIxbhtXtN9wD8CaSYLVG1F8fT
MkfffK9DI7xn64NaLkukyDhgCASR6g0=
=NyAF
-----END PGP SIGNATURE-----

--48Noe0+nb7AHw+BE--
