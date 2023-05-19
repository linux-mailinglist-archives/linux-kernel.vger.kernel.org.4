Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B59708D26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjESBAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjESA77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:59:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650D12F;
        Thu, 18 May 2023 17:59:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMpQx2Z9mz4x4h;
        Fri, 19 May 2023 10:59:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684457993;
        bh=5jd6OQJA3UL81BYlu8INMp2iVqI24+QV0xKrMxNe3w0=;
        h=Date:From:To:Cc:Subject:From;
        b=pGp/DOJnIwE+/ui6gCl6+P/FSap5FUsQGud6LcdC3wged41a/n/udXluLdpd4nlkX
         lz2rMLi1h7P4FUERqKUqHpCcHUk5X3Lc1eqKzNLva9azOS/Q1L8KvXHs/0xbxvXCV5
         v/UZYhqin9vjvmmR4jb3rLNLdrnFdj6EYH1P3AZUFeJOvl5+aRecUQ9dpZLCMP9xxt
         HDcrLT6KZtCtEhg577zsfl/FL3CyypfobVVPj9sJodQSAUS6h2cqlWEKDeBy/w5KEz
         TwmHu1fJ35nx+SYhXHc2MiQu7MgLuGFU4GLZ91ZXJPJvwc/Y81cr1jBefq4rMcgPhb
         7qHbWUxcvH0JQ==
Date:   Fri, 19 May 2023 10:59:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20230519105950.2d021e86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//+IWoI7XihBr7rQCEU1qiIt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//+IWoI7XihBr7rQCEU1qiIt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' undec=
lared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_kthre=
ad'?
  340 |         .rso_gp_kthread =3D get_rcu_tasks_trace_gp_kthread,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                           show_rcu_tasks_trace_gp_kthread

Caused by commit

  9bb839a83e1b ("rcuscale: Measure grace-period kthread CPU time")

CONFIG_RCU_SCALE_TEST=3Dm

I have used the rcu tree from next-20230518 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//+IWoI7XihBr7rQCEU1qiIt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRmygYACgkQAVBC80lX
0GyBMQf/Q8infq4iWhub0xGvYdfxutu9rQ8+hS3E6Qx8uMgWSAvaih88i7/61FXT
keIohTQqX9JCeu8EuBcOztukd26G88veH8SMpZWY5W+G1h+U4zxELnRIhthdGKJ0
Xx1tw2qbRvni3pKa1OMpVlolUqs37szAKfeYZOGqpz4lUY7+pFY1IwDqTEgToZeE
Dt+py4kYo8Hgx/jCmQdipK7Ab8mglwEG+UWbYBOtPFLFeoZsHXI550wL8K9/6d45
mAAGIiQTabXjt4YLqlm3yoQH0haZbZlvsQt+WSEV6e5/QO6CQPwBLHmYcdMa7mKS
VKETUu0eO7FuX/TuMaeEsyIo64qiOA==
=3aRg
-----END PGP SIGNATURE-----

--Sig_//+IWoI7XihBr7rQCEU1qiIt--
