Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC06804FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjA3E2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3E2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:28:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA81E1C6;
        Sun, 29 Jan 2023 20:28:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4wD43bP5z4x2c;
        Mon, 30 Jan 2023 15:28:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675052916;
        bh=YjC6K6QpDKe3K+cfREHXDGRhuZDP9c7JpW1LNdDhQ8M=;
        h=Date:From:To:Cc:Subject:From;
        b=chsvB7e6obfm5fcl78Y7AoyImL0brqetSLv/vGHtRGqhW9Wqiwen3SwD5d83GHEA7
         oVinGqpyvVKvzJXFYHPyQyN6dkGv5JeFv+1E4y0PnR67s98hDHPYg5lg91KrlpaGxo
         hj39lcK6SMBtNcJ9CQG992M4ScySU1aynFM/l71BgiDvd+LzZXj3QMg5JBviaIfiyk
         B2UVGdN9UU37vr1Hmsfax8eZiPab0QblVXCoPow23Hy7K0qXgIig5FbTU/SXVtLX4E
         YWeQN0HfGxi6761HOKzaRzR3QL1imAZsRzv1t9bpnCezkZF/AlvUptx6fNB0qrh/cm
         lfCgHrqmk3KjQ==
Date:   Mon, 30 Jan 2023 15:28:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20230130152818.03c00ea3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RiJQuUm6dju4GrgJ3u7dm1H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RiJQuUm6dju4GrgJ3u7dm1H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/ps3/system-bus.c:472:19: error: initialization of 'i=
nt (*)(const struct device *, struct kobj_uevent_env *)' from incompatible =
pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=
=3Dincompatible-pointer-types]
  472 |         .uevent =3D ps3_system_bus_uevent,
      |                   ^~~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/ps3/system-bus.c:472:19: note: (near initialization =
for 'ps3_system_bus_type.uevent')
arch/powerpc/platforms/pseries/ibmebus.c:436:22: error: initialization of '=
int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible=
 pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=
=3Dincompatible-pointer-types]
  436 |         .uevent    =3D ibmebus_bus_modalias,
      |                      ^~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/pseries/ibmebus.c:436:22: note: (near initialization=
 for 'ibmebus_bus_type.uevent')

Caused by commit

  2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Jan 2023 14:31:49 +1100
Subject: [PATCH] driver core: fixup for "driver core: make struct bus_type.=
uevent() take a const *"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/ps3.h           | 2 +-
 arch/powerpc/platforms/ps3/system-bus.c  | 2 +-
 arch/powerpc/platforms/pseries/ibmebus.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index d503dbd7856c..a5f36546a052 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -396,7 +396,7 @@ static inline struct ps3_system_bus_driver *ps3_drv_to_=
system_bus_drv(
 	return container_of(_drv, struct ps3_system_bus_driver, core);
 }
 static inline struct ps3_system_bus_device *ps3_dev_to_system_bus_dev(
-	struct device *_dev)
+	const struct device *_dev)
 {
 	return container_of(_dev, struct ps3_system_bus_device, core);
 }
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platfor=
ms/ps3/system-bus.c
index 38a7e02295c8..d6b5f5ecd515 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -439,7 +439,7 @@ static void ps3_system_bus_shutdown(struct device *_dev)
 	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
 }
=20
-static int ps3_system_bus_uevent(struct device *_dev, struct kobj_uevent_e=
nv *env)
+static int ps3_system_bus_uevent(const struct device *_dev, struct kobj_ue=
vent_env *env)
 {
 	struct ps3_system_bus_device *dev =3D ps3_dev_to_system_bus_dev(_dev);
=20
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platfo=
rms/pseries/ibmebus.c
index 58b798a0e879..bb9c18682783 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -426,7 +426,7 @@ static struct attribute *ibmebus_bus_device_attrs[] =3D=
 {
 };
 ATTRIBUTE_GROUPS(ibmebus_bus_device);
=20
-static int ibmebus_bus_modalias(struct device *dev, struct kobj_uevent_env=
 *env)
+static int ibmebus_bus_modalias(const struct device *dev, struct kobj_ueve=
nt_env *env)
 {
 	return of_device_uevent_modalias(dev, env);
 }
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/RiJQuUm6dju4GrgJ3u7dm1H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXR2IACgkQAVBC80lX
0GzIbQf+Jdkp6HUarSmsKYH9ZmarcnRrs4Zxv28qKm+XHaYYwCWq+J0HCa9iYomZ
Yej3VVhbs3MySrwTzjxb46BJzpChMwFWRSLyOnfGYiWWEXr9ocQHFaNu6pTvjotO
rZTq8NWOpmeO0bliZWvI1oNifBxthXhMQmzzjTJM9sgZ8rKbr9zBcIulGPTmL/hi
5e3QuQXq58HB8N9Fnr/rozF2bALzPjKRch1YOtXgw8si72y7QtL/Hk45nk3rJhrh
ATLm2FmiISKiNmmbE4lFc3kR/g67H3NqhE5DBEKfR0exBdg7KKl8aG4MDKHnvsMR
lHwKsjamMt7eSQYJlU59rq1rpH2WqA==
=tMYT
-----END PGP SIGNATURE-----

--Sig_/RiJQuUm6dju4GrgJ3u7dm1H--
