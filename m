Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E967DD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjA0FVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:21:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E12A98F;
        Thu, 26 Jan 2023 21:21:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35Xm6LDNz4xGM;
        Fri, 27 Jan 2023 16:21:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674796907;
        bh=ElbxIHGG350REXTmSYM+T8ONWCYZkA51/Jho7+0kBBk=;
        h=Date:From:To:Cc:Subject:From;
        b=iqCR6CmOIFbHobhWLLARl1Wnb+EuE8/TTejkxK0NWXl+gwrKlR329LqXyWVaR939W
         q78+vATfjvjDZqXVboEV0NWHkiTwwfK1WDaUMZaob7jCy4aITRcv5CVEesudjewzYE
         4leIH79mQfSZa3kcaRvkLpepwlDE/TFj4y+PjWlfIzTJw/YQgQzN5uKJMWjo3c1+HX
         klCgb2KjfVG+W98JMTYsNm/TskfEWd7op8+cq3L94ddSLM/fDeG7J9k1t76VwYjTI/
         IDV1TWKFD+jiZ1rej8z5Ykq6tmTQMvC0RVbYYZ6PYV71zi2CVvdKrxhXdEvwRjlZOs
         zkypjwl2XDSJA==
Date:   Fri, 27 Jan 2023 16:21:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the mm tree with the rdma tree
Message-ID: <20230127162143.1a3bc64b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kp/.8g48qMu3jNvrNEERdcF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kp/.8g48qMu3jNvrNEERdcF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  drivers/infiniband/hw/hfi1/file_ops.c

between commit:

  1ec82317a1da ("IB/hfi1: Use dma_mmap_coherent for matching buffers")

from the rdma tree and commit:

  6fe0afd07701 ("mm: replace vma->vm_flags direct modifications with modifi=
er calls")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/hfi1/file_ops.c
index e03b0207856e,c6e59bc480f9..000000000000
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@@ -424,17 -403,8 +424,17 @@@ static int hfi1_file_mmap(struct file *
  			ret =3D -EPERM;
  			goto done;
  		}
- 		vma->vm_flags &=3D ~VM_MAYWRITE;
+ 		vm_flags_clear(vma, VM_MAYWRITE);
 -		addr =3D vma->vm_start;
 +		/*
 +		 * Mmap multiple separate allocations into a single vma.  From
 +		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
 +		 * requires the mmap to exactly fill the vma starting at
 +		 * vma_start.  Adjust the vma start and end for each eager
 +		 * buffer segment mapped.  Restore the originals when done.
 +		 */
 +		vm_start_save =3D vma->vm_start;
 +		vm_end_save =3D vma->vm_end;
 +		vma->vm_end =3D vma->vm_start;
  		for (i =3D 0 ; i < uctxt->egrbufs.numbufs; i++) {
  			memlen =3D uctxt->egrbufs.buffers[i].len;
  			memvirt =3D uctxt->egrbufs.buffers[i].addr;
@@@ -560,9 -528,11 +560,9 @@@
  		goto done;
  	}
 =20
- 	vma->vm_flags =3D flags;
+ 	vm_flags_reset(vma, flags);
 -	hfi1_cdbg(PROC,
 -		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
 -		    ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
 -		    vma->vm_end - vma->vm_start, vma->vm_flags);
 +	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma,=20
 +		  memlen, vma);
  	if (vmf) {
  		vma->vm_pgoff =3D PFN_DOWN(memaddr);
  		vma->vm_ops =3D &vm_ops;

--Sig_/Kp/.8g48qMu3jNvrNEERdcF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTX2gACgkQAVBC80lX
0GwAOQf/XhxyOShr+CmxFTTBGVL/Ksnht2CcC0VK57U2EQL8PATzCLKkALHbc9GH
r4SlKamxq7V2gRcrusTAkodYsVcdzcq+Q1u8d2oShAJWL7IpyQBGllmcA2c+8o5q
yH2sOHwMmYrdi3oT4BXeLAxAgVptCJHH3pMaaIzm+ahJ7W2ZgWgrfcBJh9M+N69i
GWT9VM0D5mDJTs+nOBFo7/2hEpyVI3ClfZqImi2Stsaji++b9pXSY6uk0raZrJO1
3DglC5tX1CqGdZHhM04PtKIgetJ+tYRu114IotKrHJZcXMfOV8Vp2t2K7VQA4RSi
1XS8NcR6sTn/RDidrTtdTleprUL85w==
=yZpw
-----END PGP SIGNATURE-----

--Sig_/Kp/.8g48qMu3jNvrNEERdcF--
