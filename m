Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4875D6C14CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCTOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCTOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:34:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD491A651
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:34:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id n2so13277359qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679322884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9A9e3OlK5++HHhObFEXf5ESYCXtuXqccANVGQ+6I21U=;
        b=n4DZ72ZWghNDwCj3HzI/lGvHUwnh+1IQkFPYY0zRUyHL7JvoSfIDz3beMw2rwhx41g
         ZSsfOEDtBBlX/kiMrruCjNkvJLP3l3vWyV0U7pCZB4pU7vP9nwvaKVsW13IFQa+DL59L
         mR+q1RyVXGgfuzZ+kG+U0ewengBMUKhsmyXy7zYCAyC3XuWTCTYbQtPIBwjRSrF56ol5
         dwTxgS0P+bGqNRo4SQ7XvBwYn9+u8s5VBx/nwuxlIUI727A9dvHXEs7Kc/K2cxptuCDQ
         VdODXlmBPgGK4PQ4zFhma3Wf2UVMDBwyRGN47VEuLQKeSzf7HEYXKMwQ63MwXAk6OKYZ
         ICQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679322884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A9e3OlK5++HHhObFEXf5ESYCXtuXqccANVGQ+6I21U=;
        b=2ssFV6+66IUy9B1RwcV4jaZ3DGEnXy8oArWLSBu+DXgSpcW/GXLuITWmxLafn1Bwgq
         rmjLU/R/4ajdDx6WBF30LiMg1DSpdiOHdkARJEnO6MgR8rrRpev9WF+Od5P3cT+q5G1r
         Eha+ybeifsXYUUcGtG/QEMwqLDeNWjS6u3/zhqgzrLaXFinMpysOr2MWhzSVvA+zyHai
         L16WtLTW/L69WbdJQyAskbD6LZikEsukQElxwCdpr/utOe+xbqZsrGo33jKYVtutYAuo
         AKaYVe6jDG9KdqiX2O8mIHETPJR3xdymh5Iuk5LOcrrfSPOlkQN3E3WM3fTbU+8R4u7E
         slNA==
X-Gm-Message-State: AO0yUKU/wfKdWVo+TFtd5G6xfziZGWlcDajDmWTs9/WvYPbyssiW691C
        bYUuklylgM0ZUzuSVZwuT8+Z0g==
X-Google-Smtp-Source: AK7set97FZ456GPwpd2kSRrqh5hWiRZHJjIdfRskJViD/7gWDTYz3XhhIwnya2T2lX+ryW8RDoXA2Q==
X-Received: by 2002:ac8:5c13:0:b0:3d4:8ce9:cef7 with SMTP id i19-20020ac85c13000000b003d48ce9cef7mr25710279qti.8.1679322884444;
        Mon, 20 Mar 2023 07:34:44 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r16-20020a05620a299000b0074305413c73sm7463490qkp.95.2023.03.20.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:34:43 -0700 (PDT)
Date:   Sun, 19 Mar 2023 17:18:53 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] regmap-irq: Drop map from handle_mask_sync()
 parameters
Message-ID: <ZBd8PZa0kCcG4MQD@fedora>
References: <cover.1679259085.git.william.gray@linaro.org>
 <ZBhVOziLz6WL6vv7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yJ3RjQKbw+mthOrU"
Content-Disposition: inline
In-Reply-To: <ZBhVOziLz6WL6vv7@smile.fi.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yJ3RjQKbw+mthOrU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 02:44:43PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 19, 2023 at 05:02:00PM -0400, William Breathitt Gray wrote:
> > Changes in v2:
> >  - Pull out 104-dio-48e refactor to a precursor patch
> >=20
> > Remove the map parameter from the struct regmap_irq_chip callback
> > handle_mask_sync() because it can be passed via the irq_drv_data
> > parameter instead. The gpio-104-dio-48e driver is the only consumer of
> > this callback and is thus updated accordingly.
> >=20
> > A couple pending patchsets also utilize handle_mask_sync() [0][1], so
> > it'll be useful to merge the changes in this series first to avoid
> > subsequent noise adjusting the dependent drivers.
> >=20
> > [0] https://lore.kernel.org/r/cover.1677515341.git.william.gray@linaro.=
org/
> > [1] https://lore.kernel.org/r/cover.1678106722.git.william.gray@linaro.=
org/
>=20
> Good idea and intention, but something went wrong with bisectability as p=
ointed
> out by the build bot. As a last resort you would need to squash these two=
, but
> try first another possible patch series split.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

I should have build tested each commit when I rebased rather than just
the last. I'd rather avoid a squash so that these changes are distinct
for the sake of a clear git history on the regmap API change; I'll
submit a v3 soon with the minor changes needed.

William Breathitt Gray

--yJ3RjQKbw+mthOrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBd8PQAKCRC1SFbKvhIj
K7RQAQDfk4YWJnxcERWnwB2mljw7M5GixdW+XeoUvcJG1FFcvwEAkF1+dcfljnmv
gnkb42RMyBqecCEsyWOkr1gmf93vng4=
=NFFG
-----END PGP SIGNATURE-----

--yJ3RjQKbw+mthOrU--
