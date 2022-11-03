Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE56175ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKCFCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:02:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41F17E19;
        Wed,  2 Nov 2022 22:02:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2s7s73hpz4xP9;
        Thu,  3 Nov 2022 16:02:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667451754;
        bh=4nXm8pToYpeprRog17hXDoSXdnxRKLaqs4WSe3awimk=;
        h=Date:From:To:Cc:Subject:From;
        b=jlVtOXA07K4NYdEVmWPaTBQwzEOCGSOgAsng0GJCgVXKdR6S21j0g9lcHoTP1Ss+W
         OCn9U019ten+j3ERpXDDTHsq1qPwMsByQGh2steluV3Xl+F2s94smnxX8IngqCrJee
         h6+9CwLVoVzI0mLrPBGp/BhmqDaB6M2+sRfPgZ+1VVQMGyFRYA6ENN39J6GU4fGik7
         MlUHGwjdaA9J89fh4V5tdm2f7p8jnjYEjycvPwrNtzSN97iZE6T78JxGPtpPmNSu4Q
         qdgPB0YcpDWndd725P4fNQyC95l04jK8lprIHKIRTwvUfbOclFh68Hz6S3tcNbsAsv
         PZOyuGWETsrng==
Date:   Thu, 3 Nov 2022 16:02:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     wuqiang <wuqiang.matt@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221103160231.59323e82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qO..xRogeXcDH24Fd=nWXm/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qO..xRogeXcDH24Fd=nWXm/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc defconfig)
failed like this:

lib/objpool.c: In function '__objpool_try_get_slot':
lib/objpool.c:378:17: error: implicit declaration of function 'prefetch' [-=
Werror=3Dimplicit-function-declaration]
  378 |                 prefetch(&ents[id]);
      |                 ^~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  080ae5bb93cd ("kprobes,lib: kretprobe scalability improvement")

I have reverted that commit for today (and its followup fix patch).

--=20
Cheers,
Stephen Rothwell

--Sig_/qO..xRogeXcDH24Fd=nWXm/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNjS2cACgkQAVBC80lX
0GwGCgf/UaXWNOG10r1NLwTuHmHbstxQxJRnlnx3m5NSYJmaQYDhbI69fGYBr5dH
BgFwLyWHZQ/gIriuOzG4wpHsU4ISCB4Xej8hHk578bFkgvYB+d8z9+qacWvifuSX
G0kS94OJMofJuFunHdWVkfVrpWhuwOlR+7WVdQnSCisImx5WyTstjNi+I3UhGHKR
4s4TQgQT5TOlL1ntCseWlX1ycGBdw/ubHh9bmi5cXvfAk433Zos3G9lKf2p5N4aE
UbTdHO8qGCRqI5DdTra2GPek6uawIPG7Lkben9JtyN91qVzUpuEr7Z66+WPN5EZ+
y9YgxnjNesrsI26HbDTUc3cK5ym1mw==
=y9h0
-----END PGP SIGNATURE-----

--Sig_/qO..xRogeXcDH24Fd=nWXm/--
