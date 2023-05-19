Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C3708D36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjESBTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjESBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:19:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447EE4C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:19:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-561b43fc896so25399687b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684459160; x=1687051160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuRje6n2APNrdks/wvQAvSj2Ouakzm7jUJXo4jx8GOE=;
        b=NVoGzSMWid+9OAnpDnsANoD26ob7S+d5A8LcD1WIcRVCPX16PwseymDAaA02OipGeu
         UXjxWa9pNYM9pUsJZFxA4B8DRn4rKbIP8RaJ3dZQMlSMvGPA9IRNE7BNNwEn89e+TeP+
         XfqDQNOPIeEuNazm2IVajMjr7LddBch3cSvIjaSInSKrfhkwbaLFwIqwiM2vHZzBc6Ln
         YeLAUlvsGnWF65KCQnOahAebBpbkibPc+ObI2dFZfdKEgds6zkv5yifiIOtTl92DbybQ
         i6LFrIwkuajHox25LgPgV5CuXB5WMjfHwDjP1hAxpGcQQUhGcNYTppq6AxHXu8GsYqR5
         phlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459160; x=1687051160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuRje6n2APNrdks/wvQAvSj2Ouakzm7jUJXo4jx8GOE=;
        b=iw7QJQ0b/GApu2CpZL/lJra6+0i04OrZuIx29pt1LqdusrIOs+6SL7vCZklADP3CQ5
         Rjf4Y51U9Wd/2CU8H1fJ2onJq+7pK5q34WASrsYXiRzD4/cGMGBjxfr1Byxx0diXzqZ0
         45xhV49saeMxJdFQZ2bwrKW7MIKh2EBgWKgfOrcmwOgwPsx0YpIW1TB4tzBB9hpMudGq
         qG6POmIAwZqOMpC1bzoTNA73Ma5OwZC7TV6E7wxl7RBQZWlSHwdc9kxTaY0o9tPIFx2s
         R8RDhbb95Gn9uZoEVGJ0+HQQsgqnHHfvSeQjpPXQOVItO/pO/yicesnWZKCk12Wk9jZI
         w5pg==
X-Gm-Message-State: AC+VfDyfd2EeVYP2ImQ1uG49fdGWrK2nivD1IznU/mYcApZsQ5LSuLxz
        gIDSPLo3w5hER0+nOSxRIrVtFg==
X-Google-Smtp-Source: ACHHUZ7XNt5edWfx8KRqaVX0nDXAEZZ/Wm95LixfUIGE9b4OpBIYZhGvWr+0qTf4c6PapNOEYt9QZQ==
X-Received: by 2002:a0d:e288:0:b0:545:637c:3ed7 with SMTP id l130-20020a0de288000000b00545637c3ed7mr441156ywe.1.1684459160346;
        Thu, 18 May 2023 18:19:20 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s129-20020a0de987000000b00555c30ec361sm795828ywe.143.2023.05.18.18.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:19:19 -0700 (PDT)
Date:   Thu, 18 May 2023 21:19:17 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 0/4] Refactor 104-quad-8 to match device operations
Message-ID: <ZGbOlXhXgcmZMCXv@fedora>
References: <cover.1681753140.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0s7Z2gknOEJZ6EHn"
Content-Disposition: inline
In-Reply-To: <cover.1681753140.git.william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0s7Z2gknOEJZ6EHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 03:50:46PM -0400, William Breathitt Gray wrote:
> Changes in v4:
>  - Fix endianness errors by utilizing get_unaligned_le24() and
>    put_unaligned_le24()
>  - Mention benefits of using regmap in the commit description
>  - Use "int ret" for regmap_* return values throughout for consistency
>  - Reorganize declaration lists to prioritize longer lines first
> Changes in v3:
>  - Add __always_inline attribute for quad8_control_register_update()
> Changes in v2:
>  - Drop FIELD_MODIFY() macro introduction; u8p_replace_bits() is
>    utilized instead for the same purpose
>  - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
>    u8_get_bits()
>  - Replace FIELD_MODIFY() with u8p_replace_bits()
>  - Wrap up control register update in quad8_control_register_update()
>  - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
>    data
>=20
> The 104-quad-8 driver was initially introduced to the IIO subsystem
> where it didn't quite fit with the existing paradigm [0]; these
> differences eventually led to the creation of the Counter subsystem[1].
> As a result of its awkward beginnings, the design of the 104-quad-8
> driver was structured around maintaining abstract state buffers that
> would eventually be converted to match the actual device registers
> states on-the-fly as needed.
>=20
> The original design approach for the 104-quad-8 driver was neither
> efficient nor easy to troubleshoot, but it did allow us to focus on
> implementing and supporting necessary APIs for the nascent Counter
> subsystem. Now that development for the 104-quad-8 driver has shifted
> to maintenance, it is a good time to refactor and clean up the code to
> match closer to what is actually happening on the device. This patchset
> is an attempt to rectify the situation as such.
>=20
> The primary change is a transition from maintaining individual
> configuration states independently, to storing buffers of the device
> register configurations. To that end, the bitfield API is leveraged to
> access and retrieve field states. Some helper functions are introduced
> as well to abstract the handling of the PR, FLAG, PSC, and control
> registers. A migration to the regmap API is added as a follow-up patch
> due to its dependence on this patch series.
>=20
> [0] https://lore.kernel.org/r/b43e2942b763b87afc85bfa9fe36e5695cba4c44.14=
75079578.git.vilhelm.gray@gmail.com/
> [1] https://lore.kernel.org/r/cover.1554184734.git.vilhelm.gray@gmail.com/
>=20
> William Breathitt Gray (4):
>   counter: 104-quad-8: Utilize bitfield access macros
>   counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
>   counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and
>     PSC
>   counter: 104-quad-8: Migrate to the regmap API
>=20
>  drivers/counter/104-quad-8.c | 802 +++++++++++++++++++----------------
>  drivers/counter/Kconfig      |   1 +
>  2 files changed, 440 insertions(+), 363 deletions(-)
>=20
>=20
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> --=20
> 2.39.2
>=20

Queued for counter-next.

William Breathitt Gray

--0s7Z2gknOEJZ6EHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGbOlQAKCRC1SFbKvhIj
K0/QAQCqpS1jJwObJIFxVsMSbY4ebFu+739k15UsTEz16x07ZgD/dJwpK5YUZfpO
mJWRs3ezWUtdpuDF6hwUWPnznksxCgU=
=vDZl
-----END PGP SIGNATURE-----

--0s7Z2gknOEJZ6EHn--
