Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC668B333
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBFAVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:21:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752211E;
        Sun,  5 Feb 2023 16:21:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P96Q008SWz4x1f;
        Mon,  6 Feb 2023 11:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675642905;
        bh=kdSBUm1XzmULWwCbz+MsNw6BwD9DMZRj+DEeYUGV4II=;
        h=Date:From:To:Cc:Subject:From;
        b=DN8Ju3eQ0NRl/0/u6o+i5RCg68VN6SMS76jrEXkCYcvY8tcvLxrKs9DeSJxDRmWmo
         OKuFAHpiHhs0fbnbKsVTT8W4m8Lm3KHG/qG66UB6dDQQ9+FGrOvXmBgEI81ciNhTAR
         CLd25zQnVB+WPf9hhTlAY+7+b0bHDKugWpeIC8ZyFpLN5+5poN9Dzpq/WLED54qMTG
         HBmRAB5BfqDWHrsh+VANdUZCgBJb50WxSWYwgy2EHvp/9yTdQXzHJ2ZnMWMiSWzdDd
         Rer+HibenBRBI+ZppWucyXl/5etHE+3lQ8oTA+4G0XpL9w8tW3VBbjSwn/XE1zBgVe
         u6j+Pa9HKymfw==
Date:   Mon, 6 Feb 2023 11:21:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Alina Yu <alina_yu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the battery tree with the arm-soc tree
Message-ID: <20230206112143.71d626bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CEzHtiX6X7NY758jd=lQFyO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CEzHtiX6X7NY758jd=lQFyO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the battery tree got a conflict in:

  drivers/power/supply/Makefile

between commit:

  a0f831756b26 ("power: remove s3c adc battery driver")

from the arm-soc tree and commits:

  4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
  6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")

from the battery tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/power/supply/Makefile
index 8cb3c7f5c111,f8f9716d3ba4..000000000000
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@@ -52,8 -54,12 +52,10 @@@ obj-$(CONFIG_BATTERY_DA9150)	+=3D da9150-
  obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
 -obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
+ obj-$(CONFIG_CHARGER_RT9467)	+=3D rt9467-charger.o
+ obj-$(CONFIG_CHARGER_RT9471)	+=3D rt9471.o
 -obj-$(CONFIG_BATTERY_S3C_ADC)	+=3D s3c_adc_battery.o
  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
  obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
  obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o

--Sig_/CEzHtiX6X7NY758jd=lQFyO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgSBcACgkQAVBC80lX
0GzgcAgAjclu0BzM5kku7VdMju5VEq7oVPvkc2p/ZDFq99YPISUuA/MTysfXSmfj
AbA2Ewqhfpt0DWK82dEGxfmQCbzL/zg4EFdovxQwMa2lrlGPeEFpPoil234lAz7P
a2JvN1K5M+ZhqY0T5cBEb5PKhSZsyR7M9d2nr0gigJOds2fnVeOT2i8XWPln7JJ1
M2nkSSJ9hhkBfcDAf4/YRhI4M9WMAGSSCoIxQ+XXLLj//K6CmAqsPH9gqE0+YR5l
ynrnvHyy7akZ6pEdD7sIwhp0qSMaO9vyHKgGp5HyMOUH1Ccd7Qo5VUDpw8JjnaHA
4e4Ll/RzE0fE9c83QNE2KAwx6a99rw==
=8qru
-----END PGP SIGNATURE-----

--Sig_/CEzHtiX6X7NY758jd=lQFyO--
