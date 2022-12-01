Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5D63E82C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLADIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLADIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:08:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39822EF4F;
        Wed, 30 Nov 2022 19:08:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NN1Gl2M3yz4x1V;
        Thu,  1 Dec 2022 14:07:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669864079;
        bh=TfGmS1zCmudsr4uYautLm5Znw0ne7ebMP1HiuHsM1sI=;
        h=Date:From:To:Cc:Subject:From;
        b=oJVfaAprK6gXnjydn6DsCFq1BnWQaL5OLLKgDK+aI0x8vAI6vgXetXnwyhhWNdmq+
         7fCOB6F5e+WK9kpSjjZneajXSTqlBrwVRUnjgp9+EZccWujUoSrGCBRjHMfr9qIMSs
         gS4jBBD1Udqv6DFWVLAL03pQ6so/L8Tdze23kt2qebadfA+pofSpCDMtCHNvQCBkSP
         8lcFpEI7asvnZzjpKKu+Bqcq2Ik9apaJ0vL5jbPHxSWOE10x7s+IFCAQEvvi4+ZdRV
         80Rm78pBAWYd2Ym8JOl6eHOMluATttHtii3UoJSwpxD0FEYsb0YR6ALqQi+v1hqHrZ
         aHt7wr84iC7rQ==
Date:   Thu, 1 Dec 2022 14:07:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20221201140758.1d3e9aec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HlZ8cRjPobylttKtqm9R9rM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HlZ8cRjPobylttKtqm9R9rM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

kernel/panic.c: In function 'check_panic_on_warn':
kernel/panic.c:238:25: error: format '%s' expects argument of type 'char *'=
, but argument 2 has type 'unsigned int' [-Werror=3Dformat=3D]
  238 |                 panic("%s: system warned too often (kernel.warn_lim=
it is %d)",
      |                        ~^
      |                         |
      |                         char *
      |                        %d
  239 |                       warn_limit);
      |                       ~~~~~~~~~~
      |                       |
      |                       unsigned int
kernel/panic.c:238:75: error: format '%d' expects a matching 'int' argument=
 [-Werror=3Dformat=3D]
  238 |                 panic("%s: system warned too often (kernel.warn_lim=
it is %d)",
      |                                                                    =
      ~^
      |                                                                    =
       |
      |                                                                    =
       int

Caused by commit

  480e0e1d4817 ("panic: Introduce warn_limit")

I have used the kspp tree from next-20221130 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HlZ8cRjPobylttKtqm9R9rM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOIGo4ACgkQAVBC80lX
0GxflAf9E7Q1cEGIFiJwsrqgE3+0ppAkiVA5xXcTYwcz4t0tB5ZGpFhpXm/CJssl
Kc/V2Wa3+cFd3FmICAnYg94LQrKb6ciMKzXbXvnp4viEeD+v15jC4xcRAq3Iob3a
K1G/njB+II9CMhv4nxnfjLMH/yVTAvWykprcjmkLYSPn/IcnIrnxPGoeSuYdFa8t
u7T7r9NIuQptQ8tgzg9Exfs7Qvg6KISr4I9QyO3we0uQ9UEEDZaCLyS377BeC6tS
hJnyPj7BCLZXDoHbCv54eX6At3QiGGM7OKl+TMVRAJxPs/uvTFYzsndmkMscWe8Y
HhOyx3Ym/P8p6crt9jQQ34I9jvcXRg==
=B3L/
-----END PGP SIGNATURE-----

--Sig_/HlZ8cRjPobylttKtqm9R9rM--
