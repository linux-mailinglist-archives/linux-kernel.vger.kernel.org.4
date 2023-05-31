Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A807176D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjEaGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjEaGaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:30:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A799;
        Tue, 30 May 2023 23:30:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso6009181b3a.3;
        Tue, 30 May 2023 23:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685514613; x=1688106613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHVa7qx0Y3jBTDZnlucyg01NugOE8nypPp8hA0hG/dw=;
        b=HBH9612+2knX82fth45xbRKdCtfbPytavOp7WDk3ypzmYifLwc5eSyA3HGAQYFHRRw
         Rx3ZoRcpPfx6aXxB2NnoCD0SooWD2XfgJKo6vCg6yvpzgKgjPEyuGpEeECuEoGXil24C
         4T7PgMvN24poTJ/gY7VvIDIaYep+7oKknut0Y/bvoGVhjCAc+E2XqzdtoB9PYY9YEIvS
         Yy0WWxmCA79lvGp6Pp5eiInla7i5k4scmIxumtqZaqpQuWBTuZFlZ664xJpod0ZM4B6+
         IgFIXhokFbKrziQXE+qFffqETujdtoUY1hUXshSPC/rYzoqabCFax8vCM4DDOwz6Wppz
         2lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685514613; x=1688106613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHVa7qx0Y3jBTDZnlucyg01NugOE8nypPp8hA0hG/dw=;
        b=BBMOMys5GIRAX4Du6sq5r4357zP8NpeIHthXwDKN2U5kWxh6cEFmYlzic85ygkb62u
         Vb+O5XtanhpG7jmg0LyrSTcaoG7Y9hnf7ncj4vRkeNzeF3GL4fbdvtvZPAbwpMkgMg8p
         e/PwuATpkzKiIPVFFsxnL8mhgoO255E847LHPG+6Hvz8b/tnb8bVh1BtMTeNruKH+A0P
         UJtCks+I0wgU3OIJhSvfDGrLJQo31yOiLMrDObeTSOH+141UGScS33NBLGmd/FC6wvK4
         D8Ya3daexvVanuaVbsE2FJJtam/xC/wjlitGZ0AjyYgRAK5rTmKD+jx9YHzpStVylyHX
         wS7g==
X-Gm-Message-State: AC+VfDxiyPijqWgRmxcbIv2D4gljC7EaQkcI5/Hq8D88x7RNQWmW8RYe
        brCaDBSp8LtNjqJZ6z9N6oY=
X-Google-Smtp-Source: ACHHUZ6l5RP0/ikc0bFoEqIOE7+0cjfMDe2SeELiqdDqA2CVkgeJsXgs0LfWt6L7uCReI1sEult8/g==
X-Received: by 2002:a05:6a20:918a:b0:10b:7400:cef7 with SMTP id v10-20020a056a20918a00b0010b7400cef7mr5828869pzd.17.1685514612988;
        Tue, 30 May 2023 23:30:12 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b0064ceb16a1a2sm2586467pfi.182.2023.05.30.23.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 23:30:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5E445106A0B; Wed, 31 May 2023 13:30:08 +0700 (WIB)
Date:   Wed, 31 May 2023 13:30:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>, soc@kernel.org
Cc:     conor@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        olof@lixom.net, palmer@dabbelt.com, robh+dt@kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v2] Documentation/process: add soc maintainer handbook
Message-ID: <ZHbpb98Yn7SDZ4XZ@debian.me>
References: <20230530-multiple-whooping-ee5706fceb67@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yfE+yvsUjvQ597xx"
Content-Disposition: inline
In-Reply-To: <20230530-multiple-whooping-ee5706fceb67@wendy>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfE+yvsUjvQ597xx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 01:49:36PM +0100, Conor Dooley wrote:
> diff --git a/Documentation/process/maintainer-soc.rst b/Documentation/pro=
cess/maintainer-soc.rst
> new file mode 100644
> index 000000000000..9683c7d199b2
> --- /dev/null
> +++ b/Documentation/process/maintainer-soc.rst
> @@ -0,0 +1,178 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _maintainer-soc:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +SoC Subsystem
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +The SoC subsystem is a place of aggregation for SoC-specific code.
> +The main components of the subsystem are:
> +
> +* devicetrees for 32- & 64-bit ARM and RISC-V
> +* 32-bit ARM board files (arch/arm/mach*)
> +* 32- & 64-bit ARM defconfigs
> +* SoC specific drivers across architectures, in particular for 32- & 64-=
bit
> +  ARM, RISC-V and Loongarch
> +
> +These "SoC specific drivers" do not include clock, GPIO etc drivers that=
 have
> +other top-level maintainers. The drivers/soc/ directory is generally mea=
nt
> +for kernel-internal drivers that are used by other drivers to provide SoC
> +specific functionality like identifying a SoC revision or interfacing wi=
th
> +power domains.
> +
> +The SoC subsystem also serves as an intermediate location for changes to
> +drivers/bus, drivers/firmware, drivers/reset and drivers/memory.  The ad=
dition
> +of new platforms, or the removal of existing ones, often go through the =
SoC
> +tree as a dedicated branch covering multiple subsystems.
> +
> +The main SoC tree is housed on git.kernel.org:
> +  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/
> +
> +Clearly this is quite a wide range of topics, which no one person, or ev=
en
> +small group of people are capable of maintaining.  Instead, the SoC subs=
ystem
> +is comprised of many submaintainers, each taking care of individual plat=
forms
> +and driver sub-directories.
> +In this regard, "platform" usually refers to a series of SoCs from a giv=
en
> +vendor, for example, Nvidia's series of Tegra SoCs.  Many submaintainers=
 operate
> +on a vendor level, responsible for multiple product lines.  For several =
reasons,
> +including acquisitions/different business units in a company, things vary
> +significantly here.  The various submaintainers are documented in the
> +MAINTAINERS file.
> +
> +Most of these submaintainers have their own trees where they stage patch=
es,
> +sending pull requests to the main SoC tree.  These trees are usually, bu=
t not
> +always, listed in MAINTAINERS.  The main SoC maintainers can be reached =
via the
> +alias soc@kernel.org if there is no platform-specific maintainer, or if =
they
> +are unresponsive.
> +
> +What the SoC tree is not, however, is a location for architecture specif=
ic code
> +changes.  Each architecture has it's own maintainers that are responsibl=
e for
> +architectural details, cpu errata and the like.
> +
> +Information for (new) Submaintainers
> +------------------------------------
> +
> +As new platforms spring up, they often bring with them new submaintainer=
s,
> +many of whom work for the silicon vendor, and may not be familiar with t=
he
> +process.
> +
> +Devicetree ABI Stability
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Perhaps one of the most important things to highlight is that dt-bindings
> +document the ABI between the devicetree and the kernel. Please see
> +:ref:`devicetree-abi` more information on the ABI.
> +
> +If changes are being made to a devicetree that are incompatible with old
> +kernels, the devicetree patch should not be applied until the driver is,=
 or an
Until the incompatible driver changes are merged?
> +appropriate time later.  Most importantly, any incompatible changes shou=
ld be
> +clearly pointed out in the patch description and pull request, along wit=
h the
> +expected impact on existing users, such as bootloaders or other operating
> +systems.
> +
> +Driver Branch Dependencies
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A common problem is synchronizing changes between device drivers and dev=
icetree
> +files, even if a change is compatible in both directions, this may requi=
re
> +coordinating how the changes get merged through different maintainer tre=
es.
> +
> +Usually the branch that includes a driver change will also include the
> +corresponding change to the devicetree binding description, to ensure th=
ey are
> +in fact compatible.  This means that the devicetree branch can end up ca=
using
> +warnings in the "make dtbs_check" step.  If a devicetree change depends =
on
> +missing additions to a header file in include/dt-bindings/, it will fail=
 the
> +"make dtbs" step and not get merged.

Sounds like passing `make dtbs` is a merging requirement.

> +Pull requests for bugfixes for the current release can be sent at any ti=
me, but
> +again having multiple smaller branches is better than trying to combine =
too many
> +patches into one pull request.
> +
> +The subject line of a pull request should begin with "[GIT PULL]" and ma=
de using
> +a signed tag, rather than a branch.  This tag should contain a short des=
cription
> +summarising the changes in the pull request.  For more detail on sending=
 pull
> +requests, please see :ref:`pullrequests`.

As jon had said, I simply prefer to write the last cross-ref as:

```
=2E.. For more details on sending pull requests, see Documentation/maintain=
er/pull-requests.rst.
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yfE+yvsUjvQ597xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHbpaQAKCRD2uYlJVVFO
o2CWAP9q7oPy97dPSpBlxmb3b8mi73z4mh1PJl8kp27n5DmHDAEA+JxXgVRwCfXd
gpWxS2SpGlRx9lJqq4W6qaQbA+LF1Ac=
=uOGN
-----END PGP SIGNATURE-----

--yfE+yvsUjvQ597xx--
