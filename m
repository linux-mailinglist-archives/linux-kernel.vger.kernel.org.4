Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9E721AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjFDXIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDXIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:08:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08532DA;
        Sun,  4 Jun 2023 16:08:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZC842bDPz4x1N;
        Mon,  5 Jun 2023 09:08:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685920087;
        bh=QT7njgfyw1b4hMEcwfCFqDKc/Zf7MGdrMVgxHBXLNOc=;
        h=Date:From:To:Cc:Subject:From;
        b=E0CToDJFa27/q8HGw6kWQydR6nLTC80FJi/TordPwYfcTiP9OPBcGX7rVFWnXBZSj
         Ny/Kp5HXAOVBQp2/mNBmdiY2YtQOdqkMEHxvWUqeR4IPVSboEzeu92VL0+39cKn4Hs
         S1QKcJhpAEHwnRc5MXPfZF7GO+Cv45+9/Ow+RnDOZpVhRinPhlyn/dMZ3KArZTuRic
         s12VkBDCZrs+6msi4xzFr8DXy1me256KW/KJkw30ZPCm08IGTbh+K+/8lHhDnshKtr
         GqVct1DHlNWFS5Wk9NhrmkxOZM2e1B5b7Gl6csL5AxCN7PolczNyhEprlS4z5GNTE5
         a12FGQ1/OjgrA==
Date:   Mon, 5 Jun 2023 09:08:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the mm tree
Message-ID: <20230605090803.43597523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.hjKRBDY7OCci3PQOfy3NP1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.hjKRBDY7OCci3PQOfy3NP1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/file.c

between commit:

  39bf7bdb48fe ("backing_dev: remove current->backing_dev_info")

from the mm tree and commit:

  3564004ccddf ("btrfs: determine synchronous writers from bio or writeback=
 control")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/file.c
index ecd43ab66fa6,f53b7b75092d..000000000000
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@@ -1683,9 -1682,7 +1679,6 @@@ ssize_t btrfs_do_write_iter(struct kioc
  			num_written =3D num_sync;
  	}
 =20
- 	if (sync)
- 		atomic_dec(&inode->sync_writers);
-=20
 -	current->backing_dev_info =3D NULL;
  	return num_written;
  }
 =20

--Sig_/.hjKRBDY7OCci3PQOfy3NP1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9GVMACgkQAVBC80lX
0GyBcAf9GBzkcQoOBtq2fhybOifXuI18DwJLiHm3ytzilLxx0sSiIt4nZ3YSknIc
BulCo+HFgZmbWZextpCu+PqvVp2pNBqqMULo9bhl9d2s56hbhtTRE6h/6emeR1XQ
adVvGPGPaGrbhbKFeS1DsgqidYJ7JI3nRCT03AQWqu4N4Bzgsl/8YxEQ4r02h06m
4I7SWoNkTl1kl9j8AjbblruYGPiwJ5cNitrAEoZ5UUN8rNfZjWyjrdI03raYEChB
1GLYSfsh5yzivBzTwkSwhB6aNxtWHcrBuUTrDo5P1EqwAhnhvGXlbUCkXKglM1hd
OVPHHb5/F4T3E0nmu+XfhnPDwFHL5A==
=j5qO
-----END PGP SIGNATURE-----

--Sig_/.hjKRBDY7OCci3PQOfy3NP1--
