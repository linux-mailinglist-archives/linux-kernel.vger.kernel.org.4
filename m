Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6361373AF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFWEa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFWEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:30:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592972126;
        Thu, 22 Jun 2023 21:30:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnPRZ4hpGz4wj9;
        Fri, 23 Jun 2023 14:30:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687494619;
        bh=HLzyUWe2JdTNFgsbOVFqKpagFNhTmjAHxqDf7II5T4I=;
        h=Date:From:To:Cc:Subject:From;
        b=L57MqkawvTsztT6t1CeX2hsBVT21KqHEoLXcQDmZeobmJW4S8HX7SPI2QDWIxOCP8
         HG1yUlSdC9RPiYCh6mP6tN3xrwEY0mKx0UHDwRmqG6ppqBnp3x2QudOk9SLN7iyTHv
         AW7jio0wTwZVX6v3Zxy5UdoM/2+QzxoYp0utlliOaTUgI7dOVMvc/R3CCSmEHyhMar
         UIBzWR2W6z9UtmNWfuKBJU2p5WQEKnjD7CwA7I+l8QCrSk1Znbz9QiusWw3jxC3HK9
         Yyzwr3F8/vDoGSNvLAIVEBDwMwZV/aAmMIIQ6W7GfgwP2c0LgApcnqsSXRFexVoho3
         w8lh1T3gM6Lzg==
Date:   Fri, 23 Jun 2023 14:30:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20230623143011.7deba53c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LwocnfiZv+HSDnECGx87lz+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LwocnfiZv+HSDnECGx87lz+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (i386
defconfig) failed like this:

In file included from include/linux/kernel.h:30,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/current.h:10,
                 from include/linux/sched.h:12,
                 from include/linux/kthread.h:6,
                 from drivers/md/dm-core.h:13,
                 from drivers/md/dm-ioctl.c:9:
drivers/md/dm-ioctl.c: In function 'next_target':
include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of t=
ype 'long unsigned int', but argument 3 has type 'unsigned int' [-Werror=3D=
format=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:427:25: note: in definition of macro 'printk_index_w=
rap'
  427 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:498:9: note: in expansion of macro 'printk'
  498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:498:16: note: in expansion of macro 'KERN_ERR'
  498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
include/linux/device-mapper.h:626:25: note: in expansion of macro 'pr_err'
  626 | #define DMERR(fmt, ...) pr_err(DM_FMT(fmt), ##__VA_ARGS__)
      |                         ^~~~~~
drivers/md/dm-ioctl.c:1421:17: note: in expansion of macro 'DMERR'
 1421 |                 DMERR("Next dm_target_spec (offset %u) is not %lu-b=
yte aligned",
      |                 ^~~~~
cc1: all warnings being treated as errors

Caused by commit

  5df1daff2cc6 ("dm ioctl: Check dm_target_spec is sufficiently aligned")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 23 Jun 2023 14:24:29 +1000
Subject: [PATCH] fix up for "dm ioctl: Check dm_target_spec is sufficiently=
 aligned"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/md/dm-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5f0b641538d8..8b480d7825fe 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1418,7 +1418,7 @@ static int next_target(struct dm_target_spec *last, u=
int32_t next, const char *e
 	}
=20
 	if (next % __alignof__(struct dm_target_spec)) {
-		DMERR("Next dm_target_spec (offset %u) is not %lu-byte aligned",
+		DMERR("Next dm_target_spec (offset %u) is not %zu-byte aligned",
 		      next, __alignof__(struct dm_target_spec));
 		return -EINVAL;
 	}
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/LwocnfiZv+HSDnECGx87lz+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSVH9MACgkQAVBC80lX
0GxLbgf/fKBB8K/ebmMUX37B2d0fLs8mbW0dAqDaNMg+VMjo1xq0990KQYLfusnn
PKCuzwSQwxcvdHicYjGna+nKANhkW0WiajDPYT5AZ8fpRTdZeAP7TpFw51bbDUT5
e+kiFzbT5glGA8stfbRtfJfz8p9PNuQDfWR0XBLAToHI1ris9tjmGStfa62iUy5e
HSrmhPsWX5+7vTtKA9W5jVuAfmfihMRZFZLqPwM1tb8uRHbyS6cQnUwq7X9ZcWkk
uL1gwTJ6uXydGNWERmsuqgzFGbWkhMoRAgSbx5mTovfCUSsvjlHGY9YX1FisAa6E
JoqjEFh5zP7se/mpHXyDkPH4FzERcQ==
=Iov+
-----END PGP SIGNATURE-----

--Sig_/LwocnfiZv+HSDnECGx87lz+--
