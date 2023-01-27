Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B967DD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjA0GQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjA0GQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:16:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6B599A5;
        Thu, 26 Jan 2023 22:16:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P36ll1z3Cz4xGM;
        Fri, 27 Jan 2023 17:16:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674800181;
        bh=VhTAOPrR41Xg1IzRQ17uQEaagP6uPDMc4j791sT8zEA=;
        h=Date:From:To:Cc:Subject:From;
        b=r6bc8cFO/RdP1CxwcD75JPkpbxG4nBrymxSzuPj7IrlcntYBSc7BPqe/cLAjWcAUs
         vOn+pcsfSgmTGIf6RPv2bkR4mZ3YxeyUurDRHevvW71Blik/2V2/IwJG8pEu8lUK7A
         FVv9XCWVoKmcH471pfx9xQuKfBUStu74i0lOZsVFUl3f5yPWYwi0jB6XtvSMtqB/Jq
         k/ukKGp4MV9pqXIQERVzdjlnHY7WftvIey4VecmxhyCbrBwP5iDBZsqsjL53x3isMm
         LN8on3aSyI7zghDPLbzztn8Bb77SdTEhdENG3zpll9V/DilUE2Ji0voEiHjM9/vBbm
         qKVKFBcsSKRTQ==
Date:   Fri, 27 Jan 2023 17:16:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230127171618.79cead50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yAe8Kl73kuJv_dCjTOMdg.Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yAe8Kl73kuJv_dCjTOMdg.Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/accel/ivpu/ivpu_gem.c: In function 'ivpu_bo_mmap':
drivers/accel/ivpu/ivpu_gem.c:449:23: error: assignment of read-only member=
 'vm_flags'
  449 |         vma->vm_flags |=3D VM_PFNMAP | VM_DONTEXPAND;
      |                       ^~

Caused by commit

  b95a895848b9 ("mm: introduce vma->vm_flags wrapper functions")

interacting with commit

  647371a6609d ("accel/ivpu: Add GEM buffer object management")

from the drm tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Jan 2023 17:12:37 +1100
Subject: [PATCH] accel/ivpu: fix up for "mm: introduce vma->vm_flags wrappe=
r functions"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/accel/ivpu/ivpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index d1f923971b4c..12b219dd4f36 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -446,7 +446,7 @@ static int ivpu_bo_mmap(struct drm_gem_object *obj, str=
uct vm_area_struct *vma)
 		return dma_buf_mmap(obj->dma_buf, vma, 0);
 	}
=20
-	vma->vm_flags |=3D VM_PFNMAP | VM_DONTEXPAND;
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND);
 	vma->vm_page_prot =3D ivpu_bo_pgprot(bo, vm_get_page_prot(vma->vm_flags));
=20
 	return 0;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/yAe8Kl73kuJv_dCjTOMdg.Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTbDIACgkQAVBC80lX
0GzSIgf/b7KHPO4scsTzokPV5z4OBxlpegEhuzziCz19qpHAQyMW+AgBCS7jziDr
eljFLxzebi0p8vzsRmwVtsQXFt9PH8KPZsOAbOUqQxYMnFwoTZbF/gIZU2BamVJI
c6BHCxxXxRmlj862Edds7VlSUZQ0YdIuv8jqg28yonguHQ+5zWf4TFYmLs2Zi2nC
HEMHQtJNCkkWh1FVsxL6zJz0nXGC5w/KK6x/+Lidh6TtNmAefXaIUwJXIbay9Dr6
Ph+grPflixawhg/QHkKphbl0JjPlXlxSlZYtyoRd5iCBuTAnh5/OkhqlL0jDYmew
0nEJWVhNnh78pWLCUq3Aa6XA6B3Uzw==
=Z4ND
-----END PGP SIGNATURE-----

--Sig_/yAe8Kl73kuJv_dCjTOMdg.Q--
