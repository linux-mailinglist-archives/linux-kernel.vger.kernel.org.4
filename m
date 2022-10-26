Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC560EAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiJZVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJZVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:53:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445BE95AD4;
        Wed, 26 Oct 2022 14:53:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MyMyJ2PX1z4x1G;
        Thu, 27 Oct 2022 08:53:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666821224;
        bh=uv97AMPsc6IV7qTqkmaF+rTZKz0591gTDPT7qnof5Z0=;
        h=Date:From:To:Cc:Subject:From;
        b=Kt9Et3iev+6kzlFewJvzmbutbKadYpAiUPPltWNqsGOyni3vhUanKS8U2YTPYaxEO
         fcuOEU8jSK4AYxhEvrQGD0XBMlJ91zIW7p69wnzi81075zmMQcQrnVYF4TtbNr6KkY
         IAMSL0cpB41XBHxRSL1CHnLiVvy0ghF57IndBUZZOI6ymP8BLDGUlJP6YA04bjkUN1
         Y46G5f0khn2lB1xVLDEyiAVW1+YFckkG9e/TMwxESYqdUA4wTtxGgcpKHKGrkSEWOh
         j3l/OILk0U5jLIQUlFCbdG1HCX5+g/dLQi4EHiCLisFF9nwigy/Hx3V9BDqzJdp3IS
         gpxvHxPGOck8Q==
Date:   Thu, 27 Oct 2022 08:53:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Zhao Liu <zhao1.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hyperv-fixes tree
Message-ID: <20221027085220.32076be7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eES6Rp7.geZxe_+S96qRldh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eES6Rp7.geZxe_+S96qRldh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hyperv-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/hyperv/hv_init.c: In function 'hyperv_init':
arch/x86/hyperv/hv_init.c:447:29: error: unused variable 'dst' [-Werror=3Du=
nused-variable]
  447 |                 void *src, *dst;
      |                             ^~~
cc1: all warnings being treated as errors

Caused by commit

  f8162cff19f1 ("x86/hyperv: Remove BUG_ON() for kmap_local_page()")

I have used the hyperv-fixes tree from next-20221026 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eES6Rp7.geZxe_+S96qRldh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNZrFwACgkQAVBC80lX
0GwDBAf+KxgqXhRpbt6y5r760MiU3j7NSwAbMGC+qNV6sf/XaFZ9UqCGbA9C5Aqm
AN9bQJ4NaTzWQzEVwBs1Ctt7WroDq0BoTei6VBmHECclV8QEFTKxpZNAVFGirStD
PIl08w7UICbvAe4QyskpSSAvBMVjc96LmNNzO/i8gumY+q1lcUvtOKgzS5d3yAx+
G2n7KLNVMhzJke5f/dWnJ+ob9XYN3hJRmHi8cU0DOE0+JxcoPKIE9yLtrSVvEZME
71eCturbIL81U5Uf3btIXiPWxcxY04SEG73++5YIeYf/j6+bAfY9W/JlQ4IVGfP7
SIjWrPnp4EPPJDsVDmmh4crQxftXrA==
=Biax
-----END PGP SIGNATURE-----

--Sig_/eES6Rp7.geZxe_+S96qRldh--
