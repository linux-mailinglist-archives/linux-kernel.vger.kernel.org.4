Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333F747A81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGDXrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:47:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701A184;
        Tue,  4 Jul 2023 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688514421;
        bh=m9X7PjJoGtGOIM1Fq88qaw0yVr5cSNkExDGHaJjEn84=;
        h=Date:From:To:Cc:Subject:From;
        b=g1CYmj0dkPxly36wnstPHcPrlh95/7CsERovwNagESjSzb2wqoktD/v2k1/6efYbC
         hJer7puBtJjBX3yOs/sCsHWQdArhvtK8h0ECAW0gxonKQpWjm0dsr3hNETbIC4cXR7
         kSc+y3InxB0Zl0tGc4wpz8wkL7c7QON+w8kt75zylD2wKUNznXmuhVXT98/wsrrOW4
         Flh5v1ATEQu2zxR/XOFBJ0x944HrXTdJetG7OnAoGsYw2b5WZp+0l/c8lb5brxm8Vk
         XMpJxkit9/M/pe8VqVfF1DmZRh2KirauHmti8JRaN5hFkvUpF02v+/WvaBpSsUn3cq
         l/WuNHC9GW3Jg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qwfb81bK8z4wxp;
        Wed,  5 Jul 2023 09:47:00 +1000 (AEST)
Date:   Wed, 5 Jul 2023 09:46:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230705094406.0240c3b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z.i2rJ8/r1G0yke.OZgGA8S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z.i2rJ8/r1G0yke.OZgGA8S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/Kconfig

between commit:

  b97aec082b51 ("riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")

from Linus' tree and commit:

  ab7fa6b05ebb ("riscv: move options to keep entries sorted")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/Kconfig
index 6c12512d8278,c8c22cf11602..000000000000
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -105,6 -105,11 +105,12 @@@ config RISC
  	select HAVE_CONTEXT_TRACKING_USER
  	select HAVE_DEBUG_KMEMLEAK
  	select HAVE_DMA_CONTIGUOUS if MMU
+ 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNA=
MIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+ 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+ 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
++	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
+ 	select HAVE_FUNCTION_GRAPH_TRACER
+ 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
  	select HAVE_EBPF_JIT if MMU
  	select HAVE_FUNCTION_ARG_ACCESS_API
  	select HAVE_FUNCTION_ERROR_INJECTION

--Sig_/Z.i2rJ8/r1G0yke.OZgGA8S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSkr00ACgkQAVBC80lX
0Gzz3wgAnYVANI/D6rlcbxNdlBIMWGoeu2gSEGRkT3Q0cr1l0r4sNjMslkhY8WiO
bzJ4Zew1iNXctgsrH4MJ3L9u5qfqd26op3JXgAobJNJ7Fmj3yHep+pDo1yGHPUqH
5jMOkk8CMKquGssBV4buR0+IwOVn7s0NbjbQQG15Amlwq+Gg9ozTgFtxD1JPthoQ
YMhxa37CoRz//UJ+61DvxqxGqm1gVHwrqpKV1X91AceqEkOzuLm4HWfRNKC60kq/
dAs8DUc1uOM92Q58bJ8vNdCGD27jlS9youNuu5+c7HL3rYpNkqcZYzyXh6ZhWyNG
n2K46nP72AnIohZgW1AU6uf+f6iKTg==
=+dxN
-----END PGP SIGNATURE-----

--Sig_/Z.i2rJ8/r1G0yke.OZgGA8S--
