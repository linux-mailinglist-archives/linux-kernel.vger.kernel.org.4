Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE4709971
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjESOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjESOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:21:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0537192
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:21:12 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561deaad117so46579757b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684506072; x=1687098072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jD0yVuhNIJ7sH/WR7FfoCKVL3m6JfoadwNdrAx1+BfI=;
        b=k3Q7zCJd7SrM6WeO4BXv32omMuNfNO8xoS1Nt+7oOVxgtcmcRkzXN9nUaUZthvaeMx
         2pZFH6Hzncg+O0DjEkEGbSr28Ewlj1j3BRCKSML2FbRbd9eW+kiQymgS+9Vdd+gGyb/G
         b2NOKgCVlGUxDF2lGvX4J3eQpXD4upxY3yQRBmkAyvhZiQtcS1W65W+WbXNEC5FoRCmJ
         pk7dhUYd+EpUR09+fVRjmEScDNJJ0iXrXarZyeVdjVem16N+5ihl77p515rZI2A7bAqo
         4aNDHgYn1ut0uFOynwVqkIiWs5Zb8BNkpbMdfbhoe195SuluhfKNtlpTWtNeTn2e7Tbi
         dSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506072; x=1687098072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD0yVuhNIJ7sH/WR7FfoCKVL3m6JfoadwNdrAx1+BfI=;
        b=dDN5vXQiuMro3OIYYbpLXicZ3uK9ksglhI3jTOXlc8kQXCxZilE0KYIg6YhllRJSwf
         2v+TD4PS50Ez67TOyqkVkSYml0/2L1t7U1r2BuHbKjuSqaTQLUAGcoN/6O90C3wUxc/w
         f31MC6tg7b9VaW4kX6l2WDxIy7HdIXlTVJKSF6iMSLIi+XxQe9d1zxbgH7nDoFHSiATX
         SCAhwCMeMGsMpeBOsBCBhOe6REfwUbch9mK2DsYd7/lc/TgsHpuAeKXI9lTWKmYsJL2Y
         s2FOg/+tUdXtPi9mPQ7ulQGJU4/Wl/xcAu84n1BqSqPnpAY8iBDyZ6dquvlPwq7U2biI
         chiA==
X-Gm-Message-State: AC+VfDysN3Nw+NC2hAkkO3vkCHbCqO/cSb59o8s2vJ/I17c3W5qwidCZ
        itrVUVCVUuC88bZrOTHZQ+1ZBg==
X-Google-Smtp-Source: ACHHUZ6NsUlRU62aztZHG3BPnNcjT59T5yuWn3x8G1LBoK7m3LHMEqTd3W6SzUBZR5s1puYI+P7FSQ==
X-Received: by 2002:a81:5247:0:b0:561:c5c3:9d79 with SMTP id g68-20020a815247000000b00561c5c39d79mr1895406ywb.45.1684506071882;
        Fri, 19 May 2023 07:21:11 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r187-20020a815dc4000000b00545a08184bbsm1189286ywb.75.2023.05.19.07.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:21:11 -0700 (PDT)
Date:   Fri, 19 May 2023 10:21:08 -0400
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
Message-ID: <ZGeF1K0Yxu9lTgN2@fedora>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-6-schnelle@linux.ibm.com>
 <ZGbQYzXK8InMqkxu@fedora>
 <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
 <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
 <abc02dc2af7563ae26bf0d0ddd927d9b4a21dda3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EBH9/xbXifix297d"
Content-Disposition: inline
In-Reply-To: <abc02dc2af7563ae26bf0d0ddd927d9b4a21dda3.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EBH9/xbXifix297d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 03:39:57PM +0200, Niklas Schnelle wrote:
> On Fri, 2023-05-19 at 15:38 +0200, Niklas Schnelle wrote:
> > On Fri, 2023-05-19 at 15:17 +0200, Niklas Schnelle wrote:
> > > On Thu, 2023-05-18 at 21:26 -0400, William Breathitt Gray wrote:
> > > > On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> > > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and =
friends
> > > > > not being declared. We thus need to add HAS_IOPORT as dependency =
for
> > > > > those drivers using them.
> > > > >=20
> > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > >=20
> > > > Hi Niklas,
> > > >=20
> > > > The change itself is fine, but please update the description to ref=
lect
> > > > that this is adding a depends on HAS_IOPORT_MAP rather than HAS_IOP=
ORT,
> > > > along with the reason why it's needed (i.e. devm_ioport_map() is us=
ed).
> > > >=20
> > > > Thanks,
> > > >=20
> > > > William Breathitt Gray
> > > >=20
> > > >=20
> > >=20
> > > Right, this clearly needs adjustment. I went with the following commit
> > > message for v5:
> > >=20
> > > "counter: add HAS_IOPORT_MAP dependency
> > >=20
> > > The 104_QUAD_8 counter driver uses devm_ioport_map() without depending
> > > on HAS_IOPORT_MAP. This causes compilation to fail on platforms such =
as
> > > s390 which do not support I/O port mapping. Add the missing
> > > HAS_IOPORT_MAP dependency to fix this."
> > >=20
> >=20
> > Just noticed this isn't entirely correct. As devm_ioport_map() has an
> > empty stub for HAS_IOPORT_MAP=3Dn this doesn't lead to a compile error =
it
> > just doesn't work. Will reword to "This causes the driver to not be
> > useable on platforms ..."
>=20
> s/useable/usable/

104_QUAD_8 has an explicit dependency on PC104 and X86, so I don't think
it would ever be used outside of x86 platforms. Does it still make sense
to have the HAS_IOPORT_MAP dependency in this case?

William Breathitt Gray

--EBH9/xbXifix297d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGeF1AAKCRC1SFbKvhIj
K453AP9zNn9wgYcEBDa5y15FH8KKUQSfyNCaUMKyjOcLaFoeEQEAiYcdE/TNd4HS
t4Z4xU0Ws5yWOLB4p4wMFw+18EyLmQM=
=BAPi
-----END PGP SIGNATURE-----

--EBH9/xbXifix297d--
