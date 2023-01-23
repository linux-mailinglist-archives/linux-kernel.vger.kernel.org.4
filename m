Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265636773F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjAWCNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWCNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:13:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1875125A3;
        Sun, 22 Jan 2023 18:13:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k18so10069172pll.5;
        Sun, 22 Jan 2023 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVZ4BsIi3M57UVZxYYQMFwl1v2Bh74U8ai5p/1Pxiqw=;
        b=b6kiQIOxO5D+IODOPJuq7xyIPKZ/gPwDHsJp0TpRQcKBvKakfqcWnxvrbaW/yDjV1D
         AXOHSMXIt+GtsnqHRrrxQiHT/YIDYbDgRyG/GaYDYdWVh0XY0NaiEXa8YEP9vnX/53Jy
         nlBhnIYC/Z8xZc/5Z2G0gBrQG3fAJzdXuDd968HXFlwRJnGc5bpKizsSIVTNg/mCOqfN
         EYvHZ//gzi0QtkXt3WM9KBlOgOLTi1hGnYzZ8qWJrHqr8vpHyjquwmK5I6tnvhBhe7jM
         xNDqCLtDpx6BsOd/YLMC5Alc1ucqhVAS78mW6EkHjhtx5dq25fA+3b3usJBI9BBPY0T8
         sNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVZ4BsIi3M57UVZxYYQMFwl1v2Bh74U8ai5p/1Pxiqw=;
        b=sYiM29BH5sLSxu1QLb2ps0Hfg5J8o7LiDWozodEEP+BKxWbxI6dMpXT4B6Sw19PxDr
         GnxGrO1sWK+Mknj9wRLXCDbhLeaQntN+3O1OFSfsfsKF5wyjr4vh/UReg+Utyl/zX4om
         4fPRprHkYznpITNWOw5deopBuaNHiv0HE9fmOoyzdY+4kJVi7wIlffVFvPIqqHOz12Ha
         Is/+6oqLhLmsLXFu7dQei5UjyyXxFOQdrqTk13V4Bx0TKbe3JLUSeJo1zVqUjAJdatzw
         jQHNj+oSuqT/Q/SPSQM+80P629/JrcLx/yB73fNH1kkF5ySWLpbHvcmoPCsT1tTPIACN
         YUOQ==
X-Gm-Message-State: AFqh2krH5P9Ort/Sf4Mey4UTh2ACuvJexKVBogs+1RAhweTTFGh0RCN/
        ccQhD7+AE66rIbqAPYJ9vrU=
X-Google-Smtp-Source: AMrXdXscUgBpZLNwhB8xZE1/oI0IHG/yb2J/eVIw3JOc4OkJgkrK7/bKZ92Fa3BW+BlRuwU2IWUaAw==
X-Received: by 2002:a17:902:c755:b0:194:cf89:cd15 with SMTP id q21-20020a170902c75500b00194cf89cd15mr12366103plq.15.1674439985998;
        Sun, 22 Jan 2023 18:13:05 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001930b7e2c04sm27822554pli.287.2023.01.22.18.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:13:05 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DC38D101C11; Mon, 23 Jan 2023 09:13:02 +0700 (WIB)
Date:   Mon, 23 Jan 2023 09:13:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:Real-time Linux Analysis (RTLA) tools" 
        <linux-trace-devel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: rtla: Fix full name of the GPL
Message-ID: <Y83tLoHnM496akUH@debian.me>
References: <20230122181053.53725-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Txk6XMGNDFHr4ncX"
Content-Disposition: inline
In-Reply-To: <20230122181053.53725-1-didi.debian@cknow.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Txk6XMGNDFHr4ncX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2023 at 07:10:53PM +0100, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

No patch description, really?

> ---
>  Documentation/tools/rtla/common_appendix.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation=
/tools/rtla/common_appendix.rst
> index b5cf2dc223df..c631341e914e 100644
> --- a/Documentation/tools/rtla/common_appendix.rst
> +++ b/Documentation/tools/rtla/common_appendix.rst
> @@ -10,4 +10,4 @@ LICENSE
>  COPYING
>  =3D=3D=3D=3D=3D=3D=3D
>  Copyright \(C) 2021 Red Hat, Inc. Free use of this software is granted u=
nder
> -the terms of the GNU Public License (GPL).
> +the terms of the GNU General Public License (GPL).

Missing SPDX identifier. Please add it instead of trivial sed above.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--Txk6XMGNDFHr4ncX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY83tLgAKCRD2uYlJVVFO
o/85AP9UbBUdsoLh08WIbyeRWqYJhehD7WaS6F0vFTE/hBaJkQD+LaBlc13Nqn0n
u0KUTmY00RZGt92XwIKShu7WUKyzJAI=
=+QfP
-----END PGP SIGNATURE-----

--Txk6XMGNDFHr4ncX--
