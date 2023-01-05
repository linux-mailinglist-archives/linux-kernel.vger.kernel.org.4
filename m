Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE465E2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjAECZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:25:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E247304;
        Wed,  4 Jan 2023 18:25:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnVgj08PKz4xxJ;
        Thu,  5 Jan 2023 13:25:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672885537;
        bh=BC10QsUUd1K7Af0Szikb0lc79bRmlLVHx71gJoE8l6c=;
        h=Date:From:To:Cc:Subject:From;
        b=fdXJrSS0gXHPghZ5PfIKQfQfVJV4QevwEOT1kPoLKfFS/58sAY4wr30C/hvCaZSaR
         +gwynNnpyv0RwSAkABo7mVNqyfE2eJcVG225odkAhR5vTYG6nmzY8OeaM0dNPK6ly7
         wSGNxooEujw3BUz7lbyb35n8MmSPAPD5hnaelomSt/7++ykGIfTTGX5CUXiM8JCd4L
         G9ifwxPGTEjh/GFPQusBdAgzR6arcxgd/F/WEiznImFwbG84lWR2AbqHFehKf6Ffy0
         TWo+SScL2e6FSJn5OHqrhLTaMrQ2Q/hc61gPU+fIeaXAcaMnfIlahPdfNEdm4NuZa/
         Px2iyG77qKFaQ==
Date:   Thu, 5 Jan 2023 13:25:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20230105132535.0d65378f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q0x/hwuU9B53vO1dS4rR3Vy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q0x/hwuU9B53vO1dS4rR3Vy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/paravirt.h:17,
                 from arch/x86/include/asm/cpuid.h:62,
                 from arch/x86/include/asm/processor.h:19,
                 from arch/x86/include/asm/cpufeature.h:5,
                 from arch/x86/include/asm/thread_info.h:53,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:9,
                 from include/linux/preempt.h:78,
                 from include/linux/percpu.h:6,
                 from include/linux/prandom.h:13,
                 from include/linux/random.h:153,
                 from include/linux/net.h:18,
                 from net/rxrpc/output.c:10:
In function 'fortify_memcpy_chk',
    inlined from 'rxrpc_fill_out_ack' at net/rxrpc/output.c:158:2:
include/linux/fortify-string.h:520:25: error: call to '__write_overflow_fie=
ld' declared with attribute warning: detected write beyond size of field (1=
st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
  520 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Exposed by commit

  f7cd05c76c70 ("fortify: Use __builtin_dynamic_object_size() when availabl=
e")

I applied the following patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 Jan 2023 12:56:39 +1100
Subject: [PATCH] rxrpc: replace zero-lenth array with DECLARE_FLEX_ARRAY() =
helper

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/rxrpc/ar-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 18092526d3c8..c7186484fc5f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -783,7 +783,7 @@ struct rxrpc_txbuf {
 			u8	data[RXRPC_JUMBO_DATALEN]; /* Data packet */
 			struct {
 				struct rxrpc_ackpacket ack;
-				u8 acks[0];
+				DECLARE_FLEX_ARRAY(u8, acks);
 			};
 		};
 	} __aligned(64);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Q0x/hwuU9B53vO1dS4rR3Vy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2NR8ACgkQAVBC80lX
0GwCwAf+MPoesdKOEFCkSlAbUUYlyXe238BDLiBFVQ807UqSzojCndV01ehfCAs0
mb06jCclrk1C03o0ABuweEyw1DgQQc5X+Rd45oPcXwKZ1YbMqZfP7K3Xt2IfXXM0
B+ALsvG5vF7tP13d0y46C7nDjJAf7myn8nJ5mXRZUzJBbmJIXWireVNc4Arv1O5L
i4vRJ7hbU0Xy75JW/pVU4Y61iymDMOznTS8YSmMepFMx+OmNnDLuvxekemwBVLxa
Ki5cpREBzt1/WX++StAX5bENkslUNrFTjx5vZLJmB2Mubk28TLOhuA15uENH4gnP
JM1QArGvkpkfzU98mjlfwD9t1PfT0g==
=A0vG
-----END PGP SIGNATURE-----

--Sig_/Q0x/hwuU9B53vO1dS4rR3Vy--
