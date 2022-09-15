Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CF55B947F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIOGdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOGdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:33:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1795AD9;
        Wed, 14 Sep 2022 23:33:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MSnSx2Bhxz4x1F;
        Thu, 15 Sep 2022 16:33:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663223585;
        bh=wK9zZIrn0GSvSUQK4l4LOTF9pgexwJPX7pO19gTWnlA=;
        h=Date:From:To:Cc:Subject:From;
        b=lo1DubyyM7oDnig14KQnzqiWN92Nmw7++NY97BPxlIoGXV1yegWaAr0yUx2YfFave
         O1SHvoLb55rMFOYAmi/fEcTCaOzls147TiNyxmVhucdkkgyNMp4EJmIb8RJ10zo7cP
         5R1bZiA3vdO2qEPe9JKRUj4eHTXZ/1Uu4/7tlgRzzEAE6NdoVlWLDQpbXLYw0Oku0F
         hcY9E8K9yWNd6SIz3WK03O+8BtDdznU0YOCNctgVeVo7XDAD5auyAaRp5FgzBhtmZC
         K6PJJ9oePbR4kqNcP83GHZhvnzkZQEZUGyj+Z7EE7vMbVhrkYHWhFznUeJhTYYRIpY
         bLLJnXHOnumhQ==
Date:   Thu, 15 Sep 2022 16:33:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the mm tree with the kselftest tree
Message-ID: <20220915163301.1c8803bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yca8PNeg1hzOn6qyYHw=22U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yca8PNeg1hzOn6qyYHw=22U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  tools/testing/selftests/vm/hmm-tests.c

between commit:

  ab7039dbcc61 ("selftests/vm: use top_srcdir instead of recomputing relati=
ve paths")

from the kselftest tree and commit:

  223e3150a0d8 ("hmm-tests: fix migrate_dirty_page test")

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

diff --cc tools/testing/selftests/vm/hmm-tests.c
index 7d722265dcd7,96eb73f37904..000000000000
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@@ -31,8 -31,9 +31,9 @@@
   * This is a private UAPI to the kernel test module so it isn't exported
   * in the usual include/uapi/... directory.
   */
 -#include "../../../../lib/test_hmm_uapi.h"
 -#include "../../../../mm/gup_test.h"
 +#include <lib/test_hmm_uapi.h>
 +#include <mm/gup_test.h>
+ #include "vm_util.h"
 =20
  struct hmm_buffer {
  	void		*ptr;

--Sig_/yca8PNeg1hzOn6qyYHw=22U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMixx0ACgkQAVBC80lX
0GzOmAf/Z/qdfb0WQt9V/j5/HHy5XrgAQ/hTAxmcOoWNEEVopAhgagX3SRfdmGo2
bQBRFO6v2PwdiQBInotRIWswg5lkOzgnQW6nz65hPIP6+mrIAkHlHa10mJDbP6u3
wIpvJ7IRgvpw+oYl7PoVWgjEoqpUrzwS/hln5tdNNFQo1oB0p8wm7gGBtcB6q3pB
cv1FhNzhZQMQynShvoGaUMlIk7Q2aUhouoN99QncAE+sV12XQ5Yk0dTlI0LG20QH
Dx3Uql72IGY5yhtd3FETbltWm4lVOsSVbMtkGf+b/VxLzfeADY5QctzJ3zRHn6ln
agZoTaDqSiLSQiv1ED4CcnADgmeCCA==
=713r
-----END PGP SIGNATURE-----

--Sig_/yca8PNeg1hzOn6qyYHw=22U--
