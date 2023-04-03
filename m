Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5589B6D3C87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjDCElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjDCEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:41:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502F8A5C;
        Sun,  2 Apr 2023 21:41:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqdWv2fd2z4xD8;
        Mon,  3 Apr 2023 14:41:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680496892;
        bh=W6GP7q6wi5GJwj7Dq38b9nmo+P5VQXSeAtja9XIG3Uc=;
        h=Date:From:To:Cc:Subject:From;
        b=g0nfWgnGj3VP8OVsM5Ry5OyxGrYsrRiC9qCTlkfrLQeMuhu6vN3wLZe+OGKbrhucb
         ntlqK4qZAR4F1KoheUEVhuvif8YwHuahLsbJlGFOnURZTwgfIy7wp8oDc3DSkQmOwh
         1mwor4mHSTrSFGnk04GlZIxnKyZfHByqY56NObfyy+ChnFLQyHqTbLrwi5OYh677vL
         Lz1nU++bZATpcY79dlUKzX46e+NX8QxAy8SCUrV0DFnUCfojB0Je7+pcRJMRc1z7Jl
         DXU/vJDLgNbqaCyftk4As50kPIZ5HcYmfg8eSs2vvX2pAbbavkQ08QlQ6f1gR/Uc2w
         O22YJajdcZWog==
Date:   Mon, 3 Apr 2023 14:41:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ftrace tree with the iommu tree
Message-ID: <20230403144129.250c7095@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DvWvXKmidxV1SDWJWy8u9Xk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DvWvXKmidxV1SDWJWy8u9Xk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  kernel/fork.c

between commit:

  cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")

from the iommu tree and commit:

  fd593511cdfc ("tracing/user_events: Track fork/exec/exit for mm lifetime")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/fork.c
index 4a8f43aa554d,efb1f2257772..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -97,7 -97,7 +97,8 @@@
  #include <linux/io_uring.h>
  #include <linux/bpf.h>
  #include <linux/stackprotector.h>
 +#include <linux/iommu.h>
+ #include <linux/user_events.h>
 =20
  #include <asm/pgalloc.h>
  #include <linux/uaccess.h>

--Sig_/DvWvXKmidxV1SDWJWy8u9Xk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqWPoACgkQAVBC80lX
0Gz72Af+KiLZCohIEh+MgCSTaUO0nXgpchD9kQAyCk/thFxLvtNBuZ8zU/HheIhP
S4XnCEWwdcqQdu/iAiq+sgdT99a0171M3cBzkhczQ+kpNNFsH4lvPfGpDByAQ9rv
uroJn7O9HBPP+nYgqC6GlrU2udwN1mT7eNjJTQ6KMTqvovKstY38lOCJ99RSYWvJ
1KYYO4oSogiBf1CBBzA+4b5UzPzyXCQZs43/XWO3QBhBx1LnW1OcPeHEDVxSr7/9
6ce1ET6bXFiJQNx3L0EDkJ6h+qYRmZ6Q2OIgoR0c8whMkzIDBAOMJWXtqxXLrhgE
ouo1wIj5KVIK0A5vnmjWaoYEaBpjHw==
=XIXx
-----END PGP SIGNATURE-----

--Sig_/DvWvXKmidxV1SDWJWy8u9Xk--
