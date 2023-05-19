Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C1708DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjESCnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESCnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:43:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562DE4E;
        Thu, 18 May 2023 19:43:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMrk94FJgz4x5W;
        Fri, 19 May 2023 12:43:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684464194;
        bh=HQJgsxcpsIzvlNbIB3CBeC83J899N6mzuWzgWnrhbo4=;
        h=Date:From:To:Cc:Subject:From;
        b=usUJXKy/ANjDyCXw2lF9rIWXJClVftXduoCZCqf5zxKwHS6e3Qp4slUymALHe4rrG
         BGUFn6Yix4GLvj9sOGgJM8a3YvIFSfRwRGZezr7BWoR+F8qUXG5VrXRgpknho555m/
         Olx6vIeJQSWHNhABviOk1sI7Bw7bfSKzJ7OH9WszwAMVehDF9xfMyAlGAVffAiNxoD
         OaJjwazB1YAnSJLJbQlmDwohfqje7HAsOhHntlZ/GdlxrEK/1Ae4C9inqLSHQesYHl
         ml0M3YDoX6AU9Y2d7oTBEhupbh5qII/NA7H4kRCt0Dk1FpceSjr7nSoBEb88UxEdrR
         St8bbZ1JxfVqQ==
Date:   Fri, 19 May 2023 12:43:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230519124311.5167221c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HJvJD5iUf.t/+JT85er6x1g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HJvJD5iUf.t/+JT85er6x1g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc64 defconfig)
failed like this:

arch/sparc/kernel/setup_64.c: In function 'start_early_boot':
arch/sparc/kernel/setup_64.c:382:9: error: implicit declaration of function=
 'time_init_early'; did you mean 'inode_init_early'? [-Werror=3Dimplicit-fu=
nction-declaration]
  382 |         time_init_early();
      |         ^~~~~~~~~~~~~~~
      |         inode_init_early

Presumably caused by commit

  c16caa9110dd ("init: consolidate prototypes in linux/init.h")

I applied this partial revert:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 19 May 2023 12:35:26 +1000
Subject: [PATCH] fix up for "init: consolidate prototypes in linux/init.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/kernel/kernel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 970ef8dec86e..15da3c0597a5 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -62,6 +62,9 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs);
 void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long =
sp);
=20
+/* time_64.c */
+void __init time_init_early(void);
+
 /* compat_audit.c */
 extern unsigned int sparc32_dir_class[];
 extern unsigned int sparc32_chattr_class[];
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/HJvJD5iUf.t/+JT85er6x1g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRm4j8ACgkQAVBC80lX
0Gwb4ggAoRLsiCfdXE731SmuLatz/ueG4ndkaLEAiqnVZoJ5SVOIckDEWhAo4WUV
V4bfKv8kk05AdGA7zXLNZuj/eGf/kMVRsW+EtMRNKUjWnO6PIU4HFGpHgNQDdoFx
evg/M+binZmsP27/clJ/xkk+Tk65OXmJVm9rqVPAH9AwkCREWAkcy1LzkoMRHDr9
CLltLo4CZfQB0IWkb5L+VdYdh5wS6rYVyFa12CdF1K1C1hDZn6rsd0qokqVbRMbH
ppij/OPVYgKhWUItk9ocovrC23OlG9oJz4SOAOy72LYlIE/yxPuvOrk9+chBOhuH
E6o9Bl1XR6d222Kno7XuSFBNMLuAUQ==
=p+eC
-----END PGP SIGNATURE-----

--Sig_/HJvJD5iUf.t/+JT85er6x1g--
