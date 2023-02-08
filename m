Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407ED68F2CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBHQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjBHQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:05:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271484B76F;
        Wed,  8 Feb 2023 08:05:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so1256217ejb.7;
        Wed, 08 Feb 2023 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu8SJf3xEBufgW7POvLQ+bbbs+6bQN1vcLMAaGTCibI=;
        b=lsANXjT4YYeLKPfekDxuxNvAVgTcR5Cwj2R2gobvoM8V6zflsPzTwdbHamN9j3c+Dp
         qyufcdOKd4fsFzdyy1e4iQkrHkb0eRBB5wkbDuY6mwpcfSYIy9yPePUUQZRBPkXOoBPY
         lX3i1gdqwzKVboFYOrI71POx64m6R5gtaYBDZdF8NBfA60b+NwlmN1BO8zuu1XdVJotJ
         vifemm6G9DJLSHx638omaaoLmmd/ptuFJeFVpxbm/mJ2NCCN2Vxpg6K+20RE47CG9YvV
         dWKn0W1dPeZ3t5rfZBpPkjHRYtdMkFIOocmdOdS0vkBoS6l2Iy1AslrUdstO9oiRQChS
         mjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu8SJf3xEBufgW7POvLQ+bbbs+6bQN1vcLMAaGTCibI=;
        b=hfZBREPXyMtP9BrB5z12hSLBU6KX8mVC5IqqviNHhOVCnAlAsQMliVxnjn/2m2XV48
         ZQE8EIVBPSYjAplQz8mCdYL8448eUIO7CwW/404uXRnxwvfLTyp/p232MvNT/LdaOkq2
         1UJR7lkJu5u9ikTQHsLXRQPwvrIHqS9hgsGQlCFW15ePMBqA9UPLfkoQ9E5f1/0f7RPd
         zDLCjXRhL3vTcDdeWfkt/Yut5uDLSQYlF+oehg28Wf2/a+PHrq+G7Rnnl0R9ZZV3Vzua
         DK0qa2ojULWuqqTBNpkW1J7aF9hWipTZzy4G72QsexGyqBV2dfxMCuBHlnUtg+PBIKxv
         Q0Xw==
X-Gm-Message-State: AO0yUKVN01FSwrpGSEpX+cC4D/Pbo0ZplIEij5SFIzYR9Mb12ns6z42y
        jT7w3hnutCyxQNVWxop6xc0=
X-Google-Smtp-Source: AK7set94qkjdx8w8XK88as/CszW9GjQxMgGq6dqR+wis4aVIcrwdmcJPcXzYWCtcwYo84H/Cr7EwYw==
X-Received: by 2002:a17:906:7c07:b0:880:2870:7849 with SMTP id t7-20020a1709067c0700b0088028707849mr8704801ejo.74.1675872307593;
        Wed, 08 Feb 2023 08:05:07 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007ae32daf4b9sm8459666ejo.106.2023.02.08.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:05:07 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:05:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: tegra-bpmp: Handle offline zones
Message-ID: <Y+PIMc8PepsIPXN7@orome>
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
 <Y+N5+w8ePTVaZiIB@orome>
 <706b3e2d-7097-356b-b96e-dd917ce048ea@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3g8zk/YJd0AOEqHX"
Content-Disposition: inline
In-Reply-To: <706b3e2d-7097-356b-b96e-dd917ce048ea@kapsi.fi>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3g8zk/YJd0AOEqHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 05:35:48PM +0200, Mikko Perttunen wrote:
> On 2/8/23 12:31, Thierry Reding wrote:
> > On Tue, Feb 07, 2023 at 03:56:08PM +0200, Mikko Perttunen wrote:
> > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > >=20
> > > Thermal zones located in power domains may not be accessible when
> > > the domain is powergated. In this situation, reading the temperature
> > > will return -BPMP_EFAULT and the temperature is considered to be
> > > -256C for calculating trips.
> >=20
> > Where's that -256C being set? I only see THERMAL_TEMP_INVALID being set
> > as the default for a zone, but that's not -274C, not -256C. If that's
> > the temperature that you're referring to, it might be better to state
> > that we rely on the default temperature rather than any specific number.
> >=20
> > Thierry
>=20
> It is based on BPMP's internal behavior.

Okay, maybe clarify that part of the sentence then. Could be something
like:

	... will return -BPMP_EFAULT. When evaluating trips, BPMP will
	internally use -256C as the temperature for offline zones.

Thierry

--3g8zk/YJd0AOEqHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjyDEACgkQ3SOs138+
s6H5JA//TdfEDY64BG0y7A7/GvZveH2DOXG064mmwvhMJtAZ7Vp0v5ldgbi1lWOE
TiKuNwOVj5QEqgmNo3cN/+E4rYSg74mB1pl4IPrcdUSPgaHo/uLOmi2VnJscUPac
MKcBGWDw+AWkCCvOPZYfeakK5xKdgfH0Rtami3EP2PvzSEnulGMERlLr27C5s/rT
yNgfbNf3WdHEUYY5wfhUq9SGd2VNphr+fCtSEyR1GoBvIJz/1KIBsSwbVFFLlvSq
ecPnR60yhlZs9cSgb0h0L4xfkj6d225YkZU9AghDKyiYmNpzpwMXpDJDekrDIaNp
yNOZYOBpU5niMfJ/p/EyebHN89DSEtrsewy3ecDEY8xbcNA5IyMcn6rjQyccvnv/
Y7Awd98eg5ZPXwqSQTtso3oJPPbPVwsmjgCEsvJ2g/1ZgKZfJZ4aI7zNuky0vDFR
X1wItyZ8TcM06DjBOuHl4XiAdb2h2oNIIuXe2fEcxGHmipvb/6lbrcXMZO9km5sH
PP0uI3GZ0LHYexYsrpcXXhOicCWY+ld1EWVX29iHZC8T4XojzMNba2sDI7bPCSA7
i53aIN7o6pd2zKuoxrVlSRQO76ORuuX/RiV6OxAVTUBplZRdO+nhXxnUox80Zqfb
Mmc9P7aQSj2x+LHuRGasYr3l5EmvMKX07uJMbTRCMmVQy5YhttY=
=9WHK
-----END PGP SIGNATURE-----

--3g8zk/YJd0AOEqHX--
