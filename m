Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745E6AB411
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCFAxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 19:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCFAxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:53:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0118730E0;
        Sun,  5 Mar 2023 16:52:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVKn54y0jz4x80;
        Mon,  6 Mar 2023 11:52:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678063977;
        bh=PtuwvdgHELkBfRUYWW59KZOPX/ptKJRNxtUuyjU7Hbo=;
        h=Date:From:To:Cc:Subject:From;
        b=DEaeghvIoEjYQZJZt/QYzuqnMtJtLEFQct3sktQe7TwB/xZTjQ/PmaoIjM4gtqvJS
         jlJPM00sWypVOuWsCrcu4hT8oSjW9bdvYA0XLUzWD7c84Gzqam3y+YnFvsDJxF1O32
         6Ra7PZHoP257lv0XK7dioYHW9DdGkhzvKbtJWXj4qp5rVDYt1HtYm9brW4RXY23Q2j
         nYrOXm01Kr+7QMoJWQvepdxlP3HNBxY5gZ3EPvLx3E+WwI+pVcEd0+U+MntdFAS3Gj
         j/OI640YjinoPuoP1wQoHhq4wAhwRdlvENr6ejrIZsjbbv6AxMBo2IXiPwC9tfXCFd
         2DbwTGxXK9VwA==
Date:   Mon, 6 Mar 2023 11:52:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230306115256.1da8983d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Uol3rFx6CAGgGrxNiwKjie";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Uol3rFx6CAGgGrxNiwKjie
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc64 defconfig)
failed like this:

sparc64-linux-ld: mm/vmstat.o: in function `cpu_vm_stats_fold':
vmstat.c:(.text+0x2a18): undefined reference to `__xchg_called_with_bad_poi=
nter'
sparc64-linux-ld: vmstat.c:(.text+0x2a98): undefined reference to `__xchg_c=
alled_with_bad_pointer'

Caused by commit

  676a3befc9ba ("mm/vmstat: use xchg in cpu_vm_stats_fold")

Sparc does not support xchg() on 8 bit variables.

I have reverted the above commit (and the 2 following ones) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Uol3rFx6CAGgGrxNiwKjie
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFOWgACgkQAVBC80lX
0GxbAQf/cwLSUwQTocMA+MuL/JMIHUDaZ0mhAJecvM+35NgZ/OBZIe/Sk1N23CgS
WVEGJ0WOesjYsr5tyRijgaeiXVsvj8q/5u6lvizCjp3eKcTQCOxGktpp+3t2f8PL
d9jpKtSX6lhrTbZn/zpXF66mTnwXphiTEP8PLaGbxhw2HkNA30JoZAV626N9Sev0
clf/1BD8ftKxvVgLY4h/djYh09aIdzS3OgdW4RiLu9fV8TQvXg9Fr2BUIT0iF0Dy
8jnk0sDjZzoPnByB6J5ISGQOst79rJTPXtM8znrHxODQZYJIH5YZXZeM/XZPfz7r
cZGtL68SVdH9u+sMOhPyD32nuZTKNQ==
=7sxu
-----END PGP SIGNATURE-----

--Sig_/=Uol3rFx6CAGgGrxNiwKjie--
