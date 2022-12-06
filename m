Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6ED644E83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLFWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLFWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:24:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC531F94;
        Tue,  6 Dec 2022 14:23:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRZhB3cb7z4xN4;
        Wed,  7 Dec 2022 09:23:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670365436;
        bh=lqNRfzgYaa3SPZu2eVsFmxAbCnMUF7h6TuLq00GT2eI=;
        h=Date:From:To:Cc:Subject:From;
        b=A95lawMY9K4F8GNxvpovLh5r8yoqV9ki4zrLso/+SnDupp2ABlakDJqjJLOJW2RVp
         GOIoiQ0prAUtJJZeoy/W0jglEmIMfv/ePjPjGx0TFbj0aPeXHA308Xb/nrbqAwY5+j
         EL0EgrrAFPSza/eduwgXnV6x9vdW1PnvvjhtD+5xCyyV0AxfeWUlWSA6k7ZRFtDLbs
         73KdWbU7lilFUStTA7SjXgzhMcH2NTLI1AHEMTVMVlk8G7gDvWdpsSprHX7Ynps26d
         dOzpLQlvkOqBCrhONWAK+eaExnomn6ERyiFdEiybOtob0xQf+KD9LKvrWBY9181MKi
         nQoOf+azYxOfg==
Date:   Wed, 7 Dec 2022 09:23:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hirokazu Honda <hiroh@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the v4l-dvb-next tree with Linus' tree
Message-ID: <20221207092353.0d1df5f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ahfs.6cyzuPFBklWtgXRyxz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ahfs.6cyzuPFBklWtgXRyxz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb-next tree got a conflict in:

  drivers/media/common/videobuf2/frame_vector.c

between commit:

  6647e76ab623 ("v4l2: don't fall back to follow_pfn() if pin_user_pages_fa=
st() fails")

from Linus' tree and commit:

  e2fc6edd37ba ("media: videobuf2: revert "get_userptr: buffers are always =
writable"")

from the v4l-dvb-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/media/common/videobuf2/frame_vector.c
index 144027035892,aad72640f055..000000000000
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@@ -32,10 -33,15 +33,11 @@@
   *
   * This function takes care of grabbing mmap_lock as necessary.
   */
- int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
+ int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool wr=
ite,
  		     struct frame_vector *vec)
  {
 -	struct mm_struct *mm =3D current->mm;
 -	struct vm_area_struct *vma;
 -	int ret_pin_user_pages_fast =3D 0;
 -	int ret =3D 0;
 -	int err;
 +	int ret;
+ 	unsigned int gup_flags =3D FOLL_FORCE | FOLL_LONGTERM;
 =20
  	if (nr_frames =3D=3D 0)
  		return 0;
@@@ -45,20 -51,62 +47,22 @@@
 =20
  	start =3D untagged_addr(start);
 =20
- 	ret =3D pin_user_pages_fast(start, nr_frames,
- 				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
+ 	if (write)
+ 		gup_flags |=3D FOLL_WRITE;
+=20
+ 	ret =3D pin_user_pages_fast(start, nr_frames, gup_flags,
  				  (struct page **)(vec->ptrs));
 -	if (ret > 0) {
 -		vec->got_ref =3D true;
 -		vec->is_pfns =3D false;
 -		goto out_unlocked;
 -	}
 -	ret_pin_user_pages_fast =3D ret;
 +	vec->got_ref =3D true;
 +	vec->is_pfns =3D false;
 +	vec->nr_frames =3D ret;
 =20
 -	mmap_read_lock(mm);
 -	vec->got_ref =3D false;
 -	vec->is_pfns =3D true;
 -	ret =3D 0;
 -	do {
 -		unsigned long *nums =3D frame_vector_pfns(vec);
 +	if (likely(ret > 0))
 +		return ret;
 =20
 -		vma =3D vma_lookup(mm, start);
 -		if (!vma)
 -			break;
 -
 -		while (ret < nr_frames && start + PAGE_SIZE <=3D vma->vm_end) {
 -			err =3D follow_pfn(vma, start, &nums[ret]);
 -			if (err) {
 -				if (ret)
 -					goto out;
 -				// If follow_pfn() returns -EINVAL, then this
 -				// is not an IO mapping or a raw PFN mapping.
 -				// In that case, return the original error from
 -				// pin_user_pages_fast(). Otherwise this
 -				// function would return -EINVAL when
 -				// pin_user_pages_fast() returned -ENOMEM,
 -				// which makes debugging hard.
 -				if (err =3D=3D -EINVAL && ret_pin_user_pages_fast)
 -					ret =3D ret_pin_user_pages_fast;
 -				else
 -					ret =3D err;
 -				goto out;
 -			}
 -			start +=3D PAGE_SIZE;
 -			ret++;
 -		}
 -		/* Bail out if VMA doesn't completely cover the tail page. */
 -		if (start < vma->vm_end)
 -			break;
 -	} while (ret < nr_frames);
 -out:
 -	mmap_read_unlock(mm);
 -out_unlocked:
 -	if (!ret)
 -		ret =3D -EFAULT;
 -	if (ret > 0)
 -		vec->nr_frames =3D ret;
 -	return ret;
 +	/* This used to (racily) return non-refcounted pfns. Let people know */
 +	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
 +	vec->nr_frames =3D 0;
 +	return ret ? ret : -EFAULT;
  }
  EXPORT_SYMBOL(get_vaddr_frames);
 =20

--Sig_/ahfs.6cyzuPFBklWtgXRyxz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOPwPkACgkQAVBC80lX
0GyXAwf8CrMVCEnXkKiFJxJyNfXDW6Jy8m+lmcc3fQMuZZbw+ME3PWN3ZPGLH6dA
FAVdYq+Bhb9NSHoURHRizjCvTI/IMoZfsfVwziDWUuroAjvyUqdIAW8G1osnr/l/
AY9Nj5T9eWvQDoXGn6c1/t9hQA4oNriEXQ+kTIorl20eoGZmhI9x0HadbTLBwVnY
8iIXZ6zMbReP33MtVumyE/KxVZuYtWRaYBrNPXRGfCWtfsRp/ASblKGV2Z9sG49w
cRh2SDXkGnKR7GC4/Fkh0/H3wBFsSv4LbX033CydEtCprurBw8y9nVlQP/MdQ04K
GkWm0vUBQSpMtvvOvkk5ZOpizznaeg==
=myTt
-----END PGP SIGNATURE-----

--Sig_/ahfs.6cyzuPFBklWtgXRyxz--
