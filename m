Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CBB5F3A82
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJDAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJDAVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:21:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D21425290;
        Mon,  3 Oct 2022 17:21:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhJJt0CGDz4xGm;
        Tue,  4 Oct 2022 11:21:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664842863;
        bh=G/pH8iowJifwKQQ4Y/hnXMCZvuIoXfvfVOEShY9tk8k=;
        h=Date:From:To:Cc:Subject:From;
        b=sW5tiYlSb28O97boZIfQh0QCLSCEjbAesxQqoXRq6riqIiuXTwBysLopofKAagplZ
         8rHr25Vv2g8yeEjn+yF37H5FHAlZp/ljKngGP4hRowW7rUG8TlNuU9zT3CaiHyDfFr
         i28kROI4jKBg1y1UbkFcKxYmFO6L2uPNTu3BAcS2kHqGgrnGeAFdoteLFwKsMGWBb7
         GAq5cgc4/yZvQ0fedFkTaryjyYusjSm2fRRCkRGZhS4Iu1oYqiF/8/3DxqzSK3UTmK
         aJvygTvpm0DJvaTG5MxSv8+ngOpQLk4o5aXoztsYGsXfIo5nVyHUuquU/+pc1hcviM
         SleDHxWYc8wWw==
Date:   Tue, 4 Oct 2022 11:20:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the i2c tree
Message-ID: <20221004112059.5677a13e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e9zlwY=a2s+nP+CnUAI/KQL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e9zlwY=a2s+nP+CnUAI/KQL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/clk/clk-versaclock7.c:1304:19: error: initialization of 'void (*)(s=
truct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_cli=
ent *)' [-Werror=3Dincompatible-pointer-types]
 1304 |         .remove =3D vc7_remove,
      |                   ^~~~~~~~~~
drivers/clk/clk-versaclock7.c:1304:19: note: (near initialization for 'vc7_=
i2c_driver.remove')

Caused by commit

  48c5e98fedd9 ("clk: Renesas versaclock7 ccf device driver")

from the clk tree interacting with commit

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 4 Oct 2022 11:13:45 +1100
Subject: [PATCH] clk: fix up for "i2c: Make remove callback return void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/clk/clk-versaclock7.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index 050807cf971f..8e4f86e852aa 100644
--- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -1235,14 +1235,12 @@ static int vc7_probe(struct i2c_client *client)
 	return ret;
 }
=20
-static int vc7_remove(struct i2c_client *client)
+static void vc7_remove(struct i2c_client *client)
 {
 	struct vc7_driver_data *vc7 =3D i2c_get_clientdata(client);
=20
 	of_clk_del_provider(client->dev.of_node);
 	clk_unregister_fixed_rate(vc7->clk_apll.clk);
-
-	return 0;
 }
=20
 static bool vc7_volatile_reg(struct device *dev, unsigned int reg)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/e9zlwY=a2s+nP+CnUAI/KQL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7fGsACgkQAVBC80lX
0Gw5iwf/TYmcYeBA8l0qEO3bC6AXS7HLanT2pJx6RVdGAG+9JRRE0zjpDcTMS4ll
DgrorLVodZG1k3WlM2UBM+pxaXKQ8/rG/3whsdBSVxcs2dqqzDvF1Ah/5/STY08+
TKJCscM5ssow5XTBFCGhPxi2yHRUL6M2MroKk9pomvAv0pE1qg6GcnF5r6EjgxOI
g3Jbfj7AtLUT5e0My40fbID/xRBtexa2fz9JHb8ZwG/xn+oU8gcDAqNJrhD8E8wT
rPeeavARIBDoXlukpabpTOXvmE2l5m3H1B8dAW94wEJlUX0TLqd0aRAFKWKwJO5W
Py05ewrAf9H1hOXRiGdU4cXQPRuboQ==
=udgB
-----END PGP SIGNATURE-----

--Sig_/e9zlwY=a2s+nP+CnUAI/KQL--
