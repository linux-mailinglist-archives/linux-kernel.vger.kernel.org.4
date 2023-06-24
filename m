Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8C73C510
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFXAMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFXAMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7C273D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 17:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F0A61B4E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68425C433C8;
        Sat, 24 Jun 2023 00:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687565550;
        bh=7xPBiOV590KyrvCfPrfg3HGfvOAZZIKRMPcI3/sL3KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQgayS+dAenzmv9UpmDOE40oRy2E5d3izLewRqlcANE4CiboFjJk4xu/aRnjARl8H
         Zz+8n7xtKZTAUJAC9FN0Li1j69dnaILz1qVQjHOeHMl6iAAEOVkpyIG1mNLsmhQjSz
         Ac8VbW9MltakkSL6y+n8vPKuNO/FUmvlUHLIscV5OXvAf6hJmzi/aV2nNLYPbBG4dk
         y5oJtSGrW6TEWpkFiHmEY5DuRY2LR2sM7XuD6ZzSM+LFiMra72DLlvHSO8OLg0vsSl
         8JnJ54XhWlVRD6Z91vucVKZSjfpgkNLuDIsFwtF5lXtadcWV8TAjETmP0WkPbIupLJ
         RA+6jUEAF5EUw==
Date:   Sat, 24 Jun 2023 01:12:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230624-mortally-parking-68f6bc1dd5ee@spud>
References: <20230623222353.3742384-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gxx+ADrwk7P5WV3t"
Content-Disposition: inline
In-Reply-To: <20230623222353.3742384-1-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gxx+ADrwk7P5WV3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Fri, Jun 23, 2023 at 03:23:53PM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
>=20
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo.

No, you can't do this as it breaks the assumptions of userspace that
this shows the set supported across all harts.
Sorry, but NAK.

Cheers,
Conor.

--Gxx+ADrwk7P5WV3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJY06gAKCRB4tDGHoIJi
0jKQAQD+d6MrxtGHBk7NIHGkyEg81xZjoOJGzYQbnAsNIs4PewD/SbbVzF51iu9y
/tV+pkvbs4VzLZw9XIcyPwfvVIda+Ao=
=fdGx
-----END PGP SIGNATURE-----

--Gxx+ADrwk7P5WV3t--
