Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD06C98E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC0ABa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0AB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:01:28 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB449EA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 17:01:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id f24-20020a4aeb18000000b0053b78077c9dso1081697ooj.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679875286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mqNgHwIwhxr1KwcRcX5YFnIl6XBIDIyAfjEZK+PHDM=;
        b=dVz1b0idsHmc85OTInQKiN0Q8jFxK+sv1qdp24KLMg8WIN6kln+oPitk+/H4G8H10d
         dILm0QCrIwGctYcvg3eH0bZqBJd6ZOqYEfnC/rj+Y55t2dE2x2pvzUtzeZaO91K/0j4m
         zXnuI94lOwU7029aCkbIAlInzZpdj9mF+MZ2JYBWY/Hpk1Xf4zRurLJDUzjVy15lTX//
         VOC1twFCnBJBZzt6vGtr8HogzqHxwJIJTh8ymaJQ9Fk5d+8jEyqvdVuGYiGjppl2rDas
         xeUKRd2CefMYuGQAYKzd4vcIe6KgZBzed42oousGD+pPACtDY4gRooBTGGhmhbF43Zha
         LuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679875286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mqNgHwIwhxr1KwcRcX5YFnIl6XBIDIyAfjEZK+PHDM=;
        b=vdlVJZFKVpMyvY567MpzPjfwpt5hIEMo294Zg6SHRIgFcj5bARC3toNS/xGrztTn1w
         6K7hlRhQOaN89tr47qlgShboSAr/lXeCOb5jlj/GPJxEGIE915u3mCC3m8P3k3P0oLhQ
         UmQgVQL1ZMFtNQHR6kCo72g6d2et+DBSb2BQz9vIXTL6teiHySsf4BdQ0RxrcAMip38B
         h9dzWvY8ZEGQqtpTqPvA50MWntbbqfvkZ1SFAoa+/IYCNs8oIJZe4LMfq/5IF8E2SMaT
         6R1Lu5ug7jAGTywtDNIm95b2dM+ejWfY9jQY9Hk/pcpYCAuYJpBtBdggkAqpQTLz0kqS
         gQ4A==
X-Gm-Message-State: AO0yUKVcw+LVITWocjBbO2fGmCnKPqH5QZ/mCPQCvXFLOwB23wkzJASq
        9cZO75wqVM5sPsZn7m/8p5u40+18RhV3BhewIEYL5g==
X-Google-Smtp-Source: AK7set/rjDvuG3fJXQoZvhqm2wXcsciTm3HPhrb06n51ekP2LwhUp1dIcsn5TJa2ZrNBYjgZkbk3CQ==
X-Received: by 2002:a4a:4542:0:b0:525:a9a9:b44a with SMTP id y63-20020a4a4542000000b00525a9a9b44amr5055633ooa.7.1679875286250;
        Sun, 26 Mar 2023 17:01:26 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e20-20020a4a8f14000000b0053dfd96fa61sm2896021ool.39.2023.03.26.17.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 17:01:25 -0700 (PDT)
Date:   Sun, 26 Mar 2023 20:01:23 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZCDc0zPtPSyDgOaF@fedora>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
 <ZB2k9m7rL7Hpy/zU@fedora>
 <ZB2qI7k/Igws5khg@smile.fi.intel.com>
 <ZB3DJjQLa48AodSD@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VOBZKfGdbh/Z/7o0"
Content-Disposition: inline
In-Reply-To: <ZB3DJjQLa48AodSD@fedora>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VOBZKfGdbh/Z/7o0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 11:35:02AM -0400, William Breathitt Gray wrote:
> There are eight calls to quad8_control_register_update() in 104-quad-8:
>=20
>         quad8_control_register_update(priv, priv->idr, id, DISABLE_INDEX_=
MODE, INDEX_MODE);
>         quad8_control_register_update(priv, priv->cmr, id, mode_cfg, QUAD=
RATURE_MODE);
>         quad8_control_register_update(priv, priv->ior, event_node->channe=
l, flg_pins, FLG_PINS);
>         quad8_control_register_update(priv, priv->idr, channel_id, index_=
polarity, INDEX_POLARITY);
>         quad8_control_register_update(priv, priv->idr, channel_id, synchr=
onous_mode, INDEX_MODE);
>         quad8_control_register_update(priv, priv->cmr, count->id, count_m=
ode, COUNT_MODE);
>         quad8_control_register_update(priv, priv->ior, count->id, enable,=
 AB_GATE);
>         quad8_control_register_update(priv, priv->ior, count->id, !preset=
_enable, LOAD_PIN);

I attempted the cross-compiling using an x86-64 system and I was able to
recreate the build error. I tried to isolate the problem line by
commenting out quad8_control_register_update() calls and discover that
this appears to be an inline issue after all: if there are more than six
calls to quad8_control_register_update() are in the code, then the
'__bad_mask' build error occurs.

The build error doesn't occur if I force the inline via __always_inline,
so I'll add that to quad8_control_register_update() to resolve this
issue and submit a v3 patchset later this week.

William Breathitt Gray

--VOBZKfGdbh/Z/7o0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCDc0wAKCRC1SFbKvhIj
K6DUAQCHK6g+zrtL2opXqvDT2GFt26czSyY6ss78QElPdbKgbgEA7jhk8Q8oAeE2
fnq8aYq272RzeXV1qKomPviXXtZMbgc=
=2imo
-----END PGP SIGNATURE-----

--VOBZKfGdbh/Z/7o0--
