Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B0073D158
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFYORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472C1B1;
        Sun, 25 Jun 2023 07:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC7160B42;
        Sun, 25 Jun 2023 14:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1899BC433C8;
        Sun, 25 Jun 2023 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687702622;
        bh=I1vcyxhtcISQlL0P8GpCG/D7laU7l1dOUyg/BCWm7Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIXuK+6xoktZaHi1lCvzVPzqpy3FLZCqMNeaAwkfVAzPzpCkEEllpR1r45R1RuHaT
         TuR9ZxQV3ntaoajXWZ5csZsXQ8dFVwKNPbKRWyqDTBbCQPhFuMQMDqM9sw87OOeHr8
         VqTfy3+rejxZGE7qpp7RnPEG86QcnFiMj7qviz+jm+DTbheRP/q5yjyhQgyssB0qY4
         UuS2SjtdbHolck0il8DtZCLHpKRYstNVWeE8BCAQRcL92XcW2NH4e3L2ZjVqzy4CVB
         wv3yrX6R1YtvGvf/GK8f0/o+VXcfPKZiVZZoQRo5k85S8ZEwpffCSlvSEg0tI26MLS
         wVCEdQAzLYJtg==
Date:   Sun, 25 Jun 2023 15:16:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V1 0/3] Revert huge-paged linear mapping and its related
 fixups
Message-ID: <20230625-squire-hulk-d28483ab5ef7@spud>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z0/mXjtX89gmKaoG"
Content-Disposition: inline
In-Reply-To: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z0/mXjtX89gmKaoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 10:09:28PM +0800, Song Shuai wrote:
> We have encountered these two issues about huge-paged linear mapping sinc=
e v6.4-rc1:=20
>=20
> 1. Bug report: kernel paniced when system hibernates[1]
>  =20
> OpenSbi [v0.8,v1.3) set the PMP regions as !no-map, and the commit 333506=
8f8721=20
> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") mapped them in li=
near mapping.
> The hibernation process attempted to save/restore these mapped regions re=
sulting in access fault.
>=20
> This issue was temporarily fixed by commit ed309ce52218 ("RISC-V: mark hi=
bernation as nonportable").
> But as Alex's RFC and Rob's response stats in another thread [2] ,=20
> "Hibernation is only one case. Speculative accesses could also occur."
> So this fixing commit seems not the perfect answer to this issue.

This is a misunderstanding, I was not attempting to fix the issue, but
rather buy time to fix the problem properly, without regressing support
for hibernation when we do.

Cheers,
Conor.


--Z0/mXjtX89gmKaoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJhMVwAKCRB4tDGHoIJi
0uGBAQC/QRJPIKKal1mDLC95zDLv81ngF6w3fK8jXGP+B9V4pQD9GCV8MCsnF1th
HIFQcwNPiG7Zw5sBVtBjgefc18iGcwI=
=cAQy
-----END PGP SIGNATURE-----

--Z0/mXjtX89gmKaoG--
