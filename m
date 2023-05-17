Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB57076A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjEQX7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEQX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:59:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B362A2;
        Wed, 17 May 2023 16:59:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QM97m2y8sz4wgq;
        Thu, 18 May 2023 09:59:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684367972;
        bh=aQaZ4S9QuSxsOA7YpGDw0SrL+U7iyKsJ2qf2s4M/s2M=;
        h=Date:From:To:Cc:Subject:From;
        b=XYP1Y0IyeoBBAAvG04Fkk0njP7J/pSqWl7Z0BIf3awn6LSuNBxwTWAe/r0Rweda1V
         4hokdSCzudOK9g9Ya3d88B7Y4z7BMxtTpYk/8iP8AZZEEz+VhNEgx2WQOLNyKLemav
         mUbDR13I/ElV+oClgrcuk2JP44wegIj6n95ymVBJBzMvuNIW1rq+UAL/fBLODgCe6x
         T6CdKaj+XaeHs6k0T5hmnomFqoDcUZyR5HJYfYJ/Q6+z+Tvx3IkhGJRtaC8Z6rYGWf
         IPlalSEY+UorZkD24OiDkzYzrt/P21lUY7H16/N4lKWrFlBq6wTiIURpSPshYFTh29
         7hN90qAiaaleg==
Date:   Thu, 18 May 2023 09:59:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230518095929.509e34c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UZ.fwSYX9bJUmCYQ0bvOPd2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UZ.fwSYX9bJUmCYQ0bvOPd2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/page_ext.h:7,
                 from include/linux/mm.h:22,
                 from security/min_addr.c:3:
include/linux/stackdepot.h:116:26: warning: 'struct seq_file' declared insi=
de parameter list will not be visible outside of this definition or declara=
tion
  116 | void *stack_start(struct seq_file *m, loff_t *ppos);
      |                          ^~~~~~~~
include/linux/stackdepot.h:117:25: warning: 'struct seq_file' declared insi=
de parameter list will not be visible outside of this definition or declara=
tion
  117 | void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
      |                         ^~~~~~~~
include/linux/stackdepot.h:118:24: warning: 'struct seq_file' declared insi=
de parameter list will not be visible outside of this definition or declara=
tion
  118 | int stack_print(struct seq_file *m, void *v);
      |                        ^~~~~~~~

And many, many more ...

Caused by commit

  e435b85a4aea ("mm, page_owner: add page_owner_stacks file to print out on=
ly stacks and their counte")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 18 May 2023 09:39:46 +1000
Subject: [PATCH] fix for "mm, page_owner: add page_owner_stacks file to pri=
nt
 out only stacks and their counte"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/stackdepot.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 7e9d0e9ec66b..8bbd1639ae85 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -113,6 +113,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *en=
tries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
=20
 #ifdef CONFIG_PAGE_OWNER
+struct seq_file;
 void *stack_start(struct seq_file *m, loff_t *ppos);
 void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
 int stack_print(struct seq_file *m, void *v);
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/UZ.fwSYX9bJUmCYQ0bvOPd2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRlamIACgkQAVBC80lX
0GzI+Qf/bld6wtTl3mRyOR4xnrIWvMoDF8E6BCq7M7AzGm1tAYOmgD1a8lyX7T3f
3iwLAVV1ruokoa1MgELw9fqK9BBDChMivMISTHXi2en+LBTQ3UKZwvn09AunUEYj
9LP455JA0UdpX3ZQxISteN/O99Ic/B6zNNIEYdxA99qTE4Zpt7ab3EGKzVYfoBSo
RjkyvB1tiijXXtRtu58Lc9XiP+/chbz5p50L1+4MX8b1S+Tfodg7GF+gEfErtZ9l
mHP2LLKxf8+iWmlKyyPeYecy1x9iMBPvDCDDdeQivSyF2wLRq1QFwAwEDURL0GsM
Y8ozEG7dfr+sCMLuNdAYQqjJbItuEA==
=IfUK
-----END PGP SIGNATURE-----

--Sig_/UZ.fwSYX9bJUmCYQ0bvOPd2--
