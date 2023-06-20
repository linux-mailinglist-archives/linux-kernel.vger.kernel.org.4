Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9EE7362D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFTEyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFTEyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:54:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D758C6;
        Mon, 19 Jun 2023 21:54:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QlZ6H3YwSz4wjF;
        Tue, 20 Jun 2023 14:53:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687236840;
        bh=suI4KpgbK5VrndPgV8n5VWkerfSeVjf7EIddwu6JhPE=;
        h=Date:From:To:Cc:Subject:From;
        b=FtaTnuHyEJ7LsLOTF6Ajy1Lo+1lKGhRP2cEcSN1+BH66o3IBGrLApaqL4pqpzmmlF
         Rbh3Mwa0YXEapbFTdIykAt6VDScYBfrnO9XT/9tkxySqS9e8FLUn3PV/4E2PV+VCwp
         blkkW8Ov+1nrj6W/8gKV9zLm0WHFNWcZBLahvNesPt+BHSv7wmWEIO0PqoDcVCkLK1
         qW4Lnu/K9ZpjoCmef5RsEswwZWeXyyStJ0xIhiI7N22o+0R9eTl5EbUyODcrH5T1rZ
         85EtseqiyIIIEjAwpj2vkkLCWheBjP1+XPPPwRN0OMLSXPEcYJxA7lXgxAUkZwZP72
         7t95DTZicKpVQ==
Date:   Tue, 20 Jun 2023 14:53:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20230620145357.12d6b23f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qKbab17/XbTXiSu=AKDKWc_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qKbab17/XbTXiSu=AKDKWc_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

In file included from include/linux/mem_encrypt.h:17,
                 from arch/x86/include/asm/page_types.h:7,
                 from arch/x86/include/asm/page.h:9,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:9,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:56,
                 from include/linux/swait.h:7,
                 from include/linux/completion.h:12,
                 from include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
arch/x86/include/asm/mem_encrypt.h:23:20: error: static declaration of 'mem=
_encrypt_init' follows non-static declaration
   23 | static inline void mem_encrypt_init(void) { }
      |                    ^~~~~~~~~~~~~~~~
In file included from include/linux/printk.h:6,
                 from include/linux/kernel.h:30,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/preempt.h:6:
include/linux/init.h:158:6: note: previous declaration of 'mem_encrypt_init=
' with type 'void(void)'
  158 | void mem_encrypt_init(void);
      |      ^~~~~~~~~~~~~~~~

Caused by commits

  439e17576eb4 ("init, x86: Move mem_encrypt_init() into arch_cpu_finalize_=
init()")
  0a9567ac5e6a ("x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn build")

from the tip tree interacting with commit

  ad1a48301f65 ("init: consolidate prototypes in linux/init.h")

=46rom the mm tree.

I have applied the following merge fix patch for today (but I think it
can be consolidated into the mm tree commit - along with removing the
parts that remove this declaration from elsewhere).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 20 Jun 2023 14:30:52 +1000
Subject: [PATCH] fix up for "init: consolidate prototypes in linux/init.h"

interacting with commits

  439e17576eb4 ("init, x86: Move mem_encrypt_init() into arch_cpu_finalize_=
init()")
  0a9567ac5e6a ("x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn build")

from the tip tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/init.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 1200fa99e848..266c3e1640d4 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -155,7 +155,6 @@ void __init init_rootfs(void);
=20
 void init_IRQ(void);
 void time_init(void);
-void mem_encrypt_init(void);
 void poking_init(void);
 void pgtable_cache_init(void);
=20
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/qKbab17/XbTXiSu=AKDKWc_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSRMOUACgkQAVBC80lX
0Gz4Cgf/aihCAXnUlNd5x7sInWtQDM4gJO8xiHXmz5CiVlVmpDwYzzuplX6UlKwH
6R9Toqt9aLQQhCorWQCW08QsnoiUmV0FOqHdB+TdMr6/ew5LoHnxMcrNXNFEn55Q
8nJDYgPZoNXh+6F0Bc3AY2CsVy1lGpABkR7I3gICmyEvimwaH5PLTAKjK1tPeRA7
ThORHH5hcdLbGRtPwAYqRNwJaYfXX1jm/NhhZpR+NU5hX5gu4C8M2VG4PeofUcoS
xe/WciQNaa75KmnBhXHHSLrFtmuRexYp7JIwrCsPO8HnuRmZ4qLSma/0PCnDzmIb
k+wvTU9odtBvy7hzv7GDrlGP/Ct3EA==
=fgjL
-----END PGP SIGNATURE-----

--Sig_/qKbab17/XbTXiSu=AKDKWc_--
