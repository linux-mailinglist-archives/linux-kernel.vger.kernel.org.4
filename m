Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8120B604E12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJSRFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJSRFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:05:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C3360B5;
        Wed, 19 Oct 2022 10:05:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bp11so30174264wrb.9;
        Wed, 19 Oct 2022 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqysGTkOBJycGtDb7wSmmQB6Sp6M/imHmic1k4qO3UY=;
        b=IXuoQgX2+kFspAaGtljJdIEcnG7mPVWiYaQkhgeqvf+xiyDIQ0cTH7QXpKgkWa0vIi
         HWOUnp6fR952NEZr0gI330bY3MHlNSIPZ0iWXh7S6qYvgs/fEkJPlfGB1ABGu8MO22Y3
         TYwHdGFCbP2mB+tv3CS7+URG5/1LhsA0hGaQL4M4tU7TZgU/ezzYtwTu4hKZxPsE11GK
         ce5mH4mhrGS67RYCU2BgoVL1nyFLYSQfWCm7YRMBEbfzum/PfWcxcU3bqRA6aa7/wymG
         Rh9Nc6EKrcdkvswZ0hrfR1WVfZDwnDV+9Q/0HdAdUVUykYymrKFSwYohtGHEhegXl94h
         jleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqysGTkOBJycGtDb7wSmmQB6Sp6M/imHmic1k4qO3UY=;
        b=ekp3yZ4FbQUQqD4OMxnly7QQ2IbUTojbmwEBlJJ2V0B2YBxRoFlPeqIg2N7mNnSd6M
         UDMGmiC/9vJJK6LI59XjqXN1Z4Nn8ikRmzMEppzlmBKXKv5p54z6aEAFq6RKfUlto0AV
         1kTODFUs46FRywqBGC5I3gDutAmDD05TVqdDcWbxsrAooGqKWAXHUZorGnsjIW841TtX
         gQnZnXZN4qG5pkk9L+Fu67BRIqu+/6t748PuHLP3YNWT6Kt7Pejke/9pEVBtihLZEPEr
         j3rhokgIPRFJ2K7/r8drl/WbQV/xCvB9rLe3veWqWst9N2NnaC8MEtCxh7nRKW1KfCxe
         aM/A==
X-Gm-Message-State: ACrzQf0ceMmlBV7b0wup8czVUNYGGvF0nJxA8DIVqGI8H+MiwkdxStlZ
        pfvS6S1gxer0Wj1dvXd2iwL/+nUUhfA=
X-Google-Smtp-Source: AMsMyM5xVmn6Go3DUnXXfnBgmmbgvak74x/VN878p6aVZ9k2oqh2GcqEwumVr75ndaygi+zex0RKkA==
X-Received: by 2002:a5d:64e1:0:b0:22e:762f:7d3f with SMTP id g1-20020a5d64e1000000b0022e762f7d3fmr5855796wri.526.1666199135247;
        Wed, 19 Oct 2022 10:05:35 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d54c6000000b0022e2c38f8basm13968949wrv.14.2022.10.19.10.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:05:34 -0700 (PDT)
Date:   Wed, 19 Oct 2022 19:05:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 31/44] serial: tegra: Use uart_xmit_advance()
Message-ID: <Y1AuW/+hvhJRxdnS@orome>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-32-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3XZVbHeGqeQkIdEi"
Content-Disposition: inline
In-Reply-To: <20221019091151.6692-32-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XZVbHeGqeQkIdEi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 12:11:38PM +0300, Ilpo J=C3=A4rvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--3XZVbHeGqeQkIdEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNQLlkACgkQ3SOs138+
s6HUMw//dYuH/QJT4vXXjc3yK4pMncn6/2lkoCWt10dBIEdl++zRuXu2m/ueKD0S
KCroi/Xzykt0pt5JOPu/rYJKL9vePrw2DdJXg5kmYyziN67k/3sPuOOCdGm9/K1R
3VuncqopCGqAiOkk7NGe0vXFRLBZhES6DMuNYxHLTzcuKtl5wWXV3U4NhvbV6EdX
zvCmaiiBKy8ee45D9DQ6GonosuqbJ0ZuE1rEkVQ0NtBadbF37LafP7yhF+N6dyS1
BTzpVYpLXBxH2e2dVNj5DC2AvPNHZK3iO1DCkDDbSWIdN8SA/5iJyYJUPuF0oQTR
MX62QXkOjEmb17sZOrXXmiZib5GrV5ZbgIbV0qJAKbGaD2oWmTeVrG3kQMb052IL
CrinFRb6/RR2JbDJpAUo9RhQnAQUCemS5iQI0p60od47kXucS5Xt74Jvz9EfREWM
+wx49ROUTbmZxovAsRk7LP02C89TMZdZ56dInsjh9Avz91iCXLeUCWktddmWaSnt
Wx5AGH6Dal1AKTUD6F55n8xpD7zw/agc9LkmRZbvpIncnRLvPpghTKdHfg7W79Z7
pVCP14HblaYhEiyYpatDV7hmtgveXELpCEYeyx+ZyOJg62pVuCLnabmV6WdNiiqR
PrNh36gT5LS2sJo1ME9HeYYgWiumDPYE0LALloX38/SZ6WsECbw=
=qmBf
-----END PGP SIGNATURE-----

--3XZVbHeGqeQkIdEi--
