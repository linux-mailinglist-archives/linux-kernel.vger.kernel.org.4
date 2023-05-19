Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B0708D52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjESB1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjESB1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:27:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8770E3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:27:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba6d024a196so2403873276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684459623; x=1687051623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lvP7Q1DPXjSG9iBptgkojp087iyFGiylW3zAHv1G0s=;
        b=vOVrSlpzLvgAwRxr0Q+rmluXHst7drYbuTE/FlnkA0sI0Vq+REfrWisZRfc1SzSbgw
         tVsm1pXic0P6GJDF2/7zkD8ER83IoVL7aMp/bHPVrAHQkbbixm3Kg0HMLS35H/xAyVl+
         UTmOzWe+uQHcb5OYgXl4x58ilZsw3U0w8CB/8DRxqCAwNxEdqhyYWM9g8qj7xVjIwSzv
         RagYDOY7DuNgn/2/x2NdIprh8X8N+/x5WsqWtdLmu0RBcEsmDgIcvf39Vl0lvfYzI66p
         MeMDa4CFtzCaOZN4K8cznxO5u8tCBERtUczXNEkQCmNWKWb8p/nq25Dyc4YI11GlL9x7
         1/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459623; x=1687051623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lvP7Q1DPXjSG9iBptgkojp087iyFGiylW3zAHv1G0s=;
        b=FwwJn6Ip3WXSO2EQXsohH1SH7OJNv5OKT6nI5m0veTYJ6suRSSnAhjoq1xzXoyfeDC
         ZPg6gzHw/dzhGevae+f1guxkzNU5PYRRXZ94QTsIpuwX3iPX9N3m8WuBkb7Txusvc6q0
         RvMGjZIw46qCIaPkS47jZFUqf8xuDcGV50+xn266tOjXF/b5hY889GWyaLrsHFtqnCf4
         BiF9W3Z76MkK10MiJxpuDwCMr8yQZbkkwEsO4hMLs+h9GU+lw7FCvfdjIgI5TeZOAXNr
         9MJB+oA5pEX5ZgroUckLt5Cfxl5BYHedIp6aXvgxL51HvwYW+p4qCA3T8SZH1078R/G9
         Gisg==
X-Gm-Message-State: AC+VfDwitlD0S+Tm2YUpIV/gFHjjA8rx95O7NsA/zkR9TaS0TVWO8oe/
        6nHtEqFWRUK3+N78EUWqVofRyg==
X-Google-Smtp-Source: ACHHUZ60fWA8dMxrxSEEE9Cq6HNL+5hZBH8mz2lPQkgrGsomWHcS7zVmJG4fADlLH1bX8uxE4zKyvA==
X-Received: by 2002:a25:c7cb:0:b0:b8f:6cd0:4ef1 with SMTP id w194-20020a25c7cb000000b00b8f6cd04ef1mr192327ybe.17.1684459622935;
        Thu, 18 May 2023 18:27:02 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x6-20020a259c46000000b00b9ba6a3b675sm699871ybo.50.2023.05.18.18.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:27:02 -0700 (PDT)
Date:   Thu, 18 May 2023 21:26:59 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 05/41] counter: add HAS_IOPORT dependencies
Message-ID: <ZGbQYzXK8InMqkxu@fedora>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-6-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5bxTSeSIiawlWPZU"
Content-Disposition: inline
In-Reply-To: <20230516110038.2413224-6-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5bxTSeSIiawlWPZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Hi Niklas,

The change itself is fine, but please update the description to reflect
that this is adding a depends on HAS_IOPORT_MAP rather than HAS_IOPORT,
along with the reason why it's needed (i.e. devm_ioport_map() is used).

Thanks,

William Breathitt Gray

> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
>=20
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 4228be917038..e65a2bf178b8 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -15,6 +15,7 @@ if COUNTER
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
>  	depends on (PC104 && X86) || COMPILE_TEST
> +	depends on HAS_IOPORT_MAP
>  	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
> --=20
> 2.39.2
>=20

--5bxTSeSIiawlWPZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGbQYwAKCRC1SFbKvhIj
Kwr/AP9BDmkAnBXC+MjVSJOmxTQF8Sx5RdpwwV0Oaq8V32L4cAEAjgIcBwlTHN/4
SwcgWo1pJaiaLAG8+7C20VWkinQ4dwc=
=WkDE
-----END PGP SIGNATURE-----

--5bxTSeSIiawlWPZU--
