Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D700F6F8E6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjEFDwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEFDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:51:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4385F7695;
        Fri,  5 May 2023 20:51:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so1683323a12.3;
        Fri, 05 May 2023 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683345115; x=1685937115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lntOibfeThJPpn1VJ7xfamv/ry4wwbglMlCIgAw/SuQ=;
        b=KsAu+SR+0lyn3VqoKAZIBZeGRpu2Mrb+jVusCwgtPeRHwbO92SgJpOSO7Oy5UAJexe
         7y6v6Uw3RCZ7e6eqZBg9bPcKtQA/GyMoz0kkybZFlT9ctFBBQLFf8wbiXbIbVDIjtK+c
         lQEAaTHYixT8SD1MDhdlg5VtGU2pOJn7ND93nK5pPMoUkjzUe4Gs8iQLi13q9CZMXOSj
         nY/UJ54CAwvG27njWZtoXwKPZ84Sc6nmUBE4yfgam/dGvAp9M9O49DLQ5tBTgbLrguSm
         MRiqk8fwlEEQ7ZWE+7rzKly3dl4NjNggmZKzh9enV6u3XXYiFP9VS5daBjNfZBVqvZQl
         SpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683345115; x=1685937115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lntOibfeThJPpn1VJ7xfamv/ry4wwbglMlCIgAw/SuQ=;
        b=Pgi/bKDeLvDYvDhrJfiI2OzhLIZvl4JRP+D8mXLlMNKQvi8Wh+Scfp0R+Aku6IeTrq
         4pT/5J6BGxtyuLK4e3inXWPvbnwe7ZPE52eeCb5bIWUviwMiYeJY1GrQ98CbVvmzOJM2
         0OzuOHo6CwM6ChgQ0OqmQOCMmD2J1R7c9pu4YGdHx5DCpCJI7Lrlf2VyUWyn3pthRkoc
         f+tM3tVlmJwzeYSIkGiwMcPMLylyS1jKSPVf7kTKcfmH5rsMi+3zmZgggI57HCB9EnVf
         HFVoIeFWcrNbZguNsuppJKspu0z9DomeOTE3Mtv2IVrFKqI1SLW0evgWNAChdyxn2nyC
         9izg==
X-Gm-Message-State: AC+VfDxUFwH2jYf8Fh2NDUg8clH9EGpYXA2MYBz+OhYptiA/Bi4SYXAl
        qHY8UWlmaszuumeUzsnErn4=
X-Google-Smtp-Source: ACHHUZ5zj0iukVw0Wp6lKsVZ8izr5sCbXHEPIoKgZMiu/WjkBSbE8RdqI9SBwEBeJTRBDcPanyiuhA==
X-Received: by 2002:a17:902:8695:b0:19c:a9b8:4349 with SMTP id g21-20020a170902869500b0019ca9b84349mr3168517plo.32.1683345114610;
        Fri, 05 May 2023 20:51:54 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902740500b001ab09f5ca61sm2482665pll.55.2023.05.05.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:51:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BE241106849; Sat,  6 May 2023 10:51:50 +0700 (WIB)
Date:   Sat, 6 May 2023 10:51:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] docs: dt: Make references and mention kernel
 abstractions
Message-ID: <ZFXO1pRq4/fNw33/@debian.me>
References: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4FC0DSTJcODP+zd/"
Content-Disposition: inline
In-Reply-To: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4FC0DSTJcODP+zd/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 02:43:53PM +0200, Linus Walleij wrote:
> This document is named "Linux and Devicetree" so I think we
> should write a bit more about how the device tree fits into
> the Linux kernel frameworks these days after we have created
> the fwnode and swnode.
>=20

Also Cc: linux-doc list.

> +The Linux kernel supports several different hardware description
> +frameworks and DT is just one of them. The closest sibling is the
> +:ref:`Documentation/firmware-guide/acpi/index.rst ACPI`
> +DSDT (Differentiated System Description Table).
> <snipped>...
> +Further, when the DT core register devices these need to fold into the
> +Linux device driver model, which essentially means that some kind of
> +``struct device`` has to be created to match a corresponding
> +``struct device_driver``. This API can be explored in
> +detail in :ref:`Documentation/driver-api/driver-model/index.rst the driv=
er API documentation`
> +but what you need to know is that the Linux DT parser code will on its
> +own mostly spawn platform devices and AMBA devices on the platform
> +and AMBA bus respectively, and apart from that it will augment devices
> +spawn on other buses where applicable.
> +

Anchor text for :ref: links above don't mix well, so I have to override
them (also specifying intended doc target - correct me if these are wrong):

diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devic=
etree/usage-model.rst
index 37605cb549cf59..87f522d5feba81 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -80,8 +80,7 @@ then go read it now.  It's okay, I'll wait....
=20
 The Linux kernel supports several different hardware description
 frameworks and DT is just one of them. The closest sibling is the
-:ref:`Documentation/firmware-guide/acpi/index.rst ACPI`
-DSDT (Differentiated System Description Table).
+:doc:`DSDT (Differentiated System Description Table) from ACPI </firmware-=
guide/acpi/namespace>`.
=20
 To make it possible to write a device driver that will adapt to DT
 or other hardware description models, the kernel has grown some
@@ -101,7 +100,7 @@ Further, when the DT core register devices these need t=
o fold into the
 Linux device driver model, which essentially means that some kind of
 ``struct device`` has to be created to match a corresponding
 ``struct device_driver``. This API can be explored in
-detail in :ref:`Documentation/driver-api/driver-model/index.rst the driver=
 API documentation`
+detail in :doc:`the driver API documentation </driver-api/driver-model/ove=
rview>`
 but what you need to know is that the Linux DT parser code will on its
 own mostly spawn platform devices and AMBA devices on the platform
 and AMBA bus respectively, and apart from that it will augment devices

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4FC0DSTJcODP+zd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFXO0QAKCRD2uYlJVVFO
o1ADAP0U4Eqkto8ez70YgMni5+n70+3PXK2Djzh36Qxvq/oLfgD/ZqqHP4lXarNA
2qxmUqeGfJ78jWC2apff2dUzqklVLAw=
=2tz4
-----END PGP SIGNATURE-----

--4FC0DSTJcODP+zd/--
