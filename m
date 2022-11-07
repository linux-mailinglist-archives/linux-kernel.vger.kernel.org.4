Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323D461E9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiKGD5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKGD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:57:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61289B7F5;
        Sun,  6 Nov 2022 19:57:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l6so9428369pjj.0;
        Sun, 06 Nov 2022 19:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFMW3O4nMzzbsjps13fey55rZ3wr/PRwCQWHd1qcbcA=;
        b=cBnySRhwG9RoqlHnyyNDFqhPlpjxDLCS4e5dnFc2lZK2UFHxFIIFJwEkPyJ3PHw3c/
         Q0fP3TgkwQoRItRNssOvfgKeobkt2uXGkcn7kZxO3BbWQ0jBRvGCKb3hCfUJafKjqq8k
         uR6Cd4x1u48Ox6DzxUTa19AeGAq6ZdpD+lBSwFXqmULfd/mXqsil114RRgw6TxpdTiLz
         /tm9VL/RTqfc5Q53iwcCAK8WtnF653mfAd6XQv9kGUlvTiYZTKGW11cG5qDm8l8AeNYt
         OobCKgopZrtYt6ugCFghPhU4FVwgvqbH5G50GBZuL6yk9XGYmNxH9lcDHRC4DXMu2TPI
         1XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFMW3O4nMzzbsjps13fey55rZ3wr/PRwCQWHd1qcbcA=;
        b=UNgni8SrPuwTh+sAQERrK00jugrI/t7H0J+THUw4n4bEWgtlYjpGP93TuC6tbpkY0I
         B1CbTYliBSWshhzUqfr4g61ZgG63+1oip8cfWjypWzJJ0SUnp5JiBNeVw4ggMGKebgJG
         KrgShBMn7kEjmC39zJ5/Zjn5MJBxgodUDMNxnTPwLzFGyUfFDieTvUCkCPqG+2zXlPU7
         Q82+RWaJzLKWIDH/kMOlsvkwkO7E+/lL8j7NXvwjV0R88d95HrqJXf795YJ3C1gIXNJ4
         h5rzWup7aKU9YpggV04IefKF8huECDtscB+ePxglTL5A+JqrYjCVyTluT+za2Oz3yzOW
         kJuA==
X-Gm-Message-State: ACrzQf10uspqETAk3axpsNxh0Pu/Ew/iECtV2100JvaNLkhiOKOJT1vK
        31kVPU7Nu3PnA4aPQCSkquA=
X-Google-Smtp-Source: AMsMyM4dGSaEfzbbZa2tW2MWyiEUxcwujp0EXKxIC/QK7xq2+L6A/rW/IJiML0aA97pqbqrq5krEUg==
X-Received: by 2002:a17:902:ccc2:b0:178:29e1:899e with SMTP id z2-20020a170902ccc200b0017829e1899emr48045976ple.114.1667793422831;
        Sun, 06 Nov 2022 19:57:02 -0800 (PST)
Received: from debian.me (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id 68-20020a621647000000b0056bd1bf4243sm3282388pfw.53.2022.11.06.19.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 19:57:02 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B260E103B90; Mon,  7 Nov 2022 10:56:58 +0700 (WIB)
Date:   Mon, 7 Nov 2022 10:56:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Message-ID: <Y2iCCpKYRm0c7gvZ@debian.me>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
 <20221104193657.105130-2-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xo6UyqZ2b1CGVEcP"
Content-Disposition: inline
In-Reply-To: <20221104193657.105130-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xo6UyqZ2b1CGVEcP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 02:36:52PM -0500, nick.hawkins@hpe.com wrote:
> diff --git a/Documentation/hwmon/gxp-fan-ctrl.rst b/Documentation/hwmon/g=
xp-fan-ctrl.rst
> new file mode 100644
> index 000000000000..fc1709fb113b
> --- /dev/null
> +++ b/Documentation/hwmon/gxp-fan-ctrl.rst
> @@ -0,0 +1,36 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver gxp-fan-ctrl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Supported chips:
> +
> +  * HPE GXP SOC
> +
> +Author: Nick Hawkins <nick.hawkins@hpe.com>
> +
> +
> +Description
> +-----------
> +
> +gxp-fan-ctrl is a driver which provides fan control for the hpe gxp soc.
> +The driver allows the gathering of fan status and the use of fan
> +pwm control.
> +
> +
> +Usage Notes
> +-----------
> +
> +Traditionally fanY_input returns an RPM value, on HPE GXP systems it is
> +the pwm value [0-255] due to the fan speeds being reported as
> +percentages.
> +
> +
> +Sysfs attributes
> +----------------
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +pwm[0-15]		Fan 0 to 15 respective pwm value
> +fan[0-15]_input		Fan 0 to 15 respective input value: pwm value
> +fan[0-15]_fault		Fan 0 to 15 respective fault status: 1 fail, 0 ok
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

You need to add the documentation to toctree of hwmon documentation:

---- >8 ----

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index ddff3c5713d74e..29ecef3ba4870b 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -73,6 +73,7 @@ Hardware Monitoring Kernel Drivers
    g762
    gsc-hwmon
    gl518sm
+   gxp-fan-ctrl
    hih6130
    ibmaem
    ibm-cffps

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Xo6UyqZ2b1CGVEcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2iCBQAKCRD2uYlJVVFO
o9iXAQC5dCdUaEBhlftegSoX9NMmwqr5otKpX0J4Hyg6r6BWxQEAwN3T6R2st6FD
eQsWtMfkIixxZzJaGvqzv40MwM9tfAg=
=Jvc3
-----END PGP SIGNATURE-----

--Xo6UyqZ2b1CGVEcP--
