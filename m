Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E597395BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFVDLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjFVDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:11:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B11BDC;
        Wed, 21 Jun 2023 20:11:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qmlkm2pTDz4x0L;
        Thu, 22 Jun 2023 13:11:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687403476;
        bh=7Qm8l7c2nuE9U4jZ8AyN30XctT4g7MtPQ1Sf7C9ve9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=D9gPMYmnssPsDCwCYe8tHi2mwCRsU9uFAiz7kH5AFIUgCmE8uRQ3nh9AQQXlgE5FT
         RNZuEPNxQ7/e9kfudGQEjPrgq0QXtgcEbLUge+vX9x+m6PhNVTyKZ8DUyQEvuqA52l
         witBkMDaXINPriAGT0GlHlPdLLVowl+1apDnTUbM4cXv2UKEM7E8VMXwl8x1N4vTjA
         +cn8jzQM+QiicXgR86JFScai59P2h3IYvZ2DDMoYaVdNEGRo+LuGxCRgvp5mexzGnx
         8+D9f1suLf2OYlBlyIK4dJqRt0OfgDn0cdLBlgzEEwalP+mYNdXYYnB+r33ca/7+dc
         E57GRqdws0+yQ==
Date:   Thu, 22 Jun 2023 13:11:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the tip tree with the vfs-brauner tree
Message-ID: <20230622131108.19059f3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G3lxhFHOTDr_0Ur8G.CHSPo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G3lxhFHOTDr_0Ur8G.CHSPo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  include/linux/proc_fs.h

between commit:

  ef104443bffa ("procfs: consolidate arch_report_meminfo declaration")

from the vfs-brauner tree and commit:

  eec387cbf905 ("x86: Expose thread features in /proc/$PID/status")

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

diff --cc include/linux/proc_fs.h
index 253f2676d93a,80ff8e533cbd..000000000000
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@@ -158,8 -158,8 +158,10 @@@ int proc_pid_arch_status(struct seq_fil
  			struct pid *pid, struct task_struct *task);
  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
 =20
 +void arch_report_meminfo(struct seq_file *m);
 +
+ void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct=
 *task);
+=20
  #else /* CONFIG_PROC_FS */
 =20
  static inline void proc_root_init(void)

--Sig_/G3lxhFHOTDr_0Ur8G.CHSPo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTu8wACgkQAVBC80lX
0GwOygf/Trk7vPJzVHgp1QiAu6AgiMyXHYKqbOtJG8fsW2hZUuERfHd+grbbyzff
jnO5Y3SajH7oFrcOD8TqYdH6wD4TdYriw8XA9nuFPKWj2+6aQzPiUbP3ku8kPivP
tVyLX6ntGxkzI2bJYNzeHkw6bBk62vfd6R+PG07yy2osndehAVhW4IKL3lQd8bZk
IF3Y+mHAovakKKObByPMkyHAVvorDZScdt/SWGwHh0/D/g/QDTzSMQJdmI7SWkU0
xzMaaOQwHG4UyAzdN6CioG761CrQGz38M/Ohvr4HWyoeXPv2jBxduRqnUUFKN0pc
ALfQnu2v6q8lpPtmYCNbl6G2chojBQ==
=jGD9
-----END PGP SIGNATURE-----

--Sig_/G3lxhFHOTDr_0Ur8G.CHSPo--
