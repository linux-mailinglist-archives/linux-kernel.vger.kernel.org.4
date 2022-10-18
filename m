Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2C602066
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJRBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJRBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:24:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBB1C12A;
        Mon, 17 Oct 2022 18:24:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mrx3l4V5xz4xDn;
        Tue, 18 Oct 2022 12:24:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666056276;
        bh=ovYciI1whbPEvAwrybxeIj715PXaXyCmrdzpvg20q7Y=;
        h=Date:From:To:Cc:Subject:From;
        b=QJl5Pt1yq09OlrmigUuP3uLeXKhOeQg7n3veUmmuzz0cmXVeoRZ+GbdbntWOpteYz
         93/bPm9hciuMsWNuOalTkxcUnQieTa/VltqDV4ruCELWnnJoukjIX0i0dk9G86p7Fp
         bhuAhNu9sQcBlK8TyW0YGGUnKzQs1ObgWGTvcE4SyhYEFwESjFbQidDT9SxLfMsf17
         fwBNlWVlzG1t+S+tm1AsxBsOeyxtH50ij8X1KowVy0n5XhoB5T29AQUzTIW55KiiPR
         tjAUZKMfP/BtSzKRwQWAvKCZ+VH5Au/67h0c7sPhwxCDMGP3z6sspZ5ILL+TRzXM0O
         SotR7KgRL9Cog==
Date:   Tue, 18 Oct 2022 12:24:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221018122430.44a47456@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/py91g6/tIw6.1xJFUz6P9kn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/py91g6/tIw6.1xJFUz6P9kn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/kernel/ptrace/ptrace-view.c: In function 'gpr32_set_common':
arch/powerpc/kernel/ptrace/ptrace-view.c:709:16: error: void value not igno=
red as it ought to be
  709 |         return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  710 |                                          (PT_TRAP + 1) * sizeof(reg=
), -1);
      |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

Caused by commit

  1afca3ae915b ("regset: make user_regset_copyin_ignore() *void*")

after commit

  8541413ac862 ("powerpc: ptrace: user_regset_copyin_ignore() always return=
s 0")

missed one call site.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 18 Oct 2022 12:19:20 +1100
Subject: [PATCH] fix up for "powerpc: ptrace: user_regset_copyin_ignore() a=
lways returns 0"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ptrace/ptrace-view.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c b/arch/powerpc/kernel=
/ptrace/ptrace-view.c
index ca0bf8da48fd..2087a785f05f 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -706,8 +706,9 @@ int gpr32_set_common(struct task_struct *target,
 	ubuf =3D u;
 	pos *=3D sizeof(reg);
 	count *=3D sizeof(reg);
-	return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					 (PT_TRAP + 1) * sizeof(reg), -1);
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+				  (PT_TRAP + 1) * sizeof(reg), -1);
+	return 0;
=20
 Efault:
 	user_read_access_end();
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/py91g6/tIw6.1xJFUz6P9kn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNOAE8ACgkQAVBC80lX
0Gwb7AgAj2qiSOuBhIzIxRZY432OsWr5DFTzvvfhO5MqvIYAlouJkZhrIh8afyar
tZVHM9zmjeBeDfXSc3xtBd2OHri7FpMveTh9NOFer5oBqb21V20GXFm72QjEjrQ9
dfkP87u2wJFaay4Llo2FnWCtz49hbSphGGTatcTLnm54iL3imgNXMF3NPqeG9ifY
yJeO1oLLT3K/3jD/ZvlAmA7rfFy+MHXCwTX+nilovjaF0Lmu/NxCCwqw8/xXqhvp
0MxAMzglKQjxiLo8+PdpGeVRON3Piq5Je17Crk0YvE+Voe46IEApcejdZFW8mP9w
gTNsZ5r+dSc5irXwM7Yl6Gc1oyo6sA==
=igYY
-----END PGP SIGNATURE-----

--Sig_/py91g6/tIw6.1xJFUz6P9kn--
