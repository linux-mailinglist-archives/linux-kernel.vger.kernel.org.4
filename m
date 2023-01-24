Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C267A698
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjAXXDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjAXXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:03:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E114E4AA6D;
        Tue, 24 Jan 2023 15:03:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1jDb2MCmz4xZb;
        Wed, 25 Jan 2023 10:02:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674601375;
        bh=C/sQI+DCClzKo+mlylX2P7kgiOImuOJ93LV9JzJ2IW0=;
        h=Date:From:To:Cc:Subject:From;
        b=DFupiJxQkE7eL+G/s445JQOt3WZ0YM8y6KAHK4sQr6InNt5QYFgNIfw1uFBls5FfK
         oL9hOMvd8D71Ur1dZdi+rP+wkw1n5NdG8deQsT84QI9OGpNEJlFZP3BDQWGO1Fj7zE
         c4sbDJu8yQb/OXG7HoX94t2w3sYWikgkCov5DVsPuHQSljItKbPc7axK3JFz8P8IO9
         R7QOzDfkRGXsYsa6H0uejDBI7/ss6mkLqAf/enPcjzqgt43m8/JqVtqtdWeypngoYb
         kzrI2IkL2ALpk3SHIv+6VrJbAl3p0yirDPoHfz9Oj7iZCcIeFTNj+9jrY/UTGz0bVR
         2wJL2gcUU+KIw==
Date:   Wed, 25 Jan 2023 10:02:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20230125100254.7eb4aeaa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n7Xz=2Ccana0DeiPEUXYz0C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n7Xz=2Ccana0DeiPEUXYz0C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "thermal_acpi_trip_crit" [drivers/thermal/intel/int340x_the=
rmal/int340x_thermal_zone.ko] undefined!
ERROR: modpost: "thermal_acpi_trip_psv" [drivers/thermal/intel/int340x_ther=
mal/int340x_thermal_zone.ko] undefined!
ERROR: modpost: "thermal_acpi_trip_act" [drivers/thermal/intel/int340x_ther=
mal/int340x_thermal_zone.ko] undefined!
ERROR: modpost: "thermal_acpi_trip_gtsh" [drivers/thermal/intel/int340x_the=
rmal/int340x_thermal_zone.ko] undefined!

Caused by commit

  0d568e144ead ("thermal/drivers/intel: Use generic trip points int340x")

and me choosing commit

  7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")

from the pm tree over commit

  4bb6439371e9 ("thermal/acpi: Add ACPI trip point routines")

from the thermal tree in the merge fix up.

I have just reverted commit 0d568e144ead for today until this can be
sorted out.

--=20
Cheers,
Stephen Rothwell

--Sig_/n7Xz=2Ccana0DeiPEUXYz0C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQY54ACgkQAVBC80lX
0GwY5ggAipXtclAbA+nWFK3vZmC3FnhlFlu3IvquGdGtE8734Tj0XjrisB1UcFih
1WedYiVDPYTYtmGowBHzYsp7KZn7nSmyPKr1udPSyUkP9R16IJxd3YQW0Y6PVZa7
3psUKNs/AtXX+eaMicIVYckmvNjDPEX8Ix4HjoYuwlsTd/u1yHQD41T+8GppZa9g
19CmSvyvBqQAIGoaDbOlA5X42gGYWDoGTB403QZAYmasuC3UAGg0llMaxSvOnrA0
pY4ejCIefqO2/VhAJ871j4VB7YudwLdA755Msgz8HI4GnjwwOctpxxokdDj7GzDz
i0AjNZf4m7uQtp155IZZHAnsNnPsug==
=Kabu
-----END PGP SIGNATURE-----

--Sig_/n7Xz=2Ccana0DeiPEUXYz0C--
