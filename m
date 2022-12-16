Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12764E59D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLPB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:26:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355B5D6A6;
        Thu, 15 Dec 2022 17:26:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NYBJj1ssHz4xGR;
        Fri, 16 Dec 2022 12:26:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671153989;
        bh=aVx99TG7U4oYgNg9cvJlV5weqq71jApbrlwQiqe2VRg=;
        h=Date:From:To:Cc:Subject:From;
        b=L+mfCjADmYtHhHZ5GtCN25H9l/fxntPmx2TiJYI0kyN8puGp1aAan5491dZyzOWBg
         jVt5HPN3hrZUnlZ6Tv6sH3Xpzz2f0X0jHLmCm81bGV/l4coQzM1TMzUwUWbMWEbnw6
         mJbNBrc2jHabh6VNYQD6O5Di3A5uWby5W5sFiyLLlSNnHQ++YHKaTksuW9m7zNuzHG
         9tC3K4aHdswFQhC36uKDH/4rOsmp2TVcnfNOUrW7HlL+qTc6V8HjdKPvLXuPJpO0fT
         SERU1YGhqOSwrAZteCIG0a8V3uYJCuXay5YaJYDoKN+bRF2z4n9zgLwtywhpBCiwt0
         LBGaB3IPpSKUw==
Date:   Fri, 16 Dec 2022 12:26:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221216122627.6a3ded39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oV5U1ZkIftJdRxiOF=tWbm=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oV5U1ZkIftJdRxiOF=tWbm=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc defconfig)
failed like this:

kernel/pid_namespace.c: In function 'create_pid_namespace':
kernel/pid_namespace.c:114:9: error: implicit declaration of function 'init=
ialize_memfd_noexec_scope'; did you mean 'set_memfd_noexec_scope'? [-Werror=
=3Dimplicit-function-declaration]
  114 |         initialize_memfd_noexec_scope(ns);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         set_memfd_noexec_scope
kernel/pid_namespace.c: In function 'pid_namespaces_init':
kernel/pid_namespace.c:462:9: error: implicit declaration of function 'regi=
ster_pid_ns_sysctl_table_vm'; did you mean 'register_pid_ns_ctl_table_vm'? =
[-Werror=3Dimplicit-function-declaration]
  462 |         register_pid_ns_sysctl_table_vm();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         register_pid_ns_ctl_table_vm

Caused by commit

  70ebb551866e ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")

I have reverted that commit (and the following 2) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/oV5U1ZkIftJdRxiOF=tWbm=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmObyUMACgkQAVBC80lX
0GzPjgf/R7PJ8TLM1xHHJYCAbThuIafQH0e5Cn4fCpny7NPoLKq7vsNjafg57D9O
cl83f9u4MkvVHK00egRd0ClXa04JgWD+WBv2VrY/xGS4g7eaIBWEv+60hqQQxqlY
x4XWLuDzO88k7gt5/iNYDNZM/GgPDnWquvk60IG6DKwb0NAytgs/J2MLdvSEQeK/
d3zMWud94kWu5T9UXnk3ktftoHbkZuj2bnQWPeASsFn3pVy6NrRR3nFz2ZXmUcJg
/UjPSoWrlIIPbBnQ4MNkvdQf5Jg+0hWyapDoqQmQ4+tZ7kYrQ+aM/Zwfm045pZ3m
iKB8qRorzfUtkTvHhB3OjslSzAh/DA==
=C1fl
-----END PGP SIGNATURE-----

--Sig_/oV5U1ZkIftJdRxiOF=tWbm=--
