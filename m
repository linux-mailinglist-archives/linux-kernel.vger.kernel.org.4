Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACB5F3967
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJCW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJCW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:56:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A3303EA;
        Mon,  3 Oct 2022 15:56:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhGRF0kt0z4xGd;
        Tue,  4 Oct 2022 09:56:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664837785;
        bh=d/1eYtVMEzljc/gTxQ0a8JgmoQL2V3NWgQfAXPpQG/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=Pw/pGsf16uyWVIT/o9eSfCeGXg94VoRXC8go/rAZ6YpBFRwcEBKS+LzLCUMA0Sbls
         3y5dpbZWsX6SrV0jPx+hJjGDvX886VBJsDAXWF4aoNjDJIkuxDiJ43x5qbMxBNr60i
         bs+AiSQrEtC6HiawLwDO9o1nQ5AJZVjEJswBLr/1U72AM7Rstc2aGExMXjVjlaqxsx
         /DTQc1EAFS2jwraXervgeB/pCGWlHGNDV75WGq5RHdhj/uGVY57w8jD4rvGXD+nb93
         AYga3rd+z7wQEJoKJk9Nn4IdXORClrQKX2MxdujbjKhfNpGsDhjqnN441uoO+E6+vl
         yvttenSLRqnrg==
Date:   Tue, 4 Oct 2022 09:56:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20221004095623.2e5590ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LsPLuVmicHIA4GL1lpM1mYa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LsPLuVmicHIA4GL1lpM1mYa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/notify/fanotify/fanotify.h

between commit:

  7a80bf902d2b ("fanotify: Remove obsoleted fanotify_event_has_path()")

from the ext3 tree and commit:

  d5bf88895f24 ("fs/notify: constify path")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/notify/fanotify/fanotify.h
index b34246c6ec87,bf6d4d38afa0..000000000000
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@@ -452,7 -452,13 +452,7 @@@ static inline bool fanotify_is_error_ev
  	return mask & FAN_FS_ERROR;
  }
 =20
- static inline struct path *fanotify_event_path(struct fanotify_event *eve=
nt)
 -static inline bool fanotify_event_has_path(struct fanotify_event *event)
 -{
 -	return event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH ||
 -		event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH_PERM;
 -}
 -
+ static inline const struct path *fanotify_event_path(struct fanotify_even=
t *event)
  {
  	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH)
  		return &FANOTIFY_PE(event)->path;

--Sig_/LsPLuVmicHIA4GL1lpM1mYa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7aJcACgkQAVBC80lX
0GwlvAgApD+/2EU9x0iMzahFJjQe05A6n8Yy4R3mgWFxQ/OWH4cP7qBTT1CJM0aO
ZmvNAy9eUikOAeIwoVf3rJKeZ/2Fn7GPsM8sRjMHHvTKdYomRitw6LgYRCYy5vJL
cvDBb8k4U+pHzBNbFTvTpz2ElV0G9S7QoaQKAdbIKUQnsmIe79jerzv15sSGEBft
Ai49XZ3acR04KNf355EHvqJnTtQryhYnejgeAYrKzrUxodsHJlEgv91YljQBlWtI
8bXkWinK3Bl4wUp5Ead/7VfhBoRCEBsbX38BF3vbWkw/Z/NoHaCNiT1LguLYHt/D
uQs4LHzRtzPCy9KqF4iSviw32cHMJQ==
=LleN
-----END PGP SIGNATURE-----

--Sig_/LsPLuVmicHIA4GL1lpM1mYa--
