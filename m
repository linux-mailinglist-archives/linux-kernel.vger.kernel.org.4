Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788EA70B59C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEVHAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:00:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928BB7;
        Mon, 22 May 2023 00:00:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPpHj3vmZz4wj7;
        Mon, 22 May 2023 17:00:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684738833;
        bh=XCEI4EHe4xndWFjXPVpIBJmkwGAsAla9eXMvA1NSncs=;
        h=Date:From:To:Cc:Subject:From;
        b=mnsjkIHlbH+Ot2NYZ6bXhrLmet42PmM89jV+ALS9MCPE3WDMim6++/ttctmUURuFK
         toyWj9/dWVxyCteIbsg2jJ7dU/BdsdaTdQr2P3DRauKmwTWRbclqctyt+TxJ8sH4rd
         +K6zbP0tnPWREJCTJ4y9MgOWT//pFSfEGUI86z0W6RzNfF2PqFZQjmgbaoU8YBY3MO
         lnSy30QgsGmOY+vICc1Qt8awXE8ofYuBULMpA1JdL2tr6HkGmcsxcGcWafC1+iDlAc
         RGXDlBelCmuCO+sYsjD84DkTuOi8XD+GZB7DIgupDxmayViG3M4s7qXeneWPbe8hrS
         iR4FzlF2WwbHg==
Date:   Mon, 22 May 2023 17:00:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20230522170031.5fb87a64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LY98FJ3DZy9ZBORsCQ41V_k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LY98FJ3DZy9ZBORsCQ41V_k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig clang-17) failed like this:

drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'mmhub_v1_8=
_mmea_err_status_reg' is not needed and will not be emitted [-Werror,-Wunne=
eded-internal-declaration]

Caused by commit

  fa90ca94dbda ("drm/amdgpu: Add query_ras_error_status for mmhub v1_8")

It is only used as "ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg)".

Reported by the kernerci.org bot.
--=20
Cheers,
Stephen Rothwell

--Sig_/LY98FJ3DZy9ZBORsCQ41V_k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRrExAACgkQAVBC80lX
0Gzb9Af/ULQdaFsGrNBtEGI3Mt+lUGu63BS8D6r/ZHHhhn2DUif1bcewyDisL/nP
5/54dL4KAeqqe3fBdlp682O6nGl2k6VtGq6yLLSVRe9HCbqu3IKlvZGCmdRdgYGm
bkiyuZ7fGaTJUOQ+IN+ZZkVLFWFBVUWCd+UtgIjTzUn2P71qXmEiDeUEAy6Yja4u
VdHhwlmEQqbsPJBIZL/i+GuQfyqFf3FHssPTHydJzuKPp8gCNwbtcRPAzApIOcAf
NCZy4OuCHFFcP3JkFKbwrBteJZB2RPPFF6KJ8pPeu8OdKfo2yULiacIxcHnTIwK5
GdTgBgfS6TAP5mNWEDOqjZuaCKfIEQ==
=Lf6Z
-----END PGP SIGNATURE-----

--Sig_/LY98FJ3DZy9ZBORsCQ41V_k--
