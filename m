Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0136D62CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjDDNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjDDNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:30:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7430EB;
        Tue,  4 Apr 2023 06:30:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so130654745edd.1;
        Tue, 04 Apr 2023 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615004;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1xSHxE1EltnFe4rBdKCgr4L21D3en11swmxi78/QJo=;
        b=bLUcssMAVwFowKXOWPM1CwtxkNm422B0OcXpOWrHzgiGiJzsm6/YgLo/UMlBhuHBfd
         Il9Oub1F/7X1iOg7r6YTlpSlY5pMAb5yJBU/14P/SxIWfsolcFdiHb3eu9TFo0D4nf+7
         0cRj8CXV4afLv6SYPyOCupXLLBgWxT1d5qK5Y8APW0BjP5o+Q/LnEFIx7EwX5A+BT/l5
         Jdk5xQuBjZUFRWjUkibnrSXLy4Gso3NnY4WsLIZcnoCWd/gCHGoWyUhHlC6ldSiZ6XHu
         Z4n218T3YQ470eRTFZQH6aZ79HV7K1M9dHjNEZCKCwwXJqWkTUmYvajFjE3BSKOnhHvH
         x07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615004;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1xSHxE1EltnFe4rBdKCgr4L21D3en11swmxi78/QJo=;
        b=PooJPclRtDRFiHjhik2CQv3HqooQecZ7+g0h5miC2KZJthJcjVQV89jIEk/AStJJKa
         xS7GUN+lbLIJ1lT3KmBfs1/5B3TyYBqpqnU1MIEJw6H7ec+f9uqXgZefXm/WDszZPVzU
         N2OQd/CegzifPbK4iWY3XiRheaN6OgyYLcrAvyn9bn1Db2BmIZp6SrOkX0UnbTcsU1jC
         P7GgaKMe07FcrDS+d4aJH8oP7dE8FDxoKA1Sw2viyN6Gy7yV3aFIq5MX+9X0gmVK4Fu+
         ll9ZfEAx4FLrMWJWI2R+vZyCkbDOCqGxdNskZ0hyhsewWwLaqjDimvXewjfTj7NTutr0
         Hfag==
X-Gm-Message-State: AAQBX9fYwPybccujwYbdp3s2bl4saeJEb5r1HoMeFt7GmgEvryaUj5CW
        anl59O8tFC28Ual8b7FfsKU=
X-Google-Smtp-Source: AKy350ZY7QhVY8loZEZFHvtjndpc4b0Kz415JBuObSnrseK7HdloY+pOgaUekGIUv0tm7DhIanNa8A==
X-Received: by 2002:a17:906:c04f:b0:92e:e9c2:7b9c with SMTP id bm15-20020a170906c04f00b0092ee9c27b9cmr2486126ejb.77.1680615004393;
        Tue, 04 Apr 2023 06:30:04 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b0093f83562f09sm5981780ejz.87.2023.04.04.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:30:04 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:30:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] firmware: Use of_property_present() for testing DT
 property presence
Message-ID: <ZCwmWoZhMOlHnnzf@orome>
References: <20230310144704.1542045-1-robh@kernel.org>
 <20230323120030.7mk62xk7tco32zw2@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iUHciihrTalbzd5s"
Content-Disposition: inline
In-Reply-To: <20230323120030.7mk62xk7tco32zw2@bogus>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iUHciihrTalbzd5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 12:00:30PM +0000, Sudeep Holla wrote:
> On Fri, Mar 10, 2023 at 08:47:04AM -0600, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties. As
> > part of this, convert of_get_property/of_find_property calls to the
> > recently added of_property_present() helper when we just want to test
> > for presence of a property and nothing more.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/firmware/arm_scmi/optee.c | 2 +-
>=20
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>(for the SCMI part)
>=20
> I am assuming you will route this as it has other changes as well in the
> patch.

I can also pick this up along with the Tegra changes if Rob doesn't
want to take it. But also feel free to take this through whatever tree
works best, for the Tegra parts:

Acked-by: Thierry Reding <treding@nvidia.com>

--iUHciihrTalbzd5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQsJlcACgkQ3SOs138+
s6HDEhAAiyZv2IDatqnjFzcpro55n2pEFFzSq+wC+Rmf0uZ2n7/irrlJRwrx0+II
v1b6UP0dd7STZ+6vpKZ44WCXgrv58iushgVhqAD4W/tr8Q0uwUYc4vWzvv5UbN8S
vD2uizF0UuHLbKb9r/SttWElOD9U/iyZrP7IHlngTdznWyb1g5xV9hg0Eu351+qb
7DDNvlErcR3XmYeUcUTCd/SPjjJw2ZWxrJ01StWJand9145/UXyazJxVZ6j+i8I+
OUjx81H8ctLG3TAwfv4zWnR5ZlGndViv/hjVSQasEMe5b84ScQNBnDZB+xmtZAMp
Qn87+8fQcJgTP+UDR/YjjaHRegNGMu9fNqHS14+J2KFvn8nYS0xRPj3aDM8V7CS6
YDflkqK9r2je2dON9/UOKINRgqERHYIY1u9DTlaym97wUtE9a5uOelcsrAR3FScU
SG35J16O95HSXGzoxhwpqbMS0N/Tm5IQruT2ih2D3WNTZQqsjk+7KFSJ8JWabXY1
UYig/IrGLf8dnLoD1KtzxQAwdDslHmvdofvWBY9IBI+GodYQzCZVtyDTKilHi9i3
dW0/eO5knVsW6yWRrgtUEK0X3gIIvSeGr4NF02uuNSmyY94U+Um8e/LXZvc3lckI
+7VHpuvCR7jO4ORq18T2Yoq35yRvqrikIEonW3Oz5NHkAiXo+Iw=
=Qivr
-----END PGP SIGNATURE-----

--iUHciihrTalbzd5s--
