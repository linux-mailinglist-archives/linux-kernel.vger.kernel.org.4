Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25A720923
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjFBS2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbjFBS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:28:25 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B8E73;
        Fri,  2 Jun 2023 11:28:17 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1q59VX-0004v2-LU; Fri, 02 Jun 2023 20:28:15 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1q59VX-001CYV-09;
        Fri, 02 Jun 2023 20:28:15 +0200
Date:   Fri, 2 Jun 2023 20:28:15 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     netdev@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH net] lib: cpu_rmap: Fix potential use-after-free in
 irq_cpu_rmap_release()
Message-ID: <ZHo0vwquhOy3FaXc@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m0Nv01qLvHn7PZAp"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m0Nv01qLvHn7PZAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

irq_cpu_rmap_release() calls cpu_rmap_put(), which may free the rmap.
So we need to clear the pointer to our glue structure in rmap before
doing that, not after.

Fixes: 4e0473f1060a ("lib: cpu_rmap: Avoid use after free on rmap->obj ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I noticed this issue when reviewing stable changes.  I haven't tested
the change.

Ben.

 lib/cpu_rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index 73c1636b927b..4c348670da31 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -280,8 +280,8 @@ static void irq_cpu_rmap_release(struct kref *ref)
 	struct irq_glue *glue =3D
 		container_of(ref, struct irq_glue, notify.kref);
=20
-	cpu_rmap_put(glue->rmap);
 	glue->rmap->obj[glue->index] =3D NULL;
+	cpu_rmap_put(glue->rmap);
 	kfree(glue);
 }
=20

--m0Nv01qLvHn7PZAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmR6NLkACgkQ57/I7JWG
EQm8BQ/+IhHzfoOBpkoqD8Ru0N4tPO9nVB2TgpPcCMJvAMAUM/p9NsiaDcjqs2m5
aqLw0cdgT8zwqQomfsZQFoYlrZ3bzxWQkTPq6p7c0pDdQ7SFdTZDnBjAd/P7MNzd
zWn17BjNDCsnn2F65nkX//4oyRdM7mTJssyOW1nfmycGWPh7Rhm8o2Ha7vYD9NTC
9Q1daRjZDkA6asoW2oZo5v71ojX2TG1JiMh5M3VfdEH2/zy5GHyIbSv2p/PpzoPn
qIN+ZlIrT8tLT1tSGHVhuumf3ASWDEZaNnrVPY4VZ5jtSk2tQrlrUYNzMwqwL8ab
e99zorg3m4tIwnX+ReL3AcvVKEaq1cJGtpSAzGCizp4gs2mULLdacVCGXCg+iBvt
o8c+7MiF8hiSY4wqtJPismxg5m+kD1nwJ8to1L6Kjqvjya/Nk3/qJZ65lMr+TCH1
vlTvLt+6MDcIi29SxNSwKNR1++f8p8MXWKUmADTXPpU8hn68oMpYQJS48ib5gNjs
CPWolExGVot3ydtXgXbppUfaMBmowPDurxR/nRjbg8TzterCXpPmu+3tnQ7lVa/5
HJtflKq1kVJZVandFP8r5yBFGr9utOCBouyXcS830O0XA/x3GqVuqD5/dT196wdY
dicpAOMIuu5OtgC7LCleVJXeV8TpJcbnCJvO5mBXQa9ddSXejyc=
=BRu5
-----END PGP SIGNATURE-----

--m0Nv01qLvHn7PZAp--
