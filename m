Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E5670B652
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjEVHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEVHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:17:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5EE6D;
        Mon, 22 May 2023 00:16:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPpdT5km8z4x4P;
        Mon, 22 May 2023 17:15:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684739758;
        bh=g6oZwveb/eWWicUsrGibOvEr6ozBL3d6+yM4l4vddwA=;
        h=Date:From:To:Cc:Subject:From;
        b=ofOCdxzYTSfh52agI6o7NKoiVPExRNVakUMiJI17xtjb71V6QcpMVzPAB5fqRVPu/
         DMX8JwH2BcxAaOdzljKuUYIirab21fu+b1jfUyohEN9kmdjkFoDXS/eZ1ct30QNHoK
         YyQN/CLUu/ZBZIJYqMdVcnguEKULDhh6BNizWvfd67raUiyIO1Yz5M/8vGaSnVWuNs
         lR2tjG6rFNRNshsKIiq7V8TrV7vyIynzbCXKmmjUZM3GJhNMm4HSTd0CFPybwMoWpL
         5uPhx6VwhzqCXJ29OYXIdvb2mijRMvydKBWgl+gHah87KZyKhlUqTNXn9I8QKu11qn
         2YFclXdKVAadQ==
Date:   Mon, 22 May 2023 17:15:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20230522171557.32027acf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IQsQKgXv4mgj69bolCvWdu+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IQsQKgXv4mgj69bolCvWdu+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (arm allmodconfig
clang-17) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:146:54: error: format specifies ty=
pe 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsign=
ed int') [-Werror,-Wformat]

Caused by commit

  d020a29b6b58 ("drm/amdgpu: Allocate GART table in RAM for AMD APU")

Reported by the kernelci.org bot.

--=20
Cheers,
Stephen Rothwell

--Sig_/IQsQKgXv4mgj69bolCvWdu+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRrFq0ACgkQAVBC80lX
0Gx3ygf/T/GUfYOn91KThC3xxNxJBFbrCEIsxujkuU+r20qi8EITDpAldBk0hAKV
QpZOGbUZ3V8Li+IFlZcJottR79iSjZohICGLQyGYtn5uq6nKoJdK/Sg/GN90wyQs
1YJhxbJUJ9EXjbuTFWeOmu6j0r42QBkEUM41zy6VZWY6tEf6kvlLAQB9kMxTFDHS
CrrGYmSvkooJYtuQl67RzQ6Y2Ajf2tQhVEJ1p0UAsXWXKv5WfIt0vlTx+yKNiK0g
t96q0OexDZD/S4py25dXTtHYN8NfRoBGBTBoNoE2rVWsPSc2NkLqjjQvmHkLE9bx
8h9X0USUdfMU5csVTLrVnbzYpKKInA==
=HLh9
-----END PGP SIGNATURE-----

--Sig_/IQsQKgXv4mgj69bolCvWdu+--
