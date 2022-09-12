Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE15B5425
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiILGTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiILGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A727FE5;
        Sun, 11 Sep 2022 23:18:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQxHB1LKLz4xZV;
        Mon, 12 Sep 2022 16:18:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662963494;
        bh=y1RNanHEGEc2wZBBoc5obopcoQbOqF175G0KxKLZLZk=;
        h=Date:From:To:Cc:Subject:From;
        b=OFo9Up3QIdFQD/loFn4iryJ7/SYJ4sWxi1Ap9d9GL+EBjPeOnEZMeP43/9LbuKhBL
         x7fryPk6+MK0zwNnPy7hrRC1O0iBjH++QSXZ+Jno+pVvacLC1y+ix6LcuW+V5aRxUI
         QfT9MMq2cQE9JiGcR1Bv0c6tIHzFSY++YCSJ1Ei8kZxyq1o0GD2otbiMDu/WUz8D11
         zGar1Fd4okF/6xmjDnaPWjrZZ0dOvnkkJ2YpC6f9TYAW9vCu7MzaeMAeh76cQqwldb
         o2iu7qv2AdXPacf1czP3WT1jrwveTqMvzlQc+Jwa61Ah7Yp1rIh4zKNTxLyr9nkNec
         ESWbZhjPCSfWA==
Date:   Mon, 12 Sep 2022 16:18:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cgroup tree
Message-ID: <20220912161812.072aaa3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PNj=fYiUIBsNctRUXH3ph65";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PNj=fYiUIBsNctRUXH3ph65
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cgroup tree, today's linux-next build (x86_64
allmodconfig) failed like this:

kernel/cgroup/cgroup.c:5275:26: error: 'CFTYPE_PRESSURE' undeclared here (n=
ot in a function)
 5275 |                 .flags =3D CFTYPE_PRESSURE,
      |                          ^~~~~~~~~~~~~~~

Caused by commit

  8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE")

inteacting with commits

  52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
  34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable int=
erface")

from the tip tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 12 Sep 2022 16:15:33 +1000
Subject: [PATCH] sched/psi: fix up for "cgroup: Remove CFTYPE_PRESSURE"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 974ca46c6d7b..829aa42e773e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5272,7 +5272,6 @@ static struct cftype cgroup_psi_files[] =3D {
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	{
 		.name =3D "irq.pressure",
-		.flags =3D CFTYPE_PRESSURE,
 		.file_offset =3D offsetof(struct cgroup, psi_files[PSI_IRQ]),
 		.seq_show =3D cgroup_irq_pressure_show,
 		.write =3D cgroup_irq_pressure_write,
@@ -5282,7 +5281,6 @@ static struct cftype cgroup_psi_files[] =3D {
 #endif
 	{
 		.name =3D "cgroup.pressure",
-		.flags =3D CFTYPE_PRESSURE,
 		.seq_show =3D cgroup_pressure_show,
 		.write =3D cgroup_pressure_write,
 	},
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/PNj=fYiUIBsNctRUXH3ph65
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMezyQACgkQAVBC80lX
0GxhjQf+NXsMubvv5TYNTfU0/JsvVWj9hXHyNt6le+xJ4heBpagEeivynmL35Sly
xcwSXxVBLpXbFfUBB715dXCwL5glhUujnH2s6+ErC5ybZa4o8TxRelrEdgnh16jQ
drly8VD3esP4WHDAqQ9M4oT2TILstyqmAS9Cb+At8dzCRXbTfGhiUt4m19x63wIz
qq86bdNp6M88BVHbPsNv02rBpqfRS6yh1kUxUzr4Q1YZ/xSKpoY9nO1iwgxvREjy
qIcUowqKAtef71YTq+KiYeKDoGxlVgmD9srpslq1CczBAGEtNvDtJMn86eHWdx24
CwhyhAjU7yUrtLmUJhep8zLWiXvY9Q==
=5YHP
-----END PGP SIGNATURE-----

--Sig_/PNj=fYiUIBsNctRUXH3ph65--
