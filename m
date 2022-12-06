Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198CE6439E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLFAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:24:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A841F2FC;
        Mon,  5 Dec 2022 16:24:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NR1QC49S2z4x1T;
        Tue,  6 Dec 2022 11:24:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670286292;
        bh=4bttU9xuSbnp1T/tbvdcKwjQVJPJdcK+Mjvu8iHG65o=;
        h=Date:From:To:Cc:Subject:From;
        b=rNKRPhcOthMt4WBi5977e+QUpARdC45GYHHoAbw5XAbvWnMgyh0+4y7BXnxfkyc8t
         ZTlJbeq/RP4jghqnJ/lskvfTcUE6+I6rmzvVZcJ45wQ5b7BV1zTF13XFmoF1OTvLF0
         Jlwlfef1wpWMdI7Hdi66Y/ZsXhKp0ZHlulBn7NElToFHKx5XVDlm4c44VZG/SEllb0
         PcSc6dnirNh/4hSCPNAjfxhX6IZ7l1hcE+CPD+bltsy8/uUvcXtTLmT656lVIwcCH3
         9g0T7XUfYwSmQ5Meb2bGDto8IB7wVjBnJE7ajFvWSVAvfGcshsuOVoSHq6DkSkDhIQ
         AxgpjFsmSNI1Q==
Date:   Tue, 6 Dec 2022 11:24:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the pm tree
Message-ID: <20221206112447.429f7ab7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jlzzsRQhMGIBha=E=89gQu0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jlzzsRQhMGIBha=E=89gQu0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/acpi/battery.c

between commit:

  98b0cf207b61 ("ACPI: battery: Call power_supply_changed() when adding hoo=
ks")

from the pm tree and commit:

  878a82c23469 ("ACPI: battery: Pass battery hook pointer to hook callbacks=
")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/acpi/battery.c
index 883c75757400,9482b0b6eadc..000000000000
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@@ -696,8 -696,7 +696,8 @@@ static void __battery_hook_unregister(s
  	if (lock)
  		mutex_lock(&hook_mutex);
  	list_for_each_entry(battery, &acpi_battery_list, list) {
- 		if (!hook->remove_battery(battery->bat))
 -		hook->remove_battery(battery->bat, hook);
++		if (!hook->remove_battery(battery->bat, hook))
 +			power_supply_changed(battery->bat);
  	}
  	list_del(&hook->list);
  	if (lock)

--Sig_/jlzzsRQhMGIBha=E=89gQu0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOOi88ACgkQAVBC80lX
0GwoCgf9FpJ2FlQZ1thukSsoGfixDIwCo5jlkrLNZ9PpGS/90WkafVyBzQ7jebJu
fT8OOrY6cP7LB2RbXVnUoWeuOB1084UsGdR68mr0FHAsa/cEqJfSEhilwQ0Pq6li
2znB6llfqUpgHLL1QdWvJ6X5S8wzJEVE4z14JEw1FDcYd6hYE+bnQwnivfjVHnmP
ME9MgLuWXe1UgG7KuvGUlb1slMBQWLXHj17+s8sikEAMyCO90L8+cTRkfidnb+qw
6ZC5s7w/Hs7wNBj6CZQ/vhDnsTUqR7GAMlGgQNFaOIf/gYDhKtYYXQHO4OdBICcC
r5Fg2sqEZ0SyCGBE3XXUJSILeZhhOA==
=XMJ7
-----END PGP SIGNATURE-----

--Sig_/jlzzsRQhMGIBha=E=89gQu0--
