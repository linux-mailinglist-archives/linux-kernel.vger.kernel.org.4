Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC1642100
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLEBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiLEBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:15:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E99FDE;
        Sun,  4 Dec 2022 17:15:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQQbL1dL5z4xN8;
        Mon,  5 Dec 2022 12:15:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670202944;
        bh=va+ER1GinBW/ZbxfHD/We3OdldRGmNelHCbNhtA+I08=;
        h=Date:From:To:Cc:Subject:From;
        b=LUiOAsmxErriObZ4GNeT4CErqp+Xlt6RFwjfddFzTwvL3jPnkDLHQJ6Fdd7wUXto3
         iOPIhzSXzyQko5Ec6CH9xdq6WGmTOQTZlZn/RDWUqo7d1pqvFJGme1OBjNLT1innkY
         8Th63qUjUT12CVTvt3nX0qD6RmLDceM69/0eb4YnXVBZ56lv02Max6IjQxuRf2x0uX
         bFSsmsunqM5NhrzY8x6WIK1UyBNXlfvVDZeRW3un4JzJPrfLUmnGkJuBQ9NmBNEzxy
         TJ/fUip4tC0hRFiLkzXEF/wWHoM2s3EhT5XFy+daZjqByZgxsaSnqmj9Y8g8lTZhXZ
         b9r76AcovcZWA==
Date:   Mon, 5 Dec 2022 12:15:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20221205121540.25a993c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ta_TCegbeHFhMSoB1X7m4ax";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ta_TCegbeHFhMSoB1X7m4ax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/uaccess.h:11,
                 from include/linux/sched/task.h:11,
                 from include/linux/sched/signal.h:9,
                 from include/linux/rcuwait.h:6,
                 from include/linux/percpu-rwsem.h:7,
                 from include/linux/fs.h:33,
                 from include/linux/huge_mm.h:8,
                 from include/linux/mm.h:726,
                 from drivers/media/common/videobuf2/frame_vector.c:5:
drivers/media/common/videobuf2/frame_vector.c: In function 'get_vaddr_frame=
s':
drivers/media/common/videobuf2/frame_vector.c:46:31: error: 'mm' undeclared=
 (first use in this function); did you mean 'tm'?
   46 |         start =3D untagged_addr(mm, start);
      |                               ^~
arch/x86/include/asm/uaccess.h:38:28: note: in definition of macro 'untagge=
d_addr'
   38 |                 __addr &=3D (mm)->context.untag_mask | sign;       =
       \
      |                            ^~
drivers/media/common/videobuf2/frame_vector.c:46:31: note: each undeclared =
identifier is reported only once for each function it appears in
   46 |         start =3D untagged_addr(mm, start);
      |                               ^~
arch/x86/include/asm/uaccess.h:38:28: note: in definition of macro 'untagge=
d_addr'
   38 |                 __addr &=3D (mm)->context.untag_mask | sign;       =
       \
      |                            ^~

Caused by commit

  062c9b2996e9 ("mm: Pass down mm_struct to untagged_addr()")

interacting with commit

  6647e76ab623 ("v4l2: don't fall back to follow_pfn() if pin_user_pages_fa=
st() fails")

from Linus' tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 Dec 2022 11:55:52 +1100
Subject: [PATCH] fix up for "mm: Pass down mm_struct to untagged_addr()"

interacting with "v4l2: don't fall back to follow_pfn() if pin_user_pages_f=
ast() fails"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/media/common/videobuf2/frame_vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/=
common/videobuf2/frame_vector.c
index 18124929b18d..13455a76a37e 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -43,7 +43,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr=
_frames,
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames =3D vec->nr_allocated;
=20
-	start =3D untagged_addr(mm, start);
+	start =3D untagged_addr(current->mm, start);
=20
 	ret =3D pin_user_pages_fast(start, nr_frames,
 				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ta_TCegbeHFhMSoB1X7m4ax
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONRjwACgkQAVBC80lX
0GyglQf/XuQWW31A/19o3r+K3CnPRal4dtU0hcX4mqfxfQUdwUFZtUOqhkAXUK5C
ElbQ2RReZCtTZbYVK/Q4TMSN1IfPYQZ1S01qG8mbr5SwtMsRGst5jyIL5+DxIb4C
K9MOqXug2hz10VyYCkLRWj9GBBGqGyyK4sweo42i8Cfuv1YfJ8OcyqdRhDnwVyK0
lYfGHtmLMYP9xWbMwkDLBqwp99P/vtaGTF4Jvx+ilPkLtOiDVhCMA6F9nAH+7HS0
13oWdWzdjRj6q/o0zxGlwzVEuZzwtFnaMd/9ZOJh+30WnZ/2rIIrpc8mz1x7jshR
kHB0MwWajKVrZLvqMod33Z6oWygEiw==
=7UPh
-----END PGP SIGNATURE-----

--Sig_/ta_TCegbeHFhMSoB1X7m4ax--
