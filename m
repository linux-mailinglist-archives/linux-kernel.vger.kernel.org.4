Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4A712A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjEZQYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEZQYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014FBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E330160FA7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC0C433EF;
        Fri, 26 May 2023 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685118281;
        bh=AJ+BxxK52gVymsZFoUp0CRgLx8gr8FZ2nrPsRRsuDBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNPY2tCWSOOazWLhjnQD0SMygLanbck+s66Z9oBgfYBb2HWMbjZVYZqcSWa3Yz6bx
         brohvBunWS8D/c9QAcmHy+8rIw1Hjx6gJ+YXWfsNIzZsZlnUJz/S47GxfXEER8ia96
         65K1DbWeSL3baiTJDULkSA4uE/qsQP6MDNNfawRCNV171nRdqPVzSdoUa4lP0y2zQB
         tuv6s4K2hg/rctGZf1lX/aHfqIFsH5MpraX+Q6iTUIUo6WBi7y9DGVmauDRk8yjh4i
         hfrPB2e7/ColiAl4SySkXBiMuwOPasb1/5qgJ6IbipXZ61C+bbIFHIlU+eot/HYaOX
         VxMb7c3Ld032A==
Date:   Fri, 26 May 2023 17:24:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230526-clergyman-wriggly-accc659a3fad@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NlMLFogaEAENvQ8Y"
Content-Disposition: inline
In-Reply-To: <20230526154630.289374-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NlMLFogaEAENvQ8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
> Early alternatives are called with the mmu disabled, and then should not
> access any global symbols through the GOT since it requires relocations,
> relocations that we do before but *virtually*. So only use medany code
> model for this early code.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>=20
> Note that I'm not very happy with this fix, I think we need to put more
> effort into "harmonizing" this very early code (ie before the mmu is
> enabled) as it is spread between different locations and compiled
> differently.

Totally & I'll happily spend the time trying to review that work.

> I'll work on that later, but for now, this fix does what is
> needed to work (from my testing at least). Any Tested-by on the Unmatched
> and T-head boards is welcome!

On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to my
config, my Nezha fails to boot. There is no output whatsoever from the
kernel. Turning off CONFIG_RELOCATABLE boots again.

I didn't test on my unmatched.

Thanks,
Conor.

--NlMLFogaEAENvQ8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHDdRQAKCRB4tDGHoIJi
0rRcAQDJerk30eDdIobCPL6gLNU9EYo1FLQnN2rS7TRV5QYwOAD8CHZqfwZranmk
N+rYrgoF8D/+0QK4z99Lgy5drkF1TAQ=
=QYWY
-----END PGP SIGNATURE-----

--NlMLFogaEAENvQ8Y--
