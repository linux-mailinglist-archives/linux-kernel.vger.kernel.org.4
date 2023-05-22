Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9D70B60C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjEVHNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjEVHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:12:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B41BE7;
        Mon, 22 May 2023 00:11:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPpXg2JFKz4x2j;
        Mon, 22 May 2023 17:11:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684739507;
        bh=ukpPl//tNxkdjEz3WHVkRqbSBt2C7kAuFA7BLrTdxRY=;
        h=Date:From:To:Cc:Subject:From;
        b=FTz9UjHILki7wEjIBUYjhJ5WDFQH8Sbn4awZ/fDJzD7pJnXPMA2J6B+/xLyu0+8db
         uPjtLCTE8kKQYgxlSHeUQbL5SDYJTcBttE4BbytUupvfaZrrDOQk4vp1SSrqstO8Iw
         7sJp6uCmkyFKZS4xWYcjQFZPPUWy3TiOmHv/EQzMoOwyoE71RPTXCRYDG0LcZHkpP7
         efsiua7X7bVt/2q5pK+35XqLvTF4TxHr2LWH6PW4V3OeahIRiIp9043Mytmc0Eacvj
         0+S0UcwF5ZKRPjo3C9BSbbAk2LWDKeogvqfbLXL7FMThEu5NJu9dKE3TJ8NfW6QeXW
         oyxMTCtpV+gsQ==
Date:   Mon, 22 May 2023 17:11:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20230522171145.38a8bd4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rCQj+7ssbC332JIAde/oHu8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rCQj+7ssbC332JIAde/oHu8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig clang-17) failed like this:

(in function gfxhub_v1_2_xcp_resume)
drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:657:6: error: variable 'ret' is us=
ed uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-unin=
itialized]

Caused by commit

  c554a01e1c08 ("drm/amdgpu: Add GFXHUB v1.2 XCP funcs")

Reported by the kernelci.org bot.

--=20
Cheers,
Stephen Rothwell

--Sig_/rCQj+7ssbC332JIAde/oHu8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRrFbEACgkQAVBC80lX
0Gw0CQf+O/MdEEqop/SsltXAufvhvcErsoyFdd2QCwXtz3qHyvjAwYZ+Lf7b4+h4
nTzOobW6d6ACjDTOBO/kCAD9NR3110Bp6qJe2zFyu5AicX9PBWJZbOQa1GmAkv3i
ABLFm8ZlqVkT/8WIeiT8cy4oxG2sGfYgIbH+O6eTseSyPGuGR0GqYApr/OG7kDFj
xrFM49GQpO01VoXYbM7xwmIz86IjyPRsmUku9tIItzQz3e8Rf8VwW2CTSgzflCgR
PmndeGfpAMBBpjHGAdtURJEZFhSOGCVaWviKi8EhiZOeBRX61nwmeRIg1rmOMQZQ
8b4FamtYmmA9Y0g1DzFjn3O01AIf0w==
=JyDx
-----END PGP SIGNATURE-----

--Sig_/rCQj+7ssbC332JIAde/oHu8--
