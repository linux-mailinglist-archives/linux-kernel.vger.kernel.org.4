Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F565F80F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjAFATT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjAFATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:19:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D43D5D2;
        Thu,  5 Jan 2023 16:19:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np3qQ6yd8z4x1D;
        Fri,  6 Jan 2023 11:19:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672964355;
        bh=KWKLdIiyKFcqGgna5qmNCmw34VszfaI+yRthltHHztE=;
        h=Date:From:To:Cc:Subject:From;
        b=V3zGY8s3BnNIwjz+Vb/zGdNg8CWGuEYoykr+Enq2pTOeTJLtYGYMywf6XiMj3EZBA
         3YiAgo3c9R82MmY1KMtclZwZ/+4FdesPbzDHGsRvWX8ZBJaZWHVgwFV8CgJdyzML0i
         WKbPNx8IeVW948SNviVrMHUqpJtqqrOsKGJ+2Khqszzwl4tiViIGqz36AYbFBYc+LP
         jZA6RM8Gpk3caIsQznSD3s8opXx7tc1dfdntdUIPHwcmhS3SKXkd0CTmblIvbt2KeA
         8V0PVOHe31U8fEUWkWsSjTpv4xexoL1a4nJhazbFGXnScSMvEUD6bseBL+BTdYTu8y
         zT28L82HWhKYw==
Date:   Fri, 6 Jan 2023 11:19:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20230106111913.660c8983@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=hQL=sN.5byfU9l8wN3xDLH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=hQL=sN.5byfU9l8wN3xDLH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "scsi_device_from_queue" [drivers/block/pktcdvd.ko] undefin=
ed!

Caused by commit

  4b83e99ee709 ("Revert "pktcdvd: remove driver."")

interacting with commit

  7936f8b232fc ("scsi: core: Remove leftovers due to pktcdvd being removed")

from the scsi-fixes tree.

I have reverted that latter commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=hQL=sN.5byfU9l8wN3xDLH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3aQEACgkQAVBC80lX
0Gy34gf/SS9Ra3I9Ch6HLNpnDyvyOIM/AvY9bXGEWOJoo+8VbXBAyyEyiDPSlnTo
bCblGaBjNO8nvfb13juYIYDOXnTcdDjJLPyhHhcmOkDv5TWOhv+fygJfVl3DnSxe
yV/E30ZSxbTTW2hlyw0WOrGXZcKQhw2X/eD+cclh7TlqfBTqqVz0YaBK8KBBlU56
VPpCMjYI8GIkIY8o+gCYi77dE8Fx5tkXSi1gLKozvTc+N5eNUFcqh/ajz9rc+7ai
l5srStRcdMOLDzFIgCKmBtWnX5drFpmBDKP7ANMJ7yZHuH2PatH6hoHE0GXf1jEx
t/gPl7ZLznLjSQdQw/qs+1I90K7M1Q==
=Q3uY
-----END PGP SIGNATURE-----

--Sig_/=hQL=sN.5byfU9l8wN3xDLH--
