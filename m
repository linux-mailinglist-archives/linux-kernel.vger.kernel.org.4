Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844064AD45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiLMBlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiLMBkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:40:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CF1B1D4;
        Mon, 12 Dec 2022 17:40:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWLm81wSdz4xGH;
        Tue, 13 Dec 2022 12:40:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670895625;
        bh=5Wl7AcR10V9XvhyKuijI2Nb2Lac+cY7HeWrUdeDmjCk=;
        h=Date:From:To:Cc:Subject:From;
        b=AnIpkE9adSEnTffnZIK0efsbrAE3QP5bzYjh13f6ACTxvBwUrijp9EOeYiT815Qvz
         HkvNrLwTxnLpI3RnXfznvMPqNINNO8zNDzhv6ey5kcbaSgnEqJkA4qRKFUD1r+vG1M
         E1dl6FO1skm2uztavYzoqda75gzUlISAfPyNqynhXCi/DqpWdZK0pti1Du+yWpBiTV
         lW5G5Uf49z/9cFwXgDs1MxXW7HCgthOGsMJSVSRtdaTm6VNlr35pOdXDxskohzqL2e
         1AIiDDIS19NI3j+g68YG3DdXZoelIJUvdJGj5AAqR77++KKs4xe2zhWZiG/Hx4BaTB
         Y26l0YlF/jf4A==
Date:   Tue, 13 Dec 2022 12:40:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20221213124023.40476af0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.jJexiWS6+SUx0U7XEJLdyF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.jJexiWS6+SUx0U7XEJLdyF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from include/linux/uaccess.h:11,
                 from include/linux/sched/task.h:11,
                 from include/linux/sched/signal.h:9,
                 from include/linux/rcuwait.h:6,
                 from include/linux/percpu-rwsem.h:7,
                 from include/linux/fs.h:33,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/scsi/scsi_ioctl.c:9:
drivers/scsi/scsi_ioctl.c: In function 'sg_scsi_ioctl':
arch/x86/include/asm/uaccess.h:46:9: error: cast specifies array type
   46 |         (__force __typeof__(ptr))__ptrval;                         =
     \
      |         ^
arch/x86/include/asm/uaccess.h:107:38: note: in definition of macro '__type=
fits'
  107 |         __builtin_choose_expr(sizeof(x)<=3Dsizeof(type),(unsigned t=
ype)0,not)
      |                                      ^
arch/x86/include/asm/uaccess.h:130:18: note: in expansion of macro '__intty=
pe'
  130 |         register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);       =
     \
      |                  ^~~~~~~~~
arch/x86/include/asm/uaccess.h:162:9: note: in expansion of macro 'do_get_u=
ser_call'
  162 |         do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr))=
;    \
      |         ^~~~~~~~~~~~~~~~
arch/x86/include/asm/uaccess.h:162:37: note: in expansion of macro 'untagge=
d_ptr'
  162 |         do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr))=
;    \
      |                                     ^~~~~~~~~~~~
drivers/scsi/scsi_ioctl.c:522:13: note: in expansion of macro 'get_user'
  522 |         if (get_user(opcode, sic->data))
      |             ^~~~~~~~

Caused by commit

  ce66a02538f3 ("x86/mm: Fix sparse warnings in untagged_ptr()")

(the scsi code above has not changed since at least February ...)

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.jJexiWS6+SUx0U7XEJLdyF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX2AcACgkQAVBC80lX
0Gyglwf9HEPXL5503VmH+Ll1M8xSbCzgSDqmIkqsNKFbqPKTKwIM5Lh6g5cepESq
qlcs9ly8RibB9vuH+I+2GMJvS2HTUaNXKgfrOVvDx/SrfUeK6XRFrHj1prEpLP/6
XXtrXTRY+AlnAJiLL6NI9MqNtnCM52zlCmZhTlf2/S7kpemFlzLJi3MqSl5btCD1
1a/edWOgy0fhwmh1SCqO0OZiOtP3XoivJJ6Mlyeayr3/6EzxERgh88vD6OsKMorR
xmivxSfZIE0I/8LGZwpQlkkpMp7gry3lRHOP9ahE/sNsZx3tRqdpOV5Qd85I0j7s
vI1cd+WY/+d60cVoy/eWiPyl3ciUdA==
=QbK1
-----END PGP SIGNATURE-----

--Sig_/.jJexiWS6+SUx0U7XEJLdyF--
