Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EFB6FB25A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEHONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjEHONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:13:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033917DE6;
        Mon,  8 May 2023 07:13:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643990c5373so4397499b3a.1;
        Mon, 08 May 2023 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683555189; x=1686147189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iD8iShgfKv8OLGMPP2MraC3de5SlB6RRvAlLpegpMI0=;
        b=Yo6a2AUSG4UtT5ZH+ecVAGioVzYMr3bHGY2WM0rzwW/m6nlcoWbbMmX2fmL8RTnfD9
         iI2PpvP5V4WKOgXEq9tX2Hlc4U2m2NRcNEnQyctlQ3/dM+sFuIQVm/fz9w8mUPrDbnV0
         gN2M/2j7oRNItnPDnCq+O2WO8aoUCZZC4yQpgrrEp7bQ/kiOrsLkqMPoXwXX0dg+9KQ6
         wCh3qPkK+xOcvY4jNGQ31FJTiyru/Mde6GTEBUZKNv8+WGUfnQEaNITzUtl3Sx4QzZBM
         f1BDFso79f5fngQvGksistouwspC6TiQvf1n+lrVFQMzpD2GCq6ML9xjQL7iZdXbBthv
         Hhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683555189; x=1686147189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD8iShgfKv8OLGMPP2MraC3de5SlB6RRvAlLpegpMI0=;
        b=LTPae2LxvO3E2eYWsULg4ov9DRNxVri1SLiFlO+y9uNN46TWLt5OJxxRUPzXgI0o3e
         B/V/bCDSTZIzx3WJtWv4X7QpC/Y7zSaIKygdcRoHw44aDSa4WhocHNOpvND2vWdyzYAC
         YxlA/CJoOeiPrSC5fV5iiUc1Pwv8uUxVPAltFuwgPX1dOTAhgd2i/f/2oPnl8hS52Uht
         jv9tMSeedN+axbwxvHatQWfPB7B539fxOVf3PgYz5ZXXAsUy/SOKZmJY4/v9jn169FL6
         Ny6MsOgnXzFK88eorHU1SOrdfiWbeFXz2QSVrfx0XtZ0JkJtX+c1bKSRXcQ8h+uViNQw
         stqg==
X-Gm-Message-State: AC+VfDytcjlaz3e4IOTAqCFY69fFb+55oYIg79RC4jsDkV2JU+p1A/32
        nFBlurbb8Ty/1TVDEOc8OHQ=
X-Google-Smtp-Source: ACHHUZ4c+H4wpWBYfsptvQdvMKZ/tgnjeALUYIqEGPobwYtJ9MaLXSYVM0V9P5p5vbHsTAUzLYDSVA==
X-Received: by 2002:a05:6a20:12c6:b0:f3:47b4:861b with SMTP id v6-20020a056a2012c600b000f347b4861bmr13511974pzg.17.1683555189288;
        Mon, 08 May 2023 07:13:09 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-47.three.co.id. [116.206.28.47])
        by smtp.gmail.com with ESMTPSA id 205-20020a6304d6000000b00502e7115cbdsm6358397pge.51.2023.05.08.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:13:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B120910629F; Mon,  8 May 2023 21:13:05 +0700 (WIB)
Date:   Mon, 8 May 2023 21:13:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] docs: dt: Make references and mention kernel
 abstractions
Message-ID: <ZFkDce5ISNEu6nsp@debian.me>
References: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
 <4b0249cd-7538-6df4-777b-d25a72f06668@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xOniEH0+SQaTVZrU"
Content-Disposition: inline
In-Reply-To: <4b0249cd-7538-6df4-777b-d25a72f06668@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xOniEH0+SQaTVZrU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 03:09:11PM -0700, Randy Dunlap wrote:
> For @linux-doc: Is there something in ReST that does auto section numberi=
ng
> so that this renumbering does not have to be repeated in the future?
>=20

There is sectnum:: directive which does the job. In the kernel docs,
however, it is customarily used together with contents:: directive to
generate toctree for current doc. In order for this to work as expected,
you need also to rearrange section heading levels, like:

---- >8 ----
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devic=
etree/usage-model.rst
index 87f522d5feba81..890dde293540f9 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -1,5 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
+.. contents::
+.. sectnum::
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Linux and the Devicetree
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -76,7 +79,7 @@ If you haven't already read the Device Tree Usage\ [1]_ p=
age,
 then go read it now.  It's okay, I'll wait....
=20
 2.1 Linux Kernel Firmware Abstractions
---------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 The Linux kernel supports several different hardware description
 frameworks and DT is just one of them. The closest sibling is the
@@ -112,7 +115,8 @@ resources to other devices in the DT, will need to impl=
ement calls into
 the DT abstractions.
=20
 2.2 High Level View
--------------------
+~~~~~~~~~~~~~~~~~~~
+
 The most important thing to understand is that the DT is simply a data
 structure that describes the hardware.  There is nothing magical about
 it, and it doesn't magically make all hardware configuration problems
@@ -134,7 +138,8 @@ Linux uses DT data for three major purposes:
 3) device population.
=20
 2.3 Platform Identification
----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 First and foremost, the kernel will use data in the DT to identify the
 specific machine.  In a perfect world, the specific platform shouldn't
 matter to the kernel because all platform details would be described
@@ -217,7 +222,8 @@ compatible list, and probably should be avoided for new=
 architecture
 support.
=20
 2.4 Runtime configuration
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
 In most cases, a DT will be the sole method of communicating data from
 firmware to the kernel, so also gets used to pass in runtime and
 configuration data like the kernel parameters string and the location
@@ -254,7 +260,8 @@ scanning of the device tree after selecting the correct=
 machine_desc
 that supports the board.
=20
 2.5 Device population
----------------------
+~~~~~~~~~~~~~~~~~~~~~
+
 After the board has been identified, and after the early configuration data
 has been parsed, then kernel initialization can proceed in the normal
 way.  At some point in this process, unflatten_device_tree() is called

The caveat is the title heading also get numbered, making it top-level
section. Hence, it is more appropriate if the directory toctree:: also
have :numbered: option to do the job instead:

---- >8 ----
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/=
index.rst
index 1a2fc80149966e..b5297dd511ef31 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -8,6 +8,7 @@ Kernel Devicetree Usage
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 .. toctree::
    :maxdepth: 1
+   :numbered:
=20
    usage-model
    of_unittest

Anyway, if you use auto section numbering, you need to also remove the manu=
al
numbers:

---- >8 ----
diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devic=
etree/usage-model.rst
index 0ff62cdb3cc51c..e2dfbcc38c2f03 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -42,8 +42,8 @@ incompatible, bindings for i2c busses that came about bec=
ause the new
 binding was created without first investigating how i2c devices were
 already being enumerated in existing systems.
=20
-1. History
-----------
+History
+-------
 The DT was originally created by Open Firmware as part of the
 communication method for passing data from Open Firmware to a client
 program (like to an operating system).  An operating system used the
@@ -72,13 +72,13 @@ all architectures.  At the time of this writing, 6 main=
lined
 architectures (arm, microblaze, mips, powerpc, sparc, and x86) and 1
 out of mainline (nios) have some level of DT support.
=20
-2. Data Model
--------------
+Data Model
+----------
 If you haven't already read the Device Tree Usage\ [1]_ page,
 then go read it now.  It's okay, I'll wait....
=20
-2.1 Linux Kernel Firmware Abstractions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Linux Kernel Firmware Abstractions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 The Linux kernel supports several different hardware description
 frameworks and DT is just one of them. The closest sibling is the
@@ -113,8 +113,8 @@ detected devices using the device tree, or that want to=
 provide
 resources to other devices in the DT, will need to implement calls into
 the DT abstractions.
=20
-2.2 High Level View
-~~~~~~~~~~~~~~~~~~~
+High Level View
+~~~~~~~~~~~~~~~
=20
 The most important thing to understand is that the DT is simply a data
 structure that describes the hardware.  There is nothing magical about
@@ -136,8 +136,8 @@ Linux uses DT data for three major purposes:
 2) runtime configuration, and
 3) device population.
=20
-2.3 Platform Identification
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Platform Identification
+~~~~~~~~~~~~~~~~~~~~~~~
=20
 First and foremost, the kernel will use data in the DT to identify the
 specific machine.  In a perfect world, the specific platform shouldn't
@@ -220,8 +220,8 @@ However, this approach does not take into account the p=
riority of the
 compatible list, and probably should be avoided for new architecture
 support.
=20
-2.4 Runtime configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Runtime configuration
+~~~~~~~~~~~~~~~~~~~~~
=20
 In most cases, a DT will be the sole method of communicating data from
 firmware to the kernel, so also gets used to pass in runtime and
@@ -258,8 +258,8 @@ On ARM, the function setup_machine_fdt() is responsible=
 for early
 scanning of the device tree after selecting the correct machine_desc
 that supports the board.
=20
-2.5 Device population
-~~~~~~~~~~~~~~~~~~~~~
+Device population
+~~~~~~~~~~~~~~~~~
=20
 After the board has been identified, and after the early configuration data
 has been parsed, then kernel initialization can proceed in the normal

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xOniEH0+SQaTVZrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFkDagAKCRD2uYlJVVFO
oysPAQDxWkP3fxh7R+TWnA4ynuNz9UlgQ7SMY9jzck+htYXc2QEA2U4yeZYXribV
zay6/Xfm83+oep4xtcG9V6g3cXkfgAo=
=KKzX
-----END PGP SIGNATURE-----

--xOniEH0+SQaTVZrU--
