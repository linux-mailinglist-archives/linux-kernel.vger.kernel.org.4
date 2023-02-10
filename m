Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E08691602
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBJBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjBJBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:00:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8BA16AC6;
        Thu,  9 Feb 2023 17:00:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCb4l2mRzz4xwt;
        Fri, 10 Feb 2023 12:00:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675990823;
        bh=apcxmBNwKmYRtLpVjAX9XJoi1QUIpCrqIm6SUAMyNz4=;
        h=Date:From:To:Cc:Subject:From;
        b=grIyxIjVp+hPtT/GIcFS7AmVbUImlghiinEh0vBjfnw8Asu/NYdcAhJKvEmoj1BWd
         07NwPXgj1i+6qVEvcCc7BmA44bo/7nNu3bShST+uO04JkOfJ/Z4Ksrvv4nRyIOe0P6
         n4K0lAfVVMCVIpjB3ZYd0Ifsd0ysybyUBtLit69g5SzMz24eu1lLmFZP98bh8OVwv/
         1cCIherCRJS+a61lqmNATunsR4g0xprrjEscWDed1iNlQZ1MOREaTadxKpmoI3vH6O
         L4rWNWgn7VWAXKzd9TdgEAC5/I/6HuXoyYECwBQ33kGzFMZOhsPacM8V83eB+qcknC
         HiH92Kc3dn4SQ==
Date:   Fri, 10 Feb 2023 12:00:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the s390 tree
Message-ID: <20230210120021.4a507539@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tRkWBryw165Mp+T9ZJ=IBr4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tRkWBryw165Mp+T9ZJ=IBr4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/kernel/idle.c

between commit:

  c01016299dc7 ("s390/idle: move idle time accounting to account_idle_time_=
irq()")

from the s390 tree and commit:

  89b3098703bd ("arch/idle: Change arch_cpu_idle() behavior: always exit wi=
th IRQs disabled")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/kernel/idle.c
index dd8351e76539,b04fb418307c..000000000000
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@@ -61,7 -57,15 +61,6 @@@ void noinstr arch_cpu_idle(void
 =20
  	/* psw_idle() returns with interrupts disabled. */
  	psw_idle(idle, psw_mask);
- 	raw_local_irq_enable();
 -
 -	/* Account time spent with enabled wait psw loaded as idle time. */
 -	raw_write_seqcount_begin(&idle->seqcount);
 -	idle_time =3D idle->clock_idle_exit - idle->clock_idle_enter;
 -	idle->clock_idle_enter =3D idle->clock_idle_exit =3D 0ULL;
 -	idle->idle_time +=3D idle_time;
 -	idle->idle_count++;
 -	account_idle_time(cputime_to_nsecs(idle_time));
 -	raw_write_seqcount_end(&idle->seqcount);
  }
 =20
  static ssize_t show_idle_count(struct device *dev,

--Sig_/tRkWBryw165Mp+T9ZJ=IBr4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPllyYACgkQAVBC80lX
0GwccAgAjaVfw+h1ycQnThb43tEHMB2OGSMUNxs0NqexI3HslDaXxx/u1Hgp2fVq
usdIRBW5AS8u1flYl/e/xA3JaNq3Q0gVgS/uzFCJ80KomUXGm2/H+gBcANNmlA0s
ND3GL72ANEytUgTu6BitN4BHA7c93cvovWvv1ezkrFkFCNUnQv7svO2vsTY2B0U9
iD/YpVmxKTtOneU2rY0PSVcoUal15fzfNOv9qPoH/jpnOeg8QNpTMzqZPO/U251O
K9pLpHhv2+koOVSswqck+JTHi87gJkdx9MQZeVjOACtzdIL9r74iOdFI0vskIV2X
EAv4+tEuMpyV18itd6TTlJIb10JGHw==
=sGRN
-----END PGP SIGNATURE-----

--Sig_/tRkWBryw165Mp+T9ZJ=IBr4--
