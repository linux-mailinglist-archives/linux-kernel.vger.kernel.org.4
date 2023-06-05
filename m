Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006172240B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjFEK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFEK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90C114
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FD661565
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6ECC433D2;
        Mon,  5 Jun 2023 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685962742;
        bh=/3rPkZp3G1q/+mjzIUib+Reuac1X1iM8z3BUwaVACOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bACOM4T6bynYlwQjyKJfA7DrAAGoqodaVx0JjEulxIC4fTppuGQDDHpP2qxxFgkYE
         UcrTKd+WdOJW9HP0U9IYArIfEVsNa5JGrPoqw3vQemFx59ZQSeqqU6JY0YBOQD38UX
         heFNreryzj/+BFcYyDLh+3RN5mv2TXUefJNpO6A2fIAHjFmXvfW3mveoHBLTBHeKLy
         3RL4FAnu3A8wIodctBG0shWCcUgbNws+NiJyB5fnWgwaaZO+zaZWLkEnviiIS78Hsz
         vj87ZwJyZvob3NcwdUdcTmfBTpRhxhfOfhaEixJVu6IEfiNveNT3K9TCc6P9eBmM7W
         5w3nfs4YqDaKA==
Date:   Mon, 5 Jun 2023 11:58:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     alexghiti <alexghiti@rivosinc.com>, robh <robh@kernel.org>,
        ajones <ajones@ventanamicro.com>, anup <anup@brainfault.org>,
        palmer <palmer@rivosinc.com>,
        "jeeheng.sia" <jeeheng.sia@starfivetech.com>,
        "leyfoon.tan" <leyfoon.tan@starfivetech.com>,
        "mason.huo" <mason.huo@starfivetech.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        "conor.dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug report: kernel paniced while booting
Message-ID: <20230605-catnip-gallery-c20cc203b186@spud>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yPgjLI/9lNvHen1P"
Content-Disposition: inline
In-Reply-To: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yPgjLI/9lNvHen1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 10:52:14AM +0000, Song Shuai wrote:

> This report is not identical to my prior report -- "kernel paniced when s=
ystem hibernates" [1], but both of them=20
> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD=
 pages for the linear mapping").
>=20
> With this commit, hibernation is trapped with "access fault" while access=
ing the PMP-protected regions (mmode_resv0@80000000)=20
> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).

Just to be clear, you enabled NONPORTABLE & hibernation, and then
hibernating panicked for you on a system that uses standard OpenSBI?
This is the existing, known, issue and not something you are trying to
report as a new problem here, right?
(Sorry, I am a bit slow today)

Cheers,
Conor.

> In this report, efi_init handoffs the memory mapping from Boot Services t=
o memblock where reserves mmode_resv0@80000000,=20
> so there is no "access fault" but "page fault".
>=20
> And reverting commit 3335068f8721 indeed fixed this panic.

--yPgjLI/9lNvHen1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH2/8QAKCRB4tDGHoIJi
0vDbAQD1SNCYKfmAuNUKkbuOXpKZPH7MLowsCtzhmC+1cmbjcwEAqiIJ7LGGwTxa
G0Okg74x/RSarXC1mk7lvGDZjWQeDAw=
=Ypye
-----END PGP SIGNATURE-----

--yPgjLI/9lNvHen1P--
