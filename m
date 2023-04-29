Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04126F2573
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjD2RYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD2RYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70019A3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391AB61253
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 17:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD71C433D2;
        Sat, 29 Apr 2023 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682789080;
        bh=sq6usrIlQ/28LQDt+r0twkGl5RyrXFGOWOiorZPC7k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqLQ+5ECtDNIbOffcTdLxO2hn87/xtKq7hEpcucl2BmkeWJIrde0onY3If9Vb4Lsv
         eEJaEr5jXHxr4sw1e3V3HI5PhSqxf8ODwQSADc8eeILAeLxD4tluZwAUAY4SpfYGBx
         xaU5JgW9xVHgGnZvHmDHV4mDSCTZat8ba/bo0ParGMu1fvvsug9vZVmuVshME1IDBv
         hE1smY0M/85a3miNYbXMzhoVCI7MQ+FbpGTM+U7kgx8N7YOdaLUsTsEaerg93jzxa3
         RGUOFnzqYcL+rhmCVK4CjFhcr7t97m55uWjB5AIWpSwACxvTezRWzOyoRNQJ0gcGQk
         Wkwu4ow7NZOwA==
Date:   Sat, 29 Apr 2023 18:24:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in
 errata
Message-ID: <20230429-outboard-hypocrite-983e977103d2@spud>
References: <20230429155247.12131-1-rdunlap@infradead.org>
 <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0dbtxqGgkaAbUFx"
Content-Disposition: inline
In-Reply-To: <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0dbtxqGgkaAbUFx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
> On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@infradead.o=
rg> wrote:
> >
> > When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
> > CONFIG_MODULES is not set, __init_or_module becomes __init.
> > In the latter case, it causes section mismatch warnings:
> >
> > WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_=
cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.t=
ext)
> > WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_=
cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.te=
xt)
> >
> > Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_fe=
atures()")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: Conor Dooley <conor@kernel.org>
> > Cc: Evan Green <evan@rivosinc.com>
> > ---
>=20
> Thanks, Randy. I'm confused at how I didn't see that when I made the
> original fix. I feel like repro of these section mismatch errors
> depend on some other factor I'm not understanding. In any case:

Perhaps you had a cut-down config that did not enable either of the
relevant ARCH_ options to get those errata compiled?

Thanks for changing the fixes tag Randy,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--y0dbtxqGgkaAbUFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE1S1AAKCRB4tDGHoIJi
0gygAP49xJB5js4hmJBkRf6uchyUWmMJgValg/hKIRsFfeVQLgD/b15lZi/lR3Od
Bau17tKRXdMw89zA5WCPAgb83tghyQY=
=6g9o
-----END PGP SIGNATURE-----

--y0dbtxqGgkaAbUFx--
